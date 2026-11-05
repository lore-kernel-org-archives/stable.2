Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898859;
	b=JYGqzZGaxdUQG8uhIQsVXxEMV0+1M55zazPtPXwmsT0Ijow5t3vzk+vxWQNHy8tW0Xvv
	 QSnHJG7JrVzslkMA+7ifgq7lmpaXGlJEhjzjwUxoIZdeZEBCBEhzjjVyIsxpfmMcjNtvx
	 1uYC0+C/oprSvD8dZyoZgMHnenak2KSl30Fv7tKBmkQPefobWCLmCM85wdJiLXeUpsU1q
	 HsJugNiiNaifZd/L6eq31k4dg3KInVNNsovoM60ZivsLe1iHxV+DroGLMXyzQ+0GZsR6M
	 mleqWe6oQUN2utRWgPwOnHtqtHKAmpeYjn5Bbocofc2srFxPt/2Fe20epNkMI+yZLhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898859;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WRq6rtLo7VWB1ow630/TvUAEuNzpOVirbIJFKFb7H+w=;
	b=N3PTlfsEamxmJSEr6ICX0W0KUpND3n9WtzAkX5MAHi/GbO2iAe+I75i3FLbv8opXyrbO
	 Z/kWyqSfNi/x0YFTLMd9pj2+c0tveBL5UkQS1vWixi/9//RoCfjuKyRfaSQloyq74OG0J
	 LSV0Vt+6TlNhC6wameDTW8C2XOWyhlw3YF8MhfPZbBcoqv8YWyE0jWupJP4qzAWI0yeQk
	 7smw2+T+TwnrQrkjj1mim5MZNBg96p+f3Lsd+ZXAA43cj9vn7cfBjwWihVtVCMRsnkbui
	 gbXDH4/szwekDjaXz2Yjf6MBUWJR3zHHEj351M2GDZk4JBOcMTPOT7tS3AWU5cf9ivA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dns9Qii8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13870606A331
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dns9Qii8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E21F1F000C1;
	Thu,  5 Nov 2026 17:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898858;
	bh=WRq6rtLo7VWB1ow630/TvUAEuNzpOVirbIJFKFb7H+w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dns9Qii8PBq3wM09xLC8H/kDHzjqcavutQ9TzNqLInYdGChBPV1AKkDOBQLHOeUOm
	 IS37PlEN/m2esZdsB6UTHZITOFtRrKCALVmBAlY5DxWOGyHd8y8pfd+f3VJLn0u3Jt
	 99K6qKqSNdXs2o8dOnd98v3L5Wm42571vxphGlbq9/IQvrBrAW4M5HEwzDsRIhHHhO
	 HgkMUw+BiL4g2YkpWA8pK0neYodDVjNNYoQ4JdAfy4vQhWzcjEr/nUdrwLaOHPXsWZ
	 4aXQWtcAMCA1Wn1rh7h1e9qzv+SRJGOwWVYoGA+/mMyeMCHBZlU+At+nYGOjBUQDD9
	 VkRqpWQsTjDYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: always report scrub errors in tracepoints
Date: Thu,  5 Nov 2026 12:14:16 -0500
Message-ID: <20261105171321.2091272-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-thermal-harmonica-3028@gregkh>
References: <2026110457-thermal-harmonica-3028@gregkh>
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
[ sashal: Replaced cur->bc_ops->type == XFS_BTREE_TYPE_INODE with cur->bc_flags & XFS_BTREE_ROOT_IN_INODE for btree classification. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/btree.c   | 8 +++++++-
 fs/xfs/scrub/common.c  | 7 +++++--
 fs/xfs/scrub/dabtree.c | 6 +++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/btree.c b/fs/xfs/scrub/btree.c
index 0175c0b33efac..56fb120baff68 100644
--- a/fs/xfs/scrub/btree.c
+++ b/fs/xfs/scrub/btree.c
@@ -44,8 +44,14 @@ __xchk_btree_process_error(
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
-		/* fall through */
+		break;
 	default:
 		if (cur->bc_flags & XFS_BTREE_ROOT_IN_INODE)
 			trace_xchk_ifork_btree_op_error(sc, cur, level,
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 1fd24e68e13d8..502adf169ce43 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -82,8 +82,9 @@ __xchk_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
+		trace_xchk_op_error(sc, agno, bno, *error, ret_ip);
 		*error = 0;
-		/* fall through */
+		break;
 	default:
 		trace_xchk_op_error(sc, agno, bno, *error,
 				ret_ip);
@@ -137,8 +138,10 @@ __xchk_fblock_process_error(
 	case -ENODATA:
 		/* Note the badness but don't abort. */
 		sc->sm->sm_flags |= errflag;
+		trace_xchk_file_op_error(sc, whichfork, offset, *error,
+				ret_ip);
 		*error = 0;
-		/* fall through */
+		break;
 	default:
 		trace_xchk_file_op_error(sc, whichfork, offset, *error,
 				ret_ip);
diff --git a/fs/xfs/scrub/dabtree.c b/fs/xfs/scrub/dabtree.c
index 74941bad930e9..24ac38014a784 100644
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
-		/* fall through */
+		break;
 	default:
 		trace_xchk_file_op_error(sc, ds->dargs.whichfork,
 				xfs_dir2_da_to_db(ds->dargs.geo,
-- 
2.53.0

