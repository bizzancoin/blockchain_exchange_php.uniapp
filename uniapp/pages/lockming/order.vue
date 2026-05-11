<template>
	<view class="pb-50 text-white">
		<u-navbar :title="i18n.lockedPositionList"></u-navbar>
		<view class="m-30">
			<view class="p-30 border-radius-20 box-shadow mb-30 bg-black" v-for="item in list">
				<view class="d-flex-between-center">
					<view class="d-flex align-items-center">
						<text class="tag tag-success" v-if="item.status == 1">{{i18n.inProgress}}</text>
						<text class="tag tag-error" v-else-if="item.status == 2">{{i18n.redeemed}}</text>
						<text class="d-block font-size-32 ml-12">{{item.currency_name + i18n.lockedPositionsToEarnCoins}}</text>
					</view>
					<u-button type="error" @click="redemption(item.id)" class="mr-0" v-if="item.status == 1" size="mini">{{i18n.redemption}}</u-button>
				</view>
				<view class="d-grid-columns-3 mt-30">
					<view class="">
						<text class="d-block font-size-24 opacity-50">{{i18n.numberOfCoinsDeposited}}(USDT)</text>
						<text class="d-block font-size-28 mt-10 font-weight-bold">{{parseFloat(item.amount)}}</text>
					</view>
					<view class="">
						<text class="d-block font-size-24 opacity-50">{{i18n.dailyYield}}</text>
						<text class="d-block font-size-28 mt-10 font-weight-bold">{{parseFloat(item.day_rate)}}%</text>
					</view>
					<view class="">
						<text class="d-block font-size-24 opacity-50">{{i18n.lockUpTime}}</text>
						<text class="d-block font-size-28 mt-10 font-weight-bold">{{item.start_at}}</text>
					</view>
					<view class="mt-20">
						<text class="d-block font-size-24 opacity-50">{{i18n.expiryTime}}</text>
						<text class="d-block font-size-28 mt-10 font-weight-bold">{{item.end_at}}</text>
					</view>
					<view class="mt-20">
						<text class="d-block font-size-24 opacity-50">{{i18n.earlyRedemptionPenalty}}</text>
						<text class="d-block font-size-28 mt-10 font-weight-bold text-error">{{parseFloat(item.cancel_fee.toFixed(2))}}USDT</text>
					</view>
				</view>
			</view>
			<default-page v-if="!list.length"></default-page>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				page:1,
				canGet:true,
				limit:5,
				list:[],
			};
		},
		onShow() {
			this.page = 1
			this.canGet = true
			this.list = []
			this.getLockmingOrder()
		},
		methods:{
			getLockmingOrder(){
				if(!this.canGet) return
				this.$u.api.lockming.getLockmingOrder(this.page,this.limit).then(res=>{
					let list = res.message.order_list || []
					if(list.length){
						this.list = [...this.list,...list]
						this.page++
					}else{
						this.canGet = false
					}
					
				})
			},
			async redemption(id){
				const ret = await this.$utils.showModal(this.$t("common.hint"),this.$t("lockming.c_redemption"))
				if(!ret) return
				this.$u.api.lockming.redemption(id).then(res=>{
					this.$utils.showToast(res.message)
					this.getLockmingOrder()
				})
			}
		},
		computed: {
			i18n() {
				return this.$t("lockming")
			}
		},
		onReachBottom() {
			this.getLockmingOrder()
		}
	}
</script>

<style lang="scss">

</style>
