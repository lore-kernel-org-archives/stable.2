Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE773DDB04
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 21:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322357; cv=none; b=jg8NYgEG5urrSvHL3Ab6LUMAV1Z/mTtpT116Hqqo70tej2FZETiVQJ3Yafr2OFLfnLDyXI/jDp6jNbTfOjIT/GSHFM3Sz6J/SWXSmVlQOdZOlkC3lYoNHD5zJz9SnDG7+PDswn/WLt2lgUkcZtic840okUm8mjDYc3PO3N6w/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322357; c=relaxed/simple;
	bh=bi0WXExHmEUNya3DtqOoD7S8NXkEZuVQbQ16KvHXIXE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HYypkDUPpzqYWRb069wmLPXdQxlOyY6Gu9Q3cwaP096rgKTFcSD00MMgs7n4ow6JZbau8vryiwqZOw3vt55aX+bQCuUYp6Tksa6KFmGBzBFJrbUfbanopCbKkfttw+i9HcxQwayk5AJtbKH4Vb7HRJ92EIvOQOdXZlZX3mJLkZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxqGYd1R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxqGYd1R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009B61F0089C;
	Tue,  6 Oct 2026 21:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322355;
	bh=dnGkPENoMNrEriOukO6H/re34FhzL3bWXny+p0Ul8GQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MxqGYd1RIXSWgUJGRAwlURw3/tzCqPzhi4pNEzTR5a3qwcKalpiiZMw2HfwgAhwlj
	 WlNOVFeiKT9lLlCsOWtqvErfDrUmcV62Zg5vYvCjosqVnkjRb9MJn9hyT9dn90Qyxa
	 Rnr8CK7FbqOpJ2vtcGzUrYb1+SG3RmCLy/jEShHt8smRW1HtUnZu8dbzxgm2mog+uD
	 TM+UTw6jenQuo/qjUn24REFlri+ycD4Opau2foQQm7D2RnV5q1dRhY4UTxGp0BlSjp
	 P2nvb38wVleAh8V3T8BNk6aamityiDAogKjK6fO/lbUg7uUS1OoAINYxA65JGRbHf3
	 RV4KAUa7ZG1Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com,
	=?UTF-8?q?J=C3=B6rn=20Engel?= <joern@barelysecure.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] mtd: block2mtd: Fix divide error when erase_size is zero
Date: Tue,  6 Oct 2026 17:32:31 -0400
Message-ID: <20261006213147.982448-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100521-retinal-happy-e316@gregkh>
References: <2026100521-retinal-happy-e316@gregkh>
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
[ sashal: adapted the size variable check to use dev->blkdev->bd_inode->i_size directly ]
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

