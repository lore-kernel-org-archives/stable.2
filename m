Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BF8492505
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442790; cv=none; b=FHGSrUvJxYXGqUZCVGhQLdn+qfMoUi4VqgV9VaxfvWMfE+Su7qmNoKTdbGOzRSJZ+0RLdrqlHzZ7QSPsDoutUmkGx4bdKc3wyudtJhO6TB/Qc4n0XsB3MR4IwyJAj5eS6RHRS3dH5hJVYphlhf5hwjdGoLg2XPEJKcVtVcugo6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442790; c=relaxed/simple;
	bh=BjhmDCRRhoWRaId1j5+zKGMhI5PEQuVK/QAu9k1b5Eg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZOqMzeEGXqDE9+OkZ5czWZOSwWEnDbutt7tZdPdYm24gWwuNJQCsmzzjWLBlRo16H5ElJtyt/csc4xZQaQIfSeKfWjqBh4uUhI0ekQcqEHsKeF7qCvZ6BUVHDp6hdFd6VdG3dt3HRnF9SVHWIxXqgA4HnFhiFZ4QXoK+kjBEffI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tnFNHkUC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tnFNHkUC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EC321F00ACF;
	Thu,  3 Sep 2026 13:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788442768;
	bh=HEf9FCzxNcHaUdkOoEoCl3gHkKCY/dUeojf3j5znkvg=;
	h=Subject:To:Cc:From:Date;
	b=tnFNHkUClluZLmBCWroAKD2qts6R4Ij/4abM35llMoiR8fDTUvtQFu9DXQsYN7poN
	 bp1Tqy2Qum4zZ+8Moo9oWTvM1iN4p68GnFwdM9VfOVQN1dlfdOpAWQepLw+rmhlPoQ
	 WIhHxAicHtnPR7PcvckVYncN2oWIVJ26ox1rOPp4=
Subject: FAILED: patch "[PATCH] nfsd: dedup nfs4_client_to_reclaim inserts" failed to apply to 5.10-stable tree
To: jlayton@kernel.org,chuck.lever@oracle.com,clm@meta.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:12:28 +0200
Message-ID: <2026090328-follicle-skinless-f045@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9b57793863f69c608691c98e57c2f9be2db9dfed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090328-follicle-skinless-f045@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9b57793863f69c608691c98e57c2f9be2db9dfed Mon Sep 17 00:00:00 2001
From: Jeff Layton <jlayton@kernel.org>
Date: Sat, 30 May 2026 09:19:20 -0400
Subject: [PATCH] nfsd: dedup nfs4_client_to_reclaim inserts

nfs4_client_to_reclaim() unconditionally allocates a new
nfs4_client_reclaim, prepends it to reclaim_str_hashtbl[], and bumps
reclaim_str_hashtbl_size with no check for an existing entry for the
same client name.  After a reboot with a populated recovery directory
that inflates the counter by one for every client that reclaims:

    boot:    load_recdir()
               nfs4_client_to_reclaim(name)   /* entry #1, size++ */

    grace:   RECLAIM_COMPLETE
               __nfsd4_create_reclaim_record_grace()
                 nfs4_client_to_reclaim(name) /* entry #2, size++ */

inc_reclaim_complete() ends the grace period early only when

    atomic_inc_return(&nn->nr_reclaim_complete) ==
        nn->reclaim_str_hashtbl_size

With reclaim_str_hashtbl_size at 2N and nr_reclaim_complete capped at
N, the equality never holds and the fast end-of-grace path is dead.
The grace period always runs out the full 90-second laundromat timer,
and the shadow entry left in the hash table carries a dangling cr_clp
for any reader that walks it.

Fix nfs4_client_to_reclaim() to look the name up with
nfsd4_find_reclaim_client() first and, on a hit, fold the new
princhash into the existing record (if it lacks one) and return that
record without allocating or touching reclaim_str_hashtbl_size.  On
kmemdup() failure during the fold-in, return NULL so
__cld_pipe_inprogress_downcall() surfaces -EFAULT to nfsdcld, matching
the miss-path contract.

Add an rw_semaphore (reclaim_str_hashtbl_lock) to struct nfsd_net that
serialises all access to reclaim_str_hashtbl[] and
reclaim_str_hashtbl_size.  Writers (nfs4_client_to_reclaim,
nfs4_remove_reclaim_record callers) hold the write side; readers
(nfsd4_cld_check*, inc_reclaim_complete, clients_still_reclaiming,
nfs4_has_reclaimed_state, nfsd4_check_legacy_client) hold the read
side.  All call sites are in sleepable context, and none is a hot
path, so the rwsem cost is negligible.

