Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5BD28640B
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 14:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618538; cv=none; b=k1LSUSKlmMJPCVAQ13mUPVDUyzYqJKLPuNwvmZQkmNcQ44I8yw7dT63twbMboMHpUim42vohJdr2e6nQ6ejEzdiX++kSDNlQLDzqsQKkULQZEsCmcI0i/Yiyc3AD7raBXvu4hVR6vGDrGJ4NYmIvAHVtZvxiiTbEHDXirhS5s8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618538; c=relaxed/simple;
	bh=0DfsjCn9QMYaco+ZQHdWi40Bk2IuPNruDco4LXN6fW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+pA85O36d82apHoqiyV9cl+P1Wo2tZV9pkO+t7J4vTovh0ap3yDuyHARe5j7CrGPA74T74KfE/IoeflFP16PmNo6a0KnL/vVtcVKhR7gQTh3qrPUXMRcauh2r59vD/tjT7NszrU/gKk7hdQCkCCyhiUZwof3XUrxKJaPCFjytU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AtzWYf7P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AtzWYf7P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80E51F00A3D;
	Tue, 16 Jun 2026 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781618537;
	bh=SLuv/fN4WIkD2SYDV5SY6GpRx/D1oMFUUL38gIhziKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AtzWYf7Pu+qlKR0uWtQYXIj/SQFAuVn4BwkeAq1N7io9niIt8+fZfTl1gxjGJqG+2
	 srcTo9YN82Vbm+u9py8X0CcmeHd/hiwwXy+96bT/Y80IcWDSb8YR9Nbb++HqsCT6zj
	 Q2KOoh/rdSNI75DOkj308sUQeXonZ5InDrI0kO9TrCKEHj9VbbAvSiS69Ff8lQdbXz
	 IDV5rNIIwEDQ/LxFD6rqVYu/j9zJcjl2sdYxL7fKSl9vu1mRvMQDYNSRjrMOVqgyxd
	 aeo208vObyS0063EeerceQ2S1GFl95l4Uf5JaIB/2P2GEHW80nqe+zhLrEcB48i9hc
	 BRY9uiJG04d4A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yingjie Gao <gaoyingjie@uniontech.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xfs: fix error returns in CoW fork repair
Date: Tue, 16 Jun 2026 10:02:14 -0400
Message-ID: <20260616140214.3285019-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260616140214.3285019-1-sashal@kernel.org>
References: <2026061544-strife-handwork-2622@gregkh>
 <20260616140214.3285019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yingjie Gao <gaoyingjie@uniontech.com>

[ Upstream commit fcf4faba9f986b3bb528da11913c9ec5d6e8f689 ]

xrep_cow_find_bad() returns success after the cleanup labels even if
AG setup, btree queries, or bitmap updates failed. This can make
repair continue with an incomplete bad-file-offset bitmap instead of
stopping at the original error.

The force-rebuild path has a related cleanup problem. If
xrep_cow_mark_file_range() fails, the function returns directly and
skips the scrub AG context and perag cleanup.

Let the force-rebuild path fall through to the existing cleanup code
and return the saved error after cleanup.

Fixes: dbbdbd008632 ("xfs: repair problems in CoW forks")
Cc: <stable@vger.kernel.org> # v6.8
Signed-off-by: Yingjie Gao <gaoyingjie@uniontech.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/cow_repair.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/xfs/scrub/cow_repair.c b/fs/xfs/scrub/cow_repair.c
index 3524695625e338..337bdd524b0103 100644
--- a/fs/xfs/scrub/cow_repair.c
+++ b/fs/xfs/scrub/cow_repair.c
@@ -297,18 +297,15 @@ xrep_cow_find_bad(
 	 * on the debugging knob, replace everything in the CoW fork.
 	 */
 	if ((sc->sm->sm_flags & XFS_SCRUB_IFLAG_FORCE_REBUILD) ||
-	    XFS_TEST_ERROR(sc->mp, XFS_ERRTAG_FORCE_SCRUB_REPAIR)) {
+	    XFS_TEST_ERROR(sc->mp, XFS_ERRTAG_FORCE_SCRUB_REPAIR))
 		error = xrep_cow_mark_file_range(xc, xc->irec.br_startblock,
 				xc->irec.br_blockcount);
-		if (error)
-			return error;
-	}
 
 out_sa:
 	xchk_ag_free(sc, &sc->sa);
 out_pag:
 	xfs_perag_put(pag);
-	return 0;
+	return error;
 }
 
 /*
-- 
2.53.0

