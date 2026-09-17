Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D7568548
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789653743; cv=none; b=NeWvesGl+7xpf/Q0aAOPy6cDnF+qjeJ1tAdlzVTKYUlL7zCYv0I4TpTjTWA9bHDsX4KZT5KAiegzlkTf2nFujqvF2PySBh1o924Q15fiOIb0Jr+MHAddpUiAHU4TyDPxEd9ln8pAzVOy/DIUS9F7DxlKhfHob8FdiAvf8P47b2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789653743; c=relaxed/simple;
	bh=lRNw924Gk8Z8GQpKRCf7IljCJuY+T0bpMgQ/kniMtA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvwwEvJDiIWPP7JpsUY1hcX2YVdJHjmCSqXHn3tHW0XMlmUZuoydk+zaCsAAwtnNJjK4fOGBfbiEjYIr0XY6BQnuiy9jRDxQJq8BFjikOVC9GdroqCIB+fNBn5HMLIGBNdy9L343h1PPBdNDMwKDHL8L6ucJXhHIJadYdvwXOg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSujASnT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSujASnT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A92101F000FF;
	Thu, 17 Sep 2026 14:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789653741;
	bh=VBOjDRmr+08sC00Kh6JRgal6ditOrpjE2fJuVbVr9TE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MSujASnTHNQt2Rh1xXzs4pIYZisUq6u0voB9GN8LIr/ULweCa2XNUvTnYOM54pXhn
	 qS+kTKypkTyMwiMaVGtpIp9z1cxpieWnLOTgaGsaokKb/t/jUNBvOiEBc0FMHjer73
	 ON8fPkCPvuc1OCI3ZVGLmcT/Sbs6fCELR2NIE/rmhirdNxom/EvzcE3qMyo/bTjlDI
	 dldZ5yoDrcmWICmQhiwCtYv92QyGxV+24/Qm3TPSO26RWyQj4frGKodPufi78cZmcO
	 Bdausdu+E8833T4L4pKN+W3euhT7g+yKP3ITAVLcOdc/QhHrIPGSt2HKuny9jpg6YA
	 ZWo2NZ/Kwu+wQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: strengthen the "is cow staging" helpers in scrub
Date: Thu, 17 Sep 2026 10:02:18 -0400
Message-ID: <20260917140218.507173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091605-penknife-nuclear-b1ee@gregkh>
References: <2026091605-penknife-nuclear-b1ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit 0d43368844a75ad13561a1198a3b027940730756 ]

LOLLM pointed out a bug in both of the refcount scrub predicates that
determine if a range of blocks is marked as CoW staging in the btree.
While it compares blockcount < len, this isn't enough to determine that
the CoW staging record is at least as large as the range passed into the
helper.  Fix both of them.

Cc: stable@vger.kernel.org # v4.16
Fixes: f6d5fc21fdc713 ("xfs: cross-reference refcount btree during scrub")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ Omitted the rtrefcount.c hunk because Linux 6.12 lacks realtime refcount scrub support. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/refcount.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/refcount.c b/fs/xfs/scrub/refcount.c
index dc3a75ac26cec..4f56ae3e8c627 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -581,8 +581,12 @@ xchk_xref_is_cow_staging(
 	if (rc.rc_domain != XFS_REFC_DOMAIN_COW)
 		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
 
+	/* Can't start after bno */
+	if (rc.rc_startblock > agbno)
+		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
+
 	/* Must be at least as long as what was passed in */
-	if (rc.rc_blockcount < len)
+	if (rc.rc_startblock + rc.rc_blockcount < agbno + len)
 		xchk_btree_xref_set_corrupt(sc, sc->sa.refc_cur, 0);
 }
 
-- 
2.53.0

