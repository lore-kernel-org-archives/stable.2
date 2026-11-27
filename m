Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755268;
	b=swn84uefo90jAZY5izHOjyXXtgz9geL3SIlxwLKD38CdoQkJ/WXNvLIyqKwhEudGuKmi
	 4yL3HsrqgvPxwpTLZNEQWPUrRocdE0RobSIYSwmqKugmAAi8fS4HK5R0/KIs27enGlvcA
	 mzU1Npyl8M/3gmiq3Si6vxrjK0gctlk9aHz9/Rl9x5geEDnOzg+4LP5qb/NnvVFXoU4PV
	 WccF7XVpKoa8gW/VQTPjVfc6fHG/Ewk6iLhBIK+0nCmwfZ7D+L4gCPQWtbDuAijE1/GZS
	 kxwhnpKVI1NUplXgaQwUe9rr6fGIhEK+YeYautj0YCxoxKajavblS2YoAQmmEN4xr+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755268;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=f1+UxEIW/km1alxM/wlcBtOzyJstJbMob706JuowhSI=;
	b=TSNTBaCVeGcd0wSoP0fYWD8lHThNMWrwwPpd5+10X80c4yUJ8K/HwuXb/vP94ODlp0Gr
	 bhLxyla7DEwzM704SQlgwM+I/tcjz/WWElevet/auvXR6i4F3wLdme97jqdba0XWxgMiA
	 JNg8opc/yt89UhBTeaZPew4X2JA7R5MpsAKl8qIZpaCNrOcl4bnfAGnUme54j4ChJ6N8G
	 RbUUY9ij1TWoGrkoxnFxILLYLwVtM/sMc9J9QNTl0ftKSOdLIaFsX1NV+tr+ljhAKh6sh
	 xhSNVNaAVMPvxz2xjWrJ4U+HXgwfukTyI95U80NfHqQnon++MUbSFtBLmxbIA4vwshA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z76HcMo+;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0169606A32E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:54:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0169606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z76HcMo+
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b563e5cbc3so659102c88.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755267; x=1796360067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=f1+UxEIW/km1alxM/wlcBtOzyJstJbMob706JuowhSI=;
        b=Z76HcMo+zJlfKLBHjF6QoQwmBNogyymdEXW3vlzjkAsY4w6j1pYB+WcmnjPS0K9fAJ
         yycAIAEpKj8PuPtsFHnPT0IRx1w56s2M3FtCTc88wureBuRC8CBusXtzEB52+wNnaP9O
         U2tSfg8yw/6lkECoJG5l1ecHzDt7J3TJKDJryp4iJJvYsHhErP7DVeGHI5u+n3u81yIR
         FbF0GEzE7tEFEY7TM4h2Hsq0bA8MPg2C/nh2uGSB8tkzuE03RZFIIqbTn8ZgwLOmgltt
         2OpOYw3VwQVFrBs4EO/2JnIWy3lLv81b4AGMxYFRC2KUZ+EngNmX1/8otQ1FjAE8jjsm
         xcPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755267; x=1796360067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=f1+UxEIW/km1alxM/wlcBtOzyJstJbMob706JuowhSI=;
        b=AIj7Z7DH2GTu7u+KI17wf/oUStVnBpUiQ4jnlZdyc5X5PDUSmAi0+zCRj3M33LT/7e
         JG+yAyDMgE62F1f1JShIYc9Ibzt3Y/9ERjghcym1Hv6MDF/mGBhE/Cs2lK7CTKYZPgMw
         1mayMzKdKTNwK6xMy1T9omvLy8vd2LBE2u+Lwzclx6Wkc6ZMNNjO4KsaLmrnKwVO2+OM
         p4iglMjb4kM1Np3Ns5izCl7pccUCXx3RbK5yAgJqltCwK5pP2BQUNixvqLpLLoddfMVS
         gkGXjCUN+z8raHjUPEP/6N01Dy8cSUCewR+Wk/wakOug9Xvyg7OOCn6ZdEbUOPJYpCsU
         UFtA==