Reported-by: Chris Mason <clm@meta.com>
Fixes: 362063a595be ("nfsd: keep a tally of RECLAIM_COMPLETE operations when using nfsdcld")
Cc: stable@vger.kernel.org
Assisted-by: kres:claude-opus-4-7
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260530-nfsd-fixes-v2-4-f27e8eb4d974@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 37dfecb9d49d..f6b8b340bf8e 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -93,6 +93,7 @@ struct nfsd_net {
 	 */
 	struct list_head *reclaim_str_hashtbl;
 	int reclaim_str_hashtbl_size;
+	struct rw_semaphore reclaim_str_hashtbl_lock;
 	struct list_head *conf_id_hashtbl;
 	struct rb_root conf_name_tree;
 	struct list_head *unconf_id_hashtbl;
@@ -105,7 +106,10 @@ struct nfsd_net {
 	 * close_lru holds (open) stateowner queue ordered by nfs4_stateowner.so_time
 	 * for last close replay.
 	 *
-	 * All of the above fields are protected by the client_mutex.
+	 * reclaim_str_hashtbl[], reclaim_str_hashtbl_size are protected by
+	 * reclaim_str_hashtbl_lock.
+	 *
+	 * All of the remaining fields are protected by the client_lock.
 	 */
 	struct list_head client_lru;
 	struct list_head close_lru;
diff --git a/fs/nfsd/nfs4recover.c b/fs/nfsd/nfs4recover.c
index c841da585142..d513971fb119 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -285,10 +285,12 @@ __nfsd4_remove_reclaim_record_grace(const char *dname, int len,
 		return;
 	}
 	name.len = len;
+	down_write(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(name, nn);
-	kfree(name.data);
 	if (crp)
 		nfs4_remove_reclaim_record(crp, nn);
+	up_write(&nn->reclaim_str_hashtbl_lock);
+	kfree(name.data);
 }
 
 static void
@@ -484,6 +486,7 @@ nfs4_legacy_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
+	init_rwsem(&nn->reclaim_str_hashtbl_lock);
 
 	return 0;
 }
@@ -598,13 +601,16 @@ nfsd4_check_legacy_client(struct nfs4_client *clp)
 		goto out_enoent;
 	}
 	name.len = HEXDIR_LEN;
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(name, nn);
-	kfree(name.data);
 	if (crp) {
 		set_bit(NFSD4_CLIENT_STABLE, &clp->cl_flags);
 		crp->cr_clp = clp;
-		return 0;
 	}
+	up_read(&nn->reclaim_str_hashtbl_lock);
+	kfree(name.data);
+	if (crp)
+		return 0;
 
 out_enoent:
 	return -ENOENT;
@@ -1176,6 +1182,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
 		return 0;
 
 	/* look for it in the reclaim hashtable otherwise */
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
 	if (crp)
 		goto found;
@@ -1191,6 +1198,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
 		if (!name.data) {
 			dprintk("%s: failed to allocate memory for name.data!\n",
 				__func__);
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
 		name.len = HEXDIR_LEN;
@@ -1201,9 +1209,11 @@ nfsd4_cld_check(struct nfs4_client *clp)
 
 	}
 #endif
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return -ENOENT;
 found:
 	crp->cr_clp = clp;
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return 0;
 }
 
@@ -1215,6 +1225,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 	struct cld_net *cn = nn->cld_net;
 #endif
 	struct nfs4_client_reclaim *crp;
+	unsigned int princhashlen;
 	char *principal = NULL;
 
 	/* did we already find that this client is stable? */
@@ -1222,6 +1233,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 		return 0;
 
 	/* look for it in the reclaim hashtable otherwise */
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
 	if (crp)
 		goto found;
@@ -1237,6 +1249,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 		if (!name.data) {
 			dprintk("%s: failed to allocate memory for name.data\n",
 					__func__);
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
 		name.len = HEXDIR_LEN;
@@ -1247,23 +1260,31 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 
 	}
 #endif
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return -ENOENT;
 found:
-	if (crp->cr_princhash.len) {
+	princhashlen = crp->cr_princhash.len;
+	if (princhashlen) {
 		u8 digest[SHA256_DIGEST_SIZE];
+		u8 *pdata;
 
 		if (clp->cl_cred.cr_raw_principal)
 			principal = clp->cl_cred.cr_raw_principal;
 		else if (clp->cl_cred.cr_principal)
 			principal = clp->cl_cred.cr_principal;
-		if (principal == NULL)
+		if (principal == NULL) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
+		}
 		sha256(principal, strlen(principal), digest);
-		if (memcmp(crp->cr_princhash.data, digest,
-				crp->cr_princhash.len))
+		pdata = crp->cr_princhash.data;
+		if (memcmp(pdata, digest, princhashlen)) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
+		}
 	}
 	crp->cr_clp = clp;
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return 0;
 }
 
@@ -1362,6 +1383,7 @@ nfs4_cld_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
+	init_rwsem(&nn->reclaim_str_hashtbl_lock);
 	set_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags);
 	atomic_set(&nn->nr_reclaim_complete, 0);
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 2e9773b3a60c..c88637406773 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2677,14 +2677,21 @@ static void inc_reclaim_complete(struct nfs4_client *clp)
 
 	if (!test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags))
 		return;
