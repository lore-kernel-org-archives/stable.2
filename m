Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392943A874A;
	Fri, 14 Aug 2026 09:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786701341; cv=none; b=cq+U3aoGp6hsUKHGSbc/gSb/SdiupOZJFaX5Mef091Eofr8E3WMSzz/mddMESUeifFDU3OjrRjf86pmtpUX6fXUXHx6z2yOSGkoV50c6G5X/frwSYRWjPpP9lCBjbmJV14SVETCOqpjoCOA4N5n1Rx1eKQU9D0pNYRRBkVwbrmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786701341; c=relaxed/simple;
	bh=hmKchBNPKMjWFJUKwEJ+toH35ASC4JlF5iDo6YCsMI4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ye0mJHBfhHlAdDqIpSgqb79oHu6CVbEEOe/B6RG5H+GsxHk2r/gyNTwxxSU/12LbaK4kOoBxPq1v4Af1KrAbidJpmQ26u94bLQfUNc3sVkD7GLsRAKjiU61D4GjmIiNhiIGQSesG6ko/vEiGpnRWUaF4erQ4u+/pa10nns7bOKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JNq09U4Z; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=i04ZJt+t; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="JNq09U4Z";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="i04ZJt+t"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4hLyK21ZHKzKnQr;
	Fri, 14 Aug 2026 11:55:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786701334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z1V1huwI7s1opkOH2G7+P7J87ZrDyGAz9YEL7He2GFM=;
	b=JNq09U4ZHj0m/1zoUkqT7ZWIDTdWqLOhR+V3a6q3Iph2TMsaLoBuVNdXHh0foeeKRArjmR
	0/At4ADbJRJC9W4e7fmpYNbDzBO4TCG2Cb1PmBF9nbyFeCgD1stSuQ8sXa826fhk6ko/Y+
	E3MufJ6Fw61N2K+eS/bAUt9w88EJhD1nbkJ1CB7A7ISf527B6GezkoozJsOAV8Xfya/yxs
	xoW+NatvPYLvSCsyX3R1gpNT549q9GjKacso6/csW+qF14fjErGFLUyKhhMXOGjohr+qVN
	ncQnID7KI5Pwpsf4E0kLU398zoRcCqCYqeU6q20MkWHMw3bTNhVfae3zlCAjCw==
From: Qing Ming <a0yami@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1786701332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=z1V1huwI7s1opkOH2G7+P7J87ZrDyGAz9YEL7He2GFM=;
	b=i04ZJt+tYgmS+QCSgmdTOnqdVC4pcpCOlqfaMOi7eVDYPdsvbGbPEJEjQeaQnih4wTR3/F
	WvLp615fVvmUL8Km8wzJxZr+H9Ug5Gav4tqG5ajymgBDLwx6wU01wvO5Vmc/oyEgM1fIH2
	NnBtyOa/6W30DAptnKcwrV18gXmd7KhjXl+NT4Ym1MQ3wFFYe7l5bUSWWpg+khRbJPY2+k
	KGW/UluCbawDXnzb2NSzh1E9QyOMlzVOF4JrxcRnI75YZjUaKFmLEHgvhEdk3cdviG3l/x
	nCgFHI7GmxXcPIEULHAbMKDlm0ATZeoFEWwxDuq3RLV164bkNDAvrk5GbTU7qg==
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Guillaume Nault <gnault@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	David Ahern <dsahern@kernel.org>,
	Robert Shearman <rshearma@brocade.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qing Ming <a0yami@mailbox.org>,
	stable@vger.kernel.org
Subject: [PATCH net] mpls: reload header after pskb_may_pull()
Date: Fri, 14 Aug 2026 17:54:04 +0800
Message-ID: <20260814095404.7205-1-a0yami@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: twju1161ye747869k1efat4y8dsbxu61
X-MBO-RS-ID: 222a4c73fd0df02ca95

mpls_select_multipath() calls mpls_multipath_hash() to choose a nexthop
when an MPLS route has multiple nexthops.  While walking the MPLS label
stack, the hash routine caches hdr for the current label.  After finding
the bottom-of-stack label, it calls pskb_may_pull() before reading the
inner IP header.

If an skb is constructed with the inner IP header in nonlinear data and
insufficient tailroom in the linear head, pskb_may_pull() calls
pskb_expand_head() to replace the skb head and free the old one.  This
leaves hdr pointing to freed memory.  The IPv6 path can invalidate hdr
again when it performs a second pull for the larger header.

The issue was found through static analysis.  A reproducer sending a legal
Geneve packet through a bareudp/MPLS multipath setup triggered the same
KASAN report in 2 of 2 unpatched runs:

  BUG: KASAN: slab-use-after-free in mpls_select_multipath
  Read of size 1 at addr ffff88800ecc6e20 by task ksoftirqd/1/23

  Call Trace:
   mpls_select_multipath
   mpls_forward
   __netif_receive_skb_list_core
   netif_receive_skb_list_internal
   napi_complete_done
   gro_cell_poll
   __napi_poll
   net_rx_action

  Freed by task 23:
   kfree
   pskb_expand_head
   __pskb_pull_tail
   mpls_select_multipath

Reload hdr from the current skb head after each successful pull before
deriving the inner IPv4 or IPv6 header pointer.

Fixes: 9f427a0e474a ("net: mpls: Fix multipath selection for LSR use case")
Cc: stable@vger.kernel.org
Signed-off-by: Qing Ming <a0yami@mailbox.org>
---
 net/mpls/af_mpls.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 961be5054a03..17b78dcbf8ab 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -221,6 +221,7 @@ static u32 mpls_multipath_hash(struct mpls_route *rt, struct sk_buff *skb)
 		if (pskb_may_pull(skb, mpls_hdr_len + sizeof(struct iphdr))) {
 			const struct iphdr *v4hdr;
 
+			hdr = mpls_hdr(skb) + label_index;
 			v4hdr = (const struct iphdr *)(hdr + 1);
 			if (v4hdr->version == 4) {
 				hash = jhash_3words(ntohl(v4hdr->saddr),
@@ -231,6 +232,7 @@ static u32 mpls_multipath_hash(struct mpls_route *rt, struct sk_buff *skb)
 						 sizeof(struct ipv6hdr))) {
 				const struct ipv6hdr *v6hdr;
 
+				hdr = mpls_hdr(skb) + label_index;
 				v6hdr = (const struct ipv6hdr *)(hdr + 1);
 				hash = __ipv6_addr_jhash(&v6hdr->saddr, hash);
 				hash = __ipv6_addr_jhash(&v6hdr->daddr, hash);

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.53.0

