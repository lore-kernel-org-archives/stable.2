Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5611F1534
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 16:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782406092; cv=none; b=URdOy1ddCTirdpyIwFOB6swMHQemTWeOT0dENQelTfBRiHAQDLTaK9s0vZgVWlkH34RHMGgNzlQCtWStQQHs7PIv9z+mCyXrwWRZgMSegDgdpJLebPx230MQlPbtt2c9PzkYekkhQWic+6IsSs+D9FcjuBGkID4KIM/jd3ph8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782406092; c=relaxed/simple;
	bh=qJXI9cST/Ra4iPabxPsgyOZ02qsLz7Yx5c5nuJyWipc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJ60YY4/uChZNVFbOVtGJ/N0bM7EYGACC7FgblB7TUbg1srx6mXJGS6maR1nOCtH8DEvy+UnScZv9Kxyfsvl3eSMr4hpsepkCW6f9Iapjp1BhOMCMnnXvJ4MC7ZTv4kI5v7bEF4lZ03FdmzsGTKri/W7TfJLelad1q6RVrKke/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbTceOUm; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbTceOUm"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ad49c55ce1so13541e87.0
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782406088; x=1783010888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3pAbo57p2f1Q9HCCJXSOkq8MR7Ngd8saF5gl2eKPd+4=;
        b=BbTceOUmtGQvPj5dQ4/HO469r73QPy1QKeBBapzHSVHuaB8Je2a+DhP85Ikvm3vgyg
         bYRWIB8yJJrzax3iiW89TCj9joiRuKs+Q/RcXKqYLEm27SNJ6l92T+KL3qVR6U6Gpea0
         iPJGhSfTkySq+abPKMvswVLv0PId8lmK/u5NtgfmPLRY9c7pgdjk6hIES4HF7YhFQOqx
         2gMz/h8PCj1SAWU943cvEtelazpaIPb2dz1xV+36Ys/EzCnyx0y2vtHkMgl+WRruNdsL
         0g3TysQqTZ/KIoncx8f3LRch5oElY6KtkyhFMCWjd179/CZl7eIye++8P7TooP1xQuLu
         tCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782406088; x=1783010888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3pAbo57p2f1Q9HCCJXSOkq8MR7Ngd8saF5gl2eKPd+4=;
        b=JVvvi5ZNsrY8rWMEh1saqQvzt2ijbNiOnAE66IJq1UH10rEcgCFHTN2Cy1l/oaQ3Ia
         16JFKWFyGR3sWwABiDuGo3bp7SnFoTmmq6VlJ7BoiZ+40UkOFiT/0H+rYIXa9y2egl7H
         53XEMN8VIyPEzXdJR6U0ixp8yqew3uwfDdCRgFCoRxJ8YnL08NWQ7uP7w8wS032ur37E
         JjNdDI2q1+yl52ZjSQEBBu2EfyuXoFHV1Z0O3ZfWD3nVE6+Nqs3WXCeYMcSwfBBNoHpK
         2ycWODyaWPdz6kOjo3SdonBItmogrBzKUcRYtO01KZ+hAmCGKdjWDRWF9sFYAvACdZ4f
         oxpg==
X-Forwarded-Encrypted: i=1; AHgh+RpnLvC4JHb10a/kW88ANe841iUYuKYmpkjUoJFxMExcogqYOGcse2oo4yUBLx7KihGW8zCKZKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV/M6uoefrwQaniSg0czShfMg9P72P3JAQfjbWPFKzXy6xOZ8x
	8YYVhiBbRtVoZtZPUwqgtiUtov3fQka6rAYrmqerClDtkjxAueBPlqyX
X-Gm-Gg: AfdE7ckiPgv8o8BDetqGBXttvr61NJMGSi4IS7htuHc9JlkqxWI0UCUg/jJ7Rw2kcdT
	T8XDR0623w7YZtP2iFydQfKdOytUKkRmdke427oxH0z0nySLWVhBmp8hVqT7gT2dt0n8ro5pnan
	jdvF6ll1R6Cz7oEwmVwp+jQeobKP+2zsaI4Li18Xvh8MIvoCHIMZOb2CGoMS+yPRhz4BK10e5GV
	VqIYiz6sM+5LdscgQz6AOHxZqBZ8GbRl+0c9TSQyUYEs1xpaYilvic6NhcaDCAVK9yhbCsWBB9j
	9659ItcdJKumlFYIFNzuGw8XCaudr/oceqBD0CoWJvApKCOR6ciMSoeeickOicZ+F3HjGX0a0BD
	1nuEXfEemEFVoXTFdaMWlio17mJhibcad0WGZwMqT7LPXQ3G4QVJ5PVAcAERoNmeFYp4ovaotda
	kN3QGl78YCWXN32nZajpL7bctUGFw82jLM0H9qOQY=
