Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794453659;
	b=j8ORR9+ZE67wMsBhlEFEalK8B2LdC/bKJNnYDBnio8etE76dxPAAWBRFUA5MKLqt9g6G
	 bE4Hq6LRb5Hhq7arfjvIkn/AWoi7ix3g7fLbEgG+cDAoBSuRb9SgXyZcabDlAtR3n91oH
	 RteQJuMU6FLs2eroL5Nkm8ccOOtkw5GKKZIF/cXwh7kwNng0soBYmt8e5hRDomRWANr7t
	 jez9pRpDK3XN4PJTv0VOwWjNJjJ+a1FI0zeYxmdj5cvXwLbArIFCGer1MhVfDEJFO8f/I
	 JXxq3CP+Qfs8w/bzGVw9IvFGKf3iVatWVyyJ++qOsZeB9uH+QlgxGn0hlnWifBA8Cqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794453659;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Q6wejW2kHXF+KeT50QeaUalzki4zEsBRi/sj3W859ww=;
	b=1joFF6uSpHuNMUq5mmZKniLHee7+0KxjKoceWIiZsDiLEtLGgS2olNzZg2ksqCLGr4eV
	 2Nj5tJlccyYAggxTm5N5PJH1EJnkyckygnewtSp4LTyxTGgyJwGDuRM6YnN450XOgH8h5
	 A4zIsl0QXxifJVNRXSBwWapXx35XUtXTnpsGSZcZuAYLZuSue3IfsE6+sLr41zp6n6fQi
	 6mHu4+KGfP7uFja0qAmYIsTuIojfRdR0Do1jY5dXRhET+8H3I887DxzeIRiAi0qOFGVFp
	 4WAuN4+bl0+NzkqiPkHifk976/gTEWVU70/uaIfyymH4aqI4i2XpHFw0KbV0UeFm6+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVPfYdyx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B835606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JVPfYdyx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 502EC1F00A05;
	Thu, 12 Nov 2026 03:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794453659;
	bh=Q6wejW2kHXF+KeT50QeaUalzki4zEsBRi/sj3W859ww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JVPfYdyxNfAgKA92ezXAjpgz1krbXq/7XL/8t+dbS/vGKK1LUc3hOWQNKoh5p5+Wd
	 9JZC7Ff7KpNA9UDr6MKhKNGpSluB0Qny/c/7ZseMRI17K4fXPfjSTnbEqaCzMbSbzQ
	 PlxQVI0YKBxsb1s4lj0aEjpNBC6SMtNC+MGUq0Ue00g81/thJR8BC2hFk+H1b3gb4P
	 H5OOYcWrK6wuCd+CKvnvrvw9eKZKGoi4nRYrQyNONrI/sN3gz4FWuq+fGlaZ+5bPmm
	 EuAiLRCjirDaeqLrlkA2/ZF1zPwcEiG0D5BwLiXiWuRvL7VFuHJfYjf/gIFizEqUkZ
	 PT7dwdogjX+vw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daejun Park <daejun7.park@samsung.com>,
	Dave Chinner <dgc@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] xfs: don't skip free extents of the longest length in a whole-AG FITRIM
Date: Wed, 11 Nov 2026 22:20:57 -0500
Message-ID: <20261112032035.1538841-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202617-failed-5.10-5745f4f10a1a@kernel.org>
References: <20261109202617-failed-5.10-5745f4f10a1a@kernel.org>
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

From: Daejun Park <daejun7.park@samsung.com>

[ Upstream commit 5745f4f10a1a16aa5bb020acc38afa33f2d5ff99 ]

Since commit a66d636385d6 ("xfs: fix fstrim offset calculations"), the
by-length walk of an AG in FITRIM starts with
xfs_alloc_lookup_ge(cur, 0, pagf_longest) and walks down. The lookup
lands on the longest free extent with the lowest block number. The
other free extents of that length sort after it and are never
discarded.

Start every by-length batch with xfs_alloc_lookup_le() at restart_bno.

Suggested-by: Dave Chinner <dgc@kernel.org>
Link: https://lore.kernel.org/r/ZgiJWxVcVwag0fIP@dread.disaster.area
Cc: stable@vger.kernel.org
Fixes: a66d636385d6 ("xfs: fix fstrim offset calculations")
Signed-off-by: Daejun Park <daejun7.park@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Carlos Maiolino <cem@kernel.org>
[ sashal: adapted the change to xfs_trim_extents(), using agf_longest directly instead of batched trim cursor state ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/xfs/xfs_discard.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_discard.c b/fs/xfs/xfs_discard.c
index f979d0d7e6cd6..fbb88fb3061a0 100644
--- a/fs/xfs/xfs_discard.c
+++ b/fs/xfs/xfs_discard.c
@@ -53,9 +53,10 @@ xfs_trim_extents(
 	cur = xfs_allocbt_init_cursor(mp, NULL, agbp, agno, XFS_BTNUM_CNT);
 
 	/*
-	 * Look up the longest btree in the AGF and start with it.
+	 * Start at the last record of the longest length.
 	 */
-	error = xfs_alloc_lookup_ge(cur, 0, be32_to_cpu(agf->agf_longest), &i);
+	error = xfs_alloc_lookup_le(cur, NULLAGBLOCK,
+				    be32_to_cpu(agf->agf_longest), &i);
 	if (error)
 		goto out_del_cursor;
 
-- 
2.53.0

