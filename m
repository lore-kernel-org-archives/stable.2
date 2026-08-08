Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57453A83A9
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187566; cv=none; b=JgtrM5sihJhggx1iD2Mj1LfzPTB2TMtg3PRzJIUhe3aU6hVEp2vhJYMOeAI2+/l3UZzfFh6n1VFulxhUlsUZ3tVrPFlaLz3oE/1YgstpYKbYDmjxqry0cSj/3A3sAD0vN0YqBlw0xqCITZnvRkzt/FWPgwzQ/fPOSayp/5eLQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187566; c=relaxed/simple;
	bh=SPV/I3V7PACITI0RiNfQ7kruNXiWWaUkv1ac9FkDvbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rabmfovon442l4t0M7Iwz1w9Xl/GGEDsyA/E8xrfah50dgncbigeytDQIuHUX1cIot+1ygYr7gtYQCcqnraCGbz/6NCEweU4GxTOlbuFQRQlqUU8Zmk6hwaGFtBV0MXecytLcPSS+eOufZHI7tkY2GynG8031n+QtBLRRhuRbgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j4YNK5Dt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j4YNK5Dt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7F311F00A3A;
	Sat,  8 Aug 2026 11:12:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187563;
	bh=8J8dokGncWT00aBChig48ye7Xcnp/qnfm4op0SkGmHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j4YNK5DtchEQvd42Vp26yPcyrHPyXt7/qrIMSWkz+8TIXy7bc+3aD+N9h4WnFTrnM
	 /rUa8uVwFa6XKgQqVpuBkkV9rmeAzE2O8tsz58lOG78WO5vNPVkNqBm8FuTWzgY9AC
	 5X8DgSkHoHfYIoZi7SkxGc3/fRkvwdOx5lbypbLEeulF3JK77BTzS9pk4Hyr5+Knoy
	 ZlCqgw3TjAY548ENuUgJLDnnxAmaLVA2+eN19Y1Ww6x0cBnFhjxCZmQkLPJKrqsOR5
	 ZMUIeYG6SLkyVlI/IHdUhUtvqW83iOiNrq1SydW0hfGvNAf/df7gW0Ild9hYYFt30i
	 tL/06FyMJVTNg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] ceph: rename _to_client() to _to_fs_client()
Date: Sat,  8 Aug 2026 07:12:38 -0400
Message-ID: <20260808111240.93994-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808111240.93994-1-sashal@kernel.org>
References: <2026072911-tipoff-trilogy-a6d0@gregkh>
 <20260808111240.93994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiubo Li <xiubli@redhat.com>

[ Upstream commit 5995d90d2d19f337df6a50bcf4699ef053214dac ]

