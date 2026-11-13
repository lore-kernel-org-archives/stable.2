Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.202
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794546550;
	b=nQvo7hUCJ9vh0wMhg7yNEH/FMUCv0DI/wU77A2TuP/hnhl/bumfYhhbTx13Zer2WdURl
	 MlQmyl38pHSmP0IRQsSLo3Xm8pE2HHa9xKrvJgWsAZ/eOCjOqrrajvx8wmmtctixqsH2M
	 hiZKvU5hRq28kyjO3KYPsvcSQwDEwbrN42HFT7XgIc8Pp2JCwNRxlKMUw4/VxHjE65JQE
	 Azirxt/Akv9UEaJLr3yu0+TIBs32yN0oeqwvELnH3htQwXUtM2DF3OccaXGpur87gb4Qn
	 cid5GGBn/+eWkVT85sP9bS8WU/VYq/ClgjN7SB0TrSV1DAit1af8I/RzWm/s4sTsKOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794546550;
	h=DMARC-Filter:DKIM-Signature:X-QQ-XMRINFO:X-QQ-XMAILINFO:From:To:Cc:
	 Subject:Mime-Version:Content-Type:Content-Transfer-Encoding:Date:
	 X-Priority:Message-ID:X-QQ-MIME:X-Mailer:X-QQ-Mailer:References:
	 In-Reply-To:X-QQ-mid;
	bh=5Dp2IENZXY8vor5OQbmzVoL9tS9zDPmNAgbX16sKuWM=;
	b=nGeHKX1gyggHcvck3+3mTpnf+CU+lZKrkvu2byqJJC6LoS7Wys1X+bz00ymAxs57Xbnj
	 Ems1423BbSrIElKkv+csBEqNz5XPyowV6gynmb/QnD2A5xtf8rtxCVtjC/VELeCVljyb6
	 nw1Nr0v6CdPX8lqZrVyyvDX/BB7Nkg/g7worToBHbLZMhWlupR0fN6N0ulR1lrCOqhhjO
	 /5EmtbDRhNsuqj4J+iKaeHfa16vjGTVnxQkL8OFfDJUd4GTp0/SKZFs0/tov8t2TBv+cS
	 Gs2bhJihLtToC4IVN+gDyUJzYzD2u4NLNaG8bdqKbYQQbsRYnlr414P0Vt+YX6Lgemg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=otsdPddm;
	arc=none smtp.remote-ip=203.205.221.202
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE57606A321
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 05:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CE57606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=otsdPddm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794546540; bh=5Dp2IENZXY8vor5OQbmzVoL9tS9zDPmNAgbX16sKuWM=;
	h=From:To:Cc:Subject:Date:References:In-Reply-To;
	b=otsdPddmRQeT+X5rLWjdUH3qgWfurnnL665INmuBmWvN57pDiYDOrSWpx8jTFUxlD
	 fUiMGZcePYTsXUO2djmGY8Mbs/bjCxd6fZ2nF1tiE9b7k4oF9WumvHH4fI05Jzoaal
	 LAN44/zOOrcoeeYn9ahWolD/LUahlc4PPttNE5HU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-XMAILINFO: Nc5/rdswZ3xKSNAXNUazFI95a8UiJLoXzHexhkY/+iv7Dp45u0g3b4eGgS8eS9
	 0owDJrRS0VqSesJrxHCup9iP71RVuztm9/kBOm9UYgEmvlEi7UNvzoAp6JJrUJBh1Av65Uv0tJwam
	 ku+DAMQlhUHRSDFm4g0yJX53FVtc8L8ATWt8PKqbYtd56C77OpGSyM9vhfjYuaQHz7GQ+ek21Rwjf
	 kgEUafJQ9wiqfTkr9EfsUxR6RvcNYOPns04V4Pgfojxwt8woUDTxeHyF1VHLyaOGr823UhwN30wta
	 NhlxHWkEHlaQ5tbcv/bhhfCXJhYWdi1bjkxMjQpZ777W61tMaHLkDE6jImBJo4SBwTPFSAg/SvbDS
	 GNN66WRB90V1VpeX39sH/kJvz6m6B6+wMvTWJjqPg6hnr1fZiQr0+04GvJQBgZS3jUzHddIxRzUAU
	 S+kdrXRl2FtzD80EODeTo2MzUDG+5xLfFZDB/xyWIlOpyr1UXSjZr4QGa7SKL+am1HFzHihFY9/4r
	 3c7izJ7L8C44y4YudG8hVwjwPwJeaOkOn6YQz0EyEb+qmdCEr55vX9F5ftxALxwb8NgTuPuJDc3DS
	 9Drv9JWDiAJQL43LovOEm0BkXHHSxHnD21oJxWa0rU7JRhKucc0E7G1i0QPWWQ12L5aReEZ+eFE07
	 uJlM2k68hP1nfQhY401tA/37lLJ4HOfW1qpQsSjaF0hXV1/97niLXvk1TbxfR3Bd7l/ziOS0xP6hu
	 4T4iapXSkwX9ffHn0buc4JzTyN+puCX/h0IYHfrVjvZvPw6KmOkgx+T5LV97pJVXsO+anRs5e7CDY
	 fvKwQIcYQ0qzXwo/aGvVj8/B4fc8bn/vbHRfOJ68Xs0TUoVuAsSlNpdTXwhPqjdmddIL13B4sMDAb
	 QDjf1hFgBZOdm/cINbkT4YwgdMEqHhmc9I3ZtupR3FhSr+bm8b/SvXNxFDJjX6D3Tg5Cc3dZtr2I4
	 fzHI5xQLBbIn5yuLknjm5xuwRhtxklzWBK93aAPnNq36u2AwUOA1P3MBrpGqf4T1bgS5+rUh5WBjF
	 8ePJ+oA5tULHaN2CbPN4P+AEcAcqU3w3PxnMwN9PXKF39rgc=
