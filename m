Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D541C3AE18D
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 11:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784721436; cv=none; b=o89PhcUsmRAQS7qFfFpQXQ5Ru4y1V6YWfZF4lPGN93GVqJkmsn/du06qdR3raE6fLGLIu1MVcv04jwCKgthWXzJmXjoG3tw9s1DeY44uTbPrOtBU8LLo1arj6Kvqw50ghXAZZV9syc/iyyqUIPvYSTGnzb7ELQmgcdYwtiLHU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784721436; c=relaxed/simple;
	bh=o5SCFDpw/NTrcDujAj2qriVQqa1KlBtZBiszsdGNJb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RbSsC9CuVrnCnefASNOhiOXfe+0477wbIHioUUW+4e6SUewRPlWNNcQD/D6H1Z0cLq6JJY+bVDm1qGsRqFoBkogFgl/Br8Tcy5ABXybjjeqfKX28P9YmC6WPau+iFfDU5IR2vhvdctVjtVgoZmietBj2X/mj8HQ+yY+RbF5/5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TiJjVplg; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TiJjVplg"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e08baf860so10060226a91.2
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 04:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784721434; x=1785326234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dH+C1DRbZ8d3apB1BNH1FuLGa4BaOF4ic+vVx3KCjwc=;
        b=TiJjVplg8+1zqPM/4YXxxZOnN8PUoSy7QdHoJcgzHN3ML4n74CRJK/6JMuPmLtrGZ3
         Kbwd49MwzmhH/EVwSYzRkrhUhjsB8rRjQfvl3oydddPxsvVy55yVkdyOhPgBEQuocJ3c
         P9ijoRXSB/AWChrWpDNm/U2WQFMMXnkfW32sVNPgsOS3KAs55QjmYv3NBmudGSgVxQo8
         BDTZzuJVrvdwCxS3OnhhCuMQ+ZSll7D9lsnOCFczxaKTRM9tw2zXeMXKOfrAq7d/aXCM
         +w4Sg2PWrV69U9xiiytgamwFsted6W8V46HROZKX4RJk3EmG5ENFNlmw3VEctNxMIpiw
         gIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784721434; x=1785326234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dH+C1DRbZ8d3apB1BNH1FuLGa4BaOF4ic+vVx3KCjwc=;
        b=IEIZJds8HDrf3KCNTS/Q3ZsA4Re2UOi6JecbxnWadrnMpFIgS1eXiwBV0k5UBe2Cid
         ZM0FuySWcEDs10tKw22W0lUoMTFD6zoGKb/obrH/Y8k4Kg6BObX706kN7+Kti8hKSheu
         OSezVjsZr6VwQAbTvQGW8x+DEUoBOmPoWUODI/uH+5UZ+TmmKFYJdVcpoJ6AthVFWvZG
         pICtBC4fcY99JIhXBMNkJ9cypW0Dqi2C14Ch9nXr+96FZLwEGkmah/iAsAmAuG6Kwkku
         U4NAIRloMTxh6782Va3JZFdZXzFegMYrk9VAMk1TqTSTicQueB/fKbybZccWeqL9MnAj
         xPLw==
X-Forwarded-Encrypted: i=1; AHgh+RpP5j3QVFJKubljFNCFPijPi1W4Mg6kpMgW0l+g5QGOBEyRpjhYWBBIo9Tp5cNk3J6M9dumqzU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0T0makT1RURfXuXFT28Bc1XpHjVvS15k8Uw1mc1nYpEfV2po
	B5StJui3jfrQmdOLrT4ycYk1+1UgLkgRp6O3ToOENjhOz4EMaPcT33qG
X-Gm-Gg: AR+sD11XBan9fiF+60zYRd6iNr1Q6G4RNNlM9V9iinV+Bxg1I6KnxQaQ6w0XL/W9YTk
	iYWGoZBc5qu4FSLyjG/0ZemyqFhEOv3AvWVm8jDgBqV4SAEgntj4Yv3u1wIBQaZwSF9gMyfHip6
	dh4S4ec9PkwXK0agxJ7Voq/pOzGkPqizb60j50w585JjtaWn/tdJYdZeamCV9+X5UM/7B8mzm9b
	1SzV4wOiLAjLJzbjMLBJrsPhfQhe5Bh92Jah4+FUi4FzEWA7i6kv2BXO8WOQYXLdX0/p/3JK0Sk
	/4fajVga53EkFKrM6+RK8N5z7xbIyWSVqCy79cbafKSvhNtfenJQRBwT8UFe0JMWoABB7Kzpb3k
	7WXPTWY4nLB/uTSVHL6W16iT44l1u3Iy5SoQXig1jdJFNYSgZIgjx5NIJlsQ/RV3BYY5FW4rEdD
	HgE1/p9zLy8XGFAyDvSJ/HmP+iUIDD+0Y2HEh02ujfGf1cYuO+dsyn
