Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792492314;
	b=Ql2jleRRPD0loIg+kfFXRtrPlWirwqu0CjIlpBAFXKUNXGlwiDsmwsH1DEj3/AMVP5OW
	 YRKjvWba+A87VyTW/jBO+NJutjUusK3ckZludVS3cq5y5RPB+ZabjqkQxOW5/mdzR91Fo
	 qq2APwBhTaGFuatoELzmc1f9IBniUE4Rdg1BORnncZDW9AgLGRyPs7vEJx14OtWNaBN38
	 GyoEESWd6FY35vCs+Q4St9wWx6l81zkaBy6P+fRXUoSt/R2QNH09sCrPhZ0Wy524gDUEJ
	 IQtYoe4xlJFF8cVRuq1lMTCAUdS0Bb6U0DaEa7ZMmhZwVkEHwnq0iKv97JegvR+na5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792492314;
	h=DMARC-Filter:DKIM-Signature:Received:X-Originating-IP:Date:From:To:
	 Cc:Subject:X-Priority:X-Mailer:In-Reply-To:References:X-NTES-SC:
	 Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	 X-Coremail-Locale:X-CM-TRANSID:X-CM-SenderInfo:X-Coremail-Antispam;
	bh=+VuC4JgfbbKtomG49xe1m2V8q/PY9vIxlL9yX3m7W7Q=;
	b=pgYGbQOJkCNR/mC2kcJKR/E7jCwxj3eH5Il/pEQaCcGA+NzV1yeTj2Iz2mnkYUDLMjn6
	 VWb+HkyEkOdY1pVtyt6P/AKZKXX0moOf+PwIBX+9ZupstVNyy7+wDLjae2oubxASKcOsn
	 w1NfCwMz3R8RAjsffJY7idwzCjzG/LZXgHDrA3aCbftNu3EEhdKfotreBVuJzVUg0Y/xY
	 c264x4QEf807i4hEkoOEBT/guoxPDUI9zQTN1+cG1uA/qCD4gWX553NJbD4nkzRILswvb
	 uKtmSG/eINp5x6gqrNVllotUxT0h63giQKDBuKS0zbzF5Z559+8D57lmO/nr2eBY7EQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iWXn27U7;
	arc=none smtp.remote-ip=117.135.210.4
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC9606A31F;
	Tue, 20 Oct 2026 10:31:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43FC9606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iWXn27U7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
	Message-ID; bh=+VuC4JgfbbKtomG49xe1m2V8q/PY9vIxlL9yX3m7W7Q=; b=i
	WXn27U73ko9bmjAJYrY3O2e7fCFafeM5jJG5+e/2+9DcgK6gWHr13RveorZLRYl6
	px6WMgmkzLwSWVgZMC0FFRKwI3kL4XvIkJfXydO23HMlVLVKGoxZadhtIklmBCIX
	IWv7s5Z0t7+gE3mQp5gHpLZABmB3p/pPNHXuQ8q59w=
Received: from slark_xiao$163.com (
 [2408:8459:3c10:539b:d4b2:3883:2280:43f4] ) by ajax-webmail-wmsvr-40-141
 (Coremail) ; Tue, 20 Oct 2026 18:31:31 +0800 (CST)
Date: Tue, 20 Oct 2026 18:31:31 +0800 (CST)
From: "Slark Xiao" <slark_xiao@163.com>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>
Cc: mani@kernel.org, jeff.hugo@oss.qualcomm.com,
	krishna.chundru@oss.qualcomm.com, mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re:Re: Re: [PATCH] bus: mhi: host: pci_generic: Update the default
 autosuspend_delay_ms as 5000ms
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 163com
In-Reply-To: <CAFEp6-3o6gCb61hCQTJydiH2aD6CBVRa947tpmLe4L9j85Jg5w@mail.gmail.com>
References: <20261019055109.49922-1-slark_xiao@163.com>
 <CAFEp6-2XUE4AQPm5hinnRGyrrsHok2ftsFXragiHgDSKKtKWow@mail.gmail.com>
 <70714501.3175.1a157532149.Coremail.slark_xiao@163.com>
 <CAFEp6-3o6gCb61hCQTJydiH2aD6CBVRa947tpmLe4L9j85Jg5w@mail.gmail.com>
