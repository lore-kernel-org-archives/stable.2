Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA02388E49
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784224234; cv=none; b=RXTkX0XkUHKV770AjIvm6kJw6CXyhjAS7bJfs3UgjI8Rk/PpSwrlvottfSq1Zz6wVAdUB4noC4NKJSJ9aR5mNTCakU9xskmH7KF24jvR3v4bXxl+u9jKWSTfb+SBEDMIZD5Sbu6copnspdK9LdsxvxXoUAAfYa4nq+yEh+a3S3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784224234; c=relaxed/simple;
	bh=t6LuSVvdKtL0Q7nqtONkt9H9+lVUM4S5hy9msRAuiSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kr7NZIspCaNH7r3l+NeSAqE9AueqJsceWlH2D+QzbtzPjxjKkDBfeA2oRBsQQeNFgewV7Mt303ezKeAN5tmMr3hOUT+1H7sMJg7Zqnt/AS+/+1Y0V6o5XqyDFFmCIqAUM/qoahtfVsjczxT8thERvpui0fYfLX1fHSpkViPIVJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0hVmH+9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0hVmH+9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095201F000E9;
	Thu, 16 Jul 2026 17:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784224232;
	bh=aYw8xb1dQliJZszomoj5RkR5oQJauBbtGrGZAylXyOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U0hVmH+9erQhLxiIeRCrPjZoXMIKkaZfvWtIaV5SfzqlkaGgbk1yBk7dpdOawas5n
	 XJTCAro6AWEcifeCgFaZuXaWBAvmCXSkrwh6SwhTlF7PwFIw3ih6tq9EbwBrLGoagR
	 GfXVrM+Y9LoKqB+5NfIFXnMFWVF7Y4sCn8V3LYyKTs4qIcKpvZfKCi2dlN+eEJWYBC
	 Cn3RkcK/a6a3PpnLW7xRgvhV09rg0nXJpmNHerghAOjCt+d9ML47cyemiqjyd+PyC8
	 O71rMd0fsf5OCROiZox0MI1nwvVw89R7pClD0vLncenw/yYCn0W+E9Zp8qs2XrAiEV
	 KHEyWyxJYDE4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] writeback: Avoid contention on wb->list_lock when switching inodes
Date: Thu, 16 Jul 2026 13:50:29 -0400
Message-ID: <20260716175030.804337-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071445-sank-sadness-63d6@gregkh>
References: <2026071445-sank-sadness-63d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit e1b849cfa6b61f1c866a908c9e8dd9b5aaab820b ]

There can be multiple inode switch works that are trying to switch
inodes to / from the same wb. This can happen in particular if some
cgroup exits which owns many (thousands) inodes and we need to switch
them all. In this case several inode_switch_wbs_work_fn() instances will
be just spinning on the same wb->list_lock while only one of them makes
forward progress. This wastes CPU cycles and quickly leads to softlockup
reports and unusable system.

Instead of running several inode_switch_wbs_work_fn() instances in
parallel switching to the same wb and contending on wb->list_lock, run
just one work item per wb and manage a queue of isw items switching to
this wb.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Stable-dep-of: cba38ec4cbd3 ("writeback: fix race between cgroup_writeback_umount() and inode_switch_wbs()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fs-writeback.c                | 99 ++++++++++++++++++++------------
 include/linux/backing-dev-defs.h |  4 ++
 include/linux/writeback.h        |  2 +
 mm/backing-dev.c                 |  5 ++
 4 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index a1236a178a7b67..150f8605e76709 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -345,7 +345,8 @@ static struct bdi_writeback *inode_to_wb_and_lock_list(struct inode *inode)
 }
 
 struct inode_switch_wbs_context {
-	struct rcu_work		work;
+	/* List of queued switching contexts for the wb */
+	struct llist_node	list;
 
 	/*
 	 * Multiple inodes can be switched at once.  The switching procedure
@@ -355,7 +356,6 @@ struct inode_switch_wbs_context {
 	 * array embedded into struct inode_switch_wbs_context.  Otherwise
 	 * an inode could be left in a non-consistent state.
 	 */
-	struct bdi_writeback	*new_wb;
 	struct inode		*inodes[];
 };
 
@@ -464,13 +464,11 @@ static bool inode_do_switch_wbs(struct inode *inode,
 	return switched;
 }
 
-static void inode_switch_wbs_work_fn(struct work_struct *work)
+static void process_inode_switch_wbs(struct bdi_writeback *new_wb,
+				     struct inode_switch_wbs_context *isw)
 {
-	struct inode_switch_wbs_context *isw =
-		container_of(to_rcu_work(work), struct inode_switch_wbs_context, work);
 	struct backing_dev_info *bdi = inode_to_bdi(isw->inodes[0]);
 	struct bdi_writeback *old_wb = isw->inodes[0]->i_wb;
-	struct bdi_writeback *new_wb = isw->new_wb;
 	unsigned long nr_switched = 0;
 	struct inode **inodep;
 
@@ -530,6 +528,38 @@ static void inode_switch_wbs_work_fn(struct work_struct *work)
 	atomic_dec(&isw_nr_in_flight);
 }
 
