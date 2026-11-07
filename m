Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794062646;
	b=fLiEOBlXTaiWDtx5XF2nfgjzMNbHF53ByVOFKt2Ck23JA8PGo2wWxEZ2nEL10OxqWfs2
	 o0fmDQqJrMfyh95K8I6N6/QPEIdZXN72/I6ThBxJFI3/da+bgKcL1PanVUAV8SSzygH+L
	 9eKQ9F7IMfCkfo2lvTcbeiJirFS/J4Obk66i3j7qw0iaxfNpOFi/36EoWj2cqkb9+lnFb
	 3DXrSaTbKVmk0bo3U03mj/XIIhFLGvyGB7eqdZtH4yW7eeLxQ+ZtgSN9twu0UBE7UefTs
	 VjnF/3STGLQFBinmxMAmAVgRjPrYcmzw9GdrRFDJEFYuyGoPX0WNv07QZ1+50UMvDng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794062646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=c1flsEP104R0/Y0+YnWm4bBHTWURZB5LAfcThUu/D8k=;
	b=EgHyk7rx8SOoXl8A2pR39FqAwEoitmOK66bwew6+oyPAS3ljG2EfLmF7xnO16IMdG0sd
	 2Iih+z+HfdntAfB/KlwzIBRHbjW8ub/KWy+RBuzkIgkgb80T8dhWBAcFAAPCay2EtKtaa
	 /lD2rZYuX4i649per/G+G63/escObSZOgkY+8KDOTptUSsUcyKqKEFx2io/Poy/ZDKTxS
	 Ayg4+Jn7iDbZ1sSY3rcy0JQYQXPuS2p1+umP12u4y/mqwR3aE+Oo8f0m+nh8eQbM3PnDQ
	 YEdftSVMoXqJxntQkleF7fMYl4Dd8+7sEsGe6mFxkMs1vjAnc8LidalsxD9cQqrRt5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZnpLOwd;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E96D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 14:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E96D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IZnpLOwd
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so226216766b.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 06:44:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794062644; x=1794667444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c1flsEP104R0/Y0+YnWm4bBHTWURZB5LAfcThUu/D8k=;
        b=IZnpLOwdUM2bKv+lln9N7JQYaXBMidB/ixA7f1Pz9LsbWG4j1n0WDjb+oSHoObnkDr
         044ElXu+T1uk5TfyN4V8zMAd1O6MaAFsZpLPgMSSmxy3YxLB4798KjIE3DhuQo8O79Ar
         ni8Vie+HlVoCpVuXJtEz6+PIP7uug3RCXHyVMd0lwuukuDB4Ed2zNAOM0NPdJVgAZd7t
         szqIQbm8Yxp19aJP8hfD472SWoZsbRN7VM/aYWj2jkaby/Np9JEHxDRS+mmRA19vel8N
         VnoIWc1nHBuTemS3P23hN0lDWeHqpHLsPIA6CCh4BCM38uFC1uZ01xfbtnMu0kOagbZO
         bvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794062644; x=1794667444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c1flsEP104R0/Y0+YnWm4bBHTWURZB5LAfcThUu/D8k=;
        b=D/u1dNFZxe1D7oLvBVhDV8j12gGy1MmMVFf+6pn4h1li1VjP3uG/lpVFayjGnJvKcs
         bLOdtDYsKKKb7med7nWxTng6QD5I9/qgTwgQmyogtcnVG7IuGfiy9++oI8GU60yLonQe
         Aj6xPbmhyckE7WDuvrghKdUNsJe3xKymICDtxmchmliGvR/p66isOYuoCXNnN5SNMIWs
         UlwKUSOL059g6jdw0DuCpsMc1iUgpxLlB35EbPmX/PZbM6K7iob4Cg5MtxlreWy4FIN+
         BLV83djw690HBuXfR4DjpKTPqe/7sNRusNmNb6RUoLMdJ9s1pErzYEegNWHJVc0L6u2S
         Me7g==
