Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793624637;
	b=Ramxf+AiTFAE9MRhHLYYJijMhkXzWDQs62bFA+WXVz+Qy5397rvO+BfjOzbEmqezshEg
	 QkR6y9j2wkPEPTQFPFctMK4XohPK/hHmS4VNSH42/qnleelz+G2z7WCtAgAVc8NGmu7Vo
	 Zx6Pv6Np0JMZc6w2jOaNZJRqj/Q7bmdeYMeVwihMDqtdA8Rsnl2mUroHQTxLbTUTYW4JU
	 +fuPeFLIbitQyxVOhsABDtO/DCQDnHx21V6GfNqcOvV+2A5itPHMUr5NEnDflkFmSPdGj
	 R+ZacA0PoeacouBnkLui3NYbGG7I5urc6jrU5tqwphemLRU+t0Tlg3w6Vp7DLZZ0ktQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624637;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=gXkbMf8DM0d4yvmmrUjI+zueCqEc0hq6YJ+3++B1KPQ=;
	b=c1g3GzJNuAHZ58e9AJFwUlsJwdjGT/T1KHRLn6rraucHmiZe6Q3mG5stgHaMr1plZ/Zn
	 ixf3oZJDf5CuI/sBjz+wPGl3FujMLgqg62MPTxJT1qOWCU6J8LVd3xBPLqtkUgQF/nEuQ
	 uLsg1dto3T7cV9zTZIwRtgtGQ77V0jvPtv9vcIrN/i5jjrtDqr4gGUY/qzc/hXpbvKjS/
	 3+58l4Dg3kvSeOTWd3yYPnwQwnDK96V9DRhk2IF191EgH1D/gEeIKz/Pjx5dpsjIwTQzU
	 wsCH5ksdpq9VJDNXuye2lEFadyYjFnlxCsJL6OmMxeZC/hT70i4OXuPvfboFXHOOBzg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMTrcZLa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800E606A32C;
	Mon,  2 Nov 2026 13:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KMTrcZLa
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793624637;
	b=Apk0F0l0z+Age4lGkpc5dfN+nye073H5lX7We+tbrmg8MlaIUFR6TC0CSfvrYlKMEHlE
	 CyXTOOpR8Yt06QzTrbxPxo2l+e2rl82d5UQsTpjBfVueEpwfibIKmFkUygU1zpR1sTXST
	 iyfDRE533PXac5O5PSCC03JYy8Xo6XvubuxN9NNKc0+EhSmf/Nqs9WscqxMOZJ1GUqWaP
	 yzU9zcP+HDtDry0DG6lhf0oNVHITYM587tgH7urh0aHb/zoK0TviqcJIvprRcGmq6xu7a
	 7nTfun2bnhzDVO5oGPOBq1/f2wYRfVRqz8dLl/pC5JKDJU6Hh0MU8sONR2ki9RkuLTA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793624637;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=gXkbMf8DM0d4yvmmrUjI+zueCqEc0hq6YJ+3++B1KPQ=;
	b=w11gawSgTHIpF9BnayxDICeTmn7bYnZGFONigLzMC43B9/Xq88Xyfxes0I7VAXYVYmBD
	 gMhkGlQPApXLSJukQOJsUIUYc1lZUI0iHOlK8L/B6ei5XFpCKLrViAROCHg2vJ+Qq/0+c
	 9w+Nu7itsuoZJ0KpTr7eysQof1p9d+NIGzb7tBFbDPn5FaokCPc9Kr4q4VoCXWFPoPHNj
	 s1lSTBifAU9sC0IADpjeHp6pnrpY4uT5aC1xgRvlCgI46x5tBiVmHeV5+Anav9JtbH8PH
	 Ljsniv7iESZUyEH6cqUkyds2EpKp4J5Jth02u9Jt6gKE5fcyQzXzTpfsWW3OpHxGEaA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8737D1F00A16;
	Mon,  2 Nov 2026 13:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793624637;
	bh=gXkbMf8DM0d4yvmmrUjI+zueCqEc0hq6YJ+3++B1KPQ=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=KMTrcZLa4EeOwDolpCOhtcMcHP5jE5HJhdIPmS6cnZyPV8Milyuags4BU/g9SAWkk
	 P8E2iZWKuSA7v26xrtPm7D8wkBSiAxGfWQBV9HMHROFr+g5ZIUU7C8lXh3PVfqJMxm
	 lC9UIzkQ8DA5IGsSUWWUyDjncjxFLVas4xYS1w0PMJtoxWYhel15jJD9WOzyk1mkAC
	 a4KdzQByr6WnzSXQ3xx5iauSebUUxG2kKqgZjSq2Jc6F4TKylgMC+t8vCdfJaJz9W7
	 wqh+gvQ4BFfxcBMvUlW59DVc8fTknRTISzDCwrUQvN40xW23mKxaKyriNMAydYrcQ3
	 040YnrD9KgGnw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D66F746519;
	Mon,  2 Nov 2026 13:03:55 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Mon, 02 Nov 2026 13:03:56 +0000
Subject: [PATCH v4] hugetlbfs: move hugetlbfs_free_inode tracepoint to
 ->destroy_inode()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261102-b4-hugetlbfs-trace-v4-1-72371825bb5e@gmail.com>
