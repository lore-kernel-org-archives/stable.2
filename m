Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.62.57.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793243225;
	b=F/Bdm4R4bBjukHNez/PBvnoEWmZNY59gsHAnQuwkMf9cPqwMSWWkEOOLGQuV27ipI7R0
	 Q9Nne6zN0BP8+ZU6bWstmKLccHxa5kSFpkG+qAGMx3kY8ChRfxgyG/ZHOQRcqBMxcNJd/
	 ylKur115wCunalDnpebPHO7Pa7ApUzAesgvW93MEDqPw2Qi/rn/u8w8rzA09IT5Vz7ud1
	 hWLSKYvYZulusr1etcuepcYzjBlYEHkgeUj07VwvEHotg3lCswzzl3QbXEsefjEgG3XLS
	 eOFj6APQoIuq97NhcIfc8dMOe2H5mG6iOwc2AfBiWCuV+KtCDGuXBXhwKPQU28Hf4kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793243225;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Z8/pcGuauuTDgFHjtK9D7d47BI5OIckj6msjTzMPejQ=;
	b=NaiqLh3z45iI7kUgDFw9Jyq2I0PLy2JQpgvaaU1oajgZjGa8mByh8Q9/oxnZ6rBCmegY
	 69QmbaSKyTGLgE7NGqhskS5QrxXV3NRqTcLI3b+lQEk4XCrKduRBJbFVatzlyLg/9Teyv
	 0lS4UJwbCZL9jiSt37vhOKKzEBBr/UPRB+lmjT7KnWd6vLLltIsMgA4o+Ejj99SZMiWWj
	 EQAyp6sT9phtpOsf2umKSkfBMJqpnxbqdzjn9bT9bNpbeqBgQdVFquD/kIEg0EhvzpZrA
	 US2LNkysMZTaRx8t4XaK1oQOAtE20xtqWkMFGAY2rK1FBphmyG3XnIJBoeFOKis6EBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nqbBYkk9;
	arc=none smtp.remote-ip=162.62.57.49
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE81606A31C;
	Thu, 29 Oct 2026 03:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2AE81606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nqbBYkk9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1793243212; bh=Z8/pcGuauuTDgFHjtK9D7d47BI5OIckj6msjTzMPejQ=;
	h=From:To:Cc:Subject:Date;
	b=nqbBYkk9YkeOcX4KQdgweO+iNJxq4BYEDDnB+/u5dzqTUkh15LnOIzBLP2u0c7jPN
	 V5IKiwgwGW0slbwG1dFISYx9JYUOX3GM4ElKOxhkHnRHyzm6BpFJ+S+lbGLzQgyYAd
	 QBXgLqaw1gHU/nndQAtkuhMp/2SBGaSntxJodSW0=
