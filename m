Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EBF4A2051
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210765; cv=none; b=AFxJnxeVK5cnQn281hj0ghuENLvY+LvPhazlk303+lBbuJPt5kaeqGF7j95MNeChOvm++GyMOC69Jnb1u2+8ds+yJAnYb/hBJ1V2Ao7u2M77kmEDjeOsbF7j9vfJxp7O6/w9zb9hE2b42ZdDJRnzYSXiwHOWbT9wRMHvpdgnSJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210765; c=relaxed/simple;
	bh=bWpUqvohniChBcfdonJ5IVFom8JzrBR2/+lu2HlU04E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pXOYiu32t/ADppe1nqeJlanDK3iejl/p6EKAnJcKGHW0VFZdJFxTkAHKcBpMcjh/4pqk8EflCJg2buuodDKcVSI1HsAvW5xlwsbU6gHuOrU/9iQW4BAGMx2Uq6ThIq6dkWhyGpV3Owr4mkvLibwcfQLMf5Ka0hbf5rd0S/HBCwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HHdm2Nxo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HHdm2Nxo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5431F00893;
	Mon,  5 Oct 2026 14:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791210757;
	bh=pQDaFwVZwGbe5nCocSLyWJU3kJCWtoA9Y0upT2hE9DE=;
	h=Subject:To:Cc:From:Date;
	b=HHdm2Nxow173f/fFpsM1gubljVCHH8YDaMqP4oLD3pI/b/uBl3tV2WqyxejXLjLTV
	 Wq1nCVCWNY714GFTdo3j1/rv0xDynZQCKHG5dxdsPmcrDLaw9Wr6HEAoEdNNkGZMww
	 0XMvlfHst978PtnMgNicZRMVYSJxOK4g7q0eEWBs=
Subject: FAILED: patch "[PATCH] mtd: block2mtd: Fix divide error when erase_size is zero" failed to apply to 5.10-stable tree
To: xiaopei01@kylinos.cn,joern@barelysecure.org,miquel.raynal@bootlin.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 16:32:21 +0200
Message-ID: <2026100521-retinal-happy-e316@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x b5965c4221165045e19736794ca5f48ae3d67142
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100521-retinal-happy-e316@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b5965c4221165045e19736794ca5f48ae3d67142 Mon Sep 17 00:00:00 2001
From: Pei Xiao <xiaopei01@kylinos.cn>
Date: Thu, 13 Aug 2026 10:48:12 +0800
Subject: [PATCH] mtd: block2mtd: Fix divide error when erase_size is zero
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 03e80b2c4f5a..349fa07be314 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -293,7 +293,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	}
 
 	size = bdev_nr_bytes(bdev);
-	if ((long)size % erase_size) {
+	if (!erase_size || (long)size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}

