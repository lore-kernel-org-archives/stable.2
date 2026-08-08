Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4321D1DDC37;
	Sat,  8 Aug 2026 05:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786167027; cv=none; b=r+DiSer2ZYkcnTVR4CkV5PEMZb4uorqlarLoOMMVr5lyRjNvJw4TFP0JQJf1lmZqBzVVBVIcyx4TpjTFpmG15l5TNkdt4jZ+ckIzZFARA368T+NYj8dG6D4bNP3mz2BPVZNBmW7iJRE9UJobMt0tvs9U+98/AzgHZTbL8ao8FiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786167027; c=relaxed/simple;
	bh=Z7qqH7LW3+V54E3F+JyBOF+7QPST2EdHeRx2nwo8tsY=;
	h=Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ERcaaTbcpHRhY5iQcuTNtR14km90uDaiA/g0Fp5olJA4VVCiFl2uWA+fUSULe4ecI5qrWHFXzwAjM0dDVPuVuRzZFQncASZ1lnI3S3D8cQjSyj3S0YFeyiI01yLZ2GSoU0A7VXowQX9uTbcMAGSQ7674yhh/s/EtVy5TiECJ7zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org; spf=pass smtp.mailfrom=flapping.org; dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b=Jcz5oemF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IxqkjLw+; arc=none smtp.client-ip=103.168.172.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flapping.org header.i=@flapping.org header.b="Jcz5oemF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IxqkjLw+"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 1C4AC13800FD;
	Sat,  8 Aug 2026 01:30:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 08 Aug 2026 01:30:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1786167024;
	 x=1786170624; bh=Z7qqH7LW3+V54E3F+JyBOF+7QPST2EdHeRx2nwo8tsY=; b=
	Jcz5oemFNcwKRU0VF1OF5IYuMcQXEZ8vs2ZUs4hSKvoNbeTaKF8m4+us+FHkeTdv
	ijJjMCBGiYqqW0ySD2LbZevioMsYqhzkCOzyOiRq6VA2gZx//IqaVmg4bbjVMSG8
	IfSXaeHkV695Pyyml1gbazWhYo4zHlRR88rzK6i9EgSAZiF+ZTVJ1HzqXHUe7t2H
	aEq8bSoJ9CixHyXFB4vEWqjlnV4HyHSzItbYeYeyErx8k6HBdvgv4mcuTQV0y7y5
	XMqQTvqsuhMAvdkvL25t5We6A9IxE+NC78q2iQISTTTyN6gwtkg8aDTkNXD2YLmc
	1gBOW5QDnP4uU4wX/LyiPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786167024; x=
	1786170624; bh=Z7qqH7LW3+V54E3F+JyBOF+7QPST2EdHeRx2nwo8tsY=; b=I
	xqkjLw+e5SnqNu2pvvtSL1ctzzGj3BFX65v8HlBRdPYLQb8fLSaOgVMgITdhSAzM
	IrBPQo77D9OvW0E+ninknzEH9m/f1eYkCeU6L36fR67ddXTHmpziy1G5U+lMxYv7
	kf3V0l83F9aD48QH2HvsHeYTtuPIzq6Froi4AgEIrD4zlZyPkeqn3MiPgZOECPJN
	xLgmQD2PErBsnNsZjq/qYCt5Ed1PI/gdKFBNDVJd6rLv2seSvYHqLXtl6Hl3L/J6
	4a7QqmbPZSV1RnlaNAskXp0PDJ89KPYa+/uGADUUN+Xf8neTd9SOvoHh/zGOJxbP
	CenaAKLlfSjKt2FBgpKLg==
X-ME-Sender: <xms:7r52ajLzauOFzcWe9NSyoWIXpMiG3NViCkWxAGVCy9tvjx7QkgLdJg>
    <xme:7r52ageqfmoI-bOKo4BJ07tfx5NUUTsd8yMi5HKNouLyF49NDUd77OUthySg7rkZF
    ZtSlVrfuxx3wZpnLiuZ_PbyDslQPdl6E_2s4Gnssqccgl_wqs3XKpU>
