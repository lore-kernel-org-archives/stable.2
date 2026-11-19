Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049993;
	b=QYlnJmE3DY2WeSWz8vDrIgwU8zsWTGxnSFo+MDeNiExkvPcDTpOgfddvWdlWmw45q4KU
	 Cz04bTgIpCJF741KUEyn3HMuY4CH3yhvlAu4rEaoh/uRMfA47krzxkj7EwmuGRrFzKbQZ
	 ULE+VUmkaXM37o17bSjfjFRP3hoiBuA8sePGfRvgyRiunEKi+jjKvvT1YlP0iYXTyR8RH
	 066ZZG/XMTAqhGVXppN1lfliTk+JUy9un5Z1R2nV2cuGr7CW77ViwXOGLQ9c8mCyXv5bL
	 3dVKxBR+jY5MuI14pNeMGC4lIT1tN6HKjwFTTV4x19DquvwK+ZyNBa606B1BMXar//w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Lm3+96d2EqJBwaLBTcnnGoq3rcaoBCvOUgbZKsflB+U=;
	b=uqIOxMjwK+qA/7HXbEBizW6YsS1ndu6Q1tr9nUO+Qe6K1x5z5nUXjDHg1JbT4sbOfl+G
	 oLug8sUxLqBzFwmp3JYioorDjKzF2f5/3f0NXSeIIeYjfXgPCx749XsVOYUU/jbVrcw5y
	 h5ZDCc7kcz5FSubJoy1cMsQr17x6ly8BxIfBpTggCGljq9o30fXyglxwlyR7CtXwVGZQZ
	 1uhzV1O67McLmulsaxkjwlvCS3j2Wd+m37NX0VzB/+1eXey+lM4tjnsK43RUoI8bVJ3kd
	 tmKfZXbNgnA+iBTejTA7FrCoKIbzNcs8/Ck6poiXPTRF7WrQr0zgmQvZUZaerDRrM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFRGmklC;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB2C606A32C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AB2C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sFRGmklC
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-36dbde64409so2948543eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049992; x=1795654792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lm3+96d2EqJBwaLBTcnnGoq3rcaoBCvOUgbZKsflB+U=;
        b=sFRGmklCwB1+AFXYiJ+qg9nrCNF7W0WePKiZL8/JBlSJ0bIYF6l3fDeb6I0tPLf1CQ
         rUPDlPA2mPFtCkSjhsLbCGFLEV7HFzzzibNMNTyVpRaRuNhgjCxXS+x0I6NbQqMfuAUR
         wdhDj3SdOzOdYf5DaU7l7vyWYKsyQ5y2s48zJG6vKfIGxvBpDhqnGiRcS1trOlZcl37W
         DCBpa/UPzDa3aX11qtm8p00u+d6nr48/cO9HvUX5hBv5JBoKZ31cgZXjNwQQLYKE+0jC
         M8z6cauH50ZWZkX71s3T9c1VoUqG8U0c6DVEvQFAryM+FlqhP7zatx4SMkY6NhKDIt+v
         Skyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049992; x=1795654792;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lm3+96d2EqJBwaLBTcnnGoq3rcaoBCvOUgbZKsflB+U=;
        b=oNtl1v9vCW6OeUn62nRK9jALIKpNQTgv4uHbtVxq6kR5F9lQoMpW7i2Lf3DAjRkCNa
         B6u2nbV/Hbhs0kYN9kxmPYY38YgoOTAB9O5WPABvNex25J5CxHv5QFVw3WS4qRaJfWPG
         H4j26rrQKVRraBbNa4M/qJf93U4P2cBOJOB96OHNZ5QIkHMe1i83DhLH2aus3q8xjIKI
         YY6Yx4bPYbPvIyz7PFzotfqn8lMiI++T3rFjX5/lJXbY1cGl3/OTiXFoqkrv7Q0QX8gS
         NdBAi325k7Sp0yYwTxUjxorCnKw6jy2OYFcziq8w7lzQZvgajNkF7iiVMvCeYJ8S/Tf9
         LsEQ==
