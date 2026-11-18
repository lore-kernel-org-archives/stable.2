Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794965857;
	b=BWRHO+rw8wxbKOs2Bo9ieTfe3MF1DGK8qc2nBZk+R0yVgP2daAiuu2eBWoEblyIVtfHL
	 aMCvi+wnSe3bwJVIzJ12VZEMRK1nwKQvGb7xkw3SUv65ufPFEmy+fBnPg/7Eg+JJLOUJp
	 /43WmuWg2m5gdgwI3SoD8GGP6PPktEeKE9m42xNxp9szHdkG5dtcnZ0rj+jlb+m0lh+e/
	 VtB1EPnjxbln2lhm/2jb2Ycwwg2tCREGmH2HEFSqA0YHCA+Yn6x09o+c/fkcHQ8avHPXf
	 k66WBmC6jDxZV7iqNHV3C4xK2qeTb+UJ5+dTnBzAHgDc8AosRCbJBIUnsXqGofkq2Ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794965857;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2ak/G9aO4KExnQrxARHHHXj8I0CSRMgCJgoJ5vAOUe4=;
	b=mNV8n/WrTnjKxX06XCNApDIdgvowncWhN1R5RJwW96zAT1c516XSFCeRBHYY05Z2n/uC
	 8m1t5elgybNPILFyNxHP9nmxr0yf1mGwX2ak/qwLGtaLUm8Os8h4kOiSz+LxXoRbeXUjF
	 KhZCJHN2zXamNbsWzsAEICqqkF6FOHQoDlWR8pxkUZftxcuKWk5kOnNymgNGdvByPNldG
	 SHnYcvUH9yHHq6k61fBfgCEj0DmkyjHpL7VRgKrteNC3esiY4jmBjRvTACzz90ecsQC2/
	 a3Sc41gabdOUb8XlD05YPNIovYiNrNUjE0T0EJZ1Cwc8bsfUHuQ46B0tq8goaKFjWYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uf9DcJae;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB114606A337
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 01:37:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB114606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Uf9DcJae
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-3704d30b84fso773403eec.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794965856; x=1795570656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ak/G9aO4KExnQrxARHHHXj8I0CSRMgCJgoJ5vAOUe4=;
        b=Uf9DcJaefNR1xiv11XxOni8gPvQVR60YvB8zaM0ngMMbDZN9VRlB99d4I37/3Pz58G
         ue2lZ7MsvjupoSEDcl2+aiB2a+CUmawTFpBIwkdXO9RV73bCTTCq0qU/HUhtQClbpqcR
         l742uT5q6gsheFpq+0OMNFIacSYo/LZ/sJNSEz/qDdBnsR6c9zFUM3UMHMb2N6UuL7i6
         sMSINTXA5S6I/LyqOC8s8F9WEducv/Zy54Wu4NXZLwJPczrPCGv0BjRgJUWRAbyyUh8D
         cCP3aJ9bOKQFcMYSDzl2vzZ9L/1Dd32idUadqvyWBs5sNxb+Z32TktuIT2yNRD1KBajC
         ztWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794965856; x=1795570656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ak/G9aO4KExnQrxARHHHXj8I0CSRMgCJgoJ5vAOUe4=;
        b=WCNPErnvh4JSFDRBFN7dab73s8NLFj9y5WWFira+Uup92xt/XAkzE5GrZThP024tpP
         bwCVsogWKkCBFNi6fHzGdZcfhdnYjL8SN9iS+WDheIR6ACcGDx4yFxIn3zFdCNsIcPon
         h+kCJyqYc4wRTq4AySwSM3j8uiPQGdPn8ZSKCz5r03aF+ZOmsJvBNlQS3hHGm+fxEHqs
         /gRfNbLYanA8323aE1NZSkUX+FxM+oNC2KgLgzAxs0/W8+LPkECGkgILCOQXylso5nWv
         Ndvg9tD8wzJj/F5OborMPK6JsuRYh0c3P95UYrYWHutPvriRS5K2BV0mzwNrm71d6frp
         LkgA==
