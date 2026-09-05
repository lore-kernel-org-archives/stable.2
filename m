Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1D375F82
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638739; cv=none; b=DtUc79vnecoGkemC0FeoXqj4oWptQhr3WzBh5WOS4A+HJtUhVWDyN1YRzXgpFi/97N8T/zlaoyBuWKLRFXv9GlI501eJ5fWaSsa9OcbFK7BlmmrTQadJsPeuQnI7OjCGrNBaD/Wv3PKhBqZV4aIyNFFjvjZRVI85efJGDv7OH00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638739; c=relaxed/simple;
	bh=OU9fuQTtrrk1EwGK9nikANdmDi1kSsFZu0t0reoMWUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X0vO5kwFZFCrKCVMsFAyFNvO21BVjA6jwJZJL0fhO9R/mXHxhDTHttiDXc57h7doaoWXvFSpZnifu3EcAGoLAeL46Ftk/UF3IXl8Na0ozGhvBJvinSL2US3wa0vyBTJCQQO2bsta3LqUgR0S6QQkDSGbo/A+FtkSFeVZbMDMam4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g7XJxjOQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7XJxjOQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9881F00A3E;
	Sat,  5 Sep 2026 20:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788638738;
	bh=MnbBV/TCO2i25zDdUoazGZUopX9cjDqytIiXcG3y5yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7XJxjOQwgI77oOFDetgiYEPczEV8zdNPLAceVJ6ijpCKfT22qI1BmrV35nEhuwFa
	 h0IR3teFh9DCDGAzJ2aPIUIAfHs1wiIcecqUTbmIREaHqV9aTNS8NpgneQ8JrWSwfX
	 SmxGSsCEqkOUAIEgKZ1XjUs0lkvb3KXGIIIuaRqEnQzNYipzsqo4LnSjL739TR4huq
	 rIDSxir/SSILHBzMH1C+Y4ZUtHWKRlNvZTzjWztQGmR2IfAxEqe9/DS0B+ydn3yG4j
	 sFqg1j6NS4wDGkav0sDHQX9Jmy7rztTlM5UenfsIoj1Pqkm0BKuAB7xsEczkusM+V3
	 bApCwCY0fFhNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] nfsd: dedup nfs4_client_to_reclaim inserts
Date: Sat,  5 Sep 2026 16:05:35 -0400
Message-ID: <20260905200535.607640-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905200535.607640-1-sashal@kernel.org>
References: <2026090327-magnesium-foyer-2250@gregkh>
 <20260905200535.607640-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/netns.h       |  5 +++-
 fs/nfsd/nfs4recover.c | 11 +++++---
 fs/nfsd/nfs4state.c   | 61 ++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/fs/nfsd/netns.h b/fs/nfsd/netns.h
index d6630921b5539..acb252c06ab79 100644
--- a/fs/nfsd/netns.h
+++ b/fs/nfsd/netns.h
@@ -104,7 +104,10 @@ struct nfsd_net {
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
index a8b854881bca5..7b7355082e28d 100644
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
@@ -679,13 +681,16 @@ nfsd4_check_legacy_client(struct nfs4_client *clp)
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
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 65dd12fdc2e3b..d332aa410dc75 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2298,14 +2298,21 @@ static void inc_reclaim_complete(struct nfs4_client *clp)
 
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
@@ -5962,10 +5969,15 @@ static bool clients_still_reclaiming(struct nfsd_net *nn)
 
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
@@ -8029,9 +8041,13 @@ bool
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
@@ -8044,10 +8060,39 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
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
@@ -8056,6 +8101,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 			dprintk("%s: failed to allocate memory for princhash.data!\n",
 				__func__);
 			kfree(name.data);
+			up_write(&nn->reclaim_str_hashtbl_lock);
 			return NULL;
 		}
 	} else
@@ -8075,6 +8121,7 @@ nfs4_client_to_reclaim(struct xdr_netobj name, struct xdr_netobj princhash,
 		kfree(name.data);
 		kfree(princhash.data);
 	}
+	up_write(&nn->reclaim_str_hashtbl_lock);
 	return crp;
 }
 
@@ -8094,6 +8141,7 @@ nfs4_release_reclaim(struct nfsd_net *nn)
 	struct nfs4_client_reclaim *crp = NULL;
 	int i;
 
+	down_write(&nn->reclaim_str_hashtbl_lock);
 	for (i = 0; i < CLIENT_HASH_SIZE; i++) {
 		while (!list_empty(&nn->reclaim_str_hashtbl[i])) {
 			crp = list_entry(nn->reclaim_str_hashtbl[i].next,
@@ -8102,6 +8150,7 @@ nfs4_release_reclaim(struct nfsd_net *nn)
 		}
 	}
 	WARN_ON_ONCE(nn->reclaim_str_hashtbl_size);
+	up_write(&nn->reclaim_str_hashtbl_lock);
 }
 
 /*
-- 
2.53.0

