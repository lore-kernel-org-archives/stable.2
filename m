Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795624871;
	b=o63xwht+qCnDQeZoeBgaqrsitKsNaW01erDUdvvzA12T1rwUssbApwaxD/gl3Y7ih4f3
	 peuqs6N+Q5InxNtgcBBLKePZO3GeFIsVTOUesUOS+wCUSF4Ns0JY/SsWnoDxyKafL0K8R
	 Aq2h9veT2wmbSG9KfMCzkSiAgE+NfmT7g9XhT2dFUmhCVx/xRciPjSoVUFIaZV0wyYVPH
	 qdVpGXmVYUeicdSJAkFi+7oJ7Zfo0hPHEA2DAy8aEvgr0EhyBSLYGGYAQyYMDziMRjddY
	 A5t1YLHIJPyCzfeQ9N2jX44k8f3ZP0Cw7mBhQe9rEZVf+nIys5rgOM9EkRJ7pdeIrBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624871;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oy3lYrVYPPnuLCoqRrv1KSoVWPSYSuc/wdbDRS8TFi0=;
	b=mibREK+zRyxp9Wax9owQwEk9OKO8uHb+dWgyvjdjHLXjCaRSikhQL+S0dV9u6LRkmp04
	 jjxivS0nuJmvTPg5DzkaJhRgiuRgeCUMs1YkNcfVlxpNXjecEQJuku/7GfRomJCoe5ZZ3
	 +qPoJ3SR0hT26cV+4qS7h4Y4/GgNon9boYZVSj0OLNU+LNlCV4MtNEPWKVxmvbQiThETd
	 EB9NW3CeLi5hCXJ2h2YpjrR+EYK4S9waC66JRelMo4kgw8XrPRlsrIBCzKV3lpEvjGJ8k
	 js2+6Y4cN7peZy/+ZeC/GLmqs6dLgEmwa2zOEEKMLPBhab6CLAYHyH3mhdpZv+Og18g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxjEnIei;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90F7606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 16:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KxjEnIei
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB7E1F000D1;
	Wed, 25 Nov 2026 16:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795624871;
	bh=oy3lYrVYPPnuLCoqRrv1KSoVWPSYSuc/wdbDRS8TFi0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxjEnIei9g1pguAkwPza5i03z1u0HJT/xqm2UE8Zhmgag72d1f6qX+wbdNGgY969Y
	 xRxv1NnYuHnyHEn7oNWmNVyy6pU9wGgstMqcxICuoQinp7LkLs+HkFVSoH0YwbPIlb
	 s4+z5e5tE+pmL6ERyhEjtZXEiBs6Mt+Pjlo6RyhZyiObHQAlHPgke+ESAKdDFNVy/V
	 4ZvNnLnnE3ibQr7BBvsVbDK/w/OGh0Fxlv8i5KMIDMSUlzHUxP2accIrCQcie2DlMP
	 RrFvT9l5MlSW9tfSd0MvcbuXaQandq1AyzLe7BZFRyk8FvfgrExJBo42agtifurz+2
	 9iJHYjKIPW4Ig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 1/3] NFSv4/flexfiles: report the intended opnum when DS connection setup fails
Date: Wed, 25 Nov 2026 11:41:07 -0500
Message-ID: <20261125164026.827651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112557-foothold-septic-e646@gregkh>
References: <2026112557-foothold-septic-e646@gregkh>
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

From: Benjamin Coddington <ben.coddington@hammerspace.com>

[ Upstream commit 3a612faba5c40a59257db50e3a2da30c02a8c969 ]

When nfs4_ff_layout_prepare_ds() cannot establish a connection to a
data server, it records a device error with opnum OP_ILLEGAL, since no
operation ever made it to the wire.  But servers can use the ff_ioerr4
opnum to distinguish failed read-class operations from write-class
operations when deciding how to recover the affected mirror -- a mirror
that may have missed writes needs to be brought back in sync, while one
that merely failed to serve a read does not.  OP_ILLEGAL gives the
server nothing to act on.

Every caller of nfs4_ff_layout_prepare_ds() knows which operation it
was preparing to send, and the existing fail_return argument already
divides the callers along the same boundary (false for READ, true for
WRITE and COMMIT).  Replace the boolean with the intended opnum, derive
the layout return decision from it, and report it in the tracked device
error instead of OP_ILLEGAL.

Assisted-by: Claude:claude-fable-5
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Reviewed-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Stable-dep-of: 9e28836b480c ("pNFS: avoid repeatedly cancelling I/O for the same lseg")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c    | 13 ++++++++-----
 fs/nfs/flexfilelayout/flexfilelayout.h    |  2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 14 ++++++++------
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a4ccd53c79e79..121c55f4a46d9 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -904,7 +904,7 @@ ff_layout_choose_ds_for_read(struct pnfs_layout_segment *lseg,
 		mirror_ds = ff_layout_get_mirror_ds(lseg->pls_layout, mirror,
 						    *dss_id);
 		ds = nfs4_ff_layout_prepare_ds(lseg, mirror, mirror_ds,
-					       *dss_id, false);
+					       *dss_id, OP_READ);
 		if (IS_ERR(ds)) {
 			nfs4_ff_layout_put_deviceid(mirror_ds);
 			ret = ERR_CAST(ds);
@@ -1183,7 +1183,7 @@ ff_layout_pg_init_write(struct nfs_pageio_descriptor *pgio,
 		mirror_ds = ff_layout_get_mirror_ds(pgio->pg_lseg->pls_layout,
 						    mirror, dss_id);
 		ds = nfs4_ff_layout_prepare_ds(pgio->pg_lseg, mirror,
-					       mirror_ds, dss_id, true);
+					       mirror_ds, dss_id, OP_WRITE);
 		if (IS_ERR(ds)) {
 			nfs4_ff_layout_put_deviceid(mirror_ds);
 			if (!ff_layout_no_fallback_to_mds(pgio->pg_lseg))
@@ -2277,7 +2277,8 @@ ff_layout_read_pagelist(struct nfs_pgio_header *hdr)
 		mirror->dss_count,
 		offset);
 	mirror_ds = ff_layout_get_mirror_ds(lseg->pls_layout, mirror, dss_id);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, mirror_ds, dss_id, false);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, mirror_ds, dss_id,
