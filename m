Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BFE9255F52
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 19:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935441; cv=none; b=NfHoBll22dllfQiXt+gSU4JgVMc88ElaowT8CSerJnMVB354GlmCJTvPG7AIqMG40sLZ9RwSff3KsZc4cHZY4DG+XRmwbvM+5hzFdk+uVSVe3jEM/OqApjBAUOzsd+rbLdr8669KF9SWVThHHsDH0CcJfcm6fUDni1KBa9ig+Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935441; c=relaxed/simple;
	bh=fWa4HjFWAahMApekl+EC+5tquAvlfiR4xFR3s7DFxik=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RkXYva20JTv6uq/vBHg/0r5pX4E3Je3QOM051nhbFYSM2t6eZZennp59r1wdVQTGUUjzLv7d5RAkTBLngJAEcpVn3aI1NuAJD7/n7ATLfCJf0T7LQXaCEtNcDQekn2pH/zeiT3FfJyizuza0GZI2xULB5AwzNMi3MzwIqL04E7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e5G87x5c; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5G87x5c"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ca7aaa4b85so6745075ad.3
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 12:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782935440; x=1783540240; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LucnURSXGg/lFz+00tvF3tHa/rk2b5opxgrW9ta7fkQ=;
        b=e5G87x5cD463/ZHT5KG8RR5DOVrYSLL5kXkwuch/PjeWv8Xzylxgvu1JnBAmfkZEwY
         4hqt8njIplGvkWU5JVCgWxKXUvs1HW8ftEbOftnaxPIDIdU0DSpqz9fSUjo1WVcqfBV8
         5v4Oui8RtRZAoWFG2R1SNM35+z/4cHgt1Z38rBw1ShGJi/aHMNZWop92hXUdWIde1MMF
         nQpKMDaS4gnY+VfQRRYqvwy6LNBqk5OcqbYRGaSvtyfcITD0Fq3lAwMjlLpmEf0Y0IYV
         xS56s6TIp7qD5MMzhG1LZebUA+v0GOMxbJnNU/8iQaEGKpGCFRLacGPFfn96pKkzjp21
         Chzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782935440; x=1783540240;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LucnURSXGg/lFz+00tvF3tHa/rk2b5opxgrW9ta7fkQ=;
        b=X5nJ72NxS3G7QRoq4Xpv42ffTKdOgJ13J6mZmanz9plz+Kc4vetDd5qw+1tAknZNLS
         hT8qPAc8SDSDVUZbOM0gpVQ5oO5qw0oNRLCnOoOaXGNAbGK1Ru5QIBiyouuEIHkxmEeq
         ZYUJ9n/i71C8morOjmT9w583tg5ejDXp3feVNxNqcVnNlZreNpCPrPuhSUggqkqbfJ8D
         6eMUcgsQ5v1BasFTwhPXoYz3Zq9xN7r/tXyoSgWJk91pPx0v0EPet9UdxRuu7PuCw4YU
         trV9hY4DN08jDpvpAO8X/S+Q9xbHiZA8zAQZ5isIRNBTrj4vUmuxA88gV76KvjNotQtg
         3x2w==
X-Forwarded-Encrypted: i=1; AHgh+RrOZt8O/rAaWe7c9YoAyyDdjtGCkQhUBCEX4HdW/gPtDDkfDt9fR5XZ7PcDjb6NyOEMVG2L2tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwanfV3Qg7WJX5Xc8UzukqzxNNsP5dGUwzy67sVqB/WDar52RRN
	dQScFrgDYYFKfc6sVOSMN04WNhMtI0+9LrLZgWb3ToMJUA00Dm1SmW3X
