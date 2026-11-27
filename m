Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795755264;
	b=KfXvvZYPRRXqtd9g16gsOsQTQZcaUoDQbDNM3jBELCDSzJNyqygWzUNOCdOgA1NXKHwL
	 A3UU0mJ0hPvPmP8H7bxW5V+ncwizhIJQlglDHZOcdZF/ut5Mf3dpklW4rXCpwZL6w8gbJ
	 CiQeYstVGnKASwmHxNM+HUvm+44DvVASNg/Eog7E4lTWxHNR6Z29kuvDN/pCuGWS/DQzD
	 uAE8e7LU3gVANWb2agSP+uRlzn8TpqmtpL7O6G8t9+IFM93SdGcYOX3kLPmrmVywlfs90
	 wVXmQTi7Yx0XYna3RGKzx8d7LaQ+hRD+bJnoy07VlKdbeNnQtOqr5FSusvQDJsc2wPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795755264;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=7Bg19Ztb1MXrmCrbpU7WvekDY4FO8uo8mFZtOrPN6bE=;
	b=p/h2Wn+4U8i0PKDxnSMOKHaOvw5HH3b8xs8YouAfVxaw6kBRMppZh2TpPgt/OTjc/NCS
	 b0xJ+eSoj/lB5Mwl8Zci4wdqksggG6dlV0V/O+Fuluxc/k9z0gT0Yig01bwheD1J4GNWg
	 TjI83pchY8hK98YyyMQLtjd7V3H22IBXNp8NtGipxvylhJDOv1UaXw01YPu1x1UzgkjDt
	 DyMJU2HXO7Sx3Gg3MWUEz0NfOWt/bAirAgyBTz4UvPdBoZIlcowEQRFLGCljzvDs7p3si
	 YP5c1Ef34hjQTcL2vZbOtQiTItlqcsUadjjpob5PsSgguzwPkpKPlwQjLNNugq4HL9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x7896Mwy;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0817A606A331
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:54:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0817A606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x7896Mwy
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1b563e32936so3537943c88.1
        for <stable@vger.kernel.org>; Thu, 26 Nov 2026 20:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795755263; x=1796360063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7Bg19Ztb1MXrmCrbpU7WvekDY4FO8uo8mFZtOrPN6bE=;
        b=x7896Mwy2IvFwjCnIeuOrhmDyORGdtp/WnNS54r4dIy/pw/0OBe66eMISR7yPSatmT
         CpQrjF+VL4AOZ1ffJhQu8NPOef9bcT6uaYDXqx6y8F4aUh+4IaDFirBLKXqRjynISVSm
         L3E+9Ht6fHwMUK5E8KYtg1tFoOJrAQdVLzPcq6HepEu7uMZFxYsQXm8qcuJwIJ+JznVI
         9vclQTk5CZvbdfCFHDCDSz9YwDPSm5yIUZbnCjJqL3ODaVryBkY9yZTNebXN25fKPAYH
         7ciZMdAJpFp9Jahj7kmEEy1avbGvBD5EMZPZl//fy4Y3gLTyTUsrc+xTHyVb5/kFw9aE
         kqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795755263; x=1796360063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7Bg19Ztb1MXrmCrbpU7WvekDY4FO8uo8mFZtOrPN6bE=;
        b=PfDs24fSSJ8RxBdTaNFKaIJCZruc93kvjyFUYL76PFMTzQI41XY7Iv7RcIMPqyQ3Mf
         dqxewCKez3JkggxczFrZ2bRTPaujoGkKioCrII4s0I94EPUol8dONcanzEwUUBMUW8+N
         i239fk3NmWbdZPf1eqsCNPMkX0aqQRlthjrWb7k7qFJ3x7WcDG7kLvKu0LILVxciJH8h
         Xc6mExJwv/+bZ4NJOLBSwwXR37Q2Z6TGAx5KWHj4wSU6Eqk6FHsIhQSYjWbnLovViCzP
         Uy6ZtA/7hZ+wK0Yspy2DL/gSN8qLRiO3y7VhXe0TxHv7uZ4to3P/Xbb/LByR2Lmk9Se6
         1fbg==
