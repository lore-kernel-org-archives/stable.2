Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795049991;
	b=pgm9rPqbntrazBKA2BfSwkTkiqyA+j74/AJ2ctQYHm6WLoPi6hhchGGLVJ1ACtKEVntW
	 8aXo5ivXfXOnenM8YR2j92jFJoRc3Qc0P5Qkjop5IzZ0Wz/qdHe7/bZDuLSoxtiahDylB
	 G+/OvMTCLzmXNlRG6WaW/opu8FflxmWe5hzYfInPF2yUlUYmJ2h2ZASTQB4swcLZ6poyY
	 uZggl8wy/o6w7SMNwLAETK4nCWsjbbHBxvuSSPI2+FNBqQLVrZHSlXM2om63mxQtwffeQ
	 B161VS0oZMX+28BKrvtKWzlXbFj0v1yOPXUb1UQB70Tb8sV0Y+ogjBhsTHt9QiegChg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795049991;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=n2zFwqrnCjfxuTYE2fhSs+piNuvmxm7pT5WDpwNQDVc=;
	b=DARH+W5YsHYQSb6VPsZukoZKCA1sjaQ7iFK0tZx/mfFW8GaIGcHJFThnZfSPTENRjRh+
	 UbND+eC/f7RqKlALJKJNQ4qIS5e1+dUbDvvNNCLFKjLxtP6JmxHtK2W+58CrdwkFWGdjV
	 V/rUdjTNZCTIAJIM9D/PgUGFXab7S3+9GGqXaAxLN4o9oehgV0rt2hP0dnB3dEMvNiu1y
	 S6o50ilsMXFXLtPiKp0hjCS88ryVLplxKwLE03dVpR46YHhA8YH9bei/CAp3HJgvyLh0q
	 qq0ivZDbtQyRJSvCVUJB9C3jvqho+fm3Fgx8jsF8dPnbj5+m5u8Z15NSsMncBs92Eyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvjqiMNS;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3876606A33A
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 00:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3876606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DvjqiMNS
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-37198ed3727so493015eec.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 16:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795049990; x=1795654790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=n2zFwqrnCjfxuTYE2fhSs+piNuvmxm7pT5WDpwNQDVc=;
        b=DvjqiMNS8oQ7J7DvVlAF8LaY16kIMYLml4ncljITaMKPEtAWrZFgtNCYUym4jzmXHy
         9DTtX0/tD1oT+YolE/rBai1KTiWiciHHoyoyd4cGbSUlsIR4V+5OC2WoJIy+XxMsBTEm
         SUjrWFD7HENRrHDAHjAZN5CzBR54kWsEj1HvbhC8c14njbwJyqqLlECdhSSSBZvfh5A5
         OEAZD3Zu05Cktacbi3NQx324ORVJe84065wvF37YGEKEicgZbaeR3XWr5grCeSUt6eDn
         ypjLVG6PE215RfB1fe0nMWBZfp4F5bo1k88x3aRGTF8DS9kwTLOfy1uMksJBjf1Ml1fu
         dKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795049990; x=1795654790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=n2zFwqrnCjfxuTYE2fhSs+piNuvmxm7pT5WDpwNQDVc=;
        b=eHMCamUOtFWKXS8ohkPHs8Pq5Q/+8JlrtWd2awHQwh7cDkWHqBpnu4zTBrWFXbqk0Q
         D+hXk0+eyMzAPBT/ZCrFFsXxRWvKKDFOsA/5NEak/qRBxO0kdN+aLPpBgLmt7QUAboE8
         SzsjCLoCrOK3Z6KWfHzJm1UsWhzllos96gsF6QpudvVFGLCih44CIl84mVaAFnKTsyfH
         9TxcDDaJjKY9JPm1Aqevu907rMRRY3HyBFz1c0nqOVNgtPnViHN2hRSjWbl8UAa/EDoU
         HUNlcr/Kg0Ysu7i7ppHge8tQopovXjfOSWSCIqFVGCgaccZ+2pPwSMb+vwuo/Ae8nzHH
         TJSg==
X-Forwarded-Encrypted: i=1; AL+hErFtCKjiIqPALjyDmlxzn+wUcxvkgXQBfzFoZ4Ac5tN8Q9Hv1DOjPjaVevFtx4CZpH6zDxWUc+0=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9XNCgdD9QJUiSPzD9qObb4fRTZskpAfUkM2tI+WHYavTuIXZK
	U45cG3LvoG62D0N88tJnUt8aRkC5ZPvNWMIEBgipTp23u+Dr0bSM2gXx
