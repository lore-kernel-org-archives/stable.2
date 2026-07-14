Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181AF383305
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784029750; cv=none; b=a1cFPBwCWdcBkTgLAcoWWXLtET4fx5pKwMjqPQ+kdx5BBybI+LA6MG/Vvxf4lse4xoo0lVaxwbf8FFQF6jWBVAPjN17M2Le55tkbZUJlSlM3/K3VcRRSfizloPr2JZcr2+p+CzcDrOlmTRymMBuPrS1QUZg0gu4tdh0WLWGJSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784029750; c=relaxed/simple;
	bh=ZGYvGbRP+oXuIcup1YsFuHoUmTi9k6xwxTD9TCdJ5qw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sUIokS1gwWOlghKeKASoehrtRmoFeBwFAnPwnN5oP7p/xo+yqfJb3ZqoQXvxXVJGwT3XNxF2YHxrWQtOTWqx9fCoScUmgTM34N2y2AEmu3uayS9/JCNz8AUUZ29DhrqTt9ESw6y/Yg8eRU/l0KEFd9YmxN4R08rpPo+MxLCmodA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=svBsPqnv; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svBsPqnv"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92edb12cdf2so55088985a.3
        for <stable@vger.kernel.org>; Tue, 14 Jul 2026 04:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784029748; x=1784634548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1JUpepjd+suSCp2cPlkh7EA3gKkiN6bvfQtDVC0IsC0=;
        b=svBsPqnvkfvOh7NfF2v/W2O1G/xVRiQ1CYms/5QQcPbKrP86JXGBzWXil0GWK76PlT
         iccXMG8hC5ux0WGtLTTq/WYtEjSXbW+RpKgXq4S2EkrIDfLayt8/q+CFdCWxc3ZteKYS
         Qdos3iQqkJDuwoXnCh4iKL8qW171KTCTvJjOJxxfb+EytwDbR5fEsF1THk0HOSOO/0C3
         ZNtTV5EPnc6IWSdHr4sTqOu9PEBvbyP/VNDk8lDmAIbgyuPtz1ShP8DbrTNDLRGykPn2
         MBQ23o24jGX/SpuCG26KYnEmMY1rMtseq2A0CCWGf37ry6ssuWf9sng86RBaES8PlhZ8
         LOiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784029748; x=1784634548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1JUpepjd+suSCp2cPlkh7EA3gKkiN6bvfQtDVC0IsC0=;
        b=ghv7+WyyczXY65PTG0Yc4UKvAgUSnfwQwZNSEV2zitLsya3lOLkSiN7OXA8yC9M3iF
         yC/s7RgKm+Ze5li67tz0snuZuwtqS1IXBCVmlXaHuoRlNZX1dr/FRhbmydwrliSEcFec
         ALK1BVH9CVgnFJ5upH45LFyM3g08V9J4uouOnqOrSldS+It8GtGdII80gGRJ+LkVr3yr
         vXHcR9HT1Xo46TLwN2iC++cch8zsXaZ7uLhQGLk+/5+FZ+/ZiGUtk0Fymj/fRABtSAcx
         wtHRa5cGIOFEupzbgGivpfxniSgswBJIKXpydWmPjQGURU6qotw4fr0ZzaBRnCERMm82
         rg0A==
X-Forwarded-Encrypted: i=1; AHgh+Rrcutru2gH8MesjUKNNBvn5JPcU3Al56n/pd1uaXBeHwkuQKffP/K7AC5hnuectk4fFW2191gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrtzINojVx9vE/rTxt89Cnm3ifmdaEOlUDYrukLBpZQuE+lxZq
	Js/4qpERiDU0/0oq0DKpTAoFhR7Yl99DC1Z4lE2E/NBGU9eKL9g7yD2b
X-Gm-Gg: AfdE7ckmZ2bUfw7IGcSGMmXIoGeFaGzyz7jHBa4ZbTTS7knPchY0aRbZqaBUtNBuob1
	g/5cHrXPpK0HiHB5anIrQRnY2VJkUvLg4fvt4Vrd/sikUl08Y1TwkdO4s5QQtukmfNtDo1Yi4vP
	AMgELP/rCw158BWRQZ/bDDn5Sq8dvKjgsu8uHty1mEkhYSOj05IIGFBQBTC5yym/+kzU1ZVm/eO
	uZdKh5Lbc3hbDw+PfI379cSSK1pIxL5Bl9v3WLNi/kvKiuAZMeeVRXuLT52Ijo14dbmH8XKd8Eg
	v8/MjaDCbiS/lQHTmf07eUm/wvBqZAlpb2RuwdO88YtXSdE7Ham8ZBP/me9VQB+E4mrGuOESyFb
	wdCiNaFE7QFFNI2jkX5RFkYm0PBhgJPlbevLguLPvG0BeE7mihv92uL4V4aZC0O/dUl1wgs9WFt
	bso6ar7AcdMxA3A3+fLfuwWJyWl8X5JV8di7eEM5GnA1hA+gmGZ5eIirdsEhbdEVfa1mVpKQsWQ
	O42eNvTrw==
