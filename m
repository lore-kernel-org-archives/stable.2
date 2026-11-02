Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627389;
	b=AI5wF9WS7jRYoniMAEiBhRK9VTL2BzUa0TMilTc6y7iaPMVVEiPRErBNd3CcKEpEetpg
	 L5vHbOgy2JrieqSa5cQVNem4toLsW3oxyljcw2+5DydzteDb2qGf4/nV9Bt3ueWhb5cY2
	 fF3RaI1F1s3FGr+Pqi/8qRdRqxfYtallrauhfgeHTR/Aa8FkytfVOZdILHwBs2AaZNrP3
	 CoyLdjcYIXhCzfxtRdL32kaLk3vv0gsfIZqaJm+zjeY2N7oKOAh9gvH4CLY9c3Z/6GY4B
	 x9lSkENKU7EEp1WD+FDgavmIA3tjcxn7AN5ttoz+qAp9chLC11zdVeoK7PvfFqcom7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627389;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=pwmY9y0374QQGHXLs9yOy7dGIQleOqb7WpRVOaqHasw=;
	b=oAFEDcVfpiIU2rrR20myqFIRxFGNVfkfiCliqVM7vO1nhxGggDDwo35kJviMo5F0STNJ
	 U6pVDMEASTBxFFgTTx6ouk3QELuPFRrxeSYLGbUCnzox4znmIrabDsl4/TvBTYfGx5FLE
	 6vQ9kmwrj6+QkqXhzGPMO38j7EFmIgDdmPGrnAYEr83k1I6j6elzQpgKk+iv3V8sByNno
	 TUs6V8DxnGoXLGzJ9yn+Tzv/W7Z8ZUjZHC+7AhohbVbnFx9dQ0WjskA1jywVt3tPNfRBB
	 i30doGfuzecVttzkMXEc1Ab29PNHTQCdbY3XBPKZ+w36n86HEkiNy5Q6LALq5ttXOSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA5D606A32D;
	Mon,  2 Nov 2026 13:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4DA5D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJCkF3jTfz57HS0;
	Mon, 02 Nov 2026 21:49:41 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A2DnXHm086889;
	Mon, 2 Nov 2026 21:49:33 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 21:49:36 +0800 (CST)
X-Zmail-TransId: 2afc6ae894f01df-0ffe0
X-Mailer: Zmail v1.0
Message-ID: <202611022149368903WduM6gYUyx2zaQkk3gax@zte.com.cn>
In-Reply-To: <20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn>
References: 20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn
Date: Mon, 2 Nov 2026 21:49:36 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDQvNV0gdWJpZnM6IHZhbGlkYXRlIGlub2RlIGFuZCBkYXRhIG5vZGUgc2l6ZXMgZHVyaW5nIHJlcGxheQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A2DnXHm086889
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 21:49:41 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE894F5.000/4jJCkF3jTfz57HS0

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
