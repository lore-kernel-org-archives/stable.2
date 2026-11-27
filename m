Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755266;
	b=YNBZIoptRgJDml+ByzTYUR6Fh3LJLp0ADs4mx4Gs80RRWDLB3Ow9UPdBkrKFV2LfO2aY
	 0bVFW6k3gBMQ3Hfvk0AwE0tGZ9FaHBTR6FXaVeCOBfJoUnrqljZPWbwPi9Gh7lYdjANja
	 BCqnW2m8d7se5KH2NscvZzmzQVyzTeVxXpo3E86a8iNdppCVBIuIL0reeVTznC+ZnUKYr
	 /j7jT5YThy5Txe7vYWMneGhWyHcT4OWsliTN8f7U1zDFi/HPI6yDbRyUhrmRQmCBc4Adu
	 RyxgicQSXOm9qxPQgXFTgfvPnEtMvt98YfEr1OB7sljx3iEwMHF2PMMxqTfH4BbMt+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755266;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Qld5lvxIv6j4g+RAqcSr34BSnLHDeA3+QN+hu+jXTQs=;
	b=j3XM+P9fDsKJBdp2nkTDVPFp9O4h7k8kCAQ7niLN4dfLQ+uIN4yJ1/LHaUVdHb2zIhgg
	 i7LZif8eK87E8ELjTa8avMYJEI5qy9Lp1ESWqKZXdO76dFYZym7V7EEf1/Scn73OE33eg
	 5DLXaFdrnfNi62fLqB+ss6LGFf8Ty+8B/DyG9UcEccQzI9NpaoSi29nDOv8pfHWOU9psR
	 cp6RtzrF58GbjsMutTl+Z0hDBzX1zYQMK1/6yEc43WhosKpF3R9rTh6bBqkav6IWVNonE
	 wpAn3SSdGheTWDH5NpfNASAPnd26/P53Mcy+TRH6qc+fNwKW6S+ykjt0Wlb4bOqSNkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmmnMuiL;
	arc=none smtp.remote-ip=74.125.82.41
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1A0606A32A
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD1A0606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rmmnMuiL
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1a3c08d6928so11456955c88.0
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755265; x=1796360065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qld5lvxIv6j4g+RAqcSr34BSnLHDeA3+QN+hu+jXTQs=;
        b=rmmnMuiLMARChV8nfP1bAlQhCPHmNY5Zx3+Al3EcHeVSBLqlj5y7fyFPHE0bxrdEiu
         IiKLTcZIwUayw/uCB6hM71RWwBFyThe9kL3jsUQ4LibOJikep9VwLoQrkLSMeGFFZfIF
         LsjecNNqePvvSlg0ocjYXnVSs+SBhgGqNPcyhL+wIzp5mAgDp12/+rW/jtuxSWYmrusm
         AsQDL7jcMosXuR7OzxWnG+tRTn7qgVz25q1DATNMfwbuy6dJ3XmMg/4Oy00WS9q/3SOa
         dJ5bJLFAccs5T+K36hPqnl4VoZ9J8fc4LLuxXOMCL9Vge3yoTMRjFIIQUP40JUIL6zm8
         TL5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755265; x=1796360065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qld5lvxIv6j4g+RAqcSr34BSnLHDeA3+QN+hu+jXTQs=;
        b=eLPukHSQ2hNqDF/iUmxg8CeQBBmzBTPfa55029btbdp1Q9FQGwkgEpDFDGGydvg0J2
         GYivHUH450mZyzVMT/sybZLwkcacm4mgaT3IBXfRRrbx1iQXm8675ggMylfKrMl9CeCU
         NglhHXO41DkUkrdPy7lGDC5wyBdUYLh1fZyEwThT71rVmcrAFyz0fhS81ck7Y95pZvSA
         ZP+xoT0g1Kg7XI3uxPiLfmcNY9p6doZfsh1YrOp86yp8cx5FK+kmS1I0YuBymBnsmchu
         fZkoaaiiNvcvUcJEEhtz5QX7+0XjtFif1pxGasfQupsJfmieOm+DWppNineGrzNjBrst
         A3Xw==
