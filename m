Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE3052FE4F
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792083482; cv=none; b=oAszpCl/EMdlJvVHaGvRuuTpILIXBvncrmteRsNreIAEeUlVbgdvSxZxzarrv7tp2ByBWCZeJb8CgwQePZZD0L5/lWewZpGNXZzOYFw71tMGoLtWsu7sj8qJygZvJms9xui5nrcW0W5R1OGfKXMcyonbIcM0Yr+svvaGQh8NStE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792083482; c=relaxed/simple;
	bh=gBYGD3tKItIGu9oXJXjWgIyeMXUwedDlFFMV8rc1jdA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=PO2437zI/Bodz8EjbnA3yOKNxVUyGoFxPq4RPCo2oJTvRkV34Z8rGal0n0K4/YCzEcNFEpAsFnqkm0nq2AQe9CcGgCSZ6pHHM4f+nj9XPlZticD3mq7tn18YL73UB+mNhB0hyzHUPJhegZD0Ts/nVuCGryAisHvF2P80ooykhQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gezjc830; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gezjc830"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-89f0a21880aso227504b3a.0
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792083467; x=1792688267; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iPaWbI2r8AXvwprE8o0BKzZtz+m3PX1iYF2IvumBD60=;
        b=gezjc830ZDOFoZkfSXmBi94b3Zsia9dpc76bPmYxKNW7YMFCjinl8maHroQW9Qo/DU
         feX1cJ+8gRfR379IN5sJOs1kEhCLxrB5ikDSbw4KkMmfslhBsZSeNS5wEjNSl8gLGVL4
         rhClGb3ek5RTl/M+uDb7rKoQ86dy2FEYcLUkl0eiHwct/P7cnBqVUE1VDwv86FjgpBeK
         vOor1RFt9wdo9eIFG6Whuh5mt9qSJvW99tqp6F2UzFE+zk1UDkLh43p86OL49hOl1hjm
         6/RXdylI0yYsroG6AXyj434RmCwh/VHKizaXktoJqplspo36rNthIQkn+0LPYNI33Fvc
         dZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792083467; x=1792688267;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iPaWbI2r8AXvwprE8o0BKzZtz+m3PX1iYF2IvumBD60=;
        b=mkLevuxpVfEcowbExs3hoYc3aZq6p7P32NER+D98vgPVMGjQec+vfGM2LHTjVEPrJf
         4jlGQ6alOJLxZUMxqHFugkSlWDU+F2UUuvD8PA7Tyh4x/GgnIDMrshyoZVB82OkqwRc7
         TFvoygi/WaIFotx6R2zTUdKh3u8RaYI18FHs2HOAerDkcljfTPfDqDJgfY6qigBC6gPZ
         7GqQY/aMzszdJ+r8cA9QAv0XInDMjwOhkvnpiSYrBeQakd5uAec0j3BBfoA2+OY6LOas
         eHunzEMFipCQ7ouJXGgCTfsmcBlCrRJ4r+ul1DHagNk87U+E448kIXlpeFHDbvybrJVa
         oNMg==
X-Forwarded-Encrypted: i=1; AKwUvByT66YuS8KODSbnhaubovNvZH6goTy77SvgpHfyczWht2YLmEKbToUOaJPZgsvrQbHTOQuzdzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLydVft6IlAR5x6Mq2zPutt8Wccm2amU5OxGkT2FIblCLxwCHzs
	ytuSC7duGceKLBQHsMsUW/c9V5cS3BmZ6eSU6zcieYjT3k8Vz+8/GmJw
X-Gm-Gg: AYBFou2XG8xxYANm8WHhHClcyyevR7nzvvvvIVvljBzenFO2nZj44l2fUX100Kb+/c9
	cSqnhUFa9NIU0JaJRwhYQyXoeMmXP6bucfa3GLRpvQXRXHxxFohOoWurHshTIP7npzf5tHL+cTe
	Nv3w1wdKivAtBbo4NSFu3Ajav5CfBkugPshN/K0yXydcvZvpcw2vduhZKu+oBQAoRTBl3AhsKQv
	oBtB1HiZu5upUlFZZl6o5IPR52Cm/PJw4YD22JUXItwtg/98EuBsdKHmF5lif1zUQJrv0W4kGJS
	AFnfW+4ZUZIrl3HTFiu+uUHUJMu04I6Bvky/2rM1Czp5NBs4p/H7RWUZdomedsM4QhJQwF9Byzz
	3eZ8qUR+DUz1Ke0N1WLlK9QVLUrPBoFzW+mZm8joztVgLjj/hwXHnojlPhJtNNc6Q/OWxC8Clgq
	7haSPaQgqwBc1YpK52k/Ux/VoEbRq2hLxnPyCazIEx+O+mg3rZOeUKOtGfOg2pXEQPrA==
