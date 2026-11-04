Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793818834;
	b=kdUWTyHwQ6c/ZO+9ItCgGt5kpBF4dzjzjD5HFC2mKnGeNrdbCb4JDJ0Q9uv5enOmtMH0
	 mcuwfCNygP4XyN/9I+RYjtud2cBaE6ZlKK43L48EdJDBd0kWGB7DRVNroQZ0SZ1vhYAoX
	 TshMigh95GJayKNRlE5bXAVvY2u5UTidsfVfQdao3ZUS+wcn8mHZzL+a1hrgEDME3Avfb
	 OYhtuTHohXsVVUrvVV+aiqTLbVtEEb8bVG4Y9r0QXlUcbngJ3rh3Jk5/cWAljIpwh8tMw
	 fl6a4Q9X75ACOBxPZ3sEmElb4uENi8D7XSQHhVQKwZPAt6JRMeEdOZY/vObPePfxVlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793818834;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=714Nc1wwE3lw71rbcnCgmvDAHy78ZsrHCHZ5yjpWTVw=;
	b=C0CIrjy/yW61fMaN/jIwPHuh1gijUxDUN00G6PK1RDMvoK3OO2V96hRcNJPiwu8z33nL
	 xTOTusGwM5JbZ3JvJ9Hqt6RSsWoYf1udxLWn3ET/cW1FT9up0d/tn2LhHdzVeRFnkK+3b
	 cXrxmlAMaZHbSLxhBO5zRISheyrxcGzR8Dzmw2XyAotiJ21m7MNC7X7ZcnmuIp+KodREi
	 9hFsIkgQtCYmhedRKAszHz/WxlKfXavreoB9NTh3+UnAb07MS0/FPtxQXcGRhb2DRaAx8
	 QKrxPiyT1+IQj91xo0wcfcACi8VmlMAXv2/padsOfSA/Ss/5Q9/2o2Drj5ZSMcyVNJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dMDaqGbE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6E606A33C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=dMDaqGbE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B32B1F00919;
	Wed,  4 Nov 2026 19:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793818829;
	bh=714Nc1wwE3lw71rbcnCgmvDAHy78ZsrHCHZ5yjpWTVw=;
	h=Subject:To:Cc:From:Date;
	b=dMDaqGbEELT9YximnVCwLNpfyOm1e/OSSxSth2UGti3UUlJX6Yk5+DyY58TQEepsd
	 RBhN5a0YHVRGE27FqtysC/sr76pw14HAiBRKzxQ2ExnEx89kusQYuTrWKudv6CHK6s
	 JwujjNPcQeG0h/cj/haW1QMZPnCPN614+cqTciwc=
Subject: FAILED: patch "[PATCH] NFSD: Send a meaningful CB_RECALL_ANY keep count" failed to apply to 7.3-stable tree
To: cel@kernel.org,jlayton@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 14:00:28 -0500
Message-ID: <2026110428-scalping-unclaimed-78cf@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 9af39c0773ef956039e1ebe9c235532fe6ee1e50
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110428-scalping-unclaimed-78cf@gregkh' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9af39c0773ef956039e1ebe9c235532fe6ee1e50 Mon Sep 17 00:00:00 2001
From: Chuck Lever <cel@kernel.org>
Date: Mon, 17 Aug 2026 21:08:39 -0400
Subject: [PATCH] NFSD: Send a meaningful CB_RECALL_ANY keep count

deleg_reaper() sets craa_objects_to_keep to zero on every
CB_RECALL_ANY. RFC 8881 Section 20.6.3 defines that field as the
number of objects the client may keep, leaving the client to choose
which of the excess to return, because the server cannot read lack
of recent use as lack of usefulness. Zero asks for every delegation
the client holds, including the ones backing files an application
still has open.

There is also no reason NFSD has to reclaim the entire delegation
working set on the first sign of memory pressure.

Derive the keep count from cl_deleg_count so that each callback
asks for one delegation. Both the shrinker and the laundromat re-arm
while their condition lasts, so a client with more to give is asked
again on the next pass.

The Linux client ignores craa_objects_to_keep and returns unused
delegations selected from the type mask alone, so the count changes
nothing for it.

Fixes: 44df6f439a17 ("NFSD: add delegation reaper to react to low memory condition")
Cc: stable@vger.kernel.org
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260817-recall-any-keep-count-v5-4-3b2cffce701e@kernel.org
Signed-off-by: Chuck Lever <cel@kernel.org>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index f6da74ce16a9..9d40b573a295 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7959,6 +7959,7 @@ deleg_reaper(struct nfsd_net *nn)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	unsigned int count;
 
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -7968,21 +7969,33 @@ deleg_reaper(struct nfsd_net *nn)
 			continue;
 		if (clp->cl_state != NFSD4_ACTIVE)
 			continue;
-		if (list_empty(&clp->cl_delegations))
-			continue;
 		if (atomic_read(&clp->cl_delegs_in_recall))
 			continue;
 		if (ktime_get_boottime_seconds() - clp->cl_ra_time < 5)
 			continue;
 		if (clp->cl_cb_state != NFSD4_CB_UP)
 			continue;
+		/*
+		 * This read races with hash_delegation_locked() and
+		 * unhash_delegation_locked() on other CPUs. A stale
+		 * count only skews the keep value; the next
+		 * laundromat pass sees a more current one.
+		 */
+		count = data_race(READ_ONCE(clp->cl_deleg_count));
+		if (!count)
+			continue;
 		if (test_and_set_bit(NFSD4_CALLBACK_RUNNING, &clp->cl_ra->ra_cb.cb_flags))
 			continue;
 
 		/* release in nfsd4_cb_recall_any_release */
 		kref_get(&clp->cl_nfsdfs.cl_ref);
 		clp->cl_ra_time = ktime_get_boottime_seconds();
-		clp->cl_ra->ra_keep = 0;
+		/*
+		 * Ask for a single delegation. Recalling one before it
+		 * is needed costs the client an OPEN when it next
+		 * touches the file.
+		 */
+		clp->cl_ra->ra_keep = count - 1;
 		clp->cl_ra->ra_bmval[0] = BIT(RCA4_TYPE_MASK_RDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_WDATA_DLG) |
 						BIT(RCA4_TYPE_MASK_DIR_DLG);

