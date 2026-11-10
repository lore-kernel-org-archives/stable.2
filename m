Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274159;
	b=wpQ6I1ABOj0tLoafSQaqN/32Pjm7GxGxRByO5ODuPWY/sncmF8+6pREVR34AW7Mu5jUQ
	 vMeXyD1cOTTxHGe1mnJb/tq/D1VZ63VXAieWrsuxse+aWEgaeHNizxsNk+6c1nOgCtim7
	 E/7f8HbSyTXt+9dyPoEfx4GujWsNUEVpzyVBdcoMyVia+AJAansYBazlHIs7RsZ7zZwWZ
	 IiNCnPCgtpkJVStia8vkV1CS4C3fkhj2jQzUbHAAbELQ2povbxgU+6FL8WXxPJJfMu6EO
	 5xqy5PqP/yW54UWKcB/L1wZeEWqBAJN/kNd+oYETQd9daUPOO4g8D5nz/Uc9v8lt6Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274159;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YvEOZFVc5wilbicrnTCzbbbul0UTKzPV0xezc1ffnL0=;
	b=rxdX55pHSCqHUbc/FuZ6zcIa+d+lHzGUz+ap2djwv20TYEjVyWfHOiewm2itltjkj5g/
	 tK+Xi3zuNh7EveF2AfdP4hBzUa5yl7htFrtyHlWge+tQl3QgHO5SERgziXSVqgRVIvDCF
	 QMpUqst7gxIaq8/xkHPln52WB9xyf4OLb3v78eaWm6gpyCHTF+aPeABVhU6PtaIupnh07
	 PuEenjpwLUfOjrz2b/c0VeqT6liJG02UGLr/r/21sySNKUMss3bgvuY1G4UFsgMsJa1qj
	 10iHlaB4022FdFLn+DXFsxM6ncSMxZyasFfswkVXsjy8D7mnw4jdjg7juwUGvm1JnFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQYRJNnu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CD1606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VQYRJNnu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C67C1F0089F;
	Tue, 10 Nov 2026 01:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274158;
	bh=YvEOZFVc5wilbicrnTCzbbbul0UTKzPV0xezc1ffnL0=;
	h=From:To:Cc:Subject:Date;
	b=VQYRJNnuoEZrEjLS7RQFk1QFZ9MRqNZo/s8V81XfozXW1Rly21Oz/1Yhkk+LNPLAa
	 6WNg/hPNK3VSvW/dANN5HphswSSA1IHYBILJCwdehPq/SQBzEP6zXeuRhWQwn4rgPI
	 8Fnb2qfHYhxrS2JTEYn0d5Yr4HzawNhZkM/e91K3jtjoD+Ixq7U6AuQG7KV4BeUDpP
	 e3VFudyKoQqR8BJ7h3Sfyih2DJnuXoiWFSBuOrnX8iWNO8dlMO0P5a8x2sHIClRA7V
	 wPQR1HRfz/J0oiVXjaPQkA626Km7+9lfahfve7TN57TGu8YeVqSI2rQcmf6morHsAh
	 DyyzTE+PApYmQ==
From: Sasha Levin <sashal@kernel.org>
To: matthias.goergens@gmail.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: fix preallocation discarding before an empty allocation extent" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:29:17 -0500
Message-ID: <20261109202917-failed-5.10-0c52750caaac@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0c52750caaaccee8b0e929450fe6538ec4985722
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202917-failed-5.10-0c52750caaac@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0c52750caaaccee8b0e929450fe6538ec4985722 Mon Sep 17 00:00:00 2001
From: Matthias Goergens <matthias.goergens@gmail.com>
Date: Fri, 30 Oct 2026 22:05:36 +0800
Subject: [PATCH] udf: fix preallocation discarding before an empty allocation
 extent

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
---
 fs/udf/truncate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index 0990f94b85518..75151a59f0da6 100644
--- a/fs/udf/truncate.c
+++ b/fs/udf/truncate.c
@@ -124,8 +124,8 @@ void udf_discard_prealloc(struct inode *inode)
 {
 	struct extent_position epos = {};
 	struct extent_position prev_epos = {};
-	struct kernel_lb_addr eloc;
-	uint32_t elen;
+	struct kernel_lb_addr eloc, tmpeloc;
+	uint32_t elen, tmpelen;
 	uint64_t lbcount = 0;
 	int8_t etype = -1;
 	struct udf_inode_info *iinfo = UDF_I(inode);
@@ -141,7 +141,8 @@ void udf_discard_prealloc(struct inode *inode)
 
 	/* Find the last extent in the file */
 	while (1) {
-		ret = udf_next_aext(inode, &epos, &eloc, &elen, &tmpetype, 0);
+		ret = udf_next_aext(inode, &epos, &tmpeloc, &tmpelen,
+				    &tmpetype, 0);
 		if (ret < 0)
 			goto out;
 		if (ret == 0)
-- 
2.53.0




