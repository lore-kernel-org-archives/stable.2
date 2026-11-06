Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932754;
	b=Bhleei/EFSdEpOanIbIoUKe1BqH0/WoTJaciDlim/27DH38RhA9Xrr+nns2oheQaqHEM
	 6PqLseoloQdTR7AIYjdsic9Petqbs/2QNBedmmxq1wpQ1lFUw263OZbmAVL6SWlpL5dNJ
	 1f5MY+4l3raAqgVsNK3+XK2dB2GGEZxJX/PBRU23EoQomxQofrxpktGIJ4fGy/2y/EWho
	 +zTxR1o9zh3VR0LBfhyULy3iQr3+0nvN7rt4ssSqF3+/Q53BFcOr5Fs2Uow1LrNBk+zjf
	 fDkqgPuhM5bwstYgICTV2pkaUz09ufZn9kcfa+1AxKcOEMMEf9lfXzJ2IZJxF3lmmHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932754;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9I5CBFpD/QnIut00+YSH4fFgD0+g/1Nw3EuiZGOlPZ8=;
	b=THi9Y4yJ0ockKoqWCucWePa0FS4TJ3sP4MOD1VeWo0HmTlXqb0oYiyvbUyr/fEjSb9S5
	 iAetpR5g9hrkJBCwzToZnIfby4FsCcNsFJ7XIcXiQC/UOK2XfvhCtaLGGPHplN6H/8ZPh
	 6PgBofH+I2rXWqWH/k+hLiVGj0Cxico+BcDyYYbamUDDb5CeViXxXBsnv+tH4Wz0yFIq0
	 QwXf6FHtBpUOCThZ8x2iu9H1Z/FfdBWgjyet7jp5DSo6X5SAj+PGEvgNed8215UlXnB5h
	 V4iCFjg9kCcwh8uCpTtWjozjbB5p9tO1yNOtpHEPtBHZGww5cR9G3Rl89J2vlskoP3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4L7Tdxg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0AF606A329
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A4L7Tdxg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D1F1F008BC;
	Fri,  6 Nov 2026 02:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932754;
	bh=9I5CBFpD/QnIut00+YSH4fFgD0+g/1Nw3EuiZGOlPZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4L7TdxgJbuUy/m+ZDiykJ4sVsyFk6hDOkkgj9wqr7Nzqd6Gu0uqSbxwhN/BOUQAI
	 H/hWQnJcZiqlMjYD/iNM0tWGVPq2YsssIHeUL9H0DRwlm6GmDMnFGsv6U+AIIMHge1
	 lBX5+EtNL4WZV/cusrvEA2B1co+yXiKLCvzn8TUfvmp6AHpt15/EaTMbXS9oKx3/hE
	 ZlbSmlBS38FHitPzK90mtGMa0BBCTnFec2/ZOuA64v3hTndZpDTlwnUmOobVfY8nbE
	 eqBM0odp8frXO4mIiKpkj4lh7syp5TtyXc64L0ctQoVwimSZ4OlBSpjO/NIji05cF1
	 59knDDgsLew4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/5] NFSD: Send a meaningful CB_RECALL_ANY keep count
Date: Thu,  5 Nov 2026 21:39:09 -0500
Message-ID: <20261106022849.3786687-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106022849.3786687-1-sashal@kernel.org>
References: <2026110416-cleat-grapple-d472@gregkh>
 <20261106022849.3786687-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4state.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 43755bce08f95..c79b7ad28f3c4 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7006,6 +7006,7 @@ deleg_reaper(struct nfsd_net *nn)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	unsigned int count;
 
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -7015,21 +7016,33 @@ deleg_reaper(struct nfsd_net *nn)
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
 						BIT(RCA4_TYPE_MASK_WDATA_DLG);
 		trace_nfsd_cb_recall_any(clp->cl_ra);
-- 
2.53.0

