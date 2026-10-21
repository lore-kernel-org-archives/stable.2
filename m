Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792583435;
	b=alCpDI1odWoQR4y9Ka4VMk0V3PXaGUMekF6tO6vBAgFtd7PDintHex5OsHjmRCJKcW0X
	 rUdjHOmnWrV4mpIRqlnsxjssB9+5kZIpHTr19BZbPCM0C8Z/XII6dEB6a5sJHY2ZaGRXz
	 NHEaH5KC/+/aT2LvhX8DKlyNbLGb/YAVgQnBofRtuMPAYHCzPzw0NYXUpIhNmkzBuTRkV
	 nqlkBm+ZcI7gt0y+QAbNWnr06KnZADghrc7Ep7uxSzpTRxNmdB2UBLZAFnTi+O8zBcuJ2
	 aBbgtD9Fo2UXi/H/QnVY8qvq3laGacE5y27IR21XKYIL9/R/YpWMLkjiqZS9Z3E9v8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792583435;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=72FzsWQIjcY8v6oyt0wQCHWqJMzFBXUTwABFBwus7wg=;
	b=rZM8LC+xmbrjYRVCa2szAn9cT+5/nt12GjRmgzGSPLfossXoGbrIXGxy52W8RCT/Of2b
	 Fp3FkRvzGx0H2GCw23JX72Us6Hc6pfzlKAq9UhaNPFfErQ7U3j9OkC51e6fcM9FO86w9f
	 /GKbDPvFaaUbR1QOZe059o8rbLP16RDZAvLTIKpxzXjFFs9VFvcPlGLcRCkyQ5kDmQOY8
	 y3YH+5byz9W/kS38UWmfHcV1mjHrKuEKtCF+F3G1nFoqg20eDIunlua6TBS0xvWI/e/jg
	 JjBCAYOO3dh/mIQdd0DqWGLRAoGuguGJULu4W5ADJqsZvQ3CMDsgXefY5k1S79OYASg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=bgMF+pv1;
	arc=none smtp.remote-ip=115.124.28.217
Received: from out28-217.mail.aliyun.com (out28-217.mail.aliyun.com [115.124.28.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9561606A319;
	Wed, 21 Oct 2026 11:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9561606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=bgMF+pv1
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1792583430; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=72FzsWQIjcY8v6oyt0wQCHWqJMzFBXUTwABFBwus7wg=;
	b=bgMF+pv1GPQkl57dOMNOU1b0VSwL7y9CH/rBzMKGrSHxkBGZwYxlinnM6ll+3RMILTphhZnY9W1xgD3ZejdNU71pmEr59SNzbMeMIAiSMBXIjKK87hnnTdEmh91TdDJ6JieHTXnkHhYbDN94hIcxGldWBgQ1JkJqWVNZONpYqfyTqhfROpFcWH+7+F5LvxI2RbLfj2OfbW9n/N+68XVwPfBQvbNEke4MjSg3rGxs5A25lxwyJxW7ecu+q5Aq3Ho/XOXBJ3DETM9QF9NVby7dNey2kDoSDtkO0KGokIuWvkrhMUN6wEvgG6OHkh5j2glfQLLDpU5/shgbfIO+dyxVfA==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.135073|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0351905-0.00102775-0.963782;FP=2045342384072965914|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037034184;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=10;RT=10;SR=0;TI=W4_0.2.3_21251643_1792583429724_o7001c188k;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_21251643_1792583429724_o7001c188k] cluster:ay29) at Wed, 21 Oct 2026 19:50:29 +0800
Date: Wed, 21 Oct 2026 19:50:29 +0800
From: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
To: "Vincent Mailhol" <mailhol@kernel.org>
Cc: "netdev" <netdev@vger.kernel.org>,
  "linux-can" <linux-can@vger.kernel.org>,
  "mkl" <mkl@pengutronix.de>,
  "kernel" <kernel@pengutronix.de>,
  "haibo.chen" <haibo.chen@oss.nxp.com>,
  "shawnguo" <shawnguo@kernel.org>,
  "imx" <imx@lists.linux.dev>,
  "stable" <stable@vger.kernel.org>,
  "netdev-bot+sinfo" <netdev-bot+sinfo@kernel.org>
Reply-To: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
Message-ID: <7860eacb-9b7f-41f9-9e60-d48fdee47d4f.chunyuzhiqiang@yinhe.ht>
Subject: =?UTF-8?B?UkXvvJpbUEFUQ0ggdjZdIGNhbjogZGV2OiBjYW5fZmlsbF9pbmZvKCk6IGRvbid0IHdha2Ug?=
  =?UTF-8?B?dXAgY29udHJvbGxlciBpZiBpbnRlcmZhY2UgaXMgZG93bg==?=
X-Mailer: [Alimail-Mailagent revision 74][W4_0.2.3][null][Chrome]
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
x-aliyun-im-through: {"version":"v1.0"}
References: <20261021023334.11803-1-chunyuzhiqiang@yinhe.ht>,<4ef66cfe-9ff8-4d26-87de-48485e9d4fa3@kernel.org>
x-aliyun-mail-creator: W4_0.2.3_null_QuNTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXT1c2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwOS4wLjU0MTQuMTIwIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjAtUmVsZWFzZS42MDIxMTAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAyMTAwIChMaW51eDYuMTIuMTAwK2RlYjEzLWFtZDY0OC4xLjAtUmVsZWFzZS42MDIxMTAxKQ==uM
In-Reply-To: <4ef66cfe-9ff8-4d26-87de-48485e9d4fa3@kernel.org>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgVmluY2VudCwKCj4gTml0cGljazogSSB0aGluayBpdCBpcyBzbGlnaHRseSBiZXR0ZXIgdG8g
cGFzcyBkZXYgcmF0aGVyIHRoYW4KPiBhdXRvX3RkY3ZfcnVubmluZzoKPgo+ICBzdGF0aWMgc2l6
ZV90IGNhbl90ZGNfZ2V0X3NpemUoY29uc3Qgc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiAgICAg
ICAgICAgIHN0cnVjdCBkYXRhX2JpdHRpbWluZ19wYXJhbXMgKmRidF9wYXJhbXMsCj4gICAgICAg
ICAgICB1MzIgdGRjX2ZsYWdzKQo+Cj4gVGhlIHJlYXNvbiBpcyB0aGF0IGJ5IHBhc3NpbmcgZGV2
LCBpdCB3b3VsZCBiZSBlYXNpZXIgaW4gdGhlIGZ1dHVyZSBpZgo+IGZvciB3aGF0ZXZlciByZWFz
b24gd2UgbmVlZCB0byByZXRyaWV2ZSBvdGhlciB2YWx1ZXMuCgpBZ3JlZWQsIHRoYXQncyBjbGVh
bmVyIGFuZCBtb3JlIGNvbnNpc3RlbnQgd2l0aCB0aGUgcmVzdCBvZiB0aGUgZmlsZS4KSSdsbCBm
b2xkIHRoaXMgaW50byB2NzogY2FuX3RkY19nZXRfc2l6ZSgpIGFuZApjYW5fZGF0YV9iaXR0aW1p
bmdfZ2V0X3NpemUoKSB3aWxsIHRha2UgZGV2IGluc3RlYWQgb2YgYSBib29sLCBhbmQgdGhlClRE
Q1Ygc2l6ZSBjb25kaXRpb24gd2lsbCB1c2UgbmV0aWZfcnVubmluZyhkZXYpIGRpcmVjdGx5LgoK
VGhhbmtzLApDaHVuWXVaaGlRaWFuZw==
