Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794878845;
	b=wUvLETVk+p816cdIAS62YoiTsgQrGC9mJBnYIphY3mQvix8zks6KwZTcu7eE8kHZIQQo
	 KRKHtDzF8jYTAj5mQ/7zeulhpQObpZcKaOaevwneYPFCdwoG/NFiyP8GQ9t3MpLZhrfC2
	 0M6yL3m8xtgR3U0ugNf1+XRD1/4OcsFHO8wi14jLsDQyYyvnRb4HGX1rl+AgcL1jqnmG6
	 96Ih2ciA792ASyKl9pTCTbP2d2ym8yuTXJmkuA1z1DxI8yE3KBkV3ukuahxOcjp8blpmF
	 8YYQ+acT7YUdHjDNDwvMgdK1f65pDYf+gYMgViEv3rnBEeMMcO5ilk67qzX/9AWvdOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794878845;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Nx8k3CosD3afLDEMEHpVofmAOoOTqUyUTfQqddef4Z8=;
	b=Een8OjT/CVxOEWkj8lXDlO6MakKayStudWbgb9FNEZ9lB8tt9iMuCeUQsoq9h2224qZb
	 KMw5IaMR36wdy7ZKb6F7m0aBZwak4RU6epDJLpre7QDJLs6pKPTMhdQ34BvHQur656Ey1
	 o3zkPmDcjjFQdpMkCTePLL4+TaBRBxEpzVsng4xogi1JkHnEGQavdv3MoQ/OlDV1FZXHL
	 ZwUVmzO6R26CKMutCm9iqbHfZ7pGmybimlnJCaGmhdEqWmHtf7RNS8J8dMmqp3YaIGiaR
	 9qWB6+c2aDUoZPwesixePFISCdbWVO/m19af2Zz/asL6K4QyFAjtBJZXgsXK+AaAmLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18A0E606A31C;
	Tue, 17 Nov 2026 01:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18A0E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=Nx8k3CosD3afLDEMEHpVofmAOoOTqUyUTf
	Qqddef4Z8=; b=Co5hPoaQKrTG+o5hc/JeXYmMattduFCjFY0THsuBfcJ7ZycyRS
	519Ncte916woiBuoALjkrv+D6KM+UvR8phzT0zWCU6QzSYwYWsYuxXYWgxvh1VU+
	+HTDpPkHQE/K+9yKhPFNzvB2MX7v711TbMWObZopRIoqeLFNNvWcE+wSE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkCGx_xrrftqGJy_AQ--.16012S2;
	Tue, 17 Nov 2026 09:27:09 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] usb: storage: shuttle_usbat: set the ATA sector size at device init
Date: Tue, 17 Nov 2026 09:27:07 +0800
Message-Id: <20261117012707.5858-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261116093452.15286-1-25031212351@stu.xidian.edu.cn>
References: <20261116093452.15286-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkCGx_xrrftqGJy_AQ--.16012S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuryxAry8Cw17Wr18GrWfKrg_yoW5XryDpF
	ZrCFWYyrWDta1Skw1UJwsrWa4rAayfJFW3Kry0g34ruws8K3W5CrWxK34F9Fy7JryFyF1x
	Ka1vqFnxCa1DCF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvmb7Iv0xC_Cr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
	8E87Iv6xkF7I0E14v26r4j6r4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x0
	82IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGw
	Av7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48J
	MxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r
	4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF
	67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2I
	x0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2
	z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnU
	UI43ZEXa7IU8-yCJUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2r7HshEXgABsH

usbat_flash_read_data() and usbat_flash_write_data() divide the transfer
length by info->ssize to turn it into an ATA sector count.  info->ssize is
only assigned in the READ CAPACITY handler, so it is still zero when a
read request arrives earlier.

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

The ATA sector size of these readers is fixed at 512 bytes, so record it
when the USBAT flash transport is selected, instead of waiting for a READ
CAPACITY command to succeed.  The datafab and jumpshot drivers, which
share this code, already set it during device identification for the same
reason.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
Changes in v2:
 - Set info->ssize when the flash transport is selected, as suggested by
   Alan Stern, so the value is always available.
 - Drop the assignment from the READ CAPACITY handler, now redundant.
---
 drivers/usb/storage/shuttle_usbat.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/shuttle_usbat.c b/drivers/usb/storage/shuttle_usbat.c
index 7e5424268c73..267c82381465 100644
--- a/drivers/usb/storage/shuttle_usbat.c
+++ b/drivers/usb/storage/shuttle_usbat.c
@@ -1038,6 +1038,8 @@ static int usbat_set_transport(struct us_data *us,
 		break;
 
 	case USBAT_DEV_FLASH:
+		/* The ATA sector size of these readers is fixed at 512 bytes */
+		info->ssize = 0x200;
 		us->transport = usbat_flash_transport;
 		break;
 	}
@@ -1703,8 +1705,6 @@ static int usbat_flash_transport(struct scsi_cmnd * srb, struct us_data *us)
 		if (rc != USB_STOR_TRANSPORT_GOOD)
 			return rc;
 
-		/* hard coded 512 byte sectors as per ATA spec */
-		info->ssize = 0x200;
 		usb_stor_dbg(us, "READ_CAPACITY: %ld sectors, %ld bytes per sector\n",
 			     info->sectors, info->ssize);
 
-- 
2.34.1

