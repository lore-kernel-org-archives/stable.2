Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627389;
	b=WnvpllVkTSXFIRE7+9D2d6is/+Sw4jRp0sdN2YuhzPzTM0e2qbZ2/xeJ/XZhj6O6gn3c
	 1zhbaFH7Zw+o6RLFqqrLw0CsZ0StwPo/vAUVtY6DtUnWasNgBxyF1k1Auk5bOnyffieDC
	 uscb9Vd2kES6Kvvc5aE3YhuZmC6lKldJIDHPamcpKpSeyVPhrYPYNJ6OezyWpq7+wQiil
	 jiOd/yVywdQHEasVfl4nZr1TB3e8l+GtQqyE9loZ77i4Gqsio3OncDB56yqWqghuRkPQu
	 gtO2u791tkoxw4cKSfiw/jV++8zsjw7XliGAtdQtw5dI41VU7IIgI+4Q3SZx/hm+WQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627389;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=NiBTq//LWE5GTLDlIBQbX/H/OaXMeM5oOQdiT4OlOJQ=;
	b=x31Qmr7xr8O4zMqJ47ONTA627+I+0OJy9L5I8mAmq9/eETY9zROgE3PlWzInwgZqIbtL
	 w19y6i2MlFyXmfpA4bqTnxu1sHU3KexJC2ixIMW6fDJx7sgCcvw4t6S/wcFIwku93/sjs
	 heGGh1lUxKOm6SEI+UluIxDma34AlYyc3sVYJVbBkbksL5Jz+By7DtV4frKl5+llGcAe3
	 5Z6gNjeoL7Nd/BeFUOVUe5Of1FGtGPYdVtSa2k0wQLFk0bnpjLhWhk2daSPy95pU2mZN3
	 xs+EgNRu54vdfWCXAeiorQ2t/uWR1oel/0WT1cH5M+eVUaLKHsDROL6szZjUjV+4sbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B5D606A326;
	Mon,  2 Nov 2026 13:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04B5D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJCkK6RBLz8Xrrd;
	Mon, 02 Nov 2026 21:49:45 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl2.zte.com.cn with SMTP id 6A2DnYXk086900;
	Mon, 2 Nov 2026 21:49:35 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 21:49:38 +0800 (CST)
X-Zmail-TransId: 2afa6ae894f2e3f-13c3d
X-Mailer: Zmail v1.0
Message-ID: <20261102214938084lkSjY-NeV3uJHrOe4-w9Y@zte.com.cn>
In-Reply-To: <20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn>
References: 20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn
Date: Mon, 2 Nov 2026 21:49:38 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDUvNV0gdWJpZnM6IHhhdHRyOiBndWFyZCBhZ2FpbnN0IHhhdHRyIGFjY291bnRpbmcgdW5kZXJmbG93?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A2DnYXk086900
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Mon, 02 Nov 2026 21:49:45 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE894F9.000/4jJCkK6RBLz8Xrrd

remove_xattr() decrements the host inode's xattr counters, which are
stored on flash.  An image can contain an xattr entry for an inode
whose counters are already zero or smaller than the entry.  The
unsigned counters then wrap, and ubifs_jnl_delete_xattr() writes the
bogus values back to flash.  On the next mount validate_inode() rejects
the inode because xattr_names + xattr_cnt exceeds XATTR_LIST_MAX, so a
single removexattr() turns a mountable image into one that cannot be
mounted.

Refuse the operation when the accounting cannot be decremented.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/xattr.c b/fs/ubifs/xattr.c
index 3b0e8a270f59..8f0447de94f0 100644
--- a/fs/ubifs/xattr.c
+++ b/fs/ubifs/xattr.c
@@ -456,6 +456,21 @@ static int remove_xattr(struct ubifs_info *c, struct inode *host,
 
 	ubifs_assert(c, ui->data_len == inode->i_size);
 
+	/*
+	 * The per-inode xattr accounting is stored on flash and can disagree
+	 * with the entries found in the TNC.  Do not let a corrupted image
+	 * underflow the counters, because the bogus values would then be
+	 * written back to flash by ubifs_jnl_delete_xattr().
+	 */
+	if (!host_ui->xattr_cnt ||
+	    host_ui->xattr_names < fname_len(nm) ||
+	    host_ui->xattr_size < CALC_DENT_SIZE(fname_len(nm)) +
+				   CALC_XATTR_BYTES(ui->data_len)) {
+		ubifs_err(c, "xattr accounting mismatch for inode %llu",
+			  host->i_ino);
+		return -EUCLEAN;
+	}
+
 	err = ubifs_budget_space(c, &req);
 	if (err)
 		return err;