Received: from kernel-lab.tail5e91bb.ts.net ([2409:8950:57d:63:7875:da97:7462:bbd3])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 1B19CC08; Thu, 29 Oct 2026 11:06:49 +0800
X-QQ-mid: xmsmtpt1793243209t1bb8v49a
Message-ID: <tencent_6FF2EBE4EF5FF4F324C8DC4AD0F39588E505@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAiowY1SzQHRLlRkNSwuqXOThjZBTx7zBIzJitakXxYA4FY1vQWg
	 kMa2i/cl9WZDMmvcQO3U485+95cSBrQ6eWHRkZMLlA7+UNo269Dqlx04Hz1W3G7W6yVjioKeDsEd
	 rC8GWplyxq/U3FBpIX4nU1Mi+hGZh8jWYW+ugnFUfldVBfjjXbgf24Gdp2K1J28q2wECsSNqdZf6
	 vcSp9QUB0enbe/6DeUBOeY5/QPuhEAnB5aBa6AMbdQAEHRtRGULm8c9Xb6OtW4TA2iR5RH8srksR
	 AGbu6Yon8HHs0FT+zioJCjirNqc3Y8WdPergtQ3IP5dqlBNKWSoot8nHaIWfrGyJkCXJRR/+qLzW
	 9pxctdzJTP+T0tYlTtgmy/reXiwA6OFUoOolx8GBvNyxTdUBcr4UCQu4REJOwqhd80Pp2aJ5soI3
	 HPRoe8nGTB+Rzs/44wg3E5boHIDpWqPPv9jSSGPjinMxGkUkgj+IXucoKDQkRYjGofUAaZGnUU6d
	 TiXFSU0xVKCAeXU3tT93U3jTvVppWA/xSwIXARoOLZkBbcFuBprBm0LI5CV//6+bRZFqbFCdKTqT
	 enD7FUFTcSomHCKbD7eJFctl7DYdrvc52xWvqAn9NQZ/YtRM6O+pMg8UXDc97Bv6MJdvW2Ks3LqF
	 +Vn/NK95l90XSC2QEygwZFXgLaU9fvRe8VnWPY1dihP/2UEz1KttJfCh23ztgqgSL3vuiLUBQ9jp
	 H/gyNuIu5rZgZ9lEHac8YxxkZgDOwKuBAUfX527gZK4xVGJDjG5zxGg9+u50L1I2fchO56a6Ycbh
	 NcN6XRPVh2QDAhcMJMmKpePf2awJijPvZa3IyzbAnkz5U/J/qxj4dDrVGYhYdA60HdF1XgkxSbBa
	 DoXcdZPm6oFYvPUYzXLdSZ4c2NdGZBzuWCILRFvhc7sNqrMgWZ/Lqw0fvF96hkS9JBewsKgMX257
	 Zn3TNaW4lFNjq50cFSjg05dGsVwau5wMj1+fYVyt/XkOV2UAFlNCwFt8vBFbitwF97SDgNd7TuYG
	 6dPH3KE5kLaaoeapTzT1E1Az53zbYdz4X5NZygu/Ongy2cKPMWjUI85g2OGh8=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Yingjie Wang <1075151112@qq.com>
To: linux-usb@vger.kernel.org
Cc: Neill Kapron <nkapron@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Bingquan Chen <patzilla007@gmail.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: configfs: NUL-terminate extended property data
Date: Thu, 29 Oct 2026 11:06:49 +0800
X-OQ-MSGID: <20261029030649.292834-1-1075151112@qq.com>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Unicode extended properties account for a UTF-16 terminator in
ext_prop->data_len.  The configfs store path currently allocates only the
input bytes, so ext_prop_data_show() copies one byte past the allocation.

Use kmemdup_nul() for the configfs data so the source byte implied by the
terminator-inclusive length is present for both the configfs readback and
the descriptor conversion.

Fixes: 7419485f197c ("usb: gadget: configfs: OS Extended Properties descriptors support")

Reported-by: Bingquan Chen <patzilla007@gmail.com>
Link: https://lore.kernel.org/all/20260421141010.5607-1-patzilla007@gmail.com/
Cc: stable@vger.kernel.org

Tested: x86-64 KASAN configfs readback through a built-in RNDIS function
instance.  The baseline reports a slab-out-of-bounds read in
ext_prop_data_show(); the patched kernel reads back the expected 0x41 0x00
bytes with no KASAN report.

Signed-off-by: Yingjie Wang <1075151112@qq.com>
---
 drivers/usb/gadget/configfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 51df6d1d1487a..c302e8dd25a78 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -1351,7 +1351,7 @@ static ssize_t ext_prop_data_store(struct config_item *item,
 
 	if (page[len - 1] == '\n' || page[len - 1] == '\0')
 		--len;
-	new_data = kmemdup(page, len, GFP_KERNEL);
+	new_data = kmemdup_nul(page, len, GFP_KERNEL);
 	if (!new_data)
 		return -ENOMEM;
 

base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
-- 
2.43.0

