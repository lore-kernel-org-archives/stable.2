Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049819;
	b=UWnDmVvBjVnr4SG3atBPWCta/ETOX/ktANlM9PIXwF+NtkAquk4zt2mEolsT6nh57TgF
	 aNxjofMd9bU1uIgjR1QpG6r/aKgtwMyBu6HnlQkcQ1e50BwvPnmIm9h/GabsbgS34lp+Q
	 w/u+UGac0TvG+AlSrD+Ani6lNnJewW8LUsUCU/G8o4gCUKKLSILWX6WxTHC0qxyJf51+B
	 T4y8LHAIa66NMgdfIN3FHm8AXHepUnllwWCEHMlEp2DhvY82TgITRuCSUi9dyWVRxcte4
	 5r9nMPlbXPobG/MHhBbdKBfPo/tm9gx2x/fwHizjghEQXfSBMJVjJIYBi6nf+i5sBFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049819;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Yx/oewFMGF6r6UX/d8cfulvGnSG7DP5Z3ETgDjXdJEI=;
	b=u/P94Lej5kpbuoWFC1rZqGkllGLG0yd/qbypHaik/NYu/QC6C8Phu+yPuoQZ4gNHWtsq
	 9xdE8JM8ZvW+N4Zdakk9MQl4wqO10la9lKnEz3JLotrOREnXjl4m8fAe+9/bzAb2ZDELi
	 C2NtIoe57pfkOJWmVkTXfg7ws2lb5z9ir/izW3RjdKcK8w6U5LnLqNaRn1pIZf3VNS1Sd
	 1WtlJrmEejXe4zKe0pntC2cRyW93+RskTmk4bI9r21+usys5o16ApXpamYDn31MluAiwM
	 RqWLZRa+puc7IdsoiebHY70dd0P5oSijpstDSxKeXB2uyz0PLNNURQ6Taput3+l0vGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gql8pyMY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536AE606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gql8pyMY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCC881F008A1;
	Sat,  7 Nov 2026 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049819;
	bh=Yx/oewFMGF6r6UX/d8cfulvGnSG7DP5Z3ETgDjXdJEI=;
	h=From:To:Cc:Subject:Date;
	b=gql8pyMYQA3ErdMA0FDt/NGMWvCPlLsx6Xfcs0izaQTtJeShSKUbiSx/IWzgw2Jkl
	 FSPmpt8XlF2ebN7ivcIa+qec5hTGbe0vkyB431yvqJzjLqUwLVT7KzGX6XyKeNkX92
	 yojj1lMNRc1gRb5vIj23fSSpoopTdrdi7FBKgzItYRsuj4jF3bOvNXxEYi0k31j3hi
	 lhWLSgqZRo1KEsSvWnzRJ5ykGBgqfVvYnd7k+yBg7t28NxNFBIDyziiFZxdZGu/3vU
	 BO3gVpgXk+MhKj1tIv2Kkmpt1EEcKEHhJai3gPWukffLc+ncd2KAhFzsxwmNnMxtvn
	 z3b7X+MEQlXxg==
From: Sasha Levin <sashal@kernel.org>
To: zzzccc427@gmail.com,
	akpm@linux-foundation.org,
	joseph.qi@linux.alibaba.com,
	mark@fasheh.com,
	jlbec@evilplan.org,
	heming.zhao@suse.com,
	ericterminal@gmail.com,
	christophe.jaillet@wanadoo.fr,
	kees@kernel.org,
	kmehltretter@gmail.com,
	sunil.mushran@oracle.com,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ocfs2/cluster: initialize heartbeat regions before publishing them" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:16 -0500
Message-ID: <20261107061016-failed-5.15-c5b7a30a5172@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x c5b7a30a5172317e1e3cba61d8c9f9c588c497bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061016-failed-5.15-c5b7a30a5172@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c5b7a30a5172317e1e3cba61d8c9f9c588c497bb Mon Sep 17 00:00:00 2001
From: Cen Zhang <zzzccc427@gmail.com>
Date: Fri, 16 Oct 2026 00:58:38 +0800
Subject: [PATCH] ocfs2/cluster: initialize heartbeat regions before publishing
 them

A region on o2hb_all_regions must have an initialized config item and
name. o2hb_heartbeat_group_make_item() currently links the zeroed region
under o2hb_live_lock, drops the lock, and only then initializes hr_item.
The lock therefore protects the list without protecting initialization
from readers of the published item.

With global heartbeat enabled, a DLM_QUERY_REGION from the current
joining node can pass the existing-domain and protocol checks while a
configfs mkdir creates another region. The DLM locks are not taken by
the constructor, and the network worker does not take the configfs
subsystem mutex. The following ordering is possible:

  Configfs mkdir                     O2net receive worker
  --------------                     --------------------
  Allocate reg
  Lock o2hb_live_lock
  Link into o2hb_all_regions
  Unlock o2hb_live_lock
                                     dlm_query_region_handler()
                                       dlm_match_regions()
                                         o2hb_get_all_regions()
                                           Lock o2hb_live_lock
                                           Copy 32 bytes from NULL name
                                           Unlock o2hb_live_lock
  config_item_init_type_name()

The query thus dereferences NULL. Initialize hr_item before linking the
region so the existing list lock also orders name initialization before
any reader. Reject a failed name allocation, since the initialization
helper does not propagate that error.