X-Forwarded-Encrypted: i=1; AL+hErH0hS7YrzYP9d+cV9qGdUN34WFKkuV/LyLajiM8MUb8qMAvuViG9sPO7VYFQyGhm4Ja8MuFB7w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Sn8Z699HGG3A+tDQABQ6bS+vOW5gQuPl3mrwuZF4bK9bk7kOY
	HoDQznDLfhi1wjBTTuXEIQWryGZCW5S44i3Txm7FRMXJgDHh2ceotZbj
X-Gm-Gg: AZFdTZcmk15U+5dYjZQyxLiZMqptTH/u8mO9tGtSCxsmK96qgOsZZa0QaU/FJrDcShU
	dF7u3vtHThZHV/58SoObqp1ijskUWea1/ED7Z7A9iR6Sy45TT9E4DL6FeOv92l+/JJpMB71kfP7
	leKObNn7ZjYAhjXOrXxpXB3URrseraIcXKMTlXv9o3Dr4Hrkk9sOwPRo0cN7XZblpBYaVIN9IME
	cVB+GAcjxp/oKCp7uGu1+LXitt5P8sduG8ClZYPHmxaqBrGKFwsty+PAzZc5rQ8DrpV5/XmVjcn
	UrRmjl17Ime9I1/ghn80llRi2hE9/AMBOpmOn4BzKCO6ylNmV4zjwKgbKJqtMFH0yVFREW9ZvwC
	0gJQiL9pVXBDQol09rUQeShrvO+iM+kwIEysfPMb2Ytxkav4yoThonvJq+rlYIw1XnMuxzmlhXA
	JotqFimJOfDqPVEPRm7LZ6NGMYp5uURgU1b9dKURTWHhJt4uHPuXf6TOgCIUnK1+jd8RGJ47Dxg
	/D8KHQaACk4UKiMDppp0ENOAeSLOHua7A9OvDG2/s9up4gkEMxEmjzgOfP0u0SgGn+PlpjPawZ9
	NOLsXNiEc/XbyDrvghMCPUGZ+bwW19CKKexyUcBKbqQUwVVSTS2DAg3x9Fn+u9TmEXI3i1pWyKF
	Ed07KN+d0NaqGtpTNYn3Xyrr5qBs=
X-Received: by 2002:a05:701a:cc93:10b0:182:d0a8:d1a9 with SMTP id a92af1059eb24-1b551f69c66mr22497447c88.0.1795755266706;
        Thu, 26 Nov 2026 20:54:26 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:c4b4:d9b:2291:1e49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm80383487c88.14.2026.11.26.20.54.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 20:54:26 -0800 (PST)
From: Ozgun Kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	Ozgun Kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v4 3/3] hfs/hfsplus: name the node descriptor size and the first record offset
Date: Thu, 26 Nov 2026 20:54:16 -0800
Message-ID: <20261127045416.1160-4-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127045416.1160-1-ozgunkultekin@gmail.com>
References: <20261119005943.37851-1-ozgunkultekin@gmail.com>
 <20261127045416.1160-1-ozgunkultekin@gmail.com>
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

Both drivers spell the size of struct hfs_bnode_desc, which is also the
offset of record 0 in a node, in several ways: the literal 14 in brec.c
and btree.c, a local node_desc_size in hfsplus hfs_bnode_split(), local
desc_size variables in hfsplus_fs.h, and sizeof(struct hfs_bnode_desc)
in bnode.c, btree.c and hfsplus/xattr.c.

Add two names next to the structure: HFS_BNODE_DESC_SIZE for the size
and HFS_BNODE_FIRST_REC_OFF for the offset of record 0, and use them
everywhere. In hfs_btree_inc_height() keep the offset of the child
pointer in a local variable and write its length as sizeof(cnid)
instead of 4. Align the conditions next to the changed lines.

No functional change.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Ozgun Kultekin <ozgunkultekin@gmail.com>
---
v4: moved to the end of the series without Cc: stable, since
    include/linux/hfs_common.h only exists since v6.19. Second name
    HFS_BNODE_FIRST_REC_OFF for offset uses, node_desc_size,
    desc_size and sizeof(struct hfs_bnode_desc) converted too, local
    cnid_off and sizeof(cnid) in hfs_btree_inc_height(), line breaks
    after "=" and condition alignment as suggested by Viacheslav.
