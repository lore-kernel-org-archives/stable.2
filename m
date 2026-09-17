Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927AA5A9843
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 15:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657327; cv=none; b=am7+BZoJCh3Yw5mZ2Ef3qfW6vn0zaQkMX52+nZxcK5CstO6yd4gxLHS0131hb9v1i2Y0BrFcU8OkTRJJ8BYgYBuzlGzvbUrsrgfTReP/ogT1yQ+5dk+EXr9iqwXuGqzGrV5ga/LsSQEms66kIS9ykryceCGO8IEMYdw7tPFxUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657327; c=relaxed/simple;
	bh=3xaRoYqpiRAX0cgv9UxdNlzM5hR4tjzYqFmMiXqHVWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ooXQx5Fsat2qCsyke4PtwNmerIw40thk8oNxAVhJZJ2kg4WI5vlWi+E0ONHY4o5+hH9gGIRKVnCI5d4MZw3zDAECQ/QRmVuMjGDroz8dJJWnYnOTwxFR7hj+0jIllZBIW/z4MWWpRNmNZVN2xnmjWIJkKjJAqbj7TWcvyVJlHnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwIqNmOj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwIqNmOj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9C61F0089B;
	Thu, 17 Sep 2026 15:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657308;
	bh=r8uNNVZAqdS5f+RIjZ6U4UL50ioLnyDb/YgShWymU1Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nwIqNmOjtcYOtlAWyNZCN+TdXZN/aLPhOvbVZiP4sW9B0IBbzbbSNjPBteqbMelqJ
	 PajLgLBkKUsPe1DIQByaXKWxIPbuVzUgbPTIrt93RjB8OWh3yhTgLdQzYiT0kMtUaI
	 bcET3vPyjrH3PS2kZxJ2fnba0BVdAngGBEbwuOHyLsIE8xln66KlpE4HAo1q0QOYxA
	 aDdtoqnpdgcwI70rf1jXB6B4rR5iA7lba8MRWUKMoN3TaIzSBAf3FmrJhrqeC6225n
	 kJ7TEDdKumpaOw+W473rUE9MEy4s/fEm47dYUt7Ye8GiYd5DHanCOdpZMlk/OWCAdI
	 MxAjEdVi0aD9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] xfs: fix backwards mergeability logic in refcount scrubber
Date: Thu, 17 Sep 2026 11:01:46 -0400
Message-ID: <20260917150146.671140-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091615-idealize-raging-d6b0@gregkh>
References: <2026091615-idealize-raging-d6b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Darrick J. Wong" <djwong@kernel.org>

[ Upstream commit e8b01aaafffe6b852325debdf1ef4b13ccea1cd7 ]

When we start the refcount or rtrefcount btree scanners, prev_rec is
initialized to all zeroes.  This is done so that the record mergeability
checks skip the first record because you must have two records to
compare.  Unfortunately, I got the logic backwards, so scrub has never
complained about mergeable refcountbt records.  Fix this bug that LOLLM
noticed.

Cc: stable@vger.kernel.org # v6.4
Fixes: db0502b39c21d1 ("xfs: flag refcount btree records that could be merged")
Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Assisted-by: LOLLM # finding obvious bugs
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ omitted the rtrefcount.c hunk because the file does not exist in Linux 6.12. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/scrub/refcount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/scrub/refcount.c b/fs/xfs/scrub/refcount.c
index dc3a75ac26cec..8323b15e2fb44 100644
--- a/fs/xfs/scrub/refcount.c
+++ b/fs/xfs/scrub/refcount.c
@@ -411,7 +411,7 @@ xchk_refcount_mergeable(
 	const struct xfs_refcount_irec	*r1 = &rrc->prev_rec;
 
 	/* Ignore if prev_rec is not yet initialized. */
-	if (r1->rc_blockcount > 0)
+	if (r1->rc_blockcount == 0)
 		return false;
 
 	if (r1->rc_domain != r2->rc_domain)
-- 
2.53.0

