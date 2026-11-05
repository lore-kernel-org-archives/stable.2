Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890956;
	b=vcvfgvYwJx6vEY1K73bjHP46m4iKTX4KJnnl8tVlcg/BiIlA9uiMuyJtjiBWk65WzADT
	 rDjkjdyqvFPRrQ9ySjs9wg5u1NMfKdiDfeU9FjyTr3pop/DbqqN9gbiJgtHZK5j28tmdp
	 Ctd++/C+Zbc07p9hka1LGTiKK2IoyFF96WoJMJsBJ1uuD+9OLl5xNWt8dGx82aeo7RsWm
	 x80JdvwiHr7wV506oACe9cQBWgUqNnT4il3YEl8dOHbDNvKvC55n84jyBxNPSMaEJBIBe
	 7AWJmwf8tzmi8B5oKay49C2+mIorpCvMQYnLCOszgBZ8h76tvUE88wwOIGDMPMf3OTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890956;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=K/D6OPh6zEEF8uETwP1HkL+ri85ZPBf1vq3WSP6Obe4=;
	b=PVfgzR1rYMg02IByYM3gQejlvI7Q3VmIzP2DITOHzkXGG8l5j97kksgQ9GYpuFifbbx3
	 O/ijLiWNLMQp4z8F9vZ5r9L0LFguEiYk/sqaP1jOeSdqdqOVzG/HwqSC0Jxb2NrVuQXZu
	 d9DIVSJvBtfaSHCPSE/cv/RAZxiRCHEql1SIzMSAMyeu8CRLHOindtzJkrAvSHNUYiDl5
	 SfbAHeiciTQlc6Y4maVriR3lOoPNcH8EN4k48C9OchskmWYb4txHiv39xVcaLJn6rcDRJ
	 6tuUQbptpHTzQyCGt3aE7KDXBV9Lbgt33ZYMQ+N2aqLwAwgU1ibeOpLSPoar33gBdDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hh6tkqUF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549EB606EEB7
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 15:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hh6tkqUF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FF3A1F00A1D;
	Thu,  5 Nov 2026 15:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793890956;
	bh=K/D6OPh6zEEF8uETwP1HkL+ri85ZPBf1vq3WSP6Obe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hh6tkqUFuC5CkiUBYhleVsxozkfE8V6rpyTR7yYAvlqa5M7e5NNQfKJosJiavivV+
	 E0iaT0sRfG0jDjYCaBTvk4fwiBreguQ/98yOEk+DrFNopWSf0qHoZm9wRsmoizI7g8
	 Xnw5d2is15cFtddmFLDYQbhgqhQ0al5eCW0EvsmzRuu+EUEhxr2v4vaOK+QXJDHv4j
	 IuwJR86cWYOiYeWzk9eQRaYSEnTGlqCzxzsq2yWEn+ebcIxp+WlTnw/O/yr/T0k75f
	 yVzFJG17kTOAemJYM3vgV5+T1XezwQUel42AfvVmTKFd6HrR7Ui4PvFTZSMKa48w0F
	 deCfosqztUERg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] xfs: always report scrub errors in tracepoints
Date: Thu,  5 Nov 2026 10:02:34 -0500
Message-ID: <20261105150120.1843288-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-clay-heroics-73a0@gregkh>
References: <2026110408-clay-heroics-73a0@gregkh>
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
[ sashal: replaced cur->bc_ops->type == XFS_BTREE_TYPE_INODE with a cur->bc_flags & XFS_BTREE_ROOT_IN_INODE test ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/btree.c   | 8 +++++++-
 fs/xfs/scrub/common.c  | 7 +++++--
 fs/xfs/scrub/dabtree.c | 6 +++++-
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/scrub/btree.c b/fs/xfs/scrub/btree.c
index 5403ef11a21c2..bfd1dd4af9c74 100644
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
index 23de5443a12a6..b0b124943b79f 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -86,8 +86,9 @@ __xchk_process_error(
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
@@ -141,8 +142,10 @@ __xchk_fblock_process_error(
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
index 1cfdba5b7f831..3b9655b3df426 100644
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