X-Gm-Gg: AfdE7clRjMK5rO0GJtdzBPrf9VvcBuIlDeX85AMCa/D/LDISdl9DE9/fcJ3ZYJ1WIWH
	oP4mpNF7SLAf1R/pZGEFTFZm/IAO8GZ2yhkB2TDJqUw3ROQHb9t+QxERX06i7WAzIbPEwaflB4C
	pTHbXc4toQbUiLQ4z9c382aUrCqOwyq1vg08wk9Igh2VcXqwaSxR6Xh0WsuYKH3RdL3Hdutw01u
	uMhLlqrbs48WXFceX/OnjCuLlh1uY4qgJbZC0WClW/RFFYqnq+xQFHwDNh27Nn1NLmW40w7wzKH
	pS4rxSYPwaA1SNXg0g44ALgkyJfUNVN83G2+iTlvbrDow/JK+i2Lvrb5VnPBQqDPs87bYHtLBao
	cmBZ7dy9SPLDYQjttCwtAjcLhHfzq9iQQNyX4G1Xo7fIJJDCoHI0OMAc/eIKBKTJJKEYcEuhyYo
	WMd5IB1260xE7uO6bk8AWRqaS/aZAjyVy79mMuJkhXO+w98oD0NxyOJw2F9AXZs8M=
X-Received: by 2002:a17:90b:578e:b0:37f:a915:1c29 with SMTP id 98e67ed59e1d1-380ba8d66d1mr2213858a91.19.1782935439342;
        Wed, 01 Jul 2026 12:50:39 -0700 (PDT)
