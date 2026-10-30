Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352427;
	b=oQYpufTLjMIBhtOXs5vxx0tnf5w/U9OJ5smKxUv480vxD41N8wArbEbX5MOuPKDAOrsz
	 Fvht6ILbZpbIp/A+dE3esXpECmagtdExFhUr9YFYZFRCq3FH+O8UGtO2rI1V1voAJKnH3
	 uIJnD0zCT6l88g9+uniNaNUZFYS6ov4aI8uTzTX7TxLJCZahkVoZLI8w3gQHJm3whdatO
	 dbGinOyxZxh/XzH++1hcDdcRWlQH/cTSua+0PyYZfkIgDo0gqpfGrX1iHb8wR/0kBCY9a
	 bRU7+pzkV0MsKg0N2ufe5Nsngro0ZhhQbTWBAhbfhf/xmxCJbthl/GCZZSzkCgMx1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352427;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=V1pspLk+fckd2Oob0tFDkfoQsu77+dAXAQw/b0Q2v3k=;
	b=RUBQy/SgGi2b/aJgl/gpUCQGia5VyBGpDSOpom/Du0QoG6EFtLG37Pe1NChPhPbSCGjz
	 mNlSPFCESEewvvOMJHp92SFIh5xHvta4b9HjU+MsM9Uid7K00oyuAwAbH2lvJHoSKBFQk
	 etfCr5bHYzYJt0VGGAmMzHOm0L4BlgReZDcMFOYoVNBR1Sm97p1oL2MGdAGqm4VxQt7bQ
	 BTS5sGBfA8/QDlju0n2MHNnGtw6w5B5tuiyTzfD5jocAEYYURjSOfkCc8MBMfaXIh3f7h
	 w7+n120xCT/HEpke0IeqFdyBjDsKXQivd2+PijTx/GQ9UpObvJtPV0lsfSOvwwIgT1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C7F606A326;
	Fri, 30 Oct 2026 09:27:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A0C7F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jGG2W18dVz5B0xd;
	Fri, 30 Oct 2026 17:26:59 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 69U9Qm49099897;
	Fri, 30 Oct 2026 17:26:48 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Fri, 30 Oct 2026 17:26:50 +0800 (CST)
X-Zmail-TransId: 2afa6ae462da066-f0b1f
X-Mailer: Zmail v1.0
Message-ID: <20261030172650531F_VlxVrMiDglCJJ9rESWI@zte.com.cn>
In-Reply-To: <ab51df45-f763-358b-642c-8efe06f33ffb@huawei.com>
References: 202610301145238169CxodJv5_0n5vd-Vbd4XA@zte.com.cn,ab51df45-f763-358b-642c-8efe06f33ffb@huawei.com
Date: Fri, 30 Oct 2026 17:26:50 +0800 (CST)
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
Cc: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        <chengzhihao1@huawei.com>
Subject: =?UTF-8?B?W1BBVENIIHYyXSB1YmlmczogZml4IGF1dGggbm9kZSBzcGFjZSBhbmQgcGFkZGluZyBpbiBqb3VybmFsIGJ1ZmZlcnM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 69U9Qm49099897
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Fri, 30 Oct 2026 17:26:59 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE462E3.000/4jGG2W18dVz5B0xd

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

The same write path also writes uninitialized heap data.
ubifs_jnl_write_data() and ubifs_jnl_write_inode() build their node
groups in kmalloc()ed buffers, and when the last node length is not a
multiple of 8 the padding up to the next auth node goes to the flash
uninitialized.  That padding is covered neither by the node CRC nor by
the rolling hash.

Size the reserve buffer for the largest possible auth node (the mount
path allocates it before authentication is initialized, so it cannot use
ubifs_auth_node_sz()), clear the padding after the data node before it is
written, and allocate the node group buffers of ubifs_jnl_write_inode()
and ubifs_jnl_truncate() with kzalloc().  The data write path cannot just
use kzalloc() because it may fall back to the reused reserve buffer.
ubifs_jnl_truncate() refills its data node with ubifs_tnc_lookup(), so
what is left after the re-compressed node comes from the old node on the
media, not from the heap.

The padding is not part of any node, so ch.len and the CRCs stay
unchanged.  With a zeroed truncation buffer, zero_trun_node_unused() is
redundant, so remove it and the comments which refer to it.

