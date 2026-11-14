Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794645360;
	b=VUA5KW5IsfEX2CwDgrd/zcyV77RfaCsTTwwQyvgBSMuHKTF+6H+3Im0MlWklzsGg60Yz
	 zOytK5inKQHM1Ay/y4e8zzqfFtE6SxT+0TtnCDdjQV641NhsUSxmR91ddqw6kkj97umCZ
	 C7oM/lFWPUNqkXIWWum6P/tVutEJ7XcBS42g709HrUysJrF9jhaZ/ZNUrBqkqLKFVIG2f
	 tMatKF4tdf5JDwWUuIIvkdecYXGLWn/SrnAwg5XXHqamxQ8LIOjiFGlalLEhGVg7nX2RC
	 /4RVvBk1YrV9p9oXMsJVv377bMy2K4zFObXu2x1fgCoz9Zneoal0bFZA2d3whDG+cWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794645360;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QC5iG8Fvq0w0Cc03pgJd+iLfyOqr7ITsw0zOuCfILxM=;
	b=2sTWE61yizn3PhWYdykZQvIuKHm4Jc2VLr2ZEEtwcdbaziq8H0hlCUJPnGwy2AfB0Loq
	 qWaaOb3973fMyIwgMg+Vk9u1gKmxWiP8h7lVW25jqWjkI/VHpGt/6km64He5dmg10IiIg
	 Uw7LMKGsFFVV3mjunYKFcWuuy95X69fjESCWJI5sKoryyRnkvb3Ft4Kr0Djf1pBwgnVwf
	 AH3jbLvtgOXru6Av4BHhfQgkRz6L0n06L//DX4oZM/Uwt1whn3yqhzQRtuFTW8VMpTxOa
	 Mmb93KfAyIYMD1VghQdauge+Zu++fK1ZfQgr1VwYeYouWdEDGgNytsBRcVaadryItwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djbsqaB3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A1606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=djbsqaB3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D1161F000C4;
	Sat, 14 Nov 2026 08:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794645359;
	bh=QC5iG8Fvq0w0Cc03pgJd+iLfyOqr7ITsw0zOuCfILxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=djbsqaB3d9IizH99oiVvRADomiMA9IMJ0uIwQDzLE6fPqWJYMY8qPs/iZobfCFEsz
	 ND9tiBdkH8e19BH6Qc0KFPfjOcZbcCQJLVHprD5SgG5jeo0OYNlwIcQI+mFlYBZXsr
	 IkcOOpXUwlzi+39SZJTI39gwt4gRHqy7sqO8PWfhZA/hpwucUbPErbeyn14PJD/mOE
	 sWaTAh6w/LCrnEyXj7gy/SI1+NL4VuOtA6obFX1Z6Pt/9T+QAMrO8FwrNcqtBABG/i
	 ifeJFrd8/SGvzbyjhNBlTUCBdAvQ+3TZof0CCKZFpUHV+w3HqufpGH7bmMFrx+rA9I
	 q5qa0pctXWaQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] udf: fix preallocation discarding before an empty allocation extent
Date: Sat, 14 Nov 2026 03:35:58 -0500
Message-ID: <20261114083541.3277688-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202917-failed-5.10-0c52750caaac@kernel.org>
References: <20261109202917-failed-5.10-0c52750caaac@kernel.org>
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

From: Matthias Goergens <matthias.goergens@gmail.com>

[ Upstream commit 0c52750caaaccee8b0e929450fe6538ec4985722 ]

udf_discard_prealloc() finds the last extent of a file by peeking at
the next one with udf_next_aext() and stopping when that returns 0.
The peek reads into eloc and elen, and the code then uses them as the
last extent.  But when udf_next_aext() returns 0 they hold no defined
value: if the extent list ends in a continuation descriptor that leads
to an empty allocation extent, they describe that continuation, i.e.
the block of the empty allocation extent, one block long.

The kernel creates such lists itself: when udf_delete_aext() removes
the only descriptor of the last allocation extent in a list, it leaves
that allocation extent empty and the continuation to it in place.

If the last extent is a preallocation, udf_discard_prealloc() deletes
it with udf_delete_aext(), which finds the following allocation extent
empty, so it also removes the continuation and frees that allocation
extent's block.  udf_discard_prealloc() then frees eloc and elen: that
block a second time, instead of the preallocated blocks.  On a space
bitmap the preallocated blocks leak and the free block count drifts.
On an unallocated space table the second free adds a second free
extent for the same block, which is later handed out twice: fsx as run
by generic/091 and generic/263 ends up with two parts of its test file
in one block and reads back bad data.

Peek into separate variables, so that eloc and elen keep the last
extent that udf_next_aext() returned with 1.

Fixes: cfe4c1b25dd6 ("udf: Fix preallocation discarding at indirect extent boundary")
Cc: stable@vger.kernel.org
Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
Link: https://patch.msgid.link/480eccd1264a4cea5226fc36ed108931b2c403fb.1793349907.git.matthias.goergens@gmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
[ sashal: adapted udf_next_aext() calls to the older API that returns the extent type directly ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/truncate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 036ebd892b852..a0b61b0dcb973 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -122,8 +122,8 @@ void udf_discard_prealloc(struct inode *inode)
 {
 	struct extent_position epos = {};
 	struct extent_position prev_epos = {};
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
+	struct kernel_lb_addr eloc, tmpeloc;
+	uint32_t elen, tmpelen;
 	uint64_t lbcount = 0;
 	int8_t etype = -1, netype;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -136,7 +136,8 @@ void udf_discard_prealloc(struct inode *inode)
 	epos.block = iinfo->i_location;
 
 	/* Find the last extent in the file */
-	while ((netype = udf_next_aext(inode, &epos, &eloc, &elen, 0)) != -1) {
+	while ((netype = udf_next_aext(inode, &epos, &tmpeloc, &tmpelen,
+				       0)) != -1) {
 		brelse(prev_epos.bh);
 		prev_epos = epos;
 		if (prev_epos.bh)
-- 
2.53.0