X-Received: by 2002:a05:6512:228e:b0:5aa:6b0b:1f40 with SMTP id 2adb3069b0e04-5aea1f3481dmr1155973e87.2.1782406087610;
        Thu, 25 Jun 2026 09:48:07 -0700 (PDT)
Received: from grower.astra-academy.ru ([185.32.135.49])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69555c45sm2785934e87.36.2026.06.25.09.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 09:48:07 -0700 (PDT)
From: Alexander Martyniuk <alexevgmart@gmail.com>
To: sashal@kernel.org
Cc: alexevgmart@gmail.com,
	bestswngs@gmail.com,
	coreteam@netfilter.org,
	davem@davemloft.net,
	fw@strlen.de,
	gregkh@linuxfoundation.org,
	kaber@trash.net,
	kadlec@netfilter.org,
	kuba@kernel.org,
	kuznet@ms2.inr.ac.ru,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel,
	pablo@netfilter.org,
	stable@vger.kernel.org,
	xmei5@asu.edu,
	yoshfuji@linux-ipv6.org
Subject: [PATCH v2] netfilter: nf_log: validate MAC header was set before dumping it
Date: Thu, 25 Jun 2026 19:47:55 +0300
Message-ID: <20260625164755.161383-1-alexevgmart@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625054005.0003.nflog-510@kernel.org>
References: <20260625054005.0003.nflog-510@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiang Mei <xmei5@asu.edu>

commit a84b6fedbc97078788be78dbdd7517d143ad1a77 upstream.

The fallback path of dump_mac_header() guards the MAC header access
only with "skb->mac_header != skb->network_header", without checking
skb_mac_header_was_set(). When the MAC header is unset, mac_header is
0xffff, so the test passes and skb_mac_header(skb) returns
skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
dev->hard_header_len bytes out of bounds into the kernel log.

This is reachable via the netdev logger: nf_log_unknown_packet() calls
dump_mac_header() unconditionally, and an skb sent through AF_PACKET
with PACKET_QDISC_BYPASS reaches the egress hook with mac_header still
unset (__dev_queue_xmit(), which would reset it, is bypassed).

Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
uses, and replace the open-coded MAC header length test with
skb_mac_header_len(). Only skbs with an unset MAC header are affected;
valid ones are dumped as before.

 BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/nf_log_syslog.c:831)
 Read of size 1 at addr ffff88800ea49d3f by task exploit/148
 Call Trace:
  kasan_report (mm/kasan/report.c:595)
  dump_mac_header (net/netfilter/nf_log_syslog.c:831)
  nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfilter/nf_log_syslog.c:963)
  nf_log_packet (net/netfilter/nf_log.c:260)
  nft_log_eval (net/netfilter/nft_log.c:60)
  nft_do_chain (net/netfilter/nf_tables_core.c:285)
  nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
  nf_hook_slow (net/netfilter/core.c:619)
  nf_hook_direct_egress (net/packet/af_packet.c:257)
  packet_xmit (net/packet/af_packet.c:280)
  packet_sendmsg (net/packet/af_packet.c:3114)
  __sys_sendto (net/socket.c:2265)

Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to print decoded MAC header")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
---
 net/ipv4/netfilter/nf_log_ipv4.c | 4 ++--
 net/ipv6/netfilter/nf_log_ipv6.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/netfilter/nf_log_ipv4.c b/net/ipv4/netfilter/nf_log_ipv4.c
index d07583fac8f8..d6164e8e2c73 100644
--- a/net/ipv4/netfilter/nf_log_ipv4.c
+++ b/net/ipv4/netfilter/nf_log_ipv4.c
@@ -296,8 +296,8 @@ static void dump_ipv4_mac_header(struct nf_log_buf *m,
 
 fallback:
 	nf_log_buf_add(m, "MAC=");
-	if (dev->hard_header_len &&
-	    skb->mac_header != skb->network_header) {
+	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
+	    skb_mac_header_len(skb) != 0) {
 		const unsigned char *p = skb_mac_header(skb);
 		unsigned int i;
 
diff --git a/net/ipv6/netfilter/nf_log_ipv6.c b/net/ipv6/netfilter/nf_log_ipv6.c
index 8210ff34ed9b..cc724870a467 100644
--- a/net/ipv6/netfilter/nf_log_ipv6.c
+++ b/net/ipv6/netfilter/nf_log_ipv6.c
@@ -309,8 +309,8 @@ static void dump_ipv6_mac_header(struct nf_log_buf *m,
 
 fallback:
 	nf_log_buf_add(m, "MAC=");
-	if (dev->hard_header_len &&
-	    skb->mac_header != skb->network_header) {
+	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
+	    skb_mac_header_len(skb) != 0) {
 		const unsigned char *p = skb_mac_header(skb);
 		unsigned int len = dev->hard_header_len;
 		unsigned int i;
-- 
2.43.0