X-Forwarded-Encrypted: i=1; AL+hErGwcRqymUhHOZTH7kWSBm0/B3tj1/LCjrmwqnvVNqxhEN+BJY9WgTrrGo6Xb1kJs6YY6HzzTPs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9ohIWw6IQvQlck1QSyOPJCNlu3Tl9cuMbt7CDUx/CCFFFoDk0m
	y7vM0DPUUzaTjzkBTHofizmKNymguAOrSSxWedkosNAc/H3tO+VOvAVI
X-Gm-Gg: AZFdTZftV0gPvj4r03k78WupmB0IXBlR8jQ1VGJGVOz7n28PWTb7JCnwiQzk7wgFNxH
	KzdRjC3l1aBocn+jZi6umWuZjLlw2BaIAuFNc0wd2p63A0uBoAI0b7BrpR7K3i8a1zqxOAmKIOG
	MbvuS7AwHG/zWLlQsKrtdYDoxWph7GjiIUML/4u4a5GUxWHiA5NZ6i6lOrcWeD1QlKwt21jf/sm
	7H5oQ06rErZPV22uxTUekF9daLXiB1NePENhe12U9GNbr5tGuUB4AczkJv2AGTzsojlc+7MTB7k
	O/Vwv+R3rzZGOHY+B5vv2U4ES9MAYhiBvM2HtBpn9ZB3rW61+EiFslqaISr8B1qqMRmkt7WHWt4
	we6w7qXHn4HLCzOh51aEIVMQMg4FTgaCotirMIm1hSeCGNHgBJ2whwXoRWwFjgBOHlRQD9P8aaK
	FPauM1TMCrGH++I+D/n6xfiJCW/O8SY8Ra8UmKSRpyPPtVlV4cfsv/wS18e1udD7R85cEfs8Z/M
	tbnbNadsSM2EdlhKxUuFKd+IGLRWLMC5OcsQ18J93lCWx4ILtTBWOuUHSJkp3W1ZV5IYUuonxfw
	fW0l+y9rlmjAPitMySczo6tCG1Dk230gIoHvYeKPr+By6BFfWE8HwD0ehgEKDmxSEzxTkAbxB9n
	YRtVQHUPsz6SAM9LzVJ5RdcPrgvI=
X-Received: by 2002:a05:7022:23aa:b0:1b5:23e7:3387 with SMTP id a92af1059eb24-1b55688dd29mr32124402c88.19.1795755265026;
        Thu, 26 Nov 2026 20:54:25 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:c4b4:d9b:2291:1e49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm80383487c88.14.2026.11.26.20.54.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 20:54:24 -0800 (PST)
From: Ozgun Kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	Ozgun Kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v4 2/3] hfs: pass the key buffer size to hfs_bnode_read_key()
Date: Thu, 26 Nov 2026 20:54:15 -0800
Message-ID: <20261127045416.1160-3-ozgunkultekin@gmail.com>
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

hfs_bnode_read_key() reads the key length of leaf records (and of all
records of variable-key trees) from disk and only checks it against
sizeof(hfs_btree_key). The destination is always one of the two key
buffers hfs_find_init() allocates, each tree->max_key_len + 2 bytes
long: max_key_len in the b-tree header record does not count the key
length field, as hfs_btree_open() checks (HFS_MAX_EXT_KEYLEN is
sizeof(struct hfs_ext_key) - sizeof(u8)). For the extents tree
max_key_len is 7, so the whole allocation is 18 bytes and a crafted leaf
key writes up to 256 bytes from the image past it. The error path
clears sizeof(hfs_btree_key) bytes of the same buffer.

hfs_brec_insert() and hfs_brec_update_parent() reach this with keys
that were never validated, the same way as in hfsplus.

Store the capacity of each key buffer in struct hfs_find_data as
key_capacity in hfs_find_init(), allocate the two buffers from it, and
pass it to every hfs_bnode_read_key() call. Keys longer than the buffer
are rejected as before, and the error path clears only the buffer.

The allocation size does not change: max_key_len * 2 + 4 is now written
as HFS_FIND_KEY_BUFS * (max_key_len + HFS_KEY_LEN_MAX_SIZE), where
HFS_KEY_LEN_MAX_SIZE is the 16-bit key length of HFS_TREE_BIGKEYS
trees. key_capacity goes after bnode, where it pairs with record, so
struct hfs_find_data stays 56 bytes on 64-bit.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ozgun Kultekin <ozgunkultekin@gmail.com>
---
v4: now 2/3 so it applies to stable trees without the cleanup; uses
    the literal 14 that 3/3 replaces. key_buf_size renamed to
    key_capacity and placed after bnode (no hole, 56 bytes), no
    comments inside the struct, extern kept on the prototype like its
    neighbours, as suggested by Viacheslav.