+				       OP_READ);
 	if (IS_ERR(ds)) {
 		ds_fatal_error = nfs_error_is_fatal(PTR_ERR(ds));
 		goto out_failed;
@@ -2374,7 +2375,8 @@ ff_layout_write_pagelist(struct nfs_pgio_header *hdr, int sync)
 		mirror->dss_count,
 		offset);
 	mirror_ds = ff_layout_get_mirror_ds(lseg->pls_layout, mirror, dss_id);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, mirror_ds, dss_id, true);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, mirror_ds, dss_id,
+				       OP_WRITE);
 	if (IS_ERR(ds)) {
 		ds_fatal_error = nfs_error_is_fatal(PTR_ERR(ds));
 		goto out_failed;
@@ -2481,7 +2483,8 @@ static int ff_layout_initiate_commit(struct nfs_commit_data *data, int how)
 	mirror = FF_LAYOUT_COMP(lseg, idx);
 	dss_id = calc_dss_id_from_commit(lseg, data->ds_commit_index);
 	mirror_ds = ff_layout_get_mirror_ds(lseg->pls_layout, mirror, dss_id);
-	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, mirror_ds, dss_id, true);
+	ds = nfs4_ff_layout_prepare_ds(lseg, mirror, mirror_ds, dss_id,
+				       OP_COMMIT);
 	if (IS_ERR(ds))
 		goto out_err;
 
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.h b/fs/nfs/flexfilelayout/flexfilelayout.h
index 24de108af2cf8..19b833f547416 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.h
+++ b/fs/nfs/flexfilelayout/flexfilelayout.h
@@ -269,7 +269,7 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 			  struct nfs4_ff_layout_mirror *mirror,
 			  struct nfs4_ff_layout_ds *mirror_ds,
 			  u32 dss_id,
-			  bool fail_return);
+			  enum nfs_opnum4 opnum);
 
 struct rpc_clnt *
 nfs4_ff_find_or_create_ds_client(const struct nfs4_ff_layout_ds *mirror_ds,
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 3cef6a4a51a70..fa4e9ddafea6f 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -378,7 +378,7 @@ ff_layout_get_mirror_ds(struct pnfs_layout_hdr *lo,
  * @mirror_ds: referenced device node for the stripe, from
  *	ff_layout_get_mirror_ds() (may be an ERR_PTR)
  * @dss_id: DS stripe id to select stripe to use
- * @fail_return: return layout on connect failure?
+ * @opnum: operation this connection is being prepared for
  *
  * Try to prepare a DS connection to accept an RPC call. This involves
  * selecting a mirror to use and connecting the client to it if it's not
@@ -386,8 +386,10 @@ ff_layout_get_mirror_ds(struct pnfs_layout_hdr *lo,
  *
  * Since we only need a single functioning mirror to satisfy a read, we don't
  * want to return the layout if there is one. For writes though, any down
- * mirror should result in a LAYOUTRETURN. @fail_return is how we distinguish
- * between the two cases.
+ * mirror should result in a LAYOUTRETURN. @opnum is how we distinguish
+ * between the two cases. On failure, @opnum is also reported in the tracked
+ * device error so that the server can tell which class of I/O the client
+ * was unable to send to the mirror.
  *
  * Returns a pointer to a connected DS object on success or NULL on failure.
  */
@@ -396,7 +398,7 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 			  struct nfs4_ff_layout_mirror *mirror,
 			  struct nfs4_ff_layout_ds *mirror_ds,
 			  u32 dss_id,
-			  bool fail_return)
+			  enum nfs_opnum4 opnum)
 {
 	struct nfs4_pnfs_ds *ds;
 	struct inode *ino = lseg->pls_layout->plh_inode;
@@ -443,9 +445,9 @@ nfs4_ff_layout_prepare_ds(struct pnfs_layout_segment *lseg,
 	ff_layout_track_ds_error(FF_LAYOUT_FROM_HDR(lseg->pls_layout),
 				 mirror, dss_id, lseg->pls_range.offset,
 				 lseg->pls_range.length, NFS4ERR_NXIO,
-				 OP_ILLEGAL, GFP_NOIO);
+				 opnum, GFP_NOIO);
 	ff_layout_send_layouterror(lseg);
-	if (fail_return || !ff_layout_has_available_ds(lseg))
+	if (opnum != OP_READ || !ff_layout_has_available_ds(lseg))
 		pnfs_error_mark_layout_for_return(ino, lseg);
 	ds = ERR_PTR(status);
 out:
-- 
2.53.0

