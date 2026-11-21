Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795247378;
	b=kilKKHiKdm+O/8E4nYDEXSDhM5SmZE/GyeKiSTHMatpUNs1TvYHI/5e3Fb+7Y4NHjxiN
	 XoVkWkNqSUu6diuLnt21Xj61svbq4trYuIsXkV5bSdScekvHQQQj515ur1p1i1HrLBhvk
	 i6vGhGu84PP2mamQdhH0czsxFAj3iTwuRAmwDZeJ6d4btXwcLAGtFVspExyzMjRz5oaMH
	 4EyLjG6ZPlGSv9+JYDl5RyY4NBbRyJ3x/X0qPKpYL054VxMqO2I6FOaEOYvFatLGD465H
	 BWueXAf2RAC8Lq5KFWUg0nLAEYeeCbsaSSUx5zUAeO9ORhfW/eMxwm/hSd2LGPrOr8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795247378;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=iLcinoRHQQpGqpB7RbYpvqsBws/0VYTm7Rl5LRYYZVQ=;
	b=CwQS38bORKysxliczIhdM300BF1SCz5uaypXKd0cvrZFPKVibQMWDciHXsLEMSLqOj0N
	 H4FbcH0JCramvFILApiXFWr/GVhD2pi+X0T+YSr64jAZQURTiUbo/bo+JfCTaLPPW+1Wb
	 8AnfabTRWks7XsbiFr6UP9uMVCo/FpEwQog5zg9fr4WAGYAqH9r4wVAtxJ3vHXBW6BioE
	 WS58I+Zk1Mc4jv2cNj++9bhB3H5bYTrdqsS4SPIbU/xw5UP+A5zOXlWN58tFgUwVHiATS
	 1en7E2BFG9V/GnzPHVz24e6AtAAyoJ1X2RhO+OIUpjeIT59V030cmphwt6CMR3ccAZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fbbvA+FR;
	arc=none smtp.remote-ip=203.205.221.231
Received: from out203-205-221-231.mail.qq.com (out203-205-221-231.mail.qq.com [203.205.221.231])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC9606A320
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 07:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8AC9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fbbvA+FR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795247375; bh=iLcinoRHQQpGqpB7RbYpvqsBws/0VYTm7Rl5LRYYZVQ=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=fbbvA+FRNXczTapsO3RJdGTVycvvhiEsNQO3CDNr0I9GyRwaFRBimhWHFTFSb4Qjl
	 c6wHnNaEY3mEI1njqjdpC9pzh4kXve3B9W+9uc0GTIvesh942rT45U84CykkMsXEiC
	 jwInIqL8yMT76YcwAB+6H2TCn5c33Hemj9FfTgQE=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: NMF8M2bwIxE1fM67/ApOI8rE5vkr2L5vHqFC/04+JAPMM4YLpcaV8NR3cl1J1S
	 HfGJ+fYkalur0uwkQ2/TRQTrLI6S2Z/YK8Vo5B9LQHC1Qjvfr5fwQ7JWuh2ksqPKPczWGQAY+einR
	 Qcjnksa48T1U1h9meYFjeB0cyCdEP4FsfB15Qa/gldIGhYLnnMXqQOIWiBT49wvVRiFAn3ts9WYT7
	 q6y7SWmTisRBcRkbGsXc3Z1yz5i1cx5B8SqFYeFGDiTGboZ5IC3PvJw2zIj6IZ80XUdHnK3vkh5cs
	 9gel50hfITLldq9sqzhPog574DrLaC45ry+B7GU+50lVSWsKM2eawS3uW3OY09KP0u4c7Q9b+Yhbr
	 yJrOULAbiIxy3Tnj/pDGfUAB1k6Q/TfK6WDFkT4/u2Veicab/hT4amFf0/+BWrdpKV2SzeqNfJJZB
	 mDFbGN/GLRhJ38fWbeV8FqCaLTdezHVVr/8JXrqgEef8IisOiMmgmtNK/UhkXK5VmQiOFAs7Hdg62
	 QW2alhgpCgWnjA8HR3GmgJ7oWNM6kUn3cRSOHbtKVKbaWx+fVTSe0z2IdDG5ldgSeL5SIekSQVkoo
	 NvWQKRsHc+fDqOCmIUkYlzNYxAJQJhC/wYrvRoYI+WIH1KGEUqMvm0OYZ5GlQylComEpM0oe7nVY0
	 emJ/36OhQeKv7GesVWDdss+7m7/h7qx9HjSBz2NaJxnasWvL1bCRBvmCVXElGOD1iueNVSqN6FCpe
	 SPbHwTHj9mwsr6om+/K3cPCum93zLiX2Zpl+m9v0g1MBBD42aWk7u5RCVg483prFuvrD+WC78c7rp
	 vO4WQjoaL2MXLxdH6UXs32EpgC35wHCyY2B2Pe9EJL8eIuIuvNkheHtlMMr1619GqVTeKbp0LPrm1
	 XEcYMK+SQXuFZI1/Us7NMfUsG1EGapRMUpuHRCrWSXHUEjCyH92yKtJpGK9MA0md9xaHpXKqfUg7u
	 3OmWxI1dhRvAN+CRENAj4i4rG0uEDgr9xCd/APX6jNpwV5lF1eCjl2kn/wUQnohGfKUV4UaZwSAz6
	 bxuMp/fQQXA4kZLkDztpQvgrSa68tjuzupvgT+yqmBaBgK5dQdy8NZx0osqk76DEwKsM6harlYSDw
	 dOvxZQXHPYO+Ow==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?Y29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?c2toYW4=?=" <skhan@linuxfoundation.org>, "=?utf-8?B?cmR1bmxhcA==?=" <rdunlap@infradead.org>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, 
	"=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v10 08/10] can: rockchip_canfd: retry the outstanding TX buffer
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
Date: Sat, 21 Nov 2026 15:49:32 +0800
X-Priority: 3
Message-ID: <tencent_C2353675D108CA2C26008C5405302266F80A@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261119-rockchip-canfd-restart-close-v10-8-df23913aa33a@qq.com>
	<179521934391.3131.16575184154447420964@kernel.org>
