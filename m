Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273596;
	b=y/U+W1DsG+hL8tNufVKg/nXzswpxqHKGcLYkKlH+K4v7iKvu0lfhA4aUcdEwy7mpAwey
	 kWCGiDgP/NMQn+KhTPXFBDYTFynPVIKNy76cBaVv4zWG/fCFbVF6qid+I7otjdm1zZ/kF
	 Cb2el2dKga+JZ2X1kjNF8jSuF5aMbHYTO3r1pgKQf+pCerZ9+2H2+RzZLeEmhTqRujQO3
	 nesY3TQIThP8pdCksIeXVvGRgse+tzwwFBztfz4NHjQ5oessLJ8FJXmhwXQ1LSP9Uf4jW
	 ioQ5ykpaxCn3R4Dm7gB4RcoBWAco1cIO77aHPoxyX+7mAlDJJ8xsmMFmB3qw47unBnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xxNMyIkfReHDuMAGErht38PFYUxaFvqUxriIzqJlCjg=;
	b=TxouU6ac783VibDmNr4AUnMspBs/CqXEhJKAvLH38Vgnn0QNT+2SmxudTmrWxuX8A46o
	 pKABjyOYmLdLjjA8n9zm0hZ3kWX1SQ1OX4g1xt++8qcTTkdSaZCt5rfQIFLo2F/F7MBi2
	 9mygywoQEvJ3+i8/fyvgsswQ0c63tX5O5S8knXETKbt7r0Ckrm4AXiq1UGdcCL29tVa8W
	 4zciXP0s8vzVP2MBRpb5ZSpORvJN2bZPldN9JhjlEwxy+IloLej2Ph2hmxZkw8X6fVitA
	 /2038FUdkGOALpE4Nz96r15yxeDjv5MJvVVznLl1r0lc+e7DQ3UtxSIZ53o0YXEPxMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjMW5hjs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FC0606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjMW5hjs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 388DE1F0089F;
	Tue, 10 Nov 2026 01:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273595;
	bh=xxNMyIkfReHDuMAGErht38PFYUxaFvqUxriIzqJlCjg=;
	h=From:To:Cc:Subject:Date;
	b=FjMW5hjsHXTKaIek5ZVcnSpaimRYO0J5H/vChcChDQERqMv333zA+dDRTy4T0Ggqv
	 zhiC/Hud7V22ppf5b/kLKEHVVG6IbmSXeV5TEDMUi5v8A6KcnouB84SQXP29XxfuvR
	 +CfMFYqZtw30s9ryKGYqk8hYLONteIAtOifpz4yMilfeucJI8X9RafWDrZPFs9QxFK
	 RtHwu/OQ2wQLFQ0g+tFXF6/RCQdPGSZNMunrzuRYENWlezvEvC8fd+F4XuQX+JZujC
	 ERjdG3fuZlFwCoh2nAMd/cIi8U+o22raMMQx1PG7rd0YPZ2ohdq228/RuBi2Ek9Z6W
	 ar/ZBGj5JAm+w==
From: Sasha Levin <sashal@kernel.org>
To: matthias.goergens@gmail.com,
	jack@suse.cz
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] udf: fix preallocation discarding before an empty allocation extent" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:19:54 -0500
Message-ID: <20261109201953-failed-6.1-0c52750caaac@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0c52750caaaccee8b0e929450fe6538ec4985722
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201953-failed-6.1-0c52750caaac@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