We need to covert the inode to ceph_client in the following commit,
and will add one new helper for that, here we rename the old helper
to _fs_client().

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: 50958bb928ba ("ceph: fix hanging __ceph_get_caps() with stale mds_wanted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/addr.c   | 20 ++++++++++----------
 fs/ceph/cache.c  |  2 +-
 fs/ceph/caps.c   | 36 ++++++++++++++++++------------------
 fs/ceph/dir.c    | 20 ++++++++++----------
 fs/ceph/export.c | 10 +++++-----
 fs/ceph/file.c   | 24 ++++++++++++------------
 fs/ceph/inode.c  | 14 +++++++-------
 fs/ceph/ioctl.c  |  8 ++++----
 fs/ceph/snap.c   |  2 +-
 fs/ceph/super.c  | 22 +++++++++++-----------
 fs/ceph/super.h  |  8 ++++----
 fs/ceph/xattr.c  | 12 ++++++------
 12 files changed, 89 insertions(+), 89 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 7b65d4b5ebe88..618ef368b5649 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -196,7 +196,7 @@ static void ceph_netfs_expand_readahead(struct netfs_read_request *rreq)
 static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 {
 	struct inode *inode = subreq->rreq->inode;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	u64 objno, objoff;
 	u32 xlen;
@@ -210,7 +210,7 @@ static bool ceph_netfs_clamp_length(struct netfs_read_subrequest *subreq)
 
 static void finish_netfs_read(struct ceph_osd_request *req)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(req->r_inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(req->r_inode);
 	struct ceph_osd_data *osd_data = osd_req_op_extent_osd_data(req, 0);
 	struct netfs_read_subrequest *subreq = req->r_priv;
 	int num_pages;
@@ -243,7 +243,7 @@ static void ceph_netfs_issue_op(struct netfs_read_subrequest *subreq)
 	struct netfs_read_request *rreq = subreq->rreq;
 	struct inode *inode = rreq->inode;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
 	struct ceph_vino vino = ceph_vino(inode);
 	struct iov_iter iter;
@@ -483,7 +483,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 {
 	struct inode *inode = page->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_snap_context *snapc, *oldest;
 	loff_t page_off = page_offset(page);
 	int err;
@@ -625,7 +625,7 @@ static void writepages_finish(struct ceph_osd_request *req)
 	int rc = req->r_result;
 	struct ceph_snap_context *snapc = req->r_snapc;
 	struct address_space *mapping = inode->i_mapping;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	unsigned int len = 0;
 	bool remove_page;
 
@@ -707,7 +707,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 {
 	struct inode *inode = mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_vino vino = ceph_vino(inode);
 	pgoff_t index, start_index, end = -1;
 	struct ceph_snap_context *snapc = NULL, *last_snapc = NULL, *pgsnapc;
@@ -1144,7 +1144,7 @@ static struct ceph_snap_context *
 ceph_find_incompatible(struct page *page)
 {
 	struct inode *inode = page->mapping->host;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (READ_ONCE(fsc->mount_state) >= CEPH_MOUNT_SHUTDOWN) {
@@ -1594,7 +1594,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
 {
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
 	struct page *page = NULL;
 	u64 len, inline_version;
@@ -1751,7 +1751,7 @@ enum {
 static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
 				s64 pool, struct ceph_string *pool_ns)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(&ci->vfs_inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(&ci->vfs_inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_osd_request *rd_req = NULL, *wr_req = NULL;
 	struct rb_node **p, *parent;
@@ -1944,7 +1944,7 @@ int ceph_pool_perm_check(struct inode *inode, int need)
 		return 0;
 	}
 
-	if (ceph_test_mount_opt(ceph_inode_to_client(inode),
+	if (ceph_test_mount_opt(ceph_inode_to_fs_client(inode),
 				NOPOOLPERM))
 		return 0;
 
diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 9cfadbb865685..d22020f2f0e0e 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -138,7 +138,7 @@ static const struct fscache_cookie_def ceph_fscache_inode_object_def = {
 void ceph_fscache_register_inode_cookie(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_aux_inode aux;
 
 	/* No caching for filesystem */
diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index e37e9fa457aff..8542e06c43cea 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -633,7 +633,7 @@ void ceph_add_cap(struct inode *inode,
 		  unsigned seq, unsigned mseq, u64 realmino, int flags,
 		  struct ceph_cap **new_cap)
 {
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap *cap;
 	int mds = session->s_mds;
@@ -919,7 +919,7 @@ int __ceph_caps_issued_mask(struct ceph_inode_info *ci, int mask, int touch)
 int __ceph_caps_issued_mask_metric(struct ceph_inode_info *ci, int mask,
 				   int touch)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	int r;
 
 	r = __ceph_caps_issued_mask(ci, mask, touch);
@@ -993,7 +993,7 @@ int __ceph_caps_file_wanted(struct ceph_inode_info *ci)
 	const int WR_SHIFT = ffs(CEPH_FILE_MODE_WR);
 	const int LAZY_SHIFT = ffs(CEPH_FILE_MODE_LAZY);
 	struct ceph_mount_options *opt =
-		ceph_inode_to_client(&ci->vfs_inode)->mount_options;
+		ceph_inode_to_fs_client(&ci->vfs_inode)->mount_options;
 	unsigned long used_cutoff = jiffies - opt->caps_wanted_delay_max * HZ;
 	unsigned long idle_cutoff = jiffies - opt->caps_wanted_delay_min * HZ;
 
@@ -1118,7 +1118,7 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 
 	dout("__ceph_remove_cap %p from %p\n", cap, &ci->vfs_inode);
 
-	mdsc = ceph_inode_to_client(&ci->vfs_inode)->mdsc;
+	mdsc = ceph_inode_to_fs_client(&ci->vfs_inode)->mdsc;
 
 	/* remove from inode's cap rbtree, and clear auth cap */
 	rb_erase(&cap->ci_node, &ci->i_caps);
@@ -1188,7 +1188,7 @@ void ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 
 	lockdep_assert_held(&ci->i_ceph_lock);
 
-	fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	WARN_ON_ONCE(ci->i_auth_cap == cap &&
 		     !list_empty(&ci->i_dirty_item) &&
 		     !fsc->blocklisted &&
@@ -1623,7 +1623,7 @@ void ceph_flush_snaps(struct ceph_inode_info *ci,
 		      struct ceph_mds_session **psession)
 {
 	struct inode *inode = &ci->vfs_inode;
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_mds_session *session = NULL;
 	bool need_put = false;
 	int mds;
@@ -1688,7 +1688,7 @@ int __ceph_mark_dirty_caps(struct ceph_inode_info *ci, int mask,
 			   struct ceph_cap_flush **pcf)
 {
 	struct ceph_mds_client *mdsc =
-		ceph_sb_to_client(ci->vfs_inode.i_sb)->mdsc;
+		ceph_sb_to_fs_client(ci->vfs_inode.i_sb)->mdsc;
 	struct inode *inode = &ci->vfs_inode;
 	int was = ci->i_dirty_caps;
 	int dirty = 0;
@@ -1811,7 +1811,7 @@ static u64 __mark_caps_flushing(struct inode *inode,
 				struct ceph_mds_session *session, bool wake,
 				u64 *oldest_flush_tid)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_cap_flush *cf = NULL;
 	int flushing;
@@ -2143,7 +2143,7 @@ void ceph_check_caps(struct ceph_inode_info *ci, int flags,
  */
 static int try_flush_caps(struct inode *inode, u64 *ptid)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	int flushing = 0;
 	u64 flush_tid = 0, oldest_flush_tid = 0;
@@ -2221,7 +2221,7 @@ static int caps_are_flushed(struct inode *inode, u64 flush_tid)
  */
 static int unsafe_request_wait(struct inode *inode)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req1 = NULL, *req2 = NULL;
 	int ret, err = 0;
@@ -2400,7 +2400,7 @@ int ceph_write_inode(struct inode *inode, struct writeback_control *wbc)
 				       caps_are_flushed(inode, flush_tid));
 	} else {
 		struct ceph_mds_client *mdsc =
-			ceph_sb_to_client(inode->i_sb)->mdsc;
+			ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
 		spin_lock(&ci->i_ceph_lock);
 		if (__ceph_caps_dirty(ci))
@@ -2649,7 +2649,7 @@ static int try_get_cap_refs(struct inode *inode, int need, int want,
 			    loff_t endoff, int flags, int *got)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	int ret = 0;
 	int have, implemented;
 	bool snap_rwsem_locked = false;
@@ -2864,7 +2864,7 @@ int ceph_get_caps(struct file *filp, int need, int want, loff_t endoff, int *got
 	struct ceph_file_info *fi = filp->private_data;
 	struct inode *inode = file_inode(filp);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int ret, _got, flags;
 
 	ret = ceph_pool_perm_check(inode, need);
@@ -3593,7 +3593,7 @@ static void handle_cap_flush_ack(struct inode *inode, u64 flush_tid,
 	__releases(ci->i_ceph_lock)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *cf, *tmp_cf;
 	LIST_HEAD(to_remove);
 	unsigned seq = le32_to_cpu(m->seq);
@@ -3699,7 +3699,7 @@ void __ceph_remove_capsnap(struct inode *inode, struct ceph_cap_snap *capsnap,
 			   bool *wake_ci, bool *wake_mdsc)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	bool ret;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
@@ -3743,7 +3743,7 @@ static void handle_cap_flushsnap_ack(struct inode *inode, u64 flush_tid,
 				     struct ceph_mds_session *session)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	u64 follows = le64_to_cpu(m->snap_follows);
 	struct ceph_cap_snap *capsnap;
 	bool flushed = false;
@@ -3827,7 +3827,7 @@ static void handle_cap_export(struct inode *inode, struct ceph_mds_caps *ex,
 			      struct ceph_mds_cap_peer *ph,
 			      struct ceph_mds_session *session)
 {
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_mds_session *tsession = NULL;
 	struct ceph_cap *cap, *tcap, *new_cap = NULL;
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -4441,7 +4441,7 @@ int ceph_drop_caps_for_unlink(struct inode *inode)
 
 		if (__ceph_caps_dirty(ci)) {
 			struct ceph_mds_client *mdsc =
-				ceph_inode_to_client(inode)->mdsc;
+				ceph_inode_to_fs_client(inode)->mdsc;
 			__cap_delay_requeue_front(mdsc, ci);
 		}
 	}
diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index f1572609066e3..74845a793aa36 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -307,7 +307,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
 	struct ceph_dir_file_info *dfi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	int i;
 	int err;
@@ -679,7 +679,7 @@ static loff_t ceph_dir_llseek(struct file *file, loff_t offset, int whence)
 struct dentry *ceph_handle_snapdir(struct ceph_mds_request *req,
 				   struct dentry *dentry)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 	struct inode *parent = d_inode(dentry->d_parent); /* we hold i_mutex */
 
 	/* .snap dir? */
@@ -748,7 +748,7 @@ static bool is_root_ceph_dentry(struct inode *inode, struct dentry *dentry)
 static struct dentry *ceph_lookup(struct inode *dir, struct dentry *dentry,
 				  unsigned int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(dir->i_sb);
 	struct ceph_mds_request *req;
 	int op;
@@ -1147,7 +1147,7 @@ static int get_caps_for_async_unlink(struct inode *dir, struct dentry *dentry)
  */
 static int ceph_unlink(struct inode *dir, struct dentry *dentry)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct inode *inode = d_inode(dentry);
 	struct ceph_inode_info *ci = ceph_inode(inode);
@@ -1308,7 +1308,7 @@ void __ceph_dentry_lease_touch(struct ceph_dentry_info *di)
 		return;
 	}
 
-	mdsc = ceph_sb_to_client(dn->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	list_move_tail(&di->lease_list, &mdsc->dentry_leases);
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1355,7 +1355,7 @@ void __ceph_dentry_dir_lease_touch(struct ceph_dentry_info *di)
 		return;
 	}
 
-	mdsc = ceph_sb_to_client(dn->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dn->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	__dentry_dir_lease_touch(mdsc, di),
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1369,7 +1369,7 @@ static void __dentry_lease_unlist(struct ceph_dentry_info *di)
 	if (list_empty(&di->lease_list))
 		return;
 
-	mdsc = ceph_sb_to_client(di->dentry->d_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(di->dentry->d_sb)->mdsc;
 	spin_lock(&mdsc->dentry_list_lock);
 	list_del_init(&di->lease_list);
 	spin_unlock(&mdsc->dentry_list_lock);
@@ -1722,7 +1722,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 	dout("d_revalidate %p '%pd' inode %p offset 0x%llx\n", dentry,
 	     dentry, inode, ceph_dentry(dentry)->offset);
 
-	mdsc = ceph_sb_to_client(dir->i_sb)->mdsc;
+	mdsc = ceph_sb_to_fs_client(dir->i_sb)->mdsc;
 
 	/* always trust cached snapped dentries, snapdir dentry */
 	if (ceph_snap(dir) != CEPH_NOSNAP) {
@@ -1829,7 +1829,7 @@ static int ceph_d_delete(const struct dentry *dentry)
 static void ceph_d_release(struct dentry *dentry)
 {
 	struct ceph_dentry_info *di = ceph_dentry(dentry);
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dentry->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dentry->d_sb);
 
 	dout("d_release %p\n", dentry);
 
@@ -1898,7 +1898,7 @@ static ssize_t ceph_read_dir(struct file *file, char __user *buf, size_t size,
 	int left;
 	const int bufsize = 1024;
 
-	if (!ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb), DIRSTAT))
+	if (!ceph_test_mount_opt(ceph_sb_to_fs_client(inode->i_sb), DIRSTAT))
 		return -EISDIR;
 
 	if (!dfi->dir_info) {
diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 1d65934c12620..466af8e0cbce1 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -122,7 +122,7 @@ static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 
 static struct inode *__lookup_inode(struct super_block *sb, u64 ino)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct inode *inode;
 	struct ceph_vino vino;
 	int err;
@@ -198,7 +198,7 @@ static struct dentry *__snapfh_to_dentry(struct super_block *sb,
 					  struct ceph_nfs_snapfh *sfh,
 					  bool want_parent)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct inode *inode;
 	struct ceph_vino vino;
@@ -305,7 +305,7 @@ static struct dentry *ceph_fh_to_dentry(struct super_block *sb,
 static struct dentry *__get_parent(struct super_block *sb,
 				   struct dentry *child, u64 ino)
 {
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct inode *inode;
 	int mask;
@@ -427,7 +427,7 @@ static int __get_snap_name(struct dentry *parent, char *name,
 {
 	struct inode *inode = d_inode(child);
 	struct inode *dir = d_inode(parent);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_mds_request *req = NULL;
 	char *last_name = NULL;
 	unsigned next_offset = 2;
@@ -530,7 +530,7 @@ static int ceph_get_name(struct dentry *parent, char *name,
 	if (ceph_snap(inode) != CEPH_NOSNAP)
 		return __get_snap_name(parent, name, child);
 
-	mdsc = ceph_inode_to_client(inode)->mdsc;
+	mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	req = ceph_mdsc_create_request(mdsc, CEPH_MDS_OP_LOOKUPNAME,
 				       USE_ANY_MDS);
 	if (IS_ERR(req))
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index ca8d228ee395c..a8358485263a4 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -233,7 +233,7 @@ static int ceph_init_file_info(struct inode *inode, struct file *file,
 
 	spin_lock_init(&fi->rw_contexts_lock);
 	INIT_LIST_HEAD(&fi->rw_contexts);
-	fi->filp_gen = READ_ONCE(ceph_inode_to_client(inode)->filp_gen);
+	fi->filp_gen = READ_ONCE(ceph_inode_to_fs_client(inode)->filp_gen);
 
 	return 0;
 }
@@ -338,7 +338,7 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 int ceph_open(struct inode *inode, struct file *file)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_file_info *fi = file->private_data;
@@ -687,7 +687,7 @@ static int ceph_finish_async_create(struct inode *dir, struct dentry *dentry,
 int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(dir->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	struct dentry *dn;
@@ -875,7 +875,7 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	ssize_t ret;
 	u64 off = iocb->ki_pos;
@@ -1085,7 +1085,7 @@ static void ceph_aio_complete_req(struct ceph_osd_request *req)
 		if (aio_work) {
 			INIT_WORK(&aio_work->work, ceph_aio_retry_work);
 			aio_work->req = req;
-			queue_work(ceph_inode_to_client(inode)->inode_wq,
+			queue_work(ceph_inode_to_fs_client(inode)->inode_wq,
 				   &aio_work->work);
 			return;
 		}
@@ -1213,7 +1213,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client_metric *metric = &fsc->mdsc->metric;
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
@@ -1423,7 +1423,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
 	struct file *file = iocb->ki_filp;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_vino vino;
 	struct ceph_osd_request *req;
 	struct page **pages;
@@ -1702,7 +1702,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_cap_flush *prealloc_cf;
 	ssize_t count, written = 0;
@@ -1895,7 +1895,7 @@ static ssize_t ceph_write_iter(struct kiocb *iocb, struct iov_iter *from)
 static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	loff_t i_size;
 	loff_t ret;
 
@@ -1988,7 +1988,7 @@ static int ceph_zero_partial_object(struct inode *inode,
 				    loff_t offset, loff_t *length)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_osd_request *req;
 	struct ceph_snap_context *snapc;
 	int ret = 0;
@@ -2332,7 +2332,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	struct ceph_inode_info *src_ci = ceph_inode(src_inode);
 	struct ceph_inode_info *dst_ci = ceph_inode(dst_inode);
 	struct ceph_cap_flush *prealloc_cf;
-	struct ceph_fs_client *src_fsc = ceph_inode_to_client(src_inode);
+	struct ceph_fs_client *src_fsc = ceph_inode_to_fs_client(src_inode);
 	loff_t size;
 	ssize_t ret = -EIO, bytes;
 	u64 src_objnum, dst_objnum, src_objoff, dst_objoff;
@@ -2340,7 +2340,7 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	int src_got = 0, dst_got = 0, err, dirty;
 
 	if (src_inode->i_sb != dst_inode->i_sb) {
-		struct ceph_fs_client *dst_fsc = ceph_inode_to_client(dst_inode);
+		struct ceph_fs_client *dst_fsc = ceph_inode_to_fs_client(dst_inode);
 
 		if (ceph_fsid_compare(&src_fsc->client->fsid,
 				      &dst_fsc->client->fsid)) {
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 28281c83cf5f6..3adc4adef49a8 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1272,7 +1272,7 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 	struct ceph_mds_reply_info_parsed *rinfo = &req->r_reply_info;
 	struct inode *in = NULL;
 	struct ceph_vino tvino, dvino;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	int err = 0;
 
 	dout("fill_trace %p is_dentry %d is_target %d\n", req,
@@ -1828,7 +1828,7 @@ bool ceph_inode_set_size(struct inode *inode, loff_t size)
 
 void ceph_queue_inode_work(struct inode *inode, int work_bit)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	set_bit(work_bit, &ci->i_work_mask);
 
@@ -1845,7 +1845,7 @@ void ceph_queue_inode_work(struct inode *inode, int work_bit)
 static void ceph_do_invalidate_pages(struct inode *inode)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	u32 orig_gen;
 	int check = 0;
 
@@ -2000,7 +2000,7 @@ int __ceph_setattr(struct inode *inode, struct iattr *attr)
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	unsigned int ia_valid = attr->ia_valid;
 	struct ceph_mds_request *req;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *prealloc_cf;
 	int issued;
 	int release = 0, dirtied = 0;
@@ -2215,7 +2215,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 		 struct iattr *attr)
 {
 	struct inode *inode = d_inode(dentry);
-	struct ceph_fs_client *fsc = ceph_inode_to_client(inode);
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	int err;
 
 	if (ceph_snap(inode) != CEPH_NOSNAP)
@@ -2248,7 +2248,7 @@ int ceph_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 int __ceph_do_getattr(struct inode *inode, struct page *locked_page,
 		      int mask, bool force)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_mds_client *mdsc = fsc->mdsc;
 	struct ceph_mds_request *req;
 	int mode;
@@ -2378,7 +2378,7 @@ int ceph_getattr(struct user_namespace *mnt_userns, const struct path *path,
 		stat->dev = ci->i_snapid_map ? ci->i_snapid_map->dev : 0;
 
 	if (S_ISDIR(inode->i_mode)) {
-		if (ceph_test_mount_opt(ceph_sb_to_client(inode->i_sb),
+		if (ceph_test_mount_opt(ceph_sb_to_fs_client(inode->i_sb),
 					RBYTES))
 			stat->size = ci->i_rbytes;
 		else
diff --git a/fs/ceph/ioctl.c b/fs/ceph/ioctl.c
index 6e061bf62ad47..7ba8bb520e845 100644
--- a/fs/ceph/ioctl.c
+++ b/fs/ceph/ioctl.c
@@ -64,7 +64,7 @@ static long __validate_layout(struct ceph_mds_client *mdsc,
 static long ceph_ioctl_set_layout(struct file *file, void __user *arg)
 {
 	struct inode *inode = file_inode(file);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	struct ceph_inode_info *ci = ceph_inode(file_inode(file));
@@ -139,7 +139,7 @@ static long ceph_ioctl_set_layout_policy (struct file *file, void __user *arg)
 	struct ceph_mds_request *req;
 	struct ceph_ioctl_layout l;
 	int err;
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 
 	/* copy and validate */
 	if (copy_from_user(&l, arg, sizeof(l)))
@@ -182,7 +182,7 @@ static long ceph_ioctl_get_dataloc(struct file *file, void __user *arg)
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_osd_client *osdc =
-		&ceph_sb_to_client(inode->i_sb)->client->osdc;
+		&ceph_sb_to_fs_client(inode->i_sb)->client->osdc;
 	struct ceph_object_locator oloc;
 	CEPH_DEFINE_OID_ONSTACK(oid);
 	u32 xlen;
@@ -243,7 +243,7 @@ static long ceph_ioctl_lazyio(struct file *file)
 	struct ceph_file_info *fi = file->private_data;
 	struct inode *inode = file_inode(file);
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 
 	if ((fi->fmode & CEPH_FILE_MODE_LAZY) == 0) {
 		spin_lock(&ci->i_ceph_lock);
diff --git a/fs/ceph/snap.c b/fs/ceph/snap.c
index bfa7e146f5262..74a1fc919c6be 100644
--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -875,7 +875,7 @@ static void flush_snaps(struct ceph_mds_client *mdsc)
 void ceph_change_snap_realm(struct inode *inode, struct ceph_snap_realm *realm)
 {
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_inode_to_client(inode)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_inode_to_fs_client(inode)->mdsc;
 	struct ceph_snap_realm *oldrealm = ci->i_snap_realm;
 
 	lockdep_assert_held(&ci->i_ceph_lock);
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 85a283992b44b..e520ad25454a9 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -41,7 +41,7 @@ static LIST_HEAD(ceph_fsc_list);
  */
 static void ceph_put_super(struct super_block *s)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
 
 	dout("put_super\n");
 	ceph_mdsc_close_sessions(fsc->mdsc);
@@ -49,7 +49,7 @@ static void ceph_put_super(struct super_block *s)
 
 static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 {
-	struct ceph_fs_client *fsc = ceph_inode_to_client(d_inode(dentry));
+	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(d_inode(dentry));
 	struct ceph_mon_client *monc = &fsc->client->monc;
 	struct ceph_statfs st;
 	int i, err;
@@ -112,7 +112,7 @@ static int ceph_statfs(struct dentry *dentry, struct kstatfs *buf)
 
 static int ceph_sync_fs(struct super_block *sb, int wait)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	if (!wait) {
 		dout("sync_fs (non-blocking)\n");
@@ -529,7 +529,7 @@ static int compare_mount_options(struct ceph_mount_options *new_fsopt,
  */
 static int ceph_show_options(struct seq_file *m, struct dentry *root)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(root->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(root->d_sb);
 	struct ceph_mount_options *fsopt = fsc->mount_options;
 	size_t pos;
 	int ret;
@@ -848,7 +848,7 @@ static void __ceph_umount_begin(struct ceph_fs_client *fsc)
  */
 static void ceph_umount_begin(struct super_block *sb)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	dout("ceph_umount_begin - starting forced umount\n");
 	if (!fsc)
@@ -1006,7 +1006,7 @@ static int ceph_compare_super(struct super_block *sb, struct fs_context *fc)
 	struct ceph_fs_client *new = fc->s_fs_info;
 	struct ceph_mount_options *fsopt = new->mount_options;
 	struct ceph_options *opt = new->client->options;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 
 	dout("ceph_compare_super %p\n", sb);
 
@@ -1099,9 +1099,9 @@ static int ceph_get_tree(struct fs_context *fc)
 		goto out;
 	}
 
-	if (ceph_sb_to_client(sb) != fsc) {
+	if (ceph_sb_to_fs_client(sb) != fsc) {
 		destroy_fs_client(fsc);
-		fsc = ceph_sb_to_client(sb);
+		fsc = ceph_sb_to_fs_client(sb);
 		dout("get_sb got existing client %p\n", fsc);
 	} else {
 		dout("get_sb using new client %p\n", fsc);
@@ -1152,7 +1152,7 @@ static int ceph_reconfigure_fc(struct fs_context *fc)
 {
 	struct ceph_parse_opts_ctx *pctx = fc->fs_private;
 	struct ceph_mount_options *fsopt = pctx->opts;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(fc->root->d_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(fc->root->d_sb);
 
 	if (fsopt->flags & CEPH_MOUNT_OPT_ASYNC_DIROPS)
 		ceph_set_mount_opt(fsc, ASYNC_DIROPS);
@@ -1223,7 +1223,7 @@ static int ceph_init_fs_context(struct fs_context *fc)
 
 static void ceph_kill_sb(struct super_block *s)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(s);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(s);
 
 	dout("kill_sb %p\n", s);
 
@@ -1261,7 +1261,7 @@ MODULE_ALIAS_FS("ceph");
 
 int ceph_force_reconnect(struct super_block *sb)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(sb);
 	int err = 0;
 
 	fsc->mount_state = CEPH_MOUNT_RECOVER;
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 8c9021d0f8374..026accea947cb 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -439,13 +439,13 @@ ceph_inode(const struct inode *inode)
 }
 
 static inline struct ceph_fs_client *
-ceph_inode_to_client(const struct inode *inode)
+ceph_inode_to_fs_client(const struct inode *inode)
 {
 	return (struct ceph_fs_client *)inode->i_sb->s_fs_info;
 }
 
 static inline struct ceph_fs_client *
-ceph_sb_to_client(const struct super_block *sb)
+ceph_sb_to_fs_client(const struct super_block *sb)
 {
 	return (struct ceph_fs_client *)sb->s_fs_info;
 }
@@ -453,7 +453,7 @@ ceph_sb_to_client(const struct super_block *sb)
 static inline struct ceph_mds_client *
 ceph_sb_to_mdsc(const struct super_block *sb)
 {
-	return (struct ceph_mds_client *)ceph_sb_to_client(sb)->mdsc;
+	return (struct ceph_mds_client *)ceph_sb_to_fs_client(sb)->mdsc;
 }
 
 static inline struct ceph_vino
@@ -509,7 +509,7 @@ static inline u64 ceph_snap(struct inode *inode)
  */
 static inline u64 ceph_present_ino(struct super_block *sb, u64 ino)
 {
-	if (unlikely(ceph_test_mount_opt(ceph_sb_to_client(sb), INO32)))
+	if (unlikely(ceph_test_mount_opt(ceph_sb_to_fs_client(sb), INO32)))
 		return ceph_ino_to_ino32(ino);
 	return ino;
 }
diff --git a/fs/ceph/xattr.c b/fs/ceph/xattr.c
index 0cec77cb674e5..60f6e7693f93d 100644
--- a/fs/ceph/xattr.c
+++ b/fs/ceph/xattr.c
@@ -57,7 +57,7 @@ static bool ceph_vxattrcb_layout_exists(struct ceph_inode_info *ci)
 static ssize_t ceph_vxattrcb_layout(struct ceph_inode_info *ci, char *val,
 				    size_t size)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	struct ceph_string *pool_ns;
 	s64 pool = ci->i_layout.pool_id;
@@ -161,7 +161,7 @@ static ssize_t ceph_vxattrcb_layout_pool(struct ceph_inode_info *ci,
 					 char *val, size_t size)
 {
 	ssize_t ret;
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
 	s64 pool = ci->i_layout.pool_id;
 	const char *pool_name;
@@ -313,7 +313,7 @@ static ssize_t ceph_vxattrcb_snap_btime(struct ceph_inode_info *ci, char *val,
 static ssize_t ceph_vxattrcb_cluster_fsid(struct ceph_inode_info *ci,
 					  char *val, size_t size)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 
 	return ceph_fmt_xattr(val, size, "%pU", &fsc->client->fsid);
 }
@@ -321,7 +321,7 @@ static ssize_t ceph_vxattrcb_cluster_fsid(struct ceph_inode_info *ci,
 static ssize_t ceph_vxattrcb_client_id(struct ceph_inode_info *ci,
 				       char *val, size_t size)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(ci->vfs_inode.i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(ci->vfs_inode.i_sb);
 
 	return ceph_fmt_xattr(val, size, "client%lld",
 			      ceph_client_gid(fsc->client));
@@ -1052,7 +1052,7 @@ ssize_t ceph_listxattr(struct dentry *dentry, char *names, size_t size)
 static int ceph_sync_setxattr(struct inode *inode, const char *name,
 			      const char *value, size_t size, int flags)
 {
-	struct ceph_fs_client *fsc = ceph_sb_to_client(inode->i_sb);
+	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(inode->i_sb);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -1122,7 +1122,7 @@ int __ceph_setxattr(struct inode *inode, const char *name,
 {
 	struct ceph_vxattr *vxattr;
 	struct ceph_inode_info *ci = ceph_inode(inode);
-	struct ceph_mds_client *mdsc = ceph_sb_to_client(inode->i_sb)->mdsc;
+	struct ceph_mds_client *mdsc = ceph_sb_to_fs_client(inode->i_sb)->mdsc;
 	struct ceph_cap_flush *prealloc_cf = NULL;
 	struct ceph_buffer *old_blob = NULL;
 	int issued;
-- 
2.53.0

