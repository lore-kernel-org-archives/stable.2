Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793462764;
	b=Zo45nhNwL17MBEBs+wqCjnl+SglGVwgvdAd+3XT0hTrLFQT3r+rLNR2Q+Vjeu2+hEstA
	 wOJu3Kaz3EAT01mU/b4G96+8OMZehV8HzzHBjT5E35Swa1dr5r+iSstxX7w9ligTQ2Mb7
	 zE6G4yMeqNBHjG3DaPi7YQEnJV9tmLi+t2R7XlNAlfyDKuk3SoMZIuwek0cjX3HflwXCU
	 H1Ij+5zGJxUQAbLkkiuAkChrL7aDEFfhEtDTiYA4sWfTX89waX/1Ulx43oJPU4xGVphWV
	 HaB5c3K/RnDU043X3N4+YF1kBy0x04k73nKLT3HEkUZsrze3I3wu8K1qwFMb3yx3wWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793462764;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rkymqaY7xVAzdi59LAjiM9RaFMfOkE/t6iQNHmjVNAY=;
	b=1noPrXsDLzQKuUn9tdBtx9mmv9NIT+5Km7KQzudsNdq/I7CVV5M6bV/wfTuaixBWO1P0
	 91Ur8kWorFvLdY6ki22qlCokHtCw4kVC51TNwyavDtCNCo5QzOWiyTjLoSoXbqS5WDSqB
	 iVFdk0G6C8dlJaurJE7tHk2ll1tFGAWoy2phMu8hbBuhgvkMrAuW/vsWl29eYyaarF7kI
	 NLwwWvji12FTTfFEhUrXR+nUYViI6fziHs77eObmlgM6YBSsa7bftRpy13lWg3UC2XJZI
	 eA2uMgxzjHP5EYrgP3BgjeWuZ8d1boly8wAA9+vbLlb4FWBq3r/sJoX569CGDIUszjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f48maP2D;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054B8606A31A;
	Sat, 31 Oct 2026 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f48maP2D
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793462763;
	b=bmFu7/pzFL1Y8Rl+rCHTK3eh1TEobgsm+cerp+DY4txDqHvpixCCT90NLVq4HjLMQquQ
	 rvUN/Z/vdeGyq872WgVCoZhj+h7V8J751OLU8SuBfBtsGP2Jd6ukXb2ANsIPn18YrNaWN
	 V8yfdu8t/llQqLXrvaceUbWhJEPI8ZekyWevt2nwcuU4b8Gl6rSDAI2cRdahICqzrwQcv
	 W9Behq7nhiKCsrAomEPmx/6y2uV+TsAanCAU4nmnVV4p00qwcV9pyKsw6ox3MkrOQq4BU
	 RjPHIJjPr2E4C7Jf5kJMTd9irtBs+U5uyXST4ZUh5bx9zB4KEh5aDj04F9yk/mppWmg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793462763;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=rkymqaY7xVAzdi59LAjiM9RaFMfOkE/t6iQNHmjVNAY=;
	b=vD1lO74qNrmtqWKgDqekRFWyf4CoNkHisOZiMxLLBe0B9z51UXGYUa303rysEHMZjKkh
	 ItRlbXjgW7popX5X7ZMV2DPAUjbHfoWyxW4quonz4LhcqUy0rlt62MSr26NNPZ5NVt/nW
	 S4D9jOlHS1UCsryCYJrcJ7TMplINU0fC5BVkffkLjE28FNRX/8iO1HK4Wa/u/0i5v1wOO
	 OfxfJC6vf/HHD6OYVEr+DF9HEIvdNkskVE8WLT1Srz03qBhRBAASSSXOGYV4sSbJTf21n
	 vF1SqbfVs1doCPHLS9LI5katvWy42QLkqBy1NJt29GBUEP6R+NCMaDAE5Rj85tVbdLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id ED1DF1F00A02;
	Sat, 31 Oct 2026 16:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793462763;
	bh=rkymqaY7xVAzdi59LAjiM9RaFMfOkE/t6iQNHmjVNAY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=f48maP2DUE6yleQgq35vY96i4aVCMDxGF80luuZ92fT3SWEC9wQRlHhvzyvMbLRBO
	 g8rKVu018sDoVKHUf2vvVhfWt0xNSw+dJejYiRDFhRvRUwE1Yg2GPibAbuaEeO0hAC
	 7vm+1/QQWO/1Agct9CjeoU38sOqi6GfJf1FWeV+MliC21AXLcmZeWgBc0pYR8bXS75
	 ACU4LekX+VMmVBrZGUWgOhv4obNBxrR9BVCn0LVEBsDaUpyAytsqmyrnSxOR3Nf1fr
	 TckdJKXtI0lhVev0a+nlsugexYThxMQCGfZgZkb+sHHPLOpwhlXeUzr6Bi/Pg1ygsE
	 N22JIhUsuxLHQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4ED8945F27;
	Sat, 31 Oct 2026 16:06:02 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Sat, 31 Oct 2026 16:06:02 +0000