v3: https://lore.kernel.org/all/20261119005943.37851-2-ozgunkultekin@gmail.com/
---
 fs/hfs/bnode.c             |  2 +-
 fs/hfs/brec.c              | 45 ++++++++++++++++++-------------
 fs/hfs/btree.c             |  9 ++++---
 fs/hfsplus/bnode.c         |  2 +-
 fs/hfsplus/brec.c          | 55 +++++++++++++++++++++-----------------
 fs/hfsplus/btree.c         |  9 ++++---
 fs/hfsplus/hfsplus_fs.h    |  8 +++---
 fs/hfsplus/xattr.c         |  6 ++---
 include/linux/hfs_common.h |  6 +++++
 9 files changed, 82 insertions(+), 60 deletions(-)

diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index 23ad1a565..5eb38b5a5 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -426,7 +426,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 
 	rec_off = tree->node_size - 2;
 	off = hfs_bnode_read_u16(node, rec_off);
-	if (off != sizeof(struct hfs_bnode_desc))
+	if (off != HFS_BNODE_FIRST_REC_OFF)
 		goto node_error;
 	for (i = 1; i <= node->num_recs; off = next_off, i++) {
 		rec_off -= 2;
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 84da30f65..b488cccfa 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -157,8 +157,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14,
-				   fd->key_capacity);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_FIRST_REC_OFF, fd->key_capacity);
 		__hfs_brec_find(fd->bnode, fd);
 
 		hfs_bnode_put(new_node);
@@ -282,7 +282,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		return next_node;
 	}
 
-	size = tree->node_size / 2 - node->num_recs * 2 - 14;
+	size = tree->node_size / 2 - node->num_recs * 2 - HFS_BNODE_DESC_SIZE;
 	old_rec_off = tree->node_size - 4;
 	num_recs = 1;
 	for (;;) {
@@ -312,14 +312,14 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		hfs_bnode_get(new_node);
 		fd->bnode = new_node;
 		fd->record -= num_recs;
-		fd->keyoffset -= data_start - 14;
-		fd->entryoffset -= data_start - 14;
+		fd->keyoffset -= data_start - HFS_BNODE_FIRST_REC_OFF;
+		fd->entryoffset -= data_start - HFS_BNODE_FIRST_REC_OFF;
 	}
 	new_node->num_recs = node->num_recs - num_recs;
 	node->num_recs = num_recs;
 
 	new_rec_off = tree->node_size - 2;
-	new_off = 14;
+	new_off = HFS_BNODE_FIRST_REC_OFF;
 	size = data_start - new_off;
 	num_recs = new_node->num_recs;
 	data_end = data_start;
@@ -332,7 +332,8 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		num_recs--;
 	}
 	hfs_bnode_write_u16(new_node, new_rec_off, new_off);
-	hfs_bnode_copy(new_node, 14, node, data_start, data_end - data_start);
+	hfs_bnode_copy(new_node, HFS_BNODE_FIRST_REC_OFF, node, data_start,
+		       data_end - data_start);
 
 	/* update new bnode header */
 	node_desc.next = cpu_to_be32(new_node->next);
@@ -396,7 +397,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 
 	/* size difference between old and new key */
 	if (tree->attributes & HFS_TREE_VARIDXKEYS)
-		newkeylen = (hfs_bnode_read_u8(node, 14) | 1) + 1;
+		newkeylen =
+			(hfs_bnode_read_u8(node, HFS_BNODE_FIRST_REC_OFF) | 1) + 1;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 1;
 	hfs_dbg("rec %d, keylength %d, newkeylen %d\n",
@@ -435,7 +437,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	hfs_bnode_move(parent, start_off + diff, start_off,
 		       end_off - start_off);
 skip:
-	hfs_bnode_copy(parent, fd->keyoffset, node, 14, newkeylen);
+	hfs_bnode_copy(parent, fd->keyoffset, node, HFS_BNODE_FIRST_REC_OFF,
+		       newkeylen);
 	if (!(tree->attributes & HFS_TREE_VARIDXKEYS))
 		hfs_bnode_write_u8(parent, fd->keyoffset, newkeylen - 1);
 	hfs_bnode_dump(parent);
@@ -452,8 +455,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14,
-				   fd->key_capacity);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_FIRST_REC_OFF, fd->key_capacity);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd);
@@ -465,7 +468,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14,
+			hfs_bnode_read_key(node, fd->search_key,
+					   HFS_BNODE_FIRST_REC_OFF,
 					   fd->key_capacity);
 		}
 		new_node = NULL;
