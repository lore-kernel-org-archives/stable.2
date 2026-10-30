Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793331935;
	b=wwTxzMkzOXr+Ir5UVKATep4aLYRk8YuJVDUgOUNJvd1DTViZL5jaM31wYWK15yznADQ4
	 15+jBUP2It/FwLs60aV5tA7QC0jg5Tz06Pc9Z/swyTY1XOwJIgLXTQBh9he5oKegrvSdm
	 aI0v4OHVxrRf0ALQamQ/m0dtJ0JWN0IjZoZDrh1f8uGFK5/bcmVjcKpkAiRqujJ8vWL0s
	 3Jm1OypdclBOgZzeJc32X1aWa5a/j15ZZSGOf8ygmSPVEGgrqNGltJRFsjzBzD4w32xTG
	 aDHijDIWzU8Kvg1jxS2drRunMA+pRFAKZp9iZeBjOM1BEquQuzaSFo+0ChSchK6kx2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793331935;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:Date:Mime-Version:From:To:Cc:Subject:Content-Type:X-MAIL:
	 X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=q48tFhWZcL9isQVRoWO98yZxtDQcZ7rYdK/d2CExFAQ=;
	b=P4VfhrW5Dg+fjV567wgKPtKIHdyILZPbBGnf9G1uycdiOE3QhJe6XHpqjMIGeV43GQ6P
	 3q31N44iaa6HA8G6jda0ZChYTlYKP1zeMBaOdZGUDL/auUbCzGaBHRHw5m/VimgPLQq9n
	 v5s8ft3qCF15CYGeeHH5QohGvcFO53yCJ6yblN3DOyp7nehsvx84RhdQ8GfqTv/IQsDoO
	 1mGw/9T6hlsoP87Z2us4ouyDDBD9NRTfWe3pUemGpVNFCoomTSo9eKY12uCFWGL+Lpilm
	 Ty8+kD4nV5qns9GrwPxe1PUNefHSikCQqiVPjLIL3eRBkFR0RHOkCj0Ig1RbvomIHdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B6C606A320;
	Fri, 30 Oct 2026 03:45:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51B6C606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jG6SR6BwXz58fdZ;
	Fri, 30 Oct 2026 11:45:27 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 69U3jMuK041522;
	Fri, 30 Oct 2026 11:45:22 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 30 Oct 2026 11:45:23 +0800 (CST)
X-Zmail-TransId: 2afa6ae412d30cc-acdc7
X-Mailer: Zmail v1.0
Message-ID: <202610301145238169CxodJv5_0n5vd-Vbd4XA@zte.com.cn>
Date: Fri, 30 Oct 2026 11:45:23 +0800 (CST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
From: <shao.mingyin@zte.com.cn>
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>
Cc: <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIXSB1YmlmczogZml4IGF1dGggbm9kZSBzcGFjZSBhbmQgcGFkZGluZyBpbiBqb3VybmFsIGJ1ZmZlcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 69U3jMuK041522
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Fri, 30 Oct 2026 11:45:27 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE412D7.002/4jG6SR6BwXz58fdZ

From: Shao Mingyin <shao.mingyin@zte.com.cn>

write_head() appends an authentication node to the node group when
authentication is enabled and writes
ALIGN(node_len, 8) + ubifs_auth_node_sz(c) bytes from the buffer.
ubifs_jnl_write_data() allocates its buffer for that, but when the
allocation fails it falls back to c->write_reserve_buf.  That buffer is
sized for a data node only (COMPRESSED_DATA_NODE_BUF_SZ plus the cipher
block, 4144/4160 bytes), while an incompressible 4 KiB block needs
4144/4160 bytes plus the auth node (24 + the HMAC length, 56 bytes with
sha256).  ubifs_hash_nodes() then writes the auth node past the end of
the reserve buffer, and write_head() reads it back from there.

The same write path also leaks uninitialized heap data.
ubifs_jnl_write_data(), ubifs_jnl_write_inode() and
ubifs_jnl_truncate() build their node groups in kmalloc()ed buffers, and
when the last node length is not a multiple of 8 the padding up to the
next auth node is written to the flash.  That padding is covered neither
by the node CRC nor by the rolling hash.

Size the reserve buffer for the largest possible auth node (the mount
path allocates it before authentication is initialized, so it cannot use
ubifs_auth_node_sz()) and zero the padding after the last node of each
group before it is written.  The padding is not part of any node, so
ch.len and the CRCs stay unchanged.

Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 40a95a2fad50..38fb59225f27 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -840,6 +840,24 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	return err;
 }

