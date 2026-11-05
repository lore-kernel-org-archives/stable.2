Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895830;
	b=hNbu48wMnxh4CiG0qYcf3k+JcPu6t9PFRjtOVGgSgU2pTNJmSJnfprE0wxu0NsK4d9qy
	 QI+hQC9XZ2ZG6x/jS121pAhyHj8PmF2bBXaedBdSfp+Kwe/W3I8ao5KPzah6QrkyGj2Fi
	 GUJFajvpos40OGbQwQRMZkjm1W2kFNGuwAiUoTlm6s/VBFad+UEn0cQkSz/3LxrwzL63Z
	 z+uN9lq2Cm9m8dsWVNxITuk3Wd2oPph55W6atPs7+3o6NuVMalh1O5N+JMB/YM599ND31
	 4iH0UXHWtS3KYgjoEEOPupweYPj20eSr7w6/X75vkroOldc3hQSpSorWW6ibYCCjwHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895830;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MIKYx1p/lk1lvTmD1hjqBMmMsFqC7rFK4t3KDtDw+r4=;
	b=lWJTLhCsQAekmrTEiil33xIRGm55wYnqQcq0zU69C6Ad/RNQiKDRXqFIpWuiQ0Fd9vEh
	 y114fsZpsNRXzNM3qmqy+1uheidO7UmnVk6R/7fBwFcGer6WBhOZ1VLpIR7JDjitLo8dl
	 nxFg6bcw0H3l6VFqyM+W1UU36UbEHlBiy7NvbibE9kcq8ICrKIz0Ap/A1MlfQEvY3pm34
	 dbqldZcFjfICmuZMHL3H6BAP02fl34UbMxxNR+aEROOR6D3AGpRhWJ1k8Kb/CzvSVsVcp
	 L54IIoG0f5+ZbrXmKPieGAuqnYOdmCxvisZgBiK/ILyYnaVwr+JUtgAYRBsgGuJ79bA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e0Mk9M/Q";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A0D606A331
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e0Mk9M/Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C85F1F000C1;
	Thu,  5 Nov 2026 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895830;
	bh=MIKYx1p/lk1lvTmD1hjqBMmMsFqC7rFK4t3KDtDw+r4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e0Mk9M/QF7OPYC0KfsYnsrAsbkoXODwcvbGjRZ5YfRVzxBYRfjt6KlQGogTt7Mb+x
	 t9GiQ2mWUo0Qe6uo4XSM7lvcdjiNbYZ0H5noH/DnHwWE6V51M+uqzdr5pHU26ZP2D+
	 6xi+a/LKiKwPdV6rTg4RUOcR/cfTek1HJBTiGtMm9QNjHPU57yhRjkoJu8OKKbo1Dt
	 mvlKgeP4bIxBwvl4887tGvywFRXd5fFQSrk6b7BJkaVYO2vie7XyKxK0E8o4y11GJJ
	 mJ4C7hfxyVWkbvP3nXvgwg1+2JC+oktbue/o6mUx2QcIxyXf6X06VroT1fKv8rHPnk
	 hgFqtyGyq1sjg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: don't try to repair rtsummary if the summary file isn't computed
Date: Thu,  5 Nov 2026 11:23:48 -0500
Message-ID: <20261105162314.2069209-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110435-aptly-equity-6de0@gregkh>
References: <2026110435-aptly-equity-6de0@gregkh>
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

[ Upstream commit 6e82b7641889ad0198f3bf17a5e4c6fe7aab0850 ]

LOLLM observed that we can erroneously try to repair the rtsummary file
if we've not yet computed its contents.  That results in a corrupt
summary file, so let's add a flag to track whether or not the incore
data is complete.

Cc: stable@vger.kernel.org # v6.10
Fixes: abf039e2e4afde ("xfs: online repair of realtime summaries")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: Adapted xchk_rtsum_compute() to the existing mount-based realtime bitmap APIs. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/rtsummary.c        | 9 ++++++++-
 fs/xfs/scrub/rtsummary.h        | 1 +
 fs/xfs/scrub/rtsummary_repair.c | 2 +-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index 746990ae0ec1e..942f93b1e22ed 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -201,15 +201,22 @@ xchk_rtsum_compute(
 	struct xfs_scrub	*sc)
 {
 	struct xfs_mount	*mp = sc->mp;
+	struct xchk_rtsummary	*rts = sc->buf;
 	unsigned long long	rtbmp_blocks;
+	int			error;
 
 	/* If the bitmap size doesn't match the computed size, bail. */
 	rtbmp_blocks = xfs_rtbitmap_blockcount(mp, mp->m_sb.sb_rextents);
 	if (XFS_FSB_TO_B(mp, rtbmp_blocks) != mp->m_rbmip->i_disk_size)
 		return -EFSCORRUPTED;
 
-	return xfs_rtalloc_query_all(sc->mp, sc->tp, xchk_rtsum_record_free,
+	error = xfs_rtalloc_query_all(sc->mp, sc->tp, xchk_rtsum_record_free,
 			sc);
+	if (error)
+		return error;
+
+	rts->summary_computed = true;
+	return 0;
 }
 
 /* Compare the rtsummary file against the one we computed. */
diff --git a/fs/xfs/scrub/rtsummary.h b/fs/xfs/scrub/rtsummary.h
index e44b04cb6e2d5..af1ab64c3f212 100644
--- a/fs/xfs/scrub/rtsummary.h
+++ b/fs/xfs/scrub/rtsummary.h
@@ -17,6 +17,7 @@ struct xchk_rtsummary {
 	xfs_filblks_t		rsumblocks;
 	unsigned int		rsumlevels;
 	unsigned int		resblks;
+	bool			summary_computed;
 
 	/* suminfo position of xfile as we write buffers to disk. */
 	xfs_rtsumoff_t		prep_wordoff;
diff --git a/fs/xfs/scrub/rtsummary_repair.c b/fs/xfs/scrub/rtsummary_repair.c
index 7deeb948cb702..536f0b8e3bfd0 100644
--- a/fs/xfs/scrub/rtsummary_repair.c
+++ b/fs/xfs/scrub/rtsummary_repair.c
@@ -110,7 +110,7 @@ xrep_rtsummary(
 		return -EOPNOTSUPP;
 
 	/* Walk away if we disagree on the size of the rt bitmap. */
-	if (rts->rbmblocks != mp->m_sb.sb_rbmblocks)
+	if (rts->rbmblocks != mp->m_sb.sb_rbmblocks || !rts->summary_computed)
 		return 0;
 
 	/* Make sure any problems with the fork are fixed. */
-- 
2.53.0

