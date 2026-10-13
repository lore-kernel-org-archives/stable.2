Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745344B44A1;
	Tue, 13 Oct 2026 06:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791873641; cv=none; b=saDmhJpEpbS5lnwKt8N+Qw8FpF9OXFzuN4F8Mycic3Dx77IszJLWT+VWVVSMv77TDva5DZt5TQnZDSX+45dLav1ALY1vCdRL2f4w5Z8EGsu7Pbb50EMofQMdZKD/R4R8AX9Ozicfx3kDFtrAcxApCssUuRgCagjXK5janto6KcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791873641; c=relaxed/simple;
	bh=pufvseFPv7SRb1Qgh0FRdHx2ORcY7iConWw/5V0rGEY=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=UgtCowfO2se1+Zj1fJaQfKP+R6yfBHMNy1k8Lj79GD5vuQqt+7wrQ3vi/VrmWTDTzzN00Zc76nJxY+DcGITPIqfI4chAVkJAWNuA4LCK+JuabuWZ5Y3tv3zgEYIF6I4mwd2pvgI7tFUMEWjq4sXaIe7Meqo0Rakx0eU2AJhYEAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=e7VHHeWG; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="e7VHHeWG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1791873627; bh=pufvseFPv7SRb1Qgh0FRdHx2ORcY7iConWw/5V0rGEY=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=e7VHHeWG3aMNrya1UBYpPqDoDx5rlu/7bUGe11vDG8RnhwO00wWNE7BHSOxvDHELf
	 8zoN+VhL9kKbnKowFIzXZPfOJO2Rfp0Wwkf72Tc1i0+c1B6IXrRyjj5X8D/xR88AXF
	 67le0VRvOwuX/xRjzRrftiFz8rYO4+ON/IFJKTM4=
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-XMAILINFO: Nyxko0BhXiLd41+Tw1uOs1BrxflslPSuTweuL7/54vmiFn65mefZgLh3iJk0vk
	 4PgO9c7OYsrvouL0DCf7NvL0FnAY1OugU9nc6oG1RSyVaQQYnCbDrjfRHwkNaMNwbIitX/KFUy0+b
	 vQZQEvC9TWG8cgMZqG6mo1KO3ImT+3q0JS4SIu6dhSE8H/PLXFFCNrCXjwDh38Rxir59UvwkHy/Ob
	 1iFyXxvqEqq3s9i0cflrbzPIhUCm5/QYeulrMjW/hyDYVYVlu4QuiWvY+LAtvKF2oB97KiVh7HdBu
	 vZYjICUlz+tec5u7Wm8oE0zBT5+4dEiJnfFN8fdDoL8Kp+6zqKWsr5OWBvayO3zRuKbnilymr0X9+
	 xbpw5PFHXVm5skbrwRF9he+Tmdl3o3hzPs0LJQD+FA6+P5FJADNnnWYxmwRowiKsOyHgPW2Ftj2zQ
	 o2RN9WT5ojU/sGWyI7M3WJ0kzOI0mEcq9Drcm9U7TQRNcoqKasP0kQtcs5XPmNpdwK1WAUsarwi9W
	 zsnQRsoUfEJsZTqM0AanWJ9bPGROJoMmLEkQLL7cTYMtuJXJABZRpo7PwhIY4wh53oVvCpq0lQUrC
	 vbPeLrlSwarpLSTg96Kc56cvPLOceAxLOnodo5MUbFoi1VlVs1rf0ghnBA9ibEYUo/ylziOwcEzE7
	 3yEFl0D2/JFbyCIVTbbb0BeeK6yl0J/bnAlYgPQ5S+VrFOdaKNlFHyVtPvOvx1/5oUoUxZOyJ7gOW
	 8JyAqmHv5yGQsfj929TBRyq5YTiq1FOVLRenMVOR0HopbLAevLLJ0vc/GDghICuUdy8gHOn+kLSGz
	 qeCoFzd3q3j4yxVeE3qZmNeAt54uBU7OwwCIHw4Y6WLptPnCyQnXSJlTx3ALHwRjz+AGAUBd0Yylt
	 vubGXg02JvAnJQ+b8ICAbaYgerS26pq3G2qBq5sPW9ENd2UgJPiMk6DP3gzw1M71fuKt7O9y1EmSC
	 qGnRHrpLMCXRzGOrlHhkVmPu9BcJt2SZGhJI0X1d/bxPOW5CYLMJ52pk7E4qhYn/GxWpW4w48fn3L
	 TWWUM34sJbtpv70o1MwxLQp1aZ4NEAQy8ffHfQhGRThZ+kMlq/n0+RP8YyRwW//3XNWNTNXyt1WHe
	 1qQwGqRGK3v0nA==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzaW5mbw==?=" <netdev-bot+sinfo@kernel.org>
Cc: "=?utf-8?B?TWFyYyBLbGVpbmUtQnVkZGU=?=" <mkl@pengutronix.de>, "=?utf-8?B?VmluY2VudCBNYWlsaG9s?=" <mailhol@kernel.org>, "=?utf-8?B?U2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg==?=" <bigeasy@linutronix.de>, "=?utf-8?B?Q2xhcmsgV2lsbGlhbXM=?=" <clrkwllms@kernel.org>, "=?utf-8?B?U3RldmVuIFJvc3RlZHQ=?=" <rostedt@goodmis.org>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?SGVpa28gU3R1ZWJuZXI=?=" <heiko@sntech.de>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net] can: rockchip_canfd: stop bus-off restart before closing the device
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Tue, 13 Oct 2026 14:39:15 +0800
X-Priority: 3
Message-ID: <tencent_1385D030CB2025348D8C05842272FB01350A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <tencent_5802EE88434010229EDF7A53084D994C6106@qq.com>
	<179186216396.2527009.17545175870858054500@kernel.org>