Use config_item_put() on initialized constructor failures to release the
name and respect references retained by o2hb_region_pin(). Initialize
the list heads, mutex and delayed works needed by o2hb_region_release()
before any such put, and leave the list node self-linked after rollback.
Keep the existing handler drain before removing a failed published item.

KASAN report as below:

    ==================================================================
    BUG: KASAN: null-ptr-deref in o2hb_get_all_regions+0xbb/0x1f0
    Read of size 32 at addr 0000000000000000 by task kworker/u16:1/14

    CPU: 2 UID: 0 PID: 14 Comm: kworker/u16:1 Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy)
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    Workqueue: o2net o2net_rx_until_empty
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     kasan_report+0xe0/0x110
     ? o2hb_get_all_regions+0xbb/0x1f0
     kasan_check_range+0x105/0x1b0
     __asan_memcpy+0x23/0x60
     o2hb_get_all_regions+0xbb/0x1f0
     dlm_query_region_handler+0x4c2/0xc20
     ? __pfx_dlm_query_region_handler+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? kvm_clock_get_cycles+0x31/0x60
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_dlm_query_region_handler+0x10/0x10
     o2net_rx_until_empty+0x1a50/0x3200
     ? reacquire_held_locks+0xdd/0x200
     ? __pfx_o2net_rx_until_empty+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? process_one_work+0x935/0x1b40
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
    ==================================================================

Link: https://lore.kernel.org/pm-ocfs2-objects-candidate-0079-v5-f931a29339cadc0a2a70@gmail.com
Fixes: 536f0741f324 ("ocfs2/cluster: Track number of global heartbeat regions")
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Assisted-by: LLM
Cc: Mark Fasheh <mark@fasheh.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Heming Zhao <heming.zhao@suse.com>
Cc: Yufan Chen <ericterminal@gmail.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Kees Cook <kees@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Sunil Mushran <sunil.mushran@oracle.com>
Cc: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: <jjzuming@gmail.com>
Cc: <stable@vger.kernel.org>
---
 fs/ocfs2/cluster/heartbeat.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/fs/ocfs2/cluster/heartbeat.c b/fs/ocfs2/cluster/heartbeat.c
index 8e6ead433228e..9a4703bdc4e8d 100644
--- a/fs/ocfs2/cluster/heartbeat.c
+++ b/fs/ocfs2/cluster/heartbeat.c
@@ -2140,6 +2140,18 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
 	}
 	reg->hr_node_num = O2NM_MAX_NODES;
 
+	INIT_LIST_HEAD(&reg->hr_all_item);
+	mutex_init(&reg->hr_arming_mutex);
+	reg->hr_stopping = true;
+	INIT_DELAYED_WORK(&reg->hr_write_timeout_work, o2hb_write_timeout);
+	INIT_DELAYED_WORK(&reg->hr_nego_timeout_work, o2hb_nego_timeout);
+	INIT_LIST_HEAD(&reg->hr_handler_list);
+	config_item_init_type_name(&reg->hr_item, name, &o2hb_region_type);
+	if (!config_item_name(&reg->hr_item)) {
+		ret = -ENOMEM;
+		goto put_item;
+	}
+
 	spin_lock(&o2hb_live_lock);
 	reg->hr_region_num = 0;
 	if (o2hb_global_heartbeat_active()) {
@@ -2148,26 +2160,19 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
 		if (reg->hr_region_num >= O2NM_MAX_REGIONS) {
 			spin_unlock(&o2hb_live_lock);
 			ret = -EFBIG;
-			goto free;
+			goto put_item;
 		}
 		set_bit(reg->hr_region_num, o2hb_region_bitmap);
 	}
 	list_add_tail(&reg->hr_all_item, &o2hb_all_regions);
 	spin_unlock(&o2hb_live_lock);
 
-	config_item_init_type_name(&reg->hr_item, name, &o2hb_region_type);
-
 	/* this is the same way to generate msg key as dlm, for local heartbeat,
 	 * name is also the same, so make initial crc value different to avoid
 	 * message key conflict.
 	 */
 	reg->hr_key = crc32_le(reg->hr_region_num + O2NM_MAX_REGIONS,
 		name, strlen(name));
-	mutex_init(&reg->hr_arming_mutex);
-	reg->hr_stopping = true;
-	INIT_DELAYED_WORK(&reg->hr_write_timeout_work, o2hb_write_timeout);
-	INIT_DELAYED_WORK(&reg->hr_nego_timeout_work, o2hb_nego_timeout);
-	INIT_LIST_HEAD(&reg->hr_handler_list);
 	ret = o2net_register_handler(O2HB_NEGO_TIMEOUT_MSG, reg->hr_key,
 			sizeof(struct o2hb_nego_msg),
 			o2hb_nego_timeout_handler,
@@ -2190,10 +2195,13 @@ static struct config_item *o2hb_heartbeat_group_make_item(struct config_group *g
 	o2net_unregister_and_flush_handler_list(&reg->hr_handler_list);
 remove_item:
 	spin_lock(&o2hb_live_lock);
-	list_del(&reg->hr_all_item);
+	list_del_init(&reg->hr_all_item);
 	if (o2hb_global_heartbeat_active())
 		clear_bit(reg->hr_region_num, o2hb_region_bitmap);
 	spin_unlock(&o2hb_live_lock);
+put_item:
+	config_item_put(&reg->hr_item);
+	return ERR_PTR(ret);
 free:
 	kfree(reg);
 	return ERR_PTR(ret);
-- 
2.53.0




