Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550181;
	b=zaLys2t9EeakJWWkzXuyTCdZjR95rGtp0vsOJmghb28GE0fajuzQ4ZMCrmbG8lTvWLqh
	 EDD+LrORhTIqzEuEHirkK7h8JcM8upWNbmbVr2tcT7E8Zc3ONYmuutXFBVC86WaYRj86/
	 mqjSC5rHEwz8/xkLivWDy51AeJnoVkN7Uvr+eG8y/1YPVQwNtmSjCBU+ja6oCAZNT+Qd7
	 7nFR31kYC1/8HX685s8A9dmbnQ5nQ3JWjXdYYSnIWg9A5uWgobuOp+AQSF1l8oR0C65nW
	 i+e0zNOuN7nrJxmlPMK7jk1Aup0WBAB4on3kMePHqihSKgYs7BISbz7OCYC+0bK7+Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550181;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=qsyXpazAhUZahGiFpi6Kdein5RX8nnD9Y+xPSXfamaU=;
	b=WfHfm/SDazAhMpTjbF6kyGPftkdWmossaOTDKrU0iSiCveoOkJ6PpYITq1XKvh2cDvBJ
	 UnHy8lBnRS+0ae8dE/OOlj0wnL290KVjC2G0XOMs6oKmeZgo/1m0ulKgIOSJ7MDwV/q3X
	 PzbuBg0hxMZ7WhTRt5YHteRfwmEmkjS0sAcyloKqk+hlvShrZQnMvvkN+FJoGiEQ6womv
	 v3PkRfdeMF9XfX8QuN+fsYb9xesMkcZURSiuN8wWXN2Y1jwJbBA3ZrohsIHXYtIUTsYB/
	 D/RVkprUMUU/JnYyE/2YGxZbvA5C6Y7Rsi9WRdsp2ZNEOJM/N9GH/pD2/Wh0Js3h4zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=RhpaX4dv;
	arc=none smtp.remote-ip=115.124.28.49
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13493606A319;
	Wed, 21 Oct 2026 02:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13493606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=RhpaX4dv
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1792550172; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=qsyXpazAhUZahGiFpi6Kdein5RX8nnD9Y+xPSXfamaU=;
	b=RhpaX4dvHbil6vsch3SGXYrIaC0u+Rgz7QNJScYebvvlqc8AuJ1t4+HsIyLWwPG7+8XAqCyfrAmWeOSCmgQE50aVK8Bi1+taHKWa8hq3KiPIXJ7HgIee3VIGRC2JE+vKkJ8ax/lWv+KbDtrRy/y/+3pt45T1REpPxXOQD39gJ6ly2NbGgo4OmiKes1Bq1WHvCBHZrnRDMqYsoUZXEBZJvBkm8R5PT13utR/Z4DLGu3aAMnczGwfOv/L6cZUUhi1TRwyhPGcqi+Fy/injSJhpnCeDGxC/aRe24laQq7uJqNYvSNMmE12TW7IpyIa5ant9P1hqG6Fm2j8R1M6iBJvCeQ==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1351674|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_social|0.124289-0.00160616-0.874105;FP=16487930044646701978|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083099174;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=10;RT=10;SR=0;TI=W4_0.2.3_21251D6C_1792550167118_o7001c1047;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_21251D6C_1792550167118_o7001c1047] cluster:ay29) at Wed, 21 Oct 2026 10:36:07 +0800
Date: Wed, 21 Oct 2026 10:36:07 +0800
From: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>,
  "Vincent Mailhol" <mailhol@kernel.org>
Cc: "netdev-bot+sinfo" <netdev-bot+sinfo@kernel.org>,
  "netdev" <netdev@vger.kernel.org>,
  "linux-can" <linux-can@vger.kernel.org>,
  "kernel" <kernel@pengutronix.de>,
  "haibo.chen" <haibo.chen@oss.nxp.com>,
  "shawnguo" <shawnguo@kernel.org>,
  "imx" <imx@lists.linux.dev>,
  "stable" <stable@vger.kernel.org>