@@ -483,6 +487,7 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 	struct hfs_bnode *node, *new_node;
 	struct hfs_bnode_desc node_desc;
 	int key_size, rec;
+	u32 cnid_off;
 	__be32 cnid;
 
 	node = NULL;
@@ -520,28 +525,32 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 	hfs_bnode_write(new_node, &node_desc, 0, sizeof(node_desc));
 
 	rec = tree->node_size - 2;
-	hfs_bnode_write_u16(new_node, rec, 14);
+	hfs_bnode_write_u16(new_node, rec, HFS_BNODE_FIRST_REC_OFF);
 
 	if (node) {
 		/* insert old root idx into new root */
 		node->parent = tree->root;
 		if (node->type == HFS_NODE_LEAF ||
 		    tree->attributes & HFS_TREE_VARIDXKEYS)
-			key_size = hfs_bnode_read_u8(node, 14) + 1;
+			key_size =
+				hfs_bnode_read_u8(node, HFS_BNODE_FIRST_REC_OFF) + 1;
 		else
 			key_size = tree->max_key_len + 1;
-		hfs_bnode_copy(new_node, 14, node, 14, key_size);
+		hfs_bnode_copy(new_node, HFS_BNODE_FIRST_REC_OFF,
+			       node, HFS_BNODE_FIRST_REC_OFF, key_size);
 
 		if (!(tree->attributes & HFS_TREE_VARIDXKEYS)) {
 			key_size = tree->max_key_len + 1;
-			hfs_bnode_write_u8(new_node, 14, tree->max_key_len);
+			hfs_bnode_write_u8(new_node, HFS_BNODE_FIRST_REC_OFF,
+					   tree->max_key_len);
 		}
 		key_size = (key_size + 1) & -2;
 		cnid = cpu_to_be32(node->this);
-		hfs_bnode_write(new_node, &cnid, 14 + key_size, 4);
+		cnid_off = HFS_BNODE_FIRST_REC_OFF + key_size;
+		hfs_bnode_write(new_node, &cnid, cnid_off, sizeof(cnid));
 
 		rec -= 2;
-		hfs_bnode_write_u16(new_node, rec, 14 + key_size + 4);
+		hfs_bnode_write_u16(new_node, rec, cnid_off + sizeof(cnid));
 
 		hfs_bnode_put(node);
 	}
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index 4f0ddc76e..7b1fbd524 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -229,7 +229,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id, btree_keycmp ke
 
 	/* Load the header */
 	head = (struct hfs_btree_header_rec *)(kmap_local_folio(folio, 0) +
-					       sizeof(struct hfs_bnode_desc));
+					       HFS_BNODE_FIRST_REC_OFF);
 	tree->root = be32_to_cpu(head->root);
 	tree->leaf_count = be32_to_cpu(head->leaf_count);
 	tree->leaf_head = be32_to_cpu(head->leaf_head);
@@ -340,7 +340,7 @@ void hfs_btree_write(struct hfs_btree *tree)
 	/* Load the header */
 	page = node->page[0];
 	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
-					       sizeof(struct hfs_bnode_desc));
+					       HFS_BNODE_FIRST_REC_OFF);
 
 	head->root = cpu_to_be32(tree->root);
 	head->leaf_count = cpu_to_be32(tree->leaf_count);
@@ -384,8 +384,9 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct hfs_bnode *prev, u32 idx)
 	desc.num_recs = cpu_to_be16(1);
 	desc.reserved = 0;
 	hfs_bnode_write(node, &desc, 0, sizeof(desc));
-	hfs_bnode_write_u16(node, 14, 0x8000);
-	hfs_bnode_write_u16(node, tree->node_size - 2, 14);
+	hfs_bnode_write_u16(node, HFS_BNODE_FIRST_REC_OFF, 0x8000);
+	hfs_bnode_write_u16(node, tree->node_size - 2,
+			    HFS_BNODE_FIRST_REC_OFF);
 	hfs_bnode_write_u16(node, tree->node_size - 4, tree->node_size - 6);
 
 	return node;
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 144348bdb..d91714e97 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -592,7 +592,7 @@ struct hfs_bnode *hfs_bnode_find(struct hfs_btree *tree, u32 num)
 
 	rec_off = tree->node_size - 2;
 	off = hfs_bnode_read_u16(node, rec_off);
