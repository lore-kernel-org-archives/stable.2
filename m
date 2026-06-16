Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720CA44CF44
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 15:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781625291; cv=none; b=iEft5syrTuqnIDYZ6glH3E9/fIvjBO3I+sx7PfoifL1/Fg5jzJpXuglkXRzOJL6KSaQLBxOqmOpOhpH7XT3q6ac54SbEDBYJtJgRIVYO7uTShXENXyVDDsDRbu3+SSPJTRjUJYC0mxjmD3E8+Xc19s37qfVOjQXoKvYHMVNT3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781625291; c=relaxed/simple;
	bh=kPsBXBQZd4RSwEAJE0jh1oeFj5ht5bL87RD+a9y60iI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iQiFo33ad6JUHrqdGqJCFcv9W7Agd7+wlg/iPMpMzhJxV2VLWIzZm27MlDFLGbprSp16ks+uktaE9tyrFFCgSct72kVx7+zPF3TWp1JlzsPLj7OyQV9LPlVwCINDh+FJq+JybUAK5zwx2rnYDhKwAbWtSrAnWjKNIBLHb+lN2Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYQGBYwS; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kpberry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYQGBYwS"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c859d79c10eso4472351a12.0
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 08:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781625289; x=1782230089; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qrS/vFPCdRwb3zPYLcwa3HFwaCgjcl+1WFfv9jwbE10=;
        b=IYQGBYwS2aw8YJFU+VQm5Jrpx7qwJ70FmlYRpHxOrstndjpJE6f1HgOvxFWQcmndvM
         CTp9w08YvhjNCrcKDff2ScE5aGT2/NUe39ytGCuh9sB89WT+8X9WW0TYSQRY1A+l6Bqc
         6nO1mk5WeWnETRhd2N+xDMlh9YRwrBST8vooqQFCPh9iM1OdAs4L2QQP9nFE3n3zgL0G
         hbUVzW/tCZciPwqr9OS3g83kiulJx/6BbaG6GaULa0y6lcoWPpB+XL7dBoib0RTxOqE8
         vcR41dhonAPFcH4M50zaceO3US8e3c+ktWYIfJUmJQpnPomkSlSoVY34qmqBshfI6QRr
         Rllg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781625289; x=1782230089;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qrS/vFPCdRwb3zPYLcwa3HFwaCgjcl+1WFfv9jwbE10=;
        b=nd8IKBKrSKk2IvbxT5gK1nJ3NsnC9v1gtInDrO/L59TTzJwkwZ7MbKlCglptJe0K+a
         DRtMsE4GvJ2Bnyam4MMOLhsvRFo0eyfYQaC+oz2t/JzR6HzjUu9VchnaNgFB/NL86tWr
         7F0qhorTV76+fWxWYNgsRj9UINzmBRG2epThkuuqM/Uug5ZotY6YkFcn1ti3K/ZuxaJJ
         xEjcEgvQABcWRgKg1K6ERKpSKjfvHIp8zbzQIJdoXXBSNgn0g1Q2ALYlL2iSfoR6RTEu
         qLvILK4xCn32iSHBqXolskS4UIhIU7HNjcVfDEMqkHXb+ijSROzM/Aa/xg+zztudBl/f
         Gviw==
X-Gm-Message-State: AOJu0YwQKDY5U4Rk1aTRJQgaXaaqSWQbixIsLYLoskvzdjAEQ7AtxalB
	c/LG/ZDWycJAXyAd3ZRM9ZgKqG6QozGtFrai1Aq6W836jjaV3dCOzammA0bUE2zzdSmErmoWMpJ
	wV/Oc7Rjsojh6vFQXbJUMW5nBd+2491ceKNvcWpE1XfaOSVrmL6by+bZ55Fug+POqclo5912Ehv
	OPcQNBmJqvrw/H54gCdcg2EJA6nGUGFCeeFhqSNfvzVQ==