X-Forwarded-Encrypted: i=1; AL+hErGiahh6QsnPJYKMn+vyZdXZzUKifA9IlSELYJYUl5+l1sUGSTq6i2/ehoSOg8VL59pJQ29NF6g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ga9Np2eaiDUxuYyKI7AcgaRc9ihtzgVyr8e1iGSlxYQ+egINo
	+7AuVG3DMIKMvxpJsbFiGP8xsXBXFNz3MSv7Ood0+nnAXYh7nNjXlNT3
X-Gm-Gg: AZFdTZfOFYYXTfhylO8y9PErKHUCckBGmYv0OESYcmKYKIOc/MbC8nvkHjEEfWE1rmA
	XIKoKvtNF0km22DSNixnfmIlexGtQRFKDKj4s1PSRhhxHB3B685sKAhaQwNmG63hD+fKNOiTdYw
	M0kgu+YlBN7LOJKtjUQkR3oRNQMllovAYQKu8UmCD9quLBbxkEMK8dWx8ruUZgnsIlyMx8jK5Iw
	Lm1gN9t6jXz82QYB4I00jiDpY5are0UcaTvoKSz1gp7nNynokXB7prAqTKezVNwigR9bFIVGvR1
	iF3ieMI46wruBj/QORZtzxKYrw/LWqeZxkCGBuhpDOsjqmaQrdMMHiiAW6Pc3xZQ25cd/hZFDuc
	ARJ3z6Er5IAmuaZgkq8W9jt4UAkhq0cxK46A9xfPAyAO6e6+nW8u6vurirrvpHQqmapLHSe6tBO
	/M5tjx3jUYzr41Y11/QOaAxkmm8vnMMowWf8Fvsv8DNvey9hfQ6S91yTfkY9UOJpjXceKwRuEfX
	Y2ew9Y5TWJhXw5n1oqp6N3NSC7tw8XuA8RSh6OzBEZlBs/B3eo1dJnSV1yJHhOVRoUE3hOypxgO
	u3v22U2sXlRZ4OJWKtw3F72w9+ZTAOq9XEP/8CwxURBHNkFXHz8q6C+sFIazFHNYwvbfVYTzlD6
	WpodBvEFbXAFWHF8vz0oF3Q3CUxI=
X-Received: by 2002:a05:693c:69c7:b0:369:faa2:1fb2 with SMTP id 5a478bee46e88-3827f98a2d4mr3398076eec.8.1795049991611;
        Wed, 18 Nov 2026 16:59:51 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:9887:3c66:c29:4859])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm13456446eec.18.2026.11.18.16.59.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 16:59:51 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v3 2/3] hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Wed, 18 Nov 2026 16:59:42 -0800
Message-ID: <20261119005943.37851-3-ozgunkultekin@gmail.com>
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
records of variable-key and attributes trees) from disk and only checks
it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
always one of the two key buffers hfs_find_init() allocates, each
tree->max_key_len + 2 bytes long. For the extents tree max_key_len is
fixed at 10, so the whole allocation is 24 bytes and a crafted leaf key
writes up to 516 bytes from the image into kmalloc-32. The error path
clears 518 bytes of the same buffer.

hfs_brec_insert() reaches this with a key that was never validated:
when the tree root is 0 it reads the key of record 0 of the leaf it
inserts into, and after a split it reads the first key of the new node.
A read-write mount that extends the catalog, or an append to a file
whose extents spill into the extents tree, is enough.

Do not let hfs_bnode_read_key() assume the size of the buffer. Store
the size of each key buffer in struct hfs_find_data as key_buf_size in
hfs_find_init(), allocate the two buffers from it, and pass it to every
hfs_bnode_read_key() call. Keys longer than the buffer are rejected as
before, and the error path clears only the buffer.

The allocation size does not change: max_key_len * 2 + 4 is now written
as HFS_FIND_KEY_BUFS * (max_key_len + HFSPLUS_KEY_LEN_SIZE). Document
struct hfs_find_data while adding the field.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
v3: key_size renamed to key_buf_size and moved to the "filled by caller"
    part of struct hfs_find_data, struct and fields commented, buffer
    size written with named constants, as requested by Viacheslav
