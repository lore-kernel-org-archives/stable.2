Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB17C47AF60
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 12:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119960; cv=none; b=OCvmojiDVLlhEKDmLSoN889QU5W8orx24bnnnUcXo0++s4DBWoI/fUS3RJTyVFiafh41LDziwKIORsWztQexGcQzNl/DW4Uxzh/Mjz/xCCKtMZd+OY5WG2F6uEmjr5rGveOSuvJCrRl7T61UrbBLi+rd5sDGHTfoIJqP3s7PZh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119960; c=relaxed/simple;
	bh=QR1KtJH/AH6+jz+caLP1dhCtq9vx6yxL661RggMN8hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:MIME-Version:
	 Content-Type:References; b=MJHKpdUZd/H3QoTRR8Cp4wF79I7VToyd1RjV2ymQHGrcy6SL1rcgUCdarNjHwm4xWv+HBUfm2blk6GfYOFiZX2fQRNOl1xpSpUO5RhkuBIY98HyyoOSWKn11+GYB4CA8MjtY7PnpQQyd1SHxewwQH+mp+Bcyu2Y3hK4zZ2SQDko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=R/vbPxIp; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R/vbPxIp"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20260715125229epoutp03d465aa836d8c5c113fd970b0dc77a1e3~Cd6QxPxmm2272222722epoutp03V
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 12:52:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20260715125229epoutp03d465aa836d8c5c113fd970b0dc77a1e3~Cd6QxPxmm2272222722epoutp03V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784119949;
	bh=LnBlRGw+TZzG5V+xrdi5GyO/+gof+1IbI18UxfdZhx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R/vbPxIpyNCmo1xeYqjGuD25C+YBVIibaf9Hm6+BxCI/Q4bFECLtPOkjD8/P7z40B
	 jFhrzDpi/HX96WJVx8I3OTbr+4Fu0v2MB190XYg9TmWfemS3V1n5UVVdoFipXtvn87
	 L1LzCifAiOVEMhSMqZbfqyZ6q1tzwvJAoVrpr7+0=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPS id
	20260715125229epcas5p17bc009d6a530e4e0d56a91f725b0230a~Cd6QdmqTV2575225752epcas5p1Q;
	Wed, 15 Jul 2026 12:52:29 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.89]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4h0bg035WJz2SSKX; Wed, 15 Jul
	2026 12:52:28 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20260715125228epcas5p294ba6f5661bb690be77247e881c031c0~Cd6Pci_Q30435504355epcas5p2f;
	Wed, 15 Jul 2026 12:52:28 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260715125227epsmtip141ff12e6f3ec6abb86b8452d7f8cb17d~Cd6O48Jmc1978619786epsmtip1A;
	Wed, 15 Jul 2026 12:52:27 +0000 (GMT)
From: Shashank A P <shashank.ap@samsung.com>
To: stable@vger.kernel.org
Cc: Shashank A P <shashank.ap@samsung.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 6.1.y] fs: quota: create dedicated workqueue for
 quota_release_work
Date: Wed, 15 Jul 2026 18:21:37 +0530
Message-ID: <20260715125138.668-1-shashank.ap@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <2025101651-arrive-frail-3c0f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260715125228epcas5p294ba6f5661bb690be77247e881c031c0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260715125228epcas5p294ba6f5661bb690be77247e881c031c0
References: <2025101651-arrive-frail-3c0f@gregkh>
	<CGME20260715125228epcas5p294ba6f5661bb690be77247e881c031c0@epcas5p2.samsung.com>

There is a kernel panic due to WARN_ONCE when panic_on_warn is set.

This issue occurs when writeback is triggered due to sync call for an
opened file(ie, writeback reason is WB_REASON_SYNC). When f2fs balance
is needed at sync path, flush for quota_release_work is triggered.
By default quota_release_work is queued to "events_unbound" queue which
does not have WQ_MEM_RECLAIM flag. During f2fs balance "writeback"
workqueue tries to flush quota_release_work causing kernel panic due to
MEM_RECLAIM flag mismatch errors.

This patch creates dedicated workqueue with WQ_MEM_RECLAIM flag
for work quota_release_work.

------------[ cut here ]------------
WARNING: CPU: 4 PID: 14867 at kernel/workqueue.c:3721 check_flush_dependency+0x13c/0x148
Call trace:
 check_flush_dependency+0x13c/0x148
 __flush_work+0xd0/0x398
 flush_delayed_work+0x44/0x5c
 dquot_writeback_dquots+0x54/0x318
 f2fs_do_quota_sync+0xb8/0x1a8
 f2fs_write_checkpoint+0x3cc/0x99c
 f2fs_gc+0x190/0x750
 f2fs_balance_fs+0x110/0x168
 f2fs_write_single_data_page+0x474/0x7dc
 f2fs_write_data_pages+0x7d0/0xd0c
 do_writepages+0xe0/0x2f4
 __writeback_single_inode+0x44/0x4ac
 writeback_sb_inodes+0x30c/0x538
 wb_writeback+0xf4/0x440
 wb_workfn+0x128/0x5d4
 process_scheduled_works+0x1c4/0x45c
 worker_thread+0x32c/0x3e8
 kthread+0x11c/0x1b0
 ret_from_fork+0x10/0x20
Kernel panic - not syncing: kernel: panic_on_warn set ...

Fixes: ac6f420291b3 ("quota: flush quota_release_work upon quota writeback")
CC: stable@vger.kernel.org
Signed-off-by: Shashank A P <shashank.ap@samsung.com>
Link: https://patch.msgid.link/20250901092905.2115-1-shashank.ap@samsung.com
Signed-off-by: Jan Kara <jack@suse.cz>
(cherry picked from commit 72b7ceca857f38a8ca7c5629feffc63769638974)
---
 fs/quota/dquot.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 0aa0ed754f2e..f296872efda9 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -163,6 +163,9 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 /* SLAB cache for dquot structures */
 static struct kmem_cache *dquot_cachep;
 
+/* workqueue for work quota_release_work*/
+static struct workqueue_struct *quota_unbound_wq;
+
 int register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
@@ -916,7 +919,7 @@ void dqput(struct dquot *dquot)
 	put_releasing_dquots(dquot);
 	atomic_dec(&dquot->dq_count);
 	spin_unlock(&dq_list_lock);
-	queue_delayed_work(system_unbound_wq, &quota_release_work, 1);
+	queue_delayed_work(quota_unbound_wq, &quota_release_work, 1);
 }
 EXPORT_SYMBOL(dqput);
 
@@ -3091,6 +3094,11 @@ static int __init dquot_init(void)
 	if (register_shrinker(&dqcache_shrinker, "dquota-cache"))
 		panic("Cannot register dquot shrinker");
 
+	quota_unbound_wq = alloc_workqueue("quota_events_unbound",
+					   WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
+	if (!quota_unbound_wq)
+		panic("Cannot create quota_unbound_wq\n");
+
 	return 0;
 }
 fs_initcall(dquot_init);
-- 
2.34.1

