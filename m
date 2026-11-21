Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.205
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795248441;
	b=k9Q9QDUpw1oH6Si0BcbDeYKSu/YBxuKhemeU+U+SRkn62MrCtuGGWYdU+6PgE1ZasY2S
	 ABIKTkUYVbk6uxtTHGS9eE/drar+p42LAaRjfOpQ1/uGWqLETTBcFlMIuxdk4f3IDeX3T
	 V4eIhP8ghAAKoMh5kLZQAV+KtqWWYKR0HNm4mplJm00Wa0hDuhFKQ0DL1G+gixZGMCOwn
	 NiyFggY1Lt3T63PIBMkcghXoCGpKJBDeRZeWefjA8tD4J6ajsGG3x8/Gk1CoT9HYdiqGT
	 xtFyhZJxc6A8YM2u/XqKTxo5PWEV2i0rqU7DIINCd7iSLhNNqkUBXUBUOn3T5UDldMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795248441;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=ydGqG2X9vPHlg2dNKkqZZA+txMkiHMzrAcf5VIowiK8=;
	b=Gh4lO9EFkIPGw7NKC1JBlahgBwPIrZMdbnFRm/JJUgPPCFBajE5LWHm0kXe+qu/o39bG
	 wvHnDhE4JoAwlCQ8TtgoQeq/w5ybfevUebaW6ATXlEQWC3kVM+XCGuPKwKIKL+/H1bQwD
	 4hBQNXw1MM33LNIaVoxEFZRxRHYbvt97d56N6PQVP3lZrPRrDrrgmrjul9+krt8uLSS4U
	 YYPwSqBXXwgAJb2Y2wECN/vW+iD0q2gfmTF+Nfpj3lLnJdlzPi8oJLQuu03d9dr/6/vqt
	 VvnAD5Rzya0Mlw/x0AH/+uT4F40j3uNB90YFaTWXXkYkeDM4Hx9ZLohipEaj4AcGOiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vacehtI1;
	arc=none smtp.remote-ip=203.205.221.205
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA3606A32C
	for <stable@vger.kernel.org>; Sat, 21 Nov 2026 08:07:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BCA3606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=vacehtI1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1795248438; bh=ydGqG2X9vPHlg2dNKkqZZA+txMkiHMzrAcf5VIowiK8=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=vacehtI1nuzuFJtDKjVsaj3sffn9TdWY1yTNu2pktLYHnvVMrToqkae9TNUwL3FBw
	 UuFHrGrIV1E0DWSOJ3IAIS2BBQ8zK4L1rs94oCmxtwad3Pz8g2nJJ67wMLlggiaWpJ
	 m3ZETnOkfqgNBj2a0X+Ajdq7z+Dv42XVh4CX50XU=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-XMAILINFO: Ng02GeT6VExI3uUWFD3xnavVNU+V6Hm34+BPzOlcKVIXJ8PwdC12xW5pVAVxDm
	 P5ASM+U//uKLiyt2kZs4uKnzfS2C5x6/kj/TbAiXKQo5WfUJCyAxzOxsR2U/4q63xnyaDtXH6mvX7
	 mz/xQuO3v3L0oN5gtCTshBBG+EHaSN6Eb19boRq2w9lMxXcHVXqP6N96WqLJhQnvJwKArYz+zPhNm
	 yYzbeFY7usepMHk5mhUxlhvYa6xgQg+siZKB3C1P545doU6P64+Z840PpDjDrmitzxF7DTpSSVMMF
	 cb5ItOgFkrvOxP6oIcIzK/FOCxiaCutyYdaIL2ldhawQuWanl0wc5a5pfGvKzQjdxTye89UhqXxtJ
	 U+SpvAhsmA01LcQIr4qKDUWd24QiQa0dAhH9GbfjzKKkiQpVtnVD/rggGP/22JN8adh4nbjiPaPgy
	 VT0dvuV6B6+d5WoM+s9WzM5AZUlhD17xOYpgmdr170Qs76N85kbf7WawIdq/fzODMcc130ioc0un0
	 Ku/w7BVA6voTfXTcxZf3vlOmtGL6TodhGvze/fJCgq300fHQcBcf2EzlqYz5ZvWjkvZ2/XINV0d+n
	 G1T5KekFl2kSt44zoLJgKOlM5oJa1myTDkqLYcyVaZHagMgpXq2I5beKfrrlIiVMCftwgxlh9aEHC
	 rmbh0pTaF6ZHLr1L13QtUZd8hRRreqrjvCFpdr0gdAPx8+PCAmeoRwRBPSdR3H0ntdPS+CNYuDiIe
	 DZbcF6FdicEYDCvgqmi6v/O2FGzivn8QazlBEJgM9DZPyDq+Ud2/WI8bJoE5ez2tXljZBCIPezinW
	 6KyM/DTKlpxtUav8uLdgeZ5kc+/YgAi3pNSqRhhhHnJviImavB0a/J4T+nhWwaZMGRMVdvfy47c9N
	 r24FSuLSFUdr+JUWuqlJW6mHAsxyl9MqxXeYVSeWRZ3/I01TNuid8+FspMqmzTYmfoDl6J+WhSFoo
	 +afmmkF4kiWHcNfwEk4CwoUMupd/hzQevXPIkdzu+cuQdZz+I+VzvvQPGO3wLvU0asT0lB+0wW01d
	 EN31KfoYyOkNqRC9Uy9GrZgU6bkXAZ5nZ9B6iCSU4EZENm0z7laLm20Cmiz29AMlQ7EdwUmRws7GO
	 vJvDssJ3w5A+381UmZnmv9K1
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?Y29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?c2toYW4=?=" <skhan@linuxfoundation.org>, "=?utf-8?B?cmR1bmxhcA==?=" <rdunlap@infradead.org>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, 
	"=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v10 10/10] can: rockchip_canfd: serialize timecounter timestamp conversion
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
Date: Sat, 21 Nov 2026 16:07:15 +0800
X-Priority: 3
Message-ID: <tencent_7CC03EE28E1F4753374DA10C4FC2E1086C06@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261119-rockchip-canfd-restart-close-v10-10-df23913aa33a@qq.com>
	<179521934595.3131.13988876249908602124@kernel.org>
