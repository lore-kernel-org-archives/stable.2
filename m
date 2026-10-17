Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BAB3CEB84
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 03:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792208583; cv=none; b=Sp9YPM1hmQlTpkh2gr3ax5myBclf60yEJn1+x6Hro00mypTBEHdQyEG9R3T9IkHF6KUmIW238hx05PPrcUwRXQvNAtBV08Z93TrUb1+Q3L6ALs4nEfLgzgh1+QSQB1wgnc6VYiP16l2Vz1WRgW1c0DF9AAGernnRdINfW3RqefQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792208583; c=relaxed/simple;
	bh=IJerTsz81r38Lu15HZf4hJIHhOGCfMms4JugNb/dsME=;
	h=From:To:Cc:Subject:Mime-Version:Content-Type:Date:Message-ID:
	 References:In-Reply-To; b=WuIZMjLhdggTup5O3mkO60Vh0p7Lpjr0krdYAtmpv8DnKQd7SYCIepJ1LtlOY+/8nln1GUOE5Ws+duzSL80/dT3lh8L9DgZxPmrZbPkxqt+4T1gdLayKnr+coPc3iRlzfMp69fqKXWpKbDc1Rfm9OhtnekntL4rWCSq+8S7mhBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iZ1WZnvm; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iZ1WZnvm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1792208576; bh=IJerTsz81r38Lu15HZf4hJIHhOGCfMms4JugNb/dsME=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=iZ1WZnvmP0UgbKX1bbGEoK0kDWP0HZlrhxOdMjhEVR04MC9vqi/sL5AAU30DGjHWh
	 6Byp6bVZs1MHaK/d7EpzZ1M5y773BPRmPFST6s4gTC5XeMiOz7l70UZfoeSwg9S/Gi
	 YNfWla7RIXeiQRA0AyKAeRwpUJJdUx7zj6sCNKTY=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-XMAILINFO: NSJPTvnisrLj8wYCImFMHtnbfUIUrHAx6PvluKs+g2oQLbqcVRcJSfuBcVZi8A
	 3S6K3AJ9XY2PBPtPafsNigyty01JlIh2DiQMP98xjjHKxjVA8y5pEblgtwz6GTPTZFYvn2bb8lUiN
	 g4xxRhYyddD2rWNTWI6TUACh7LGt4SGvSbku3uIx5Q1JPDwIIcBV8+L976Xz7pK0I3T996x+CVOQr
	 Bb7bBr/HVOFxxCxyTMMSOIUGHLz7Q0EtewJolS4d8Ac41C34TlZjhrhtN8bxNtNywy1ujMMkkd4JV
	 //s4b79C/ScJapoenMUcTRvmm5b6DxMZDQ/szS4Re9YHWPzB6j2OEpLTPlSqR7FglFRWIK//JF2p6
	 jml3tYO26gzphLflxNyaYTNseBMSxwtr8wbTYByithwGVxUTamUlzVIcPSagPMx5Q6QRMCFERKGEE
	 MTreGbpNuxEqUhFJMu1T+RHZwe1So6h8oAvZAPTsNWuNHdMNcTYlNXOLUMAYD9FOhQmUlwrCuJ8QB
	 G9B0e9YH0pm3IC6bwbHwOcFXpywq5vfzQHvlIa17hYK0JTCaC0W++DPbqYbLL3HNe6nuwU/tha+dQ
	 Z9dgkn19JoNSDlGi47qwHjW3xcf5lKKUntMT2sZ7zeqKbsa9XBXZFd4/JE2WYW+26Mg4UV3t8k6wv
	 aYnp6IsSbIi2ZzrBjMTRVlzFizRDP59yOMTgobaMYTSyRGKf/i09sMleXrUOZjntzRJiNN5E5F/yV
	 1ReCXSUXlFn+Ptyx9qP2+Sb2oFz/IlkXZUHGKs9v9Q8H7yursXo8+4D5UejOjKwA4vcNBC90i4pm7
	 0LG/s2fVZLNbQmhCqAPpl8hRlf2Qgizd0CMXHTbJ7pxZNL+nsuaWbbvPnD7WsV3Blt3k9lwmqZoDf
	 3JJsKqzVXNKR179r78Q65DqDmyWasLoL0Qsfg1Pkb1UWVuEksPTwsysie8uUUDZ3/iyF3u7KuefqD
	 +sJaoYck9ZBN8HddAngnVvWDcNASOlttI5O47dfhlCTNm+8XnegR6fGVxdtjL2owdG60nBoMg+2S4
	 Q90dze2izJJyTcefwhAFzVdWYlpmm3zCYh24kmnmFiEs2A/8Ik+WjecL0nrIRhGW7cK8S
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, "=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>
Subject: Re: [PATCH net v5 2/6] can: dev: add close_candev_cancel_restart_sync()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: base64
Date: Sat, 17 Oct 2026 11:42:53 +0800
X-Priority: 3
Message-ID: <tencent_BCC00222B29F6013030D8F0C6C02DEC84E06@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261015-rockchip-canfd-restart-close-v5-2-ae77327037c9@qq.com>
	<179219884300.1406898.17794218418731765550@kernel.org>
