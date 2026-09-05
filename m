Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1653644A0
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638739; cv=none; b=pQYxEArkygFRxqIsR9tAsp1fiXaxPNDPpJfPy+fS6ZZiAuj7ijt0HzreWt0rD+PnbndY8Wjk6OEkQRVNf5Obx7fEM2luTZkwmBCwY/Ed0cbVaBGYTC7KxFJF6HzD78nYqAPHPJGPeQUxuMocZ1leztsaL7b7j8OYkdAf0n+Ao34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638739; c=relaxed/simple;
	bh=2UYTiB5VqZ6V8XqmINIjstFF11zNht00FhvAxAYh1eM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5+0Z0iGYSn5/a8oaACRigXSqknbxgOJEqHSvnZV88p1/n6DgwrCZBaN4Uc4XTPbfVcf6QGvY5ePilkE6kdhT5j2C6ExlESWmfbUFJnndWHZvu6yb/atJ863NLt9+C2xuMe42XHuPbOmk0AlI7xHl8lEV89u96m+UlIsS3Kdkj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y+jns3iB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+jns3iB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD281F00A3A;
	Sat,  5 Sep 2026 20:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638737;
	bh=vcLQpPYs41x+6Z8n5CD/LhMaWVZ1eIAUqm/zukXV/8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y+jns3iBt3+2kPdWE8sMjBX6fxiuhSFhbyWcHMa9poC4y2byDWa4vnO/jMlI0i0ax
	 /kaQt7i4iqwNRhapP75Ix7ylOM6kx4D+JzQcPiXf5PVMecp9FmEkc73fuLJUAFuc50
	 uPrukT9OpGfKZomp5y3vi+H0UlEtUb4Zyaijc+usPtmYqXuovG6mXDdi9FLTTqpUqQ
	 zgcvqYyZ+B7dDQPYcNTiaYPE5BYns6PItP8WZDhgL0Gb//iS268Un5xDndmlA1YQM0
	 hRA0b24PSZenYhBi8m7tFzG17ubIS+uKTUgc1N4pQZjtN1PV3YthI5aAmX/qtIDHxJ
	 vlCZ+XNH2ARZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] NFSD: net ref data still needs to be freed even if net hasn't startup
Date: Sat,  5 Sep 2026 16:05:34 -0400
Message-ID: <20260905200535.607640-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090327-magnesium-foyer-2250@gregkh>
References: <2026090327-magnesium-foyer-2250@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Adam Davis <eadavis@qq.com>

[ Upstream commit 0b88bfa42e5468baff71909c2f324a495318532b ]

When the NFSD instance doesn't to startup, the net ref data memory is
not properly reclaimed, which triggers the memory leak issue reported
by syzbot [1].

To avoid the problem reported in [1], the net ref data memory reclamation
action is moved outside of nfsd_net_up when the net is shutdown.

[1]
unreferenced object 0xffff88812a39dfc0 (size 64):
  backtrace (crc a2262fc6):
    percpu_ref_init+0x94/0x1e0 lib/percpu-refcount.c:76
    nfsd_create_serv+0xbe/0x260 fs/nfsd/nfssvc.c:605
    nfsd_nl_listener_set_doit+0x62/0xb00 fs/nfsd/nfsctl.c:1882
    genl_family_rcv_msg_doit+0x11e/0x190 net/netlink/genetlink.c:1115
    genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
    genl_rcv_msg+0x2fd/0x440 net/netlink/genetlink.c:1210

BUG: memory leak

Reported-by: syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=6ee3b889bdeada0a6226
Fixes: 39972494e318 ("nfsd: update percpu_ref to manage references on nfsd_net")
Cc: stable@vger.kernel.org
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 9b57793863f6 ("nfsd: dedup nfs4_client_to_reclaim inserts")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/Kconfig       |   5 +-
 fs/nfsd/netns.h       |  20 ++++---
 fs/nfsd/nfs4proc.c    |   2 +-
 fs/nfsd/nfs4recover.c | 129 +++++++++++++++++++++---------------------
 fs/nfsd/nfs4state.c   |  41 ++++++++------
 fs/nfsd/nfsctl.c      |   2 +-
 fs/nfsd/nfssvc.c      |  22 +++----
 7 files changed, 117 insertions(+), 104 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 4e7d8d926b908..8d9f663619e92 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -77,8 +77,8 @@ config NFSD_V4
 	select FS_POSIX_ACL
 	select SUNRPC_GSS
 	select CRYPTO
