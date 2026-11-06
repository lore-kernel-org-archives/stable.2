Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930434;
	b=S6prxW2mmBVVKO46gbM0qNoEJR1HlEcJV6v6pFgnGkGFjEhRm6UH5Ua6YjnUGhdNlMmj
	 +mTLHxt87XCwXF9FC5bq2iOrXXynvs2slGhoRkPkC6+qgsMjRTNGgj1dZHSxC5eGmapnz
	 4Ugu6VKFdCbMvlaOTBi1Zr7nCTN2DQueCDthebVLgQn5uPhEYxFu79J9BS0yBoP/4rQxk
	 XhNgdPtDPwgpZmUGSq7/hsrPIwO3c25VJlcccuRgUQmgqp+h4r8XjhBwu2cQwIMDanf7D
	 Ib9kzdp0HivLjxlYgzsFAoUE2B0fKg3PevT/XzLA+hwKbuPreFI1mnMYfq5ZleS+1Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930434;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s8e9V7BGJb9On45+u9ZoMOCMT4YSo+UxkMTq1z73A5g=;
	b=aJEszu0Cm0TMK87RaJW3V4io9qsAeBhftcaUS5R6R8d3Lw2hsLF85kf3Ntsd7cgHyJWZ
	 wSgn68Lmklt56JzQ8cIMmsXV2dlddkuRca5jKbr3jG0Ah43p2FUMuPZ4BPns4pHNRKIAP
	 MX81vjPF+MC7SexhUBT2dlDnSHQaLMQHgmd6StW4+tyZmqVCN5CD4Up2JovA4nYVFaiN+
	 yelkDCqeqbdYc7T9sAKWkJgWrhOUW3zHzbpIAXVmm9SHjHcptx07RN/cbzaRrCc7yC8r9
	 uYFzd8rK8Kp0D68twgYphcMBYJAajPprcC/fJvRhqgHISjqjgrnoYcTZH9C7RS3aznw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="SFPdt/so";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C60606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SFPdt/so
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5074E1F0089F;
	Fri,  6 Nov 2026 02:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793930433;
	bh=s8e9V7BGJb9On45+u9ZoMOCMT4YSo+UxkMTq1z73A5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SFPdt/soMCdyaUDEDp/RV01wk6Kdp6Ru1ZUuLSuqhqopxl/XUbYeym61olCyyt1p0
	 e0Vv6Ld2k1t5pRUg3Pzma6sfIYtv98i61iMHn2SPkuqYnCuR0JriMD4+D9vm06ppgw
	 lfqYeKlJMlJuWUmfyivz9Q4WR5KpHimhzdVG/XAUy+l7Va+vtJ07v8qhswtIHUrHeL
	 BKEE13qr94/hfXdDmuKA9XYkiVb7e1yPAeRbI/SJVlxn3qgEPO1CQV/b87JTXnx1IS
	 vw6AOXJfqr90ieS9+nTzANtXCOk+NtTy7jBxQ1jxTlrfl8hjzpWlTGa3UpK3k13c2Y
	 UTQPAkbr1BQUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] NFSD: Send a meaningful CB_RECALL_ANY keep count
Date: Thu,  5 Nov 2026 21:00:31 -0500
Message-ID: <20261106015246.3591400-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110428-scalping-unclaimed-78cf@gregkh>
References: <2026110428-scalping-unclaimed-78cf@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <cel@kernel.org>

[ Upstream commit 9af39c0773ef956039e1ebe9c235532fe6ee1e50 ]

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
[ sashal: Added missing prerequisites for per-client delegation counting and the directory-delegation callback mask. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 24 ++++++++++++++++++++----
 fs/nfsd/state.h     |  2 ++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 3bdde4c1bb8eb..f0a7959401370 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1517,6 +1517,7 @@ hash_delegation_locked(struct nfs4_delegation *dp, struct nfs4_file *fp)
 	dp->dl_stid.sc_type = SC_TYPE_DELEG;
 	list_add(&dp->dl_perfile, &fp->fi_delegations);
 	list_add(&dp->dl_perclnt, &clp->cl_delegations);
+	clp->cl_deleg_count++;
 	return 0;
 }
 
@@ -1548,6 +1549,7 @@ unhash_delegation_locked(struct nfs4_delegation *dp, unsigned short statusmask)
 	++dp->dl_time;
 	spin_lock(&fp->fi_lock);
 	list_del_init(&dp->dl_perclnt);
+	dp->dl_stid.sc_client->cl_deleg_count--;
 	list_del_init(&dp->dl_recall_lru);
 	list_del_init(&dp->dl_perfile);
 	spin_unlock(&fp->fi_lock);
@@ -7938,6 +7940,7 @@ deleg_reaper(struct nfsd_net *nn)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	unsigned int count;
 
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -7947,23 +7950,36 @@ deleg_reaper(struct nfsd_net *nn)
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
-						BIT(RCA4_TYPE_MASK_WDATA_DLG);
+						BIT(RCA4_TYPE_MASK_WDATA_DLG) |
+						BIT(RCA4_TYPE_MASK_DIR_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
 		nfsd4_run_cb(&clp->cl_ra->ra_cb);
 	}
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 9661c08b879e8..df35c35890d48 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -610,6 +610,8 @@ struct nfs4_client {
 
 	unsigned int		cl_state;
 	atomic_t		cl_delegs_in_recall;
+	/* Length of cl_delegations, updated under nn->deleg_lock */
+	unsigned int		cl_deleg_count;
 
 	struct nfsd4_cb_recall_any	*cl_ra;
 	time64_t		cl_ra_time;
-- 
2.53.0