Received: from DESKTOP-L3Q0GIV.localdomain ([203.230.195.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380ce0cb40dsm404245a91.13.2026.07.01.12.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 12:50:38 -0700 (PDT)
From: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>
To: Luis de Bethencourt <luisbg@kernel.org>,
	Salah Triki <salah.triki@gmail.com>
Cc: =?UTF-8?q?=EC=9D=B4=EC=83=81=ED=98=B8?= <kudo3228@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] befs: validate B-tree node layout before use
Date: Thu,  2 Jul 2026 04:50:35 +0900
Message-ID: <20260701195035.817400-1-kudo3228@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BeFS directory B-trees store several variable-sized regions inside each
on-disk B-tree node: the node header, packed key bytes, a key-length index,
and the value array.  The current reader byte-swaps all_key_count and
all_key_length from disk and then lets helpers derive pointers to the
key-length index and value array from those fields.

That means a malformed filesystem image can describe a layout that does not
fit in the buffer_head data that was actually read from disk.  In
particular, an oversized all_key_length or all_key_count can move the
key-length index or value array beyond the loaded node block.  Directory
iteration then follows those derived pointers and can read outside the node
buffer.  The local reproducer triggers KASAN reports in befs_bt_get_key()
and befs_btree_read().

The B-tree node parser should reject such images at the boundary where the
disk format is first converted into the in-memory node representation.  Add
a node-layout validator immediately after reading and byte-swapping the
node header, before later helpers can use the untrusted counts and lengths.
The validator checks that:

  - the node header fits in the bytes remaining in the block;
  - the packed key data fits after the header;
  - the aligned key-length index fits after the key data;
  - the value array fits after the key-length index; and
  - every key end offset is monotonic and remains within all_key_length.

Rejecting the malformed node at read time keeps the existing BeFS error
path and turns the crafted image into a mount/readdir failure instead of an
out-of-bounds read.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: 이상호 <kudo3228@gmail.com>
---
Reproducer image and serial logs are available on maintainer request. They
are not included in this public patch email.

 fs/befs/btree.c |   83 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 83 insertions(+)

diff --git a/fs/befs/btree.c b/fs/befs/btree.c
index aa24f1daccdd..c5fc529f0069 100644
--- a/fs/befs/btree.c
+++ b/fs/befs/btree.c
@@ -100,6 +100,10 @@ static int befs_bt_read_node(struct super_block *sb, const befs_data_stream *ds,
 			     struct befs_btree_node *node,
 			     befs_off_t node_off);
 
+static int befs_bt_validate_node(struct super_block *sb,
+				 struct befs_btree_node *node,
+				 size_t bytes);
+
 static int befs_leafnode(struct befs_btree_node *node);
 
 static fs16 *befs_bt_keylen_index(struct befs_btree_node *node);
@@ -192,6 +196,7 @@ befs_bt_read_node(struct super_block *sb, const befs_data_stream *ds,
 		  struct befs_btree_node *node, befs_off_t node_off)
 {
 	uint off = 0;
+	size_t bytes;
 
 	befs_debug(sb, "---> %s", __func__);
 
@@ -206,6 +211,14 @@ befs_bt_read_node(struct super_block *sb, const befs_data_stream *ds,
 
 		return BEFS_ERR;
 	}
+	if (off >= BEFS_SB(sb)->block_size) {
+		befs_error(sb, "%s node offset %u is outside block", __func__,
+			   off);
+		brelse(node->bh);
+		node->bh = NULL;
+		return BEFS_ERR;
+	}
+	bytes = BEFS_SB(sb)->block_size - off;
 	node->od_node =
 	    (befs_btree_nodehead *) ((void *) node->bh->b_data + off);
 
@@ -218,11 +231,81 @@ befs_bt_read_node(struct super_block *sb, const befs_data_stream *ds,
 	    fs16_to_cpu(sb, node->od_node->all_key_count);
 	node->head.all_key_length =
 	    fs16_to_cpu(sb, node->od_node->all_key_length);
+	if (befs_bt_validate_node(sb, node, bytes) != BEFS_OK) {
+		brelse(node->bh);
+		node->bh = NULL;
+		return BEFS_ERR;
+	}
 
 	befs_debug(sb, "<--- %s", __func__);
 	return BEFS_OK;
 }
 
+static int
+befs_bt_validate_node(struct super_block *sb, struct befs_btree_node *node,
+		      size_t bytes)
+{
+	fs16 *keylen_index;
+	size_t keydata_end;
+	size_t keylen_index_off;
+	size_t keylen_index_size;
+	size_t valarray_off;
+	size_t valarray_size;
+	u16 prev_key_end = 0;
+	int i;
+
+	if (bytes < sizeof(befs_btree_nodehead)) {
+		befs_error(sb, "B-tree node is too small: %zu", bytes);
+		return BEFS_ERR;
+	}
+
+	if (node->head.all_key_length >
+	    bytes - sizeof(befs_btree_nodehead)) {
+		befs_error(sb, "B-tree node key data is too large: %u",
+			   node->head.all_key_length);
+		return BEFS_ERR;
+	}
+
+	keydata_end = sizeof(befs_btree_nodehead) +
+		      node->head.all_key_length;
+	keylen_index_off = (keydata_end + 7) & ~7UL;
+	keylen_index_size = node->head.all_key_count * sizeof(fs16);
+	if (keylen_index_off > bytes ||
+	    keylen_index_size > bytes - keylen_index_off) {
+		befs_error(sb, "B-tree node key index is too large: %u keys",
+			   node->head.all_key_count);
+		return BEFS_ERR;
+	}
+
+	valarray_off = keylen_index_off + keylen_index_size;
+	valarray_size = node->head.all_key_count * sizeof(fs64);
+	if (valarray_size > bytes - valarray_off) {
+		befs_error(sb, "B-tree node value array is too large: %u keys",
+			   node->head.all_key_count);
+		return BEFS_ERR;
+	}
+
+	keylen_index = befs_bt_keylen_index(node);
+	for (i = 0; i < node->head.all_key_count; i++) {
+		u16 key_end = fs16_to_cpu(sb, keylen_index[i]);
+
+		if (key_end < prev_key_end ||
+		    key_end > node->head.all_key_length) {
+			befs_error(sb, "B-tree node has invalid key offset");
+			return BEFS_ERR;
+		}
+		prev_key_end = key_end;
+	}
+
+	if (node->head.all_key_count &&
+	    prev_key_end != node->head.all_key_length) {
+		befs_error(sb, "B-tree node key length mismatch");
+		return BEFS_ERR;
+	}
+
+	return BEFS_OK;
+}
+
 /**
  * befs_btree_find - Find a key in a befs B+tree
  * @sb: Filesystem superblock
-- 
2.43.0