X-Forwarded-Encrypted: i=1; AL+hErGNDlsFUSmooNKDHR7WeoKezPMdlWVp2G+f2L0HSOoi2L1a8Jsy8eve7wdHV24sHrrlNbarcmo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/DQQ6tgrUlaCEe/DzluRmyHwR1L9a1y6fHMEFGPD0sPu933mGZ
	D1thiaipycJswKYYwjjFw/uvJMB/MLIJuXDNo5PqczVgsKPQ8hl/4NRY
X-Gm-Gg: AZFdTZdC4L2nRLpwXHd10R4v5AEmekcjLMa6ZVyEauN6A3To1WR4V5VoYRqEp8no54B
	wnUW08UravSxBgKesa2dKMhSZabssoerQguBp1jaV+HOLXoCYvxmHZCBobzJHwkbllrDty7LTqP
	WvaVdkGKwKV/Qfi1UgtxceMNZM8oyr6e1YSoGVEEx5reD7p3xcNXPaL5/Wc/vyLff8dGiMJZgat
	KHS+3Q8eUYXI9Izp2MBOI3z9Bk3Mss1AEVY2zJXkcl9RfcEATe3geMBa/DSJGZigofZDEDcfD+U
	RzW8XRBrSNGTPNlgudqql7Z06yXpnmf0Vpo350gotRThsHdL1Nzp666WHHoE3lVilnZPu9T5uiu
	l/Zr6/Al5m3JDBvHwTeb8f2wuhtVKKIr8eT8dz+00/3lg6ei95i4360pJ8PMkW+rx87f5ySKFJX
	/l5NCexlFUvxOPsG92iInYtPM06X9+Omm+azQdrmi3YZpkKNw1wKku2XuukIBjxYkOHZ+emqHEs
	kUlk9t9/hZwJnyjufv20JzCrhCHMjiz2lciAqHHKHbFSwpxBM5kvMbWWgL7XXbAPEntkKcF22PC
	1el2gnRv065bE1TNhYEnm0wVlLglFOWdheNSW5E9J20SHocVNOQ3hvUtf1aBwWkmZNAuw2765EO
	cw0uU0MCjhXd8iNmT+iNLXw/gk7xl3zA9lFgLu9oK4rVxuLsSnw==
X-Received: by 2002:a05:7300:d117:b0:372:32a1:b384 with SMTP id 5a478bee46e88-38281a0669amr1111204eec.33.1794965855691;
        Tue, 17 Nov 2026 17:37:35 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:b1a7:bebf:2fc7:37b1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a6def9e2sm2094527eec.13.2026.11.17.17.37.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 17:37:35 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v2 1/2] hfsplus: pass the key buffer size to hfs_bnode_read_key()
Date: Tue, 17 Nov 2026 17:37:24 -0800
Message-ID: <20261118013725.90985-2-ozgunkultekin@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261118013725.90985-1-ozgunkultekin@gmail.com>
References: <20261114043522.48764-1-ozgunkultekin@gmail.com>
 <20261118013725.90985-1-ozgunkultekin@gmail.com>
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

Do not let hfs_bnode_read_key() assume the size of the buffer. Record
the size of each key buffer in struct hfs_find_data in hfs_find_init(),
allocate the two buffers from it, and pass it to every
hfs_bnode_read_key() call. Keys longer than the buffer are rejected as
before, and the error path clears only the buffer.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: bb5e07cb9277 ("hfs/hfsplus: fix slab-out-of-bounds in hfs_bnode_read_key")
Reported-by: Guikun Yang <yangguikun19@qq.com>
Closes: https://lore.kernel.org/all/tencent_F85118A9AFDF9B230D4E8FA672510A3E2F08@qq.com/
Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
v2: pass the key buffer size to hfs_bnode_read_key() and keep it in
    hfs_find_data, as suggested by Viacheslav
