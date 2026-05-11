<template>
	<view>
		<u-navbar :title="i18n.share"></u-navbar>
		<text class="d-block text-center font-size-50 text-white m-30 py-30">{{i18n.my_qrcode}}</text>
		<view class="m-30 p-30 border-radius-20 bg-black text-white">
			<view class="d-flex  align-items-center">
				<image :src="user.head_portrait   | retImageUrl" class="border-radius-50per border" mode="aspectFill"
					style="width: 120rpx;height:120rpx;"></image>
				<view class="ml-22">
					<text
						class="d-block font-size-36 font-weight-bold">{{user.account_number || $t("common.plsLogin")}}</text>
					<text class="d-block font-size-22 opacity-50 mt-4" v-if="user.id">ID:{{user.id}}</text>
					<text class="d-block font-size-22 opacity-50 mt-4"
						v-if="user.score">{{i18n.score}}:{{Number(user.score)}}</text>
				</view>
			</view>
			<view class="mt-50 mx-auto text-center p-30 bg-333 border-radius-20" style="width: 330px;">
				<uqrcode ref="uqrcode"></uqrcode>
			</view>
		</view>
	</view>
</template>

<script>
	export default {
		data() {
			return {
				user: {}
			};
		},
		onLoad() {
			this.user = this.$store.state.user
		},
		onShow() {
			this.$nextTick(function(){
				this.$refs.uqrcode.make({
						size: 300,
						text: this.$store.state.baseDomain + '/h5/#/pages/common/register?code=' + this.user.extension_code
					})
			})
		},
		computed: {
			i18n() {
				return this.$t("setting")
			}
		}
	}
</script>

<style lang="scss">

</style>