X-ME-Received: <xmr:7r52ajsY9j43_OkBu7c-2meEDn4om7V_QIaKmRrcR_AalMo5jmGiSi1N20bk51wAVlj0ATId_x9LvxR5IkLbR8tI>
X-ME-Proxy-Cause: dmFkZTFmBd0NuyB3aeGQKppgbGUY2cM5HAd/TJk9kA8lZc0wGCcICpb4AqwPBT1g/SzG+q
    3/kqa12a9t5mbd5xNvhmx4qa4a/GgJwXgU7vRcoTgQBfz00n2Ju2OT+mOdRaXRSC8tZyhQ
    TerJb4ASAtl0scbHr6YdI93TOJtnDYTcPICB0NFkabP/Abj+kC5uNsLnhJTjaNJqBPNl3S
    PrsjFZeunp1YQb6IQ36Piz7Q2O6Ts8OkfRAGwzqzoAEnLdR0tq1h1R28dEiV4vjwh6ez8e
    W5NVEuEbh9YhDTNqiV5doG6S0KXUeH/+If6ibEOCJ9dwLnHwqscx9QT84HbpEGtsbGxaTp
    1Iqsj/hlrqndnlf5baJ36iO/mskY07RkwG7BfwAZFVR/7MPbX8t2KTC942I+sWJfChq+8N
    UfJhG2/tqjcCFnhnagvK/J7JwAlaNO+/eZLbS3v3CYtsHeWGESvQ5VhLS3v30qBwX/UB2M
    exCCxFVpLwSDTIvuD6MybO2PBmjVgPO6P828+t/h9cH3HGEalGkpPWtns+ykGEJWo3wLxC
    IPrRpmBVP7B4qwx42Qh6bziIMf8SAR/8UdE+MfPanKYtW3MGebDf+9ACSV+XHpJQhDJv2L
    ouBNvmBNhGqXRzfCDB4tuZW7VbcF/7ES5VN/ZD3Vr+jesqEjgAsA31nlmH+Q
X-ME-Proxy: <xmx:7r52amGyAK2aKbReDRN5OTWIKNcqoVt819Fqto8JPVe3Jy275z0G-w>
    <xmx:7r52alfD7Hxh2iap__dLFRPX2xNFRo4NJhYVVNBL3yrwFEwlzOt6Dw>
    <xmx:7r52aquteibrkL2SWmaPhhlg73S4VKcLR4fiZJMtC9wYyfDlb-bY4w>
    <xmx:7r52akmqi4fTiAPH08VW9NanUK-SDfekbtFPTvqAZ38tJwC5LvXXFQ>
    <xmx:7752aj0MSQ36KqHGPYbqMvWPz-AvM2C4ihgveHSx_gTbkSYPLuvFJqFE>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 8 Aug 2026 01:30:16 -0400 (EDT)
Date: Sat, 08 Aug 2026 14:30:13 +0900 (JST)
Message-Id: <20260808.143013.1251068388254615351.tomo@flapping.org>
To: miguel.ojeda.sandonis@gmail.com
Cc: tomo@flapping.org, ojeda@kernel.org, arnd@arndb.de, krzk@kernel.org,
 alexandre.belloni@bootlin.com, linusw@kernel.org, chenhuacai@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 rust-for-linux@vger.kernel.org, fustini@kernel.org,
 linux-arm-kernel@lists.infradead.org, soc@lists.linux.dev,
 kernel@xen0n.name, loongarch@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] rust: bug: fix `dead_code` warning in `warn_on!`
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <CANiq72n4=fz=JNKY0Jdm8BnLa=RmHB2B7s0bO47YTJ7hygqBZg@mail.gmail.com>
References: <20260807221429.155946-1-ojeda@kernel.org>
	<20260808.074341.1056015191905819805.tomo@flapping.org>
	<CANiq72n4=fz=JNKY0Jdm8BnLa=RmHB2B7s0bO47YTJ7hygqBZg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64

