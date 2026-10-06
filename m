Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104C23769FD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 17:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791309387; cv=none; b=WyjZlEhjjqkpPxUBtXBCjbNMHLoKZP9IU/mVswBu3uBc7RWrNbz/iFCfc5TPWgfr4H7lMloNpnNircwjAq7tA0Y6GPJMpbrKW5usXybyOB3Rsx0pXcAKtDLo/YH2gppssJHiITQcz6rZgWnQQhCDsADfETjlBZ0TC2Ko+zAtMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791309387; c=relaxed/simple;
	bh=7OqlaBVOFGq5BVe00QnCCDTcIdbpiE5GbyP1aAX2fWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiPp5YA3wRlJsE+Xzrx3HlEUPQuiKyVzjnF3fo9GxBynPPsD8VFXSI1OMNAb/BAK7/6YJ6qPFu3Grn9BWlW6vO5yDu0osAXWQLt/sJU4Yvlll3ZYBqL1f+DN0oOPi2DsxTZCWd6EE4E8DrMxFtK1pixsAoSp2HZQqPav6R8pccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9a+jfRo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9a+jfRo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3281E1F0089B;
	Tue,  6 Oct 2026 17:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791309385;
	bh=oAYC1rMqrPLjHdbCHVTvypx9wj+1i8qPGdo6FQNpwzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k9a+jfRoI/NSnxlbZoe8G0CXugkN4lfL/3fgR/KOqvv0pfiKbn7ZkFQyYt+ua554g
	 /rkULw87BNINHkyvIY70MN41no5+EimoWc4v7cDb5lu6aHGMmNI0GVfz0TjskRodzo
	 uUbqJid9mu6k+Ow9gN7MWB9o11302DvciMaaO3JoCTidRMAsfW8Fof6fCeL+eZ/BtK
	 Qa1RbUXL0iBw7+cNlYpzVDYEkvKUL+V36oGaMeULYV8wqBeY0lIJD+0KAioR+85puz
	 Lrbqcs7L7Z4iPOqEHllosCvAH/s5jYPqPiq+yUt3aJRdmLyG1ls/aYEMfdJ+hojdjH
	 u4vi6Fb10ZB7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com,
	=?UTF-8?q?J=C3=B6rn=20Engel?= <joern@barelysecure.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mtd: block2mtd: Fix divide error when erase_size is zero
Date: Tue,  6 Oct 2026 13:56:21 -0400
Message-ID: <20261006175531.911606-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100520-cartridge-uptight-2ae4@gregkh>
References: <2026100520-cartridge-uptight-2ae4@gregkh>
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
[ sashal: adapted the size variable check to direct dev->blkdev->bd_inode->i_size access ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/devices/block2mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index c08721b11642b..58ec5d0525ec2 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -269,7 +269,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 		goto err_free_block2mtd;
 	}
 
-	if ((long)dev->blkdev->bd_inode->i_size % erase_size) {
+	if (!erase_size || (long)dev->blkdev->bd_inode->i_size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
-- 
2.53.0

