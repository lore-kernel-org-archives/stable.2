Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B760772621
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788606183; cv=none; b=E78m7NNRrKV8Z7TvTgyUPzo92rrl1wjMm/VUrJVnaQSfrE6eQ4Xv9HN6Y8LDgXgPMTt3MOe6/qpk9R1zlQIYy5j3cklDAOou6O7BORibdwAZnB1G90jDZ1ChaeREY3WvjILKx4SMwX3RPBz0kPlYZkJ1oFbE4fzOFpo+4WCd3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788606183; c=relaxed/simple;
	bh=opvfxjFconlo3btorAKpoEIImMtEitNpt72CvlZsY3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oj2geYNbjUtfaEYeyY2P+PV8wEjZd4N4lFbuwb3ou65jv93EKXBACS+k4/5vzAFptWrGyZEwGqLGyKrebyP9B7KXCL74htmJLY/MeJCBAZeuG4enrXymdhHtSOiGzTk/U+XujctMSMdAQsDIGe0QWGHkvOVzdHAjc9UW0KfYsHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lI3YmWKe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lI3YmWKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8251F00A3D;
	Sat,  5 Sep 2026 11:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788606181;
	bh=8Kzs51mn9kZK3v5ssmg5NVjobozeX6o2D85B9YXC2Ac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lI3YmWKe3AhoGgnHiG/crhJyrdzDnqLUr0yiVhUPabQw55L71eNQTEHGMwiYjCC+P
	 lE77TpEhbnJENsJSGZB5Ri9eEsk1W1IWUICVUaksNhn+gps/rUO73be0PdUI0UxBcF
	 HPtCnpiaAwfjm7u6nm1lkaQeN5sKtDsoUoynMp/z88VXlJxxrJ0F2jh+9WZrF/fry0
	 1am65OSpHh1YDYeJctK+dWW9RmqPqI0r9aX2FH4h0yXGGVnuSDanomUIWw2cd1hFWF
	 S9ZSiouAacxdPNjAcWKoFp+B5nczHRMYrS5wJ71MkYaHAiP8iXlNKkP4QZA51TyBQi
	 V0bE4a4p0k5tw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] nfsd: dedup nfs4_client_to_reclaim inserts
Date: Sat,  5 Sep 2026 07:02:59 -0400
Message-ID: <20260905110259.3663263-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090325-triage-suitor-da06@gregkh>
References: <2026090325-triage-suitor-da06@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 9b57793863f69c608691c98e57c2f9be2db9dfed ]

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
[ retained 6.12 boolean fields and crypto-shash API while adding balanced unlocks to older error paths. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h       |  6 ++++-
 fs/nfsd/nfs4recover.c | 39 ++++++++++++++++++++++-----
 fs/nfsd/nfs4state.c   | 61 ++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 92 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index 09a06e46dab98..af3916e901630 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -84,6 +84,7 @@ struct nfsd_net {
 	 */
 	struct list_head *reclaim_str_hashtbl;
 	int reclaim_str_hashtbl_size;
+	struct rw_semaphore reclaim_str_hashtbl_lock;
 	struct list_head *conf_id_hashtbl;
 	struct rb_root conf_name_tree;
 	struct list_head *unconf_id_hashtbl;
@@ -96,7 +97,10 @@ struct nfsd_net {
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
index a8182962a2861..f2993d5c4695a 100644
--- a/fs/nfsd/nfs4recover.c
+++ b/fs/nfsd/nfs4recover.c
@@ -355,10 +355,12 @@ __nfsd4_remove_reclaim_record_grace(const char *dname, int len,
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
@@ -559,6 +561,7 @@ nfs4_legacy_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
+	init_rwsem(&nn->reclaim_str_hashtbl_lock);
 
 	return 0;
 }
@@ -678,13 +681,16 @@ nfsd4_check_legacy_client(struct nfs4_client *clp)
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
@@ -1285,6 +1291,7 @@ nfsd4_cld_check(struct nfs4_client *clp)
 		return 0;
 
 	/* look for it in the reclaim hashtable otherwise */
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
 	if (crp)
 		goto found;
@@ -1296,13 +1303,16 @@ nfsd4_cld_check(struct nfs4_client *clp)
 		struct xdr_netobj name;
 
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
@@ -1313,9 +1323,11 @@ nfsd4_cld_check(struct nfs4_client *clp)
 
 	}
 #endif
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return -ENOENT;
 found:
 	crp->cr_clp = clp;
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return 0;
 }
 
@@ -1335,6 +1347,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 		return 0;
 
 	/* look for it in the reclaim hashtable otherwise */
+	down_read(&nn->reclaim_str_hashtbl_lock);
 	crp = nfsd4_find_reclaim_client(clp->cl_name, nn);
 	if (crp)
 		goto found;
@@ -1345,13 +1358,16 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 		char dname[HEXDIR_LEN];
 
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
@@ -1362,6 +1378,7 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 
 	}
 #endif
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return -ENOENT;
 found:
 	if (crp->cr_princhash.len) {
@@ -1369,26 +1386,33 @@ nfsd4_cld_check_v2(struct nfs4_client *clp)
 			principal = clp->cl_cred.cr_raw_principal;
 		else if (clp->cl_cred.cr_principal)
 			principal = clp->cl_cred.cr_principal;
-		if (principal == NULL)
+		if (principal == NULL) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
+		}
 		cksum.len = crypto_shash_digestsize(tfm);
 		cksum.data = kmalloc(cksum.len, GFP_KERNEL);
