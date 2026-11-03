Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793686852;
	b=sX/grgpUleVawQFDUoRlphZRmOHxgNYWrC8FZ4Lbx19UOpEv1zH4yG89vAfWi1RiQMGu
	 7ZZLmV4bky0vIFaZspTF+WjQuYWnYVTUMc+mnpHohX0TG9VX4dJ7UMXliMB21zHkaJNd9
	 Z+ZCSJhXgDxe4hXKmHEWUvLROJLfa49a/QWMX103zds1g5k/eEfgO56HVKCi4zooeL1VX
	 pUtPbgdmJSDuxZybG875yteVpJutgI0tlAxi9FWrsEjc3XlICWPBbzRmRnU+m9qAC6KxY
	 2L34I4ZfKsfNi5sJhikPhPGq8/9zZjK0LyNHddGp/eC1ZICUif4v/ZnClmUb2x3fgYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793686852;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=pVYQcXyOMWomgBFEiE6DUqhCU/MbEJKsZkNoAyldhwE=;
	b=lHe8mGHDrCnMZ4pwtEbGLwJXzOFIrmn5cUfnRAkQ1h3XmXRkVnwfqWPhMegG1FrZ6tCE
	 ZEUtK6nWx+meEIKr7oZDeC03Vpy5Kb7HYqbNkEMhzXcEw3wpliSrlYNrPK+WiZHmwdBnL
	 bwq+awRlIjtX5x5hiTzos7SEQJ1tdadtW5AGBe6f/xMJRxx9o1bMwvfP6vDTI/Ydy7Iwo
	 bCJ0BbRQpcghEGfZkGU5NFVOGo1sSNt/OwkbGqbXCkZRS27XsPY5FBty1OrtpP50gNGSp
	 XbqPQp1CBFJcwtYIXQ1MlrbLtMlZPS8qk28vgEUuT8YDGKwyj6pirnANdRnJUjl/B2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3BE606D804;
	Tue,  3 Nov 2026 06:20:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D3BE606D804
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJdjq6Vw7z5B0vB;
	Tue, 03 Nov 2026 14:20:47 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl1.zte.com.cn with SMTP id 6A36Kf94003888;
	Tue, 3 Nov 2026 14:20:41 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 14:20:43 +0800 (CST)
X-Zmail-TransId: 2afc6ae97d3bc75-c35c7
X-Mailer: Zmail v1.0
Message-ID: <20261103142043289ude_HZBjiYKUKUplcNrSR@zte.com.cn>
In-Reply-To: <202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn>
References: 202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn
Date: Tue, 3 Nov 2026 14:20:43 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDEvNV0gdWJpZnM6IHJlamVjdCBpbm9kZXMgd2l0aCBhbiBvdXQtb2YtcmFuZ2Ugc2l6ZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A36Kf94003888
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 03 Nov 2026 14:20:47 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE97D3F.002/4jJdjq6Vw7z5B0vB

validate_inode() compares inode->i_size with c->max_inode_sz only.  The
size is read from the on-flash inode node as a 64-bit value and stored
in the signed loff_t, so a value with the top bit set becomes negative
and passes the check.

The read paths then do size arithmetic with that negative value, for
example (i_size + UBIFS_BLOCK_SIZE - 1) >> UBIFS_BLOCK_SHIFT in
do_readpage() and (i_size - 1) >> PAGE_SHIFT in populate_page().
Reject such inodes like the other invalid on-flash fields.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
v2: no change since v1.

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 38972786817e..602f0cd9713f 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -71,9 +71,9 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
 	int err;
 	const struct ubifs_inode *ui = ubifs_inode(inode);
 
-	if (inode->i_size > c->max_inode_sz) {
-		ubifs_err(c, "inode is too large (%lld)",
-			  (long long)inode->i_size);
+	if (inode->i_size < 0 || inode->i_size > c->max_inode_sz) {
+		ubifs_err(c, "inode size %lld is out of range (max. is %lld)",
+			  (long long)inode->i_size, c->max_inode_sz);
 		return 1;
 	}
