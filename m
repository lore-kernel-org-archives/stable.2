Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053034;
	b=s90ohCvQD2Hr3bOYLwcKLG4IGvK4qn6LQeRWnHTWwIlDoTSCmrnbSsrSlGv7Lzg6xGCz
	 sLHDjtdvaJOff46DB/K9WKJRbUORBd8rtF/QxbfbhBBIOpyjsGfSq5q4ZoyPY3QFDbEG3
	 LJBH1KLOXM0DGotPLtnOXdgEhZQSjoqQUV0iz/nkozx8EWllhqejxx9Lx6511Xf6VY5CK
	 0JHsXs36jHamNq8hB7M4ztklp4iMvEALIDgw6Gy2EyFWH2dq9LfBnY6AWYz73nK21Pm4i
	 rm/j/TsDxgUBPLHSZ+oHt5HBakuOKavjDfFV/Wxt77VYy4NkN+6hvBvNGBCyqcW8Y8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=colwCFulLNMicTRI6Mx9C/ru9VurgUyIQ449HmkAprI=;
	b=BBPeZ1Qp+h35cjnRvvi85NDWwS7nxsP+vZ+XaHBrS2w0blq2mxupkQRZUrSL5HjBMgCL
	 MvUgwAGa7Z6GsKL5PZ04dMOYVrQ00NCn0okoDdirbFhxNrZePvafz/bKEbP1pvXPVDK1b
	 IRYQAWA7kQ7CdBJEqFN5A77heIOD8cc6Euejh+XSe5apsdO1skt709RvtNFEJsyxSNuvI
	 Eh8NbkwoSAQmvf3o9lPOqgr68nFM5W9bFb59JBJbO4n3sdN98zUR4gAhoiCnMeGDN0DQI
	 wgrBJlWInBpeWZGYm4SAj7hENYx2hsNER78fDpEK8QPfPhcQvzuTTJiiUgirCgFNqmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iaiF6W7h;
	arc=none smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814E3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:03:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 814E3606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iaiF6W7h
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so2317547a12.0
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 04:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053033; x=1794657833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=colwCFulLNMicTRI6Mx9C/ru9VurgUyIQ449HmkAprI=;
        b=iaiF6W7hE8EbZOmXZo45o2QHiyj43t+DloNWJJNbPcz1Mcj0sTiUdF1xL8gp+tHdPl
         BWpJVPpbfjbwCpYrcmL/ZfNDoy2UmGHAkbAed+SN9020QaOquyKoayn/pjKZSxkSKzgq
         h6GedoSkZ+Phg8FSWaWCa8SjBkY4v9MrOIhPb9cYRWSCw9wvG24b3uJNY0pds6RS3MDr
         zoLvdOjpYTy7Q3b7isYkrcJ+a3BmkC45UnNFZHeQvX52TUCgM436yZQfXte+tZwki5jk
         tg3H9L2EicBFRZhOSpWjYW665mZ28IFNdgPNWcg5d5VqRW/EGYxMw1rgttjKt6qBi01c
         xpaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053033; x=1794657833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=colwCFulLNMicTRI6Mx9C/ru9VurgUyIQ449HmkAprI=;
        b=yC829o6qGnlbZjLXD1/AlkTHlD0ZV7KztVIHXRMzC/nlwpKCb1bvhVZJ9BvHfRpAuB
         G0xPYDkx+HNxs1yaUQ8yj0uBAqeCY3BCyTPiNR9TyVzUXo0vlEt6FcPbptTsf8L/mWnY
         oaTI7xqq249yZEzt0A3/+5LJo1taJ9+E1e1r0eC8XhtfdXBa4KD5txzkSxCdvWDV7b3r
         lAbnSB/+1ep+4ZrxORbAH/Ft7LdQe64Q1FSZ7qtPtaXN+L+cIe9ueh7oCl/y9VmzKpfs
         8ta4QozA79z7ieJOX+AVPO0ukh1rOz8+Rk79H0Yzj1kowAdtyjTiycuLBM/JsZ/Wnfbk
         O9Cw==
X-Gm-Message-State: APuU4Z/YBOKbvgYIJGPDGqW8jeVJS7uOfvVqJFkNT67fBcJKFDNC8m1X
	Mwg5fH9YnMW6E2HT5bxlcsy2//QR+LxcTD59vqxjhYyf2EkGDvAi0HFy0ApHfw==
