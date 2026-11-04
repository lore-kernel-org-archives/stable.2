Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.58.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793779585;
	b=0k0YDWrovV2D4Cyps69d/DKheX+vCRzB2vT4zDKbhV7H43evgEARvazzV7l/koBKxzvF
	 16voVQqXrYaQvvA1tpxpVSoIX0X4we4A3vpr3fve5f+h9OPoNiskFFZ0VLPFIpO41m4Oe
	 r8jw5wpIr5cSk1bGDVEVi7qcPIjRiPj/VhBZwOEW1T2jhi1EDuArTCtViTRvgVWzDy0k/
	 ClhzQEJhN1okMsQyI1PJjqCNT6u8ISta64ic73hApQO4XyWWAODC9nDP1HiM5vitCBHON
	 RTqGC3uswetYhfoq585STlr+JiS5m4No2boVwbLKASgaGimud3vYf8wgE2ldkui0Cmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793779585;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=WgxEiGMcAXeHim/OCpv0zMeF0d48h/zJZ1XH8xX5r4w=;
	b=fW8KS9JDFNdGN4lxDNFmfL5FHEiYz7KsS8OFWlWj8jMHRnK9cz2Rz6TAbsYUxC7yJVDw
	 fsfPn9i1Cjq8ZiEyhTCideEQDEo28fRKHKRAu3c9X0gsQCFutBgvBe7uMoeo8UJJnSMWW
	 X6Mib0c2l3YQ/sBS8pn2g+aZgp9mqaRRn+9ZPMqh4fMfYZogtnGbMIcMHPmbju2F9FrGY
	 /KrVrZuRWVXach1OWRAnCDcI29XpsVGlUtFvNa1vvH0rBOTEd8UUetnAyOuK3+SIyOReU
	 /fbzAkGA9goxjfj37nciGGNjCzpuDdwGUb/r2HxdYqrYErBEdgEhWT9zPW4/AWtF+RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fOEj9ig5;
	arc=none smtp.remote-ip=162.62.58.216
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809B5606A334;
	Wed,  4 Nov 2026 08:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 809B5606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=fOEj9ig5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793779579; bh=WgxEiGMcAXeHim/OCpv0zMeF0d48h/zJZ1XH8xX5r4w=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=fOEj9ig5JXN09CLHqNfTNgbw330Bh/WIacL9+P9J5rKELZqrG/iX3nWAuCG41tSLn
	 3v2RfVVwIiWX9HMUBlu8oX6dbosXWswYQ2tpi76OJJHbKygZRed3lrS1MI5Ic3xMoR
	 7P5ESqp3MzxmK8aiNu8ZZuBBgwpvf5duWSzGefiE=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: Nze9Gsl2QAyr5RxeywbNGg6T5cysE3+3MmOq0TdLhgaEbwUJeN9vA51HWHzzUm
	 8+OJbKEXn/feXKvOo/2TOKWuMMaZCIRy0UWsahrowRynnMa1jlpI0vfs9ZOmuX96Xaup7yVWAnGAv
	 r6wM66C+1UYEho16kdBhDsLpHI+JddESc7SYXXmZFx+74oaXiw1W84KD1+73Doq2momM1ZyOLpLVm
	 fV1uRXtsx6533qpYQG0c/4T9nSYawztosAet8uI+nIP0baYUxMTrZM6eK6ENU6GbdUALaUjqa0nRi
	 JnOK5vl0RU0PdywsI/aetYv7E9OSBwmGX/iD5HmmDmiizWHdl/1TqbAd/oR/algyGG2OKdfBXDKKs
	 HYqgTOgGjUruMQ4c8dzbqe2eny2nQmPRQJzS/PZl+J8H0qcVkrNQTuWxK9xo6H+CFbLfKBVfUZYbr
	 YFzatZMYpuAeERkWN/EVm/6nx6H3BGOnp6RfaVyYhAG3R6IXVMAT0xrRZqUkHNvRb4f1imVoF9rs1
	 AgJ4Nim5PyXcsyshlnwttdra7XpG5Ls3uNC36X5MeDQ1quwW6q3FR7XldERP8bD0LnpebQ6n0k6ut
	 ckQyxhQSLVEBGkgDVS03MOpisqtOZEZUdkSTHf8r8nTSBNlw3vLQbj7qrPJUQH3T8fvb7f6ApkmI3
	 oKSY3zzZhEtVBvUu+4Z8tkOqR6AxKoiFdFU5fJKc6g3r9j8J9HxW4uw65lrmt1oX2qWz9vD1R4MQi
	 oGDAWCUPBoJDgw0g9uG7UTzINOwf29Qfz4hq2mV93CqttBx9jgEFeEU6VLR2o4ZoXtFvdhutAE9aM
	 6x7HpA6IltYkk0VpbHrv7WyxWvTIyjGN1CVBT1rfTLKTEZQdeSZWj+r2UrpU9TxRd7GvadgTmsEpb
	 gZhqcpqIdrU4vRN1thMDTweEEW5ZOrTmuoFywATQS6FxrleaLOG/Wpq6Ff2xANFsj9ceWelW2BxeQ
	 rtkA9lMeex1XHsrHi3eRcpdnX2oz4zD+rIDRa/nMGR4jboJp0+BFH+GoAmUjwEwcQlLuusR5xtYtb
	 JRCvoxORlO2iH+BN6Q7T2DXhPGw==
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?Y29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?c2toYW4=?=" <skhan@linuxfoundation.org>, "=?utf-8?B?cmR1bmxhcA==?=" <rdunlap@infradead.org>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, 
	"=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bmV0ZGV2?=" <netdev@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v6 3/6] can: rockchip_canfd: cancel bus-off restart before closing the device
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
Date: Wed, 4 Nov 2026 16:06:17 +0800
X-Priority: 3
Message-ID: <tencent_2E7A44783FBE26011A7319CF849111D78007@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261017-rockchip-canfd-restart-close-v6-3-ed605feb4b6e@qq.com>
	<179237864073.3135.8117104622491949177@kernel.org>
