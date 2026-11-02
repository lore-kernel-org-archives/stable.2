Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627385;
	b=YxUZo0wGjrFuEJSQm4T6o0HH2UfXw/u3C5mPPxvhoyD4CyordtJfkQoJf0w1TM3DGHFO
	 wnEon/XTOBySQqK0CJznbW6KAWvfAhsgWQJvyHwLOu8F+p/CIAxSIalomGTrQK8tn2KWt
	 17l+ZvVZ31FBGgsCDfpscEEuBunUARubxYjOmgPm+O2uDQHBJpVTwI1kcpKgnW299QPIV
	 9xodDAiDGL+1NWFbq30a2/BKl6ZgS6stFP9X5+xiWsrwn+VWU0OGIoOnP3F5HyKO9dBlg
	 Px2LUOEnmrKhjBoI/OV4GxEaiaolnW6GLRK4UYAPi+RSfhKzg/rAnqjL3QB/Us7uJ9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627385;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=6cvgVMoPYt/reZdqbQhO6yAzIHruJWWmPF0VYpvrEII=;
	b=TnrGjOI4QMSuid7l7n4wtCsl0DUeh7ShiLE6touk1YGAI0WOdAR5w/hYm72GmU2CWKe/
	 zaTD1ZWdsTNuIdVYp3Q5hMT3LeK/6u9wnGN14v7XyatAaM/sjmWG+s0svTf1pqplHGR2Q
	 lMr3B9Caa2ckwqbHZM8gshlQW8HcEaIb8yVElOT2fuARROFgEuBarhML0lJ1VmP4jhLrE
	 9CjFEvY9O5dhT7BabRs2fh+AkmkCd706To/uhThnHozbYcFq4zwbvpOjOFgjR8hq0LKAM
	 QITaxaYRiP4I2KaqOjWMFyy9CsbuPx+893HRbjzf+O2gwOJ4nnDX9A9yYThfqd0UcQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EB4606A326;
	Mon,  2 Nov 2026 13:49:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79EB4606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJCkG698hz8XrrM;
	Mon, 02 Nov 2026 21:49:42 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A2DnWDW052816;
	Mon, 2 Nov 2026 21:49:32 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp05[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 21:49:34 +0800 (CST)
X-Zmail-TransId: 2afc6ae894ee124-0ff25
X-Mailer: Zmail v1.0
Message-ID: <20261102214934411GPsnXXiPDuCvO4pgPeTgU@zte.com.cn>
In-Reply-To: <20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn>
References: 20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn
Date: Mon, 2 Nov 2026 21:49:34 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDIvNV0gdWJpZnM6IHJlamVjdCB4YXR0ciBpbm9kZXMgd2hvc2Ugc2l6ZSBkb2VzIG5vdCBtYXRjaCB0aGUgdmFsdWU=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A2DnWDW052816
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 02 Nov 2026 21:49:42 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE894F6.000/4jJCkG698hz8XrrM

An extended attribute inode stores the value in the inode node and
UBIFS keeps inode->i_size equal to ubifs_inode->data_len (see
create_xattr() and change_xattr()).  validate_inode() does not check
this for inodes that carry UBIFS_XATTR_FL, so an image with a mismatch
is accepted.  ubifs_xattr_get() and remove_xattr() then trip their
ubifs_assert() on the invariant; with the assert=read-only or
assert=panic mount option a plain getxattr() or removexattr() turns the
file system read-only or panics the kernel.

Reject such inodes at iget time.

Fixes: 1e51764a3c2a ("UBIFS: add new flash file system")
Cc: stable@vger.kernel.org
Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
---
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 38972786817e..9f608c10b39e 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -91,6 +91,18 @@ static int validate_inode(struct ubifs_info *c, const struct inode *inode)
 	if (ui->xattr && !S_ISREG(inode->i_mode))
 		return 5;
 
+	/*
+	 * Extended attribute inodes keep the value in the inode node and
+	 * maintain i_size == data_len everywhere (see create_xattr() and
+	 * change_xattr()).
+	 */
+	if (ui->xattr && inode->i_size != ui->data_len) {
+		ubifs_err(c, "xattr inode %llu has size %lld, but %d bytes of data",
+			  inode->i_ino, (long long)inode->i_size,
+			  ui->data_len);
+		return 6;
+	}
+
 	if (!ubifs_compr_present(c, ui->compr_type)) {
 		ubifs_warn(c, "inode %llu uses '%s' compression, but it was not compiled in",
 			   inode->i_ino, ubifs_compr_name(c, ui->compr_type));
