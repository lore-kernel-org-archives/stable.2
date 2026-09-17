Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562734D4881
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789670384; cv=none; b=gKruBbAehOwmvtJeQ69HNPemTim9dOfZPNMtTXLCjZbGsP3TQpsHoyv4y2QjSLQbLLczFIovaoIxHvafsDSTx90fYkjBaobSz+UjnbxRerOKm2gvu+nQV3DZEysDocJce3Q0MngCsQsoifp7ZQZfkTer/l9yZDVN3dhKrT6B/dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789670384; c=relaxed/simple;
	bh=UbR+JdWtqzr3kRqs/U+bSP8foeE4VpVkoJLBExAkNmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qe4311gvIrlooJrDRglaTJDwXIqPRxsC56xX4wndrZqdS9dSOR1SAW3z76G+yNtF4FS0h/+nim8nYWBDQNcnyjxHUCRR8sQ6SjFcm2SABldQ42rFzaDjqdOfm7RJdtdnLJANl52wcZPo0p6U+8mM1FyDb9jyI+Z/Gbs6WNuXHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YF1ieY7p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YF1ieY7p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5131F0089C;
	Thu, 17 Sep 2026 18:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789670382;
	bh=ks0B8ebo7eU0J1E+SlxWud5U+ZMoZj/yEOQzyXhN3uc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YF1ieY7pLTQoZczS9T3k/CSVC0EX7rwX1xuVMW5mSGPEdmslOcdpo++lNO6Wtaodg
	 d7BW8Rh7esc5BmNtPTJiyI2PR9luEMoIN9saYOWDSN5eWoyGIfNta/N9EncQ0hBuqR
	 WFCIePWawFig4EIHBd9ayrAtmwa38ryl+beAN2n2CTg34wdFe72VSyAVTAmzUGqvNM
	 0ozPDSz6hNUyVCexE7ygy7sLGGUrSCSK9S0muQyoquSwhHHdecf/gre+geuaodORZY
	 rI+YsBnfJZIHm0FywHN2fs2Rw4GtFEW69voiBOja+pE53JTh7O+wdox1hN1zF7Ytoz
	 O8GWKN5BOaxKw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xfs: don't stash removename operations with unknown ftype
Date: Thu, 17 Sep 2026 14:39:38 -0400
Message-ID: <20260917183939.1201122-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917183939.1201122-1-sashal@kernel.org>
References: <2026091654-contented-triceps-9bbc@gregkh>
 <20260917183939.1201122-1-sashal@kernel.org>
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
index 0cdd763250cc3..5d594085a6c1b 100644
--- a/fs/xfs/scrub/dir_repair.c
+++ b/fs/xfs/scrub/dir_repair.c
@@ -1373,9 +1373,24 @@ xrep_dir_live_update(
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

