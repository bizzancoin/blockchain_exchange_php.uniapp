<template>
	<view class="pb-50 text-white">
		<u-navbar :title="i18n.lockming"></u-navbar>
		<view class="deposit mt-30 mx-30">
			<view class="d-flex align-items-center">
				<text class="d-block font-size-28 mr-10">{{i18n.fundsUnderCustody}}</text>
			</view>
			<view class="mt-30">
				<view class="d-flex align-items-baseline">
					<text class="font-size-44 mr-20">{{totalAmount}}</text>
					<text class="font-size-24">USDT</text>
				</view>
			</view>
			<view class="earnings-wrap">
				<view class="earnings d-grid-columns-3">
					<view class="">
						<text class="d-block opacity-50">{{i18n.estimatedTodayIncome}}</text>
						<text class="d-block mt-10">{{day_rate}}%</text>
					</view>
					<view class="">
						<text class="d-block opacity-50">{{i18n.cumulativeIncome}}</text>
						<text class="d-block mt-10">{{total_interest}}</text>
					</view>
					<view class="">
						<text class="d-block opacity-50">{{i18n.ordersInCustody}}</text>
						<text class="d-block mt-10">{{orderCount}}</text>
					</view>
				</view>
			</view>
			<view class="dealer" @click="$utils.jump('/pages/lockming/order')">
				<text class="mr-10">{{i18n.entrustedOrders}}</text>
			</view>
		</view>
		<view class="m-30">
			<view class="p-30 box-shadow border-radius-20 mb-20 bg-black" v-for="item in list">
				<view class="d-flex-between-center">
					<text class="font-size-32 font-weight-bold">{{item.currency_name + i18n.lockedPositionsToEarnCoins}}</text>
					<text class="tag tag-warning font-size-28 px-20" style="border-radius: 10rpx;" @click="jump(item)">{{i18n.lockedPositions}}</text>
				</view>
				<view class="d-grid-columns-3 mt-30">
					<view class="">
						<text class="d-block font-size-28 opacity-50">{{i18n.minimumSingleTransaction}}</text>
						<text class="d-block font-size-28 mt-10 font-weight-bold">{{parseFloat(item.save_min)}}</text>
					</view>
					<view class="">
						<text class="d-block font-size-28 opacity-50">{{i18n.dailyYield}}</text>
						<text class="d-block font-size-28 mt-10 font-weight-bold">
						  <text v-if="item.intro">{{item.intro}}</text>
							<text v-else>{{parseFloat(item.interest_rate)}}%</text>
						</text>
					</view>
					<view class="">
						<text class="d-block font-size-28 opacity-50">{{i18n.lockUpPeriod}}</text>
						<text class="d-block font-size-28 mt-10 font-weight-bold">{{item.day}}({{i18n.day}})</text>
					</view>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				list: [],
				order:[],
				totalAmount:0,//正在托管的资金
				orderCount:0,//托管中的订单,
				day_rate:0,//日收益率
				total_interest:0,//累计收益
			};
		},
		onShow() {
			// 获取锁仓挖矿列表
			this.getLockming()
			// 获取锁仓挖矿的订单
			this.getLockmingOrder()
		},
		methods: {
			getLockming(){
				this.$u.api.lockming.getLockming().then(res=>{
					this.list = res.message
				})
			},
			getLockmingOrder(){
				this.$u.api.lockming.getLockmingOrder(1,9999).then(res=>{
					let list = res.message.order_list || []
					this.totalAmount = list.reduce((total,item)=>{
						return total + Number(item.amount)
					},0)
					this.day_rate = list.reduce((total,item)=>{
						return total + Number(item.day_rate)
					},0)
					this.day_rate = Number(this.day_rate.toFixed(4))
					this.total_interest = list.reduce((total,item)=>{
						return total + Number(item.total_interest)
					},0)
					this.orderCount = list.length
				})
			},
			jump(item){
				uni.setStorageSync('lockming',item)
				uni.navigateTo({
					url:'/pages/lockming/buy'
				})
			}
		},
		computed: {
			i18n() {
				return this.$t("lockming")
			}
		}
	}
</script>

<style lang="scss" scoped>
.dealer {
		position: absolute;
		top: 26rpx;
		right: 0;
		color: #FBE6CC;
		border-radius: 31rpx 0 0 31rpx;
		background-image: linear-gradient(to right, #574625, #6B552D);
		padding: 14rpx 44rpx;
		display: flex;
		align-items: center;
	}
</style>