X-Received: by 2002:a05:620a:258c:b0:92e:54b1:2881 with SMTP id af79cd13be357-92ef2bb787bmr1289546185a.16.1784029747886;
        Tue, 14 Jul 2026 04:49:07 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5baaab7sm1500521585a.19.2026.07.14.04.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 04:49:07 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Antoine Tenart <atenart@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Tom Herbert <tom@herbertland.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v2] ila: reload IPv6 header after pskb_may_pull in checksum adjust
Date: Tue, 14 Jul 2026 07:49:03 -0400
Message-ID: <20260714114903.3763420-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

ila_csum_adjust_transport() caches ip6h = ipv6_hdr(skb) before calling
pskb_may_pull(). On a non-linear skb whose transport header sits in a page
fragment, pskb_may_pull() can call __pskb_pull_tail() / pskb_expand_head()
and free the old skb head, leaving ip6h dangling; the following
get_csum_diff(ip6h, p) then reads freed memory. ila_update_ipv6_locator()
uses ip6h (and the iaddr derived from it) again after the csum-adjust
call and additionally writes the new locator through that pointer.

Impact: a remote IPv6 packet routed through a configured ILA
csum-adjust-transport route or receive-side mapping triggers a
slab-use-after-free in ila_update_ipv6_locator() (KASAN). The route or
mapping requires CAP_NET_ADMIN to configure, but trigger packets are
unauthenticated once it exists.

Reload ip6h after each pskb_may_pull() in ila_csum_adjust_transport()
before the csum-diff read. In ila_update_ipv6_locator() only the
ILA_CSUM_ADJUST_TRANSPORT case pulls the skb, so reload ip6h and iaddr in
that case alone before the destination-address write; the neutral-map
modes never pull and keep their cached pointers.

Fixes: 33f11d16142b ("ila: Create net/ipv6/ila directory")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
v2: In ila_update_ipv6_locator() reload ip6h/iaddr only in the
    ILA_CSUM_ADJUST_TRANSPORT case instead of unconditionally, per
    Antoine Tenart's review; the neutral-map modes never pull the skb,
    so their cached pointers remain valid.
v1: https://lore.kernel.org/netdev/20260711150648.2915106-1-michael.bommarito@gmail.com/

Evidence: a KUnit case on UML+KASAN drives ila_update_ipv6_locator()
with a non-linear skb whose transport header sits in a fragment, so the
pskb_may_pull() in ila_csum_adjust_transport() reallocates the head.
Stock: BUG: KASAN: slab-use-after-free in ila_update_ipv6_locator, Read of
size 4 (the stale ip6h/iaddr). Patched: both the valid-linear control and
the fragmented case pass, KASAN-clean. Built clean, no new warnings.


 net/ipv6/ila/ila_common.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index e71571455c8a0..b78179bfc4c72 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -85,6 +85,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			struct tcphdr *th = (struct tcphdr *)
 					(skb_network_header(skb) + nhoff);
 
+			ip6h = ipv6_hdr(skb);
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
 							diff, true, true);
@@ -96,6 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 					(skb_network_header(skb) + nhoff);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
+				ip6h = ipv6_hdr(skb);
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
 								diff, true, true);
@@ -110,6 +112,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			struct icmp6hdr *ih = (struct icmp6hdr *)
 					(skb_network_header(skb) + nhoff);
 
+			ip6h = ipv6_hdr(skb);
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
 							diff, true, true);
@@ -127,6 +130,15 @@ void ila_update_ipv6_locator(struct sk_buff *skb, struct ila_params *p,
 	switch (p->csum_mode) {
 	case ILA_CSUM_ADJUST_TRANSPORT:
 		ila_csum_adjust_transport(skb, p);
+		/*
+		 * ila_csum_adjust_transport() calls pskb_may_pull(), which can
+		 * reallocate the skb head and leave ip6h (and the iaddr derived
+		 * from it) dangling; reload both before the write below.  The
+		 * other csum modes do not pull, so their cached pointers stay
+		 * valid.
+		 */
+		ip6h = ipv6_hdr(skb);
+		iaddr = ila_a2i(&ip6h->daddr);
 		break;
 	case ILA_CSUM_NEUTRAL_MAP:
 		if (sir2ila) {
-- 
2.53.0