X-Gm-Gg: AZFdTZfxgyOMyj7EWseji0C7BVuLY5wjFmWzqFkJYRh9aVwKlXVpHDEo8tFQIcJr6ow
	PRaC1cRSMm2hs31LQTJ4BzwGHGLpC24huj4UzXd5vFpAjAQVGL0V1SDCAwInuBxb8C4INiCPedZ
	gsheQM50xxsAmb5W5PpIAwl6XHzCc9LqNQSVNQe46B6FrA6B72IBEcwgjwxGb2tOs/+8kt6egpN
	Zf/Nkp9F7eXTsmJYuKDhSjbLCxti4lfIzRaZDwGjYmr8AxxlGf6QlKpEEtk6gcKmxy7xzJq3h44
	TqOElWU2l2MGaTl8IIrcjdh7PISgoC4lALm6g1n22XFNsAVnVFT+M1bq2L8aDx026iwh7Sy6f/M
	T9Gj5p2E/ddGJK7Jw5msJvZ8/EBsUFyBR4BFz6FqCzca2SvXnZRUlux9vIJc2oKOEPlyc0TEvBi
	jE6mby+z7NVqJVLKtq8zxMWdGlwGKpP0gMt2XaKhWJ7gid1KxM6nm5pzavP2seeGqXS3FeEA2xA
	PEBTRXLZo0eTOxXZnppkBFE05nASfD9xBhUiM9bT7g0uhH4M3YI4RBJquyyxy6ExPcZ2IQ+ghZB
	h48O9BEhaGmB8JdiiShGrqT92gSPXWytSqtR3JBBXQvad/nxCMNhT4JyLBMf3zA39UzmBfdyKnk
	XTQnTIiP37OcuYVoBoPtgUok5kKvUcQ3f4cIdn0J2QbGclHC3
X-Received: by 2002:a05:7301:9a8d:b0:36a:79cd:12df with SMTP id 5a478bee46e88-384447032camr330493eec.9.1795049989804;
        Wed, 18 Nov 2026 16:59:49 -0800 (PST)
Received: from localhost.localdomain ([2601:646:4300:d042:9887:3c66:c29:4859])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-382a72eb2f3sm13456446eec.18.2026.11.18.16.59.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 16:59:49 -0800 (PST)
From: ozgun kultekin <ozgunkultekin@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	yangguikun19@qq.com,
	stable@vger.kernel.org,
	ozgun kultekin <ozgunkultekin@gmail.com>
Subject: [PATCH v3 1/3] hfs/hfsplus: add HFS_BNODE_DESC_SIZE for the node descriptor size
Date: Wed, 18 Nov 2026 16:59:41 -0800
Message-ID: <20261119005943.37851-2-ozgunkultekin@gmail.com>
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

brec.c and btree.c in both drivers use the literal 14 for the size of
struct hfs_bnode_desc, which is also the offset of record 0 in a node.
Add HFS_BNODE_DESC_SIZE next to the structure and use it instead.

No functional change. The next two patches use the new name in the
hfs_bnode_read_key() calls they change.

Suggested-by: Viacheslav Dubeyko <slava@dubeyko.com>
Cc: stable@vger.kernel.org # prerequisite for the next two patches
Signed-off-by: ozgun kultekin <ozgunkultekin@gmail.com>
---
v3: new patch, as requested by Viacheslav

 fs/hfs/brec.c              | 32 +++++++++++++++++++++-----------
 fs/hfs/btree.c             |  4 ++--
 fs/hfsplus/brec.c          | 31 ++++++++++++++++++++-----------
 fs/hfsplus/btree.c         |  4 ++--
 include/linux/hfs_common.h |  3 +++
 5 files changed, 48 insertions(+), 26 deletions(-)

diff --git a/fs/hfs/brec.c b/fs/hfs/brec.c
index 1ca1ee9f7..31574e562 100644
--- a/fs/hfs/brec.c
+++ b/fs/hfs/brec.c
@@ -156,7 +156,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_DESC_SIZE);
 		__hfs_brec_find(fd->bnode, fd);
 
 		hfs_bnode_put(new_node);
@@ -402,7 +403,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 
 	/* size difference between old and new key */
 	if (tree->attributes & HFS_TREE_VARIDXKEYS)
-		newkeylen = (hfs_bnode_read_u8(node, 14) | 1) + 1;
+		newkeylen = (hfs_bnode_read_u8(node,
+					       HFS_BNODE_DESC_SIZE) | 1) + 1;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 1;
 	hfs_dbg("rec %d, keylength %d, newkeylen %d\n",
@@ -441,7 +443,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	hfs_bnode_move(parent, start_off + diff, start_off,
 		       end_off - start_off);
 skip:
-	hfs_bnode_copy(parent, fd->keyoffset, node, 14, newkeylen);
+	hfs_bnode_copy(parent, fd->keyoffset, node, HFS_BNODE_DESC_SIZE,
+		       newkeylen);
 	if (!(tree->attributes & HFS_TREE_VARIDXKEYS))
 		hfs_bnode_write_u8(parent, fd->keyoffset, newkeylen - 1);
 	hfs_bnode_dump(parent);
@@ -458,7 +461,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_DESC_SIZE);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd);
@@ -470,7 +474,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14);
+			hfs_bnode_read_key(node, fd->search_key,
+					   HFS_BNODE_DESC_SIZE);
 		}
 		new_node = NULL;
 	}
