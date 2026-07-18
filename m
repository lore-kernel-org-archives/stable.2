Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2900487BE
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 01:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784338420; cv=none; b=U7s+/3+P2ujD61Lwi+eESsc8xtaIv0MOYaBOrHMex/T33vbFOhjmjlzsFG8WviHRXvMqDBQAiT+i9ur+N/LWL9Me52T+mLKjZ6/7cS7vT/FFf9Q6xxNTalqutcaH+f/Yomgkin6K15fu/t2j8pcAJs1NF+TtT+d38Z7YBfwFEBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784338420; c=relaxed/simple;
	bh=ZQtPGBhTJ3pZ6TQobSuDp+peF8fid+spbbSCrr1KuNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ws+mwUFliNGvSK7MjFBp0/uaeLkd0yiHdByG/pKqVAzS9Fj9XueluHos9VzIKn4DiQcgfOCTQL+tDGPi+APho+4zBE7rdiOcnIUv9fwDRm0Ca9P6hAgYac535IBfyTITO9Pnva+/fRJGxQNZ00JMKevsGiot6VmbXqUFdloKHrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0zJoev8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0zJoev8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8EC81F00A3A;
	Sat, 18 Jul 2026 01:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784338418;
	bh=H0Ek5Agqzv72cLzL5gEqJGWM8LWp26YdrwIFNkOeqx0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K0zJoev8qyhr7R2898Rl9A3JRPhcXdEd3EOUQDrsMkXI8Yj2K+GosUVH98iG9SYNo
	 Q+UQVhHLD/NHXG9FgYlSRkIiXtLwn+bg0JSXh1hTr3dImrF6L4Fbaz1ptE9x4ZWzZL
	 pCFi9AsTtHS07/SE3gTXZvFMpsSDp2SoFFIe12e+v8eGz461KuNpjqKTct0X4EWYJP
	 gb1ikg0CERao+2g7FYzbJ5+wc9Eipc6LHEAQokel3t6TiV+aqinaE5Qwl8BMCsQ1o3
	 tt0T578wsX2yzQgF2GZswdHndnEqu5jNUqf5u9u0SMkqzcGd0dQVDZfJmptlS27igz
	 twUiw2iI+VFYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <dchinner@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] xfs: Remove dead code
Date: Fri, 17 Jul 2026 21:33:34 -0400
Message-ID: <20260718013335.2621394-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718013335.2621394-1-sashal@kernel.org>
References: <2026071429-showdown-footpad-d6da@gregkh>
 <20260718013335.2621394-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

[ Upstream commit e62c720817597f259b81f1ff004eb042293bf046 ]

Remove tht entire xlog_recover_check_summary() function, this entire
function is dead code and has been for 12 years.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Dave Chinner <david@fromorbit.com>
Stable-dep-of: cc9af5e461ea ("xfs: use null daddr for unset first bad log block")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_log_recover.c | 59 ----------------------------------------
 1 file changed, 59 deletions(-)

diff --git a/fs/xfs/xfs_log_recover.c b/fs/xfs/xfs_log_recover.c
index c8e2423a13d82b..c439afb7a7aced 100644
--- a/fs/xfs/xfs_log_recover.c
+++ b/fs/xfs/xfs_log_recover.c
@@ -39,13 +39,6 @@ STATIC int
 xlog_clear_stale_blocks(
 	struct xlog	*,
 	xfs_lsn_t);
-#if defined(DEBUG)
-STATIC void
-xlog_recover_check_summary(
-	struct xlog *);
-#else
-#define	xlog_recover_check_summary(log)
-#endif
 STATIC int
 xlog_do_recovery_pass(
         struct xlog *, xfs_daddr_t, xfs_daddr_t, int, xfs_daddr_t *);
@@ -3373,8 +3366,6 @@ xlog_do_recover(
 	}
 	mp->m_alloc_set_aside = xfs_alloc_set_aside(mp);
 
-	xlog_recover_check_summary(log);
-
 	/* Normal transactions can now occur */
 	clear_bit(XLOG_ACTIVE_RECOVERY, &log->l_opstate);
 	return 0;
@@ -3517,7 +3508,6 @@ xlog_recover_finish(
 	}
 
 	xlog_recover_process_iunlinks(log);
-	xlog_recover_check_summary(log);
 
 	/*
 	 * Recover any CoW staging blocks that are still referenced by the
@@ -3551,52 +3541,3 @@ xlog_recover_cancel(
 		xlog_recover_cancel_intents(log);
 }
 
-#if defined(DEBUG)
-/*
- * Read all of the agf and agi counters and check that they
- * are consistent with the superblock counters.
- */
-STATIC void
-xlog_recover_check_summary(
-	struct xlog		*log)
-{
-	struct xfs_mount	*mp = log->l_mp;
-	struct xfs_perag	*pag;
-	struct xfs_buf		*agfbp;
-	struct xfs_buf		*agibp;
-	xfs_agnumber_t		agno;
-	uint64_t		freeblks;
-	uint64_t		itotal;
-	uint64_t		ifree;
-	int			error;
-
-	freeblks = 0LL;
-	itotal = 0LL;
-	ifree = 0LL;
-	for_each_perag(mp, agno, pag) {
-		error = xfs_read_agf(mp, NULL, pag->pag_agno, 0, &agfbp);
-		if (error) {
-			xfs_alert(mp, "%s agf read failed agno %d error %d",
-						__func__, pag->pag_agno, error);
-		} else {
-			struct xfs_agf	*agfp = agfbp->b_addr;
-
-			freeblks += be32_to_cpu(agfp->agf_freeblks) +
-				    be32_to_cpu(agfp->agf_flcount);
-			xfs_buf_relse(agfbp);
-		}
-
-		error = xfs_read_agi(mp, NULL, pag->pag_agno, &agibp);
-		if (error) {
-			xfs_alert(mp, "%s agi read failed agno %d error %d",
-						__func__, pag->pag_agno, error);
-		} else {
-			struct xfs_agi	*agi = agibp->b_addr;
-
-			itotal += be32_to_cpu(agi->agi_count);
-			ifree += be32_to_cpu(agi->agi_freecount);
-			xfs_buf_relse(agibp);
-		}
-	}
-}
-#endif /* DEBUG */
-- 
2.53.0