In-Reply-To: <179186216396.2527009.17545175870858054500@kernel.org>
X-QQ-mid: xmsezb41-0t1791873555t7ffge0n2

SGksCgo+ICAtIEhvdyB0aGUgaXNzdWUgd2FzIGRpc2NvdmVyZWQsIGUuZy4gaGl0IGluIHBy
b2R1Y3Rpb24sIGhpdCBkdXJpbmcKPiAgICBkZXZlbG9wbWVudCwgc3l6Ym90IHJlcG9ydCwg
bWFudWFsIGNvZGUgaW5zcGVjdGlvbiwgTExNIG9yIHN0YXRpYwo+ICAgIGFuYWx5c2lzIHRv
b2wgc2Nhbi4KClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuIFRoaXMgd29yayBzdGFy
dGVkIHdpdGggYSByZWFsIGZhaWx1cmUgb24gYQpwcm9kdWN0aW9uIHJvYm90LCByYXRoZXIg
dGhhbiBhIGdlbmVyYWwgc2NhbiBmb3IgcG90ZW50aWFsIGRyaXZlciBidWdzLgoKVGhlIHBy
b2R1Y3Rpb24gc3lzdGVtIHVzZWQgYSBMdWJhbkNhdC01SU8gd2l0aCBhbiBSSzM1ODgsIHJ1
bm5pbmcgYQo2LjE4LjU1LWN1cnJlbnQtcm9ja2NoaXA2NCBQUkVFTVBUX1JUIGtlcm5lbCB3
aXRoIGxvY2FsIENBTiBwYXRjaGVzLiBJdHMKMSBNYml0L3MgQ0FOIGJ1cyBjb25uZWN0ZWQg
Zm91ciBDQU5vcGVuIG1vdG9ycyBvcGVyYXRpbmcgYXQgMTAwIEh6IGFuZApmb3VyIHNlbnNv
cnMgb3BlcmF0aW5nIGF0IDIwIEh6LgoKPiAgLSBXaGV0aGVyIHRoZSBpc3N1ZSB3YXMgYWN0
dWFsbHkgdHJpZ2dlcmVkLCBvciBpcyBvbmx5IHRoZW9yZXRpY2FsCj4gICAgKGUuZy4gZm91
bmQgYnkgY29kZSBpbnNwZWN0aW9uKS4gSWYgaXQgd2FzIHRyaWdnZXJlZCBwbGVhc2UgaW5j
bHVkZQo+ICAgIHRoZSBzeW1wdG9tcywgbGlrZSB0aGUgc3RhY2sgdHJhY2Ugb3IgZXJyb3Ig
bWVzc2FnZXMuCgpUaGUgb2JzZXJ2ZWQgZmFpbHVyZSB3YXMgYSBwZXJzaXN0ZW50IFRYIHN0
YWxsOiBSWCBjb250aW51ZWQsIGJ1dCB0aGUgVFgKcXVldWUgcmVtYWluZWQgc3RvcHBlZCBh
bmQgc3Vic2VxdWVudCBzZW5kcyByZXR1cm5lZCBFTk9CVUZTLiBUaGUKaW50ZXJmYWNlIHN0
aWxsIHJlcG9ydGVkIEVSUk9SLUFDVElWRSwgYW5kIHRoZSBoYXJkd2FyZSBpbmRpY2F0ZWQg
bmVpdGhlcgphIGJ1cy1vZmYgY29uZGl0aW9uIG5vciBhIHBlbmRpbmcgVFggcmVxdWVzdC4K
Ckkgd2lsbCBzdWJtaXQgdHdvIHBhdGNoZXMgZm9yIHRoaXMgaXNzdWU7IHRoaXMgaXMgdGhl
IGZpcnN0IG9uZS4KClRoaXMgcGF0Y2ggaXMgbm90IGEgZGlyZWN0IGZpeCBmb3IgdGhhdCBm
YWlsdXJlLiBJdCBmaXhlcyBhIHJhY2UKdGhhdCB3YXMgYWxyZWFkeSBwcmVzZW50IGluIHRo
ZSBkcml2ZXIgYW5kIHRoYXQgSSBmb3VuZCBkdXJpbmcKZmF1bHQtaW5qZWN0aW9uIHRlc3Rp
bmcgb2YgdGhlIGVjaG8tbG9zcyBmaXg6IGNsb3NlX2NhbmRldigpIGNhbmNlbHMKcmVzdGFy
dF93b3JrIG9ubHkgYWZ0ZXIgdGhlIElSUSBoYXMgYmVlbiBmcmVlZCBhbmQgdGhlIGNvbnRy
b2xsZXIgaGFzCmJlZW4gc3RvcHBlZCwgc28gYSBxdWV1ZWQgYnVzLW9mZiByZXN0YXJ0IGNh
biByZS1lbmFibGUgdGhlIGNvbnRyb2xsZXIKYW5kIGl0cyBpbnRlcnJ1cHRzIGFmdGVyIElS
USB0ZWFyZG93biwgYW5kIGNhbiByZXF1ZXVlIHRpbWVzdGFtcCB3b3JrCnRoYXQgbWF5IGxh
dGVyIGFjY2VzcyByZWdpc3RlcnMgYWZ0ZXIgcnVudGltZSBzdXNwZW5kIGhhcyBkaXNhYmxl
ZCB0aGUKY2xvY2tzLiBUaGUgc2Vjb25kIHBhdGNoIGJ1aWxkcyBvbiB0aGlzIHNlcmlhbGl6
YXRpb24gYW5kIGFkZHJlc3NlcyB0aGUKZWNoby1sb3NzIHN0YWxsIGl0c2VsZi4KClJlZ2Fy
ZHMsCkN1bmhhbyBMdQo=

