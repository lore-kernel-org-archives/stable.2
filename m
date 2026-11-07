Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062619;
	b=0At6GeO10vdNmJV7i0WyQP4x6OEdKa5Vv0+AWtT+AJHm3fu4Y/MKf0gmsrgrDMXGleOQ
	 +gdgknJWlu8nE8EfyJyls6DLqSdhmAwtl4Mhrd82TYoAMvjRXdPIeuSwOAhrZKa9IOKXH
	 GCegwyJyDeM7Jb6F6pzuKKF1rdV1VzDGQXSAsfOz76wcGo8r4CjRu3xTnEYzbqtnq3FNQ
	 XbY/igH0qIYIhkJodDEEUGkZuFD3YfbrHazOWdxV9LLbQw8RvVNWaxhrFZEax5KrbgAkD
	 ngAhc40UQpe72epDgtQiRhwHBnKHc6vPV2PdP2KNfg3r9E5yQ/uQGUe2QM1p6L5ffgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mqEUC7diGM+qqninO58NMR1zIUrnj+6a+3GnM1rrPlo=;
	b=QLwJII5gUPMIhXuNnWKOSNUWASANJ7ZXllZtl8IahVGMYsN8SSDxeBPaAZrk9COKPA/I
	 ILs9RQhecb1AfQfTM6bUPjVH37WBgrwkgb5Oco2qCtlefLbUIcLxLazTon6N0NBHmMBcT
	 km1IpsKBd7g1BIREHnNiywkgAgVfVanuVlMyDgM3gN0KVzCTH4/0JMhbeMBQRAbKovyMy
	 bfzxS/Brc3y34H1Io1rcvdKukgqZmHLaA/BBLf91CUemhvD92iHzXs6QuGS/+v2MvxR65
	 k+N277N4ExdHH2YYac9BjmM+AUifv3lI87NuznF0Ia9LXQiy7lhnNkzfrVPISNdHxmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0EL27In;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E6606A657
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:43:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 502E6606A657
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=s0EL27In
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c4d2b741ed9so235698366b.2
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062618; x=1794667418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mqEUC7diGM+qqninO58NMR1zIUrnj+6a+3GnM1rrPlo=;
        b=s0EL27In5Zf6NmrrLMezWZ2pmIXHpFh4lY5l7SxUqY2F4GxrcGQgbLqtmG13Ir8Aih
         GnDZ8lET22ERcMNrY0EPomsYhBXlNjKSEpABiHfJs6EWYcTl6eCutVkWNsLbyDAurl1t
         Xnatgw9oyEx5Me2RJu0VO86lzCe4qgTi87rjG0fQrzSp0A7X2FzdDE60IhqGoXT1gCV2
         Y5cOBTb2nzMtAq+vRfh5DspxGJDw28/IsJecRgQFTXKm0am7pUzX+NVec/wVro2TTR7x
         JQHA1TPTLqWDnExZ1MHnMIGRVgc/QdGBqNvbqXvzO739eXOGx5l+tOEp0BoGwwJ0i05D
         fXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062618; x=1794667418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mqEUC7diGM+qqninO58NMR1zIUrnj+6a+3GnM1rrPlo=;
        b=Bpc4/J2JkXh+0n40SBuVYsqQ1oCGPNOHYMy+g/9OtxxV7JY2s1gKMOrsiLpXWqPzLi
         T3axLX11br2sZFDRz2VviL7AsyIygO14Cbvuq9e56gr/P3fYDwTXgcyH93Mm6Lljvgz2
         HluIMQu75w/tI65QDTxIiuo8UQ++Ts12+R12v80yKZ97EPvEPO/V/qzD9qlXm3zs2IfM
         qxTVQ18kvUis/Ox7S+HuA7OsNeeYjIEaCENevg7sG08xS43X4/I4LA/PCwyz2+OSHruo
         0hEipGLF1sUP1ekWcXUiO+MFW8Ck+LOcT0G2iYUtXfgOKs21UOl4iNYl2KYK9AJvRJNN
         dvvg==
X-Gm-Message-State: APuU4Z9d2ZR8p79Edu9bPy/UYVsbXnltVEKXVnyDSHWZKUAzejmktwgf
	D7EKQA/5JjVouxWOio1OfuXRFxKn12gSO78xNGWOmd7gdkwehwjqUGEKiV7NUDro