@@ -524,28 +529,33 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 	hfs_bnode_write(new_node, &node_desc, 0, sizeof(node_desc));
 
 	rec = tree->node_size - 2;
-	hfs_bnode_write_u16(new_node, rec, 14);
+	hfs_bnode_write_u16(new_node, rec, HFS_BNODE_DESC_SIZE);
 
 	if (node) {
 		/* insert old root idx into new root */
 		node->parent = tree->root;
 		if (node->type == HFS_NODE_LEAF ||
 		    tree->attributes & HFS_TREE_VARIDXKEYS)
-			key_size = hfs_bnode_read_u8(node, 14) + 1;
+			key_size = hfs_bnode_read_u8(node,
+						     HFS_BNODE_DESC_SIZE) + 1;
 		else
 			key_size = tree->max_key_len + 1;
-		hfs_bnode_copy(new_node, 14, node, 14, key_size);
+		hfs_bnode_copy(new_node, HFS_BNODE_DESC_SIZE, node,
+			       HFS_BNODE_DESC_SIZE, key_size);
 
 		if (!(tree->attributes & HFS_TREE_VARIDXKEYS)) {
 			key_size = tree->max_key_len + 1;
-			hfs_bnode_write_u8(new_node, 14, tree->max_key_len);
+			hfs_bnode_write_u8(new_node, HFS_BNODE_DESC_SIZE,
+					   tree->max_key_len);
 		}
 		key_size = (key_size + 1) & -2;
 		cnid = cpu_to_be32(node->this);
-		hfs_bnode_write(new_node, &cnid, 14 + key_size, 4);
+		hfs_bnode_write(new_node, &cnid,
+				HFS_BNODE_DESC_SIZE + key_size, 4);
 
 		rec -= 2;
-		hfs_bnode_write_u16(new_node, rec, 14 + key_size + 4);
+		hfs_bnode_write_u16(new_node, rec,
+				    HFS_BNODE_DESC_SIZE + key_size + 4);
 
 		hfs_bnode_put(node);
 	}
diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
index f07038403..4c2f82c1c 100644
--- a/fs/hfs/btree.c
+++ b/fs/hfs/btree.c
@@ -356,8 +356,8 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct hfs_bnode *prev, u32 idx)
 	desc.num_recs = cpu_to_be16(1);
 	desc.reserved = 0;
 	hfs_bnode_write(node, &desc, 0, sizeof(desc));
-	hfs_bnode_write_u16(node, 14, 0x8000);
-	hfs_bnode_write_u16(node, tree->node_size - 2, 14);
+	hfs_bnode_write_u16(node, HFS_BNODE_DESC_SIZE, 0x8000);
+	hfs_bnode_write_u16(node, tree->node_size - 2, HFS_BNODE_DESC_SIZE);
 	hfs_bnode_write_u16(node, tree->node_size - 4, tree->node_size - 6);
 
 	return node;
diff --git a/fs/hfsplus/brec.c b/fs/hfsplus/brec.c
index f416e562d..37e058c5d 100644
--- a/fs/hfsplus/brec.c
+++ b/fs/hfsplus/brec.c
@@ -166,7 +166,8 @@ int hfs_brec_insert(struct hfs_find_data *fd, void *entry, u32 entry_len)
 		entry_len = sizeof(cnid);
 
 		/* get index key */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_DESC_SIZE);
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
 
 		hfs_bnode_put(new_node);
@@ -409,7 +410,7 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	/* size difference between old and new key */
 	if ((tree->attributes & HFS_TREE_VARIDXKEYS) ||
 				(tree->cnid == HFSPLUS_ATTR_CNID))
-		newkeylen = hfs_bnode_read_u16(node, 14) + 2;
+		newkeylen = hfs_bnode_read_u16(node, HFS_BNODE_DESC_SIZE) + 2;
 	else
 		fd->keylength = newkeylen = tree->max_key_len + 2;
 	hfs_dbg("rec %d, keylength %d, newkeylen %d\n",
@@ -449,7 +450,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 	hfs_bnode_move(parent, start_off + diff, start_off,
 		       end_off - start_off);
 skip:
-	hfs_bnode_copy(parent, fd->keyoffset, node, 14, newkeylen);
+	hfs_bnode_copy(parent, fd->keyoffset, node, HFS_BNODE_DESC_SIZE,
+		       newkeylen);
 	hfs_bnode_dump(parent);
 
 	hfs_bnode_put(node);
@@ -464,7 +466,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 		}
 		fd->bnode = hfs_bnode_find(tree, new_node->parent);
 		/* create index key and entry */
