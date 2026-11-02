Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609861;
	b=pefHgv6KycbVQlwMonz9QCndn2TI5D34frXjnPt53abZEqr3oElpq2Bbxsz2Ts8LRZGh
	 3LLAigW4mYzmW8REgFkEGAHZEI5QwADnaoiUIrL9cAbklPCBD3r92KE3TS+YPCbWY5F5e
	 r9WUQ6uHOasQ+Ae4x8uRbZESETemPvgvSljjZO+p2MKarZxnLm4QEpwZLU5WmUswWo62a
	 0JOfnk5JKg3K7npN1NCYJmTnVHMjhY0FPj982eYb57N1lWl5GoCx8Yq4ttbmiPYrelKlR
	 sbOa+ZF1zdWfiYr5XyCoq/saH8BqI5bnclr3t8A4HN1/7pHN3nh0CVhp44tS9oLFqfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609861;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=MT+iqss53aywUbO/a8V4XaOjzYPtyOfA+f1pPTgJrxY=;
	b=mAB3q7JdigGG2rPc20SgjVmTI1r7ZLN+KyLkkMroTAU5U3/6DzoWyAH//IZOVsDciT/A
	 6IlRLN3HPBAxolOOZHA7siaJOW4wUJwWSxrRqouOB+E7ewQD/f/74RuwNvjxWlm2mAXr0
	 wMY8AlzPBXlt3NXCyQyJEAd+RfKphAokUENC9ELVu+39qEctP66rQ7LmJNZhue5pHsKzS
	 aO9lxHI+q0WbhR44XUFUI2F/TXeNcIeroDhoifdYtHiNTKvFg0gF4s9gxOeluVBE9xZJO
	 alN5YJ6RsBt7Nj+MjMvfViewGDOg7y1b9Dc3WY+iCE3zaDezM4KR9VrVNmkkD5K0J/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0D1606A33D;
	Mon,  2 Nov 2026 08:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED0D1606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=MT+iqss53aywUbO/a8V4XaOjzYPtyOfA+f
	1pPTgJrxY=; b=2iK4pYuaYJy+wMyeo3b39vJoZY4ccIjt68b84fl+BlGRa7+GB8
	+/NtxI8CoW0hA6fi0Idesc//54YIztTpoeGgG3E6SuPMwQRa4CItm+GVOT0wRd9/
	JP8b3SVsPCgioTF+TysiCt75pY1zmoEQRtkkbP9Vx6MlA5LKLeLLCDOoM=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.55])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkD2Of90UOhqVtIYAQ--.48924S2;
	Mon, 02 Nov 2026 16:57:25 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Helge Deller <deller@gmx.de>,
	Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH v2] fbdev: smscufx: keep the usb_device alive while ufx_data is in use
Date: Mon,  2 Nov 2026 16:57:24 +0800
Message-Id: <20261102085724.13456-1-25031212351@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261102072120.3022-1-25031212351@stu.xidian.edu.cn>
References: <20261102072120.3022-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkD2Of90UOhqVtIYAQ--.48924S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW5uFWDuFyfWr1kWFyDWrg_yoW5ur18pF
	W5Cay5GrWkJr4Y9a9rGr48uFyFqw13Aa4UCr9Fkr15uFn8C3y3JryqyryIg3Z3JFWkAw47
	Aa45X3yj9a9ru3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17Mc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5_Ks5UUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rnVdSL8QABs5

ufx_usb_probe() stores the usb_device pointer in dev->udev without
taking a reference, and ufx_usb_disconnect() does not wait for in-flight
control transfers.  A mode set or blank request that runs while the
device is being unplugged - through ufx_ops_set_par() or ufx_ops_blank()
on an open /dev/fbN file - keeps issuing synchronous control messages for
the whole ufx_set_vid_mode() sequence, including two msleep(1) delays in
ufx_config_pix_clk().  Once the disconnect callback returns, the USB core
may release the usb_device, and the next ufx_reg_write()/ufx_reg_read()
dereferences dev->udev through __create_pipe():

  general protection fault, probably for non-canonical address
  0xdffffc0000000006: 0000 [#1] SMP
  KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
  RIP: __create_pipe include/linux/usb.h:2031
  Call Trace:
   ufx_set_vid_mode
   ufx_ops_set_par
   fb_set_var
   fb_set_var_from_user
   store_rotate

Take a reference to the usb_device in ufx_usb_probe() and drop it in
ufx_free(), so dev->udev and dev->gdev stay valid until the last
ufx_data user is gone.  The control transfers then fail with -ENODEV
instead of dereferencing freed memory.

Also return early from ufx_set_vid_mode() while the device is inactive,
matching the other transmit paths.  That check alone is not enough,
because it is not serialized against ufx_usb_disconnect() and the
transfer sequence continues after it; it only avoids a long series of
failing transfers.

Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adapters")
Cc: stable@vger.kernel.org
---
Changes in v2:
 - Hold a reference to the usb_device and drop it in ufx_free() so
   dev->udev stays valid for the whole transfer sequence; the
   usb_active check alone only covers the entry (review feedback).
 drivers/video/fbdev/smscufx.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5704f60e1741..eac303adb69a 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -661,8 +661,12 @@ static int ufx_set_vid_mode(struct ufx_data *dev, struct fb_var_screeninfo *var)
 	u32 temp;
 	u16 h_total, h_active, h_blank_start, h_blank_end, h_sync_start, h_sync_end;
 	u16 v_total, v_active, v_blank_start, v_blank_end, v_sync_start, v_sync_end;
+	int status;
+
+	if (!atomic_read(&dev->usb_active))
+		return -ENODEV;
 
-	int status = ufx_reg_write(dev, 0x8028, 0);
+	status = ufx_reg_write(dev, 0x8028, 0);
 	check_warn_return(status, "ufx_set_vid_mode error disabling RGB pad");
 
 	status = ufx_reg_write(dev, 0x8024, 0);
@@ -1064,6 +1068,7 @@ static void ufx_free(struct kref *kref)
 {
 	struct ufx_data *dev = container_of(kref, struct ufx_data, kref);
 
+	usb_put_dev(dev->udev);
 	kfree(dev);
 }
 
@@ -1606,6 +1611,8 @@ static int ufx_usb_probe(struct usb_interface *interface,
 
 	dev->udev = usbdev;
 	dev->gdev = &usbdev->dev; /* our generic struct device * */
+	/* keep the device alive until the last ufx_data user is gone */
+	usb_get_dev(usbdev);
 	usb_set_intfdata(interface, dev);
 
 	dev_dbg(dev->gdev, "%s %s - serial #%s\n",
-- 
2.34.1

