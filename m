Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049995;
	b=w9mQjcqSUEy4y9NZ72FmSmxmBh56QEZrjgMlnzJATArD0hSPlEA/VpIq4e3uDeUVDCA+
	 FojtYmo9vLYjwdWzJrN+Y16Zy9QUQaj53lsH38Uz36Dp9TxuVnp/cxlf3wiRMY06IYXxA
	 RpCru/Rurzfrouw5upk1iY+Z0cmJ2SQAPXLV/kY+8j1I95brtWQ3qCoInu39ABPH0CYuB
	 bWQdRItPKT2Zm3GQwsn47r8mCu1Q3QtVWQPFyDjlYIkLYipvVh88IA8aY9GvCDr4cYEBF
	 BZkmevnq/OtnrfyAQkPyPwBzuOlddwThiiEdNrYslVe2ssePNuTT2cbBHvtl9W6KVxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049995;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZqJAwttIoOoIP3yW/pxrODQxbEV48V7B4tTRHVpor0c=;
	b=YhOYHH3Iwik3PHIVzev7bgE8rbc87CV6PwR6Yi13ydR6EOHQ/5MVbLJPRaKvx5Q1EuW8
	 eulKoFlAZ8Y0MXbUByGCFsvMi4hS18D8O/CqzgRlHJMLelqEPMYJWudVkmlJw1kMwNDPu
	 cEEYxlA06Ho0pg5s1ScJ8LS/9apEnPsx9DBfLSQuI+MaEYv3+1pta4dJ7ZGGDojHo/Qah
	 CW/QFY3xSgkKyEzXldWSHU6xjKdk9rHMfPFP9X8cbArBzWCK/hsUxiwlHxqEqPsckLMQH
	 T9dOSWdGD5XUvIqOMWo4UoIDP/UFLpQm5xDqMSmoUdNr3zMqYO9cUGKMZgrbk6JVCoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yxg3XAod;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15D7606A333
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A15D7606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Yxg3XAod
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-380b40312e2so4559091eec.1
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:59:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049994; x=1795654794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZqJAwttIoOoIP3yW/pxrODQxbEV48V7B4tTRHVpor0c=;
        b=Yxg3XAodNVHnTEcTgpAXibccE8ebjBCSxFLzu6rEYMXakB8/XJ+JG3VUwoPfyrAEkw
         SQvKdgGwPB+7HUyAbikxuMo3rGncli35fd1kkLwo7p8o839hA93HLyW8dmu4mZ6sxeFf
         n0yqWN+Lx/ZarJujOJlajNmoyn0GHEsgV7BtDGpRIAspXqswMeL/A04nrVB8bEzZZSHh
         6hytkfV5+9iUkyEbwvI1mQoQ7Dqgm51RhR4e7B7KsK+Zr9h6NItPRkajYNlPGO5ly15H
         Z3um85+wx8/xZU4WrOcYGsUG9Wyvs2og+F0b03CUClIF4vPN4T8fZI/K92OOxTWrXfbd
         1pCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049994; x=1795654794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZqJAwttIoOoIP3yW/pxrODQxbEV48V7B4tTRHVpor0c=;
        b=G5/W4jdqV9agOKUPD5FBySA2BS0oosfADcCljwX4nCU1Azg/x9YBka4jL22+TFd7BN
         +S6HgaeivWFXdgQgi18LISs6wBJjByUmpMk4lumm1NnfXWiSzRyKZZDRqmlBDanR+cc5
         YH+YyVF0gflG/bGOIoJVoUMs5YlX+2SRg/etYY/OTISMEadHhfRQOWlgdPpR7duiAmB4
         kxC7zWTLP458sdhuvUTW78gvs5EXZ0F1d92S7gHcIpA+nVGGx5+kQwMid34I5bdkQmBg
         J6UpzR3aNLVlJ4fduDM8hgsmmkMuH8tmtxb1dQgNgBtxvzcqtUl2vxb4PfQo2SYn8h5g
         yCvA==
X-Forwarded-Encrypted: i=1; AL+hErG4Mwu67fupa4Gyb73jhTFiD2iDtntc81ZxZqa1vTS6qPJxpkQwvCQa/GFmukc0EFCfI2e5Mdo=@vger.kernel.org
X-Gm-Message-State: APuU4Z992b4eB2Wdk6XdacwApfSrfQ5cVVZeyB2gCwvhFKWC46xEiIf3
	+Nt3BcJy/i79vroVtuemae30CHPWq4u3mr7shTTf5Iewg7JsT9ewSZaq
