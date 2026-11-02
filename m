Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=183.62.165.209
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793627153;
	b=cLnjxAhSP16+dUcGxisvIyQKPuwM6mXFerOcSNyBHqoRJpeJHDEx4PCB7Eqlb+WXJbAD
	 6kEWgHnTxa6+ruTo18DqZt9Fy3/7qgAS1DUKU6tCJ9LfO84mP5gzNShHQv6VWgGnUDPUy
	 8DW+iw9Vcklb4SVsYn8ESZZz/+3c9xRuHoV8cP5X0tepcwHC7Y0Zg3KM9gYCFOaf61Qq8
	 D0OrkFiW735gHdP2+jDN0OR6uuWHI7xw9rpkNsZkHYInhFykc5XucxnchydYRdlS4dSak
	 QC3j3f/FXHCjXhpcDUsADRtAlcyD7H8O1ryGPFr4KCLITOem4yEydhuA+cG8zCrJnYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793627153;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=yD4Vavq9bkAU37YHIzdyZESn81dXRsb4B/zIIv/Tc/s=;
	b=4v3/I1w60MHXMRfOBz79LBS25D1GbxIFJRblqjE2nikOmuycO9vDfFPIDWJQ0rdR7RnE
	 bLhXhKkh2LJszPHldY6jpObd7ytiO7aLakZVa3KfiDE8zjetqMSzAyEcoLfES6ZleQRZ/
	 1F1+FZDIueyXDLK/bFS3REanDj/S8S5TXTtatlql93U/bC8SfNfJBg9E8BIrJy/xQKGu8
	 8D0fivBbMYPXkd3AolwRwD+6nC1ay6pGs+b0HQMVT5awnxrlnFVMSHSFwsO/6kIjFH1wl
	 2M/i24uSPv9pcoKE9PTGMVvSqhDvVwkHDZehP/YN8kN0UnEvNxdqUh0dV7jTM1r3LGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=183.62.165.209
Received: from mxct.zte.com.cn (mxct.zte.com.cn [183.62.165.209])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0910D606A32E;
	Mon,  2 Nov 2026 13:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0910D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxct.zte.com.cn (FangMail) with ESMTPS id 4jJCdh61ghz57HRy;
	Mon, 02 Nov 2026 21:45:44 +0800 (CST)
Received: from xaxapp02.zte.com.cn ([10.88.97.241])
	by mse-fl1.zte.com.cn with SMTP id 6A2DjXWh050750;
	Mon, 2 Nov 2026 21:45:33 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp02[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 2 Nov 2026 21:45:36 +0800 (CST)
X-Zmail-TransId: 2afa6ae89400676-0f478
X-Mailer: Zmail v1.0
Message-ID: <20261102214536590UewltJeUMBYjmXfdz0jD-@zte.com.cn>
In-Reply-To: <20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn>
References: 20261102214531231UAVA89ay_BDVcwFmrv8cq@zte.com.cn
Date: Mon, 2 Nov 2026 21:45:36 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIDEvNV0gdWJpZnM6IHJlamVjdCBpbm9kZXMgd2l0aCBhbiBvdXQtb2YtcmFuZ2Ugc2l6ZQ==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 6A2DjXWh050750
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.132 unknown Mon, 02 Nov 2026 21:45:44 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE89408.001/4jJCdh61ghz57HRy

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