X-Received: by 2002:a17:903:11c3:b0:2cc:6817:d9b1 with SMTP id d9443c01a7336-2cf34a00b94mr256840395ad.41.1784721433902;
        Wed, 22 Jul 2026 04:57:13 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf8f2e6247sm13435475ad.54.2026.07.22.04.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:57:13 -0700 (PDT)
From: Sangho Lee <kudo3228@gmail.com>
To: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Sangho Lee <kudo3228@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] befs: bound B-tree descent depth
Date: Wed, 22 Jul 2026 20:57:10 +0900
Message-ID: <20260722115710.1387346-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

BeFS B-tree descent follows child and overflow offsets supplied by the
filesystem image until a leaf node is reached.  It does not compare the
number of levels traversed with the B-tree superblock's max_depth field.

A crafted directory B-tree can therefore make an empty interior root point
its overflow field back to itself.  Directory iteration remains in
befs_btree_seekleaf() indefinitely.  The same unbounded descent exists in
befs_btree_find().

Track the descent depth in both paths and reject trees that exceed their
declared maximum depth.  Also apply a 64-level absolute limit so a
corrupted max_depth value cannot itself make the bound ineffective.  A
valid B-tree in a 64-bit address space cannot require more than 64 interior
levels.

This is separate from validation of the packed key layout inside each node;
the looping image uses a structurally valid empty node and malformed graph
connectivity.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Sangho Lee <kudo3228@gmail.com>
---
 fs/befs/btree.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index aa24f1dac..f27e8c94e 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -87,6 +87,8 @@ struct befs_btree_node {
 /* local constants */
 static const befs_off_t BEFS_BT_INVAL = 0xffffffffffffffffULL;
 
+#define BEFS_BTREE_MAX_DEPTH 64
+
 /* local functions */
 static int befs_btree_seekleaf(struct super_block *sb, const befs_data_stream *ds,
 			       befs_btree_super * bt_super,
@@ -248,6 +250,7 @@ befs_btree_find(struct super_block *sb, const befs_data_stream *ds,
 	struct befs_btree_node *this_node;
 	befs_btree_super bt_super;
 	befs_off_t node_off;
+	u32 depth = 0;
 	int res;
 
 	befs_debug(sb, "---> %s Key: %s", __func__, key);
@@ -276,6 +279,12 @@ befs_btree_find(struct super_block *sb, const befs_data_stream *ds,
 	}
 
 	while (!befs_leafnode(this_node)) {
+		if (++depth > bt_super.max_depth ||
+		    depth > BEFS_BTREE_MAX_DEPTH) {
+			befs_error(sb, "B-tree depth exceeds limit");
+			goto error_alloc;
+		}
+
 		res = befs_find_key(sb, this_node, key, &node_off);
 		/* if no key set, try the overflow node */
 		if (res == BEFS_BT_OVERFLOW)
@@ -543,6 +552,7 @@ befs_btree_seekleaf(struct super_block *sb, const befs_data_stream *ds,
 		    struct befs_btree_node *this_node,
 		    befs_off_t * node_off)
 {
+	u32 depth = 0;
 
 	befs_debug(sb, "---> %s", __func__);
 
@@ -559,6 +569,11 @@ befs_btree_seekleaf(struct super_block *sb, const befs_data_stream *ds,
 	}
 
 	while (!befs_leafnode(this_node)) {
+		if (++depth > bt_super->max_depth ||
+		    depth > BEFS_BTREE_MAX_DEPTH) {
+			befs_error(sb, "B-tree depth exceeds limit");
+			goto error;
+		}
 
 		if (this_node->head.all_key_count == 0) {
 			befs_debug(sb, "%s encountered "
-- 
2.43.0
