Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 369EF24A05D
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 04:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791692100; cv=none; b=IjOQLPnwE/FiW1P7RBlk1BW7PRZHeKAP19hcDQeT6vGPwE+ro0gkEP6tnu3yrh3XBe0eBfGOZ6Zb6igQSGfqMWJDXfVYDQRNKmFgJw3xWADmu2utFAykzGWqDXAWZQzZIVyZqdeepiKZrnc/bdgDyu9i6nXoUwEFOeVpmehbAsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791692100; c=relaxed/simple;
	bh=l1a/bWcOT2l+X9e047O+Zc0VAnzVT8S5JAO8GTa3MUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fa4kAzRtFYCjR0Es7g+gJc8uQLYVr6cx5ltG1+Ge6fmAMj+Kfa0U0bkYmQShp+Z1uFSseQEMTtbroSsGBXxXivk7oJqY4kkAYRg9RJQThuJokT0kgYl+N4jYo2ZM0O2tfXdsCR9pIY24p3AJLZdcUE8MxZkjkR8JfrcSM3ubZcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o9yaV1U3; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9yaV1U3"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso2237752eec.1
        for <stable@vger.kernel.org>; Sat, 10 Oct 2026 21:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791692098; x=1792296898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=q235uDx+bpsRBMkhHfqYFd51DmOA87ePC3AWPxfUoj4=;
        b=o9yaV1U31wMmnaQHL+ez2fnFFV6N2pMjGb7lpKu/NOchnIWtlQHVoMAetbRVK5/u/g
         owUsBcxgBk6AL3iIBgIe0QBqbabPSw9m1QVp7om0bRN7vk0MVsWdAlxDV/QC29Juibay
         9nPuauqETthi8aR8Jr/CeCgXnSmm9jRsiSj/6/BHlfoYfEnJP/N4KujOgJmp7o0ywmDQ
         rK6Ka3gFNcRqv/IwRRrmblBV1wo7Yxj1DX61jp9sPwME5HOlUGC7i/OtfzxlJNBRNaNr
         4CMW2TIu8575AV75Ts3rDQVUT7nLSinLxBQKzhAZoYPFNQ0A4apdc1zQYCDu74NhhbQr
         VGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791692098; x=1792296898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=q235uDx+bpsRBMkhHfqYFd51DmOA87ePC3AWPxfUoj4=;
        b=0gVYxpoCilgLuGaYKi+OtbHbmBQnSToAeRneQvIZvzziTOfhPoFywY/fLEz9aD0Pgf
         +sJBH0u3TQQLLHY7tbj3g5VJIOhc+ZkhF+ZAgttWp9Ea/I6oJ3zYi9LxlO4a/Co5C+s4
         9ZgCoN0RtNPOeGNytjhhMFw31+Qt/fcney0fzOQ5053RvSDzuN9g+0wCfm8dxbYsAm6k
         bbZWzQAINGkEDAilpUOvUW756FyMLW7AoBwUmjewzDjfpEMZPWE2DMsMHmD4SrSz3IYm
         yOUnjtH37HPpPCzmU4T6JTds2jpVwDApJsu2S3JgyIwIYBZz1VwlaUBQgjXAXnTSuHl6
         CliA==
X-Forwarded-Encrypted: i=1; AKwUvBxd6wT4aQac+inPdZtGrRGaeI4Ep9TNlYeetF95MfmC/rgCPTvROTblD7KhCYfgTc8lEa2p3vY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhSEUYCsK8ipqF1ECgSBTWjPFbzTV49/1ClcfleprVj1gnzvz0
	uXlH/RTdw3Hne9BUBHFvZaDVzbMJrKOueSgr3FNhb5si2OcVAgkhmWnR
X-Gm-Gg: AYBFou3XfxnZkaCusqobC/Qtry/tW90t6KDSVVex5tRyDuJwDiVDHLqxaTWeQ26YyLe
	RUKXM5ihskXbpk1oXHJsudF62R6vOFjg2jLgvcB+TQYFyrdbA2JKrjikGhqerqaLLWMwFKIIXjj
	5Av8gQIj/IQtHb3J11Vgu1NjH/knS39FtqmjFuT0ynrvCKJcQ4pgqkxSueMvXaKxI5Kf0rKMrFR
	l0JWH4YN6iotjLPuu9K0ju5jNgLHyWtZ+l8POHWKQiA/puPmjgH/m5i5PlsGVi0MGBHykWnoQ/I
	8qcZX4tSzeF7CkaimQJMaoVFQEeLTNI8ZA0d9Jg2E9YiaQGvV9wOTJa9dJQIoPRLs6KoH/OHvfu
	5ZN80s9SB5owsxJ4gHswWsaW5iJs/PWkl76Y0Ol7244sA9LMRi2jsX1snZRNSbKQzq1fqGtYF/p
	LgjZZqIEM0m+DL2phfwb9fjF1oFskxUEcGWTZQu0BukrJyL/W9oMS5iHAyjUo3o0Y1HP4wVk7TZ
	QwqBXDbKdydb+ZbI++OQ8blOjUXIPpEDPFLkSvILr8=