X-Gm-Gg: AYBFou3Wwleoy9kZ/3tLU+fI4wgVCFIY3Tf7Ohg+lguj4PgZrrPIKOWDMN/VZSY4/eh
	hSWmKYi5F21hK214zw6JrjVAD9m8p0KMLbI/0X9kRV66f0YwR7Ql36c1FfOts287B3UIfyPq1dY
	aWZVw1lfsxE2aI2w+sKKnQ9ZGFxXzZDymx+slfPKZlYdSz3njfwYxyfjmYHvFAH3Tw2VanWaKxH
	7bALSC1iemaWIreozWqdLLIGIZTqo/1ilWd07sEnbfpijLFwu7RF2W1KWalYZSjvCBOs4ATX2Ay
	L8yfn+ZIAUxOyolmmlTy3iVtUNCT2g4W8Utu4He4R53KeWxcEiuoQHTYbJi8LFZhb30gUg+cJnL
	bH+USx6PHCHRaZ82MkoDZmMJBUS/XSMUudUBGyhAWL+fP6UbODDgwrPGv7GLR88SQDO9tqTFotv
	flztuFv7QCwP/+tJppYZhtNCziFJmzioskzTl5/Y8av3f/I6G1ngcaLDxoFV/f3xf7j/ZtGKN7B
	q8QSXxNwdfw7G8u+UZdEfCeVkfZcwoEpXjrkmw19lkWqjXsVimvKE5NAqt59pwjjv9vXJl4rSNA
	HkyWApLJG/u9fVGQEKySr/yXDHNR6BUGHTKlHSXgg4aEDMdtbHUA92uYK4dzKLaIvFq7583wP4j
	OVOxu7Yy78Sw=
X-Received: by 2002:a17:907:ea89:b0:c4c:bff4:200c with SMTP id a640c23a62f3a-c4d3531f031mr432913966b.32.1794062617480;
        Sat, 07 Nov 2026 06:43:37 -0800 (PST)
Received: from kali (83.11.29.10.ipv4.supernova.orange.pl. [83.11.29.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d3569edc9sm156775466b.50.2026.11.07.06.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:43:37 -0800 (PST)
From: Kamil Sawicki <user148783812897@gmail.com>
To: stable@vger.kernel.org
Cc: willemb@google.com,
	kuniyu@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Subject: [PATCH 5.15.y] net: limit priority VLAN untag depth
Date: Sat,  7 Nov 2026 09:42:53 -0500
Message-ID: <20261107144253.243256-1-user148783812897@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061309-failed-5.15-d3ff07f5acc5a@kernel.org>
References: <20261107061309-failed-5.15-d3ff07f5acc5a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit d3ff07f5acc573e5f72bf1c581bae5d05191ba61 ]

The priority VLAN receive path can repeatedly remove VID 0 tags and retry
packet processing. Unlike the read-only VLAN protocol parser, this path has
no limit on the number of nested tags it consumes.

Each skb_vlan_untag() advances skb->data and resets header offsets. The
offsets are stored in 16-bit fields. With enough nested tags, the network
or transport offset can wrap. A later protocol handler can then derive a
large pull length from the wrapped offsets and access memory outside the
skb allocation.

Apply the existing VLAN_MAX_DEPTH limit to the exceptional VID 0 retry.
Count the tag already stored in skb VLAN metadata as the first level, then
stop before untagging a ninth level. Keep the accounting inside this
uncommon branch so the regular VLAN receive path is unaffected.

A single VID 0 priority tag before a real VLAN tag is valid. No normal
deployment was found that intentionally emits multiple consecutive VID 0
tags; permitting eight levels is therefore conservative.

The issue was found while researching the Linux network receive path for
Google kvmCTF, with OpenAI Codex (gpt-5.6-sol) assisting the analysis. The
affected path, reproducer and fix were manually reviewed and tested.

Fixes: 36b2f61a42c2 ("net: handle 802.1P vlan 0 packets properly")
Cc: stable@vger.kernel.org
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Link: https://patch.msgid.link/20261024004835.17862-1-user148783812897@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[ Backport to 5.15.y: __netif_receive_skb_core() has no local
  drop_reason variable, and this branch does not define
  SKB_DROP_REASON_RECURSION_LIMIT. Omit the upstream assignment
  and keep the existing drop path, which frees the skb with
  kfree_skb(). ]
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
---
Backport based on linux-5.15.y 29c6cdaac04a6989a7ed4ae4275ce4244e617f58 (Linux 5.15.225).
W=1 net/core/dev.o built without warnings (gcc 12.5). Full
KASAN/ftrace bzImage built as well.
Boundary test on an isolated KVM host: the eight-tag packet
was delivered and the nine-tag packet was dropped.
Original nested vhost/TAP trigger: ftrace recorded eight
skb_vlan_untag() calls and zero tcp_v4_rcv() calls; no KASAN
report, oops or panic was observed.
Unpatched 5.15.225 on the same host: the nine-tag packet was
delivered, and the trigger removed all 16364 tags and triggered
a KASAN use-after-free report in tcp_v4_rcv().

 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7197b18b052dff..dd5e5097726562 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5460,6 +5460,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+		unsigned int priority_tag_depth = 1;
+
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
@@ -5471,6 +5473,10 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 			 * 802.1Q or 802.1AD and vlan_do_receive() above could
 			 * not find vlan dev for vlan id 0.
 			 */
+			if (unlikely(priority_tag_depth >= VLAN_MAX_DEPTH))
+				goto drop;
+
+			priority_tag_depth++;
 			__vlan_hwaccel_clear_tag(skb);
 			skb = skb_vlan_untag(skb);
 			if (unlikely(!skb))