-	if (off != sizeof(struct hfs_bnode_desc))
+	if (off != HFS_BNODE_FIRST_REC_OFF)
 		goto node_error;
 	for (i = 1; i <= node->num_recs; off = next_off, i++) {
 		rec_off -= 2;
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index c9fb6873a..c56ca7a85 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -167,8 +167,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14,
-				   fd->key_capacity);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_FIRST_REC_OFF, fd->key_capacity);
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
 
 		hfs_bnode_put(new_node);
@@ -260,7 +260,6 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 	int num_recs, new_rec_off, new_off, old_rec_off;
 	int data_start, data_end, size;
 	size_t rec_off_tbl_size;
-	size_t node_desc_size = sizeof(struct hfs_bnode_desc);
 	size_t rec_size = sizeof(__be16);
 
 	tree = fd->tree;
@@ -290,7 +289,7 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 
 	rec_off_tbl_size = node->num_recs * rec_size;
 	size = tree->node_size / 2;
-	size -= node_desc_size;
+	size -= HFS_BNODE_DESC_SIZE;
 	size -= rec_off_tbl_size;
 	old_rec_off = tree->node_size - (2 * rec_size);
 
@@ -322,14 +321,14 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		hfs_bnode_get(new_node);
 		fd->bnode = new_node;
 		fd->record -= num_recs;
-		fd->keyoffset -= data_start - node_desc_size;
-		fd->entryoffset -= data_start - node_desc_size;
+		fd->keyoffset -= data_start - HFS_BNODE_FIRST_REC_OFF;
+		fd->entryoffset -= data_start - HFS_BNODE_FIRST_REC_OFF;
 	}
 	new_node->num_recs = node->num_recs - num_recs;
 	node->num_recs = num_recs;
 
 	new_rec_off = tree->node_size - rec_size;
-	new_off = node_desc_size;
+	new_off = HFS_BNODE_FIRST_REC_OFF;
 	size = data_start - new_off;
 	num_recs = new_node->num_recs;
 	data_end = data_start;
@@ -342,8 +341,8 @@ static struct hfs_bnode *hfs_bnode_split(struct hfs_find_data *fd)
 		num_recs--;
 	}
 	hfs_bnode_write_u16(new_node, new_rec_off, new_off);
-	hfs_bnode_copy(new_node, node_desc_size,
-			node, data_start, data_end - data_start);
+	hfs_bnode_copy(new_node, HFS_BNODE_FIRST_REC_OFF,
+		       node, data_start, data_end - data_start);
 
 	/* update new bnode header */
 	node_desc.next = cpu_to_be32(new_node->next);
@@ -410,8 +409,9 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 
 	/* size difference between old and new key */
 	if ((tree->attributes & HFS_TREE_VARIDXKEYS) ||
-				(tree->cnid == HFSPLUS_ATTR_CNID))
-		newkeylen = hfs_bnode_read_u16(node, 14) + 2;
+	    (tree->cnid == HFSPLUS_ATTR_CNID))
+		newkeylen =
+			hfs_bnode_read_u16(node, HFS_BNODE_FIRST_REC_OFF) + 2;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 2;
 	hfs_dbg("rec %d, keylength %d, newkeylen %d\n",
@@ -451,7 +451,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	hfs_bnode_move(parent, start_off + diff, start_off,
 		       end_off - start_off);
 skip:
-	hfs_bnode_copy(parent, fd->keyoffset, node, 14, newkeylen);
+	hfs_bnode_copy(parent, fd->keyoffset, node, HFS_BNODE_FIRST_REC_OFF,
+		       newkeylen);
 	hfs_bnode_dump(parent);
 
 	hfs_bnode_put(node);
@@ -466,8 +467,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14,
-				   fd->key_capacity);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_FIRST_REC_OFF, fd->key_capacity);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
@@ -479,7 +480,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14,
+			hfs_bnode_read_key(node, fd->search_key,
+					   HFS_BNODE_FIRST_REC_OFF,
 					   fd->key_capacity);
 		}
 		new_node = NULL;