Subject: [PATCH] hugetlbfs: emit hugetlbfs_free_inode from
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
Message-Id: <20261031-b4-hugetlbfs-trace-v1-1-4ec8d02a30cc@gmail.com>
X-B4-Tracking: v=1; b=H4sIAOkR5moC/x3MSwqAMAwA0atI1gasrR+8irhoNGpAVNoqQvHuF
 pdvMRPBsxP20GURHN/i5dgTVJ7BuNp9YZQpGcqirFWhFZLB9Vo4bDR7DM6OjNoo0rq1VDUEKTw
 dz/L803543w8rE6aMZAAAAA==
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
 Hongbo Li <lihongbo22@huawei.com>, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com, 
 stable@vger.kernel.org, Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793462761; l=3980;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=CimqNwtPRA6nxILdhyc+0Xn4gqEkC2G7lMQ2JLmnouo=;
 b=yjuS2uTzQ9DedPHbuDm6WP0AuJe1WwYvU3AL0T/UCB287QqTTK/wXTcArMWRSVnwIEyUeH8rb
 qV6kSiKFMPyCX4BeVFMi8oIBqxxY16vKLP3MQWAKCoduXNPhXggr+3X
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

Fixes: 014ad7c42a69 ("hugetlbfs: use tracepoints in hugetlbfs functions.")
Reported-by: syzbot+91e1fc35f51774c479b2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6ae27525.5451848c.f7707.0001.GAE@google.com/
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
Resend: my mail provider blocked the original submission to the lists
on 2026-10-29, so only the direct recipients got it. No change to the
patch, except dropping a deprecated Assisted-by trailer.

David asked whether the tracepoint should be renamed now that it no
longer fires from ->free_inode(). I'd keep this patch as is, since it
is tagged for stable and the event name is visible in tracefs
(events/hugetlbfs/hugetlbfs_free_inode); renaming it in stable kernels
would break existing tracing setups just to fix the use-after-free. I
can send a follow-up for mm-unstable that renames it to
hugetlbfs_destroy_inode, next to hugetlbfs_evict_inode, or fold the
rename into a v2 if preferred.

Tested with the syzbot C reproducer on a KASAN kernel with the event
enabled: the use-after-free reproduced in 3 of 3 boots without the
patch and in none of 12 runs with it, and the event is still emitted.

Tool-use note: the analysis and testing were done with help from an
LLM-based assistant; I reviewed the change and ran the tests myself.
---
 fs/hugetlbfs/inode.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44..5bd348288 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -1179,12 +1179,16 @@ static struct inode *hugetlbfs_alloc_inode(struct super_block *sb)
 
 static void hugetlbfs_free_inode(struct inode *inode)
 {
-	trace_hugetlbfs_free_inode(inode);
 	kmem_cache_free(hugetlbfs_inode_cachep, HUGETLBFS_I(inode));
 }
 
 static void hugetlbfs_destroy_inode(struct inode *inode)
 {
+	/*
+	 * Not in ->free_inode(): that runs from an RCU callback, when the
+	 * superblock the event reads may already be freed.
+	 */
+	trace_hugetlbfs_free_inode(inode);
 	hugetlbfs_inc_free_inodes(HUGETLBFS_SB(inode->i_sb));
 }
 

---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261031-b4-hugetlbfs-trace-341b338ab57b

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


