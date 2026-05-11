<template>
	<view class="login-wrap">
		<image src="../../static/image/icon/login-bg.png" class="login-head-bg" ></image>
		<view class="login-logo">
			<image :src="$store.state.logo" class="d-block" mode="aspectFit" style=""></image>
		</view>
		<view class="login-container text-white">
			<view class="d-flex-between-center">
				<text class="d-block font-size-48 my-8 font-weight-bold linear-gradient-text" style="line-height: 66rpx;">{{i18n.login}}</text>
				<text class="font-size-32 opacity-75" @click="showLanguage=true">{{i18n.selectLang}}</text>
			</view>
			<view>
				<!-- 邮箱/手机/用户名 -->
				<view class="login-input-group">
					<input type="text" v-model="user_string" class="login-input"
						:placeholder="i18n.email" confirm-type="next" @confirm="passwordFocus=true">
				</view>
				<view class="login-input-group">
					<input type="text" v-model="password" :focus="passwordFocus" @blur="passwordFocus=false" class="login-input" :placeholder="i18n.password" :password="true" @confirm="login">
				</view>
				
				<view class="mt-20 d-flex-between-center">
					<view class="d-flex align-items-center ">
						<text class="iconfont text-secondary mr-12" :class="rememberPassword ? 'icon-checkbox-ok' : 'icon-checkbox'" @click="rememberPasswordFunc"></text>
						<text>{{i18n.rememberPassword}}</text>
					</view>
					<!-- <navigator class="text-warning" url="/pages/common/forget">
						{{i18n.forgetPassword}}
					</navigator> -->
				</view>
				
				<view class="login-btn-group">
					<view class="d-flex mt-60 mb-16">
						{{i18n.noaccount + i18n.go}}
						<navigator url="/pages/common/register" class="ml-4 text-warning">{{i18n.register}}</navigator>
					</view>
					<button class="warning-button" @click="login">{{i18n.login}}</button>
				</view>
			</view>
		</view>
		
		<view class="kefu" @click="$utils.jump('/pages/kefu/index')">
			<image src="../../static/image/icon/kefu.png" style="width: 36rpx;height: 41rpx;"></image>
		</view>
		
		<!-- 选择语言的popup -->
		<u-popup v-model="showLanguage" mode="bottom" length="60%" :title="i18n.selectLang">
			<view class="popup-list">
				<view class="popup-list-item" v-for="item in langs" :key="item.value" :class="{active : item.selected}"
					@click="setLang(item)">
					<text>{{item.name}}</text>
				</view>
			</view>
		</u-popup>
	</view>
</template>
<script>
	import {langs} from "./../setting/data.js"
	export default {
		data() {
			return {
				password: uni.getStorageSync('loginPassword') || '',
				user_string: uni.getStorageSync('loginAccount') || '',
				showLanguage:false,
				langs: null,
				passwordFocus: false,
				rememberPassword:uni.getStorageSync('rememberPassword') || false
			};
		},
		onLoad() {
			const _this = this
			uni.setNavigationBarTitle({
				title:_this.$t("common.login")
			})	
		},
		onShow() {
			this.setDefaultLang()
		},
		computed: {
			i18n() {
				return this.$t("common")
			}
		},
		methods: {
			setDefaultLang() {
				let langsData = langs.map(el => {
					el.selected = false
					return el
				})
				const lang = this.$store.state.lang || 'en'
				const has = langsData.findIndex(item => item.value == lang)
				langsData[has].selected = true
				this.langs = langsData
			},
			//设置语言
			setLang(item) {
				let langs = this.langs.map(el => {
					el.selected = false
					if (el.value == item.value) el.selected = true
					return el
				})
				this.langs = langs
				this._i18n.locale = item.value
				this.lang = item
				uni.setStorageSync('lang', item.value)
				this.$store.commit('setLang', item.value)
				
				setTimeout(() => {
					this.showLanguage = false
				}, 200)
			},
			login() {
				this.$u.throttle(async () => {
					const {
						user_string,
						password
					} = this
					if (!user_string) {
						this.$utils.showToast(this.i18n.plsInputUsername)
						return false
					}
					if (!password) {
						this.$utils.showToast(this.i18n.passwordPlaceholder)
						return false
					}
					if(this.$utils.charTest(user_string) || this.$utils.charTest(password) ){
						this.$utils.showToast(this.$t("common.specialChart"))
						return false
					}
					
					try {
						const res = await this.$store.dispatch('login', {
							data: {
								user_string,
								password,
							},
							_this: this
						})
						if (res) {
							//登陆成功，延时1.2s跳转
							this.$utils.showToast(this.i18n.login_success)
							//如果勾选了记住密码，则储存
							if(this.rememberPassword){
								uni.setStorageSync('loginAccount',user_string)
								uni.setStorageSync('loginPassword',password)
							}else{
								uni.removeStorageSync('loginAccount')
								uni.removeStorageSync('loginPassword')
							}
							
							setTimeout(() => {
								uni.reLaunch({
									url: "/pages/index/index"
								})
							}, 1200)
						}
					} catch (e) {
						// 捕获异常
						console.log(e);
					}
				}, 1000)
			},
			rememberPasswordFunc(){
				this.rememberPassword = !this.rememberPassword
				uni.setStorageSync('rememberPassword',this.rememberPassword)
			}
		}
	}
</script>
<style lang="scss" scoped>
	.login-wrap {
		height: 100vh;
		background-color: $uni-color-333;

		.login-container {
			position: fixed;
			left: 0;
			right: 0;
			bottom: 0;
			padding: 50rpx;
			padding-bottom: 80rpx;
			background-color: $uni-color-black;
			border-radius: 50rpx 50rpx 0 0;
		}
	}
	
	// 弹出层列表
	.popup-list {
		.popup-list-item {
			height: 96rpx;
			line-height: 96rpx;
			padding: 0 30rpx;
			@extend .font-size-32;
			position: relative;
			display: flex;
			align-items: center;
	
			&:before {
				content: "";
				position: absolute;
				left: 30rpx;
				right: 30rpx;
				bottom: 0;
				height: 2rpx;
				background-color: #efefef;
			}
	
			&.active {
				background-color: #f2f6ff;
	
				&:after {
					content: "";
					width: 36rpx;
					height: 20rpx;
					background-image: url('./../../static/image/icon/select.png');
					background-size: cover;
					position: absolute;
					right: 80rpx;
					top: 50%;
					margin-top: -10rpx;
				}
			}
		}
	}
</style>