-	if (!nfsd4_find_reclaim_client(clp->cl_name, nn))
+
+	down_read(&nn->reclaim_str_hashtbl_lock);
+	if (!nfsd4_find_reclaim_client(clp->cl_name, nn)) {
+		up_read(&nn->reclaim_str_hashtbl_lock);
 		return;
+	}
 	if (atomic_inc_return(&nn->nr_reclaim_complete) ==
 			nn->reclaim_str_hashtbl_size) {
+		up_read(&nn->reclaim_str_hashtbl_lock);
 		printk(KERN_INFO "NFSD: all clients done reclaiming, ending NFSv4 grace period (net %x)\n",
 				clp->net->ns.inum);
 		nfsd4_end_grace(nn);
+		return;
 	}
+	up_read(&nn->reclaim_str_hashtbl_lock);
 }
 
 static void expire_client(struct nfs4_client *clp)
@@ -6821,10 +6828,15 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 
 	if (test_bit(NFSD_NET_GRACE_END_FORCED, &nn->flags))
 		return false;
-	if (test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags) &&
-			atomic_read(&nn->nr_reclaim_complete) ==
-			nn->reclaim_str_hashtbl_size)
-		return false;
+	if (test_bit(NFSD_NET_TRACK_RECLAIM_COMPLETES, &nn->flags)) {
+		int size;
+
+		down_read(&nn->reclaim_str_hashtbl_lock);
+		size = nn->reclaim_str_hashtbl_size;
+		up_read(&nn->reclaim_str_hashtbl_lock);
+		if (atomic_read(&nn->nr_reclaim_complete) == size)
+			return false;
+	}
 	if (!test_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags))
 		return false;
 	clear_bit(NFSD_NET_SOMEBODY_RECLAIMED, &nn->flags);
@@ -8994,9 +9006,13 @@ bool
 nfs4_has_reclaimed_state(struct xdr_netobj name, struct nfsd_net *nn)
 {
 	struct nfs4_client_reclaim *crp;
+	bool found;
 
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(name, nn);
-	return (crp && crp->cr_clp);
+	found = (crp && crp->cr_clp);
+	up_read(&nn->reclaim_str_hashtbl_lock);
+	return found;
 }
 
 /*
@@ -9009,10 +9025,39 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 	unsigned int strhashval;
 	struct nfs4_client_reclaim *crp;
 
+	down_write(&nn->reclaim_str_hashtbl_lock);
+
+	/*
+	 * A reclaim record for this client name may already exist (for
+	 * example, populated at boot from the recovery directory before
+	 * an in-grace RECLAIM_COMPLETE or an nfsdcld downcall delivers
+	 * the same name). Dedup here so reclaim_str_hashtbl_size stays
+	 * equal to the number of distinct client names; inc_reclaim_complete
+	 * relies on that equality to end the grace period via the fast path.
+	 */
+	crp = nfsd4_find_reclaim_client(name, nn);
+	if (crp) {
+		if (princhash.len && crp->cr_princhash.len == 0) {
+			void *pdata = kmemdup(princhash.data, princhash.len,
+					      GFP_KERNEL);
+			if (pdata) {
+				crp->cr_princhash.data = pdata;
+				crp->cr_princhash.len = princhash.len;
+			} else {
+				dprintk("%s: failed to allocate memory for princhash.data!\n",
+					__func__);
+				crp = NULL;
+			}
+		}
+		up_write(&nn->reclaim_str_hashtbl_lock);
+		return crp;
+	}
+
 	name.data = kmemdup(name.data, name.len, GFP_KERNEL);
 	if (!name.data) {
 		dprintk("%s: failed to allocate memory for name.data!\n",
 			__func__);
+		up_write(&nn->reclaim_str_hashtbl_lock);
 		return NULL;
 	}
 	if (princhash.len) {
@@ -9021,6 +9066,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 			dprintk("%s: failed to allocate memory for princhash.data!\n",
 				__func__);
 			kfree(name.data);
+			up_write(&nn->reclaim_str_hashtbl_lock);
 			return NULL;
 		}
 	} else
@@ -9040,6 +9086,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 		kfree(name.data);
 		kfree(princhash.data);
 	}
+	up_write(&nn->reclaim_str_hashtbl_lock);
 	return crp;
 }
 
@@ -9059,6 +9106,7 @@ nfs4_release_reclaim(struct nfsd_net *nn)
 	struct nfs4_client_reclaim *crp = NULL;
 	int i;
 
+	down_write(&nn->reclaim_str_hashtbl_lock);
 	for (i = 0; i < CLIENT_HASH_SIZE; i++) {
 		while (!list_empty(&nn->reclaim_str_hashtbl[i])) {
 			crp = list_entry(nn->reclaim_str_hashtbl[i].next,
@@ -9067,6 +9115,7 @@ nfs4_release_reclaim(struct nfsd_net *nn)
 		}
 	}
 	WARN_ON_ONCE(nn->reclaim_str_hashtbl_size);
+	up_write(&nn->reclaim_str_hashtbl_lock);
 }
 
 /*

