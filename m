Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.192
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778744;
	b=wdOXsho8NaSV04PkhGA1Dp4MhXU7gs7CCkBBWgWuooO1IAnlawygux4diJ62l0F8DWq0
	 oiuR1YrqMmznnprCUbPielVO1eZXSCwvtG2/AQ8Gihvj+zHaIEDKhsA4TYSgFYQITCHBh
	 GGCyHweUdAWAgBRqIV6ZhiGucb+I5dPAbKe59E1heET/ALZdQxqR2Dwy12U9jDfRqBHwq
	 cZOHBKG1x8rLjVJ79xhx1XFdoUYrvjhD5ZsMhramSQ+OU6VAnBcuKrKdNm7T+I6v2c/OE
	 xeL8vnHXvCvRggD+zd/mbwxiTaXudKDWpla/Di8OJy2WamutLZiqNTLt8tSnrga1MgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778744;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=rr2v31AaKAWwYmMIc7r6Adi1RCicIPCQioImctiyPsI=;
	b=QXhDzccNag6piJIDX1j6mX9RxbQ/iklP0K9CytreHhfoDYbUn9mmg2Xsm5YmM+r27e1l
	 Y2GG1HhM7OvXzIMk2nhHqrMZ+5gz2/Ri++dIp/Az3SZ7JpgHInIfHbTOmklsDUWIhH2xP
	 EEehK5hwQObTNffv6FFM046KjYC4fU0hb3vj8WL5M3fWHyuu0RD93NMaPx0BU0MxuIh62
	 bUhz4zp9gq6vQwhlezKD+n88hT4Fa3PlgA3KDr70eCScORTWbQA7Auf62H+Lq2Bcgpajj
	 0uT319K7A2VhHM26g1cQJL/GViTr/SWnyUpFVoqlGDMMobJJzToKplGYbxgkONZZKxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=NlzusISO;
	arc=none smtp.remote-ip=203.205.221.192
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551FD606A328;
	Wed,  4 Nov 2026 07:52:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 551FD606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=NlzusISO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793778733; bh=rr2v31AaKAWwYmMIc7r6Adi1RCicIPCQioImctiyPsI=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=NlzusISOe4VyviO+Fh5QTwmSxrxrLtqdqrhxKfDnon8OW6c/9QNr1CsmyY0Wm+UTd
	 gGAWtRvvKlAotx/iLQNa2SKd37eyEVloK7J9f915e4ZGsBxXcOCCAVydkEwHfdfwpx
	 zqL+JPmAY4AiiYPQpJ5HgNkRKNkEkXhAKtYs6rYk=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-XMAILINFO: Ml3saj0rxilewwLbXqRKjCErbc4xuxuyWPmsVBMNNss3RQEAP6yAd1CEVl1F7O
	 bR6f/5s7YcgQ5cqBNSYf1rOOnHvXyA0G9/TQ/BMPQfStW+NFrSbzmfwfvKuW//fod4aP2qWJSQSqQ
	 ISA1O0h0AFCQPKed1baTxGlZn/ehdIr+NHT7tUX1ixp+aQh3sLxMql3MBxcSrVMo07XzOis8RlJiX
	 4ZKXHpFH6/tq9EdGDwAr9oig+AIVYrYtpWzwGOMuWH9tejSa0YS6rK9r/b5Wpl1j4q2aO2U4geLNO
	 9ASkPSkqQdE/IWsxC6BYW3rV9lIfoX3ZuFTXtU3Tfzs3CZnOJEHoJOjvepkFISq4xK2B2Cyvyu26q
	 N0aimYeyPjqHgQkZbWEqchA2ZmDYOF4zqxEGiq0eFXa1nFq8mq6RgcKgqb4W++Z+bvPme28MbMGrS
	 JE6TcVj9aFGxn0CQoYRR4pWvPcQ+GQDefvKgVeXpzMYqEWQmfx9lMgHakL2qzHq/Znxm7MQ8cJx/6
	 FvPiGPGKxNAbGECmXIe7QCvslhM3GRcpggmpRz0WAyM22nun9RjyeyhaOzm22xIFpKGYsuQ9VdZah
	 ykKVU5j/IDEa+OtNPQYyUxIJcsup1215kBJdSie8N6YOCUwrTSKfqd2Ybb2KSG48yp8103BHSiJpV
	 0IAsRLmsfsUD89xvymLhkytcYuESXI6AfIun8lesINyedj6JmQTZh+r5rYz1+D0zr2XcfMs6ME2GO
	 no8+dqg5LWThs5n7H7f+F7U7A9cBqMSPNVP7nC90/n5PIVyI6DTICU4VwNm2yn/ey08WGL1AYtGKQ
	 KsDZClpFqTfBKA8BDQ59dTiemuRiV+RhZL+yLvD7slOKZswJPE+aZl/ogYbNfYMJvhrWZlG0PG+Yy
	 NZmp/TJI5ZilR2HctJ1yJwb7/si/gvl8Q+mWBiyfCaNCs3hPSXouQ4feA+rV9XCJgnJD1+5VJIGUo
	 5Re2nEnuwlBFN9MWmJcbxUN8rhPoSibRgqHSnjuNphZWU3vIUnegbkPwXWqlkabnP+D+Pmu3Gdn0a
	 437bc
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?Y29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?c2toYW4=?=" <skhan@linuxfoundation.org>, "=?utf-8?B?cmR1bmxhcA==?=" <rdunlap@infradead.org>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, 
	"=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v6 1/6] can: dev: prevent bus-off recovery when the interface is not running
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Wed, 4 Nov 2026 15:52:11 +0800
X-Priority: 3
Message-ID: <tencent_CD800791DD8FA7E989A65526222168C42605@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261017-rockchip-canfd-restart-close-v6-1-ed605feb4b6e@qq.com>
	<179237863891.3135.16148468658160918424@kernel.org>
