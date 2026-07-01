Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418CD32B132
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 23:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782949828; cv=none; b=AlaTmOEpaUmal6HC3AzAq9hRhxBkvZCGrms7IoYwvlKDyb6levGHurA76u44tKip7I+K+MSJVbLSbSOgWJFtgh3HvsEq/eSQ28znm+no9teG5l1qPDZ5ZEI/2HiLEYu9IZqQlGUoeB4oX+LtpDwo2n0TUez3h8Kz4TJo/8mMRvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782949828; c=relaxed/simple;
	bh=5886wVrZkREo7AeMbbusDaBWMEfw794FAd1FKB0Ls/Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jBsSrqw//cDXHhPu6oVzqyGA+bEIQLuKMDTd8JjrNla7+ph07x32jkbIU7n+eWioPbnke5tI17yLVQWzXoJO3ZOcnJfntxGzY58jcK18ojO+Gp0iCStqI+KAYzJMYZ0dxkPfYFX+n/awErf8I1E3V4LCR++v+iJMuRU6PcoVjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qVZCkBiY; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuyanghuang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qVZCkBiY"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-847a5f03ff9so1373564b3a.0
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 16:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782949825; x=1783554625; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xSi6QIt8CogOxeoVQBNr0dLIQQY+Wwg6VCKy7bdtrbw=;
        b=qVZCkBiY6w6gZ9+L7tDQKbLM7U0F+oMxo5FIi37zOhsViNmU8QNWIQhKBXsW92jsK7
         GXA8mdXIAAPoQ2uB8NPcZzJfhNiqnc6Ueq/hEZTZAlzCcvLreenfN/94bug2gDhGKQuD
         glktFhykUFl5qUFZ8wRyzf7l5ygdmTRQqUITW1jPwH7ddNHbaYlkrpgJAxWAE1S1Xcyl
         iPgv+ZOkjZBgcXA2QI32aY9MBG9+jkSHW/MM//Yj4WYu985FMFxX0B/oAmMjRclCqL0E
         /87ZpkOvXMZyynqJgGdveVam+yrISyVN/AuAy7AiEL2PPkTz+j0IAIwkbPwlZhmxc+FO
         CtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782949825; x=1783554625;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xSi6QIt8CogOxeoVQBNr0dLIQQY+Wwg6VCKy7bdtrbw=;
        b=MFOVWVMf3onSzmEbrFySpo7+pJroi39PWbiTcGcbxhlQJEjK2WfU1iS1XKdWOlb50u
         DrxIgCtf+DWR6Q6UASc9DxjtLtuEtLcizm68FtivQQLx3zQxkp/WWk7KisCkI0MIjL8S
         MFAQ842rvlLCH6MQ2i39e7shyepzZ3Ftk9APNXGCgQ/JW2HeleHlHi7U9ImG2+IEqw0o
         MzEvG8sEOU9r0Cz0irEmL2adrO6W81PCUIldgvvGbvExRqRkmDaCrGS7xs2t6DiL/GCf
         WF4eeGeSy2FUUE6jvVqu4Zkvin5xRxPCW403BZ9b2phGMkspYFA4BHb8C4MPCBzUaMcy
         9+NQ==
X-Forwarded-Encrypted: i=1; AFNElJ+g5Jy2NlmsF8zkA9EMSKpSsMRfqA///ZhAc6Lj0HHJz7QgCbeTbiq7dgSd5zrl6YvDslnvKbw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBYe9THNWlgFy1KoMSAhqjMJLjTCFd3kPTdIKo/txwbRfBGQE7
	Dmo5yeTLohZoPTLzZnxtYdIOtKHUhM6HxyaveeI/9O9sKm3MkX+WXZ/Rt/OSg+Pc8DOoPPwNO8z
	GM3A8ypUcbbFcD+WOaLqaUicvzQ==
X-Received: from pfbho12.prod.google.com ([2002:a05:6a00:880c:b0:847:8ffb:40ad])
 (user=yuyanghuang job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1388:b0:847:8f34:cb00 with SMTP id d2e1a72fcca58-847c095110cmr4024562b3a.51.1782949825262;
 Wed, 01 Jul 2026 16:50:25 -0700 (PDT)
Date: Thu,  2 Jul 2026 08:50:14 +0900
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701235014.73505-1-yuyanghuang@google.com>
Subject: [PATCH net v3] ipv4: igmp: remove multicast group from hash table on
 device destruction
From: Yuyang Huang <yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Cong Wang <xiyou.wangcong@gmail.com>, 
	David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
the multicast list and calls ip_ma_put() on each membership, scheduling
them for RCU reclamation. However, they are not unlinked from the device's
multicast hash table (mc_hash).

Since the device remains published in dev->ip_ptr until after
ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
can still locate and access the multicast group after its refcount is
decremented. If the RCU callback runs and frees the group while a reader is
accessing it, a use-after-free occurs.

Fix this by unlinking the multicast group from mc_hash using
ip_mc_hash_remove() before scheduling it for reclamation.

BUG: KASAN: slab-use-after-free in ip_check_mc_rcu+0x149/0x3f0
Read of size 4 at addr ffff888009bf1408 by task mausezahn/2276

Call Trace:
 <IRQ>
 dump_stack_lvl+0x67/0x90
 print_report+0x175/0x7c0
 kasan_report+0x147/0x180
 ip_check_mc_rcu+0x149/0x3f0
 udp_v4_early_demux+0x36d/0x12d0
 ip_rcv_finish_core+0xb8b/0x1390
 ip_rcv_finish+0x54/0x120
 NF_HOOK+0x213/0x2b0
 __netif_receive_skb+0x126/0x340
 process_backlog+0x4f2/0xf00
 __napi_poll+0x92/0x2c0
 net_rx_action+0x583/0xc60
 handle_softirqs+0x236/0x7f0
 do_softirq+0x57/0x80
 </IRQ>

Allocated by task 2239:
 kasan_save_track+0x3e/0x80
 __kasan_kmalloc+0x72/0x90
 ____ip_mc_inc_group+0x31a/0xa40
 __ip_mc_join_group+0x334/0x3f0
 do_ip_setsockopt+0x16fa/0x2010
 ip_setsockopt+0x3f/0x90
 do_sock_setsockopt+0x1ad/0x300

Freed by task 0:
 kasan_save_track+0x3e/0x80
 kasan_save_free_info+0x40/0x50
 __kasan_slab_free+0x3a/0x60
 __rcu_free_sheaf_prepare+0xd4/0x220
 rcu_free_sheaf+0x36/0x190
 rcu_core+0x8d9/0x12f0
 handle_softirqs+0x236/0x7f0

Fixes: e9897071350b ("igmp: hash a hash table to speedup ip_check_mc_rcu()")
Cc: stable@vger.kernel.org
Signed-off-by: Yuyang Huang <yuyanghuang@google.com>
---
v3:
  - Target 'net' instead of 'net-next'.
  - Add the KASAN Use-After-Free traceback to the commit message.
v2:
  - Add Fixes tag in the commit message.

 net/ipv4/igmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index b6337a47c141..d520ea4f6d14 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -1922,6 +1922,7 @@ void ip_mc_destroy_dev(struct in_device *in_dev)
 #endif
 
 	while ((i = rtnl_dereference(in_dev->mc_list)) != NULL) {
+		ip_mc_hash_remove(in_dev, i);
 		in_dev->mc_list = i->next_rcu;
 		WRITE_ONCE(in_dev->mc_count, in_dev->mc_count - 1);
 		ip_mc_clear_src(i);
-- 
2.55.0.rc0.799.gd6f94ed593-goog