Reply-To: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
Message-ID: <04ea1d30-9b6b-4cc9-b92d-a6151084ef0e.chunyuzhiqiang@yinhe.ht>
Subject: =?UTF-8?B?UkXvvJpbUEFUQ0ggdjVdIGNhbjogZGV2OiBjYW5fZmlsbF9pbmZvKCk6IGRvbid0IHdha2Ug?=
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
References: <20261018101744.93657-1-chunyuzhiqiang@yinhe.ht> <20261020075340.417899-1-chunyuzhiqiang@yinhe.ht> <CAMZ6RqKpP62XS5tPR714wUmwf6QkdY4V5fb7c4rTFSyoDc+DAA@mail.gmail.com> <20261020-precise-panther-of-symmetry-db65f4-mkl@pengutronix.de>,<20261020-nebulous-meaty-guillemot-bb7589-mkl@pengutronix.de>
x-aliyun-mail-creator: W4_0.2.3_null_QuNTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXT1c2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwOS4wLjU0MTQuMTIwIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjAtUmVsZWFzZS42MDIxMTAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAyMTAwIChMaW51eDYuMTIuMTAwK2RlYjEzLWFtZDY0OC4xLjAtUmVsZWFzZS42MDIxMTAxKQ==uM
In-Reply-To: <20261020-nebulous-meaty-guillemot-bb7589-mkl@pengutronix.de>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgVmluY2VudCwgTWFyYywKCj4gVGhlIENBTiBUREMgcGFyYW1ldGVycyBhcmUgc3RpbGwgbWVh
bmluZ2Z1bCB3aGVuIHRoZSBpbnRlcmZhY2UgaXMgZG93bi4KPgo+IEFDSwo+Cj4gQWxsIHRoZSBv
dGhlciBUREMgcGFyYW1ldGVycyBzaG91bGQgc3RpbGwgYmUgYXZhaWxhYmxlIHdoZW4gdGhlCj4g
aW50ZXJmYWNlIGlzIGRvd24sIHNvIGp1c3QgZ2F0aW5nIHRoZSBhdXRvIHRkY3YgaXMgZW5vdWdo
IEkgdGhpbmsuCj4KPiBZZXMsIHRoZSBjYWxsIHRvIGRidF9wYXJhbXMtPmRvX2dldF9hdXRvX3Rk
Y3YoKSBzaG91bGQgYmUgZ2F0ZWQuIEFsc28KPiBjaGVjayBpZiB0aGUgc2l6ZSBjYWxjdWxhdGlv
biBoYXMgdG8gYmUgYWRqdXN0ZWQuCgpBZ3JlZWQsIGdhdGluZyB0aGUgd2hvbGUgY2FuX3RkY19m
aWxsX2luZm8oKSB3YXMgdG9vIGJyb2FkLiB2NiBvbmx5IGdhdGVzCmRvX2dldF9hdXRvX3RkY3Yo
KSBvbiBuZXRpZl9ydW5uaW5nKCksIHNvIHRoZSBzdGF0aWMgVERDIHBhcmFtZXRlcnMgYW5kCnRo
ZSBtYW51YWwgVERDViBhcmUgc3RpbGwgcmVwb3J0ZWQgZm9yIGRvd24gaW50ZXJmYWNlcy4KCkZv
ciB0aGUgc2l6ZSBjYWxjdWxhdGlvbiwgY2FuX3RkY19nZXRfc2l6ZSgpIG5vdyB0YWtlcyBhbgph
dXRvX3RkY3ZfcnVubmluZyBhcmd1bWVudCBhbmQgb25seSBza2lwcyB0aGUgSUZMQV9DQU5fVERD
ViBzaXplIHdoZW4gdGhlCmludGVyZmFjZSBpcyBkb3duIGFuZCB0aGUgZHJpdmVyIHVzZXMgZG9f
Z2V0X2F1dG9fdGRjdigpLiBUaGUgcmVzdCBvZiB0aGUKVERDIHNpemUgaXMgdW5jaGFuZ2VkLgoK
VGhlIGJlcnItY291bnRlciBnYXRpbmcgc3RheXMgYXMgaXMuCgpUaGFua3MsCkNodW5ZdVpoaVFp
YW5n
