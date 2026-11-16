Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794794967;
	b=VVh6wsV1IhVEFua/69bSQrbP4EGD3luXEKk+RMZvfQRmyr0T4178uvQxuES18hJYtcKQ
	 bgkDh+HoQXq2hex9axXomMpYLEAG3YOa+P4SO1/CFT0A8hcngkTEtFNtH25JiHYNgLlUO
	 Fz0vccMEmmyVbTFhJB+9sNSJ5ImbTPFmg0oPUa2qmdOIr7m2072JfFzFy+9b9mxfxWwRp
	 HyvOcsikffa/+uNNQaPn7T+07OTT9czU9YyiDZP0p0nt6wJF3tlznVhPf0kJW7CcuO0mj
	 pcZMWnXnjpEeD7Fq77JHFM6z23PQMWD/4TzvKg6iZZwDBb48JPIb7loo9VapgZO6i1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794794967;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=m+dEIJONCiCim+YEcdPwcO1SEYQrLR9cGyOiWLDFjYs=;
	b=wcDMNZUH3qLqh0az11HFKJfO4gsfnpjqjhGI8/yLHKWTJ+WZmiEcnUCzGRjgLf66Pdzw
	 ZfqBlij5TbxfnRk9uDH0a460Ijl6oVcOKnj6O4b1b3XTK3iM6+0tOEelr1Bk4sSo8GVff
	 TnXVJFgsjArZqO9EkhE+/C71ThHAPfZ6lkGbREIIIRQDwA2jIH/wwufmv1GJKlmqNKJYo
	 k3qhoI21Bi5RnmVJ3qrEhPBJ0k6XfF6jZDthINYe5lCe6U/YqLnWFhrXTqlIU1S+gZlQx
	 KIhmwbCNLdDLvzfOMNzZBG9krbL9F2PmX0VVLXb/UDkEbQQjTucK/uQNySyvdRavGXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CCF606A31C;
	Mon, 16 Nov 2026 02:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49CCF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=m+dEIJONCi
	Cim+YEcdPwcO1SEYQrLR9cGyOiWLDFjYs=; b=wKWTqWeQi8ekrnB7xQgGSsOyCe
	qf4C2oXy6qDzGm1pH+9/pajNNGCLQkvMr/fZL09Su4m1a37ijJnAVxaLuLw8ToyT
	52YN0Jz5mBAuA+Uyj8HxZG8CyFN0Vn1YKXEVarjhJY14t62AlgMG9I1aNOh9blHk
	T2HXO3AVU55Pk3tMI=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.41])
	by hzbj-edu-front-4.icoremail.net (Coremail) with UTF8SMTPA id BrQMCkDmCgGyZfpqZCuyAQ--.59725S2;
	Mon, 16 Nov 2026 10:08:52 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Israel Cepeda <israel.a.cepeda.lopez@intel.com>,
	Hans de Goede <hansg@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] i2c: usbio: check the return value of usbio_acquire()
Date: Mon, 16 Nov 2026 10:08:50 +0800
Message-Id: <20261116020850.10526-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BrQMCkDmCgGyZfpqZCuyAQ--.59725S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr13Jw17Xr4rArWUZrWxCrg_yoW8Kw4xpF
	43WFZ0kFW0qr109ws8Jr1IvF15AwsruFW5GFyjkwn5ZF15XwnFyryDtw1jgFn5Cr4xCw1q
	vFWqq39FkF1jyaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_Zr1lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwV
	C2z280aVCY1x0267AKxVW8Jr0_Cr1UM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq
	07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r
	18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
	r41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcjg4UUUUU
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUTD2r5ytdeeQAAsx

usbio_i2c_xfer() ignores the return value of usbio_acquire() and always
calls usbio_release() on the way out.

usbio_acquire() returns -ENODEV once the USBIO bridge has been
disconnected: usbio_disconnect() sets client->bridge to NULL, and
usbio_acquire() then only drops client->mutex and returns without
taking usbio->bulk_mutex or the runtime PM reference of the USB device.
The transfer is nevertheless issued.  usbio_bulk_msg() dereferences the
NULL client->bridge in its packet size check and the kernel faults on
usbio->txbuf_len.  The matching usbio_release() then drops a runtime PM
reference that was never taken, which is reported as "Runtime PM usage
count underflow!", and unlocks a mutex that nobody holds.

Propagate the error instead, so that a transfer racing with the
disconnect returns -ENODEV without touching the bridge.

A NULL pointer dereference in usbio_bulk_msg() was observed when the
bridge was unplugged while i2c-dev was reading from the adapter:

  usbio-bridge 1-1:1.0: Bulk out failed: -19
  usbio-bridge 1-1:1.0: Runtime PM usage count underflow!
  usb 1-1: USB disconnect, device number 3
  general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
  RIP: 0010:usbio_bulk_msg+0xce/0x9f0
  Call Trace:
   usbio_i2c_init
   usbio_i2c_xfer
   __i2c_transfer
   i2cdev_read
   vfs_read

Fixes: daf161343a39 ("i2c: Add Intel USBIO I2C driver")
Cc: stable@vger.kernel.org
Co-developed-by: Bin Yu <byu@xidian.edu.cn>
Signed-off-by: Bin Yu <byu@xidian.edu.cn>
Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
---
 drivers/i2c/busses/i2c-usbio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-usbio.c b/drivers/i2c/busses/i2c-usbio.c
index 259754e5fd05..232397efe8a4 100644
--- a/drivers/i2c/busses/i2c-usbio.c
+++ b/drivers/i2c/busses/i2c-usbio.c
@@ -178,7 +178,9 @@ static int usbio_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int nu
 	struct usbio_i2c *i2c = i2c_get_adapdata(adap);
 	int ret;
 
-	usbio_acquire(i2c->adev);
+	ret = usbio_acquire(i2c->adev);
+	if (ret)
+		return ret;
 
 	ret = usbio_i2c_init(adap, msgs);
 	if (ret)
-- 
2.34.1