X-Gm-Message-State: APuU4Z/CHBYZLe4eB+fpspZVfcqsuUYF6DmbVWbrUvOQiek8MnQsXueq
	SE0XswbVxektXoUJ2lOomz3EDkqyPjUtElnvxAMXhAp+i7qrB/uz7CuniUP7UXbH
X-Gm-Gg: AYBFou1spnAeUzJVFae7i+KjNvf0KcIv532KjweRA+SqruEFwe4kEAsny+2BMFZfLfY
	t64ox9pd/HcfyrcXl8csglLjg1GuFEo6QoVbcF9H/shHcWJx5PUEWzxJ4NDh6f/y7Y9nYjiVQ6f
	98EX2d7UILT9Vdtp93/LRmTxeezgoCVOQO1K0jvhVQl/zcXjSEVa7kNorKuRa+IAEXK3n4/uDLu
	6O5Jn2ik/UUKwM9r7kUMBV0RuDGM770UT0koGHO6Oxy67ZhrT4PPjNafZuyccc8wBOLVQtmnVZT
	oEL0sH/pZ2px6n9LRetnnBBQZE8iRAYUSGxiPgUsjxkEmz1ViLf+6/p4vFYRNHQDJ36ofprQPqi
	6XMYUpoMbKkOb1PBB54YQG2pnP8PJr32mkXMauLiBstao+ULsPzaMwjS3s7FJ9JGvvRHXCqjlre
	vLFKN8edw3FSkIfIU+q3gnnFp7A2os9iXZYTyYi8WOgaYmlS3QuYYYrTJCHgnc171TC1qhIiTEP
	mb/hSJUxAYXeVR2GLKoksv2x6bK702vnQBGl0IHRInPxoOdYFjp4tPEjIN3H16lz6g1XAl5PMAt
	PTJsDtTFTg0k1jy5cQmc2I2GDVDJ3w9gCuqL/3ADNAiCu/A4IehINwX+RkPXDFHlqA==
X-Received: by 2002:a17:907:54f:b0:c29:63f2:99bb with SMTP id a640c23a62f3a-c4d3555b439mr309921466b.47.1794062644422;
        Sat, 07 Nov 2026 06:44:04 -0800 (PST)
Received: from kali (83.11.29.10.ipv4.supernova.orange.pl. [83.11.29.10])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d356c2979sm150045066b.67.2026.11.07.06.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 06:44:04 -0800 (PST)
From: Kamil Sawicki <user148783812897@gmail.com>
To: stable@vger.kernel.org
Cc: willemb@google.com,
	kuniyu@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Subject: [PATCH 5.10.y] net: limit priority VLAN untag depth
Date: Sat,  7 Nov 2026 09:43:54 -0500
Message-ID: <20261107144354.243797-1-user148783812897@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107063012-failed-5.10-d3ff07f5acc5a@kernel.org>
References: <20261107063012-failed-5.10-d3ff07f5acc5a@kernel.org>
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

[ Backport to 5.10.y: __netif_receive_skb_core() has no local
  drop_reason variable, and this branch does not define
  SKB_DROP_REASON_RECURSION_LIMIT. Omit the upstream assignment
  and keep the existing drop path, which frees the skb with
  kfree_skb(). ]
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
---
Backport based on linux-5.10.y 3a323bc22b881a5bdc1646080f93f5ecb22850bf (Linux 5.10.274).
W=1 net/core/dev.o built without warnings (gcc 12.5). Full
KASAN/ftrace bzImage built as well.
Boundary test on an isolated KVM host: the eight-tag packet
was delivered and the nine-tag packet was dropped.
Original nested vhost/TAP trigger: ftrace recorded eight
skb_vlan_untag() calls and zero tcp_v4_rcv() calls; no KASAN
report, oops or panic was observed.
Unpatched 5.10.274 on the same host: the nine-tag packet was
delivered, and the trigger removed all 16364 tags and triggered
a KASAN use-after-free report in tcp_v4_rcv().

 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 4fcc2857c7db01..b9026d7fd27fc6 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5314,6 +5314,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+		unsigned int priority_tag_depth = 1;
+
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
@@ -5326,6 +5328,10 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
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