v3: https://lore.kernel.org/all/20261119005943.37851-1-ozgunkultekin@gmail.com/
v2: https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.com/
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/
---
 fs/hfs/bfind.c |  5 +++--
 fs/hfs/bnode.c |  7 ++++---
 fs/hfs/brec.c  | 12 ++++++++----
 fs/hfs/btree.h | 15 ++++++++++++++-
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
index d56e47bdc..b37448e7b 100644
--- a/fs/hfs/bfind.c
+++ b/fs/hfs/bfind.c
@@ -21,11 +21,12 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 
 	fd->tree = tree;
 	fd->bnode = NULL;
-	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	fd->key_capacity = tree->max_key_len + HFS_KEY_LEN_MAX_SIZE;
+	ptr = kzalloc(HFS_FIND_KEY_BUFS * fd->key_capacity, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-	fd->key = ptr + tree->max_key_len + 2;
+	fd->key = ptr + fd->key_capacity;
 	hfs_dbg("cnid %d, caller %ps\n",
 		tree->cnid, __builtin_return_address(0));
 	switch (tree->cnid) {
diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
index fcb5b9cd1..23ad1a565 100644
--- a/fs/hfs/bnode.c
+++ b/fs/hfs/bnode.c
@@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 	return data;
 }
 
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_capacity)
 {
 	struct hfs_btree *tree;
 	u32 key_len;
@@ -83,8 +84,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 1;
 
-	if (key_len > sizeof(hfs_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfs_btree_key));
+	if (key_len > key_capacity || key_len < 1) {
+		memset(key, 0, key_capacity);
 		pr_err("hfs: Invalid key length: %u\n", key_len);
 		return;
 	}
diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 5a2f740dd..84da30f65 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -138,7 +138,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 	 * at the start of the node and it is not the new node
 	 */
 	if (!rec && new_node != node) {
-		hfs_bnode_read_key(node, fd->search_key, data_off + size);
+		hfs_bnode_read_key(node, fd->search_key, data_off + size,
+				   fd->key_capacity);
 		hfs_brec_update_parent(fd);
 	}
 
@@ -156,7 +157,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key, 14,
+				   fd->key_capacity);
 		__hfs_brec_find(fd->bnode, fd);
 
 		hfs_bnode_put(new_node);
@@ -450,7 +452,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key, 14,
+				   fd->key_capacity);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd);
@@ -462,7 +465,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14);
+			hfs_bnode_read_key(node, fd->search_key, 14,
+					   fd->key_capacity);
 		}
 		new_node = NULL;
 	}
diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
index 1f703f2c5..404e526f9 100644
--- a/fs/hfs/btree.h
+++ b/fs/hfs/btree.h
@@ -74,11 +74,23 @@ struct hfs_bnode {
 #define HFS_BNODE_NEW		1
 #define HFS_BNODE_DELETED	2
 
+/* hfs_find_init() allocates search_key and key as one buffer */
+#define HFS_FIND_KEY_BUFS	2
+
+/*
+ * Room for the key length field at the start of every key. The
+ * max_key_len of the b-tree header record does not count it (see
+ * hfs_btree_open()). The field is a u8, or a u16 in HFS_TREE_BIGKEYS
+ * trees (see hfs_brec_keylen()); the buffers have room for the larger.
+ */
+#define HFS_KEY_LEN_MAX_SIZE	sizeof(__be16)
+
 struct hfs_find_data {
 	btree_key *key;
 	btree_key *search_key;
 	struct hfs_btree *tree;
 	struct hfs_bnode *bnode;
+	u32 key_capacity;
 	int record;
 	int keyoffset, keylength;
 	int entryoffset, entrylength;
@@ -117,7 +129,8 @@ extern void hfs_bmap_free(struct hfs_bnode *node);
 extern void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 extern u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
 extern u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
-extern void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
+extern void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			       u32 key_capacity);
 extern void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 extern void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
 extern void hfs_bnode_write_u8(struct hfs_bnode *node, u32 off, u8 data);
-- 
2.39.5