X-B4-Tracking: v=1; b=H4sIADuK6GoC/33Nyw7CIBCF4VdpWIuZKfSiK9/DuAA6tCS9GKhE0
 /Tdpd3owrj8TzLfLCyQdxTYOVuYp+iCm8YU8pAx06mxJe6a1CyHvEQQyLXk3aOludc28NkrQ1x
 I1ELUSheVZunw7sm6545eb6k7F+bJv/YfEbf1LxeRI5dk6gZyJcCYSzso1x/NNLCNi+JDIPwmR
 CKgQF1haeUJ7Dexrusbr4LkXfcAAAA=
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
 Hongbo Li <lihongbo22@huawei.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793624635; l=4611;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=KamqvAmHDg6o0N+fTVEMDXuwIqsclHfnbjLf5BnFAeI=;
 b=6KI19Vg+bAxiED0JqPw6cBQwYlbwj43osrwBDrFjsM/YfY07REwyxhqBR4n5b2oqe015nw9Cy
 T6PsmCPy7HUCpwFtBSgbCWDiiT3HPmtT6UUve/QpoSglPtcB7gNcinv
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

hugetlbfs_free_inode() calls trace_hugetlbfs_free_inode(), and the
hugetlbfs__inode event class records inode->i_sb->s_dev.  ->free_inode()
runs from an RCU callback (destroy_inode() queues i_callback() with
call_rcu()), and Documentation/filesystems/porting.rst says that this
callback "is *NOT* ordered wrt superblock destruction; as the matter of
fact, the superblock and all associated structures might be already
gone".  put_super() frees the superblock with call_rcu() followed by a
workqueue item (destroy_super_rcu() -> destroy_super_work()).  syzbot
hit this with the event enabled:

  BUG: KASAN: slab-use-after-free in trace_event_raw_event_hugetlbfs__inode+0x45b/0x4c0 include/trace/events/hugetlbfs.h:36
  Read of size 4 at addr ffff888038850010 by task syz-executor952/6134
   hugetlbfs_free_inode+0x15e/0x1f0 fs/hugetlbfs/inode.c:1182
   i_callback+0x46/0x80 fs/inode.c:317
   rcu_do_batch kernel/rcu/tree.c:2650 [inline]
   rcu_core+0x5f0/0x1220 kernel/rcu/tree.c:2919
  Allocated by task 6134:
   alloc_super fs/super.c:326 [inline]
   sget_fc+0x1ba/0x1f60 fs/super.c:874
   hugetlbfs_get_tree+0x1e7/0x2b0 fs/hugetlbfs/inode.c:1431
  Freed by task 855:
   kfree+0x22b/0x6d0 mm/slub.c:6923
   process_one_work+0xac7/0x1b10 kernel/workqueue.c:3495

Emit the event from hugetlbfs_destroy_inode() instead.  destroy_inode()
calls ->destroy_inode() synchronously, before it queues the RCU
callback, while the superblock is still alive; hugetlbfs_destroy_inode()
already dereferences inode->i_sb there.  ->free_inode() is left with
only the kmem_cache_free().

Since the event no longer fires from ->free_inode(), rename it to
hugetlbfs_destroy_inode so that its name matches where it is emitted,
as suggested by David and Muchun.

Found by syzbot; analysed and tested with the syzbot C reproducer on an
arm64 KASAN kernel.

Fixes: 014ad7c42a69 ("hugetlbfs: use tracepoints in hugetlbfs functions.")
Reported-by: syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6ae27525.5451848c.f7707.0001.GAE@google.com/
Suggested-by: David Hildenbrand <david@kernel.org>
Suggested-by: Muchun Song <muchun.song@linux.dev>
Cc: stable@vger.kernel.org
Reviewed-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
Changes in v4:
- Drop the comment in hugetlbfs_destroy_inode(), the new event name
  makes it clear where it fires (Muchun).
- Add Muchun's Reviewed-by.

Andrew, this replaces
hugetlbfs-move-hugetlbfs_free_inode-tracepoint-to-destroy_inode.patch in
mm-hotfixes-unstable; the only code change from v3 is the removed
comment.

Changes in v3:
- Rename the tracepoint to hugetlbfs_destroy_inode in the same patch, so
  its name matches where it now fires (David, Muchun).

Tested with the syzbot C reproducer on an arm64 KASAN kernel with the
renamed event enabled: no splat in 3 of 3 boots, and
hugetlbfs_destroy_inode events are recorded.

Tool-use note: the analysis and testing were done with help from an
LLM-based assistant; I reviewed the change and ran the tests myself.

v3: https://lore.kernel.org/all/20261101-b4-hugetlbfs-trace-v3-1-051b716f490f@gmail.com/
---
 fs/hugetlbfs/inode.c             | 2 +-
 include/trace/events/hugetlbfs.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44ebe..f0be8edb3517 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1179,12 +1179,12 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 static void hugetlbfs_free_inode(struct inode *inode)
 {
-	trace_hugetlbfs_free_inode(inode);
 	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
 }
 
 static void hugetlbfs_destroy_inode(struct inode *inode)
 {
+	trace_hugetlbfs_destroy_inode(inode);
 	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
 }
 
diff --git a/include/trace/events/hugetlbfs.h b/include/trace/events/hugetlbfs.h
index 8ba72c1d4f4d..a7932e0db0f8 100644
--- a/include/trace/events/hugetlbfs.h
+++ b/include/trace/events/hugetlbfs.h
@@ -72,7 +72,7 @@ DEFINE_EVENT(hugetlbfs__inode, hugetlbfs_evict_inode,
 	TP_ARGS(inode)
 );
 
-DEFINE_EVENT(hugetlbfs__inode, hugetlbfs_free_inode,
+DEFINE_EVENT(hugetlbfs__inode, hugetlbfs_destroy_inode,
 
 	TP_PROTO(struct inode *inode),
 

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261031-b4-hugetlbfs-trace-341b338ab57b

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