-		hfs_bnode_read_key(new_node, fd->search_key, 14);
+		hfs_bnode_read_key(new_node, fd->search_key,
+				   HFS_BNODE_DESC_SIZE);
 		cnid = cpu_to_be32(new_node->this);
 
 		__hfs_brec_find(fd->bnode, fd, hfs_find_rec_by_key);
@@ -476,7 +479,8 @@ static int hfs_brec_update_parent(struct hfs_find_data *fd)
 			if (new_node == node)
 				goto out;
 			/* restore search_key */
-			hfs_bnode_read_key(node, fd->search_key, 14);
+			hfs_bnode_read_key(node, fd->search_key,
+					   HFS_BNODE_DESC_SIZE);
 		}
 		new_node = NULL;
 	}
@@ -530,7 +534,7 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 	hfs_bnode_write(new_node, &node_desc, 0, sizeof(node_desc));
 
 	rec = tree->node_size - 2;
-	hfs_bnode_write_u16(new_node, rec, 14);
+	hfs_bnode_write_u16(new_node, rec, HFS_BNODE_DESC_SIZE);
 
 	if (node) {
 		/* insert old root idx into new root */
@@ -538,21 +542,26 @@ static int hfs_btree_inc_height(struct hfs_btree *tree)
 		if (node->type == HFS_NODE_LEAF ||
 				tree->attributes & HFS_TREE_VARIDXKEYS ||
 				tree->cnid == HFSPLUS_ATTR_CNID)
-			key_size = hfs_bnode_read_u16(node, 14) + 2;
+			key_size = hfs_bnode_read_u16(node,
+						      HFS_BNODE_DESC_SIZE) + 2;
 		else
 			key_size = tree->max_key_len + 2;
-		hfs_bnode_copy(new_node, 14, node, 14, key_size);
+		hfs_bnode_copy(new_node, HFS_BNODE_DESC_SIZE, node,
+			       HFS_BNODE_DESC_SIZE, key_size);
 
 		if (!(tree->attributes & HFS_TREE_VARIDXKEYS) &&
 				(tree->cnid != HFSPLUS_ATTR_CNID)) {
 			key_size = tree->max_key_len + 2;
-			hfs_bnode_write_u16(new_node, 14, tree->max_key_len);
+			hfs_bnode_write_u16(new_node, HFS_BNODE_DESC_SIZE,
+					    tree->max_key_len);
 		}
 		cnid = cpu_to_be32(node->this);
-		hfs_bnode_write(new_node, &cnid, 14 + key_size, 4);
+		hfs_bnode_write(new_node, &cnid,
+				HFS_BNODE_DESC_SIZE + key_size, 4);
 
 		rec -= 2;
-		hfs_bnode_write_u16(new_node, rec, 14 + key_size + 4);
+		hfs_bnode_write_u16(new_node, rec,
+				    HFS_BNODE_DESC_SIZE + key_size + 4);
 
 		hfs_bnode_put(node);
 	}
diff --git a/fs/hfsplus/btree.c b/fs/hfsplus/btree.c
index 0a9b32d5c..519f07b81 100644
--- a/fs/hfsplus/btree.c
+++ b/fs/hfsplus/btree.c
@@ -497,8 +497,8 @@ static struct hfs_bnode *hfs_bmap_new_bmap(struct hfs_bnode *prev, u32 idx)
 	desc.num_recs = cpu_to_be16(1);
 	desc.reserved = 0;
 	hfs_bnode_write(node, &desc, 0, sizeof(desc));
-	hfs_bnode_write_u16(node, 14, 0x8000);
-	hfs_bnode_write_u16(node, tree->node_size - 2, 14);
+	hfs_bnode_write_u16(node, HFS_BNODE_DESC_SIZE, 0x8000);
+	hfs_bnode_write_u16(node, tree->node_size - 2, HFS_BNODE_DESC_SIZE);
 	hfs_bnode_write_u16(node, tree->node_size - 4, tree->node_size - 6);
 
 	return node;
diff --git a/include/linux/hfs_common.h b/include/linux/hfs_common.h
index 802d1590e..1b639bbd1 100644
--- a/include/linux/hfs_common.h
+++ b/include/linux/hfs_common.h
@@ -495,6 +495,9 @@ struct hfs_bnode_desc {
 	u16 reserved;
 } __packed;
 
+/* Size of the node descriptor, which is also the offset of record 0 */
+#define HFS_BNODE_DESC_SIZE	sizeof(struct hfs_bnode_desc)
+
 /* HFS/HFS+ BTree node types */
 #define HFS_NODE_INDEX	0x00	/* An internal (index) node */
 #define HFS_NODE_HEADER	0x01	/* The tree header node (node 0) */
-- 
2.39.5

