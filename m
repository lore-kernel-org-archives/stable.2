Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794815345;
	b=ESMICh7hcEP/dpD0Vmy/mQxLy6nSE7eAqdIJM551HrhcPDZ9zrsXTgsoD1bcx0hxXvCl
	 J+DaFxKRWGEl0LrRLuFm+OteGb7xVjECQoibdOlqwbXkANVNJ8/WoJAl+vrHJ0BXMvTIi
	 JQ7kYdEte7Vf/ZEki5uhGr2gLIXeiEfZjNcC95KUsr+7Lww5KEJH/o0TtJW24Vo1scdF+
	 aIO4pzT0J+KJlHFGoYjleln82LBb/WCvCh7Gr72rMNLOb8QZbqGx8xRK6RFjs7GNM1nRi
	 g/IWj7uX8OMGEyv4tSO19fXSnAf9T6Vu1HHU1XOvBfyt+gyJwP04gBmmor6+VMjv6OA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794815345;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=bY6lzXmazPNgQ+UcyoLBmKep2WfhVGTgscTPgEi4ngw=;
	b=Rq/ojf84DlGooEC0rvPDx9FFpgf2RUnLFTwtrq4AeL3q4hd/xXYIQl8RPuUHzIaUoNAC
	 lZw8RqNsylt0MW1v/POCdqZtMkRJwG9mpfUjpPnenMFb4bWBu70vm/e7fXI4f1n3ydp82
	 6ELeGSjPOpN07buFleiJg22196T+UEQwgdaQDFus/XVov54MRHimudpLENTYPe5B32u+3
	 Y1YTxgSpZz9m607SnPHxQC44kA49WhGhnaEiHDQlJBwBS8ew76Z/2cEQOvjzF7MsF4EzM
	 QCVCKCUHxaovi/7Xa31U0kJsWnejT4EUYdLwhykarGYCbfdchQofj8k09252EgVOcoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D46606A31C;
	Mon, 16 Nov 2026 07:49:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F1D46606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=bY6lzXmazP
	NgQ+UcyoLBmKep2WfhVGTgscTPgEi4ngw=; b=VGdZytAhpz16t7Nyc2Kwz2z8SQ
	KsUYzgpZGIDTLHBftk1bvhZ3IWFM3r8mQtTkGXK1zHLiWBPsAnv6m+8Z1i77LhgF
	otqLu5Q2yCxll/JBM+Bl8EBfTMTTQGuIgMFnyew5aLz03xyrmS4mD+ftgH2w69gZ
	ExMEQGKnFPqCFxCfo=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-3.icoremail.net (Coremail) with UTF8SMTPA id BbQMCkDGyv1otfpqVsG0AQ--.43335S2;
	Mon, 16 Nov 2026 15:48:57 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Dave Penkler <dpenkler@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] gpib: ni_usb: fix use-after-free in ni_usb_line_status()
Date: Mon, 16 Nov 2026 15:48:56 +0800
Message-Id: <20261116074856.3446-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BbQMCkDGyv1otfpqVsG0AQ--.43335S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCrWUAFyxCrW5tr1kZryUAwb_yoW5Cry8pa
	y3tayjkFyqqr1SyanxAa1DuF15C3ZFvas7CF1jk3yxuws8J34fKrykKryYga4FyrykAw47
	JFWjvrWUuFWrCrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9vb7Iv0xC_tr1lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r
	15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r4xMxAIw28IcxkI7VAKI48JMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8QBMJUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAgUTD2r5zUhtNAACsW

ni_usb_line_status() caches the usb_device derived from
ni_priv->bus_interface and uses it for the two error messages that
follow the register read.  The bus_interface check at the top of the
function only proves that the interface was still valid when the
pointer was taken: the bulk transfer can take up to a second, and
longer when the endpoint stalls, so the dongle can be disconnected
while the transfer is in flight.  The USB core then frees the
usb_device and dev_err() reads freed memory:

  BUG: KASAN: slab-use-after-free in dev_name include/linux/device.h:934
  Read of size 8 at addr ffff8880088df100
  Freed by task 11:
   device_release
   kobject_put
   put_device
   hub_port_connect
  Call Trace:
   _dev_err
   ni_usb_line_status
   iblines
   general_ibstatus
   ibwait
   ibioctl

The gpib board and its device outlive the USB interface, so report the
transfer failure through board->gpib_dev and drop the local usb_device
pointer.

Fixes: 4934b98bb243 ("staging: gpib: Update messaging and usb_device refs in ni_usb")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/gpib/ni_usb/ni_usb_gpib.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpib/ni_usb/ni_usb_gpib.c b/drivers/gpib/ni_usb/ni_usb_gpib.c
index 28de1d543ad6..8e688509fdff 100644
--- a/drivers/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/gpib/ni_usb/ni_usb_gpib.c
@@ -1516,7 +1516,6 @@ static int ni_usb_line_status(const struct gpib_board *board)
 {
 	int retval;
 	struct ni_usb_priv *ni_priv = board->private_data;
-	struct usb_device *usb_dev;
 	u8 *out_data, *in_data;
 	static const int out_data_length = 0x20;
 	static const int  in_data_length = 0x20;
@@ -1528,7 +1527,6 @@ static int ni_usb_line_status(const struct gpib_board *board)
 
 	if (!ni_priv->bus_interface)
 		return -ENODEV;
-	usb_dev = interface_to_usbdev(ni_priv->bus_interface);
 	out_data = kmalloc(out_data_length, GFP_KERNEL);
 	if (!out_data)
 		return -ENOMEM;
@@ -1550,7 +1548,7 @@ static int ni_usb_line_status(const struct gpib_board *board)
 	if (retval || bytes_written != i) {
 		mutex_unlock(&ni_priv->addressed_transfer_lock);
 		if (retval != -EAGAIN)
-			dev_err(&usb_dev->dev, "send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
+			dev_err(board->gpib_dev, "send_bulk_msg returned %i, bytes_written=%i, i=%i\n",
 				retval, bytes_written, i);
 		return retval;
 	}
@@ -1567,7 +1565,7 @@ static int ni_usb_line_status(const struct gpib_board *board)
 
 	if (retval) {
 		if (retval != -EAGAIN)
-			dev_err(&usb_dev->dev, "receive_bulk_msg returned %i, bytes_read=%i\n",
+			dev_err(board->gpib_dev, "receive_bulk_msg returned %i, bytes_read=%i\n",
 				retval, bytes_read);
 		kfree(in_data);
 		return retval;
-- 
2.34.1