+void inode_switch_wbs_work_fn(struct work_struct *work)
+{
+	struct bdi_writeback *new_wb = container_of(work, struct bdi_writeback,
+						    switch_work);
+	struct inode_switch_wbs_context *isw, *next_isw;
+	struct llist_node *list;
+
+	/*
+	 * Grab out reference to wb so that it cannot get freed under us
+	 * after we process all the isw items.
+	 */
+	wb_get(new_wb);
+	while (1) {
+		list = llist_del_all(&new_wb->switch_wbs_ctxs);
+		/* Nothing to do? */
+		if (!list)
+			break;
+		/*
+		 * In addition to synchronizing among switchers, I_WB_SWITCH
+		 * tells the RCU protected stat update paths to grab the i_page
+		 * lock so that stat transfer can synchronize against them.
+		 * Let's continue after I_WB_SWITCH is guaranteed to be
+		 * visible.
+		 */
+		synchronize_rcu();
+
+		llist_for_each_entry_safe(isw, next_isw, list, list)
+			process_inode_switch_wbs(new_wb, isw);
+	}
+	wb_put(new_wb);
+}
+
 static bool inode_prepare_wbs_switch(struct inode *inode,
 				     struct bdi_writeback *new_wb)
 {
@@ -559,6 +589,13 @@ static bool inode_prepare_wbs_switch(struct inode *inode,
 	return true;
 }
 
+static void wb_queue_isw(struct bdi_writeback *wb,
+			 struct inode_switch_wbs_context *isw)
+{
+	if (llist_add(&isw->list, &wb->switch_wbs_ctxs))
+		queue_work(isw_wq, &wb->switch_work);
+}
+
 /**
  * inode_switch_wbs - change the wb association of an inode
  * @inode: target inode
@@ -572,6 +609,7 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	struct backing_dev_info *bdi = inode_to_bdi(inode);
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
+	struct bdi_writeback *new_wb = NULL;
 
 	/* noop if seems to be already in progress */
 	if (inode->i_state & I_WB_SWITCH)
@@ -596,40 +634,34 @@ static void inode_switch_wbs(struct inode *inode, int new_wb_id)
 	if (!memcg_css)
 		goto out_free;
 
-	isw->new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
+	new_wb = wb_get_create(bdi, memcg_css, GFP_ATOMIC);
 	css_put(memcg_css);
-	if (!isw->new_wb)
+	if (!new_wb)
 		goto out_free;
 
-	if (!inode_prepare_wbs_switch(inode, isw->new_wb))
+	if (!inode_prepare_wbs_switch(inode, new_wb))
 		goto out_free;
 
 	isw->inodes[0] = inode;
 
-	/*
-	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
-	 * the RCU protected stat update paths to grab the i_page
-	 * lock so that stat transfer can synchronize against them.
-	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
-	 */
-	INIT_RCU_WORK(&isw->work, inode_switch_wbs_work_fn);
-	queue_rcu_work(isw_wq, &isw->work);
+	wb_queue_isw(new_wb, isw);
 	return;
 
 out_free:
 	atomic_dec(&isw_nr_in_flight);
-	if (isw->new_wb)
-		wb_put(isw->new_wb);
+	if (new_wb)
+		wb_put(new_wb);
 	kfree(isw);
 }
 