In-Reply-To: <179521934595.3131.13988876249908602124@kernel.org>
X-QQ-mid: xmsezb41-0t1795248435tv16k8jeu

CkhpLAoKPiBbU2V2ZXJpdHk6IExvd10KPiBTaG91bGQgdGhlIHN0YWJsZSB0YWcgbWVudGlv
biB0aGF0IHRoaXMgZGVwZW5kcyBvbiB0aGUgZWFybGllciBwYXRjaCBpbgo+IHRoZSBzZXJp
ZXMsICJjYW46IHJvY2tjaGlwX2NhbmZkOiBwcmV2ZW50IHRpbWVzdGFtcCB3b3JrIGZyb20g
cmVhcm1pbmcKPiBhZnRlciBidXMtb2ZmIj8KClRoZSBkZXBlbmRlbmN5IGlzIHJlYWwuIEEg
YmFja3BvcnQgbmVlZHMgMDkvMTAgYmVmb3JlIDEwLzEwOiAwOS8xMAppbnRyb2R1Y2VzIHRp
bWVzdGFtcF9sb2NrIGFuZCB0YWtlcyBpdCBhcm91bmQgdGltZWNvdW50ZXJfcmVhZCgpIGFu
ZAp0aW1lY291bnRlcl9pbml0KCkuIEFkZGluZyBqdXN0IHRoZSBsb2NrIGZpZWxkIHRvIG1h
a2UgMTAvMTAgYnVpbGQKd291bGQgc3RpbGwgbGVhdmUgdGltZWNvdW50ZXJfY3ljMnRpbWUo
KSByYWNpbmcgd2l0aCB0aGUgd29ya2VyLgoKUGF0Y2ggMDkvMTAgaXMgYWxyZWFkeSBtYXJr
ZWQgZm9yIHN0YWJsZS4gVGhlIHN0YWJsZSBydWxlcyBkbyBub3QKcmVxdWlyZSBsaXN0aW5n
IGEgcHJlcmVxdWlzaXRlIGFnYWluIHdoZW4gaXQgaXMgaW4gdGhlIHNhbWUgc2VyaWVzCmFu
ZCBpcyBpdHNlbGYgbWFya2VkIGZvciBzdGFibGUuCgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBM
dQo=

