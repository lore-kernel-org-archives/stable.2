Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E8F26ED40
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 17:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787245936; cv=none; b=EnVeyYcaUT0yXioOzCdyXrIOzzrj2y2OYB16VIyUpWHNMMM7WusBT2n7k0PvlMhgBo9MdNaMD949E0CAJy4gb2TBU+9S8TSDWsfp9p76+RjKvkHQX4k5C8AhMW7gf6wUmgG6QUJnSIQelrejrOgVr8Wdo2A5VB/JdSZzvJ1/CAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787245936; c=relaxed/simple;
	bh=D8FPraN71VD39KN1gpQdD92B0qFi+xsvSpMhra3c+do=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=aTI3SJ/98h1QYEgg/rL2VY0QVsbRGAu51tII1hhlIXmWXKJGRiFp0NGJLYdBqytcDw+GKb5pA1fcCIiQa0CT5khoCOw4MOjipb+LrVb0zPRr8EzIGRUzqQtahvuOvzsKNvASuqvXzmJNRkAJOoPiR0yc4H0oW5ruEvpDAjLIYKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=OH4SSzVT; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="OH4SSzVT"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38fdeaed181so36773a91.1
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1787245934; x=1787850734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WDHOzboWyyedJI0AK0XaWF+GldMNcusvvKh1u6SV1rQ=;
        b=OH4SSzVTAZLC+W26UctQSU36eZZ5MZ4kTfBBayzN3xHLpVfgpyP0xo3/lTD2czXTUb
         9cYNlf/fwnA0XS+4S55SM/00KnFKp+63PGqYNGYlCR/1BgEbVRkuzFkGZ9uvEAIREUbu
         N0kbgRHcIVWROZ61PBozuR/pkRd6qJdUjCJeoVXyQR0lHhKBRpx218NbjRvvE37K76Dw
         YNohVgeB3dsqyWuMkt4sRGDQmo1SQUkpdSDvF3iZOpw2e+HCJc5WjkWGv+ozCNkVj4Oi
         NINhX/gTZaOlzK5ettmnQeH/dl0XlF7/GPJzv6srJVbDai520F3zjEQf8fpNaFHPmx8s
         Zg6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787245934; x=1787850734;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=WDHOzboWyyedJI0AK0XaWF+GldMNcusvvKh1u6SV1rQ=;
        b=CKoCgONBOQbWRfHuepbvWWcs+lkbur1AYNV+IBLeAshPrABu9nJP0so5nT3W5BmUvG
         8eqN9cqOsJaTTPTLJk/uDpGMToqfhN0o7Tb/mQKPv0PVCF/N+9HH1t+2IOQp82DPs7W3
         cxFKbpIjmsbEz9eUFVm2ye0bi6qYfaEXzC5OyeBGzkj6qBxcEjahvi1rwXPNtweQUo1B
         juEarrS2HpyENHpTK7kpxxVT09HvO6vKvLyFxFJaipC8Ncxp9g+Vyw7g4bcWI57SLsMb
         Mts4BNaDT/SnywNhskXPgL/b9LS7X9YYINu1aVOv8KhR27AP0afIh47tXiiD2UjF9bNv
         M6IA==
X-Gm-Message-State: AFuF++lvsx/Un475rRANcq2nRlq7BPQcyvRX5fAiOm2aP2QSG6PTf0B2
	/qyDq8Bd6Obv3u87ipEKYr4R1GukrCYg9pgd/EQW+RZRmaHC9QSqo6XDV8jF5ltSK/GPFIsR86S
	kLq1/
X-Gm-Gg: AR+sD12mO6gD5cIMVa2wySa8aCXu6X00w0zxOnIhZVAQqUVZLDnKwo3m4ZRYPee9VKy
	q6/sXLx8A2w8Qc9yyuFzcV4C4dE1F9Ib15ER99ASlirSS34oapHf3BjOI1LVaTLB6PwuEqgaMM/
	+dej/e4Hs7HZU3ZNqcU/YvrF5MLw0j7Ny13t0QjK/GpAsiy8VbXSwXWN0uanStatMrdnYOdVBUk
	nt9JyH53TrE3zuRd9BjCfsgkuwyy8zuVZY8c157YTMX9X1MNTy+d6/36YfxKCrtSOX0fNcWCPG3
	25YuZYtAssLLAB9uW+tzSONKT6tzr3C9RJDmn362zzKW4KGT/KJ6CYl8o5cZYvGL5JEBrrOV883
	p1sqG/bG/+xKzmbG1eFjAoDTYt8jXuPYbTszgDt3WyzxayDhM0K7wvmu9RteJiECTOnYnEGI71i
	TutOcVj5L3pH9k6hYxxPtYtG7j8zCYshDNzGn12jBytw8yxEtUuO7FUT9WCpiYsgk2d4krmI3I3
	km8SbjV8bBJe8IvJ6ZeJ+C2uJE1S2Hlt+ab52DvTFhwSnwl11Pj5SDNFjajcg==
X-Received: by 2002:a17:90b:4ac9:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-395810cad6amr25770511a91.14.1787245934060;
        Thu, 20 Aug 2026 10:12:14 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:4439:8048:bb7:959c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fb17eb5sm8767712a91.3.2026.08.20.10.12.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 20 Aug 2026 10:12:13 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.1.y v2] net: bonding: fix use-after-free in bond_xmit_broadcast()
Date: Thu, 20 Aug 2026 13:11:49 -0400
Message-ID: <20260820171153.31521-1-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Assisted-by: OpenAI:Codex
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Changes in v2:
- Preserve the upstream changelog, authorship, and trailers.
- Move the 6.1.y backport rationale and validation below the separator.
v1: https://lore.kernel.org/r/20260819165924.1184-1-artem@trailofbits.com

Backport of 2884bf72fb8f for CVE-2026-31419. The identical one-line change
applies to v6.1.183. An unprivileged namespace workload triggered a KASAN
use-after-free in skb_clone() on v6.1.182 in about one second; with the fix it
completed 1,180,061 sends and 299 slave-list mutations without a KASAN report,
oops, lock warning, or BUG. The fix is in 6.6.143, 6.12.95, 6.18.22, and 6.19.12,
but remains absent from 6.1.y.

 drivers/net/bonding/bond_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5a71893fc6a962..c4f640292bb59c 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5345,7 +5345,7 @@ static netdev_tx_t bond_xmit_broadcast(struct sk_buff *skb,
 		if (!(bond_slave_is_up(slave) && slave->link == BOND_LINK_UP))
 			continue;
 
-		if (bond_is_last_slave(bond, slave)) {
+		if (i + 1 == slaves_count) {
 			skb2 = skb;
 			skb_used = true;
 		} else {
-- 
2.39.5