v2: https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.com/
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

 fs/hfsplus/bfind.c      |  5 +++--
 fs/hfsplus/bnode.c      |  7 ++++---
 fs/hfsplus/brec.c       | 10 ++++++----
 fs/hfsplus/hfsplus_fs.h | 28 ++++++++++++++++++++--------
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca9813f58..948bc3086 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -19,11 +19,12 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	fd->tree = tree;
 	fd->bnode = NULL;
 	hfs_find_result_init(fd);
-	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	fd->key_buf_size = tree->max_key_len + HFSPLUS_KEY_LEN_SIZE;
+	ptr = kzalloc(HFS_FIND_KEY_BUFS * fd->key_buf_size, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-	fd->key = ptr + tree->max_key_len + 2;
+	fd->key = ptr + fd->key_buf_size;
 	hfs_dbg("cnid %d, caller %ps\n",
 		tree->cnid, __builtin_return_address(0));
 	mutex_lock_nested(&tree->tree_lock,
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 3a1a1fa6f..9fd06ce88 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 	return data;
 }
 
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_buf_size)
 {
 	struct hfs_btree *tree;
 	u32 key_len;
@@ -84,8 +85,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 2;
 
-	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfsplus_btree_key));
+	if (key_len > key_buf_size || key_len < 1) {
+		memset(key, 0, key_buf_size);
 		pr_err("hfsplus: Invalid key length: %u\n", key_len);
 		return;
 	}
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index 37e058c5d..2a63b06d8 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -148,7 +148,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 	 * at the start of the node and it is not the new node
 	 */
 	if (!rec && new_node != node) {
-		hfs_bnode_read_key(node, fd->search_key, data_off + size);
+		hfs_bnode_read_key(node, fd->search_key, data_off + size,
+				   fd->key_buf_size);
 		hfs_brec_update_parent(fd);
 	}
 
@@ -167,7 +168,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 
 		/* get index key */
 		hfs_bnode_read_key(new_node, fd->search_key,
-				   HFS_BNODE_DESC_SIZE);
+				   HFS_BNODE_DESC_SIZE, fd->key_buf_size);
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
 
 		hfs_bnode_put(new_node);
@@ -467,7 +468,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
 		hfs_bnode_read_key(new_node, fd->search_key,
-				   HFS_BNODE_DESC_SIZE);
+				   HFS_BNODE_DESC_SIZE, fd->key_buf_size);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
@@ -480,7 +481,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 				goto out;
 			/* restore search_key */
 			hfs_bnode_read_key(node, fd->search_key,
-					   HFS_BNODE_DESC_SIZE);
+					   HFS_BNODE_DESC_SIZE,
+					   fd->key_buf_size);
 		}
 		new_node = NULL;
 	}
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index dd88053cc..f19787eba 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -257,17 +257,28 @@ static inline void hfsplus_mark_inode_dirty(struct inode *inode,
 	mark_inode_dirty(inode);
 }
 
+/* hfs_find_init() allocates search_key and key as one buffer */
+#define HFS_FIND_KEY_BUFS	2
+
+/* Size of the key_len field at the start of every key */
+#define HFSPLUS_KEY_LEN_SIZE	sizeof_field(hfsplus_btree_key, key_len)
+
+/*
+ * State of one b-tree search. hfs_find_init() sets up the key buffers
+ * and the tree, the search functions fill in the rest.
+ */
 struct hfs_find_data {
 	/* filled by caller */
-	hfsplus_btree_key *search_key;
-	hfsplus_btree_key *key;
+	hfsplus_btree_key *search_key;	/* key to search for */
+	hfsplus_btree_key *key;		/* key of the found record */
+	u32 key_buf_size;		/* size of each of search_key and key */
 	/* filled by find */
-	struct hfs_btree *tree;
-	struct hfs_bnode *bnode;
+	struct hfs_btree *tree;		/* tree being searched */
+	struct hfs_bnode *bnode;	/* node with the found record */
 	/* filled by findrec */
-	int record;
-	int keyoffset, keylength;
-	int entryoffset, entrylength;
+	int record;			/* index of the record in bnode */
+	int keyoffset, keylength;	/* offset and length of its key */
+	int entryoffset, entrylength;	/* offset and length of its data */
 };
 
 struct hfsplus_readdir_data {
@@ -372,7 +383,8 @@ void hfs_bmap_free(struct hfs_bnode *node);
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_buf_size);
 void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
 void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
-- 
2.39.5

