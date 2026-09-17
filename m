Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB05649738A
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658272; cv=none; b=MTmeCRbGtGuqhVpMA56Mr0d5cRyNFOiDjrpot7OuUMJmBp6k7NAIqFqIo7Rlg6QIuF8zWjPidYiJ+j8e7kNxNfkhZyzWOQhCALQOepjua5MCr/LDA5ActH+g4eIN+0izAgfjsCWYCjlzNU5e+XjI7EwnZblWKeT6rbSHaS9HYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658272; c=relaxed/simple;
	bh=twsDDxktS7x+AhilU2r3l5AXVRpKORxM+LRZGxQ7q38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDNG3VP99861/c+76NW3vH5W88vivdJyYNpPd+jLBgKSCNNdJaheZxl5NmLiGLOZnvfNWa3tpAMkfJWA65wzWod01E9VZ8CExBEhPSeFZwLky6Vdyc/3ROIHf4vEey2YzqVCzGu8y5B2TLMHit13C9tJHF243SOCX+YSEPmUtoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fSYXKFfK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fSYXKFfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBED31F008BC;
	Thu, 17 Sep 2026 15:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658253;
	bh=EW1WeY3yMJT2TUI69N55nBh5U2fmHU33IvfDAcPPFr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fSYXKFfKVKyygCXPrixgs/lyeDh1I38dsjLqutSP0N2QiBnA9yMvAXimdWIsSuzBQ
	 NtTlO/8pHh2vcnAG/3T+ngOFCm0XnECxndpCxTu0RugdFlqECyg1CMbO1Jozv9Z7N2
	 0oh4R0/uXerXYD43PpcAOmUrZBNelYObqDdFM1XLt1L1JdrCCQu7c/ECpLmBmjkp3/
	 B5mdNfEI3H56RhvIFZ2H9ijPxOa6mqSyMaJo8KMOG8Q7WOdKk6tIPpXE/dERrDXfYu
	 08GORwcJfQMfqb5ziG06sCB9WiSh7SigrQ1dkPwhH8Vxj1TzP06RDU4L9eEdJVoIXZ
	 mE4N2lguZTxBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 9/9] xfs: don't stash removename operations with unknown ftype
Date: Thu, 17 Sep 2026 11:17:23 -0400
Message-ID: <20260917151724.693663-9-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917151724.693663-1-sashal@kernel.org>
References: <2026091651-freedom-anger-bd4d@gregkh>
 <20260917151724.693663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 865b751e75039fc07838b3200f9740256653da9a ]

LOLLM notices that the behavior of xrep_dir_replay_update changes based
on the ftype recorded in the stashed removename information.  It also
notices that the unlink iops sometimes set that ftype to FT_UNKNOWN
because the regular directory tree update code paths don't need to know
the ftype of the child.

Unfortunately, this results in incorrect link counts, which eventually
trips link count errors in later phases of xfs_scrub, or in xfs_repair.
Fix this by creating a second xfs_name with the type set correctly.

Cc: stable@vger.kernel.org # v6.10
Fixes: 8559b21a64d983 ("xfs: implement live updates for directory repairs")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/dir_repair.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/scrub/dir_repair.c b/fs/xfs/scrub/dir_repair.c
index a56eb621bd978..1c689cb6f5396 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -1375,9 +1375,24 @@ xrep_dir_live_update(
 		if (p->delta > 0)
 			error = xrep_dir_stash_createname(rd, p->name,
 					I_INO(p->ip));
-		else
-			error = xrep_dir_stash_removename(rd, p->name,
+		else {
+			/*
+			 * xfs_dentry_to_name in unlink or rename-exchange can
+			 * pass us names with ftype FT_UNKNOWN, but we really
+			 * must know the ftype of the child that is being
+			 * removed so that we can do nlink updates correctly
+			 * without holding inode references.
+			 */
+			struct xfs_name	name = {
+				.name	= p->name->name,
+				.len	= p->name->len,
+				.type	= xfs_mode_to_ftype(
+						VFS_IC(p->ip)->i_mode),
+			};
+
+			error = xrep_dir_stash_removename(rd, &name,
 					I_INO(p->ip));
+		}
 		mutex_unlock(&rd->pscan.lock);
 		if (error)
 			goto out_abort;
-- 
2.53.0

