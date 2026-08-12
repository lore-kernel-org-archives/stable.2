Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424EE370AF1;
	Wed, 12 Aug 2026 01:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786499577; cv=none; b=SchqtupbwFCfSxYbK6EGzlq+dq1HldTEFkLMhaPwart+tb3D4Hprm8Nu4HaK5fduSXPJxxGSTl+2xVTnuRkfqlxiiI6iAS80ire0/3rIrMxx2aW2bPXDUejNi36UM2MComFRp0p/PH4ou5DvLi1w7LGOwBqvvOsGuGGSKbYuwcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786499577; c=relaxed/simple;
	bh=h4atu9frIiOKJHlB/Iihh6cigtVtezo0cPrL0HNKSRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=La7OO4rT9YzTo8vBGb2ldc0WiN+lMO0k+dKIBX9xF1l8rRbjzrVOUmp0nSqggU9JJ68pMrHkiiDNZVV+uQmWZp+RZcMpoH2CdwRIrphxIiZzXxTug0rxX1BR6pJLXC3FGbndcGZrvdFGc+uSlRBDXXssk4gZ1FQsYPpn95TAOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 83d00f5095f011f1aa26b74ffac11d73-20260812
X-CID-CACHE: Type:Local,Time:202608120941+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:29fd8a83-22f9-4b16-9869-f0f4ec69909e,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:2a74e15aecf54d0328745e282302cfcd,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:81|82|102|136|850|865|898,TC:nil,Content
	:0|15|50,EDM:-3|-100,IP:nil,URL:99|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:n
	il,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 83d00f5095f011f1aa26b74ffac11d73-20260812
X-User: xiaopei01@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xiaopei01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 406332067; Wed, 12 Aug 2026 09:52:46 +0800
From: Pei Xiao <xiaopei01@kylinos.cn>
To: joern@lazybastard.org,
	miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Pei Xiao <xiaopei01@kylinos.cn>,
	syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com,
	=?UTF-8?q?J=C3=B6rn=20Engel?= <joern@barelysecure.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] mtd: block2mtd: Fix divide error when erase_size is zero
Date: Wed, 12 Aug 2026 09:52:42 +0800
Message-Id: <48230456575d27aa83ce8640de8fc07cc62e8efb.1786499433.git.xiaopei01@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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

While at it, drop the unnecessary (long) cast from the size operand of
the modulo.

Fixes: ea6d833a3fdd ("mtd: block2mtd: check device size")
Reported-by: syzbot+b320a4d5f65a61dbbf89@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/6a7b58ba.ac361c09.22ff0a.0045.GAE@google.com/
Suggested-by: Jörn Engel <joern@barelysecure.org>
Cc: stable@vger.kernel.org
Signed-off-by: Pei Xiao <xiaopei01@kylinos.cn>
---
changlogs in v2:
1.Add Suggested-by tag
2.remove unnecessary (long) cast from the size
---
 drivers/mtd/devices/block2mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 03e80b2c4f5a..3e2367dfff88 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -293,7 +293,7 @@ static struct block2mtd_dev *add_device(char *devname, int erase_size,
 	}
 
 	size = bdev_nr_bytes(bdev);
-	if ((long)size % erase_size) {
+	if (!erase_size || size % erase_size) {
 		pr_err("erasesize must be a divisor of device size\n");
 		goto err_free_block2mtd;
 	}
-- 
2.25.1