In-Reply-To: <179237863891.3135.16148468658160918424@kernel.org>
X-QQ-mid: xmsezb41-0t1793778731ti26akn17

SGksCgo+IERvZXMgdGhpcyBjaGVjayBhY3R1YWxseSBjbG9zZSB0aGUgd2luZG93IHRoZSBz
dWJqZWN0IGxpbmUgZGVzY3JpYmVzPwoKTm8uIFRoZSBjaGVja3MgcmVqZWN0IHJlY292ZXJ5
IHRoYXQgb2JzZXJ2ZXMgdGhlIGludGVyZmFjZSBkb3duLCBidXQgZG8Kbm90IHNlcmlhbGl6
ZSByZWNvdmVyeSB3aXRoIGNsb3NlLiBUaGUgRmxleENBTiB0ZWFyZG93biByYWNlIGFuZCB0
aGUKSEkzMTEwIHN0YWxlLXdvcmsgY2FzZSBhcmUgcmVhbCwgcHJlLWV4aXN0aW5nIGlzc3Vl
cy4gVGhpcyBwYXRjaCBuYXJyb3dzCnRoZWlyIGVudHJ5IHdpbmRvd3Mgd2l0aG91dCBjbG9z
aW5nIHRoZW0uIFJvY2tjaGlwJ3MgZWFybHkgY2FuY2VsbGF0aW9uCmFuZCBmaW5hbCBjYW5j
ZWxsYXRpb24gYWZ0ZXIgSVJRIHRlYXJkb3duIGRvIG5vdCBmaXggb3RoZXIgZHJpdmVycy4K
Cj4gQ2FuIHJlc3RhcnRfd29yayBzdGlsbCBiZSBxdWV1ZWQgYWZ0ZXIgY2xvc2VfY2FuZGV2
KCkgYW5kIHRoZW4KPiBvdXRsaXZlIHRoZSBuZXRfZGV2aWNlPwoKWWVzLiBISTMxMTAncyBJ
UlEgdGhyZWFkIGNhbiByZXRhaW4gYSB0cnVlIHJ1bm5pbmcgc25hcHNob3QgYWNyb3NzIHRo
ZQpjYW5jZWwsIHRoZW4gcXVldWUgdGhlIGNvcmUgd29yayBiZWZvcmUgZnJlZV9pcnEoKSBm
aW5pc2hlcy4gUmVtb3ZhbCBoYXMKbm8gbGF0ZXIgY2FuY2VsbGF0aW9uIG9mIHRoYXQgd29y
ay4gRGVzdHJveWluZyB0aGUgZHJpdmVyJ3MgcHJpdmF0ZQp3b3JrcXVldWUgZG9lcyBub3Qg
ZHJhaW4gdGhlIGNvcmUgcmVzdGFydCB3b3JrIG9uIHRoZSBzeXN0ZW0gd29ya3F1ZXVlLgpD
aGVja2luZyBuZXRpZl9ydW5uaW5nKCkgZnJvbSB0aGUgY2FsbGJhY2sgY2Fubm90IHByb3Rl
Y3QgZnJlZWQgbWVtb3J5LgoKQmVzdCByZWdhcmRzLApDdW5oYW8gTHU=