X-Received: by 2002:a05:6a20:6a0e:b0:3e0:c2fd:511b with SMTP id adf61e73a8af0-3e16be0d320mr16966384637.32.1792083467156;
        Thu, 15 Oct 2026 09:57:47 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd635cbaca7sm1556170a12.25.2026.10.15.09.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 09:57:46 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com,
	akpm@linux-foundation.org,
	zzzccc427@gmail.com,
	christophe.jaillet@wanadoo.fr,
	blum@kernel.org,
	kees@kernel.org,
	sunil.mushran@oracle.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com
Subject: [PATCH] ocfs2: drain quorum work before removing the cluster
Date: Fri, 16 Oct 2026 00:57:38 +0800
Message-Id: <pm-ocfs2-objects-candidate-0064-v4-51daf51db746eedf7533@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The configured cluster must remain available until an in-flight quorum
decision has finished using its fencing method. o2quo_make_decision()
drops qs_lock before calling o2quo_fence_self(), which marks heartbeat
regions for unclean stop and then reads
o2nm_single_cluster->cl_fence_method. Cluster removal clears the
singleton without waiting for this independent system-workqueue item.

When a failed-quorum decision overlaps removal of the heartbeat regions,
nodes and cluster through configfs, the worker can be preempted after
marking the regions and resume after the singleton has been cleared:

  Quorum worker                     Configfs removal
  select fence; drop qs_lock
  o2hb_stop_all_regions()
                                    remove regions; join heartbeat threads
                                    remove nodes; stop o2net
                                    clear singleton; release cluster
  read cl_fence_method

The resumed read dereferences NULL instead of applying the configured
fencing method. The heartbeat thread's dependency protects the local
node only until the thread exits, and draining o2net does not wait for
qs_work.

Call the existing o2quo_exit() flush before clearing the singleton in
o2nm_cluster_group_drop_item(). By this point the heartbeat regions and
nodes have been removed, so their work publishers are stopped. The
flush lets any pending or running decision finish while the cluster is
still available. It introduces no new state or locking; the worker does
not acquire the configfs mutex held by the removal path.

KASAN report as below:

    Oops: general protection fault, probably for non-canonical address 0xdffffc000000011b: 0000 [#1] SMP KASAN NOPTI
    KASAN: null-ptr-deref in range [0x00000000000008d8-0x00000000000008df]
    CPU: 0 UID: 0 PID: 72 Comm: kworker/0:2 Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: events o2quo_make_decision
    RIP: 0010:o2quo_fence_self+0x65/0x200

Register dump omitted.

    Call Trace:
     <TASK>
     o2quo_make_decision+0x345/0x3a0
     ? __pfx_o2quo_make_decision+0x10/0x10
     ? process_one_work+0x834/0x1b40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x9a8/0x1b40
     ? __pfx_process_one_work+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kthread_parkme+0x177/0x220
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x351/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf70
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>
    Modules linked in:
    ---[ end trace 0000000000000000 ]---

Fixes: f6656d26d17b ("ocfs2/cluster: Make fence method configurable - v2")
Cc: <stable@vger.kernel.org>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index e08850a5d736..13d7f579047f 100644
--- a/fs/ocfs2/cluster/nodemanager.c
+++ b/fs/ocfs2/cluster/nodemanager.c
@@ -12,6 +12,7 @@
 #include "tcp.h"
 #include "nodemanager.h"
 #include "heartbeat.h"
+#include "quorum.h"
 #include "masklog.h"
 #include "sys.h"
 
@@ -740,6 +741,8 @@ static void o2nm_cluster_group_drop_item(struct config_group *group, struct conf
 	struct o2nm_cluster *cluster = to_o2nm_cluster(item);
 
 	BUG_ON(o2nm_single_cluster != cluster);
+	/* Drain quorum work before it loses access to the cluster. */
+	o2quo_exit();
 	o2nm_single_cluster = NULL;
 
 	configfs_remove_default_groups(&cluster->cl_group);
