Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AEB49E143
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 15:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791301209; cv=none; b=EE9LUUg/G+DpXmxpfVZlnLTciCHlj9JmEFOlFsr5JsIQZeL+Sqj4Pqv79kdriEB52j2I7W4XbnZ88H7X5T4dzeSd+4n/Ymhkn4ZBHaJOHLbzrWrfRe3kRVTKLDOSUNLKq6nZXCHpEWGiLLVgkH8fxvC2wCSownixA3y8YnvUGUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791301209; c=relaxed/simple;
	bh=87rBMjuHSwgcIW9zbyUqSCSSXM4iNU4iFbXIteEHpg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ILbsSIAiwxKU16Tr9w/CUgyaP36VM6PVRKKPhhjYtfRW5Hn3ox3zF7DUBeD9v0wSaDvPDpWRXQihjBfppNTyYMk5C2prFDBFRDoEu63rNSwATOj0bGE44EIiMgeAxi6XTcuagGNBYJK9KJfPinEKrvRpmJgh79Oun5Py0bQo8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnMVmh42; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnMVmh42"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E4891F0089B;
	Tue,  6 Oct 2026 15:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791301208;
	bh=E8nidy6r1FDiL2AuROqTkoFo10wK5TfHDzSGKTcDIek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BnMVmh42PkCgVi80y0SX6e6M5I3NHAvBDkMjcvMbZx3qOFYnGx9cnLOHylgF8XO5M
	 Slsyy8fxuvQ3WGqoApCOoEUkFMkuMlwC2gkUw4bTG1cpiwm18NQpAU3R1SULEHqcoc
	 mGIKy7WOQRYvfFY36B5DOpJ7orKf3UVylkBTHThtcfZuHi22K1FE7SS9uUhHu2qJ4e
	 d2p6X6evj+CIXfS218dzeT3shfo9yY6KV8IdFpY3S4QxCFHkvGiZHyZ0Xg1F0mpvK3
	 HARqKkifav3fCJP6ajnKgTotQ+Q6+SJCIM4Wr0OI2dWQf5WjQvwEVA/v4wkYyutxIt
	 fhxvVs/oSPXrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com,
	=?UTF-8?q?J=C3=B6rn=20Engel?= <joern@barelysecure.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] mtd: block2mtd: Fix divide error when erase_size is zero
Date: Tue,  6 Oct 2026 11:40:01 -0400
Message-ID: <20261006153928.760780-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006153928.760780-1-sashal@kernel.org>
References: <2026100520-kilogram-result-00fb@gregkh>
 <20261006153928.760780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Pei Xiao <xiaopei01@kylinos.cn>

[ Upstream commit b5965c4221165045e19736794ca5f48ae3d67142 ]

The erase size is parsed from the "block2mtd" module parameter and can
be set to zero. add_device() then evaluates

        if (size % erase_size)

with a zero divisor, which triggers a divide error:

divide error: 0000 [#1] PREEMPT SMP PTI
RIP: 0010:add_device drivers/mtd/devices/block2mtd.c:296 [inline]
RIP: 0010:block2mtd_setup2+0x592/0xda0 drivers/mtd/devices/block2mtd.c:459
Call Trace:
block2mtd_setup+0x27/0xe0 drivers/mtd/devices/block2mtd.c:476
param_attr_store+0x214/0x310 kernel/params.c:589
module_attr_store+0x65/0x90 kernel/params.c:904
kernfs_fop_write_iter+0x3a4/0x540 fs/kernfs/file.c:345
...

Reject a zero erase size before performing the modulo operation so the
existing "erasesize must be a divisor of device size" error path
reports the invalid argument and frees the device.

Fixes: ea6d833a3fdd ("mtd: block2mtd: check device size")
Reported-by: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6a7b58ba.ac361c09.22ff0a.0045.GAE@google.com/
Suggested-by: Jörn Engel <joern@barelysecure.org>
Cc: stable@vger.kernel.org
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/block2mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 502c30124aa61..1eb6bcab7adc6 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -297,7 +297,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	}
 
 	size = bdev_nr_bytes(bdev);
-	if ((long)size % erase_size) {
+	if (!erase_size || (long)size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
-- 
2.53.0

