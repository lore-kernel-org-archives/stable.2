Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792467912;
	b=EwjYkPLUv0T7mNf4nPxowc6MOkkpHPrHq7d8eESeVKdvsq9SpdMRgxailMRG9DHH7Qvy
	 7+mMnLvS+f1O9mdh32abf0/vyeyi5qwgrTiWtpKDYvABxg0uLyTN3OXiEwb8x3zmtgBed
	 0emYmJDS+/K21S66I+gXgCPedEQRWwfHd9Aa7Ga2XCTRfIq7m5MKqHzXTgY9ZzayCzR6l
	 eKisdbs+hqqmirmO7rE9UX/0iGCCuuP0lCjhUsR6AlICQBBjb/hUlKsfIAbO3c4i+htPM
	 f2UWXcRjwhQ6DeGRq9F8dG/mWxrj0vyoaTLz2pE3HDOVFS1Yep2SlPGEJXKlO2+AECA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792467912;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PFN0eeliP3cWfqvR/ohlDfw2jEjJGDLAFVCOFpZ4D5A=;
	b=nrgkI5xuf/3OdUZAReoI+x/37m5lVKHK+HqrMM5MipacpjOSXbCUUHvkDIuPnB/XM8zQ
	 mF7GJQBIZoHTZrIbRpMtO60l4lmTYilW3hTwj+AxbMxCrjqHGLgirAmgKDm8yk5dZoQgJ
	 YrLPqfntb1mwyN8K1gBVvbYrshGPwo3iLVLRyQ9BQ9xP1kkYgecbPRHPtVr3U2U5685CI
	 LIz7q7IOluDifzVJD3vW4N27J75HPLVNP5iYz8JORR3jcnlpwiNA3HQ2IYL0eLqsat99J
	 tBGAfR4kEIPu3lKPHboG/2UDT+2Rkbs/OqwWOvH00122WNt8duuHVIG36n7ELMaJmDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mgnCwBwT;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B518606A31B
	for <stable@vger.kernel.org>; Tue, 20 Oct 2026 03:45:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B518606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mgnCwBwT
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cbedd5aece4so136516a12.0
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792467911; x=1793072711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PFN0eeliP3cWfqvR/ohlDfw2jEjJGDLAFVCOFpZ4D5A=;
        b=mgnCwBwTPiUm/+XB3+8qoIaIQ5HXRhZWsvVEapVahWQbdi266NwWC65XZUC9pJN1lJ
         h1UcIElR2ZB0JgTLyHY346w1x1x+08oiswJJBwLgxK8r6kcUylK6fNX11jgHjubpb1S8
         3DKrwqHYov88lV+Nzn4PPwjHz3d4kXL9G7Guf4/c0jgzTVXYO1PikdRDKd7Gvio0qiuk
         bW+eQ0G0tys7kwt0VellLuc6WlUPpinusHTFZRY3gP4bzqIGZfupOn1BKpXIniwpNl9q
         hCl4hASxQHq8qVw7XRt3oxCeaRHaW+bsJAeEdFiT7tlPzGNaFIImF9uUUkr8D9ykJCql
         YGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792467911; x=1793072711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PFN0eeliP3cWfqvR/ohlDfw2jEjJGDLAFVCOFpZ4D5A=;
        b=GCWJ7lRM3tUZh/EKLVNcr4LpHo7eD6E0U2AR/2r2rzLIAFUWeFqtfPXb5zhGVUtQ0y
         RWFjk47ZFqs4rwxmzTrh8yPlxt9gK2rb/UQxesykWkDIdjuOTLAIa9xrT+thXnEPEjs2
         WudRDIrtmhBzn5C2iCegF+6Wdh/WBYHmQG1JaC85686Ju0zjEEb3935RseLfdEARampu
         c1P/AzTps6bIhb410Wm9DJ8RC6jaPRxTg6zH/F5opK/VOafvv44uIjbShaEeWRwFySpy
         mjst8hf1zefKOkoT0vGUkwt9E/nfWgsc6hCCT69VA5gGVOmVlZC1ty+j230+ePOgxzgb
         IG+A==
X-Forwarded-Encrypted: i=1; AKwUvBx59Iu+a+ljAzzyf3sVzu0kz3v7CMrA08LIT4S34qRdy7g4DGL2pe5h3Ny62OPn/sLw5yFUCXo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKmoVA5nK9tL58cazrrYTDcdKmZzpMbkwJyeqXmHXgZBbkPqOG3
	C2ovapIf4oM7AJBuxmS0w8+Cjm2WNu52yAt/v09gx0XiqOzO1QlBX+wj