In-Reply-To: <179237864073.3135.8117104622491949177@kernel.org>
X-QQ-mid: xmsezb41-0t1793779577t7nbgj69z

SGksCgo+IElzIHJrY2FuZmRfc3RhcnRfeG1pdCgpIHNlcmlhbGl6ZWQgYWdhaW5zdCB0aGlz
IHJlaW5pdGlhbGl6YXRpb24gYXQgYWxsPwo+IFdvdWxkIHRoaXMgbGVhdmUgSU5UX01BU0sg
dW5tYXNrZWQgYW5kIHRoZSBUWCBxdWV1ZSBhd2FrZSBvbiBhCj4gY29udHJvbGxlciB0aGF0
IGlzIGluIHJlc2V0IHdpdGggdGhlIENBTiBzdGF0ZSBhdCBDQU5fU1RBVEVfQlVTX09GRj8K
CkJvdGggd2luZG93cyBwcmVkYXRlIHRoaXMgcGF0Y2guIEl0cyBhZGRlZCB3YWl0cyBjYW4g
ZXh0ZW5kIHRoZSBUWCByYWNlCmFmdGVyIHRoZSBjb3JlIHJlc3RvcmVzIGNhcnJpZXIuIFBh
dGNoIDUgb2YgdjYgY2xvc2VzIGJvdGggd2luZG93cy4KSSB3aWxsIGZpeCB0aGlzIGlzc3Vl
IGluIHY3IGJ5IGludHJvZHVjaW5nIHJlc3RhcnQgc3luY2hyb25pemF0aW9uIGFuZApUWCBw
cm90ZWN0aW9uIHRvZ2V0aGVyLgoKSW4gdGhlIGNvbXBsZXRlIHY2IHNlcmllcywgYm90aCBy
ZXN0YXJ0IGFuZCBvcGVuIHVzZQpya2NhbmZkX2NoaXBfc3RhcnRfZmluaXNoKCkuIEl0IGhv
bGRzIHR4X2xvY2sgd2hpbGUgY2xlYXJpbmcgdGhlIElSUSBnYXRlLAp1bm1hc2tpbmcgaW50
ZXJydXB0cyBhbmQgd2FraW5nIHRoZSBxdWV1ZS4gQSBuZXcgYnVzLW9mZiBtdXN0IGFjcXVp
cmUgdGhlCnNhbWUgbG9jayBpbiBya2NhbmZkX3R4X2Rpc2FibGUoKSBiZWZvcmUgcHVibGlz
aGluZyBCVVNfT0ZGIGFuZCBzdG9wcGluZwp0aGUgY29udHJvbGxlciwgc28gaXQgdGFrZXMg
cHJlY2VkZW5jZSBvdmVyIHN0YXJ0dXAuIFRoZSBmbGFnIGlzIG5vdCB0aGUKb25seSBzeW5j
aHJvbml6YXRpb24gaGVyZTsgYW4gYWRkaXRpb25hbCBsb2NrIGFyb3VuZCB0aGUgd2hvbGUg
aGFuZGxlcgppcyBub3QgbmVlZGVkIGZvciB0aGUgcmVwb3J0ZWQgaW50ZXJsZWF2aW5nLgoK
PiBDYW4gdGhlIGhhbmRsZXIgc2VlIGEgbmV3IGN5Y2xlX2xhc3QgdG9nZXRoZXIgd2l0aCBh
biBvbGQgbnNlYz8KClllcywgYmVmb3JlIHBhdGNoIDYgb2YgdjYuIFRoYXQgcHJlLWV4aXN0
aW5nIHJhY2UgaXMgZml4ZWQgYnkgdGFraW5nCnRpbWVzdGFtcF9sb2NrIGZvciBjb252ZXJz
aW9uIGFzIHdlbGwgYXMgdGltZWNvdW50ZXIgdXBkYXRlcy4gSSB3aWxsCnJldGFpbiB0aGF0
IGZpeCBpbiB2Ny4gVGhlIHdvcmtlciByZWFybWluZyBpc3N1ZSBpcyBhbHJlYWR5IGZpeGVk
IGJ5IHRoZQpsb2NrZWQgYWN0aXZlIGNoZWNrIGluIHBhdGNoIDQgb2YgdjYgYW5kIHdpbGwg
YWxzbyByZW1haW4gZml4ZWQuCgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBMdQoKcHctYm90OiBj
cgo=