X-Received: by 2002:a05:693c:60d4:b0:359:2f0b:aa89 with SMTP id 5a478bee46e88-3592f0bc083mr2769453eec.10.1791692097980;
        Sat, 10 Oct 2026 21:14:57 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c843079sm19707164eec.1.2026.10.10.21.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 21:14:57 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	zjamg <ndaugoing@gmail.com>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org,
	co+b3e1928dd33a1bd6@bugs.sh
Subject: [PATCH net] net: mpls: keep transport offsets valid across label changes
Date: Sun, 11 Oct 2026 12:14:37 +0800
Message-ID: <20261011041436.1424222-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

skb_mpls_push() and skb_mpls_pop() can leave a transport header at or
inside the moved MPLS header behind. Repeated pops then make
skb_transport_offset() negative; when a GSO skb is redirected to egress,
qdisc_pkt_len_segs_init() widens that offset, wraps its pull length, and
dereferences about 4 GiB past skb->data.

For tunnel GSO, qdisc_pkt_len_segs_init() uses the inner transport header
instead. skb_mpls_push() rejects encapsulated skbs because the networking
stack does not support simultaneous tunnel and MPLS GSO, but
skb_mpls_pop() did not. This leaves the same negative-offset path reachable
through stale inner metadata.

Align outer transport headers at or before the affected network header
with its new position while preserving valid later L4 offsets. Reject
encapsulated skbs from skb_mpls_pop(), matching skb_mpls_push(), and
refresh mac_len after a pop.

BUG: unable to handle page fault for address: ffffed10408b8e0b
Oops: Oops: 0000 [#1] SMP KASAN NOPTI
RIP: qdisc_pkt_len_segs_init (include/linux/tcp.h:31 net/core/dev.c:4193)
Call Trace:
 __dev_queue_xmit (net/core/dev.c:4835)
 tcf_mirred_to_dev (net/sched/act_mirred.c:242 net/sched/act_mirred.c:237 net/sched/act_mirred.c:328)
 tcf_mirred_act (net/sched/act_mirred.c:489)
 tcf_action_exec (include/net/tc_wrapper.h:59 net/sched/act_api.c:1162 net/sched/act_api.c:1136)
 tcf_classify (include/net/tc_wrapper.h:178 net/sched/cls_api.c:1779 net/sched/cls_api.c:1875)
 tc_run (net/core/dev.c:4463)
 __netif_receive_skb_core.constprop.0 (net/core/dev.c:4538 net/core/dev.c:6115)
 __netif_receive_skb_one_core (net/core/dev.c:6262)
 netif_receive_skb (net/core/dev.c:6377 net/core/dev.c:6463 net/core/dev.c:6522)
 tun_get_user (drivers/net/tun.c:1595 drivers/net/tun.c:2045)
 tun_chr_write_iter (drivers/net/tun.c:2091)
 vfs_write (fs/read_write.c:595 fs/read_write.c:687)
 ksys_write (fs/read_write.c:739)
 do_syscall_64 (arch/x86/entry/syscall_64.c:61 arch/x86/entry/syscall_64.c:84)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
Kernel panic - not syncing: Fatal exception in interrupt

Cc: stable@vger.kernel.org
Fixes: 48d2ab609b6b ("net: mpls: Fixups for GSO")
Reported-by: <co+b3e1928dd33a1bd6@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/core/skbuff.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index cc3b4b702..c09bb8ac2 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6612,6 +6612,7 @@ int skb_mpls_push(struct sk_buff *skb, __be32 mpls_lse, __be16 mpls_proto,
 		  int mac_len, bool ethernet)
 {
 	struct mpls_shim_hdr *lse;
+	bool trans_update;
 	int err;
 
 	if (unlikely(!eth_p_mpls(mpls_proto)))
@@ -6630,11 +6631,15 @@ int skb_mpls_push(struct sk_buff *skb, __be32 mpls_lse, __be16 mpls_proto,
 		skb_set_inner_protocol(skb, skb->protocol);
 	}
 
+	trans_update = skb_transport_header_was_set(skb) &&
+		       skb->transport_header <= skb->network_header;
 	skb_push(skb, MPLS_HLEN);
 	memmove(skb_mac_header(skb) - MPLS_HLEN, skb_mac_header(skb),
 		mac_len);
 	skb_reset_mac_header(skb);
 	skb_set_network_header(skb, mac_len);
+	if (trans_update)
+		skb->transport_header = skb->network_header;
 	skb_reset_mac_len(skb);
 
 	lse = mpls_hdr(skb);
@@ -6669,6 +6674,10 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 	if (unlikely(!eth_p_mpls(skb->protocol)))
 		return 0;
 
+	/* Networking stack does not allow simultaneous Tunnel and MPLS GSO. */
+	if (skb->encapsulation)
+		return -EINVAL;
+
 	err = skb_ensure_writable(skb, mac_len + MPLS_HLEN);
 	if (unlikely(err))
 		return err;
@@ -6680,6 +6689,10 @@ int skb_mpls_pop(struct sk_buff *skb, __be16 next_proto, int mac_len,
 	__skb_pull(skb, MPLS_HLEN);
 	skb_reset_mac_header(skb);
 	skb_set_network_header(skb, mac_len);
+	if (skb_transport_header_was_set(skb) &&
+	    skb->transport_header <= skb->network_header)
+		skb->transport_header = skb->network_header;
+	skb_reset_mac_len(skb);
 
 	if (ethernet && mac_len >= ETH_HLEN) {
 		struct ethhdr *hdr;