-		if (cksum.data == NULL)
+		if (cksum.data == NULL) {
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
+		}
 		status = crypto_shash_tfm_digest(tfm, principal,
 						 strlen(principal), cksum.data);
 		if (status) {
 			kfree(cksum.data);
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
 		if (memcmp(crp->cr_princhash.data, cksum.data,
 				crp->cr_princhash.len)) {
 			kfree(cksum.data);
+			up_read(&nn->reclaim_str_hashtbl_lock);
 			return -ENOENT;
 		}
 		kfree(cksum.data);
 	}
 	crp->cr_clp = clp;
+	up_read(&nn->reclaim_str_hashtbl_lock);
 	return 0;
 }
 
@@ -1488,6 +1512,7 @@ nfs4_cld_state_init(struct net *net)
 	for (i = 0; i < CLIENT_HASH_SIZE; i++)
 		INIT_LIST_HEAD(&nn->reclaim_str_hashtbl[i]);
 	nn->reclaim_str_hashtbl_size = 0;
+	init_rwsem(&nn->reclaim_str_hashtbl_lock);
 	nn->track_reclaim_completes = true;
 	atomic_set(&nn->nr_reclaim_complete, 0);
 
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 342de8d2c4aa8..4f065db93aa71 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2484,14 +2484,21 @@ static void inc_reclaim_complete(struct nfs4_client *clp)
 
 	if (!nn->track_reclaim_completes)
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
@@ -6385,10 +6392,15 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 
 	if (READ_ONCE(nn->grace_end_forced))
 		return false;
-	if (nn->track_reclaim_completes &&
-			atomic_read(&nn->nr_reclaim_complete) ==
-			nn->reclaim_str_hashtbl_size)
-		return false;
+	if (nn->track_reclaim_completes) {
+		int size;
+
+		down_read(&nn->reclaim_str_hashtbl_lock);
+		size = nn->reclaim_str_hashtbl_size;
+		up_read(&nn->reclaim_str_hashtbl_lock);
+		if (atomic_read(&nn->nr_reclaim_complete) == size)
+			return false;
+	}
 	if (!nn->somebody_reclaimed)
 		return false;
 	nn->somebody_reclaimed = false;
@@ -8564,9 +8576,13 @@ bool
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
@@ -8579,10 +8595,39 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
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
@@ -8591,6 +8636,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 			dprintk("%s: failed to allocate memory for princhash.data!\n",
 				__func__);
 			kfree(name.data);
+			up_write(&nn->reclaim_str_hashtbl_lock);
 			return NULL;
 		}
 	} else
@@ -8610,6 +8656,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 		kfree(name.data);
 		kfree(princhash.data);
 	}
+	up_write(&nn->reclaim_str_hashtbl_lock);
 	return crp;
 }
 
@@ -8629,6 +8676,7 @@ nfs4_release_reclaim(struct nfsd_net *nn)
 	struct nfs4_client_reclaim *crp = NULL;
 	int i;
 
+	down_write(&nn->reclaim_str_hashtbl_lock);
 	for (i = 0; i < CLIENT_HASH_SIZE; i++) {
 		while (!list_empty(&nn->reclaim_str_hashtbl[i])) {
 			crp = list_entry(nn->reclaim_str_hashtbl[i].next,
@@ -8637,6 +8685,7 @@ nfs4_release_reclaim(struct nfsd_net *nn)
 		}
 	}
 	WARN_ON_ONCE(nn->reclaim_str_hashtbl_size);
+	up_write(&nn->reclaim_str_hashtbl_lock);
 }
 
 /*
-- 
2.53.0

