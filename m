Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847211;
	b=kDl5/98xsQeBekEMTbs+uAISJRo0WqaFZkaSDKr/h6Wa7KRzQD3MSmuUCyBunHovudU2
	 B/TvtAna5MfBnC2OKPy8KCD+IH+4hI498knLDrgDXFPVjgH7WhTruz8ks5vVt2mhxGA6+
	 hG8/lk/NHawfcto7xVrO7BmvhR9cAxeCdHW+n7ukyaRwcHwJo28F2KUQT6GgWQcEoaIDl
	 JOA7CA5q/5cRS9+oUKaliBckGaTEdr0hBQneyEARYKB/KbV6BuanXilicsvX0mU1aQlX3
	 EoRNEHkGr7yqQcW+1eDKvd+5G54BowMTAbzm5cscUZzgo4Amdr/261y3/zhtiKyVEZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847211;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Gv5Ou0wt+2aHJXSeApK0Ht9ChzMC0IpYCvBuwmBztaE=;
	b=JRauFEjDh7r6tvYyGoC/zUYr4OHxcdYJvytytvHNglGQeBDD+B4L7Nt6jLOMEDuM7iEE
	 Ndy74ltmD1pXZ1I+/U+Djl+CrRbVXgkR3O7JoxFoxGpFCoAP2UAOz14eBqw+ggMsbCGT1
	 r3TJviYye/hgaPsuxyXgDk3QOYpzMilM0Th4MeKJ5buRc0xtTwIbBhqyQJi+QqBQE6s4h
	 4aH5EsAex7CDmZADmxE8hA1pnQQpc+3jZRqLxP+zW9tYIbfp0DlaIPDytv1ZkDzmkq+7m
	 Qpm1UhsTOb1hK0qMtzqqRq7LPw33B8+KUFIA+0WgvB3hCj6JKp8id0iSTNp89L+WLbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4204E606A895;
	Mon, 16 Nov 2026 16:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4204E606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=Gv5Ou0wt+2
	aHJXSeApK0Ht9ChzMC0IpYCvBuwmBztaE=; b=D38dkpdvXKxeOe7H9HYHeBd7/w
	FT2PRFbfGRbdAIl4X1gtenc1MbOjbxuUjfQg0acRRX5Z+S8guz2PVcdM75xhxaG+
	tYCX5vCu0XmTe4yDKhXgrbCWHtvZvF5zkwzeVqAm+r2Kwk1OMgeE+l0X1BXRs9fZ
	RKea6EKwE57Htgjy0=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkDWHQPSMftqyZ+6AQ--.7152S2;
	Tue, 17 Nov 2026 00:39:48 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] usb-storage: reject too small values in max_sectors_store()
Date: Tue, 17 Nov 2026 00:39:46 +0800
Message-Id: <20261116163946.2502-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkDWHQPSMftqyZ+6AQ--.7152S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFWxuw15uw15uFy8JF1kZrb_yoW5WFWDpF
	W7WFyxKrWjga1xWan8Xw17uF9YkwsrGFWakrsxJwn5ur13Gas3KrnrKr9xXFy3Arn5Aa4U
	tFWDtFyqkrW8uFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvqb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18Mc
	Ij6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x07j5ID7UUUUU=
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2r5ytfv0wABsr

Writing a value that is smaller than a page worth of sectors, or
smaller than one logical block, to
/sys/class/scsi_device/.../device/max_sectors passes an invalid
max_hw_sectors to queue_limits_commit_update_frozen().  The block layer
requires max_hw_sectors to cover at least one page and at least one
logical block, and treats a smaller value as a driver bug:

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

Reject such values with -EINVAL on the limits snapshot returned by
queue_limits_start_update(), cancelling the update.  This keeps the
return value for values below a page unchanged, as the block layer
already returned -EINVAL for them, and also rejects zero, which
blk_validate_limits() would otherwise replace with BLK_SAFE_MAX_SECTORS
without the user asking for it.  Checking the logical block size as
well covers devices that report a block size larger than a page, where
a value above PAGE_SECTORS can still be smaller than one logical block.

Fixes: 70a7949335e5 ("scsi: usb-storage: Switch to using ->device_configure")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v2:
 - Also reject values below one logical block and cancel the limits
   update; with a device reporting a logical block size larger than a
   page, such a value reaches the second WARN_ON_ONCE() in
   blk_validate_limits().
---
 drivers/usb/storage/scsiglue.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/storage/scsiglue.c b/drivers/usb/storage/scsiglue.c
index 97de28e85562..7a55cfc18236 100644
--- a/drivers/usb/storage/scsiglue.c
+++ b/drivers/usb/storage/scsiglue.c
@@ -593,6 +593,10 @@ static ssize_t max_sectors_store(struct device *dev, struct device_attribute *at
 		return -EINVAL;
 
 	lim = queue_limits_start_update(sdev->request_queue);
+	if (ms < PAGE_SECTORS || ms < lim.logical_block_size >> SECTOR_SHIFT) {
+		queue_limits_cancel_update(sdev->request_queue);
+		return -EINVAL;
+	}
 	lim.max_hw_sectors = ms;
 	ret = queue_limits_commit_update_frozen(sdev->request_queue, &lim);
 	if (ret)
-- 
2.34.1

