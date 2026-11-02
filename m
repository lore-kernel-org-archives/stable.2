Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793621620;
	b=WGR4n1CLjrWxvp8WRkWR+n2Zq4CoPbnzLeRvFiKHQm8z7L1o46NQUZMveObK8lMeaq9L
	 QGWV0kHpRAt1/9pBfsfhDAHavPFDNy4Bh3df9/s4cIm9JNhVhHeMsViRB8TlepwQDDEv+
	 TBTZtibv5wUsr4GT+u9TS4jlrdYmHnEBHn6sx/G/jOwaJzVhbqpIYjMiPi06vXFx/mx+K
	 QtgAdPHeYnUw+V+oLGi2r5C3OA8cz9rblRZTnGR7VSxSuLqDF/dQljJhZA0H57qQRJFBF
	 qODndp2vFPABx8IgimqpTqSPM+mbJwiZ45FCQE28UP7E7u74kCse+xdg4GSLF2eQSwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793621620;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=NWBSo6JiDET5m/Z7QDrfEi5ti+8jerlMRY0F8wuR4vs=;
	b=ekYjLSjqaXXy64tCyJWVG2ArtakPHAVfBlWVPrrey62HCYeuOs8qlPDHl1diywbABUOx
	 ijRkDjDwuieAM7B4cxSvajzmgRhsF33dSJVUYwm9VmLJwqZFT9KBYnj586m+fGDYD6OeK
	 VQFcxVoVflBHZhtPIpGrur3H8nRuVRrA/GXPtUK5UblsDT2lQ/jZt2SH2aiOMoWLpN4K4
	 vriTklXZbaPR3bNW2SiT3s8/vvhaacOtrE4e5VngCw7vt/HQ+dX1dNPZBkJGeyEk2WdkC
	 jyYV5H5+2juMhkjhVK6hY0tm7uIpvU+cGUHaJJIWOYU3h8cy7L+Jn+9Fq0AAqf8B/fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BAF606A324;
	Mon,  2 Nov 2026 12:13:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37BAF606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJ9bN4lKnz8Xs71;
	Mon, 02 Nov 2026 20:13:36 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A2CDWDP023757;
	Mon, 2 Nov 2026 20:13:32 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 20:13:35 +0800 (CST)
X-Zmail-TransId: 2af96ae87e6ff91-9de04
X-Mailer: Zmail v1.0
Message-ID: <20261102201335478iPmq9rQKEkewCIq9T4RAb@zte.com.cn>
In-Reply-To: <20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn>
References: 20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn
Date: Mon, 2 Nov 2026 20:13:35 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvM10gdWJpZnM6IHhhdHRyOiBwcmVzZXJ2ZSB0aGUgZW5jcnlwdGlvbiBmbGFnIHdoZW4gY3JlYXRpb24gZmFpbHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A2CDWDP023757
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 20:13:36 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE87E70.001/4jJ9bN4lKnz8Xs71

create_xattr() clears UBIFS_CRYPT_FL in its error path regardless of
whether this call set the flag.  The flag is also set for every inode
that already carries an encryption context, so a failed setxattr() on
such an inode clears it from the in-memory inode.  The next inode write
then packs ui->flags without UBIFS_CRYPT_FL, and after the next mount
the inode is no longer treated as encrypted although its names and data
still are.  ubifs_jnl_update() can fail before anything is written, for
example when its journal buffer cannot be allocated.

Remember whether this call actually set the flag and only clear it in
that case.

Fixes: d475a507457b ("ubifs: Add skeleton for fscrypto")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 3b0e8a270f59..7f82ddb9e3f2 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -69,6 +69,7 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 			const struct fscrypt_name *nm, const void *value, int size)
 {
 	int err, names_len;
+	bool set_crypt = false;
 	struct inode *inode;
 	struct ubifs_inode *ui, *host_ui = ubifs_inode(host);
 	struct ubifs_budget_req req = { .new_ino = 1, .new_dent = 1,
@@ -133,8 +134,10 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 	 * To avoid multiple updates of the same inode in the same operation,
 	 * let's do it here.
 	 */
-	if (strcmp(fname_name(nm), UBIFS_XATTR_NAME_ENCRYPTION_CONTEXT) == 0)
+	if (strcmp(fname_name(nm), UBIFS_XATTR_NAME_ENCRYPTION_CONTEXT) == 0) {
+		set_crypt = !(host_ui->flags & UBIFS_CRYPT_FL);
 		host_ui->flags |= UBIFS_CRYPT_FL;
+	}

 	err = ubifs_jnl_update(c, host, nm, inode, 0, 1, 0);
 	if (err)
@@ -152,7 +155,8 @@ static int create_xattr(struct ubifs_info *c, struct inode *host,
 	host_ui->xattr_size -= CALC_DENT_SIZE(fname_len(nm));
 	host_ui->xattr_size -= CALC_XATTR_BYTES(size);
 	host_ui->xattr_names -= fname_len(nm);
-	host_ui->flags &= ~UBIFS_CRYPT_FL;
+	if (set_crypt)
+		host_ui->flags &= ~UBIFS_CRYPT_FL;
 	mutex_unlock(&host_ui->ui_mutex);
 out_free:
 	make_bad_inode(inode);
