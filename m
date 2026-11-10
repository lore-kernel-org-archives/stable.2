Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279946;
	b=gylIjEyUGTk0wS8dm4hlEWUnW50A+ZkQobtByRA6U7/KPKylURPJ5BRkZpKEhmT68ALc
	 x4Q5tbWQaIXF0XPMk7T69bLXOdyDNZm+tK+xTlHjUoagR25r81cGT/8gviiLgGWlXOILT
	 WYeDnoC98c/9XL5RNaUrtcQ7QThHtoIb/v+HPF94IOfl8SboLDsjiDTjwnYcFM6XewuCt
	 PqxRDxfnwJR/vYi+S9WxZsvFAqzWe9YWNPR2R18DMAEYddkdfRu30b5/FDwNzAcphGDkL
	 lns0YMO4bm5pGO9t9xrLrm8G7xiD7ZYsDrlkLQY3+7tefI8DoYigGXqs5QUY+kVLKQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279946;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=q9XOYK7wX+00B6FBPgLD2vBKMAkmDiR49f/zui5qQz0=;
	b=3vDU9sKAApMvUPJsFGxZhvRJqniXZpLE2kfyKQP4C/rUjNXQ64zYiaWhbknYz9BLO2wj
	 vXYHmC2npZE8jmFlK4xXi/tz3KMGvdpBdlENqNAOLhyF/Xfk8rA9nhwlbibBWtrOYZvhq
	 60hRal3BncvIjE9UXucRnugO8EZkiIWscZqnEjIVPVP9w3mMhEaTKqL7f9txOGl0KyV/y
	 GeMFZBv/jXqoUlpLd/AZkZ7IjQfXrN/KiUzqZS0s7IUpKqsdjolg5c9AOE10JrtcwwoSC
	 7EoOT6Vb4mYxthc2R4WWN3A7msNtXpKNXfxkBJ5ufHK88gSJhRqg3ts1Qyq7JVVwOPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fZUfxXVy;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63EB606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63EB606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fZUfxXVy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794279939; bh=q9XOYK7wX+00B6FBPgLD2vBKMAkmDiR49f/zui5qQz0=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=fZUfxXVyc6DAD15Sv5X4swqN9j/GmjL8dRnoagW1DhD+O/L6QRUMlsggANFnRQ0Bj
	 D5veAtp3I1xww6mVMV1Tr+z5flqP62yg5Y/LzHau/FXDztMX9+63fkAMDnicnryiiA
	 RfwgTnlQNClTOqf3FGIO1LhVf7JathlzAxx97xHI=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: MzHbHz6ky8ylxXRwvpD01xe5vfDxiM5d4sy1mzo5PARKG0efZTjt8CVhuRmRZB
	 X916dvvbNf6mSP72RiWNcNkqCoNPOcxgBWOr5TCZcXnrUl9jCXlBL7sN0QJ4T5Y3UdWVhkCbnXnpG
	 vdp9c5eNmkQygDx70y3v0fP7PLOER3IGW5zxJhXPUmUgyxGfqZwX2rtwe3Jtn8xzOde1dGcyuBCqu
	 B3CmRyVm7R4LWQcm8jyBLfeacUa7dugB4ZvW+mqQuK17Ml+y8ub7YPpJctk25Nys2Mvv769EMSsdn
	 gyFpV4NtYY5QzHMlFVwUMf61TfKrDif+QvN+eKFykf8fTRr4P6tUAMX8EjrmxtXe08M0wJY2zcUsV
	 ZCbbeAv7i2dpy57uuj5FAmeBEfOhOs1aeSEH0H8cMnzrL5dxPYAS/1QrmLQ0Tnz/MFmRldWYiA+AG
	 caiEA5CJiQ34zO8hIgYLPotpS0901vK+WlSahYTacdWKy7Xxs8wr9JFeu4ioN5jSZWUXuuGtEd6Cl
	 CCMNpacI0piTaP6oj8dLwYr0Q9s2ZbZuL8q0lDeZOUh53rJLmlKt00fsxUCrOkTvd3utbbRA09EXR
	 q22YlOFFUVDNvtHFy0LzEi6f3c9jZsOK34FYUDLWr2avoGfnlcSFvpxriZBvxtK3CsV2toP3ohc8y
	 NMr0xO1FEC1hRQsL77+9TGn1IKzFmrjJJbkuQS4DIcFfsC5fXcYtBCnC/y355xwQqk95Ic+wvYhYN
	 as5k0cJeG2my4Jt7nJ6eEx/rYbxpgRw5gK4DODp4ef2+JhCC1cgOW3at0NnbaX0f450vYnOJHZEBU
	 HRoPJhcnehr04GJlF3dwm1u3UCTrR3iDsI5b57xBHS3Aw+ZocdVTg9dcE/M2hyvEV8Hc9ZGCS1eXg
	 onxDMmUiVaEXvBtajFT5QG0P+nx0d2HHMnE7cURCbigcGOWiCt1GLo+jsbEua2PJZlr7qnaVKSEbf
	 1i9qJJwVhsoLAP1jhHQzWj1nNX9WYsvWLk6T5wFS+mI9dsL6xI77tQvxdJFZ1pPERKAYtrirzDYJO
	 fpiPE+5B/T4uxxl4WF2yiIWequDXJkDxKHdZr
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?SmFrdWIgS2ljaW5za2k=?=" <kuba@kernel.org>
Cc: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?T2xpdmVyIEhhcnRrb3Bw?=" <socketcan@hartkopp.net>, "=?utf-8?B?RGF2aWQgUy4gTWlsbGVy?=" <davem@davemloft.net>, "=?utf-8?B?RXJpYyBEdW1hemV0?=" <edumazet@kernel.org>, "=?utf-8?B?UGFvbG8gQWJlbmk=?=" <pabeni@redhat.com>, "=?utf-8?B?U2ltb24gSG9ybWFu?=" <horms@kernel.org>, "=?utf-8?B?Sm9uYXRoYW4gQ29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?U2h1YWggS2hhbg==?=" <skhan@linuxfoundation.org>, "=?utf-8?B?UmFuZHkgRHVubGFw?=" <rdunlap@infradead.org>, "=?utf-8?B?V29sZmdhbmcgR3JhbmRlZ2dlcg==?=" <wg@grandegger.com>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, 
	"=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v8 00/10] can: fix Rockchip TX stalls and bus-off restart/close races
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
Date: Tue, 10 Nov 2026 11:05:37 +0800
X-Priority: 3
Message-ID: <tencent_F59D327809C523BE014488357EEF4D163408@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261108-rockchip-canfd-restart-close-v8-0-3e7a23fd9eae@qq.com>
	<20261109112402.283c16a3@kernel.org>