From: "=?utf-8?B?Q3VuaGFvIEx1?=" <1579567540@qq.com>
To: "=?utf-8?B?bmV0ZGV2LWJvdCtzYXNoaWtv?=" <netdev-bot+sashiko@kernel.org>
Cc: "=?utf-8?B?bWts?=" <mkl@pengutronix.de>, "=?utf-8?B?a2VybmVs?=" <kernel@pengutronix.de>, "=?utf-8?B?bWFpbGhvbA==?=" <mailhol@kernel.org>, "=?utf-8?B?aGVpa28=?=" <heiko@sntech.de>, "=?utf-8?B?c29ja2V0Y2Fu?=" <socketcan@hartkopp.net>, "=?utf-8?B?ZGF2ZW0=?=" <davem@davemloft.net>, "=?utf-8?B?ZWR1bWF6ZXQ=?=" <edumazet@kernel.org>, "=?utf-8?B?a3ViYQ==?=" <kuba@kernel.org>, "=?utf-8?B?cGFiZW5p?=" <pabeni@redhat.com>, "=?utf-8?B?aG9ybXM=?=" <horms@kernel.org>, "=?utf-8?B?Y29yYmV0?=" <corbet@lwn.net>, "=?utf-8?B?c2toYW4=?=" <skhan@linuxfoundation.org>, "=?utf-8?B?cmR1bmxhcA==?=" <rdunlap@infradead.org>, "=?utf-8?B?d2c=?=" <wg@grandegger.com>, "=?utf-8?B?bGludXgtY2Fu?=" <linux-can@vger.kernel.org>, "=?utf-8?B?bGludXgtYXJtLWtlcm5lbA==?=" <linux-arm-kernel@lists.infradead.org>, 
	"=?utf-8?B?bGludXgtcm9ja2NoaXA=?=" <linux-rockchip@lists.infradead.org>, "=?utf-8?B?bGludXgta2VybmVs?=" <linux-kernel@vger.kernel.org>, "=?utf-8?B?bGludXgtZG9j?=" <linux-doc@vger.kernel.org>, "=?utf-8?B?c3RhYmxl?=" <stable@vger.kernel.org>
Subject: Re: [PATCH net v9 04/10] can: dev: check netif_running() before bus-off recovery
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
Date: Fri, 13 Nov 2026 13:08:57 +0800
X-Priority: 3
Message-ID: <tencent_7BC3801D441CBFA5A6369A1F19AD848B9107@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20261111-rockchip-canfd-restart-close-v9-4-6643f3825ba3@qq.com>
	<179452272955.488853.2430789088711910750@kernel.org>
In-Reply-To: <179452272955.488853.2430789088711910750@kernel.org>
X-QQ-mid: xmsezb41-0t1794546537tvcfyebl0