X-Gm-Gg: AZFdTZcf1kltVkjiWUc5CzAnpNwJqt+dZxPQp1R7zfIwPOh+RQz9v8q/yY7zTJdb34G
	LPyaMGzirAcQLPSfbyl1ZKNtXpx7lfk+pBdVaWQq8MnURVyRNdftvvSB2fW6KnvTq5dpNCLYwNL
	rMdB5o0Dz2S4pdG6raoUMNTsEY5FIM/Juoq7QGs2Yy3HcadMa9TqTIuFDgib0yrXFoXR1nPr1Ij
	0G2euVWm2qYEBaLA3oXN9bAqAhYUq/n+dEuefDCOyZImq+GsEamc9Eyto+VyEoH2zBHqzfHXvaz
	EqwwjSfTjDUcl+UJn+hn2rchO7C/laceH51rOLHknCf9WYpuK+sg3w0o/zIGcrf3G9vqKpB+0YN
	xnH0e9aq+yipKtf1idk4K+asebSOiAioBrvyIPq2FAtlv/tZT0HWlFn04kD5CFle1bvtLr9odDT
	iwtvI20qbC33cI6y2scJGLt7Y9a1k12YtfBqyT8BZbppDPK1PAgKCvwtx2DmzGHDm8G3eh3nxN3
	raEcpjk8c09fA+OrEZ7yuslYLBRYnIQqmyGmWbRBop2LkD5VX2WMClttxazrAQ+1+9diKyyi3cF
	cTw33imPmfHtZPYrg6f9juWQG+49yY+JZQfkE92CBoRBVkV7dZsDe9ECT7ZjZtj8t3Pq7JUi303
	Kc0jP72ry5OCknqSkTyIDBAVpLcafCrZDgOq96FMFwsoltzJA
X-Received: by 2002:a05:7301:4d04:b0:381:ccd2:f6ad with SMTP id 5a478bee46e88-3828016ffefmr3845203eec.18.1795049993532;
        Wed, 18 Nov 2026 16:59:53 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:9887:3c66:c29:4859])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm13456446eec.18.2026.11.18.16.59.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 16:59:53 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v3 3/3] hfs: pass the key buffer size to hfs_bnode_read_key()
Date: Wed, 18 Nov 2026 16:59:43 -0800
Message-ID: <20261119005943.37851-4-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119005943.37851-1-ozgunkultekin@gmail.com>
References: <20261118013337.67813-1-ozgunkultekin@gmail.com>
 <20261119005943.37851-1-ozgunkultekin@gmail.com>
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

hfs_bnode_read_key() reads the key length of leaf records (and of all
records of variable-key trees) from disk and only checks it against
sizeof(hfs_btree_key). The destination is always one of the two key
buffers hfs_find_init() allocates, each tree->max_key_len + 2 bytes
long. For the extents tree max_key_len is 7, so the whole allocation is
18 bytes and a crafted leaf key writes up to 256 bytes from the image
past it. The error path clears sizeof(hfs_btree_key) bytes of the same
buffer.

hfs_brec_insert() and hfs_brec_update_parent() reach this with keys
that were never validated, the same way as in hfsplus.

Store the size of each key buffer in struct hfs_find_data as
key_buf_size in hfs_find_init(), allocate the two buffers from it, and
pass it to every hfs_bnode_read_key() call. Keys longer than the buffer
are rejected as before, and the error path clears only the buffer.

The allocation size does not change: max_key_len * 2 + 4 is now written
as HFS_FIND_KEY_BUFS * (max_key_len + HFS_KEY_LEN_MAX_SIZE), where
HFS_KEY_LEN_MAX_SIZE is the 16-bit key length of HFS_TREE_BIGKEYS
trees. Document struct hfs_find_data while adding the field.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
v3: same changes as in the hfsplus patch
v2: https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.com/
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

 fs/hfs/bfind.c |  5 +++--
 fs/hfs/bnode.c |  7 ++++---
 fs/hfs/brec.c  | 10 ++++++----
 fs/hfs/btree.h | 31 +++++++++++++++++++++++--------
 4 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index d56e47bdc..d052b613e 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -21,11 +21,12 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	fd->key_buf_size = tree->max_key_len + HFS_KEY_LEN_MAX_SIZE;