In-Reply-To: <20261109112402.283c16a3@kernel.org>
X-QQ-mid: xmsezb41-0t1794279937tom1cqfol

SGksCgo+ID7CoFN1YmplY3Q6wqBbUEFUQ0jCoG5ldMKgdjjCoDAwLzEwXcKgY2FuOsKgZml4
wqBSb2NrY2hpcMKgVFjCoHN0YWxsc8KgYW5kwqBidXMtb2ZmwqByZXN0YXJ0L2Nsb3NlwqBy
YWNlcwo+Cj4gcGxlYXNlwqB1c2XCoGdldF9tYWludGFpbmVyLnBsLMKgZG/CoG5vdMKgQ0PC
oG5ldGRldsKgb27CoENBTsKgcGF0Y2hlc8KgZGlyZWN0bHkuCgpJIHVzZWQgYjQgcHJlcCAt
LWF1dG8tdG8tY2MsIHdoaWNoIGludm9rZXMgZ2V0X21haW50YWluZXIucGwuClRoZSBzZXJp
ZXMgbW9kaWZpZXMgRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL2Nhbi5yc3QsIHdoaWNoIG1h
dGNoZXMKRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nLyB1bmRlciBORVRXT1JLSU5HIFtHRU5F
UkFMXSBhbmQgaXMgbm90CmV4Y2x1ZGVkIHRoZXJlLCBzbyBuZXRkZXZAdmdlci5rZXJuZWwu
b3JnIHdhcyBhZGRlZCBhdXRvbWF0aWNhbGx5LgoKSSB3aWxsIG1hbnVhbGx5IHJlbW92ZSBu
ZXRkZXZAdmdlci5rZXJuZWwub3JnIGZyb20gQ2MgZm9yIHRoZSBuZXh0CnJldmlzaW9uLgoK
QmVzdCByZWdhcmRzLApDdW5oYW8gTHUK

