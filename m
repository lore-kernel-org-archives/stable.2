Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687212;
	b=l+jjEFsW2OFuNdSxMjWni4A2Uh4RsEUG7nwcrLgrDsdaB6TkDQD2mPLVQixbTLD+POKJ
	 pFhXEV1aMa0D2wq6c7AJTB+nDM8sW//qySZbUY8rgL+2ZsdvJHBmCiVRNn1RKLTXDjcs2
	 RUi3sYD2l2KIjOO1UHwpbZ9sDjeJyrMP0xlrZvJV+5Z6VW84douHvwnxLIbRieBQgPYxr
	 LRLUb9mtIIkJsEPp8tXTHnYnD/uFSzkdHGpaVjlIJpbwYOPVResnorVXkbY43TFVrTHEJ
	 i5EE3rgzX6ipj6yzZfp8tHUP831Huq89QQiUOZ6Ui2oG+1QYYIAvBPDGe2JP8LwkNTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687212;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=GkjvvCHhteZtw/uG+Zq+6BNxON5YRmIpC2a6EV3RPR4=;
	b=P5II4JrDk97zIf3Tb7FdadspznnOfiBVEeeQFEaa33hlQIb4+QypK7yxQxyH5rkPDpEt
	 mr7VtHX/MJvYhYuIju0VcnO8ay7a1pvLpKpuucWnWBxa3aPK/joKO6+KKPVSX/aoXHorP
	 Bc6Gb/VUEXO7pvUPPXcFcvygUtij/slO2RdIICV2ZCc7hbcYOn8G6UfJRkIBDjdpDO4b1
	 IrUcakIWy1Axwal65VY2yWI20MeXT3eWAeuj4dE6yBV9lS0szHXu1Kxzq5XA4Bt2tpow+
	 yEseT3OJtzcpRBKGK7N6RrSteqxSb0FEn9HxY/7BHJqVrOatbQJWLcPwc989YFbX5Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846E8606A32E;
	Tue,  3 Nov 2026 06:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 846E8606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJdrn6GLXz5B0sK;
	Tue, 03 Nov 2026 14:26:49 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A36Qbvr029471;
	Tue, 3 Nov 2026 14:26:37 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 14:26:39 +0800 (CST)
X-Zmail-TransId: 2afb6ae97e9f425-d6d63
X-Mailer: Zmail v1.0
Message-ID: <20261103142639249fHll0I2TNe_OAs_YcCBGS@zte.com.cn>
In-Reply-To: <202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn>
References: 202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn
Date: Tue, 3 Nov 2026 14:26:39 +0800 (CST)
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
To: <richard@nod.at>
Cc: <linux-mtd@lists.infradead.org>, <chengzhihao1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIHYyIDQvNV0gdWJpZnM6IHZhbGlkYXRlIGlub2RlIGFuZCBkYXRhIG5vZGUgc2l6ZXMgZHVyaW5nIHJlcGxheQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A36Qbvr029471
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 03 Nov 2026 14:26:49 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE97EA9.000/4jJdrn6GLXz5B0sK

replay_bud() trusts the size fields of inode and data nodes from the
journal.  An image that is corrupt but has a matching CRC can therefore
carry an inode node with a negative or too large size, or a data node
with a size outside 1..UBIFS_BLOCK_SIZE.  During recovery
ubifs_recover_size_accum() uses these values and ubifs_recover_size()
may extend the inode to the bogus size.

The normal read paths already reject such nodes (read_block(),
populate_page()) and truncation nodes are validated in replay_bud() as
well.  Do the same for inode and data nodes.  While at it, compute the
data node end offset with 64-bit arithmetic so that a large block
number cannot wrap.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v2: no change since v1.

diff --git a/fs/ubifs/replay.c b/fs/ubifs/replay.c
index 263045e05cf1..14cd5598ca0b 100644
--- a/fs/ubifs/replay.c
+++ b/fs/ubifs/replay.c
@@ -741,6 +741,12 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 			struct ubifs_ino_node *ino = snod->node;
 			loff_t new_size = le64_to_cpu(ino->size);
 
+			/* Validate inode node */
+			if (new_size < 0 || new_size > c->max_inode_sz) {
+				ubifs_err(c, "bad inode node");
+				goto out_dump;
+			}
+
 			if (le32_to_cpu(ino->nlink) == 0)
 				deletion = 1;
 			err = insert_node(c, lnum, snod->offs, snod->len, hash,
@@ -751,9 +757,21 @@ static int replay_bud(struct ubifs_info *c, struct bud_entry *b)
 		case UBIFS_DATA_NODE:
 		{
 			struct ubifs_data_node *dn = snod->node;
-			loff_t new_size = le32_to_cpu(dn->size) +
-					  key_block(c, &snod->key) *
-					  UBIFS_BLOCK_SIZE;
+			u32 dsize = le32_to_cpu(dn->size);
+			loff_t new_size;
+
+			/* Validate data node */
+			if (!dsize || dsize > UBIFS_BLOCK_SIZE) {
+				ubifs_err(c, "bad data node");
+				goto out_dump;
+			}
+
+			new_size = (loff_t)key_block(c, &snod->key) *
+				   UBIFS_BLOCK_SIZE + dsize;
+			if (new_size > c->max_inode_sz) {
+				ubifs_err(c, "bad data node");
+				goto out_dump;
+			}
 
 			err = insert_node(c, lnum, snod->offs, snod->len, hash,
 					  &snod->key, snod->sqnum, deletion,
