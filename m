Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084456;
	b=ciDpq4PMjtsXkHBWt+hA+hXTJ5zTKfJf3IQkWn8gCd6gWEDMjtLF1IJw9FETCt6dCjzq
	 4AXZafGdyJj+n//8+QmIAvUbOL/bPOli/iEg5uugfPaEcwFGrb1zz7Oi5CExQIRBiMRiA
	 72rrymrI9CorKP6LC+rvcnsY0dmFfn+bGcSF2tmyLEpD+eyCXgOKnr6uqycHcPgmjpNbg
	 VWsNbJQ1nHRD/o+loJJQKWbkgmbkbVTXqrWSiZlYbKEc2HEsWQ7TO0eEnc7ewOAl4nTfs
	 kD/2fQLJJQriwPUp0Bc9QZyJNZxDEP7mmMdtXyC4l0ZnT/gHc7fFPn0yoTF28PICS9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084456;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Date:From:To:
	 Cc:Reply-To:Message-ID:Subject:X-Mailer:MIME-Version:
	 x-aliyun-im-through:References:x-aliyun-mail-creator:In-Reply-To:
	 x-aliyun-mailtrack:Content-Type:Content-Transfer-Encoding;
	bh=G3CHyPHqSVPX/oIn+63k332RUvAemXvuZZ9tyeSwFOI=;
	b=0RNOfUkPPxm7GCICMfrasfu1LgHJ+O2rnJjwwlfRKtc/nizoqGHGXR9lEYzV1L8R+5W6
	 fT912xvA66CxiqjL48ZPeaa9AVqUV9HgNbEiHIpDNjBoNztweEgM4y4Rjelharj3cud4M
	 fhOgatdTUHMIoGAIgctDbWPB9PrmnB0KEhuHhXEg3DLpqQLBulvrNQf9Db9oev1HBMJqv
	 3GlK7TV4ELNGiq/2N+tou2i6g82rEOBENjAeLqyWQ+AZPnIYG4gDr7CqN9yg+EXKIbTC3
	 azxe3vbWr2Py/5azyqJHMt6ANisQ+SPMLLYaP1TCeYkBRKLfWgMM7tPNeyFZlgHBKpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=yinhe.ht;
	spf=pass smtp.mailfrom=yinhe.ht;
	dkim=pass header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=NkQ20jcM;
	arc=none smtp.remote-ip=115.124.28.124
