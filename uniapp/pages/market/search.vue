<template>
	<view class="text-white">
		<view class="status_bar"></view>
		<view class="d-flex px-30 pt-30 align-items-center">
			<navigator open-type="navigateBack" :delta="1"><u-icon name="arrow-leftward" size="38" class="mr-30"></u-icon></navigator>
			<u-search :placeholder="i18n.searchPlaceholder" v-model="keyword" :show-action="false" @change="search"></u-search>
		</view>
		<view class="m-30">
			<navigator open-type="reLaunch"  class="py-20 border-bottom" v-for="item in quotation" :url="`/pages/transaction/index?from=market&currency_name=${item.currency_name}&legal_name=${item.legal_name}&currency_id=${item.currency_id}`">
				<text class="font-size-32">{{item.currency_name}}</text>
			</navigator>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				keyword:'',
				quotation:[],
				origin:[]
			};
		},
		onLoad() {
			let quotation = uni.getStorageSync('quotation') || []
			this.origin = quotation
			this.quotation = quotation
		},
		methods:{
			search(e){
				this.quotation = this.origin.filter(item => {
					if(item.currency_name.indexOf(e) > -1) return item
				})
			}
		},
		computed:{
			i18n(){
				return this.$t("transaction")
			}
		}
	}
</script>

<style lang="scss" scoped>
.hot-search{
	.item{
		display: block;
		font-size: 32rpx;
		padding: 4rpx 20rpx;
		color: rgba(0,0,0,.5);
		border-radius: 6rpx;
		background-color: #f2f2f2;
		margin: 20rpx 20rpx 0 0;
	}
}
</style>
