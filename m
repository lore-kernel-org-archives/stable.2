Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794799767;
	b=dF9cNim4NCOvq2rF0NhM4kJNBpPtX/+6YeWRBUzoguskVBrT2MpzWmSVA90FzqDxsEHT
	 bLOskbwcA4OAJqr/O+Zb8ikbFAgTIvyjjcTXcLZwCYudVXYca3dt97nhqqyY8moRkZQRK
	 fG4K3vbmrZqFv3PLLMeyMHXm2PFL3q1BltIikOGHU4+PxCW1GX5Rs2I7ODzRrEspgxEWo
	 hMB7LfaxkOphQrer9P7qWr8HwFI9AzwJQhrhKLyB7upKBPh89701xw3PYFRw/ffC/zMbf
	 1B5idNU5u8IhMwToT+UDuwf/ZA8teTpBuZwbPq122Ke9mxGigpAHFCq3aGc65eN7W6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794799767;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=R98RYxd8YGTses0oZtYrvdCHL6uuQfMTRPowI4jHOCM=;
	b=yLbyLaYXyMF9SFWoVQtwGAvFKhnQg3neFQ3oFf2NEUebMATm1XYfwUtZqyKyFW4btRkS
	 NW7oQ1XTi8kdC0q6uf1aJrnvHehQOu6cwgQhggwU1RWFeKfbV2xdjmzvsY76Z22XBBmgm
	 x1w1u9Lmc2AM/YsRpDU4YY9/r0Fr1q5SchV0B2eQ/QMd96V4fwNbbJfx/anQ9etbexAGY
	 kXJmOOxIcKUnSIsQgl26diQpy0KthRAOSSIdzal9ClJD7k6cGjRkpkUo2sufo9zWbKZce
	 hsmQR9xWck51Rcd9pIndonj/fR5yDrqxGKXRL7KvX11c3MwtcCeUHzokwx5zH5GJG+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79C21606A33F;
	Mon, 16 Nov 2026 03:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79C21606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=R98RYxd8YG
	Tses0oZtYrvdCHL6uuQfMTRPowI4jHOCM=; b=3Lg0HspBPM03+9sISbTfROM/eO
	pV87eGyx6F2FvIkAHyN8qx+RwCaqPDvyPEPpO01kbcwn8p3yZLMfrLAkcQeWJe0o
	iKJr0jxutvoSXweX/DcONSEXS75a0Q8I63Dowq7lkcbfklm432w7msbADv1UGjb6
	6oTdHbkb4yH3Fb0q0=
Received: from LAPTOP-FRMFRHCN.localdomain (unknown [2408:8670:ae1:0:3842:c738:6c8e:750c])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkC21ft8ePpqAASzAQ--.58384S2;
	Mon, 16 Nov 2026 11:29:01 +0800 (CST)
From: Haoli Zhang <26031212468@stu.xidian.edu.cn>
To: tglx@kernel.org,
	anna-maria@linutronix.de,
	frederic@kernel.org
Cc: linux-kernel@vger.kernel.org,
	richardcochran@gmail.com,
	syzbot+667788430769ef9ddf25@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	25031212117@stu.xidian.edu.cn,
	byu@xidian.edu.cn,
	Haoli Zhang <26031212468@stu.xidian.edu.cn>
Subject: [PATCH] posix-clock: initialize cdev state before publishing
Date: Mon, 16 Nov 2026 11:28:53 +0800
Message-Id: <20261116032853.825-1-26031212468@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
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
X-CM-TRANSID:BrQMCkC21ft8ePpqAASzAQ--.58384S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJr47Cr18AFW8tw1ftr4xZwb_yoW8Aw4fpF
	43Ja4FyayDKr1UCa4DGrW2qF47Cw1qqa1xAFyvy340krn5G39Yyw10gF1q9a4rA340ya1U
	XF4ayFya9FW5ur7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAq
	YI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4
	AK6IIF6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8Zw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sRRDD
	G5UUUUU==
X-CM-SenderInfo: yswqjiasrskluy6v33wo0lvxldqovvfxof0/1tbiAgUTEWr5zUhzFgAAs2

cdev_device_add() may expose the cdev before it returns. Initialize
clk->cdev.owner and clk->dev before calling it, so an open racing with
registration takes the matching module and device references.

If cdev_device_add() fails after cdev_add() made the cdev available,
open files may still exist. Mark the clock as a zombie under rwsem before
returning the error, so subsequent read, poll, ioctl, and dynamic clock
operations on those files fail while the caller tears down registration
state. Keep clk->dev valid so the release path can drop any reference
acquired by a successful open.

Fixes: a33121e5487b ("ptp: fix the race between the release of ptp_clock and cdev")
Reported-by: syzbot+667788430769ef9ddf25@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=667788430769ef9ddf25
Cc: stable@vger.kernel.org
Co-developed-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Signed-off-by: Jinning Zhang <25031212117@stu.xidian.edu.cn>
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Haoli Zhang <26031212468@stu.xidian.edu.cn>

---
--- a/kernel/time/posix-clock.c
+++ b/kernel/time/posix-clock.c
@@ -164,14 +164,18 @@
 	init_rwsem(&clk->rwsem);
 
 	cdev_init(&clk->cdev, &posix_clock_file_operations);
+	/* cdev_device_add() can expose the cdev before it returns. */
+	clk->cdev.owner = clk->ops.owner;
+	clk->dev = dev;
 	err = cdev_device_add(&clk->cdev, dev);
 	if (err) {
 		pr_err("%s unable to add device %d:%d\n",
 			dev_name(dev), MAJOR(dev->devt), MINOR(dev->devt));
-		return err;
-	}
-	clk->cdev.owner = clk->ops.owner;
-	clk->dev = dev;
+		down_write(&clk->rwsem);
+		clk->zombie = true;
+		up_write(&clk->rwsem);
+		return err;
+	}
 
 	return 0;
 }

