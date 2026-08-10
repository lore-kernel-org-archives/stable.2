Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BC53A4F30;
	Mon, 10 Aug 2026 09:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353161; cv=none; b=K0WH8TTPVk6sh/YRJ/9JJHUdoZOauJhiYDegONqPT4rW9VTzSe4fRLVFeav0iocUExWTJ1Wy4Y1zs5Aj8hSMLxs0+SfetC7dFJgolj098E5JzyGFTq2fvRNEwRUl5i1xnCo8wrLx1ZvA1cJHhhlQpNkZr5/rnHhyC1evcXLvtgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353161; c=relaxed/simple;
	bh=C/xPd2dxpI0fdu/nl5F8LSye1mV8xhTI8uzOKNXcfdg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=irrhfgPLN1P5gmxIGpWjRR4R43RVrhVV07qw1qAtT/0XDf9rXGZuqw4/pdDktGVwKyqpUj2VJUtHJBGR13skNJAjtIYFldVwOtWCNwCOOY0sAhAt+ujg/AxjRwAf/yJsU3Qggo4Wd3E1cZwEwXyNeGlpuvI5Z7CQ9mIQXJqM0us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 9eb917ae949b11f1aa26b74ffac11d73-20260810
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:fdec0016-1b4a-408c-91e5-bf8670a58b8c,IP:0,U
	RL:0,TC:0,Content:-25,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:1cb3b056e9383900a3bc2b8a6664f4ec,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:5|-100,IP:nil,URL:1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,C
	OL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 9eb917ae949b11f1aa26b74ffac11d73-20260810
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1347937998; Mon, 10 Aug 2026 17:12:32 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com
Cc: joern@lazybastard.org,
	linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	syzkaller-bugs@googlegroups.com,
	vigneshr@ti.com,
	Pei Xiao <xiaopei01@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: block2mtd: Fix divide error when erase_size is zero
Date: Mon, 10 Aug 2026 17:12:29 +0800
Message-Id: <c0148dd9482275f3bab75b7263408fca89ef311b.1786353116.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <6a791c94.01d0871a.3a0d52.009b.GAE@google.com>
References: <6a791c94.01d0871a.3a0d52.009b.GAE@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The erase size is parsed from the "block2mtd" module parameter and can
be set to zero. add_device() then evaluates

	if ((long)size % erase_size)

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
Closes: https://lore.kernel.org/all/6a791c94.01d0871a.3a0d52.009b.GAE@google.com/T/#m5d4961a95b273da06457d603ddcc4170bf82a9fd
Cc: stable@vger.kernel.org
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
 drivers/mtd/devices/block2mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.25.1