Received: from out28-124.mail.aliyun.com (out28-124.mail.aliyun.com [115.124.28.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA53606A323;
	Tue, 27 Oct 2026 07:00:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1BA53606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yinhe.ht
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=yinhe.ht header.i=@yinhe.ht header.a=rsa-sha256 header.s=default header.b=NkQ20jcM
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=yinhe.ht; s=default;
	t=1793084450; h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type;
	bh=G3CHyPHqSVPX/oIn+63k332RUvAemXvuZZ9tyeSwFOI=;
	b=NkQ20jcM1/Ei9BCq/FzJ0ywgGso6Ku2J0gcqvPqc2OaPxUHI5PXRWc58Y26aVPS6PcIzGrFyvf2vmcVi0DZci2UCsmW2aIRYBmLya4cKpIcvfx7w2w41TYT9vMA8Yq0YtpjSOjSuQheYc0ap5lO6+gDMQ5IsFIdR3w5A2Z6maESCpgKzUfy9P2kmhIf0ZVybbPmdndKV6GkqTFWSVrRlRGrTc+rqjxyFEyEZ7MdM8CybM2Xx4tcjqRfjDo/0mCR+X+4qqkfQ/pfbnFf9//4i8pRvxwtlKKDVe3k2PN0kgP3n+65B4IACPQ81DQQO4ERiBC/pWaxhLibJ4E32/qxn4w==
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2858976|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.357271-0.0037877-0.638942;FP=86025002816831325|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033045166233;MF=chunyuzhiqiang@yinhe.ht;NM=1;PH=DW;RN=10;RT=10;SR=0;TI=W4_0.2.3_21251BF5_1793084445172_o7001c92n;
Received: from WS-web (chunyuzhiqiang@yinhe.ht[W4_0.2.3_21251BF5_1793084445172_o7001c92n] cluster:ay29) at Tue, 27 Oct 2026 15:00:45 +0800
Date: Tue, 27 Oct 2026 15:00:45 +0800
From: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
To: "Vincent Mailhol" <mailhol@kernel.org>,
  "netdev-bot+sinfo" <netdev-bot+sinfo@kernel.org>
Cc: "netdev" <netdev@vger.kernel.org>,
  "linux-can" <linux-can@vger.kernel.org>,
  "mkl" <mkl@pengutronix.de>,
  "kernel" <kernel@pengutronix.de>,
  "haibo.chen" <haibo.chen@oss.nxp.com>,
  "shawnguo" <shawnguo@kernel.org>,
  "imx" <imx@lists.linux.dev>,
  "stable" <stable@vger.kernel.org>
Reply-To: "=?UTF-8?B?5rez5LqO5pm65by6?=" <chunyuzhiqiang@yinhe.ht>
Message-ID: <e3fe3acb-cb2b-4d91-94bd-1f6df474792c.chunyuzhiqiang@yinhe.ht>
Subject: =?UTF-8?B?UkXvvJpbUEFUQ0ggdjddIGNhbjogZGV2OiBjYW5fZmlsbF9pbmZvKCk6IGRvbid0IHdha2Ug?=
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
References: <20261021145115.153107-1-chunyuzhiqiang@yinhe.ht>,<b0d3e7bf-ddd3-4eaa-8ebc-fbe5e7d8443f@kernel.org>,<635d5817-f715-40c4-94e1-306204ca5521.chunyuzhiqiang@yinhe.ht>
x-aliyun-mail-creator: W4_0.2.3_null_QuNTW96aWxsYS81LjAgKFdpbmRvd3MgTlQgNi4xOyBXT1c2NCkgQXBwbGVXZWJLaXQvNTM3LjM2IChLSFRNTCwgbGlrZSBHZWNrbykgQ2hyb21lLzEwOS4wLjU0MTQuMTIwIFNhZmFyaS81MzcuMzYgZGluZ3RhbGstd2luLzEuMC4wIG53KDAuMTQuNykgRGluZ1RhbGsoOC4xLjAtUmVsZWFzZS42MDIxMTAxKSBNb2pvLzEuMC4wIE5hdGl2ZSBBcHBUeXBlKHJlbGVhc2UpIENoYW5uZWwvMjAyMTAwIChMaW51eDYuMTIuMTAwK2RlYjEzLWFtZDY0OC4xLjAtUmVsZWFzZS42MDIxMTAxKQ==uM
In-Reply-To: <635d5817-f715-40c4-94e1-306204ca5521.chunyuzhiqiang@yinhe.ht>
x-aliyun-mailtrack: {"foreign-track":"0"}
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

SGkgVmluY2VudCwKClNvcnJ5LCBteSBwcmV2aW91cyByZXBseSB3YXMgd3Jvbmcgb24gdHdvIGNv
dW50cy4KCjEuIHY4IGFscmVhZHkgaGFzIGJvdGggY29uZGl0aW9ucyBvbiBhIHNpbmdsZSBsaW5l
OgoKCWlmIChwcml2LT5kb19nZXRfYmVycl9jb3VudGVyICYmIG5ldGlmX3J1bm5pbmcoZGV2KSkJ
LyogSUZMQV9DQU5fQkVSUl9DT1VOVEVSICovCgogICB9IGVsc2UgaWYgKGRidF9wYXJhbXMtPmRv
X2dldF9hdXRvX3RkY3YgJiYgbmV0aWZfcnVubmluZyhkZXYpKSB7CgogICBTbyBubyB2OSBpcyBu
ZWVkZWQgZm9yIHRoZXNlIG5pdHBpY2tzLgoKMi4gVGhlIGxpbmsgaW4gbXkgcHJldmlvdXMgbWFp
bCB3YXMgYSBwbGFjZWhvbGRlci4gVGhlIGFjdHVhbCB2OAogICBzZXJpZXMgaXMgaGVyZToKCmh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LWNhbi8yMDI2MTAyNzA2NTAxMi4xOTEzNDgtMS1j
aHVueXV6aGlxaWFuZ0B5aW5oZS5odC9ULyN0CgpQbGVhc2UgaWdub3JlIHRoZSAic3RpbGwgc3Bs
aXQgYWNyb3NzIHR3byBsaW5lcyIgcGFydC4KClRoYW5rcywKQ2h1bll1WmhpUWlhbmc=
