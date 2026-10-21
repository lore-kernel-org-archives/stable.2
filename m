Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.73
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792594718;
	b=v0pTTidZ7GYsF+y7wREJ3AVzPRhLkjlQpDSZiR3ZHSXl0TagaQqj7nf/bGXN4In2KK83
	 b3Fh/bD8dw08+E/XJV0mbgPNDSxkoXvxXkdvOYnbnqSng3inVeY+dvL13gZM8v/TZEC+N
	 W0SC3/IxnORWo6GVyvrU5MbrU8pr51tfmm88Y1A2aJz32W7fmXmYynTSQEwX3+tXbHx9B
	 qIu14sAP5j+aeZvXwSsh7PV2bWAWT0x+1dyU/9yWY44qlQLGBDAbS7shLPhfKrPZsVhgF
	 KV692xPfvTNzi6kVHFpeUPhe5LqaCMndfotRPC2GHzxTYinAhSB/MXnWohivHDEpFaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792594718;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=C3dqHBo0uBLdePKBl5z0IlryPz8FCarlaELddSUrG/8=;
	b=i5uoIB+Ml21FdP+oaYOOrNNpsSlqDZZKreSajj7BW4wfYCZLmz6JSYtDR6JnPgiFGBiu
	 eqVkOwsKIryNzIVSQddOh2uGK+jO8kSNA1BcwuTbFuUxAC6khGB6Suj6yiiKhFZBkN5uA
	 n2lrsPQldwgYw79RXPWkyVbZvl41LBdWuVC7nhA4B771M/zD0HxatlbQtoo3WmYrDHCFE
	 XLPy+3YYT1pegtKITDwsMqgaen6FTpYpTdEuuISNIhYXSZHVkYRWALnMWmG9YK5hdinDZ
	 yJO8FHeJeFgFYMr61pt4SkQt5ipm00XU7SZrLf/N4AKyJ/5xCkzLvdgkB7vu6+vDP4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=gRFSk3xP;
	arc=none smtp.remote-ip=115.124.28.73
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE5D606A321;
	Wed, 21 Oct 2026 14:58:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CE5D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=gRFSk3xP
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1792594713; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=C3dqHBo0uBLdePKBl5z0IlryPz8FCarlaELddSUrG/8=;
	b=gRFSk3xPdLSiRQ5K8fh/KdI412C+cR/41iwM+uVXiHrPShrebvb9uGrs8V5MOw9Pj5oPILraxWhzSARZadLgXRPMar28vF/GG+wDBDSJbWbngXvCaJ8mam1+LCvMZA1/yjpOnaVnu3iu1QoBxZnRPT5RYq5dUcUlFjT6yFGeoM1hlfhC8TkXlSH99dFTBd4U9PGJdRH0qJB+j+a1lCiiolsI/TLoF/XfyPLriKOmQAdzq6BCYbO91sdNjaY11a3HehuyznSUti1oYj1u6IQHBRRGrkmkEpsxk99097fYNNDoVyYtfHdFdbZWjsKVNW5zl8SG2K/1fR1mrKUhvVNy/g==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2023654|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_news_journal|0.0460745-0.0028953-0.95103;FP=6080588669665476379|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033025068124;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=10;RT=10;SR=0;TI=W4_0.2.3_212DDFD4_1792594707797_o7001c76l;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_212DDFD4_1792594707797_o7001c76l] cluster:ay29) at Wed, 21 Oct 2026 22:58:28 +0800
Date: Wed, 21 Oct 2026 22:58:28 +0800
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
Message-ID: <bf1a39bf-f26a-47c0-8d52-5ceaf68adece.chunyuzhiqiang@yinhe.ht>
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
cGFzcyBkZXYgcmF0aGVyIHRoYW4KPiBhdXRvX3RkY3ZfcnVubmluZzoKPiAuLi4KCnY3IGlzIG91
dCBhbmQgZm9sZHMgaW4geW91ciBzdWdnZXN0aW9uOiBjYW5fdGRjX2dldF9zaXplKCkgYW5kCmNh
bl9kYXRhX2JpdHRpbWluZ19nZXRfc2l6ZSgpIG5vdyB0YWtlIGRldiwgYW5kIHRoZSBURENWIHNp
emUgY29uZGl0aW9uCnVzZXMgbmV0aWZfcnVubmluZyhkZXYpIGRpcmVjdGx5LgoKTGluazogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtY2FuLzIwMjYxMDIxMTQ1MTE1LjE1MzEwNy0xLWNo
dW55dXpoaXFpYW5nQHlpbmhlLmh0LwoKU29ycnkgZm9yIG5vdCBDYydpbmcgeW91IG9uIHRoZSB2
NyBwb3N0aW5nLgoKVGhhbmtzLApDaHVuWXVaaGlRaWFuZw==
