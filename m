Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793620598;
	b=IOBUvrxVOJ9Ew9YoQ+1dMorShqYyDDuXTQ7Nd2Ve4NrouWC+v6NKS9ZFVwlWn68PIfvc
	 qUIrIFAF58/XpEVfANHpIE7lkZOvqTIJRZPmpOfd5qWXX6rxmsQT/I2SyawrcskRzRnpg
	 hFD8DSuPhranoKmW5Uv4y5P+ogqkaVZIAR8b8E/q38deHRK4wPLT8QJr/nv3WkMkSnyh/
	 C9z7kVhIiCXpYRguOpHg4T15/4i1vZCSFd6r4eTZFhvC6YKJuCpPnDEJ922Xg6Xl8xeT1
	 Zy+2U+J3XD4SbV914XPNvPKeTjgOI257xHqKEZGjDoadTfgm615thR5am3aKS+8Ujiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793620598;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:References:Date:Mime-Version:From:To:Subject:Content-Type:
	 X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:X-CLEAN:
	 X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=NWBSo6JiDET5m/Z7QDrfEi5ti+8jerlMRY0F8wuR4vs=;
	b=aOreqq0cBm5Mmma6Vz0my7OFsA7wzNjD8Dep4aT47/i6myMo+o4crX3todbhiw1wFG2L
	 fKwctCnDr99cahKhjG79SoRtzmrKE6JauoIa5oIqNLvQrM8i7pV5K0aGDIgEhRdNV2eCb
	 Fpe2UB8B22n1bkvkbffW4g2gMifct/mxYKD+2QhHReHzLNSWpiJNaUvhJOU4kW/Klw0q9
	 z4+bi+mBOd9ThSHOaqB88xeFkCO9jr8kWKZzaLAgcf00b7n5GcojHgyOEPpJnLfgMUqaV
	 KJB724sasyC5J+iZ0SlwHGiXMb5F2sxLCYqufK7uARB2ZwMXUJbnYsEztxqiaAgPVzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE52606A329;
	Mon,  2 Nov 2026 11:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAE52606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJ9Ck0wC0z4yjjH;
	Mon, 02 Nov 2026 19:56:34 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl2.zte.com.cn with SMTP id 6A2BuM8j007548;
	Mon, 2 Nov 2026 19:56:22 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 19:56:25 +0800 (CST)
X-Zmail-TransId: 2afa6ae87a69acd-8295b
X-Mailer: Zmail v1.0
Message-ID: <20261102195625207uxpYcc94_VO6Ir71GcQ99@zte.com.cn>
References: 20261102195030814Aeehrb4WmExc085745ldN@zte.com.cn
Date: Mon, 2 Nov 2026 19:56:25 +0800 (CST)
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
To: <richard@nod.at>, <linux-mtd@lists.infradead.org>,
        <chengzhihao1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIDIvM10gdWJpZnM6IHhhdHRyOiBwcmVzZXJ2ZSB0aGUgZW5jcnlwdGlvbiBmbGFnIHdoZW4gY3JlYXRpb24gZmFpbHM=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A2BuM8j007548
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 19:56:34 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE87A72.000/4jJ9Ck0wC0z4yjjH

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