+	select CRYPTO_LIB_SHA256
 	select CRYPTO_MD5
-	select CRYPTO_SHA256
 	select GRACE_PERIOD
 	select NFS_V4_2_SSC_HELPER if NFS_V4_2
 	help
@@ -161,3 +161,6 @@ config NFSD_V4_SECURITY_LABEL
 
 	If you do not wish to enable fine-grained security labels SELinux or
 	Smack policies on NFSv4 files, say N.
+
+config NFSD_LEGACY_CLIENT_TRACKING
+	def_bool NFSD_V4
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index be0c8f1ce4e3e..d6630921b5539 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -25,6 +25,16 @@
 struct cld_net;
 struct nfsd4_client_tracking_ops;
 
+enum nfsd_net_flag {
+	NFSD_NET_GRACE_ENDED,
+	NFSD_NET_GRACE_END_FORCED,
+	NFSD_NET_IN_GRACE,
+	NFSD_NET_SOMEBODY_RECLAIMED,
+	NFSD_NET_TRACK_RECLAIM_COMPLETES,
+	NFSD_NET_UP,
+	NFSD_NET_LOCKD_UP,
+};
+
 enum {
 	/* cache misses due only to checksum comparison failures */
 	NFSD_STATS_PAYLOAD_MISSES,
@@ -63,8 +73,7 @@ struct nfsd_net {
 	struct cache_detail *nametoid_cache;
 
 	struct lock_manager nfsd4_manager;
-	bool grace_ended;
-	bool grace_end_forced;
+	unsigned long flags;
 	bool client_tracking_active;
 	time64_t boot_time;
 
@@ -82,6 +91,7 @@ struct nfsd_net {
 	 */
 	struct list_head *reclaim_str_hashtbl;
 	int reclaim_str_hashtbl_size;
+	struct rw_semaphore reclaim_str_hashtbl_lock;
 	struct list_head *conf_id_hashtbl;
 	struct rb_root conf_name_tree;
 	struct list_head *unconf_id_hashtbl;
@@ -112,19 +122,13 @@ struct nfsd_net {
 	spinlock_t blocked_locks_lock;
 
 	struct file *rec_file;
-	bool in_grace;
 	const struct nfsd4_client_tracking_ops *client_tracking_ops;
 
 	time64_t nfsd4_lease;
 	time64_t nfsd4_grace;
-	bool somebody_reclaimed;
 
-	bool track_reclaim_completes;
 	atomic_t nr_reclaim_complete;
 
-	bool nfsd_net_up;
-	bool lockd_up;
-
 	seqlock_t writeverf_lock;
 	unsigned char writeverf[8];
 
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7a85817fa5bfe..bc34ce0836c4b 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -593,7 +593,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		pr_warn("nfsd4_process_open2 failed to open newly-created file: status=%u\n",
 			be32_to_cpu(status));
 	if (reclaim && !status)
-		nn->somebody_reclaimed = true;
+		set_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 out:
 	if (open->op_filp) {
 		fput(open->op_filp);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index d13e512149eed..a8b854881bca5 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -33,6 +33,7 @@
 */
 
 #include <crypto/hash.h>
+#include <crypto/sha2.h>
 #include <linux/file.h>
 #include <linux/slab.h>
 #include <linux/namei.h>
@@ -228,7 +229,7 @@ nfsd4_create_clid_dir(struct nfs4_client *clp)
 out_unlock:
 	inode_unlock(d_inode(dir));
 	if (status == 0) {
-		if (nn->in_grace)
+		if (test_bit(NFSD_NET_IN_GRACE, &nn->flags))
 			__nfsd4_create_reclaim_record_grace(clp, dname, nn);
 		vfs_fsync(nn->rec_file, 0);
 	} else {
@@ -388,7 +389,7 @@ nfsd4_remove_clid_dir(struct nfs4_client *clp)
 	nfs4_reset_creds(original_cred);
 	if (status == 0) {
 		vfs_fsync(nn->rec_file, 0);
-		if (nn->in_grace)
+		if (test_bit(NFSD_NET_IN_GRACE, &nn->flags))
 			__nfsd4_remove_reclaim_record_grace(dname,
 					HEXDIR_LEN, nn);
 	}
@@ -446,7 +447,7 @@ nfsd4_recdir_purge_old(struct nfsd_net *nn)
 {
 	int status;
 
-	nn->in_grace = false;
+	clear_bit(NFSD_NET_IN_GRACE, &nn->flags);
 	if (!nn->rec_file)
 		return;
 	status = mnt_want_write_file(nn->rec_file);
@@ -528,7 +529,7 @@ nfsd4_init_recdir(struct net *net)
 
 	nfs4_reset_creds(original_cred);
 	if (!status)
-		nn->in_grace = true;
+		set_bit(NFSD_NET_IN_GRACE, &nn->flags);
 	return status;
 }
 
@@ -558,6 +559,7 @@ nfs4_legacy_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
+	init_rwsem(&nn->reclaim_str_hashtbl_lock);
 
 	return 0;
 }
@@ -710,8 +712,9 @@ struct cld_net {
 	spinlock_t		 cn_lock;
 	struct list_head	 cn_list;
 	unsigned int		 cn_xid;
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	bool			 cn_has_legacy;
-	struct crypto_shash	*cn_tfm;
+#endif
 };
 
 struct cld_upcall {
@@ -774,7 +777,6 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 	char *namecopy __free(kfree) = NULL;
 	char *princhashcopy __free(kfree) = NULL;
 	uint16_t namelen;
-	struct cld_net *cn = nn->cld_net;
 
 	if (get_user(cmd, &cmsg->cm_cmd)) {
 		dprintk("%s: error when copying cmd from userspace", __func__);
@@ -824,8 +826,10 @@ __cld_pipe_inprogress_downcall(const struct cld_msg_v2 __user *cmsg,
 			name.data = namecopy;
 			name.len = namelen;
 		}
-#ifdef CONFIG_NFSD_V4
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 		if (name.len > 5 && memcmp(name.data, "hash:", 5) == 0) {
+			struct cld_net *cn = nn->cld_net;
+
 			name.len = name.len - 5;
 			name.data = name.data + 5;
 			cn->cn_has_legacy = true;
@@ -1000,7 +1004,9 @@ __nfsd4_init_cld_pipe(struct net *net)
 	}
 
 	cn->cn_pipe->dentry = dentry;
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	cn->cn_has_legacy = false;
+#endif
 	nn->cld_net = cn;
 	return 0;
 
@@ -1032,8 +1038,6 @@ nfsd4_remove_cld_pipe(struct net *net)
 
 	nfsd4_cld_unregister_net(net, cn->cn_pipe);
 	rpc_destroy_pipe_data(cn->cn_pipe);
-	if (cn->cn_tfm)
-		crypto_free_shash(cn->cn_tfm);
 	kfree(nn->cld_net);
 	nn->cld_net = NULL;
 }
@@ -1127,8 +1131,6 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
 	struct cld_msg_v2 *cmsg;
-	struct crypto_shash *tfm = cn->cn_tfm;
-	struct xdr_netobj cksum;
 	char *principal = NULL;
 
 	/* Don't upcall if it's already stored */
@@ -1151,22 +1153,9 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 	else if (clp->cl_cred.cr_principal)
 		principal = clp->cl_cred.cr_principal;
 	if (principal) {
-		cksum.len = crypto_shash_digestsize(tfm);
-		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
-		if (cksum.data == NULL) {
-			ret = -ENOMEM;
-			goto out;
-		}
-		ret = crypto_shash_tfm_digest(tfm, principal, strlen(principal),
-					      cksum.data);
-		if (ret) {
-			kfree(cksum.data);
-			goto out;
-		}
-		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = cksum.len;
-		memcpy(cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data,
-		       cksum.data, cksum.len);
-		kfree(cksum.data);
+		sha256(principal, strlen(principal),
+		       cmsg->cm_u.cm_clntinfo.cc_princhash.cp_data);
+		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = SHA256_DIGEST_SIZE;
 	} else
 		cmsg->cm_u.cm_clntinfo.cc_princhash.cp_len = 0;
 
@@ -1175,8 +1164,6 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 		ret = cmsg->cm_status;
 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
 	}
-
-out:
 	free_cld_upcall(cup);
 out_err:
 	if (ret)
@@ -1270,31 +1257,39 @@ nfsd4_cld_check_v0(struct nfs4_client *clp)
 static int
 nfsd4_cld_check(struct nfs4_client *clp)
 {
-	struct nfs4_client_reclaim *crp;
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	struct cld_net *cn = nn->cld_net;
-	int status;
-	char dname[HEXDIR_LEN];
-	struct xdr_netobj name;
+#endif
+	struct nfs4_client_reclaim *crp;
 
 	/* did we already find that this client is stable? */
 	if (test_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags))
 		return 0;
 
 	/* look for it in the reclaim hashtable otherwise */
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
 	if (crp)
 		goto found;
 
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	if (cn->cn_has_legacy) {
+		struct xdr_netobj name;
+		char dname[HEXDIR_LEN];
+		int status;
+
 		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
-		if (status)
+		if (status) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
+		}
 
 		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
 		if (!name.data) {
 			dprintk("%s: failed to allocate memory for name.data!\n",
 				__func__);
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
 		name.len = HEXDIR_LEN;
@@ -1304,23 +1299,24 @@ nfsd4_cld_check(struct nfs4_client *clp)
 			goto found;
 
 	}
+#endif
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return -ENOENT;
 found:
 	crp->cr_clp = clp;
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return 0;
 }
 
 static int
 nfsd4_cld_check_v2(struct nfs4_client *clp)
 {
-	struct nfs4_client_reclaim *crp;
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	struct cld_net *cn = nn->cld_net;
-	int status;
-	char dname[HEXDIR_LEN];
-	struct xdr_netobj name;
-	struct crypto_shash *tfm = cn->cn_tfm;
-	struct xdr_netobj cksum;
+#endif
+	struct nfs4_client_reclaim *crp;
+	unsigned int princhashlen;
 	char *principal = NULL;
 
 	/* did we already find that this client is stable? */
@@ -1328,19 +1324,28 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 		return 0;
 
 	/* look for it in the reclaim hashtable otherwise */
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
 	if (crp)
 		goto found;
 
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	if (cn->cn_has_legacy) {
+		struct xdr_netobj name;
+		char dname[HEXDIR_LEN];
+		int status;
+
 		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
-		if (status)
+		if (status) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
+		}
 
 		name.data = kmemdup(dname, HEXDIR_LEN, GFP_KERNEL);
 		if (!name.data) {
 			dprintk("%s: failed to allocate memory for name.data\n",
 					__func__);
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
 		name.len = HEXDIR_LEN;
@@ -1350,33 +1355,32 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 			goto found;
 
 	}
+#endif
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return -ENOENT;
 found:
-	if (crp->cr_princhash.len) {
+	princhashlen = crp->cr_princhash.len;
+	if (princhashlen) {
+		u8 digest[SHA256_DIGEST_SIZE];
+		u8 *pdata;
+
 		if (clp->cl_cred.cr_raw_principal)
 			principal = clp->cl_cred.cr_raw_principal;
 		else if (clp->cl_cred.cr_principal)
 			principal = clp->cl_cred.cr_principal;
-		if (principal == NULL)
-			return -ENOENT;
-		cksum.len = crypto_shash_digestsize(tfm);
-		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
-		if (cksum.data == NULL)
-			return -ENOENT;
-		status = crypto_shash_tfm_digest(tfm, principal,
-						 strlen(principal), cksum.data);
-		if (status) {
-			kfree(cksum.data);
+		if (principal == NULL) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
-		if (memcmp(crp->cr_princhash.data, cksum.data,
-				crp->cr_princhash.len)) {
-			kfree(cksum.data);
+		sha256(principal, strlen(principal), digest);
+		pdata = crp->cr_princhash.data;
+		if (memcmp(pdata, digest, princhashlen)) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
-		kfree(cksum.data);
 	}
 	crp->cr_clp = clp;
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return 0;
 }
 
@@ -1476,7 +1480,8 @@ nfs4_cld_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
-	nn->track_reclaim_completes = true;
+	init_rwsem(&nn->reclaim_str_hashtbl_lock);
+	set_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags);
 	atomic_set(&nn->nr_reclaim_complete, 0);
 
 	return 0;
@@ -1487,7 +1492,7 @@ nfs4_cld_state_shutdown(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nn->track_reclaim_completes = false;
+	clear_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags);
 	kfree(nn->reclaim_str_hashtbl);
 }
 
@@ -1554,7 +1559,6 @@ nfsd4_cld_tracking_init(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	bool running;
 	int retries = 10;
-	struct crypto_shash *tfm;
 
 	status = nfs4_cld_state_init(net);
 	if (status)
@@ -1579,13 +1583,6 @@ nfsd4_cld_tracking_init(struct net *net)
 		status = -ETIMEDOUT;
 		goto err_remove;
 	}
-	tfm = crypto_alloc_shash("sha256", 0, 0);
-	if (IS_ERR(tfm)) {
-		status = PTR_ERR(tfm);
-		goto err_remove;
-	}
-	nn->cld_net->cn_tfm = tfm;
-
 	status = nfsd4_cld_get_version(nn);
 	if (status == -EOPNOTSUPP)
 		pr_warn("NFSD: nfsdcld GetVersion upcall failed. Please upgrade nfsdcld.\n");
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index e6c0b1520973e..65dd12fdc2e3b 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2296,7 +2296,7 @@ static void inc_reclaim_complete(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	if (!nn->track_reclaim_completes)
+	if (!test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags))
 		return;
 	if (!nfsd4_find_reclaim_client(clp->cl_name, nn))
 		return;
@@ -4453,8 +4453,6 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
 
 	nn->nfsd4_lease = 90;	/* default lease time */
 	nn->nfsd4_grace = 90;
-	nn->somebody_reclaimed = false;
-	nn->track_reclaim_completes = false;
 	nn->clverifier_counter = prandom_u32();
 	nn->clientid_base = prandom_u32();
 	nn->clientid_counter = nn->clientid_base + 1;
@@ -5886,12 +5884,21 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 static void
 nfsd4_end_grace(struct nfsd_net *nn)
 {
-	/* do nothing if grace period already ended */
-	if (nn->grace_ended)
+	/*
+	 * nfsd4_end_grace() can be entered concurrently from the
+	 * laundromat workqueue and from an nfsd compound thread
+	 * handling RECLAIM_COMPLETE.  Without serialization, both
+	 * callers can observe NFSD_NET_GRACE_ENDED clear and proceed
+	 * into nfsd4_record_grace_done().  For tracking ops whose
+	 * grace_done drains reclaim_str_hashtbl, that results in
+	 * list corruption and a double free of every
+	 * nfs4_client_reclaim entry.  Use an atomic test-and-set so
+	 * exactly one caller proceeds.
+	 */
+	if (test_and_set_bit(NFSD_NET_GRACE_ENDED, &nn->flags))
 		return;
 
 	trace_nfsd_grace_complete(nn);
-	nn->grace_ended = true;
 	/*
 	 * If the server goes down again right now, an NFSv4
 	 * client will still be allowed to reclaim after it comes back up,
@@ -5933,11 +5940,12 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
 	if (!nn->client_tracking_ops)
 		return false;
 	spin_lock(&nn->client_lock);
-	if (nn->grace_ended || !nn->client_tracking_active) {
+	if (test_bit(NFSD_NET_GRACE_ENDED, &nn->flags) ||
+	    !nn->client_tracking_active) {
 		spin_unlock(&nn->client_lock);
 		return false;
 	}
-	WRITE_ONCE(nn->grace_end_forced, true);
+	set_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags);
 	mod_delayed_work(laundry_wq, &nn->laundromat_work, 0);
 	spin_unlock(&nn->client_lock);
 	return true;
@@ -5952,15 +5960,15 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 	time64_t double_grace_period_end = nn->boot_time +
 					   2 * nn->nfsd4_lease;
 
-	if (READ_ONCE(nn->grace_end_forced))
+	if (test_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags))
 		return false;
-	if (nn->track_reclaim_completes &&
+	if (test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags) &&
 			atomic_read(&nn->nr_reclaim_complete) ==
 			nn->reclaim_str_hashtbl_size)
 		return false;
-	if (!nn->somebody_reclaimed)
+	if (!test_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags))
 		return false;
-	nn->somebody_reclaimed = false;
+	clear_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 	/*
 	 * If we've given them *two* lease times to reclaim, and they're
 	 * still not done, give up:
@@ -7666,7 +7674,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
 		status = 0;
 		if (lock->lk_reclaim)
-			nn->somebody_reclaimed = true;
+			set_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 		break;
 	case FILE_LOCK_DEFERRED:
 		kref_put(&nbl->nbl_kref, free_nbl);
@@ -8176,8 +8184,8 @@ static int nfs4_state_create_net(struct net *net)
 	nn->conf_name_tree = RB_ROOT;
 	nn->unconf_name_tree = RB_ROOT;
 	nn->boot_time = ktime_get_real_seconds();
-	nn->grace_ended = false;
-	nn->grace_end_forced = false;
+	clear_bit(NFSD_NET_GRACE_ENDED, &nn->flags);
+	clear_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags);
 	nn->client_tracking_active = false;
 	nn->nfsd4_manager.block_opens = true;
 	INIT_LIST_HEAD(&nn->nfsd4_manager.list);
@@ -8259,7 +8267,8 @@ nfs4_state_start_net(struct net *net)
 	spin_lock(&nn->client_lock);
 	nn->client_tracking_active = true;
 	spin_unlock(&nn->client_lock);
-	if (nn->track_reclaim_completes && nn->reclaim_str_hashtbl_size == 0)
+	if (test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags) &&
+	    nn->reclaim_str_hashtbl_size == 0)
 		goto skip_grace;
 	printk(KERN_INFO "NFSD: starting %lld-second grace period (net %x)\n",
 	       nn->nfsd4_grace, net->ns.inum);
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index cc0dea883fbdb..ae5b569278d37 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1126,7 +1126,7 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 	}
 
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%c\n",
-			 nn->grace_ended ? 'Y' : 'N');
+			 test_bit(NFSD_NET_GRACE_ENDED, &nn->flags) ? 'Y' : 'N');
 }
 
 #endif
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index ff27e2abf18f9..466d8120faa99 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -402,7 +402,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int ret;
 
-	if (nn->nfsd_net_up)
+	if (test_bit(NFSD_NET_UP, &nn->flags))
 		return 0;
 
 	ret = nfsd_startup_generic();
@@ -412,11 +412,11 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	if (ret)
 		goto out_socks;
 
-	if (nfsd_needs_lockd(nn) && !nn->lockd_up) {
+	if (nfsd_needs_lockd(nn) && !test_bit(NFSD_NET_LOCKD_UP, &nn->flags)) {
 		ret = lockd_up(net, cred);
 		if (ret)
 			goto out_socks;
-		nn->lockd_up = true;
+		set_bit(NFSD_NET_LOCKD_UP, &nn->flags);
 	}
 
 	ret = nfsd_file_cache_start_net(net);
@@ -434,7 +434,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	if (ret)
 		goto out_reply_cache;
 
-	nn->nfsd_net_up = true;
+	set_bit(NFSD_NET_UP, &nn->flags);
 	return 0;
 
 out_reply_cache:
@@ -442,9 +442,9 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 out_filecache:
 	nfsd_file_cache_shutdown_net(net);
 out_lockd:
-	if (nn->lockd_up) {
+	if (test_bit(NFSD_NET_LOCKD_UP, &nn->flags)) {
 		lockd_down(net);
-		nn->lockd_up = false;
+		clear_bit(NFSD_NET_LOCKD_UP, &nn->flags);
 	}
 out_socks:
 	nfsd_shutdown_generic();
@@ -458,11 +458,11 @@ static void nfsd_shutdown_net(struct net *net)
 	nfs4_state_shutdown_net(net);
 	nfsd_reply_cache_shutdown(nn);
 	nfsd_file_cache_shutdown_net(net);
-	if (nn->lockd_up) {
+	if (test_bit(NFSD_NET_LOCKD_UP, &nn->flags)) {
 		lockd_down(net);
-		nn->lockd_up = false;
+		clear_bit(NFSD_NET_LOCKD_UP, &nn->flags);
 	}
-	nn->nfsd_net_up = false;
+	clear_bit(NFSD_NET_UP, &nn->flags);
 	nfsd_shutdown_generic();
 }
 
@@ -558,7 +558,7 @@ void nfsd_last_thread(struct net *net)
 	 * other initialization has been done except the rpcb information.
 	 */
 	svc_rpcb_cleanup(serv, net);
-	if (!nn->nfsd_net_up)
+	if (!test_bit(NFSD_NET_UP, &nn->flags))
 		return;
 
 	nfsd_shutdown_net(net);
@@ -799,7 +799,7 @@ nfsd_svc(int nrservs, struct net *net, const struct cred *cred)
 	if (error)
 		goto out;
 
-	nfsd_up_before = nn->nfsd_net_up;
+	nfsd_up_before = test_bit(NFSD_NET_UP, &nn->flags);
 	serv = nn->nfsd_serv;
 
 	error = nfsd_startup_net(net, cred);
-- 
2.53.0

