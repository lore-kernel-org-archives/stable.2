Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932979;
	b=BVSEU7px4eLXvO+P8X/dqMMF3D6f/wYKPaZbKew4D+PmUf1+hRVsUxg2a8fUr8TyFS38
	 87iVMbQ+RHVsiRlsswke5NHNywtIfx7Grst+RTtse3ubtawNHkXYxFMbu5Z0dIFSvZiwz
	 rh1Dq78G/1jRSehv0IszjBmFF1KLJbjZDAQcChlaklUIpJe6H89irlezOphw3uX7ErT/J
	 QEMoJV0oQ35xTz8Ud/bczY4gzXQahAlzNtRSxC8pxkA8aZhGd5onBDWBbrNxRnsV1WCHX
	 1rJL93hEcdPp/YMxpSanDeINHP+YPqLWdWVbuT0YeNkwc29MS+wzJpyWO2VN62tfp1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4Lko5y7/8t1uUKXJ5dFrp8wJi1vH76A2kO9rkI066c0=;
	b=V+oulgPpZ1cCmYmeh+2PojxqJstw1bYPNuTl3SrxQbNX4Yvi/5ERUIgRgoWMPn0r75D/
	 /0K6v9Npj+hRiheILQsMUqSjNEo8DyepcD5AnoRALss7tXX6Y9ReySPmpJxkcuMHFA3/1
	 rue1dCSH7k5j5AZE3usAqcvrn8CtJ5mLysTB+TzhgCPhEuOuxQIzu/1p8i5ASoxGbmGLa
	 gUw5bLgVbS+SA8EYdj6jhSQKL2YgmhiHSp1FW/DDKoMK5hUrLlHwelimUUrikD619do1l
	 Xg+dVsUhsLUZ3paXnj5BDb0rF4o5TriAaVGoEG5MUggUrk1xeTSk447jtc4eCKw6WBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXikmpnd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93F2606A32C
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WXikmpnd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7CE1F008A4;
	Fri,  6 Nov 2026 02:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932978;
	bh=4Lko5y7/8t1uUKXJ5dFrp8wJi1vH76A2kO9rkI066c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WXikmpndY+3M2CjdZWVlhcs/0CVrL+8rNw9sBh0IBJnqJz3r2D9Dev2QxBVSK/ykU
	 U7JVLVOD/vSvg92twNs+SlTn8GueehNRgAwOgDaP77YWLd2Y54+ZULw5IPF3vWcjKO
	 oGaIblw3xwk2aJANlxnidf7AcRfqCoOX7Rva2sDfYyu2PYk1q0pBUms5WEKXVhCemg
	 b4YqJ6E2aksfTl7Hc8PvQhhbhCZ1MgDTr908hOmizMwMRn3v+5aRC4OWO8yY06D9fm
	 tR5fHRAaYPobI9wV0OGWFebWtaSBib4w1aSI+5gDRv3vc9y4o3/lK5JxNEUWS5Sxrp
	 3uvZm9YAIG1Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] NFSD: Send a meaningful CB_RECALL_ANY keep count
Date: Thu,  5 Nov 2026 21:42:56 -0500
Message-ID: <20261106023407.3730085-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106023407.3730085-1-sashal@kernel.org>
References: <2026110428-retention-sandfish-d9c2@gregkh>
 <20261106023407.3730085-1-sashal@kernel.org>
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
index 222f2aadaafad..44ca5746911c8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -7306,6 +7306,7 @@ deleg_reaper(struct nfsd_net *nn)
 {
 	struct list_head *pos, *next;
 	struct nfs4_client *clp;
+	unsigned int count;
 
 	spin_lock(&nn->client_lock);
 	list_for_each_safe(pos, next, &nn->client_lru) {
@@ -7315,21 +7316,33 @@ deleg_reaper(struct nfsd_net *nn)
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