SGksCgo+IFtTZXZlcml0eTogSGlnaF0KPiBDYW4gYSByZXN0YXJ0IHdvcmtlciBwYXNzIHRo
aXMgY2hlY2sgYW5kIHN0aWxsIHJlc3RhcnQgdGhlIGNvbnRyb2xsZXIKPiB3aGlsZSBuZG9f
c3RvcCgpIGlzIHJ1bm5pbmc/CgpZZXMuIFdpdGggcmVzdGFydC1tcyBlbmFibGVkLCBhIHdv
cmtlciBjYW4gcGFzcyB0aGUgcnVubmluZyBjaGVjayBiZWZvcmUKY2xvc2UgY2xlYXJzIF9f
TElOS19TVEFURV9TVEFSVC4gRmxleENBTiBjYWxscyBjbG9zZV9jYW5kZXYoKSBhZnRlcgpo
YXJkd2FyZSBhbmQgb2ZmbG9hZCB0ZWFyZG93biwgc28gYW4gYWRtaXR0ZWQgd29ya2VyIGNh
biBmbHVzaCBlY2hvIHNrYnMKZHVyaW5nIHRlYXJkb3duIG9yIHJlc3RhcnQgYW4gYWxyZWFk
eSBzdG9wcGVkIGNoaXAuCgpUaGlzIHJhY2UgcHJlZGF0ZXMgdGhlIHBhdGNoLiBUaGUgcnVu
bmluZyBjaGVja3MgbmFycm93IHRoZSB3aW5kb3cgYnV0CmRvIG5vdCBzZXJpYWxpemUgYW4g
YWxyZWFkeSBhZG1pdHRlZCBjYWxsYmFjayB3aXRoIGNsb3NlLiBUaGlzIHBhdGNoCmRvZXMg
bm90IGludHJvZHVjZSBvciB3aWRlbiB0aGUgcmFjZSBhbmQgZG9lcyBub3QgZml4IHRoYXQg
c2h1dGRvd24Kb3JkZXJpbmcgaW4gb3RoZXIgZHJpdmVycy4gQSBjb21wbGV0ZSBmaXggbXVz
dCB3YWl0IGZvciBhY3RpdmUgcmVjb3ZlcnkKYmVmb3JlIGRpc21hbnRsaW5nIGl0cyByZXNv
dXJjZXMuIFRoZSBSb2NrY2hpcCBmb2xsb3ctdXAgcGF0Y2hlcyBhZGRyZXNzCnRoYXQgZHJp
dmVyJ3Mgc2h1dGRvd24gb3JkZXJpbmcuCgpbU2V2ZXJpdHk6IEhpZ2hdCj4gQ2FuIHJlc3Rh
cnRfd29yayBzdGlsbCBiZSBxdWV1ZWQgYWZ0ZXIgY2xvc2VfY2FuZGV2KCkgaGFzIGFscmVh
ZHkKPiBjYW5jZWxsZWQgaXQ/CgpZZXMuIEhJMzExMCBjYWxscyBjbG9zZV9jYW5kZXYoKSBi
ZWZvcmUgZnJlZV9pcnEoKS4gSXRzIElSUSB0aHJlYWQgY2FuCnNhbXBsZSB0aGUgcnVubmlu
ZyBzdGF0ZSBiZWZvcmUgY2xvc2UgYW5kIGVucXVldWUgYWZ0ZXIgY2FuY2VsbGF0aW9uLgpB
IGZhc3QgcmVvcGVuIGNhbiB0aGVuIGV4ZWN1dGUgc3RhbGUgcmVjb3ZlcnkgYW5kIGZsdXNo
IGN1cnJlbnQgZWNobwplbnRyaWVzOyByZW1vdmFsIGNhbiBsZWF2ZSBkZWxheWVkIHdvcmsg
cmVmZXJyaW5nIHRvIGZyZWVkIGNhbl9wcml2LgpDbGVhbmluZyB1cCB0aGUgZHJpdmVyJ3Mg
cHJpdmF0ZSB3b3JrcXVldWUgZG9lcyBub3QgY2FuY2VsIHRoZSBDQU4gY29yZSdzCmRlbGF5
ZWQgd29yay4KClRoaXMgcHJvZHVjZXIvY2FuY2VsIG9yZGVyaW5nIGFsc28gcHJlZGF0ZXMg
dGhlIHBhdGNoIGFuZCBpcyB1bmNoYW5nZWQKYnkgaXQuIFRoZSBydW5uaW5nIGNoZWNrcyBy
ZWR1Y2UgcmVjb3ZlcnkgYXR0ZW1wdHMgYnV0IGNhbm5vdCBwcm90ZWN0CmZyZWVkIG1lbW9y
eS4gUXVpZXNjaW5nIHByb2R1Y2VycyBiZWZvcmUgdGhlIGZpbmFsIGNhbmNlbGxhdGlvbiwg
b3IKcHJldmVudGluZyBsYXRlIGVucXVldWVzLCByZXF1aXJlcyBhIHNlcGFyYXRlIGxpZmV0
aW1lIGZpeCBvdXRzaWRlIHRoaXMKcGF0Y2guCgpCZXN0IHJlZ2FyZHMsCkN1bmhhbyBMdQ==

