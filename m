Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBEC4A0910
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788619305; cv=none; b=aDkc4NjyjQRdJdDIbqs4+nzeW1+wshck9uBjwSs7rH0DEGItnMrL/i9Q3SfORk+Ozhx1RaErxWg6+EgDiKv7lpL5rv7f5JJBEsZr1/b3anxE3X7E3K6ReYL2TsNl6oAS0SDIqeyzsgso7+z+b+3+/UL4K+p7dIHan+71KgS6Qjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788619305; c=relaxed/simple;
	bh=DegoajcpyMQckXOSFKUDGnbMXPh79QgxJG8OR3/Fdc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teoEe06gdsEdt0ZQbKEAXPn/h8YIx6M85JuPOGs+DcJ4MxISWU+IPxNnZRkXe0l/avUXnF8TgSeHpcqeWyCp7lzPOChdlZdT7mrBAgGFAkfD9gHd9L3ilMKkou7GfmsHQDmGZOgveVPta4wis+ub7O67XXaxN0Fa19kZVVSedhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUejX4ml; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUejX4ml"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F20FA1F00A3D;
	Sat,  5 Sep 2026 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788619287;
	bh=+tUYuKDU+0Ajtz1W1L1OtJ0uKm7Tj5pQ0o5ZaMjAMTM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fUejX4mlwSwuOHI/yGeyQ0GlJRabe9jDJfm/XcRMrXjoGLmEZeEhNUkM8fqxv7WNo
	 yYSPqby+1Y1/Ex47poLn9xKmkE+DMumyFgz39C/t96rOuzWRjV8k3nDtFcVl7k7ioU
	 P5aE/9SzXfq3gi/HzdvhFENq582dhHVW1rs2pBuaYhPLGRk3IlwLUScjs6EBdHYOew
	 t7cbUAsrZx2+k41jdY+Dt1/065SsLFGSHWRwZnf0ChfwJJtsaSvZOLgJdf5y4YyKQy
	 2JxWkCUjjF0Do/ju80BEBA2srTyyaD5p4P5G8nBJ1dl3IPiV+t0W+BF/ppkHCGfs9T
	 gXO+TIA6h4SxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>,
	syzbot+6ee3b889bdeada0a6226@syzkaller.appspotmail.com,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] NFSD: net ref data still needs to be freed even if net hasn't startup
Date: Sat,  5 Sep 2026 10:41:24 -0400
Message-ID: <20260905144125.251876-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090326-skeptic-ribbon-0a0b@gregkh>
References: <2026090326-skeptic-ribbon-0a0b@gregkh>
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
 fs/nfsd/Kconfig       |  2 +-
 fs/nfsd/netns.h       | 19 +++++----
 fs/nfsd/nfs4proc.c    |  2 +-
 fs/nfsd/nfs4recover.c | 94 ++++++++++++++++---------------------------
 fs/nfsd/nfs4state.c   | 41 +++++++++++--------
 fs/nfsd/nfsctl.c      |  2 +-
 fs/nfsd/nfssvc.c      | 20 ++++-----
 7 files changed, 83 insertions(+), 97 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 75a3e5407a87d..6a63131e5cacb 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -77,8 +77,8 @@ config NFSD_V4
 	select FS_POSIX_ACL
 	select RPCSEC_GSS_KRB5
 	select CRYPTO
+	select CRYPTO_LIB_SHA256
 	select CRYPTO_MD5
-	select CRYPTO_SHA256
 	select GRACE_PERIOD
 	select NFS_V4_2_SSC_HELPER if NFS_V4_2
 	help
diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 0ecc5527a8f1a..a90e553ff7673 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -26,6 +26,16 @@
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
@@ -64,8 +74,7 @@ struct nfsd_net {
 	struct cache_detail *nametoid_cache;
 
 	struct lock_manager nfsd4_manager;
-	bool grace_ended;
-	bool grace_end_forced;
+	unsigned long flags;
 	bool client_tracking_active;
 	time64_t boot_time;
 
@@ -113,19 +122,13 @@ struct nfsd_net {
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
index 5767080362e85..2e9b512cd7ac1 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -626,7 +626,7 @@ nfsd4_open(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		pr_warn("nfsd4_process_open2 failed to open newly-created file: status=%u\n",
 			be32_to_cpu(status));
 	if (reclaim && !status)
-		nn->somebody_reclaimed = true;
+		set_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 out:
 	if (open->op_filp) {
 		fput(open->op_filp);
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index f4060d0cec8a5..17fccddb6af3c 100644
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
 
@@ -711,7 +712,6 @@ struct cld_net {
 	struct list_head	 cn_list;
 	unsigned int		 cn_xid;
 	bool			 cn_has_legacy;
-	struct crypto_shash	*cn_tfm;
 };
 
 struct cld_upcall {
@@ -1032,8 +1032,6 @@ nfsd4_remove_cld_pipe(struct net *net)
 
 	nfsd4_cld_unregister_net(net, cn->cn_pipe);
 	rpc_destroy_pipe_data(cn->cn_pipe);
-	if (cn->cn_tfm)
-		crypto_free_shash(cn->cn_tfm);
 	kfree(nn->cld_net);
 	nn->cld_net = NULL;
 }
@@ -1127,8 +1125,6 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 	struct cld_net *cn = nn->cld_net;
 	struct cld_msg_v2 *cmsg;
-	struct crypto_shash *tfm = cn->cn_tfm;
-	struct xdr_netobj cksum;
 	char *principal = NULL;
 
 	/* Don't upcall if it's already stored */
@@ -1151,22 +1147,9 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
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
 
@@ -1176,7 +1159,6 @@ nfsd4_cld_create_v2(struct nfs4_client *clp)
 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
 	}
 
-out:
 	free_cld_upcall(cup);
 out_err:
 	if (ret)
@@ -1270,12 +1252,11 @@ nfsd4_cld_check_v0(struct nfs4_client *clp)
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
@@ -1286,7 +1267,13 @@ nfsd4_cld_check(struct nfs4_client *clp)
 	if (crp)
 		goto found;
 
+
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	if (cn->cn_has_legacy) {
+		struct xdr_netobj name;
+		char dname[HEXDIR_LEN];
+		int status;
+
 		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
 		if (status)
 			return -ENOENT;
@@ -1304,6 +1291,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
 			goto found;
 
 	}
+#endif
 	return -ENOENT;
 found:
 	crp->cr_clp = clp;
@@ -1313,14 +1301,11 @@ nfsd4_cld_check(struct nfs4_client *clp)
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
 	char *principal = NULL;
 
 	/* did we already find that this client is stable? */
@@ -1332,7 +1317,12 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 	if (crp)
 		goto found;
 
+#ifdef CONFIG_NFSD_LEGACY_CLIENT_TRACKING
 	if (cn->cn_has_legacy) {
+		struct xdr_netobj name;
+		char dname[HEXDIR_LEN];
+		int status;
+
 		status = nfs4_make_rec_clidname(dname, &clp->cl_name);
 		if (status)
 			return -ENOENT;
@@ -1350,31 +1340,22 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 			goto found;
 
 	}
+#endif
 	return -ENOENT;
 found:
 	if (crp->cr_princhash.len) {
+		u8 digest[SHA256_DIGEST_SIZE];
+
 		if (clp->cl_cred.cr_raw_principal)
 			principal = clp->cl_cred.cr_raw_principal;
 		else if (clp->cl_cred.cr_principal)
 			principal = clp->cl_cred.cr_principal;
 		if (principal == NULL)
 			return -ENOENT;
-		cksum.len = crypto_shash_digestsize(tfm);
-		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
-		if (cksum.data == NULL)
-			return -ENOENT;
-		status = crypto_shash_tfm_digest(tfm, principal,
-						 strlen(principal), cksum.data);
-		if (status) {
-			kfree(cksum.data);
+		sha256(principal, strlen(principal), digest);
+		if (memcmp(crp->cr_princhash.data, digest,
+				crp->cr_princhash.len))
 			return -ENOENT;
-		}
-		if (memcmp(crp->cr_princhash.data, cksum.data,
-				crp->cr_princhash.len)) {
-			kfree(cksum.data);
-			return -ENOENT;
-		}
-		kfree(cksum.data);
 	}
 	crp->cr_clp = clp;
 	return 0;
@@ -1476,7 +1457,7 @@ nfs4_cld_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
-	nn->track_reclaim_completes = true;
+	set_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags);
 	atomic_set(&nn->nr_reclaim_complete, 0);
 
 	return 0;
@@ -1487,7 +1468,7 @@ nfs4_cld_state_shutdown(struct net *net)
 {
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 
-	nn->track_reclaim_completes = false;
+	clear_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags);
 	kfree(nn->reclaim_str_hashtbl);
 }
 
@@ -1554,7 +1535,6 @@ nfsd4_cld_tracking_init(struct net *net)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	bool running;
 	int retries = 10;
-	struct crypto_shash *tfm;
 
 	status = nfs4_cld_state_init(net);
 	if (status)
@@ -1579,12 +1559,6 @@ nfsd4_cld_tracking_init(struct net *net)
 		status = -ETIMEDOUT;
 		goto err_remove;
 	}
