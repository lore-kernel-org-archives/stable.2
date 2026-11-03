Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=160.30.148.35
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793687278;
	b=GtESnAgtHcaYBRbBG5DyXY5Y1EUCiz7Pa7MWH5t3swdPUqwEgWyiyIqTyQpMhdfzdLjo
	 ZI5koPpSgUuu4929poIE9XLHV3+iwmyobkiFtU90pfZxAhDF7Sm2F3ID3lN70HacVn9E4
	 +lezyVNjU25fk7MoUTGE/UnLAZi8gmKweMH8IjKFqEuoMsYZrmy6vHZCOAxb20S7muKVV
	 +U31yi4NZRqqKoLgs3D1JF/zP0nMA62JVTN8IuLkitXct4iy1mAGHkeFht3vRW7HwdXit
	 0rIvhdmDlBu+yyJc+na06JEGFAIBRfwlw086ZvwfJAPcOKNLc5oAIsxs6cvvLzR+1Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793687278;
	h=DMARC-Filter:Received:Received:Received:X-Zmail-TransId:X-Mailer:
	 Message-ID:In-Reply-To:References:Date:Mime-Version:From:To:Cc:
	 Subject:Content-Type:X-MAIL:X-TLS:X-ENVELOPE-SENDER:X-SOURCE-IP:
	 X-CLEAN:X-Fangmail-Anti-Spam-Filtered:X-Fangmail-MID-QID;
	bh=4/mZIo+pI7ccFeJJn9NvJ96K6eMwQetl4MbSJhidZfk=;
	b=sDng4huDy4C5Emp0iV1sQsCP530pzwPEl38NOUlIOmX11xh7Yw1RBcpS8RuxbBi48gSi
	 W3vNE/S9WeI2o87ensu5xDuBbHKQH7AcEBwaHNwseU1R7+zkPm9sHC8S4X8fO8Pg8keP8
	 Xk7WSfZYCSb8IUbOoIcs5s39ElFkOqYlj/GfbmZoTLrnGctdP+U4s2dH5/Djqmx3RV86D
	 mm2Y1VJ0AHEW8WYHEYSj/s1UgI9/sXzIFk4O++3kOd6y4hK3gHbyd0h6hSaZcm6IbJbsi
	 ubXVnIDdlYetlUZgWrXPuC4DVsCFJigKwOtVaNnQtEnw7qSXaQOZh1TECWGv5I416SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=zte.com.cn;
	spf=pass smtp.mailfrom=zte.com.cn;
	arc=none smtp.remote-ip=160.30.148.35
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F939606A324;
	Tue,  3 Nov 2026 06:27:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F939606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4jJdt41T1rz8Xrrr;
	Tue, 03 Nov 2026 14:27:56 +0800 (CST)
Received: from xaxapp04.zte.com.cn ([10.99.98.157])
	by mse-fl2.zte.com.cn with SMTP id 6A36Rp8b030279;
	Tue, 3 Nov 2026 14:27:51 +0800 (+08)
	(envelope-from shao.mingyin@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 3 Nov 2026 14:27:52 +0800 (CST)
X-Zmail-TransId: 2af96ae97ee8e66-d57a6
X-Mailer: Zmail v1.0
Message-ID: <20261103142752814S2rewzbXLcvuKGHsZ9hUB@zte.com.cn>
In-Reply-To: <202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn>
References: 202611031419019991s0Y8mllWsWU1CBrr87AS@zte.com.cn
Date: Tue, 3 Nov 2026 14:27:52 +0800 (CST)
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
Subject: =?UTF-8?B?W1BBVENIIHYyIDUvNV0gdWJpZnM6IHhhdHRyOiBndWFyZCBhZ2FpbnN0IHhhdHRyIGFjY291bnRpbmcgdW5kZXJmbG93?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 6A36Rp8b030279
X-TLS: YES
X-ENVELOPE-SENDER: shao.mingyin@zte.com.cn
X-SOURCE-IP: 10.5.228.133 unknown Tue, 03 Nov 2026 14:27:56 +0800
X-CLEAN: YES
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6AE97EEC.001/4jJdt41T1rz8Xrrr

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
v2: no change since v1.

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
