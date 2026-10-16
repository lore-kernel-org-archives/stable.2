Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE54639656C
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792129107; cv=none; b=fOeLEZs6ZPAeXHurbNNdsN7QP+wWMr7V3X+wK+IBy8DrHzPM/fRD6cU5q3b8VDorJXnN7GDqoRZl6BsDyDsWz4thHWR4OghoDmY0qyRCUAjPWMvTaO0SD2Fy13DDCg+HREYNkb7VUYhvgcGmX2ba0/qjGae7E6x2kkvqcwrpAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792129107; c=relaxed/simple;
	bh=I9S/3scpv8TmDMpc3q9HAsNyW70EViJX64k08LJms7E=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=PSWNzh43YUDgNOOxpvNDGM6WovVhNdP2uiA4wteUAKVLmLfFD91doMh5ZXELCN0FBaG4e5n0CqZSPsT9273/AAVk+F7kqBwJTZbNbk8XKnCoHvwISJiKlRq6dmYoTjLCFF2ezcE2FL0kliCMTk3vf7uj+2j4Qvdm00PJ4vC0tl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=cxP/9htK; arc=none smtp.client-ip=43.163.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="cxP/9htK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792129097; bh=I9S/3scpv8TmDMpc3q9HAsNyW70EViJX64k08LJms7E=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=cxP/9htKshkcGlqtR4PvqVrttAC60cxFdU3CFwAtVdMna9nJUCuGcFYHgqj0JYOM7
	 590j5kv3z7felF+xg7pg5NzW5a8zyCK9qQQhIUZt+8XgiSZKnvFMghRzF0EHYe7FXm
	 8ij3wmlTIst7OSxdj2lX8dSYrycWjL67PIJ5hT9I=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-XMAILINFO: MYbC+rXBLyObodfQCA4D7TaoC77kH8yp+juHBOTeycoxYspZxP8BMQM5plRqXp
	 zbvO/D7gGuVDNON12sGweqj9HkecQI4fZdeQtgAf1H6bnhUZfr8LRxHn5k8b0uE8Wo2TLq75I38VY
	 0ebyvfRz6/Zi7lyNeEk7JwBPtXFp8/m6nTP/SXbxRGJFon3KvSxWFVCgKj/6pPp41Z/qbPqohN2fX
	 XPn6RlPVn/woGfgLwefe588P4RvHw0q5J78CFmV6tijn2hlCNhwMm5eDZzd+PWGVWUWkGF+doB7gJ
	 rpvnLW87wnglxDOV3aSGqiOL8cfxlW86STqrxcyTcqDYjsMtOHJj2uj97DGLNUyTKS4NWRPCDwKYg
	 7L7CKTFFkWbQyOzkvIrHekv94DixLNKaUZc/mZ1rZglKBJL8YO2s/kHiVSxFlciinot5mMnk+98Bh
	 eNBspZUi2qlD5d+8wfWmwjU1Tmi1f1ZkI5Bq+vjWg38iE5kD7/zF0dWF0cifVX6dn257A4A2oTNdq
	 sbc9rm4fO6RyAHoBe4MZ6LpA4p5r4xHPDwrTFkD0C7rOV0pNuoT44E+LluRhECc5PR0AXcfvJtuow
	 c3PQNqJLzLL4b/SlNICw8piy5WMwbDG/9bFKVP0vnJuKpEOBXC5W0/Ny3UKWgzNgLhWFDvSjAzMx1
	 gAcWME4YV6xUkumRdI4ai0eG+xLxS3iNQMDZ3q+H7TapI5wLcfRzhJMo2ssLaVdkjzpKmAn/Z40BX
	 dRWsFCoVgYKeRVn9JQ1hA0a6YBeEIRJX9TGK4f+AX/XXWbraDLdX65RPfygGvWTjzslM2IL9KjTIp
	 BniCtuPJi/F6r418IHXaw9rTQlSzCN9AbIG9R7PQrwjU88rb68DvwqACQaC3ydKS57IDP7GtNh1Wq
	 GAYT7PnwxekubUkpk0SFywKN5wWvGoExUeDr+Ltwb+kVBvfu/xoNM8cQcU1B77baOackPJuT7dZSi
	 UJ7IlCp43FxSDPrYerbSF9vQPpPZupFEm7VdaBjs3oSi8eaZwYK3HU1ye7Zm5ENVtl1GI70Y0QHj2
	 E5aFPDjlYbhyLT77QicDd4corlf6N9UQCPwZ1
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>
Subject: Re: [PATCH net v3 1/5] can: dev: prevent bus-off recovery when the interface is not running
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Fri, 16 Oct 2026 13:38:15 +0800
X-Priority: 3
Message-ID: <tencent_F6326E09D62380013188767E4F4D66345808@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261014-rockchip-canfd-restart-close-v3-1-f0eb41090242@qq.com>
	<179212694915.1406898.5096495212984871051@kernel.org>