-	tfm = crypto_alloc_shash("sha256", 0, 0);
-	if (IS_ERR(tfm)) {
-		status = PTR_ERR(tfm);
-		goto err_remove;
-	}
-	nn->cld_net->cn_tfm = tfm;
 
 	status = nfsd4_cld_get_version(nn);
 	if (status == -EOPNOTSUPP)
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f21878a7f3939..275deb330a315 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2295,7 +2295,7 @@ static void inc_reclaim_complete(struct nfs4_client *clp)
 {
 	struct nfsd_net *nn = net_generic(clp->net, nfsd_net_id);
 
-	if (!nn->track_reclaim_completes)
+	if (!test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags))
 		return;
 	if (!nfsd4_find_reclaim_client(clp->cl_name, nn))
 		return;
@@ -4452,8 +4452,6 @@ nfsd4_init_leases_net(struct nfsd_net *nn)
 
 	nn->nfsd4_lease = 90;	/* default lease time */
 	nn->nfsd4_grace = 90;
-	nn->somebody_reclaimed = false;
-	nn->track_reclaim_completes = false;
 	nn->clverifier_counter = get_random_u32();
 	nn->clientid_base = get_random_u32();
 	nn->clientid_counter = nn->clientid_base + 1;
@@ -5927,12 +5925,21 @@ nfsd4_renew(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
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
@@ -5974,11 +5981,12 @@ bool nfsd4_force_end_grace(struct nfsd_net *nn)
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
@@ -5993,15 +6001,15 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
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
@@ -7731,7 +7739,7 @@ nfsd4_lock(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		nfs4_inc_and_copy_stateid(&lock->lk_resp_stateid, &lock_stp->st_stid);
 		status = 0;
 		if (lock->lk_reclaim)
-			nn->somebody_reclaimed = true;
+			set_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
 		break;
 	case FILE_LOCK_DEFERRED:
 		kref_put(&nbl->nbl_kref, free_nbl);
@@ -8241,8 +8249,8 @@ static int nfs4_state_create_net(struct net *net)
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
@@ -8324,7 +8332,8 @@ nfs4_state_start_net(struct net *net)
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
index 9b7f314525511..c7f46f57935d9 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1130,7 +1130,7 @@ static ssize_t write_v4_end_grace(struct file *file, char *buf, size_t size)
 	}
 
 	return scnprintf(buf, SIMPLE_TRANSACTION_LIMIT, "%c\n",
-			 nn->grace_ended ? 'Y' : 'N');
+			 test_bit(NFSD_NET_GRACE_ENDED, &nn->flags) ? 'Y' : 'N');
 }
 
 #endif
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 623f522b15659..2086a73b140fb 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -407,7 +407,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
 	int ret;
 
-	if (nn->nfsd_net_up)
+	if (test_bit(NFSD_NET_UP, &nn->flags))
 		return 0;
 
 	ret = nfsd_startup_generic();
@@ -417,11 +417,11 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
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
@@ -439,7 +439,7 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
 	if (ret)
 		goto out_reply_cache;
 
-	nn->nfsd_net_up = true;
+	set_bit(NFSD_NET_UP, &nn->flags);
 	return 0;
 
 out_reply_cache:
@@ -447,9 +447,9 @@ static int nfsd_startup_net(struct net *net, const struct cred *cred)
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
@@ -463,11 +463,11 @@ static void nfsd_shutdown_net(struct net *net)
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
 
@@ -563,7 +563,7 @@ void nfsd_last_thread(struct net *net)
 	 * other initialization has been done except the rpcb information.
 	 */
 	svc_rpcb_cleanup(serv, net);
-	if (!nn->nfsd_net_up)
+	if (!test_bit(NFSD_NET_UP, &nn->flags))
 		return;
 
 	nfsd_shutdown_net(net);
-- 
2.53.0