X-Received: from pgla26.prod.google.com ([2002:a63:b5a:0:b0:c85:62f4:f188])
 (user=kpberry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:350d:b0:3b4:8f18:326
 with SMTP id adf61e73a8af0-3b783dbce10mr22144982637.10.1781625288354; Tue, 16
 Jun 2026 08:54:48 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:54:29 +0000
In-Reply-To: <20260616155432.2093908-1-kpberry@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260616155432.2093908-1-kpberry@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260616155432.2093908-7-kpberry@google.com>
Subject: [PATCH 6.12 6/7] net: bonding: fix use-after-free in bond_xmit_broadcast()
From: Kevin Berry <kpberry@google.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, bestswngs@gmail.com, chenglongtang@google.com, 
	joneslee@google.com, kpberry@google.com, pabeni@redhat.com, rnj@google.com, 
	sashal@kernel.org, xmei5@asu.edu
Content-Type: text/plain; charset="UTF-8"

From: Xiang Mei <xmei5@asu.edu>

[ Upstream commit 2884bf72fb8f03409e423397319205de48adca16 ]

bond_xmit_broadcast() reuses the original skb for the last slave
(determined by bond_is_last_slave()) and clones it for others.
Concurrent slave enslave/release can mutate the slave list during
RCU-protected iteration, changing which slave is "last" mid-loop.
This causes the original skb to be double-consumed (double-freed).

Replace the racy bond_is_last_slave() check with a simple index
comparison (i + 1 == slaves_count) against the pre-snapshot slave
count taken via READ_ONCE() before the loop.  This preserves the
zero-copy optimization for the last slave while making the "last"
determination stable against concurrent list mutations.

The UAF can trigger the following crash:

==================================================================
BUG: KASAN: slab-use-after-free in skb_clone
Read of size 8 at addr ffff888100ef8d40 by task exploit/147

CPU: 1 UID: 0 PID: 147 Comm: exploit Not tainted 7.0.0-rc3+ #4 PREEMPTLAZY
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:379 mm/kasan/report.c:482)
 kasan_report (mm/kasan/report.c:597)
 skb_clone (include/linux/skbuff.h:1724 include/linux/skbuff.h:1792 include/linux/skbuff.h:3396 net/core/skbuff.c:2108)
 bond_xmit_broadcast (drivers/net/bonding/bond_main.c:5334)
 bond_start_xmit (drivers/net/bonding/bond_main.c:5567 drivers/net/bonding/bond_main.c:5593)
 dev_hard_start_xmit (include/linux/netdevice.h:5325 include/linux/netdevice.h:5334 net/core/dev.c:3871 net/core/dev.c:3887)
 __dev_queue_xmit (include/linux/netdevice.h:3601 net/core/dev.c:4838)
 ip6_finish_output2 (include/net/neighbour.h:540 include/net/neighbour.h:554 net/ipv6/ip6_output.c:136)
 ip6_finish_output (net/ipv6/ip6_output.c:208 net/ipv6/ip6_output.c:219)
 ip6_output (net/ipv6/ip6_output.c:250)
 ip6_send_skb (net/ipv6/ip6_output.c:1985)
 udp_v6_send_skb (net/ipv6/udp.c:1442)
 udpv6_sendmsg (net/ipv6/udp.c:1733)
 __sys_sendto (net/socket.c:730 net/socket.c:742 net/socket.c:2206)
 __x64_sys_sendto (net/socket.c:2209)
 do_syscall_64 (arch/x86/entry/syscall_64.c:63 arch/x86/entry/syscall_64.c:94)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
 </TASK>

Allocated by task 147:

Freed by task 147:

The buggy address belongs to the object at ffff888100ef8c80
 which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 192 bytes inside of
 freed 224-byte region [ffff888100ef8c80, ffff888100ef8d60)

Memory state around the buggy address:
 ffff888100ef8c00: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888100ef8c80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff888100ef8d00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                                    ^
 ffff888100ef8d80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
 ffff888100ef8e00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================

Fixes: 4e5bd03ae346 ("net: bonding: fix bond_xmit_broadcast return value error bug")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Signed-off-by: Xiang Mei <xmei5@asu.edu>
Link: https://patch.msgid.link/20260326075553.3960562-1-xmei5@asu.edu
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Kevin Berry <kpberry@google.com>
---
 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5c57c841dadc..bb561621cbb8 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5391,7 +5391,7 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (i + 1 == slaves_count) {
 			skb2 = skb;
 			skb_used = true;
 		} else {
-- 
2.54.0.1136.gdb2ca164c4-goog

