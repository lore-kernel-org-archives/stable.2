Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E062DC76A
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 11:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784373654; cv=none; b=uIIzbfrfb1Schjyl4FHDKrYdtlTAYnt08n3DMZkHgiYI2A6yNLrf6QhGNBM3sAwf9XggH4y5/AJY7PGf0WsRwMkhVGc6t5n0Lmgl5RV3L99QRQp1riKM117NQjAqA+Z3WXnzWYp5Sy0Mt/7l56QQqwg78qlnd61YqTeBJJgk1uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784373654; c=relaxed/simple;
	bh=4dd32NlKMUNNZDmzucBQOfQgu9ca5+h6DNvvOc5Yrsw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vF2pHvJqh2frRR0oADaPyaMf9XYTE6cjRNaGEkBSOCNwMunA2lezfCKun0HJF0kNE4rm89dAHHlzj8zkc4tujKknLtJXgHVprdaKKiyzrq1tKK5L3pdyFUTUioyi8tTB6L02rLGKotgi9B7R5o2X200ifb1sbgHhgqMRxzx9/LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngMTH2s0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngMTH2s0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5B61F00A3E;
	Sat, 18 Jul 2026 11:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784373651;
	bh=TxLlvH8KK3QzV6mgvfjh+2zbV3dKlEr3xR8eBkrRHQM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ngMTH2s0VeqdEpT6gPr45JvvJ1DdBmiD1eZOaWMnszEOcM0BtmBQr72xAGUW9fP00
	 AHYkIEPC2EJrlKyJtcsm+7OWfUX7UOcYiWwuCf/K9RH0LhfOl/ECtxKf7Ivitfwtql
	 tFCSxrrN56d6pcMweaXwoMUNKUhR9mzHnapmOGhe8mOuthtdNIGQR50B5NLBVmOHXf
	 cN4Trmv68GT1L1/nqH/gZefPruBJs9SEb7JSGnmEZX5Epl2KMhTLkTp5t8qmTsFqf7
	 dObWuq18rkaUfZvA21YVYRVmpgjUNXPLYapuCVHUf1yu4P5phPQnAYTODvtyTJWI2M
	 q9QKXPxp3uoUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alexey Nepomnyashih <sdl@nppct.ru>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] xfs: fix unreachable BIGTIME check in dquot flush validation
Date: Sat, 18 Jul 2026 07:20:48 -0400
Message-ID: <20260718112048.2959902-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718112048.2959902-1-sashal@kernel.org>
References: <2026071407-parmesan-cyclic-e3d5@gregkh>
 <20260718112048.2959902-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexey Nepomnyashih <sdl@nppct.ru>

[ Upstream commit 03866d130ed33ab68cc7faaf4bf2c4abef96d42e ]

The dqp->q_id == 0 check inside the XFS_DQTYPE_BIGTIME block is
unreachable because root dquots return successfully earlier. Reject root
dquots with XFS_DQTYPE_BIGTIME before that early return, preserving the
intended validation and removing the unreachable condition.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 4ea1ff3b4968 ("xfs: widen ondisk quota expiration timestamps to handle y2038+")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Alexey Nepomnyashih <sdl@nppct.ru>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Allison Henderson <achender@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_dquot.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/xfs/xfs_dquot.c b/fs/xfs/xfs_dquot.c
index 05b168a025192c..fe00ad64c3952f 100644
--- a/fs/xfs/xfs_dquot.c
+++ b/fs/xfs/xfs_dquot.c
@@ -1201,6 +1201,14 @@ xfs_qm_dqflush_check(
 	    type != XFS_DQTYPE_PROJ)
 		return __this_address;
 
+	/* bigtime flag should never be set on root dquots */
+	if (dqp->q_type & XFS_DQTYPE_BIGTIME) {
+		if (!xfs_has_bigtime(dqp->q_mount))
+			return __this_address;
+		if (dqp->q_id == 0)
+			return __this_address;
+	}
+
 	if (dqp->q_id == 0)
 		return NULL;
 
@@ -1216,14 +1224,6 @@ xfs_qm_dqflush_check(
 	    !dqp->q_rtb.timer)
 		return __this_address;
 
-	/* bigtime flag should never be set on root dquots */
-	if (dqp->q_type & XFS_DQTYPE_BIGTIME) {
-		if (!xfs_has_bigtime(dqp->q_mount))
-			return __this_address;
-		if (dqp->q_id == 0)
-			return __this_address;
-	}
-
 	return NULL;
 }
 
-- 
2.53.0