X-Forwarded-Encrypted: i=1; AL+hErHYZ8aw8S+Ok/ufCkynHNhq6Fin1IgP+zsh4BHjPw8lkG2Her2m7RteEiELUC2ErDP3BnvpqFU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8UMrftCKI5GWNYl5MGK9v7XuLOJwgXUFCb4JQsb3nvtFbSgCd+
	AFglxZLAxekqcfR35aj+ACZADaMZrHJIwt4Ww6iqPj4yhSd8Lt1Zao4OH5nhb/ScoR4=
X-Gm-Gg: AZFdTZeo79TbKyNi7+0Jh4FVHHyBVbaYM/Br7XjLinoEMiHmfXfCTDISHLDzA0urEz/
	h9oDySugeXLSX3jPG1sxYs6l1lhF8cweYrrxdZkoR9We5lJZ7u9rSw/7uyDEp0JThs4nti2+u93
	CDAaD/+jzxjqd4MLUH8nvcCoJ+fiXBwf/TmrEkJtxDaP+K8TJXq7ID0d8IxxWFYe2s+fmhpBhNK
	4xcXEZYDJBRSQIJ8ZX7L1xGCnOkEIvd7CB6SmTl0XzbWV9ut1EmZ8LBxFJ1rU5T3pe6WeGDiqz+
	IxobH1qP5M6t09pR7IfMhJLp5vDiCOny/iGSQCNBxNYNlTCicv4phSInWr9AzEUeIzMtiDgPE5t
	ZYc/l/a9oDmzEFSKC+m2jPQ80atsVO+dNvRWSygrxgoHR4A1UsIEhlsMPUVXClmKJ0N2D0AMfQT
	Uka5tUPQio6Hg4JKdERvFAtiYmYDuTTWtYoj/AQszqyVNxMU8F0HqrSNpW5HK4N1kD3SdhPv0SS
	9HIOHpmBpfmJ/t3YX+OBXHfHrccaPFUZpjNKLzCCmMhcXWR+l6h8NRKBFUHRx4ypys4U+Uc6iZU
	GnfRG+bPeedG+kVSbUJn1eWU20mwMEs6ixj+N/cPgsw+xeC+8rHWG+L49HHBe1AfUQYU/xFTmvB
	5aoYc00gKTOhC9GNc+DaVkPNvC6A=
X-Received: by 2002:a05:7022:b043:10b0:1b2:471f:c4c with SMTP id a92af1059eb24-1b5568ce1f3mr23979667c88.19.1795755263113;
        Thu, 26 Nov 2026 20:54:23 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:c4b4:d9b:2291:1e49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm80383487c88.14.2026.11.26.20.54.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 20:54:22 -0800 (PST)
From: Ozgun Kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	Ozgun Kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v4 1/3] hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Thu, 26 Nov 2026 20:54:14 -0800
Message-ID: <20261127045416.1160-2-ozgunkultekin@gmail.com>
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
records of variable-key and attributes trees) from disk and only checks
it against sizeof(hfsplus_btree_key), 518 bytes. The destination is
always one of the two key buffers hfs_find_init() allocates, each
tree->max_key_len + 2 bytes long: max_key_len in the b-tree header
record does not count the __be16 key_len field, as hfs_btree_open()
checks (HFSPLUS_EXT_KEYLEN - sizeof(u16) and so on). For the extents
tree max_key_len is fixed at 10, so the whole allocation is 24 bytes and
a crafted leaf key writes up to 516 bytes from the image into
kmalloc-32. The error path clears 518 bytes of the same buffer.

hfs_brec_insert() reaches this with a key that was never validated:
when the tree root is 0 it reads the key of record 0 of the leaf it
inserts into, and after a split it reads the first key of the new node.
A read-write mount that extends the catalog, or an append to a file
whose extents spill into the extents tree, is enough.

Do not let hfs_bnode_read_key() assume the size of the buffer. Store
the capacity of each key buffer in struct hfs_find_data as key_capacity
in hfs_find_init(), allocate the two buffers from it, and pass it to
every hfs_bnode_read_key() call. Keys longer than the buffer are
rejected as before, and the error path clears only the buffer.