In-Reply-To: <179521934391.3131.16575184154447420964@kernel.org>
X-QQ-mid: xmsezb41-0t1795247372t59iwxlbh

SGksCgo+IFtTZXZlcml0eTogTG93XQo+IElzIHRoZXJlIGEgbGltaXQgb24gaG93IG1hbnkg
dGltZXMgdGhpcyByZS1hcm1zPwo+IAo+IHJrY2FuZmRfY2hpcF9zdGFydCgpIGVuYWJsZXMg
UktDQU5GRF9SRUdfTU9ERV9BVVRPX1JFVFhfTU9ERS4gSWYgdGhlCj4gcmV0cmllZCBmcmFt
ZSBuZXZlciBnZXRzIGFuIEFDSyAoZm9yIGV4YW1wbGUgdGhlIGJ1cyBpcyB1bnBsdWdnZWQg
b3IgdGhlCj4gb25seSBvdGhlciBub2RlIGdvZXMgc2lsZW50KSwgdGhlIGNvbnRyb2xsZXIg
a2VlcHMgcmV0cmFuc21pdHRpbmcgYW5kCj4gVFhfUkVRIHN0YXlzIHNldC4KPiAKPiBVbmRl
ciB0aGUgSVNPIDExODk4LTEgZmF1bHQgY29uZmluZW1lbnQgZXhjZXB0aW9uLCBhbiBlcnJv
ci1wYXNzaXZlCj4gdHJhbnNtaXR0ZXIgdGhhdCBzZWVzIG9ubHkgQUNLIGVycm9ycyBkb2Vz
IG5vdCBpbmNyZWFzZSBURUMuIEJ1cy1vZmYgaXMKPiBuZXZlciByZWFjaGVkLCBzbyBya2Nh
bmZkX3R4X2Rpc2FibGUoKS0+cmtjYW5mZF90eF9yZXRyeV9zdG9wKCkgbmV2ZXIKPiBydW5z
Lgo+IAo+IFdvdWxkbid0IHRoaXMgd29ya2VyIHRoZW4gdGFrZSB0eF9sb2NrIGFuZCByZWFk
IFJLQ0FORkRfUkVHX0NNRCBvbmNlIHBlcgo+IGppZmZ5IHVudGlsIHRoZSBpbnRlcmZhY2Ug
aXMgY2xvc2VkIG9yIHJlc3RhcnRlZD8gQW4gdW4tQUNLZWQgZnJhbWUgYWxzbwo+IHN0YWxs
ZWQgVFggYmVmb3JlIHRoaXMgcGF0Y2gsIGJ1dCB0aGUgcGVyLWppZmZ5IHBvbGxpbmcgd2l0
aCBubyBsaW1pdCBpcwo+IG5ldy4KPiAKPiBJbiB0aGUgc3B1cmlvdXMgbWF0Y2ggY2FzZSB0
aGUgc3R1Y2sgcmVxdWVzdCBpcyB0aGUgdW50cmFja2VkIGR1cGxpY2F0ZS4KPiBUaGUgcXVl
dWUgdGhlbiBzdGF5cyBzdG9wcGVkIGV2ZW4gdGhvdWdoIHR4X3BlbmRpbmcgaXMgMC4KCk5v
LiBBIG1pc3NpbmcgQUNLIGFsb25lIGRvZXMgbm90IHN0YXJ0IHRoZSB3b3JrZXIuIFRoZSBk
cml2ZXIgbXVzdCBmaXJzdAppc3N1ZSBhIHNvZnR3YXJlIHJldHJ5IGZvciBlcnJhdHVtIDYu
IEVpdGhlciBUWDBfUkVRIG9yIFRYMV9SRVEgbXVzdAp0aGVuIHN0YXkgc2V0LCBhbmQgdGhl
IGludGVyZmFjZSBtdXN0IHJlbWFpbiB1cCB3aXRob3V0IHRoZSBjb250cm9sbGVyCmdvaW5n
IGJ1cy1vZmYuIFByb2xvbmdlZCBwb2xsaW5nIHJlcXVpcmVzIGFsbCBvZiB0aG9zZSBjb25k
aXRpb25zLgoKSSB0ZXN0ZWQgdGhpcyBvbiBSSzM1ODguIFRoZSBmaXJzdCB0aW1lIHRoZSB3
b3JrZXIgdG9vayB0aGUgYnVzeSBwYXRoLApUWDBfUkVRIHdhcyBzdGlsbCBzZXQsIHNvIGl0
IHNjaGVkdWxlZCBhbm90aGVyIHBvbGwuIEJ5IHRoZSBuZXh0IHBvbGwsCmJvdGggVFgwX1JF
USBhbmQgVFgxX1JFUSB3ZXJlIGNsZWFyLiBJIHN1c3BlY3QgdGhlCnByb2xvbmdlZCBwb2xs
aW5nIHlvdSBkZXNjcmliZSBtYXkgbmV2ZXIgb2NjdXIgaW4gcHJhY3RpY2UsIGFsdGhvdWdo
CnRoaXMgdGVzdCBhbG9uZSBjYW5ub3QgZXN0YWJsaXNoIHRoYXQuCgo+IFtTZXZlcml0eTog
TWVkaXVtXQo+IAo+IElzIGl0IHNhZmUgdG8gcmVsZWFzZSB0aGUgZ3VhcmQgYXMgc29vbiBh
cyBib3RoIFRYX1JFUSBiaXRzIHJlYWQgY2xlYXI/Cj4gCj4gcmtjYW5mZF94bWl0X3JldHJ5
KCkgc3RhcnRzIGEgc2Vjb25kIGhhcmR3YXJlIHRyYW5zbWlzc2lvbiBvZiB0aGUgZnJhbWUg
YXQKPiB0eF90YWlsLCBidXQgaXQgY3JlYXRlcyBubyBlY2hvX3NrYiBzbG90IG9yIHBlbmRp
bmcgY291bnQgZm9yIGl0LiBDbGVhcgo+IFRYX1JFUSBiaXRzIG9ubHkgbWVhbiB0aGUgaGFy
ZHdhcmUgZmluaXNoZWQgc2VuZGluZy4gVGhlIFJYU1RYCj4gc2VsZi1yZWNlcHRpb24gb2Yg
dGhlIHJldHJpZWQgY29weSBtYXkgc3RpbGwgYmUgaW4gdGhlIFJYIEZJRk8uCj4gCj4gVGFr
ZSB0aGUgb3JkZXJpbmcgdGhlIGNvbW1pdCBtZXNzYWdlIGRlc2NyaWJlcywgd2hlcmUgdGhl
IG9yaWdpbmFsIHJlcXVlc3QKPiBoYXMgYWxyZWFkeSBjb21wbGV0ZWQgd2hlbiB0aGUgbWF0
Y2hpbmcgc3RhbmRhcmQgZnJhbWUgaXMgcHJvY2Vzc2VkOgo+IAo+IDEuIFN0YW5kYXJkIGZy
YW1lIFMgbWF0Y2hlcyBwZW5kaW5nIEVGRiBmcmFtZSBCIGF0IHR4X3RhaWwuCj4gICAgcmtj
YW5mZF9yeHN0eF9maWx0ZXIoKSBjYWxscyBya2NhbmZkX3htaXRfcmV0cnkoKSwgYW5kIEIg
aXMgc2VudCBhZ2Fpbi4KPiAKPiAyLiBCJ3Mgb3JpZ2luYWwgZWNobywgc3RpbGwgaW4gdGhl
IFJYIEZJRk8sIG1hdGNoZXMgZWNob19za2JbdHhfdGFpbF0uCj4gICAgdHhfdGFpbCBhZHZh
bmNlcyBhbmQgdHhfcGVuZGluZyBiZWNvbWVzIDAuCj4gCj4gMy4gVGhlIHJldHJ5IGZpbmlz
aGVzLiBUaGlzIHdvcmtlciBzZWVzIFRYX1JFUSBjbGVhciwKPiAgICBya2NhbmZkX2dldF9l
ZmZlY3RpdmVfdHhfZnJlZSgpIHJldHVybnMgMiwgYW5kIHRoZSBxdWV1ZSBpcyB3b2tlbi4K
PiAKPiBbLi4uXQo+IAo+IFNob3VsZCB0aGUgZWNobyBvZiB0aGUgcmV0cnkgYmUgYWNjb3Vu
dGVkIGZvcj8gSWYgbm90LCBjb3VsZCB0aGUgY29tbWl0Cj4gbWVzc2FnZSBhbHNvIG1lbnRp
b24gdGhlIGxvY2FsIHBoYW50b20gUlggYW5kIHRoZSBtaXNhdHRyaWJ1dGVkCj4gY29tcGxl
dGlvbj8KClRoZSBkcml2ZXIgYWxyZWFkeSByZXRyaWVzIHRoZSBmcmFtZSB3aXRob3V0IGFs
bG9jYXRpbmcgYSBzZWNvbmQgZWNobwpzbG90LiBPbmNlIHRoZSBvcmlnaW5hbCBlY2hvIGhh
cyBiZWVuIGNvbnN1bWVkLCB0aGUgcmV0cnkgZWNobyBjYW4gYmUKZGVsaXZlcmVkIGFzIG9y
ZGluYXJ5IFJYIG9yIG1pc3Rha2VuIGZvciB0aGUgY29tcGxldGlvbiBvZiBhbiBpZGVudGlj
YWwKc3VjY2Vzc29yLiBUaGlzIHByZWRhdGVzIHRoZSBwYXRjaC4gVGhlIGd1YXJkIGtlZXBz
IG5ldyBzdWJtaXNzaW9ucyBmcm9tCm92ZXJ3cml0aW5nIHRoZSBUWCByZWdpc3RlcnMgd2hp
bGUgdGhlIHJldHJ5IGlzIGFjdGl2ZS4gSXQgZG9lcyBub3QKaWRlbnRpZnkgdGhlIHJldHJ5
IGVjaG8sIGFuZCBJIGRvIG5vdCBjdXJyZW50bHkgcGxhbiB0byBmaXggdGhpcyBpc3N1ZQpp
biB0aGlzIHBhdGNoLgoKQmVzdCByZWdhcmRzLApDdW5oYW8gTHUK