X-NTES-SC: AL_Qu2SAPiSvUoi5yKQYukdkksQgec4UMu1ufkm1YVQc+sGugXc3i4+fHFvBVny3+OmISWKkzSKXApu6MN/RJhgumkNQhMiUoB9mNopWRNBNQ==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <65d8a1b5.8e5b.1a158ddc4de.Coremail.slark_xiao@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jSgvCgD3PwADQ9dqbyVcAA--.370W
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbC6ANhxWrXQwPZ8gAA3Z
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgpBdCAyMDI2LTEwLTIwIDE1OjI3OjQzLCAiTG9pYyBQb3VsYWluIiA8bG9pYy5wb3VsYWluQG9z
cy5xdWFsY29tbS5jb20+IHdyb3RlOgo+SGkgU2xhcmssCj4KPk9uIFR1ZSwgT2N0IDIwLCAyMDI2
IGF0IDU6MjDigK9BTSBTbGFyayBYaWFvIDxzbGFya194aWFvQDE2My5jb20+IHdyb3RlOgo+Pgo+
Pgo+PiBBdCAyMDI2LTEwLTE5IDE1OjQxOjI3LCAiTG9pYyBQb3VsYWluIiA8bG9pYy5wb3VsYWlu
QG9zcy5xdWFsY29tbS5jb20+IHdyb3RlOgo+PiA+T24gTW9uLCBPY3QgMTksIDIwMjYgYXQgNzo1
MuKAr0FNIFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4gd3JvdGU6Cj4+ID4+Cj4+ID4+
IEZvciBzb21lIE1ISSBkZXZpY2VzIGluIHNvbWUgc3BlY2lmaWMgc2NlbmFyaW8sIHRoZSBkZWZh
dWx0IHZhbHVlCj4+ID4+IG9mIGF1dG9zdXNwZW5kX2RlbGF5X21zIG1heSBub3QgZW5vdWdoIHRv
IGhhbmRsZSBsYXN0IHdha2UgZXZlbnQuCj4+ID4+IFRoaXMgbWF5IGxlYWQgdG8gc29tZSB1bmV4
cGVjdGVkIHByb2JsZW1zLgo+PiA+Pgo+PiA+PiBSZWZlciB0byB0aGUgUXVhbGNvbW0ncyBXaW5k
b3dzIHNldHRpbmdzIGFuZCB3ZSBjaGVja2VkIHRoaXMgd2l0aAo+PiA+PiBRdWFjbG9tbSBvdmVy
IGNhc2UsIFF1YWxjb21tIHJlY29tbWVuZCB1cyB0byBzZXQgdGhpcyBhcyA1MDAwbXMuCj4+ID4K
Pj4gPlF1YWxjb21tCj4+ID4KPj4gPj4gUXVhbGNvbW0gYWxzbyBzdWdnZXN0cyB1cyB0byB1cGRh
dGUgdGhpcyBmb3IgYWxsIE1ISSBkZXZpY2VzLgo+PiA+PiBTaW5jZSB0aGlzIHNldHRpbmcgaGFz
IGFmZmVjdGVkIHNvbWUgZXhpc3RlZCBrZXJuZWwgdmVyc2lvbnMsIGl0J3MKPj4gPj4gYmV0dGVy
IHRvIGJlIGFwcGxpZWQgdG8gc3RhYmxlIHZlcnNpb24uCj4+ID4KPj4gPlRoaXMgbG9va3MgbW9y
ZSBsaWtlIGEgd29ya2Fyb3VuZCB0aGFuIGEgcHJvcGVyIGZpeC4gSXQgd291bGQgYmUKPj4gPmhl
bHBmdWwgdG8gZGVzY3JpYmUgdGhlIHVuZGVybHlpbmcgaXNzdWUsIGluY2x1ZGluZyB0aGUgdGlt
aW5nIGFuZAo+PiA+c2VxdWVuY2Ugb2YgZXZlbnRzIHRoYXQgbWFrZSB0aGlzIG5lY2Vzc2FyeS4g
SW4gcHJpbmNpcGxlLCBlaXRoZXIgdGhlCj4+ID5kZXZpY2UgY2FuIGJlIHN1c3BlbmRlZCBhdCB0
aGF0IHBvaW50IG9yIGl0IGNhbm5vdC4gUmVseWluZyBvbiBhCj4+ID5kZWxheWVkIHN1c3BlbmQg
ZmVlbHMgZnJhZ2lsZSBhbmQgbWF5IGVuZCB1cCBtYXNraW5nIHRoZSByZWFsIHByb2JsZW0uCj4+
ID4KPj4gSGkgTG9pYywKPj4gSG9uZXN0bHksIFF1YWxjb21tIGhhcyBiZWVuIGFuYWx5emluZyBm
b3Igb3ZlciAyIG1vbnRocyBhbmQgc3RpbGwgaGFzbid0Cj4+IGlkZW50aWZpZWQgdGhlIHJvb3Qg
Y2F1c2UuCj4+Cj4+IEFjdHVhbGx5IEkgaGF2ZSBleHBsYWluZWQgdGhlIHJlYXNvbnMgYmVoaW5k
IHRoZSBldmVudHMgdG8gTWFuaSBpbiBhbm90aGVyCj4+IHRocmVhZCwgeW91IGNhbiByZWZlciB0
byBodHRwczovL2xvcmUua2VybmVsLm9yZy9taGkvMjAyNjA5MTkwOTU1MDYuOTU3MC0xLXNsYXJr
X3hpYW9AMTYzLmNvbS8KPj4KPj4gRnJvbSBRdWFsY29tbSdzIHBlcnNwZWN0aXZlLCAyIHNlY29u
ZHMgaXMgbm90IGVub3VnaCBmb3IgdGhlaXIgZGVmYXVsdCBkZXNpZ24uCj4+IFRoZXkgcmVjb21t
ZW5kZWQgdXMgdG8gdXBkYXRlIHRoaXMgdmFsdWUgdG8gNSBzZWNvbmRzIGFuZCBNYW5pIGNoZWNr
ZWQgdGhpcwo+PiBpbnRlcm5hbGx5IGFzIHdlbGwuIFNvIHdlIGRlY2lkZWQgdG8gdXBkYXRlIHRo
aXMgNSBzZWNvbmRzIHNldHRpbmcgdG8gYWxsIE1ISSBkZXZpY2VzLgo+Cj5UaGFua3MuIEknbSBy
ZWFsbHkgc3VycHJpc2VkIHdlIHN0aWxsIGRvbid0IGhhdmUgYSBtb3JlIHByZWNpc2UKPnVuZGVy
c3RhbmRpbmcgb3IgZGVzY3JpcHRpb24gb2YgdGhlIHVuZGVybHlpbmcgaXNzdWUuIFRoYXQgc2Fp
ZCwgSQo+dGhpbmsgaXQncyByZWFzb25hYmxlIHRvIHByb2NlZWQgd2l0aCB0aGlzIGFzIGFuIGlu
aXRpYWwgd29ya2Fyb3VuZC4KPgo+Q291bGQgeW91IHBsZWFzZSBzZW5kIGEgdjIgdGhhdCBpbnRy
b2R1Y2VzIGEgZGVmaW5lIGZvciB0aGUgNTAwMCBtcwo+dGltZW91dD8gSXQgd291bGQgYWxzbyBi
ZSBoZWxwZnVsIHRvIGFkZCBhIGNvbW1lbnQgZXhwbGFpbmluZyB0aGF0Cj50aGlzIHZhbHVlIGlz
IHJlcXVpcmVkIHRvIGFjY29tbW9kYXRlIHRoZSAnbGF0ZSB3YWtlLWV2ZW50IGlzc3VlJy4KPgo+
UmVnYXJkcywKPkxvaWMKCkRvIHlvdSBtZWFuIHNvbWV0aGluZyBsaWtlIGJlbG93PwoKLyogQWRk
IGRlZmluZSBvZiAgaW5pdGlhbCBhdXRvc3VzcGVuZF9kZWxheV9tcyB0byBhY2NvbW1vZGF0ZSBh
IHBvdGVudGlhbCAnbGF0ZSB3YWtlLWV2ZW50JyBpc3N1ZSAqLwojZGVmaW5lIE1ISV9BVVRPU1VT
UEVORF9ERUxBWV9NUyA1MDAwCi4uLi4uLgogLSAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfc2V0
X2F1dG9zdXNwZW5kX2RlbGF5KCZwZGV2LT5kZXYsIDIwMDApOwogKyAgICAgICAgICAgICAgIHBt
X3J1bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KCZwZGV2LT5kZXYsIE1ISV9BVVRPU1VTUEVO
RF9ERUxBWV9NUyk7CgpUaGFua3MKCj4+Cj4+IFRoYW5rcwo+PiA+Pgo+PiA+PiBGaXhlczogZDM4
MDBjMWRjZTI0ICgiYnVzOiBtaGk6IHBjaV9nZW5lcmljOiBBZGQgc3VwcG9ydCBmb3IgcnVudGlt
ZSBQTSIpCj4+ID4+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+ID4+IFNpZ25lZC1vZmYt
Ynk6IFNsYXJrIFhpYW8gPHNsYXJrX3hpYW9AMTYzLmNvbT4KPj4gPj4gLS0tCj4+ID4+ICBkcml2
ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jIHwgMiArLQo+PiA+PiAgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4+ID4+Cj4+ID4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jIGIvZHJpdmVycy9idXMvbWhpL2hv
c3QvcGNpX2dlbmVyaWMuYwo+PiA+PiBpbmRleCA3MTkzYTM4NGNjYTQuLjQwNzM1YmViNDZjYiAx
MDA2NDQKPj4gPj4gLS0tIGEvZHJpdmVycy9idXMvbWhpL2hvc3QvcGNpX2dlbmVyaWMuYwo+PiA+
PiArKysgYi9kcml2ZXJzL2J1cy9taGkvaG9zdC9wY2lfZ2VuZXJpYy5jCj4+ID4+IEBAIC0xNDgz
LDcgKzE0ODMsNyBAQCBzdGF0aWMgaW50IG1oaV9wY2lfcHJvYmUoc3RydWN0IHBjaV9kZXYgKnBk
ZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPj4gPj4KPj4gPj4gICAgICAgICAv
KiBBbGxvdyBydW50aW1lIHN1c3BlbmQgb25seSBpZiBib3RoIFBNRSBmcm9tIEQzSG90IGFuZCBN
MyBhcmUgc3VwcG9ydGVkICovCj4+ID4+ICAgICAgICAgaWYgKHBjaV9wbWVfY2FwYWJsZShwZGV2
LCBQQ0lfRDNob3QpICYmICEoaW5mby0+bm9fbTMpKSB7Cj4+ID4+IC0gICAgICAgICAgICAgICBw
bV9ydW50aW1lX3NldF9hdXRvc3VzcGVuZF9kZWxheSgmcGRldi0+ZGV2LCAyMDAwKTsKPj4gPj4g
KyAgICAgICAgICAgICAgIHBtX3J1bnRpbWVfc2V0X2F1dG9zdXNwZW5kX2RlbGF5KCZwZGV2LT5k
ZXYsIDUwMDApOwo+PiA+PiAgICAgICAgICAgICAgICAgcG1fcnVudGltZV91c2VfYXV0b3N1c3Bl
bmQoJnBkZXYtPmRldik7Cj4+ID4+ICAgICAgICAgICAgICAgICBwbV9ydW50aW1lX21hcmtfbGFz
dF9idXN5KCZwZGV2LT5kZXYpOwo+PiA+PiAgICAgICAgICAgICAgICAgcG1fcnVudGltZV9wdXRf
bm9pZGxlKCZwZGV2LT5kZXYpOwo+PiA+PiAtLQo+PiA+PiAyLjUzLjAKPj4gPj4K
