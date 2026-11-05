Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793893254;
	b=veT2I1lo85vPOP99Q94T+FRueA8MIzFOWTqsxeo4oiBUYO31EEchWKIXjTABcKaKPuSz
	 zE0RFqhxd1NyYcPHFyYvkv+pFHU0x/sVeuXdUt1MBINVbcBx9TFPKIieUWHVv0NJU/hJz
	 ojTEtCRTLVhWEktyErBz85a5l+jpq0YbhgXzK4O3/hp8o8OJB2CrZc1ER2JnqN4kl2Na+
	 ay0M+If/94wPNLaewg4+b/CRp9S72u3feVYfCHDfLHcruE0L9PPBOIiDcOxWQ+r6FNCx8
	 8mgULyLKe0JQ7vGVN3ti0troKEdpgYvd3GLP/zohhZJvENxSTLKSdCVkczyjzuNq7Kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793893254;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OIo3hYQsCto/yuloWdAN6sLtyuJFZ3yKFJq+Xz3167I=;
	b=XvrT1rwoiDTLAE5cBiags06yFofSJ6KOzWrBbwOPzkECk+bxti/ZCLkTxRYaP4eb7kik
	 La8SrHsU8s/AyeA1cpUleUjhxFDBZpAHPeyOVrJT/41nc531qUvu5pYYM9+yPdnm/oplC
	 V/mt2Yio1LPGlMD0cm6+sdDFxKh6SUcGidYYsBus+rW3Hel9P/4toB7XYjV/59RHmZvJ5
	 bbBC6cw94XR4vjGyXJgMvTY5MXFfqYcTov3oIEVG4nmB1ZUal30fLHtZ/cgyQG74x/28d
	 MM369eX0lvpnff/u1DjTijGGJXTUo+3BiFtKH1GHdLX3/n2vy2mQBabXh28G1CXwnPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDjLgk0E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD89606A331
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kDjLgk0E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D39F1F00919;
	Thu,  5 Nov 2026 15:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793893253;
	bh=OIo3hYQsCto/yuloWdAN6sLtyuJFZ3yKFJq+Xz3167I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kDjLgk0EYrf1jEovTBIc6SX+U2+5m18p3YFAow/mgeO5avvTN9ESpv5JqOwxjkz/e
	 sS7gsPEWLRXDeuA6lPzND3UMmwPvTpkM7MYPJp8cN0Ix85YlxKQYOWddS0VpfS2Sk0
	 VAfl3h6f5ug6ZDxcTiFvfQSjgE6ZJHpBZWNsL6Ht/vzJYFM9WcISfdLbNz6jQIl+yW
	 Kw9GwtxsouhPEJDJjsp+DkRmVirG1R6pY3ndH+3Ods056+c5WwLVRg7jFq/p3ICB5x
	 CXV4bJGMZnxo2tWFMYlBfuV4z2TgXRFTSI0K4MHSSq5NpnNY2+a7JBdA0gZUYNddrV
	 JYZSQpTv2BQEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] xfs: always report scrub errors in tracepoints
Date: Thu,  5 Nov 2026 10:40:51 -0500
Message-ID: <20261105154031.1980828-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110410-unstopped-oncoming-1919@gregkh>
References: <2026110410-unstopped-oncoming-1919@gregkh>
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

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 1ccc8f553d885d49c1bfe141ea1f331511940b3a ]

LOLLM complains that the error processing functions in scrub will
sometimes zero out *error before recording a tracepoint.  This makes
diagnosing problems harder, so let's fix that.

Cc: stable@vger.kernel.org # v4.15
Fixes: 4700d22980d459 ("xfs: create helpers to record and deal with scrub problems")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Replaced cur->bc_ops->type == XFS_BTREE_TYPE_INODE with cur->bc_flags & XFS_BTREE_ROOT_IN_INODE. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/btree.c   | 8 +++++++-
 fs/xfs/scrub/common.c  | 7 +++++--
 fs/xfs/scrub/dabtree.c | 6 +++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/btree.c b/fs/xfs/scrub/btree.c
index eb4e49b8b8479..9e9aeec3b202f 100644
--- a/fs/xfs/scrub/btree.c
+++ b/fs/xfs/scrub/btree.c
@@ -45,8 +45,14 @@ __xchk_btree_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
+		if (cur->bc_flags & XFS_BTREE_ROOT_IN_INODE)
+			trace_xchk_ifork_btree_op_error(sc, cur, level,
+					*error, ret_ip);
+		else
+			trace_xchk_btree_op_error(sc, cur, level,
+					*error, ret_ip);
 		*error = 0;
-		fallthrough;
+		break;
 	default:
 		if (cur->bc_flags & XFS_BTREE_ROOT_IN_INODE)
 			trace_xchk_ifork_btree_op_error(sc, cur, level,
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 96d5806637300..bbc9cc2d3e2b2 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -84,8 +84,9 @@ __xchk_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
+		trace_xchk_op_error(sc, agno, bno, *error, ret_ip);
 		*error = 0;
-		fallthrough;
+		break;
 	default:
 		trace_xchk_op_error(sc, agno, bno, *error,
 				ret_ip);
@@ -139,8 +140,10 @@ __xchk_fblock_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
+		trace_xchk_file_op_error(sc, whichfork, offset, *error,
+				ret_ip);
 		*error = 0;
-		fallthrough;
+		break;
 	default:
 		trace_xchk_file_op_error(sc, whichfork, offset, *error,
 				ret_ip);
diff --git a/fs/xfs/scrub/dabtree.c b/fs/xfs/scrub/dabtree.c
index ff34b3e4f3ef0..bbb45c008778d 100644
--- a/fs/xfs/scrub/dabtree.c
+++ b/fs/xfs/scrub/dabtree.c
@@ -48,8 +48,12 @@ xchk_da_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= XFS_SCRUB_OFLAG_CORRUPT;
+		trace_xchk_file_op_error(sc, ds->dargs.whichfork,
+				xfs_dir2_da_to_db(ds->dargs.geo,
+					ds->state->path.blk[level].blkno),
+				*error, __return_address);
 		*error = 0;
-		fallthrough;
+		break;
 	default:
 		trace_xchk_file_op_error(sc, ds->dargs.whichfork,
 				xfs_dir2_da_to_db(ds->dargs.geo,
-- 
2.53.0

