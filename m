Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687022;
	b=JILkPikLGrteQtrZoVb6pWQZzbhcKBWJbkuRRs+6Z5FektJTBZr/E3LpkRg4Wy8aT8FH
	 w959BeN5X70wm+JupBfyZmkahSeCAtUErIqcA5kKE+WNQXQiSMaIvlHtO4mn8JrcczxwH
	 QHtEF7Z7TJolkpVqpJo1y0p2YVeVMy8IFCZLoq2wno2S1yDciv0nBz+n608maqj0qpVBA
	 0wcj9H2q4LHYZYa2Gi1FNnWCB6Twq4gD97GFjYTi5iaYfGt5R0Y5JCDCcD72LppBuViDB
	 GxvGw0nc04d6VKvDyX4nUsGSrOCwA6iUsygFKoWdDJUh7MJsXPGUMw91AI/Ty23M60g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687022;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=Tp7SfFYxSlLXTVfAdm3a9JRIK4fnpGCJrEGCtDnJwNE=;
	b=R+9z4WrAjiw4E75cDuAikfDvz+0D8ATk0lPEdMENYFdZmfIwERWHzLWiY/WeA7QzH+r5
	 SzeN7CP4ydm/ijOafwafGTGp+0f/f5C6Ku85mC5Q88muwoqEGnqIdZimhZkzBagCPraPG
	 VjJHodT8CaAO2JyYy0gJJu0NwHm5PdmggsWa7oe10UDS4s7cIvsT+P4pxiukI/PKa1avx
	 k46lrc+3FS0Nm3tgZ15pHmBuS2HqzoQHMW2du7IJkW78tLMMjCI2j4gmCs5t5H3Dy69IF
	 7N1qKQhIy1jsbmqA+b7DI4mTC4SAwX4aWLVHOhI6q7NAILy5frnBkvLZONRfRAgtsEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.34
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D71606A32D;
	Tue,  3 Nov 2026 06:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0D71606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJdn76hTWz5B0t4;
	Tue, 03 Nov 2026 14:23:39 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl1.zte.com.cn with SMTP id 6A36NSf8008109;
	Tue, 3 Nov 2026 14:23:28 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 14:23:30 +0800 (CST)
X-Zmail-TransId: 2afa6ae97de223e-ceb84
X-Mailer: Zmail v1.0
Message-ID: <20261103142330670pHApJBK7YKHkUyzKIGpKY@zte.com.cn>
In-Reply-To: <202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn>
References: 202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn
Date: Tue, 3 Nov 2026 14:23:30 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDIvNV0gdWJpZnM6IHJlamVjdCB4YXR0ciBpbm9kZXMgd2hvc2Ugc2l6ZSBkb2VzIG5vdCBtYXRjaCB0aGUgdmFsdWU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A36NSf8008109
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Tue, 03 Nov 2026 14:23:39 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE97DEB.001/4jJdn76hTWz5B0t4

v2: merge the new size check into the existing ui->xattr block, as
    suggested by Zhihao Cheng.

diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 38972786817e..d89dd76a6847 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -88,8 +88,22 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
 	if (ui->data_len < 0 || ui->data_len > UBIFS_MAX_INO_DATA)
 		return 4;
 
-	if (ui->xattr && !S_ISREG(inode->i_mode))
-		return 5;
+	if (ui->xattr) {
+		if (!S_ISREG(inode->i_mode))
+			return 5;
+
+		/*
+		 * Extended attribute inodes keep the value in the inode node
+		 * and maintain i_size == data_len everywhere (see
+		 * create_xattr() and change_xattr()).
+		 */
+		if (inode->i_size != ui->data_len) {
+			ubifs_err(c, "xattr inode %llu has size %lld, but %d bytes of data",
+				  inode->i_ino, (long long)inode->i_size,
+				  ui->data_len);
+			return 6;
+		}
+	}
 
 	if (!ubifs_compr_present(c, ui->compr_type)) {
 		ubifs_warn(c, "inode %llu uses '%s' compression, but it was not compiled in",