X-Gm-Gg: AYBFou3ErmshzZDQz/lSFSWacY0LrfcHAhhgFkOqdb8PsGn0jzGYaxQKlx5Xdid/vt4
	ndkiY34P283xesnEIW40vZjftY0IGmb0nVtmfpz3GVjJ1A2rvDTcKLBkH+CElOor+zgbrjPAu8C
	jyPmJ5XnINZJMaYjhnWMiSwU7DgFzO6N1l0tmDHpA0au9n3M0qI8DMWC0fSRwU+NVZwmaJlaf0e
	uU5XZ7jM7UVxyc9qVq1EYEarrZnOXaz9IdRuMsSMTxSvxZ0gLwr1QuMHjZ81kk6WXAdGI41DHBC
	yQ89ZjDhIQhFkn0R7D0bE2IbsYOaH8MYx/jA/FaUFVj7E2VyFh2z5rUWIsplOP3XlzP9gdCCwRz
	kIijt1VPPbXFoRZJ17fYxRkyk/bdVuqLSE2HyBJ61pwKu6u7uea1xZ4ofJHCoBqVjCZKcpCxlhB
	4+74buRxOjENoFjy3mUccBG71HAq+xfGF5DPvEQe5qJOrBy6IHPlfbcfQL3IA0Gzdr0A==
X-Received: by 2002:a17:90a:fc4c:b0:3a6:f6b0:30ce with SMTP id 98e67ed59e1d1-3ad64be6734mr561619a91.36.1792467910724;
        Mon, 19 Oct 2026 20:45:10 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd0939725sm10124927a91.3.2026.10.19.20.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 20:45:10 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH v2] ocfs2: drain quorum work before removing the cluster
Date: Tue, 20 Oct 2026 11:45:04 +0800
Message-Id: <pm-ocfs2-objects-candidate-0064-v5-e3870bf6571b80b07b52@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Add o2quo_flush_work() to drain pending or running quorum decisions
before clearing the singleton in o2nm_cluster_group_drop_item(). By
this point the heartbeat regions and nodes have been removed, so their
work publishers are stopped. The worker can finish while the cluster
and its configured fencing method remain available. It does not acquire
the configfs mutex held by the removal path.

Keep o2quo_exit() as the counterpart of o2quo_init() for module teardown
and initialization failure, and have it call the same drain helper.
Cluster removal uses only the explicitly named drain operation.

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
Changes in v2:
- Add a dedicated o2quo_flush_work() helper and use it before clearing the
  cluster singleton, as requested by Joseph Qi.
- Preserve o2quo_exit() as the counterpart of o2quo_init() and make it call
  the shared drain helper.

Link to v1: https://lore.kernel.org/r/pm-ocfs2-objects-candidate-0064-v4-51daf51db746eedf7533@gmail.com

 fs/ocfs2/cluster/nodemanager.c | 3 +++
 fs/ocfs2/cluster/quorum.c      | 7 ++++++-
 fs/ocfs2/cluster/quorum.h      | 1 +
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ocfs2/cluster/nodemanager.c b/fs/ocfs2/cluster/nodemanager.c
index e08850a5d736..ced4fe6d3b59 100644
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
+	o2quo_flush_work();
 	o2nm_single_cluster = NULL;
 
 	configfs_remove_default_groups(&cluster->cl_group);
diff --git a/fs/ocfs2/cluster/quorum.c b/fs/ocfs2/cluster/quorum.c
index bfb8b456876c..ab5b3d4fd0e8 100644
--- a/fs/ocfs2/cluster/quorum.c
+++ b/fs/ocfs2/cluster/quorum.c
@@ -318,9 +318,14 @@ void o2quo_init(void)
 	INIT_WORK(&qs->qs_work, o2quo_make_decision);
 }
 
-void o2quo_exit(void)
+void o2quo_flush_work(void)
 {
 	struct o2quo_state *qs = &o2quo_state;
 
 	flush_work(&qs->qs_work);
 }
+
+void o2quo_exit(void)
+{
+	o2quo_flush_work();
+}
diff --git a/fs/ocfs2/cluster/quorum.h b/fs/ocfs2/cluster/quorum.h
index d64bf4482a4a..1ce5fc2a8ca9 100644
--- a/fs/ocfs2/cluster/quorum.h
+++ b/fs/ocfs2/cluster/quorum.h
@@ -8,6 +8,7 @@
 
 void o2quo_init(void);
 void o2quo_exit(void);
+void o2quo_flush_work(void);
 
 void o2quo_hb_up(u8 node);
 void o2quo_hb_down(u8 node);