-static bool isw_prepare_wbs_switch(struct inode_switch_wbs_context *isw,
+static bool isw_prepare_wbs_switch(struct bdi_writeback *new_wb,
+				   struct inode_switch_wbs_context *isw,
 				   struct list_head *list, int *nr)
 {
 	struct inode *inode;
 
 	list_for_each_entry(inode, list, i_io_list) {
-		if (!inode_prepare_wbs_switch(inode, isw->new_wb))
+		if (!inode_prepare_wbs_switch(inode, new_wb))
 			continue;
 
 		isw->inodes[*nr] = inode;
@@ -653,6 +685,7 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 {
 	struct cgroup_subsys_state *memcg_css;
 	struct inode_switch_wbs_context *isw;
+	struct bdi_writeback *new_wb;
 	int nr;
 	bool restart = false;
 
@@ -665,12 +698,12 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 
 	for (memcg_css = wb->memcg_css->parent; memcg_css;
 	     memcg_css = memcg_css->parent) {
-		isw->new_wb = wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
-		if (isw->new_wb)
+		new_wb = wb_get_create(wb->bdi, memcg_css, GFP_KERNEL);
+		if (new_wb)
 			break;
 	}
-	if (unlikely(!isw->new_wb))
-		isw->new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
+	if (unlikely(!new_wb))
+		new_wb = &wb->bdi->wb; /* wb_get() is noop for bdi's wb */
 
 	nr = 0;
 	spin_lock(&wb->list_lock);
@@ -682,27 +715,21 @@ bool cleanup_offline_cgwb(struct bdi_writeback *wb)
 	 * bandwidth restrictions, as writeback of inode metadata is not
 	 * accounted for.
 	 */
-	restart = isw_prepare_wbs_switch(isw, &wb->b_attached, &nr);
+	restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_attached, &nr);
 	if (!restart)
-		restart = isw_prepare_wbs_switch(isw, &wb->b_dirty_time, &nr);
+		restart = isw_prepare_wbs_switch(new_wb, isw, &wb->b_dirty_time,
+						 &nr);
 	spin_unlock(&wb->list_lock);
 
 	/* no attached inodes? bail out */
 	if (nr == 0) {
 		atomic_dec(&isw_nr_in_flight);
-		wb_put(isw->new_wb);
+		wb_put(new_wb);
 		kfree(isw);
 		return restart;
 	}
 
-	/*
-	 * In addition to synchronizing among switchers, I_WB_SWITCH tells
-	 * the RCU protected stat update paths to grab the i_page
-	 * lock so that stat transfer can synchronize against them.
-	 * Let's continue after I_WB_SWITCH is guaranteed to be visible.
-	 */
-	INIT_RCU_WORK(&isw->work, inode_switch_wbs_work_fn);
-	queue_rcu_work(isw_wq, &isw->work);
+	wb_queue_isw(new_wb, isw);
 
 	return restart;
 }
diff --git a/include/linux/backing-dev-defs.h b/include/linux/backing-dev-defs.h
index 2ad261082bba5f..c5c9d89c73edcc 100644
--- a/include/linux/backing-dev-defs.h
+++ b/include/linux/backing-dev-defs.h
@@ -152,6 +152,10 @@ struct bdi_writeback {
 	struct list_head blkcg_node;	/* anchored at blkcg->cgwb_list */
 	struct list_head b_attached;	/* attached inodes, protected by list_lock */
 	struct list_head offline_node;	/* anchored at offline_cgwbs */
+	struct work_struct switch_work;	/* work used to perform inode switching
+					 * to this wb */
+	struct llist_head switch_wbs_ctxs;	/* queued contexts for
+						 * writeback switching */
 
 	union {
 		struct work_struct release_work;
diff --git a/include/linux/writeback.h b/include/linux/writeback.h
index 083387c00f0c8b..a7a061c7a7706b 100644
--- a/include/linux/writeback.h
+++ b/include/linux/writeback.h
@@ -283,6 +283,8 @@ static inline void wbc_init_bio(struct writeback_control *wbc, struct bio *bio)
 		bio_associate_blkg_from_css(bio, wbc->wb->blkcg_css);
 }
 
+void inode_switch_wbs_work_fn(struct work_struct *work);
+
 #else	/* CONFIG_CGROUP_WRITEBACK */
 
 static inline void inode_attach_wb(struct inode *inode, struct folio *folio)
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 4234caa564b3ee..dabab8461f0d6e 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -545,6 +545,7 @@ static void cgwb_release_workfn(struct work_struct *work)
 	wb_exit(wb);
 	bdi_put(bdi);
 	WARN_ON_ONCE(!list_empty(&wb->b_attached));
+	WARN_ON_ONCE(work_pending(&wb->switch_work));
 	call_rcu(&wb->rcu, cgwb_free_rcu);
 }
 
@@ -621,6 +622,8 @@ static int cgwb_create(struct backing_dev_info *bdi,
 	wb->memcg_css = memcg_css;
 	wb->blkcg_css = blkcg_css;
 	INIT_LIST_HEAD(&wb->b_attached);
+	INIT_WORK(&wb->switch_work, inode_switch_wbs_work_fn);
+	init_llist_head(&wb->switch_wbs_ctxs);
 	INIT_WORK(&wb->release_work, cgwb_release_workfn);
 	set_bit(WB_registered, &wb->state);
 	bdi_get(bdi);
@@ -751,6 +754,8 @@ static int cgwb_bdi_init(struct backing_dev_info *bdi)
 	if (!ret) {
 		bdi->wb.memcg_css = &root_mem_cgroup->css;
 		bdi->wb.blkcg_css = blkcg_root_css;
+		INIT_WORK(&bdi->wb.switch_work, inode_switch_wbs_work_fn);
+		init_llist_head(&bdi->wb.switch_wbs_ctxs);
 	}
 	return ret;
 }
-- 
2.53.0