T24gU2F0LCA4IEF1ZyAyMDI2IDAxOjIxOjIzICswMjAwDQpNaWd1ZWwgT2plZGEgPG1pZ3VlbC5v
amVkYS5zYW5kb25pc0BnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9uIFNhdCwgQXVnIDgsIDIwMjYg
YXQgMTI6NDPigK9BTSBGVUpJVEEgVG9tb25vcmkgPHRvbW9AZmxhcHBpbmcub3JnPiB3cm90ZToN
Cj4+DQo+PiBJIHNlbnQgYSBmaXggZm9yIHRoaXMgYnVnIGEgZmV3IGRheXMgYWdvOg0KPj4NCj4+
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI2MDgwMTAyNDg0MS43ODY2NjQtMS10b21v
QGZsYXBwaW5nLm9yZy8NCj4gDQo+IEFoLCByaWdodCwgc29ycnkhIEkgYWxzbyBzYXcgYW5vdGhl
ciBvbmUgd2l0aCBgcnVzdHRlc3RgIGZvciBhcm02NCBhbmQNCj4gcmlzY3Y2NC4gRGlkIHlvdSBz
ZWUgdGhhdCBvbmU/IFdlIHByb2JhYmx5IG5lZWQgYSBgY2ZnKHRlc3RsaWIpYA0KPiBzcGxpdC4N
Cg0KSXMgdGhpcyB0aGUgb25lIHlvdSBzYXc/DQoNCmVycm9yOiBpbnZhbGlkIGluc3RydWN0aW9u
IG1uZW1vbmljICdicmsnDQogIC0tPiBydXN0L2tlcm5lbC9idWcucnM6NjM6MTcNCiAgIHwNCjYz
IHwgLyAgICAgICAgICAgICAgICAgY29uY2F0ISgNCjY0IHwgfCAgICAgICAgICAgICAgICAgICAg
ICIvKiB7c2l6ZX0gKi8iLA0KNjUgfCB8ICAgICAgICAgICAgICAgICAgICAgaW5jbHVkZSEoY29u
Y2F0IShlbnYhKCJPQkpUUkVFIiksICIvcnVzdC9rZXJuZWwvZ2VuZXJhdGVkX2FyY2hfd2Fybl9h
c20ucnMiKSksDQo2NiB8IHwgICAgICAgICAgICAgICAgICAgICBpbmNsdWRlIShjb25jYXQhKGVu
diEoIk9CSlRSRUUiKSwgIi9ydXN0L2tlcm5lbC9nZW5lcmF0ZWRfYXJjaF9yZWFjaGFibGVfYXNt
LnJzIikpKTsNCiAgIHwgfF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19eDQogICB8DQpub3RlOiBpbnN0YW50aWF0ZWQgaW50byBhc3NlbWJseSBoZXJlDQogIC0t
PiA8aW5saW5lIGFzbT46MToxMTUNCiAgIHwNCiAxIHwgICAgIC8qIDggKi8ucHVzaHNlY3Rpb24g
X19idWdfdGFibGUsImF3IjsgLmFsaWduIDI7IDE0NDcwOiAubG9uZyAxNDQ3MWYgLSAuOy5zaG9y
dCAyMzA1Oy5hbGlnbiAyOyAucG9wc2VjdGlvbjsgMTQ0NzE6YnJrIDB4ODAwDQogICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF5e
Xg0KDQpJdCBzaG93cyB1cCB3aGVuIGBtYWtlIHJ1c3R0ZXN0YCBydW5zIHdpdGggYEFSQ0g9YCBz
ZXQgdG8gYW4NCmFyY2hpdGVjdHVyZSBvdGhlciB0aGFuIHRoZSBob3N0J3MuDQoNCkkgcG9zdGVk
IGEgYGNmZyh0ZXN0bGliKWAgc3BsaXQgZm9yIGl0Og0KDQpodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNjA4MDgwMjI2MDguMTEyNTE3NC0xLXRvbW9AZmxhcHBpbmcub3JnLw0KDQoNCldo
aWxlIGF0IGl0LCBhIHF1ZXN0aW9uOiB3aGF0IGlzIGBydXN0dGVzdGAgbWVhbnQgdG8gY292ZXIg
d2hlbg0KYEFSQ0g9YCBpcyBub3QgdGhlIGhvc3Qncz8NCg0K
