Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794645057;
	b=eyWbQGw4GYsRH4kuMK+9c37DQXWgfXMQCtBiAdlTAbZiujDu9lKWbskhe6d8KvKbDnjF
	 BAsqFvC145jnYL3NEuB8XLTOnZoXHKqqkjm1aDmwiWucBPQv0waDEMyCagKTpvx2STIx+
	 worM9ClBI4pWqMGFUNHQ4HFiVhSu/5z3TiuCQ36J0RPQ2DHfV9qerNPwUZpo8W5gZgdOA
	 b+HvqhZDUF7HQZIJBVIOpZn0REpyDyYe3IVESX2P5m8/Ns+3REvVehW80hbfJMuQxS1mz
	 qXzeMEOQT522A8U5aKb/5uCNjD5tcbPvDaOkUTJToahjuRwyDRvjIjsV3xHAQWECAfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794645057;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2FG8PT/0cvFPfJHBL6U03hXo2VMR0zdMqUuOuoE+kyQ=;
	b=a5uomO/k30e+MUhPThPlTblQqJtDshpBTBuTxXDyP9O92l80UGiW+3rjRFK0BDNkAqCH
	 y4Wj5dbqEgGrQRRRit/awAEhk1upYAe+nH5TghII0uhUzIrE1x7cL+GmrcWyph4Y8HchU
	 ll4mey2bNnxD7LougakM91A4R20FaLJ/CWIGl4WP9YGJFwO82+PL2DAlQG75Gdr+8aAAG
	 0Xkk0ra0kWZSVnXEYASI316rCS2x+uZ2WriPomhmNcoIgyGdEXHU98Wtd5K1w5TAz/T4e
	 cVWv+F31W+K6nmQ2cU56/UE13lQZtl866c4ABD8UXwASKzVv/B7GszYNrpS4kGv5klA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTtZBVTL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A8606A331
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QTtZBVTL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980D91F000C5;
	Sat, 14 Nov 2026 08:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794645057;
	bh=2FG8PT/0cvFPfJHBL6U03hXo2VMR0zdMqUuOuoE+kyQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTtZBVTL+l1HI6z/svqbKLEWTJdBurVzwUqiUh80GgFVg8J5YZ3WwW4jbX+8zSTHf
	 bfgX4OhBiFmesQmplBKL8rE8qAKJU+VqfBDsOymWHM18NSDpw28M1iIZ7u9xGf1SFJ
	 qxPyAlr+jB7B29ROvrhE9cSdAOxNqChhM6YVnKw0VC0jD8Od8u+Dxg2AZXuxSbatXY
	 AdYVB4+VXlRs5ELjk3BF49jmX6brVEsFbwsC54QdJtUF0ih0Y8l3xAxOHnqTd166Hh
	 yant1ds2+PF7S+RpvrLGqHKv9B1eguxdezlwHjx5ITf4GLDjZ1mmLhLkhznEa8mO30
	 Xs54gGOxWcLYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] udf: fix preallocation discarding before an empty allocation extent
Date: Sat, 14 Nov 2026 03:30:55 -0500
Message-ID: <20261114083039.3267886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201953-failed-6.1-0c52750caaac@kernel.org>
References: <20261109201953-failed-6.1-0c52750caaac@kernel.org>
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
[ sashal: adapted udf_next_aext() calls to the older interface that returns the extent type directly and uses -1 to terminate iteration ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/truncate.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/udf/truncate.c b/fs/udf/truncate.c
index f0de6e106ce65..b7fca0df9a447 100644
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

