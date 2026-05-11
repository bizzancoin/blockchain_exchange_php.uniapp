<template>
	<view class="">
		<u-navbar back-icon-size="34" :title="$t('fund.selectCurrency')"></u-navbar>
		<view class="px-36 py-30">
			<u-search placeholder="" input-align="center" :show-action="false" v-model="keyword"></u-search>
		</view>
		<view class="mx-36">
			<view class="item" v-for="item in $store.state.coins" :key="Math.random()" :class="{'cannot':!item.status}" @click="jump(item)">
				<view class="d-flex text-white align-items-center">
					<image :src="item.image" style="width: 58rpx; height: 58rpx;"></image>
					<text class="font-size-32 ml-18">{{item.name}}{{item.subName && `(${item.subName})`}}</text>
				</view>
				<text class="type">{{item.type}}</text>
			</view>
		</view>
		
	</view>


</template>

<script>
	// 选择币种
	export default {
		data() {
			return {
				url:'',
				keyword:'',
			};
		},
		onLoad(options) {
			this.url = options.url
		},
		methods:{
			jump(item){
				if(!item.status) return
				uni.setStorageSync('selectCoin',item)
				let url = `/pages/fund/${this.url}`
				uni.navigateTo({
					url
				})
			}
		}

	}
</script>

<style lang="scss" scoped>

.item{
	@extend .d-flex,.align-items-center,.justify-content-between,.py-20;
	border-bottom: 1px solid $uni-color-black;
	&:last-child{
		border-bottom: none;
	}
	
	.type{
		background-color: $uni-color-success;
		border-radius: 22rpx;
		color: #fff;
		padding: 6rpx 18rpx;
		font-size: 20rpx;
	}
	&.cannot{
		view{
			opacity: .3;
		}
		.type{
			background-color: #d6d6d6;
		}
	}
}
</style>
