Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E7545C70A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791303094; cv=none; b=rwzOaQ2ddaz76LBBTO4H8isB9PSKzFr56pydgk3LUuXyMGDxZV9eZjKwpcDLfvQPdWl2e1iNIJ0l8dfJW/+ZDJIhJcNn9GIQRRh5noPA3EUj9Hucba6nCq53QvwZA1qbts4ndTZWavVb0DTmFwgK5Y+501zhzODDOJjhmb1vaBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791303094; c=relaxed/simple;
	bh=japs/fcAQ4/BfZecpPI1Gs2j3JS3M4ehmU1F8+0pbHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyB+fDAYPFmqvog+LmW9Qdlv3bYMs4QAD12CG33bfUG6WILpaeKiFW9mThARqncExu7/1Jn+n/EYrjSlAvfnZGEIR3XvFNyP6vQlHSLW/lfZIzv5XokPNMNwDi5c+FHrYvZTp5REE3RrS3mPYLCPzCmQjqRUMpS1FmwVH2No3YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZyBC2EVL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZyBC2EVL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 593561F0089B;
	Tue,  6 Oct 2026 16:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791303092;
	bh=5/F+4wSotr1+g4fNSRdrhonIN2jm6a3jmBZDanLcRpU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZyBC2EVL5RiNENw7BBu6mM3xhmaz5OX9qiUxKx1HvaqgPFKAx4yp/J0MlQjZk0sDS
	 oTBXynhiMvm23J86WA+R+yeko0+9cOxHKQ5DTgZ1qAqMnbeepYLD7ai6GriXHx2MqJ
	 FU07/hg7VsuNGh+6gEZJlyvVB2LQBMlCHMjC+azjWQzVsbU69L/rsxAOYvZA2EMpLg
	 qQBLtiJSjCSyzMkMGHXWK6/GrAJ6VIobhybS5ySNt0V4T2Sxj8BbO+ihSFy6KWFqpD
	 NMsiAXFz7xiJca6Juh58P1Xb0p+RTvUiXfu/FsPKffcL9s5FxlbybqkgmjJDHv4F7u
	 kpHMekYN51nyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com,
	=?UTF-8?q?J=C3=B6rn=20Engel?= <joern@barelysecure.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mtd: block2mtd: Fix divide error when erase_size is zero
Date: Tue,  6 Oct 2026 12:11:29 -0400
Message-ID: <20261006161106.855855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100520-mothball-imaging-d7cd@gregkh>
References: <2026100520-mothball-imaging-d7cd@gregkh>
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
[ sashal: Replaced the upstream local size variable with the existing direct dev->blkdev->bd_inode->i_size expression. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/block2mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 4cd37ec45762b..9175196110c6d 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -272,7 +272,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)dev->blkdev->bd_inode->i_size % erase_size) {
+	if (!erase_size || (long)dev->blkdev->bd_inode->i_size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
-- 
2.53.0

