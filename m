Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794824179;
	b=o9ca9Six7vr2DN9xhUQ3ytGmeY1Dct2r5t6vmNqZVSohB0nNMtm8S8JMHtBl1Nn3bfw5
	 t4L7Vk0TUqmLhtjEKWH1V6ELHHI6d9MWllQPQA4EZH6Dg8ggqn387xYzecUMPi8/deu+U
	 EtSgV2B58zsKFpYNuJSlVM8MG6ZnhNuipaOHTFBufQ95bmUPvEiBQD+MpQWnFWozewHms
	 gImde1BC52uD2ICAlAr9Rec2ayA3HA5qbCZbz33tnf9ekU78aQwZxye/6pYPFc6U3DBPS
	 sLYxyRQ9PrReIwNvgiFmvfnoS9F8JffRkNKu2qSC/HR8ccUtdpxe4rd6ymIRDY+N53A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794824179;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=lp1hBh3kGMtiMv4I01/WDcU3LFNFBfEj5W+S8mSCYKc=;
	b=qgOpgP5zMr4K3DHm2LDaK9uRdFepPFXWM/4C65S+fJCeaFEHnYT3n3UFyFkfwMDh1Ebm
	 qHGy7Ik8zg1qzaypEq+SX9Xt55ojrcMP4N9zWsVMXG6OemCkEsYRDcZ2PflZnZX+XuIlr
	 BbdHaUwLa0azfd8/kSYKXbSPl+zWZQ5S4WwbPCPneQeB/FoG4D+n1dKFg1zBZF3aDUqC2
	 qaUOpgEcDn/a3uMNIPOSkGz0i0SaUQJEK/5lpPE/o4EDf5DIhGx3A+PvY5Oz4eQ5lnOdY
	 Ix5Gz8NEDjvUQeFQmqUgJcxtWHw7xXtiRUBtmQpAV9X9DbaI7pG+mpip1Ef3ZKhP3Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D385A606A31C;
	Mon, 16 Nov 2026 10:16:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D385A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=lp1hBh3kGM
	tiMv4I01/WDcU3LFNFBfEj5W+S8mSCYKc=; b=cAqQfbC+WP8SkhEgXaV8Z0b4Ga
	WvAoZa5vHcNAr0MpgVK9Pih0DKqO26s1vlyP90OlpW0LBlTCsPWlBHqVbjsOF6Qf
	3eaFJBcpwEYyJJsOaVezKimi0ebGIm4rdvf+l1EM08eG7seG+waUghBWqh5qTnM7
	dR8iT87LHB/GR8aGo=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDW2_7k1_pqoDG2AQ--.2231S2;
	Mon, 16 Nov 2026 18:16:04 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] usb-storage: reject too small values in max_sectors_store()
Date: Mon, 16 Nov 2026 18:16:04 +0800
Message-Id: <20261116101604.42161-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkDW2_7k1_pqoDG2AQ--.2231S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar43Jr4DCw1DKw43trWUurg_yoW8uw13pF
	ZrXFyakFWUtanrWws8Xw17uasYk39rGFy2krsxXwn5urnxGF9IkryUtr1aqFy3Awn8Aa48
	tFZ0yFyqk3yDuFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r
	15McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4DMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8LYFJUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2r5zUi2hAACs9

Writing a value smaller than a page worth of sectors to
/sys/class/scsi_device/.../device/max_sectors passes an invalid
max_hw_sectors to queue_limits_commit_update_frozen().  The block layer
requires max_hw_sectors to cover at least one page and treats a smaller
value as a driver bug:

 WARNING: block/blk-settings.c:389 at blk_validate_limits+0xeb9/0x14b0
 Call Trace:
  queue_limits_commit_update
  queue_limits_commit_update_frozen
  max_sectors_store
  dev_attr_store
  sysfs_kf_write

Before commit 70a7949335e5 ("scsi: usb-storage: Switch to using
->device_configure") the store called blk_queue_max_hw_sectors(), which
silently raised values below PAGE_SECTORS to that minimum.  The
conversion to the queue_limits API lost the clamping, so a single sysfs
write from user space can now trigger the warning.

Reject values below PAGE_SECTORS with -EINVAL before taking the limits
lock.  This keeps the return value for 1..7 unchanged, as the block
layer already returned -EINVAL for them, and also rejects zero, which
blk_validate_limits() would otherwise replace with BLK_SAFE_MAX_SECTORS
without the user asking for it.

Fixes: 70a7949335e5 ("scsi: usb-storage: Switch to using ->device_configure")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/usb/storage/scsiglue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 97de28e85562..94131b726ade 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -591,6 +591,8 @@ static ssize_t max_sectors_store(struct device *dev, struct device_attribute *at
 
 	if (sscanf(buf, "%hu", &ms) <= 0)
 		return -EINVAL;
+	if (ms < PAGE_SECTORS)
+		return -EINVAL;
 
 	lim = queue_limits_start_update(sdev->request_queue);
 	lim.max_hw_sectors = ms;
-- 
2.34.1