In-Reply-To: <179212694915.1406898.5096495212984871051@kernel.org>
X-QQ-mid: xmsezb41-0t1792129095tq0zz4chp

SGksCgo+IFtTZXZlcml0eTogTWVkaXVtXQo+IElzIHRoaXMgY2hlY2sgZW5vdWdoIHRvIHBy
ZXZlbnQgdGhlIGZhaWx1cmUgZGVzY3JpYmVkIGluIHRoZSBjb21taXQKPiBtZXNzYWdlLCAi
cG90ZW50aWFsbHkgcmUtZW5hYmxpbmcgaGFyZHdhcmUgd2hpbGUgdGhlIGRyaXZlciBpcyB0
ZWFyaW5nIGl0Cj4gZG93biI/CgpObywgbmV0aWZfcnVubmluZygpIGFsb25lIGRvZXMgbm90
IHNlcmlhbGl6ZSByZXN0YXJ0IHdpdGggbmRvX3N0b3AoKS4gQQpyZXN0YXJ0IHRoYXQgaGFz
IGFscmVhZHkgcGFzc2VkIHRoZSBjaGVjayBjYW4gc3RpbGwgb3ZlcmxhcCB3aXRoIGhhcmR3
YXJlCnRlYXJkb3duLiBUaGUgY29tbWl0IG1lc3NhZ2UgZXhwbGljaXRseSBkb2N1bWVudHMg
dGhpcyBsaW1pdGF0aW9uIGFuZCB0aGUKbmVlZCBmb3IgZHJpdmVycyB0byBjYW5jZWwgcmVz
dGFydCB3b3JrIGJlZm9yZSB0ZWFyaW5nIGRvd24gcmVzb3VyY2VzLgoKRm9yIFJvY2tjaGlw
LCB0aGUgc2VyaWVzIGFscmVhZHkgY2FsbHMgY2xvc2VfY2FuZGV2X2NhbmNlbF9yZXN0YXJ0
X3N5bmMoKQphdCB0aGUgc3RhcnQgb2YgcmtjYW5mZF9zdG9wKCkuIFRoaXMgY2FuY2VscyBw
ZW5kaW5nIHdvcmsgYW5kIHdhaXRzIGZvciBhbnkKcmVzdGFydCBhbHJlYWR5IGluIHByb2dy
ZXNzIGJlZm9yZSBkaXNhYmxpbmcgaW50ZXJydXB0cywgZnJlZWluZyB0aGUgSVJRCm9yIHN0
b3BwaW5nIHRoZSBjb250cm9sbGVyLiBUaGUgZmluYWwgY2xvc2VfY2FuZGV2KCkgcmVtYWlu
cyBhZnRlciBJUlEKdGVhcmRvd24gZm9yIGZpbmFsIGNhbmNlbGxhdGlvbiBhbmQgZWNobyBj
bGVhbnVwLgoKQXMgZGlzY3Vzc2VkIGVhcmxpZXIsIHRoaXMgc2VyaWVzIGxpbWl0cyB0aGUg
ZHJpdmVyLXNpZGUgZml4IHRvIFJvY2tjaGlwLgpZb3UgYXJlIHJpZ2h0IHRoYXQgc2phMTAw
MCBhbmQgZmxleGNhbiBzdGlsbCBoYXZlIHRoZSB3aW5kb3cgeW91IGRlc2NyaWJlLgpUaG9z
ZSBwcmUtZXhpc3RpbmcgcmFjZXMgbmVlZCBzZXBhcmF0ZSBkcml2ZXIgZml4ZXM7IHRoZSBj
b3JlIGNoZWNrcyBkbwpub3QgcmVzb2x2ZSB0aGVtLiBGb3IgUm9ja2NoaXAsIHRoZSBzZXJp
ZXMgdXNlcyB0aGUgZWFybHktY2FuY2VsbGF0aW9uCmFwcHJvYWNoIHlvdSBzdWdnZXN0IHJh
dGhlciB0aGFuIGFkZGluZyBSVE5MIGxvY2tpbmcgdG8gdGhlIHdvcmtlci4KCj4gW1NldmVy
aXR5OiBMb3ddCj4gVGhpcyBpc24ndCBhIGJ1ZywgYnV0IHRoZSBjb21tZW50IGFib3ZlIGNh
bl9idXNfb2ZmKCkgc3RpbGwgZGVzY3JpYmVzIHRoZQo+IG9sZCBjb25kaXRpb246Cj4KPiAv
KiBDQU4gYnVzLW9mZgo+ICAqCj4gICogVGhpcyBmdW5jdGlvbnMgc2hvdWxkIGJlIGNhbGxl
ZCB3aGVuIHRoZSBkZXZpY2UgZ29lcyBidXMtb2ZmIHRvCj4gICogdGVsbCB0aGUgbmV0aWYg
bGF5ZXIgdGhhdCBubyBtb3JlIHBhY2tldHMgY2FuIGJlIHNlbnQgb3IgcmVjZWl2ZWQuCj4g
ICogSWYgZW5hYmxlZCwgYSB0aW1lciBpcyBzdGFydGVkIHRvIHRyaWdnZXIgYnVzLW9mZiBy
ZWNvdmVyeS4KPiAgKi8KPgo+IENvdWxkIGl0IG1lbnRpb24gdGhhdCByZWNvdmVyeSBpcyBu
b3cgb25seSBzY2hlZHVsZWQgd2hlbiB0aGUgaW50ZXJmYWNlCj4gaXMgcnVubmluZz8KCkFn
cmVlZC4gSSB3aWxsIHVwZGF0ZSB0aGUgY29tbWVudCB0byByZWZlciB0byBkZWxheWVkIHdv
cmsgYW5kIHN0YXRlIHRoYXQKcmVjb3ZlcnkgaXMgc2NoZWR1bGVkIG9ubHkgd2hlbiBhdXRv
bWF0aWMgcmVjb3ZlcnkgaXMgZW5hYmxlZCBhbmQgdGhlCmludGVyZmFjZSBpcyBydW5uaW5n
LiBJIHdpbGwgYWxzbyBjbGFyaWZ5IHRoZSBydW5uaW5nLWludGVyZmFjZSBjb25kaXRpb24K
aW4gdGhlIHJlc3RhcnQtbXMgZG9jdW1lbnRhdGlvbi4gSWYgdjUgaXMgYWNjZXB0ZWQsIEkg
d2lsbCBzZW5kIGEKc2VwYXJhdGUgZG9jdW1lbnRhdGlvbiBjbGVhbnVwIHBhdGNoIGxhdGVy
LgoKUmVnYXJkcywKQ3VuaGFvIEx1Cg==

