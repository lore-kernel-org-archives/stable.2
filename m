Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE203C1D44
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 11:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786187566; cv=none; b=nW3dCiI7DGBKW1dMhMheiMI4ZNJISkxw+SGaznbtuFXTRvs792NkUHdm4+kKs6vVpdGn7nBTqPy5kU7rMP+EnbNv6+vWodp3+b5CniSIK+G7cDQ+JhhFHccB8YlIQ8TOA24uJv4v7JO7CJx1wclAvG2Xy/5jz5Xx+EB6AQNwqZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786187566; c=relaxed/simple;
	bh=l9am9awVx/KUJQEF66fj4Vicg+/g/OPyfJEuPy14c6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uee3y3RnjouDWw08Zx+5/r5cbOrdoiGBWLaH++gAthzai5E/z45R1bYMtE8ayHncZk7wbMmYq2OBMObgF5/nvO0zVpeFR45MALoX5uCO+qMuxjKhxCy09WbJbTIPYyQ5oxKcIZl/4SFZZOIqoG6ka5oyiYDihYwJMm9G0OyBUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb2uMzfX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb2uMzfX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7481F00A3E;
	Sat,  8 Aug 2026 11:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786187564;
	bh=40Njq3NtypCwnyEzjluOdaaLkddUso9d4DuUhCjOlGY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kb2uMzfXcYD7v9eVyvVO+GSWApf+/EnYdRA59iB6daGoUhmGciip65ngptqaflgQL
	 eMRdS14BSiZCsYiP4WxFwxRNFwRKHJ0Ec3UvT8Xp7huvpcPL51CtyXHmsncIPxzTS0
	 IBNDqYIJ6/GUZ625p4HgyLTANo5dcGSE6PnIkDZRSvDS42FT23BY8rfdKMNSpwUxtv
	 P8T3eA7507A1161UmVP4iH7aXIEFKjIUva1zEu/475D9Dr1XVf+QwVD0CVwcEnxzty
	 FFmlP3F77cyE20pjwmmN5L+ePHEcazZIUA/HU8/B8/el2A6MZGsu1p+GXE26IgH9YK
	 rLZb1/knvUHKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>,
	Patrick Donnelly <pdonnell@redhat.com>,
	Milind Changire <mchangir@redhat.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] ceph: print cluster fsid and client global_id in all debug logs
Date: Sat,  8 Aug 2026 07:12:39 -0400
Message-ID: <20260808111240.93994-3-sashal@kernel.org>
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

[ Upstream commit 38d46409c4639a1d659ebfa70e27a8bed6b8ee1d ]

Multiple CephFS mounts on a host is increasingly common so
disambiguating messages like this is necessary and will make it easier
to debug issues.

At the same this will improve the debug logs to make them easier to
troubleshooting issues, such as print the ino# instead only printing
the memory addresses of the corresponding inodes and print the dentry
names instead of the corresponding memory addresses for the dentry,etc.

Link: https://tracker.ceph.com/issues/61590
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Stable-dep-of: 50958bb928ba ("ceph: fix hanging __ceph_get_caps() with stale mds_wanted")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/acl.c    | 6 ++++--
 fs/ceph/file.c   | 9 ++++++---
 fs/ceph/metric.c | 5 +++--
 fs/ceph/super.h  | 6 ++++++
 4 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/acl.c b/fs/ceph/acl.c
index f4fc8e0b847cc..c8373971d1e35 100644
--- a/fs/ceph/acl.c
+++ b/fs/ceph/acl.c
@@ -15,6 +15,7 @@
 #include <linux/slab.h>
 
 #include "super.h"
+#include "mds_client.h"
 
 static inline void ceph_set_cached_acl(struct inode *inode,
 					int type, struct posix_acl *acl)
@@ -31,6 +32,7 @@ static inline void ceph_set_cached_acl(struct inode *inode,
 
 struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 {
+	struct ceph_client *cl = ceph_inode_to_client(inode);
 	int size;
 	unsigned int retry_cnt = 0;
 	const char *name;
@@ -72,8 +74,8 @@ struct posix_acl *ceph_get_acl(struct inode *inode, int type, bool rcu)
 	} else if (size == -ENODATA || size == 0) {
 		acl = NULL;
 	} else {
-		pr_err_ratelimited("get acl %llx.%llx failed, err=%d\n",
-				   ceph_vinop(inode), size);
+		pr_err_ratelimited_client(cl, "%llx.%llx failed, err=%d\n",
+					  ceph_vinop(inode), size);
 		acl = ERR_PTR(-EIO);
 	}
 
diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index a8358485263a4..c47c67ca9ce6c 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -282,6 +282,7 @@ static int ceph_init_file(struct inode *inode, struct file *file, int fmode)
 int ceph_renew_caps(struct inode *inode, int fmode)
 {
 	struct ceph_mds_client *mdsc = ceph_sb_to_mdsc(inode->i_sb);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_mds_request *req;
 	int err, flags, wanted;
@@ -293,8 +294,9 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
 		int issued = __ceph_caps_issued(ci, NULL);
 		spin_unlock(&ci->i_ceph_lock);
-		dout("renew caps %p want %s issued %s updating mds_wanted\n",
-		     inode, ceph_cap_string(wanted), ceph_cap_string(issued));
+		doutc(cl, "%p %llx.%llx want %s issued %s updating mds_wanted\n",
+		      inode, ceph_vinop(inode), ceph_cap_string(wanted),
+		      ceph_cap_string(issued));
 		ceph_check_caps(ci, 0, NULL);
 		return 0;
 	}
@@ -325,7 +327,8 @@ int ceph_renew_caps(struct inode *inode, int fmode)
 	err = ceph_mdsc_do_request(mdsc, NULL, req);
 	ceph_mdsc_put_request(req);
 out:
-	dout("renew caps %p open result=%d\n", inode, err);
+	doutc(cl, "%p %llx.%llx open result=%d\n", inode, ceph_vinop(inode),
+	      err);
 	return err < 0 ? err : 0;
 }
 
diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
index d21ff43543322..7dff3967d3af6 100644
--- a/fs/ceph/metric.c
+++ b/fs/ceph/metric.c
@@ -25,6 +25,7 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 	struct ceph_client_metric *m = &mdsc->metric;
 	u64 nr_caps = atomic64_read(&m->total_caps);
 	u32 header_len = sizeof(struct ceph_metric_header);
+	struct ceph_client *cl = mdsc->fsc->client;
 	struct ceph_msg *msg;
 	struct timespec64 ts;
 	s64 sum;
@@ -38,8 +39,8 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
 
 	msg = ceph_msg_new(CEPH_MSG_CLIENT_METRICS, len, GFP_NOFS, true);
 	if (!msg) {
-		pr_err("send metrics to mds%d, failed to allocate message\n",
-		       s->s_mds);
+		pr_err_client(cl, "to mds%d, failed to allocate message\n",
+			      s->s_mds);
 		return false;
 	}
 
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 026accea947cb..5e07715b895d1 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -456,6 +456,12 @@ ceph_sb_to_mdsc(const struct super_block *sb)
 	return (struct ceph_mds_client *)ceph_sb_to_fs_client(sb)->mdsc;
 }
 
+static inline struct ceph_client *
+ceph_inode_to_client(const struct inode *inode)
+{
+	return (struct ceph_client *)ceph_inode_to_fs_client(inode)->client;
+}
+
 static inline struct ceph_vino
 ceph_vino(const struct inode *inode)
 {
-- 
2.53.0

