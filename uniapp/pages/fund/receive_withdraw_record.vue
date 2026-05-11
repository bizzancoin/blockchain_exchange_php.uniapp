<template>
	<view>
		<u-navbar :title="$t('common.log')"></u-navbar>
		<view class="mx-36">
			<view class="bg-black text-white my-30 p-20 border-radius-20" v-for="item in data" :key="item.id">
				<view class="d-flex justify-content-between align-items-center">
					<view class="d-flex align-items-center">
						<text class="font-size-32">{{item.name}}</text>
					</view>
					<text class="font-size-32" :style="{'color':$utils.getColor(item.type)}">{{item.amount}}</text>
				</view>
				<view class="text-right font-size-22 my-4 opacity-50">
					{{item.name}}
				</view>
				<view class="d-flex justify-content-between opacity-50">
					<text :style="{'color':$utils.getColor(item.type)}">{{item.type == -1 ? $t("home.withdraw") : $t("home.recharge")}}</text>
					<text>{{item.created_at}}</text>
				</view>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				data: [],
				page: 1,
				limit: 99999999,
				canGet: true,
				withdrawList: []
			};
		},
		onShow() {
			this.data = []
			this.getList()
		},
		methods: {
			async getList() {
				const ret1 = await this.$u.api.wallet.getRechargeLog(this.page, this.limit)
				const ret2 = await this.$u.api.wallet.getWithdrawList(this.page, this.limit)
				let arr1 = ret1.message.data.map(item => {
					item.type = 1
					return item
				})
				let arr2 = ret2.message.data.map(item => {
					item.type = -1
					item.created_at = item.create_time
					item.amount = item.number
					return item
				})
				let arr = [...arr1,...arr2]
				this.data = arr.sort((a,b)=>a.created_at - b.created_at)
			},
			// getRechargeLog() {
			// 	const coins = this.$store.state.coins
			// 	if (!this.canGet) return
			// 	this.$u.api.wallet.getRechargeLog(this.page, this.limit).then(res => {
			// 		const data = res.message
			// 		if (data.total == this.data.length) {
			// 			this.canGet = false
			// 		} else {
			// 			let list = data.data.map(item => {
			// 				const obj = coins.find(el => item.currency_id == el.id)
			// 				item.amount = Number(item.amount).toFixed(2)
			// 				item.currency_image = obj.image,
			// 					item.type = 1
			// 				return item
			// 			})

			// 			this.data = this.data.concat(list)
			// 		}
			// 	})
			// },
			// getWithdrawList() {
			// 	const coins = this.$store.state.coins
			// 	if (!this.canGet) return
			// 	this.$u.api.wallet.getWithdrawList(this.page, this.limit).then(res => {
			// 		const data = res.message
			// 		if (data.total == this.data.length) {
			// 			this.canGet = false
			// 		} else {
			// 			let list = data.data.map(item => {
			// 				const obj = coins.find(el => item.currency_id == el.id)
			// 				item.amount = Number(item.amount).toFixed(2)
			// 				item.currency_image = obj.image,
			// 					item.type = 0
			// 				return item
			// 			})

			// 			this.withdrawList = this.withdrawList.concat(list)
			// 		}
			// 	})
			// },
		},
		onReachBottom() {
			//this.getRechargeLog()
		},
		filters: {

		}
	}
</script>

<style lang="scss" scoped>
	.type {
		background-color: rgba(33, 193, 146, .2);
		border-radius: 18rpx;
		color: #028a62;
		font-size: 20rpx;
		height: 36rpx;
		line-height: 36rpx;
		padding: 0 24rpx;
	}
</style>