Fixes: 6a98bc4614de ("ubifs: Add authentication nodes to journal")
Link: https://lore.kernel.org/all/ab51df45-f763-358b-642c-8efe06f33ffb@huawei.com/
Cc: stable@vger.kernel.org
Suggested-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v2: Keep the explicit padding clear only in ubifs_jnl_write_data(), which
    may fall back to the reused write reserve buffer; allocate the node
    groups of ubifs_jnl_write_inode() and ubifs_jnl_truncate() with
    kzalloc(), and drop zero_trun_node_unused() together with the
    comments pointing at it.  Thanks to Zhihao Cheng for the review.

 fs/ubifs/journal.c     | 39 ++++++++++++++++++++++++++-------------
 fs/ubifs/super.c       | 18 ++++++++++++++----
 fs/ubifs/ubifs-media.h |  6 ++----
 3 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/fs/ubifs/journal.c b/fs/ubifs/journal.c
index 40a95a2fad50..449bc8c0a224 100644
--- a/fs/ubifs/journal.c
+++ b/fs/ubifs/journal.c
@@ -68,16 +68,6 @@ static inline void zero_dent_node_unused(struct ubifs_dent_node *dent)
 	dent->padding1 = 0;
 }

-/**
- * zero_trun_node_unused - zero out unused fields of an on-flash truncation
- *                         node.
- * @trun: the truncation node to zero out
- */
-static inline void zero_trun_node_unused(struct ubifs_trun_node *trun)
-{
-	memset(trun->padding, 0, 12);
-}
-
 static void ubifs_add_auth_dirt(struct ubifs_info *c, int lnum)
 {
 	if (ubifs_authenticated(c))
@@ -840,6 +830,28 @@ int ubifs_jnl_update(struct ubifs_info *c, const struct inode *dir,
 	return err;
 }

+/**
+ * ubifs_zero_node_pad - zero the padding after a journal node
+ * @c: UBIFS file-system description object
+ * @node: node to pad
+ * @len: length of the node
+ *
+ * When authentication is enabled the auth node is placed at the next
+ * 8-byte aligned offset, so the bytes between the end of the node and
+ * that offset are written to the media.  They are covered neither by the
+ * node CRC nor by the rolling hash, so clear them instead of writing
+ * stale buffer contents.
+ *
+ * This is only needed when the buffer is reused, i.e. for the write
+ * reserve buffer of ubifs_jnl_write_data().  Buffer owners which get a
+ * fresh allocation use kzalloc() instead.
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
@@ -925,6 +937,7 @@ int ubifs_jnl_write_data(struct ubifs_info *c, const struct inode *inode,
 	if (err)
 		goto out_free;

+	ubifs_zero_node_pad(c, data, dlen);
 	ubifs_prepare_node(c, data, dlen, 0);
 	err = write_head(c, DATAHD, data, write_len, &lnum, &offs, 0);
 	if (err)
@@ -1007,9 +1020,10 @@ int ubifs_jnl_write_inode(struct ubifs_info *c, const struct inode *inode)
 	else
 		write_len += ilen;

-	ino_start = ino = kmalloc(write_len, GFP_NOFS);
+	ino = kzalloc(write_len, GFP_NOFS);
 	if (!ino)
 		return -ENOMEM;
+	ino_start = ino;

 	/* Make reservation before allocating sequence numbers */
 	err = make_reservation(c, BASEHD, write_len);
@@ -1716,7 +1730,7 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 	sz =  UBIFS_TRUN_NODE_SZ + UBIFS_INO_NODE_SZ +
 		dn_size + ubifs_auth_node_sz(c);

-	ino = kmalloc(sz, GFP_NOFS);
+	ino = kzalloc(sz, GFP_NOFS);
 	if (!ino)
 		return -ENOMEM;

@@ -1725,7 +1739,6 @@ int ubifs_jnl_truncate(struct ubifs_info *c, const struct inode *inode,
 	trun->inum = cpu_to_le32(inum);
 	trun->old_size = cpu_to_le64(old_size);
 	trun->new_size = cpu_to_le64(new_size);
-	zero_trun_node_unused(trun);

 	dlen = new_size & (UBIFS_BLOCK_SIZE - 1);
 	if (dlen) {
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
diff --git a/fs/ubifs/ubifs-media.h b/fs/ubifs/ubifs-media.h
index 3c9792cbb6ff..7d4702f3e15f 100644
--- a/fs/ubifs/ubifs-media.h
+++ b/fs/ubifs/ubifs-media.h
@@ -591,14 +591,12 @@ struct ubifs_data_node {
  * @old_size: size before truncation
  * @new_size: size after truncation
  *
- * This node exists only in the journal and never goes to the main area. Note,
- * do not forget to amend 'zero_trun_node_unused()' function when changing the
- * padding fields.
+ * This node exists only in the journal and never goes to the main area.
  */
 struct ubifs_trun_node {
 	struct ubifs_ch ch;
 	__le32 inum;
-	__u8 padding[12]; /* Watch 'zero_trun_node_unused()' if changing! */
+	__u8 padding[12];
 	__le64 old_size;
 	__le64 new_size;
 } __packed;
