Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794645212;
	b=1oipqdnY++lwBmVOFArAUIKMN/QfbQuOguKgD0hlo6rcFY0DTJAGsC1OFjWPzdwKRQ1B
	 Ao8M8nW6yNcBpAxa/qt25ZtKxe8vAWNKrx46VyXapwE5vGPj4O/pCSRCqMnq/vOmBiyA7
	 N8qDCOykGFQ5H6m8iRr5hCJhPMMbWeGf5nY9b153jaomWOcMDOmLu+KplVtfjI0NZcJ4g
	 bHUab3auwShF6FEYN92zMmJhAc7oZ3yI4P6VDwzPrBK0MKtpnmkMDTuW2WUW1SarIvSKz
	 rMfrYqobbQo+Winclqv/43JRljDFBk7UBkx/VdvA1urIwMefDKfo6dkodYTh8pnJwpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794645212;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QC5iG8Fvq0w0Cc03pgJd+iLfyOqr7ITsw0zOuCfILxM=;
	b=RRfcVwoPrFuRSf8U9dJAePNz8prc5C8D8PD5DHXnIU4vXzl6jlT9XhpXXlUNMxDdhWeH
	 sWyY74Pa4AOffJNpdxjj7QXAGher1eeryBlprtbkAs/ig1OZ/oKm4/Kf8LDyYP9CUZjGo
	 57CR8Q8iDpVa42Hkj2NLuHuZML+zS/RspUBluXG2XActICEzYsPlK1aFsqgSAUDYKz/sf
	 ZO7mpMKQCjNeOiRFALzjr5IQrSNuwwE1uh52ojkw/2FhS1jjExr2hbWVKKxc+KLUl9q6v
	 k6pSkq/sK2VAMtSsRhN3sal1es62/2tHTN2ftvNvEiRjrQlnZ43QYSmrEd8zDL22P1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQE6ZOBl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE1606A327
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OQE6ZOBl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37ACB1F000C4;
	Sat, 14 Nov 2026 08:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794645211;
	bh=QC5iG8Fvq0w0Cc03pgJd+iLfyOqr7ITsw0zOuCfILxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OQE6ZOBlj/42d+lQ2yJRPFOMCGU93y8TMf8J51yqwpWyul7Hbls2dojAzGDlzPqeV
	 hAFAP0wPOwnrpGeVdMVIuZMhCoLmkOsiOkGzwsvhzDUBFF1cJiwZDPFIHnrpLVJjbg
	 V7WuKFfIrcOJoyYHFblh0pGO/oGr1qgn1+x7nM28tHouy19gAUomKY1gba+ftxu3SN
	 sCnopJuGglstqWsGiuYjvLwUep+x4P3d3F54lnBRPMVlpwO6C15RN3k5l3guEYSlV5
	 h/aWv7viZ48XICGlrNwm6CKBZeblfQSbDvEbF7vk0Pwe79NbHkkHlt6+vBVnk+95LA
	 qQ05jcLL3bGPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] udf: fix preallocation discarding before an empty allocation extent
Date: Sat, 14 Nov 2026 03:33:29 -0500
Message-ID: <20261114083317.3274309-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202455-failed-5.15-0c52750caaac@kernel.org>
References: <20261109202455-failed-5.15-0c52750caaac@kernel.org>
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