+	ptr = kzalloc(HFS_FIND_KEY_BUFS * fd->key_buf_size, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-	fd->key = ptr + tree->max_key_len + 2;
+	fd->key = ptr + fd->key_buf_size;
 	hfs_dbg("cnid %d, caller %ps\n",
 		tree->cnid, __builtin_return_address(0));
 	switch (tree->cnid) {
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index ec1b0189a..0cdc2ddf9 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 	return data;
 }
 
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_buf_size)
 {
 	struct hfs_btree *tree;
 	u32 key_len;
@@ -83,8 +84,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 1;
 
-	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfs_btree_key));
+	if (key_len > key_buf_size || key_len < 1) {
+		memset(key, 0, key_buf_size);
 		pr_err("hfs: Invalid key length: %u\n", key_len);
 		return;
 	}
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 31574e562..3d2c64c57 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 	 * at the start of the node and it is not the new node
 	 */
 	if (!rec && new_node != node) {
-		hfs_bnode_read_key(node, fd->search_key, data_off + size);
+		hfs_bnode_read_key(node, fd->search_key, data_off + size,
+				   fd->key_buf_size);
 		hfs_brec_update_parent(fd);
 	}
 
@@ -157,7 +158,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 
 		/* get index key */
 		hfs_bnode_read_key(new_node, fd->search_key,
-				   HFS_BNODE_DESC_SIZE);
+				   HFS_BNODE_DESC_SIZE, fd->key_buf_size);
 		__hfs_brec_find(fd->bnode, fd);
 
 		hfs_bnode_put(new_node);
@@ -462,7 +463,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
 		hfs_bnode_read_key(new_node, fd->search_key,
-				   HFS_BNODE_DESC_SIZE);
+				   HFS_BNODE_DESC_SIZE, fd->key_buf_size);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd);
@@ -475,7 +476,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 				goto out;
 			/* restore search_key */
 			hfs_bnode_read_key(node, fd->search_key,
-					   HFS_BNODE_DESC_SIZE);
+					   HFS_BNODE_DESC_SIZE,
+					   fd->key_buf_size);
 		}
 		new_node = NULL;
 	}
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 1f703f2c5..56de6425e 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -74,14 +74,28 @@ struct hfs_bnode {
 #define HFS_BNODE_NEW		1
 #define HFS_BNODE_DELETED	2
 
+/* hfs_find_init() allocates search_key and key as one buffer */
+#define HFS_FIND_KEY_BUFS	2
+
+/* Largest key length field: u16 in trees with HFS_TREE_BIGKEYS */
+#define HFS_KEY_LEN_MAX_SIZE	sizeof(__be16)
+
+/*
+ * State of one b-tree search. hfs_find_init() sets up the key buffers
+ * and the tree, the search functions fill in the rest.
+ */
 struct hfs_find_data {
-	btree_key *key;
-	btree_key *search_key;
-	struct hfs_btree *tree;
-	struct hfs_bnode *bnode;
-	int record;
-	int keyoffset, keylength;
-	int entryoffset, entrylength;
+	/* filled by caller */
+	btree_key *key;			/* key of the found record */
+	btree_key *search_key;		/* key to search for */
+	u32 key_buf_size;		/* size of each of search_key and key */
+	/* filled by find */
+	struct hfs_btree *tree;		/* tree being searched */
+	struct hfs_bnode *bnode;	/* node with the found record */
+	/* filled by findrec */
+	int record;			/* index of the record in bnode */
+	int keyoffset, keylength;	/* offset and length of its key */
+	int entryoffset, entrylength;	/* offset and length of its data */
 };
 
 static inline bool is_hfs_bnode_range_valid(struct hfs_find_data *fd,
@@ -117,7 +131,8 @@ extern void hfs_bmap_free(struct hfs_bnode *node);
 extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 extern u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
 extern u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
-extern void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_buf_size);
 extern void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 extern void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
 extern void hfs_bnode_write_u8(struct hfs_bnode *node, u32 off, u8 data);
-- 
2.39.5

