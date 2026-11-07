Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050849;
	b=kK4Mp9KBEa3OX4JlXotcKROmFu3R77/LThmVpDD+mRacz4K+GdmEYgybpb+OZCgfzCE1
	 B5lD+1Usqs4c+8YVp4krx5UWURTd6SEhTOEIR259BzA4cqIlaz++k2NKIcozJuHjGWu22
	 f6nCStXaPUPRerMBLvG6PhQcKPTZOxszNMvSC7j4fWiG1pGQRlMzXnl+d3v7cQC/ry/qY
	 wfKCoLPzO5lLrUpOjtlMBesvScKOmuVQVpr/rLLJCay3ByrdqTYytMPhZa6AKdW0vexdk
	 9g2R6iY7hMVbxgUFHSXrPoKKkh7OcIw4VzMFKDWI1sxCUGXXHjDZc2T7XoyJxu4WAqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050849;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ZkCCj6hO60nRf0jAGI44Am2yIVyQ9SZOp3keZPJrqho=;
	b=EPBFXdINn1U3zgW8x9sgvOP/Akvg19tLJDTbtIBzHlo9xPt7s88hnQc32o0Ecnxgr5xf
	 GukStVh25Urr2J1CV0rm+yZRDQ+WKk6aMlStvZhz0oxFBx1L4Fw3CzjFlTiWv0QIKDOWy
	 KHTN9vdU7h3i5EioGpONamRX5xYDEqL7E2dGMPh/o/vLuh38ysEqAgC89jI4uJWOaXW0y
	 TUFm8U/Fwi9HICjmHdiWsAj5tPmP8M1hZ4lgGFkIMFC0XYX1xnnMlj3c3EzRyi68MXX4s
	 TSYZyLyZT/nsO0Qr0yDFA52u4tfre7NFb34NzzI/zPbI+Fld+HWHsRONtFjYbzD0SLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TqOv1v/4";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4F606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqOv1v/4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16691F0089F;
	Sat,  7 Nov 2026 11:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050849;
	bh=ZkCCj6hO60nRf0jAGI44Am2yIVyQ9SZOp3keZPJrqho=;
	h=From:To:Cc:Subject:Date;
	b=TqOv1v/4pNqyZXgYFByp2lLeh/2SbpIepvwUZ8HtDg/2GgRVnx8ehXXTLka07J6JL
	 GjbYVqUS3T2Ka7CSrIsprZ3I6BoAU8gWQZUCL1GjlyDLLazasypsTuyD5Szko2OoB6
	 dki7/TcTUWURYCJ0N+MXg3WtDth+C4nTz0FH1FfqyJNagWdMDA9xSsEbILZuz3sdQH
	 SSY/ID2A3yd59iDV+XZlG7Vv+W/TYBTSMWYgsJxOC2hCfl6ARmCn1EjdcrpZXawgHW
	 XfyYThJz9DTsIIxo9/wyoEYuhm8kMT81CMi4mCYjMryaMjTMoiZ1YQ8Yb6Wek2q/9f
	 48EVR9sGbUdqA==
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
Subject: FAILED: patch "[PATCH] ocfs2/cluster: initialize heartbeat regions before publishing them" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:26 -0500
Message-ID: <20261107062726-failed-5.10-c5b7a30a5172@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c5b7a30a5172317e1e3cba61d8c9f9c588c497bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062726-failed-5.10-c5b7a30a5172@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