The allocation size does not change: max_key_len * 2 + 4 is now written
as HFS_FIND_KEY_BUFS * (max_key_len + HFSPLUS_KEY_LEN_SIZE). key_capacity
goes after bnode, where it pairs with record, so struct hfs_find_data
stays 56 bytes on 64-bit.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ozgun Kultekin <ozgunkultekin@gmail.com>
---
v4: now 1/3 so it applies to stable trees without the cleanup; uses
    the literal 14 that the cleanup in 3/3 replaces. key_buf_size
    renamed to key_capacity and placed after bnode (no hole, 56 bytes),
    struct comments as section headings only, as suggested by
    Viacheslav. The + 2 per buffer stays: max_key_len excludes key_len.
v3: https://lore.kernel.org/all/20261119005943.37851-1-ozgunkultekin@gmail.com/
v2: https://lore.kernel.org/all/20261118013337.67813-1-ozgunkultekin@gmail.com/
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/
---
 fs/hfsplus/bfind.c      |  5 +++--
 fs/hfsplus/bnode.c      |  7 ++++---
 fs/hfsplus/brec.c       | 12 ++++++++----
 fs/hfsplus/hfsplus_fs.h | 21 +++++++++++++++++----
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca9813f58..fcd6d50ee 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -19,11 +19,12 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	fd->tree = tree;
 	fd->bnode = NULL;
 	hfs_find_result_init(fd);
-	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	fd->key_capacity = tree->max_key_len + HFSPLUS_KEY_LEN_SIZE;
+	ptr = kzalloc(HFS_FIND_KEY_BUFS * fd->key_capacity, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-	fd->key = ptr + tree->max_key_len + 2;
+	fd->key = ptr + fd->key_capacity;
 	hfs_dbg("cnid %d, caller %ps\n",
 		tree->cnid, __builtin_return_address(0));
 	mutex_lock_nested(&tree->tree_lock,
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 3a1a1fa6f..144348bdb 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 	return data;
 }
 
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_capacity)
 {
 	struct hfs_btree *tree;
 	u32 key_len;
@@ -84,8 +85,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 2;
 
-	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfsplus_btree_key));
+	if (key_len > key_capacity || key_len < 1) {
+		memset(key, 0, key_capacity);
 		pr_err("hfsplus: Invalid key length: %u\n", key_len);
 		return;
 	}
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index f416e562d..c9fb6873a 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -148,7 +148,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 	 * at the start of the node and it is not the new node
 	 */
 	if (!rec && new_node != node) {
-		hfs_bnode_read_key(node, fd->search_key, data_off + size);
+		hfs_bnode_read_key(node, fd->search_key, data_off + size,
+				   fd->key_capacity);
 		hfs_brec_update_parent(fd);
 	}
 
@@ -166,7 +167,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key, 14,
+				   fd->key_capacity);
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
 
 		hfs_bnode_put(new_node);
@@ -464,7 +466,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key, 14,
+				   fd->key_capacity);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
@@ -476,7 +479,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14);
+			hfs_bnode_read_key(node, fd->search_key, 14,
+					   fd->key_capacity);
 		}
 		new_node = NULL;
 	}
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 6f240f87f..06d30bd5d 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -257,14 +257,26 @@ static inline void hfsplus_mark_inode_dirty(struct inode *inode,
 	mark_inode_dirty(inode);
 }
 
+/* hfs_find_init() allocates search_key and key as one buffer */
+#define HFS_FIND_KEY_BUFS	2
+
+/*
+ * Size of the key_len field at the start of every key. The max_key_len
+ * of the b-tree header record does not count it (see hfs_btree_open()),
+ * so a key buffer needs max_key_len + HFSPLUS_KEY_LEN_SIZE bytes.
+ */
+#define HFSPLUS_KEY_LEN_SIZE	sizeof_field(hfsplus_btree_key, key_len)
+
 struct hfs_find_data {
-	/* filled by caller */
+	/* set by hfs_find_init() */
 	hfsplus_btree_key *search_key;
 	hfsplus_btree_key *key;
-	/* filled by find */
 	struct hfs_btree *tree;
+	/* filled by find */
 	struct hfs_bnode *bnode;
-	/* filled by findrec */
+	/* set by hfs_find_init(): size of each of search_key and key */
+	u32 key_capacity;
+	/* filled by findrec, reset by hfs_find_result_init() */
 	int record;
 	int keyoffset, keylength;
 	int entryoffset, entrylength;
@@ -372,7 +384,8 @@ void hfs_bmap_free(struct hfs_bnode *node);
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_capacity);
 void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
 void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
-- 
2.39.5

