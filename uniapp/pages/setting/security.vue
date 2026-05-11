<template>
	<view class="text-white">
		<u-navbar :title="$t('setting.aqsz')"></u-navbar>
		<view class="list">
			<navigator url="/pages/setting/password" class="item">
				<text>{{i18n.editLoginPassword}}</text>
				<text class="iconfont icon-gengduo1 font-size-28"></text>
			</navigator>
		</view>
		<!-- <view class="list">
			<view class="item" @click="showSetpayPassword=true">
				<text>{{i18n.setPayPassword}}</text>
				<text class="iconfont icon-gengduo1"></text>
			</view>
			<navigator url="/pages/setting/payPassword" class="item">
				<text>{{i18n.editPayPassword}}</text>
				<text class="iconfont icon-gengduo1"></text>
			</navigator>
		</view> -->
		<view class="list">
			<view class="item" @click="showEditPhone=true">
				<text>{{i18n.bindPhone}}</text>
				<view class="d-flex align-items-center font-size-28 opacity-50">
					<text class="text mr-20">{{user.phone}}</text>
					<text class="iconfont icon-gengduo1 font-size-28"></text>
				</view>
			</view>
			<view class="item">
				<text>{{i18n.email}}</text>
				<text class="text  font-size-28 opacity-50">{{user.email}}</text>
			</view>
		</view>
		<!-- <view class="list">
			<view class="item">
				<text>{{i18n.stayLogin}}</text>
				<text class="iconfont icon-gengduo1"></text>
			</view>
		</view> -->
		
		<u-popup v-model="showSetpayPassword"  mode="bottom" length="34%" :title="i18n.setPayPassword">
			<view class="mx-30">
				<u-message-input mode="bottomLine" :maxlength="6" :breathe="true"></u-message-input>
				<button class="warning-button mt-40 font-size-28">{{$t("common.submit")}}</button>
			</view>
		</u-popup>
		
		<!-- 修改手机号 -->
		<u-popup v-model="showEditPhone"  mode="bottom" length="50%" :title="i18n.bindPhone">
			<view class="mx-30">
				<text class="d-block font-size-32 mt-30 mb-8">{{i18n.phoneNumber}}</text>
				<view class="d-flex border-radius-20 bg-secondary py-20 px-30 position-relative">
					<view class="d-flex align-items-baseline mr-30" @click="showSelectAreaFunc">
						<text class="mr-10 font-size-32">{{selectArea.area_code}}</text>
						<text class="iconfont icon-xiala font-size-26"></text>
					</view>
					<view class="flex-1">
						<input type="digit" v-model="phone" class="security" :placeholder="i18n.plsInputMobile">
					</view>
					<button class="warning-button py-0 font-size-22 px-20" v-if="!hasSend" @click="sendCode">{{i18n.sendCode}}</button>
					<button class="secondary-button py-0 font-size-22 px-20" v-else>{{seconds}}s</button>
				</view>
				<text class="d-block font-size-32 mt-30 mb-8">{{i18n.code}}</text>
				<view class="border-radius-20 bg-secondary py-20 px-30 position-relative ">

					<input type="digit" v-model="code" class="security" :placeholder="i18n.plsIptCode">
				</view>
				<button class="warning-button mt-40 font-size-28" @click="saveMobile">{{$t("common.submit")}}</button>
			</view>
		</u-popup>
		<u-select v-model="showSelectArea" :list="areas" value-name="area_code" :cancelText='$t("common.cancel")' :confirmText='$t("common.confirm")' @confirm="confirmSelectArea"></u-select>

	</view>
</template>

<script>
	import areas from '@/common/areas.js'
	export default {
		data() {
			return {
				showSetpayPassword:false,
				showEditPhone:false,
				areas:[],
				phone:'',
				showSelectArea:false,
				selectArea:{},
				seconds:120,
				code:null,
				hasSend:false,
				secondsInterval:null,
				user:{}
			};
		},
		onLoad() {
			this.user = this.$store.state.user
			this.areas = areas.map(item=>{
				item.label = item.area_code + ' ' + item.name_en
				return item
			})
			this.selectArea = this.areas.find(item=>item.area_code == '+852') 
		},
		methods:{
			showSelectAreaFunc(){
				this.showEditPhone=false
				setTimeout(()=>{
					this.showSelectArea=true
				},100)
			},
			confirmSelectArea(e){
				const value = e[0].value
				this.selectArea = this.areas.find(item=>item.area_code == value)
				 setTimeout(()=>{
					this.showEditPhone=true
				 },100)
			},
			//发送验证码
			sendCode(){
				const {phone,i18n,selectArea} = this
				if(!phone){
					return this.$utils.showToast(i18n.plsInputMobile)
				}
				const area_code = selectArea.area_code.replace('+','')
				//发送短信的接口
				this.$u.api.setting.sendSmsCode(area_code,phone).then(res=>{
					this.$utils.showToast(res.message)
					this.hasSend = true
					this.secondsInterval = setInterval(() => {
						this.seconds = this.seconds - 1
						if (this.seconds == 0) {
							clearInterval(this.secondsInterval)
							this.hasSend = false
							this.seconds = 120
						}
					}, 1000)
				})
			},
			saveMobile(){
				const {phone,i18n,selectArea,code} = this
				if(!phone){
					return this.$utils.showToast(i18n.plsInputMobile)
				}
				if(!code){
					return this.$utils.showToast(i18n.plsIptCode)
				}
				this.$u.api.setting.bindMobile(phone,code).then(res=>{
					this.$utils.showToast(res.message)
					setTimeout(()=>{
						this.showEditPhone = false
					},300)
				})
			}
		},
		computed:{
			i18n(){
				return this.$t("setting")
			}
		},
		onHide(){
			if(this.secondsInterval) clearInterval(this.secondsInterval)
		}
	}
</script>

<style lang="scss" scoped>
	.list{
		border-top: 12rpx solid #393939;
		.item{
			@extend .d-flex-between-center;
			font-size: 32rpx;
			padding: 26rpx 30rpx;
			position: relative;
			&:after{
				content: "";
				position: absolute;
				left: 30rpx;
				right: 30rpx;
				top: 0;
				height: 2rpx;
				background-color: #393939;
			}
			&:first-child:after{
				display: none;
			}
			
		}
	}

	.security{
		.uni-input-placeholder{
			color: #999;
		}
	}
</style>