v1: https://lore.kernel.org/all/20261114043522.48764-1-ozgunkultekin@gmail.com/

 fs/hfsplus/bfind.c      | 6 ++++--
 fs/hfsplus/bnode.c      | 7 ++++---
 fs/hfsplus/brec.c       | 9 +++++----
 fs/hfsplus/hfsplus_fs.h | 5 ++++-
 4 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/fs/hfsplus/bfind.c b/fs/hfsplus/bfind.c
index ca9813f58..5ec72fc98 100644
--- a/fs/hfsplus/bfind.c
+++ b/fs/hfsplus/bfind.c
@@ -19,11 +19,13 @@ int hfs_find_init(struct hfs_btree *tree, struct hfs_find_data *fd)
 	fd->tree = tree;
 	fd->bnode = NULL;
 	hfs_find_result_init(fd);
-	ptr = kzalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
+	/* search_key and key, each holding one key of the largest size */
+	fd->key_size = tree->max_key_len + 2;
+	ptr = kzalloc(2 * fd->key_size, GFP_KERNEL);
 	if (!ptr)
 		return -ENOMEM;
 	fd->search_key = ptr;
-	fd->key = ptr + tree->max_key_len + 2;
+	fd->key = ptr + fd->key_size;
 	hfs_dbg("cnid %d, caller %ps\n",
 		tree->cnid, __builtin_return_address(0));
 	mutex_lock_nested(&tree->tree_lock,
diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
index 3a1a1fa6f..e2335c6d7 100644
--- a/fs/hfsplus/bnode.c
+++ b/fs/hfsplus/bnode.c
@@ -71,7 +71,8 @@ u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
 	return data;
 }
 
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_size)
 {
 	struct hfs_btree *tree;
 	u32 key_len;
@@ -84,8 +85,8 @@ void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off)
 	else
 		key_len = tree->max_key_len + 2;
 
-	if (key_len > sizeof(hfsplus_btree_key) || key_len < 1) {
-		memset(key, 0, sizeof(hfsplus_btree_key));
+	if (key_len > key_size || key_len < 1) {
+		memset(key, 0, key_size);
 		pr_err("hfsplus: Invalid key length: %u\n", key_len);
 		return;
 	}
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index f416e562d..779d7df0b 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -148,7 +148,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 	 * at the start of the node and it is not the new node
 	 */
 	if (!rec && new_node != node) {
-		hfs_bnode_read_key(node, fd->search_key, data_off + size);
+		hfs_bnode_read_key(node, fd->search_key, data_off + size,
+				   fd->key_size);
 		hfs_brec_update_parent(fd);
 	}
 
@@ -166,7 +167,7 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key, 14, fd->key_size);
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
 
 		hfs_bnode_put(new_node);
@@ -464,7 +465,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key, 14, fd->key_size);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
@@ -476,7 +477,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14);
+			hfs_bnode_read_key(node, fd->search_key, 14, fd->key_size);
 		}
 		new_node = NULL;
 	}
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index 6f240f87f..d0d4fea94 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -268,6 +268,8 @@ struct hfs_find_data {
 	int record;
 	int keyoffset, keylength;
 	int entryoffset, entrylength;
+	/* size of each of the search_key and key buffers */
+	u32 key_size;
 };
 
 struct hfsplus_readdir_data {
@@ -372,7 +374,8 @@ void hfs_bmap_free(struct hfs_bnode *node);
 void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off);
 u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off);
-void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off);
+void hfs_bnode_read_key(struct hfs_bnode *node, void *key, u32 off,
+			u32 key_size);
 void hfs_bnode_write(struct hfs_bnode *node, void *buf, u32 off, u32 len);
 void hfs_bnode_write_u16(struct hfs_bnode *node, u32 off, u16 data);
 void hfs_bnode_clear(struct hfs_bnode *node, u32 off, u32 len);
-- 
2.39.5

