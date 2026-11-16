Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794821716;
	b=MQD+rxXiSxHJoOhf9qeLDxYYSnRyGlqb52ALDh3F/XbtONKGMcvnRG7iuHlYJ0ociXx1
	 vn1+Z43Huol7kpoISW3bewzI7bnRh/HWXqNVOFNb2eAVDSx96CC/c/g33H1iWQ2G9J4vb
	 P/MQ9BxMsjOY5/IanTY0qrjcrXf+/3eOZ+UebvsMLl3kbQsbqemNYbR5m3sWI5wd7Abra
	 1QemChHDr43mCvI2ZCfpRxirym+IkRrwQ6oYCmjVEntc7LySqnAtp+FrQnmb15xkmfC4u
	 slkBYoZbslGjc0uPEGsxApy9mi3pbtwVAiKoHVYSmrdtK46CH9Ot9n6mVj4Ev/jqQBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821716;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=m2paPrvOQbcYKgaX4fQc0mmLJu13moPBo8N94dl2CTg=;
	b=d47uu3xI3rkZzK3GzUiGkoJwuUyHUx4F32oiezT3d2NUyCmnjHO1vwIai3UieJ8yG6vD
	 QnIIZLzK+uopS5+w03FvRO4ui4CZPJQDD4f17XEdSe8GN+B9My5RUnNVUkyPZmW5quVL/
	 /arswQCz7olKaVj+CDg7vmruy+I11UbUKiYCHL3sbB1DNjHOu77o1n+EDym0jLQkrdP1v
	 X/4JcUlCNSqfLr+40qpUw9aI94Ne88g3sJZ8TAycq+A+JxsUHGfGzHCvKlJYyWuWBlfju
	 oGk3DOstVmLE+Tp8lTghG6vXaYGxlyVxracHYcZZhRLVws91ilps0fl02BO6plK08MA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDBF0606A31C;
	Mon, 16 Nov 2026 09:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDBF0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=m2paPrvOQb
	cYKgaX4fQc0mmLJu13moPBo8N94dl2CTg=; b=OMv4njrsNs10dtQK0F9L1Yd9XG
	WpSYW02xeDZUYMtwYxDPyhthlJES4aCCZzuHGvnjPrw5nagnWcRyHmpLVwu9k9Ud
	7DlHp6vnlFO1Tlr64MROHOM0TELNflwcX8Qub6sHBONNUssu+Bt58Vx8MCMb+3AZ
	YQs686gVw+Cm/KL9E=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkAmTAI8zvpq9Gy2AQ--.21849S2;
	Mon, 16 Nov 2026 17:34:54 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] usb: storage: shuttle_usbat: do not divide by an unknown sector size
Date: Mon, 16 Nov 2026 17:34:52 +0800
Message-Id: <20261116093452.15286-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkAmTAI8zvpq9Gy2AQ--.21849S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryxAry8Cw17Wr18GrWfKrg_yoW5Gw1Dpa
	y2kFWYkryDtan3Cw45XwsFqFy5XFZ3AFW3GryIgw15Ww15uF1xCrW2ga4rWa43Jr97XF1I
	qF4vvFn8CayDCaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvGb7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjxUcmiiUUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2r5ytetsAACsJ

usbat_flash_read_data() and usbat_flash_write_data() divide the transfer
length by info->ssize to turn it into an ATA sector count.  info->ssize is
only assigned when a READ CAPACITY command has completed successfully, so
it is still zero when a read request arrives earlier.

Such a request is sent during device scan: sd_probe() starts with
media_present set and usb-storage sets read_before_ms for every device, so
sd_revalidate_disk() calls sd_read_block_zero() right after
sd_read_capacity(), even when READ CAPACITY failed, because
read_capacity_error() deliberately keeps media_present set for drives that
fail it with media loaded.  A CompactFlash reader that does not complete
the READ CAPACITY sequence, for example because a register access is
stalled, therefore reaches usbat_flash_read_data() with info->ssize == 0:

  Oops: divide error
  RIP: 0010:usbat_flash_read_data+0x2a4/0x5c0

Reject read and write requests while the sector size is unknown, the same
way the driver already rejects an out of range LBA.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/usb/storage/shuttle_usbat.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/storage/shuttle_usbat.c b/drivers/usb/storage/shuttle_usbat.c
index 7e5424268c73..faea2c77c5aa 100644
--- a/drivers/usb/storage/shuttle_usbat.c
+++ b/drivers/usb/storage/shuttle_usbat.c
@@ -1130,6 +1130,13 @@ static int usbat_flash_read_data(struct us_data *us,
 	if (result != USB_STOR_TRANSPORT_GOOD)
 		return result;
 
+	/*
+	 * The sector size is only known once a READ CAPACITY command has
+	 * succeeded; a request can arrive before that.
+	 */
+	if (!info->ssize)
+		return USB_STOR_TRANSPORT_ERROR;
+
 	/*
 	 * we're working in LBA mode.  according to the ATA spec,
 	 * we can support up to 28-bit addressing.  I don't know if Jumpshot
@@ -1221,6 +1228,13 @@ static int usbat_flash_write_data(struct us_data *us,
 	if (result != USB_STOR_TRANSPORT_GOOD)
 		return result;
 
+	/*
+	 * The sector size is only known once a READ CAPACITY command has
+	 * succeeded; a request can arrive before that.
+	 */
+	if (!info->ssize)
+		return USB_STOR_TRANSPORT_ERROR;
+
 	/*
 	 * we're working in LBA mode.  according to the ATA spec,
 	 * we can support up to 28-bit addressing.  I don't know if the device
-- 
2.34.1

