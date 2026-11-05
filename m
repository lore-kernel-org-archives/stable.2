Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793888942;
	b=BIk7kcPJiISKAAG1zw0SpwYkM/wJHWkWVaFHYlfSquyL0r3IzMyy60ZpsYMImZcBf5Gw
	 n7tx7zcJn3iK7InvKZaFAVXADBoC85Ov4ichSDN6X1OwZTJhzdS/beYBSl7hQCdk+A5+9
	 eDoRFeWqADu8j61VRwHwly3adEZN1o++jEwvdjPDcps7r4BTBdRqqVxg+4rPeYL8F+lWq
	 o63skwvHoN9n6X2qEIxHDXMGQOlcAbKx4Nne2DBKzwyzJPIbbxFBrXTjRDKXzbLWEXqev
	 PcF2n+lP8nWS23Xa+Cmd7/NYknCWhZDfcIAi+f1F7mCRK2koJ3LeqzFtZHLI+KRCl9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793888942;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BYJjnDiMyQtxAizzmEAsbR8mV13zd17kbTnSzU8ajiI=;
	b=X9yUgnm+vVmII4GqZ8IxNgYorjzddie3hwA5QAWTav+onca7eEQYJpKvGmP9mOaJKX0o
	 NNRULcMFJ/SbGDy8FBvkjxsxD2VQkc16cYcbeqd3CZIgCyUV36fsB6/Y5DrmJVr/VRb5U
	 RG2CvPNRQFII8m7dLGRLfc3A7yrDEuacgU23DNiy0ySNwg0ePb2c0nyL68ORlaL8gS3m2
	 vBOfc9EkygOWAzXJpdYgFM7hpfptKaOOP6BMZ8xMjHntdGNixbSGUcUUGS530e94NyrBU
	 7wxx7whZTJQuFxfDFomiHbwZtH6IQnS7KtPT3IzI4DK/1bPkjG8ZaRPYi01/47uDnTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPXXkfl6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51DBA606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 14:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hPXXkfl6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448DC1F00919;
	Thu,  5 Nov 2026 14:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793888941;
	bh=BYJjnDiMyQtxAizzmEAsbR8mV13zd17kbTnSzU8ajiI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hPXXkfl6x6VDxGp/NwsREDgslP9t1sszJ3kdg2JscVvIDLD4yAmXcvgiyn3mCP5ZI
	 AMkWMOHM1ZzGg+RLAnZ07n6CKGunsIQAMyU83L4dh2nkDQH8z8JyJ85vcxXJu3F2s3
	 6o/rCNDac8Z0iJoJxuHaLDW4K+0xbLFCXbT0pYF2BA8h51d4ScjbYeJhSLQZbeofWc
	 hvlr/n+6yXcUcqaSZ1tLZdIy+y11D3hijSHwSmeeZq+9/0WNuJfFT+cWFDyBBzRKup
	 GZ/7+n2lZldh2IqPWHOJyCPp3aCwMBKNbG5PUTR6D6KuWsCbWImUq3FiLSMiFeqcHu
	 F54YBGHXUecjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] xfs: always report scrub errors in tracepoints
Date: Thu,  5 Nov 2026 09:29:00 -0500
Message-ID: <20261105142749.1661087-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110406-device-hangover-5a05@gregkh>
References: <2026110406-device-hangover-5a05@gregkh>
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
index 38e156788f96d..41945f3874c56 100644
--- a/fs/xfs/scrub/btree.c
+++ b/fs/xfs/scrub/btree.c
@@ -46,8 +46,14 @@ __xchk_btree_process_error(
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
index 36814c09bf103..ddde0d61e5d16 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -87,8 +87,9 @@ __xchk_process_error(
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
@@ -143,8 +144,10 @@ __xchk_fblock_process_error(
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
index 893c1f7431200..925858a6779b4 100644
--- a/fs/xfs/scrub/dabtree.c
+++ b/fs/xfs/scrub/dabtree.c
@@ -49,8 +49,12 @@ xchk_da_process_error(
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