In-Reply-To: <179219884300.1406898.17794218418731765550@kernel.org>
X-QQ-mid: xmsezb41-0t1792208573tmm7xzz68

SGksCgo+IFtTZXZlcml0eTogTG93XQo+IFRoaXMgaXNuJ3QgYSBidWcsIGJ1dCBjb3VsZCB0
aGUgY29tbWl0IG1lc3NhZ2Ugc2F5IHdoeSB0aGlzIGlzIGdvaW5nIHRvCj4gc3RhYmxlPwo+
Cj4gT24gaXRzIG93biwgdGhlIHBhdGNoIGlzIGEgbm8tb3AgcmVmYWN0b3Igb2YgY2xvc2Vf
Y2FuZGV2KCkgcGx1cyBhIG5ldwo+IGhlbHBlci4gSXQgaGFzIG5vIEZpeGVzOiB0YWcgYW5k
IG5vICIjIHByZXJlcXVpc2l0ZSBmb3IgLi4uIiBhbm5vdGF0aW9uLgoKVGhpcyBwYXRjaCBp
cyBhIHByZXJlcXVpc2l0ZSBmb3IgdGhlIG5leHQgcGF0Y2gsICJjYW46IHJvY2tjaGlwX2Nh
bmZkOgpjYW5jZWwgYnVzLW9mZiByZXN0YXJ0IGJlZm9yZSBjbG9zaW5nIHRoZSBkZXZpY2Ui
LgoKPiBbU2V2ZXJpdHk6IExvd10KPiBJbiB0aGlzIHBhdGNoLCB0aGUgb25seSBjYWxsZXIg
b2YgY2xvc2VfY2FuZGV2X2NhbmNlbF9yZXN0YXJ0X3N5bmMoKSBpcwo+IGNsb3NlX2NhbmRl
digpIGluIGRyaXZlcnMvbmV0L2Nhbi9kZXYvZGV2LmMsIGFuZCB0aGF0IGNvbnZlcnNpb24g
a2VlcHMKPiB0aGUgb2xkIGJlaGF2aW91ci4gQXMgYSByZXN1bHQsIG5vIGRyaXZlcidzIG5k
b19zdG9wIGdldHMgdGhlIGVhcmx5Cj4gY2FuY2VsbGF0aW9uIHRoYXQgdGhlIGNvbW1pdCBt
ZXNzYWdlIGRlc2NyaWJlcy4KPiAuLi4KPiBDb3VsZCB0aGUgY29tbWl0IG1lc3NhZ2UgbWVu
dGlvbiB0aGF0IHVzZXIsIHNvIHRoZSBoZWxwZXIgZG9lc24ndCBsb29rCj4gdW51c2VkIHdo
ZW4gdGhpcyBwYXRjaCBpcyByZXZpZXdlZCBhbG9uZT8KClllcy4gVGhlIGZvbGxvd2luZyBS
b2NrY2hpcCBwYXRjaCBpcyB0aGUgaW50ZW5kZWQgdXNlci4gVGhlIGN1cnJlbnQKY29tbWl0
IG1lc3NhZ2UgZXhwbGFpbnMgd2h5IGRyaXZlcnMgbmVlZCB0aGUgaGVscGVyLCBidXQgZG9l
cyBub3QKZXhwbGljaXRseSBuYW1lIHRoYXQgdXNlci4gVGhlIGNvbnZlcnNpb24gb2YgY2xv
c2VfY2FuZGV2KCkgaW50ZW50aW9uYWxseQpwcmVzZXJ2ZXMgaXRzIGV4aXN0aW5nIGJlaGF2
aW91ci4KCklmIHY2IGlzIG5lZWRlZCwgSSB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3Nh
Z2UgdG8gY2xhcmlmeSB0aGlzLgoKUmVnYXJkcywKQ3VuaGFvIEx1Cg==