+/**
+ * ubifs_zero_node_pad - zero the padding after the last node of a group
+ * @c: UBIFS file-system description object
+ * @node: last node of the group
+ * @len: length of the node
+ *
+ * When authentication is enabled the auth node is placed at the next
+ * 8-byte aligned offset, so the bytes between the end of the last node
+ * and that offset are written to the media.  They are covered neither
+ * by the node CRC nor by the rolling hash, so clear them instead of
+ * writing stale heap contents.
+ */
+static void ubifs_zero_node_pad(const struct ubifs_info *c, void *node, int len)
+{
+	if (ubifs_authenticated(c))
+		memset((char *)node + len, 0, ALIGN(len, 8) - len);
+}
+
 /**
  * ubifs_jnl_write_data - write a data node to the journal.
  * @c: UBIFS file-system description object
@@ -925,6 +943,7 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 	if (err)
 		goto out_free;

+	ubifs_zero_node_pad(c, data, dlen);
 	ubifs_prepare_node(c, data, dlen, 0);
 	err = write_head(c, DATAHD, data, write_len, &lnum, &offs, 0);
 	if (err)
@@ -1062,6 +1081,7 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 	}

 	pack_inode(c, ino, inode, 1);
+	ubifs_zero_node_pad(c, ino, ilen);
 	err = ubifs_node_calc_hash(c, ino, hash);
 	if (err)
 		goto out_release;
@@ -1781,6 +1801,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 	ubifs_prep_grp_node(c, trun, UBIFS_TRUN_NODE_SZ, dlen ? 0 : 1);
 	if (dlen) {
 		ubifs_prep_grp_node(c, dn, dlen, 1);
+		ubifs_zero_node_pad(c, dn, dlen);
 		err = ubifs_node_calc_hash(c, dn, hash_dn);
 		if (err)
 			goto out_release;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 38972786817e..538907aba8a0 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -1263,8 +1263,16 @@ static int mount_ubifs(struct ubifs_info *c)
 		bu_init(c);

 	if (!c->ro_mount) {
-		c->write_reserve_buf = kmalloc(COMPRESSED_DATA_NODE_BUF_SZ + \
-					       UBIFS_CIPHER_BLOCK_SIZE,
+		/*
+		 * The reserve buffer is also used as a fallback for data
+		 * nodes which are followed by an authentication node, so
+		 * reserve room for the largest possible one.  Authentication
+		 * is initialized only later, hence the maximum sizes.
+		 */
+		c->write_reserve_buf = kmalloc(COMPRESSED_DATA_NODE_BUF_SZ +
+					       UBIFS_CIPHER_BLOCK_SIZE +
+					       UBIFS_AUTH_NODE_SZ +
+					       UBIFS_MAX_HMAC_LEN,
 					       GFP_KERNEL);
 		if (!c->write_reserve_buf)
 			goto out_free;
@@ -1723,8 +1731,10 @@ static int ubifs_remount_rw(struct ubifs_info *c)
 		goto out;
 	}

-	c->write_reserve_buf = kmalloc(COMPRESSED_DATA_NODE_BUF_SZ + \
-				       UBIFS_CIPHER_BLOCK_SIZE, GFP_KERNEL);
+	c->write_reserve_buf = kmalloc(COMPRESSED_DATA_NODE_BUF_SZ +
+				       UBIFS_CIPHER_BLOCK_SIZE +
+				       UBIFS_AUTH_NODE_SZ +
+				       UBIFS_MAX_HMAC_LEN, GFP_KERNEL);
 	if (!c->write_reserve_buf) {
 		err = -ENOMEM;
 		goto out;