X-Gm-Gg: AYBFou0sy0FUjC3bujg47jLGzIxcD8sxfryqeS5FM24VDQ0+O0jHiHPhC7kPQVAvMcP
	/J1xbneVYdslQh57mO3ijnWveJw3Ghxkm4Gy+oHDNR3QlaOVNuNgn7YoaaHnMECWEPDAMgys+Ot
	N1tF+Y1BGIH0WZq2LoImNagGLxUgMPwgK20SJWKz6Pbmnr2KMEeviW2L1/ncxAxDPDOWilbLz6S
	q/Cicnvv4OZucdFSUy0s39MihA2c750rpmySSaGPGywVYnZcJkWdDfVefj/p7K416NF/rMUzFlR
	2uT+0dagq2Yp2rTzBf7cBk6i/Wq8MwccgGeLJHWtsSxA7eLFBLaLuUwzuAcja0auVBvmwSVNrd3
	x6NJsx2Qv+d7clJY4neqiWzEzngS7Pl7dp/GvTKCorkXMj55XaB5HNJ4Y3KqvASSwaGN2VzOay9
	L1PePnambqicvLCpReqGwcFMTOinf2k18KjLrmOAe3rZoe7ekCqZMQQ4ELLAyAq8EVz2hBXHZ5H
	skmRf6cHMnJraBcG9U33kjmR79x8iB3TbtvX3lzBl2eamA8UICnc5QX/d2gzzyY1NJ6xMTiv1SD
	mG+i5CSKc2XkB7vBogPjk1Zftp9PMDVE8Z80TkL/+WrLUoS9x9uSmrqf0NhBkxE3PStDPF1u2zb
	1bQ4hbGqv7Q==
X-Received: by 2002:a05:6402:e8a:b0:6b5:7792:d82c with SMTP id 4fb4d7f45d1cf-6b59781621fmr3575800a12.16.1794053032789;
        Sat, 07 Nov 2026 04:03:52 -0800 (PST)
Received: from kali (83.11.29.10.ipv4.supernova.orange.pl. [83.11.29.10])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b664b0239csm1846795a12.26.2026.11.07.04.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:03:51 -0800 (PST)
From: Kamil Sawicki <user148783812897@gmail.com>
To: stable@vger.kernel.org
Cc: willemb@google.com,
	kuniyu@google.com,
	edumazet@kernel.org,
	kuba@kernel.org
Subject: [PATCH 6.12.y] net: limit priority VLAN untag depth
Date: Sat,  7 Nov 2026 07:03:30 -0500
Message-ID: <20261107120330.29162-1-user148783812897@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052727-failed-6.12-d3ff07f5acc5@kernel.org>
References: <20261107052727-failed-6.12-d3ff07f5acc5@kernel.org>
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

[ Backport to 6.12.y: __netif_receive_skb_core() has no local
  drop_reason variable, and this branch does not define
  SKB_DROP_REASON_RECURSION_LIMIT. Omit the upstream assignment
  and keep the existing SKB_DROP_REASON_UNHANDLED_PROTO drop path. ]
Signed-off-by: Kamil Sawicki <user148783812897@gmail.com>
---
Backport based on linux-6.12.y 03bae623ec326c2738198739625832aab0eb120a (Linux 6.12.115).
W=1 net/core/dev.o built without warnings. Full KASAN/ftrace
bzImage built with W=1 CONFIG_WERROR=; unrelated files emitted
pre-existing W=1 warnings.
Boundary test on two isolated KVM hosts: the eight-tag packet
was delivered and the nine-tag packet was dropped.
Original nested vhost/TAP trigger on each host: ftrace recorded
eight skb_vlan_untag() calls and zero tcp_v4_rcv() calls; no
KASAN report, oops or panic was observed.

 net/core/dev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index 397fd0f9cc7a27..058965698004dc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5760,6 +5760,8 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
 	}
 
 	if (unlikely(skb_vlan_tag_present(skb)) && !netdev_uses_dsa(skb->dev)) {
+		unsigned int priority_tag_depth = 1;
+
 check_vlan_id:
 		if (skb_vlan_tag_get_id(skb)) {
 			/* Vlan id is non 0 and vlan_do_receive() above couldn't
@@ -5771,6 +5773,10 @@ static int __netif_receive_skb_core(struct sk_buff **pskb, bool pfmemalloc,
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