@@ -497,6 +499,7 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 	struct hfs_bnode *node, *new_node;
 	struct hfs_bnode_desc node_desc;
 	int key_size, rec;
+	u32 cnid_off;
 	__be32 cnid;
 
 	node = NULL;
@@ -534,29 +537,33 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 	hfs_bnode_write(new_node, &node_desc, 0, sizeof(node_desc));
 
 	rec = tree->node_size - 2;
-	hfs_bnode_write_u16(new_node, rec, 14);
+	hfs_bnode_write_u16(new_node, rec, HFS_BNODE_FIRST_REC_OFF);
 
 	if (node) {
 		/* insert old root idx into new root */
 		node->parent = tree->root;
 		if (node->type == HFS_NODE_LEAF ||
-				tree->attributes & HFS_TREE_VARIDXKEYS ||
-				tree->cnid == HFSPLUS_ATTR_CNID)
-			key_size = hfs_bnode_read_u16(node, 14) + 2;
+		    tree->attributes & HFS_TREE_VARIDXKEYS ||
+		    tree->cnid == HFSPLUS_ATTR_CNID)
+			key_size =
+				hfs_bnode_read_u16(node, HFS_BNODE_FIRST_REC_OFF) + 2;
 		else
 			key_size = tree->max_key_len + 2;
-		hfs_bnode_copy(new_node, 14, node, 14, key_size);
+		hfs_bnode_copy(new_node, HFS_BNODE_FIRST_REC_OFF,
+			       node, HFS_BNODE_FIRST_REC_OFF, key_size);
 
 		if (!(tree->attributes & HFS_TREE_VARIDXKEYS) &&
-				(tree->cnid != HFSPLUS_ATTR_CNID)) {
+		    (tree->cnid != HFSPLUS_ATTR_CNID)) {
 			key_size = tree->max_key_len + 2;
-			hfs_bnode_write_u16(new_node, 14, tree->max_key_len);
+			hfs_bnode_write_u16(new_node, HFS_BNODE_FIRST_REC_OFF,
+					    tree->max_key_len);
 		}
 		cnid = cpu_to_be32(node->this);
-		hfs_bnode_write(new_node, &cnid, 14 + key_size, 4);
+		cnid_off = HFS_BNODE_FIRST_REC_OFF + key_size;
+		hfs_bnode_write(new_node, &cnid, cnid_off, sizeof(cnid));
 
 		rec -= 2;
-		hfs_bnode_write_u16(new_node, rec, 14 + key_size + 4);
+		hfs_bnode_write_u16(new_node, rec, cnid_off + sizeof(cnid));
 
 		hfs_bnode_put(node);
 	}
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index bd4dbdbc8..b67e0b6d2 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -300,7 +300,7 @@ struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id)
 
 	/* Load the header */
 	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
-		sizeof(struct hfs_bnode_desc));
+		HFS_BNODE_FIRST_REC_OFF);
 	tree->root = be32_to_cpu(head->root);
 	tree->leaf_count = be32_to_cpu(head->leaf_count);
 	tree->leaf_head = be32_to_cpu(head->leaf_head);
@@ -448,7 +448,7 @@ int hfs_btree_write(struct hfs_btree *tree)
 	/* Load the header */
 	page = node->page[0];
 	head = (struct hfs_btree_header_rec *)(kmap_local_page(page) +
-		sizeof(struct hfs_bnode_desc));
+		HFS_BNODE_FIRST_REC_OFF);
 
 	head->root = cpu_to_be32(tree->root);
 	head->leaf_count = cpu_to_be32(tree->leaf_count);
@@ -491,8 +491,9 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct hfs_bnode *prev, u32 idx)
 	desc.num_recs = cpu_to_be16(1);
 	desc.reserved = 0;
 	hfs_bnode_write(node, &desc, 0, sizeof(desc));
-	hfs_bnode_write_u16(node, 14, 0x8000);
-	hfs_bnode_write_u16(node, tree->node_size - 2, 14);
+	hfs_bnode_write_u16(node, HFS_BNODE_FIRST_REC_OFF, 0x8000);
+	hfs_bnode_write_u16(node, tree->node_size - 2,
+			    HFS_BNODE_FIRST_REC_OFF);
 	hfs_bnode_write_u16(node, tree->node_size - 4, tree->node_size - 6);
 
 	return node;
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 06d30bd5d..8a8d3eb28 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -609,16 +609,15 @@ bool hfs_bnode_num_recs_invalid(struct hfs_bnode *node)
 	u32 table_size;
 	u32 area_size;
 	u32 rec_size = sizeof(__be16);
-	u32 desc_size = sizeof(struct hfs_bnode_desc);
 
 	if (!node || !node->tree)
 		return true;
 
 	node_size = node->tree->node_size;
-	if (node_size < desc_size)
+	if (node_size < HFS_BNODE_DESC_SIZE)
 		return true;
 
-	area_size = node_size - desc_size;
+	area_size = node_size - HFS_BNODE_DESC_SIZE;
 	table_size = ((u32)node->num_recs + 1) * rec_size;
 
 	return table_size > area_size;
@@ -641,12 +640,11 @@ bool hfs_brec_offsets_invalid(struct hfs_bnode *node, u16 off, u16 next_off)
 	u32 table_size;
 	u32 table_start;
 	u32 rec_size = sizeof(__be16);
-	u32 desc_size = sizeof(struct hfs_bnode_desc);
 
 	if (!node || !node->tree)
 		return true;
 
-	if (off < desc_size || (off & 1))
+	if (off < HFS_BNODE_FIRST_REC_OFF || (off & 1))
 		return true;
 
 	if (next_off <= off ||
diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
index 71364e093..54aa0be83 100644
--- a/fs/hfsplus/xattr.c
+++ b/fs/hfsplus/xattr.c
@@ -74,7 +74,7 @@ static u32 hfsplus_init_header_node(struct inode *attr_file,
 	desc = (struct hfs_bnode_desc *)buf;
 	desc->type = HFS_NODE_HEADER;
 	desc->num_recs = cpu_to_be16(HFSPLUS_BTREE_HDR_NODE_RECS_COUNT);
-	offset = sizeof(struct hfs_bnode_desc);
+	offset = HFS_BNODE_FIRST_REC_OFF;
 	*--rec_offsets = cpu_to_be16(offset);
 
 	head = (struct hfs_btree_header_rec *)(buf + offset);
@@ -96,7 +96,7 @@ static u32 hfsplus_init_header_node(struct inode *attr_file,
 		u32 map_node_bits;
 
 		desc->next = cpu_to_be32(be32_to_cpu(head->leaf_tail) + 1);
-		map_node_bits = 8 * (node_size - sizeof(struct hfs_bnode_desc) -
+		map_node_bits = 8 * (node_size - HFS_BNODE_DESC_SIZE -
 					(2 * sizeof(u16)) - 2);
 		map_nodes = (be32_to_cpu(head->node_count) -
 				hdr_node_map_rec_bits +
@@ -157,7 +157,7 @@ static void hfsplus_init_map_node(u8 *buf, u16 node_size, u32 next_node)
 	rec_offsets = (__be16 *)(buf + node_size);
 
 	/* record #1 */
-	offset = sizeof(struct hfs_bnode_desc);
+	offset = HFS_BNODE_FIRST_REC_OFF;
 	*--rec_offsets = cpu_to_be16(offset);
 
 	/* record #2 */
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index d6a615e74..af9ddb461 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -475,6 +475,12 @@ struct hfs_bnode_desc {
 	u16 reserved;
 } __packed;
 
+/* Size of the node descriptor at the start of every node */
+#define HFS_BNODE_DESC_SIZE	sizeof(struct hfs_bnode_desc)
+
+/* Offset of record 0, which follows the node descriptor */
+#define HFS_BNODE_FIRST_REC_OFF	HFS_BNODE_DESC_SIZE
+
 /* HFS/HFS+ BTree node types */
 #define HFS_NODE_INDEX	0x00	/* An internal (index) node */
 #define HFS_NODE_HEADER	0x01	/* The tree header node (node 0) */
-- 
2.39.5

