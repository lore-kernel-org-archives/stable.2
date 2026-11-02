Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=162.243.164.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609330;
	b=GP0TaIpsDa1JqdD2wiS1BdvxFbJkhy7hxsGCv0/fPd6uh4e9xnrOmsi0/YCxEQSm/7rd
	 rODPh5RtLyIo22itFYX3SHMBpnuXemLSG3NSvSriazL9KPQvPr9xervJnuDfPAjHT/i3l
	 V5CETAABJNRefNqT7a408pEpaJM6yAZdK/zDX8hENBsGSvuBBECQ9bw+E75nOvFf6cQfU
	 P4IoeE2ndFV+lCFjp4PAorxetOzMcjPVyd/abIFzBKRa6/J+VGi0fEKfxnxju93SNsEDj
	 EslBlgEG2JIb6z7JaVok+UNjySAlXBMv2Py+VycDAZ6XI2oR2wxO8AmYmXH66QvmyiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609330;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=IIx5Id2p6UomVqlMJQwLEL9OVFN79ieEtDwmL+E+5vU=;
	b=ih2YhWRCIEAUQ69/wcYjFvPvx47upeD9IVnVsLKQMbfWK1tedINsaSdAcC+byVedJAeI
	 9nHuonQ5q0hqQFcggijfCslSOPQ51Ig4xH3JCuIwAHMUtdCHmSg2nfRRAB7XHMWmOKMxW
	 WO0NNFmMHnXhgLnSr7JMgnI3wsXO7aKyBjXC0nCp8SBeXiNZpQdos2oPZLkf2RvkiXIKP
	 3jX6YoGWLLSK2qwIEy3uaGzYrexLtyC1EMfPgy4flviiRS96BHDdT0QlX29bz1TzcWUXZ
	 FlxeFphDxlal4cOc+f/G4bHHdg8TiY5FcjWWjjC3XoR/5qk0arJrydXtC2/VgN9/duw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=stu.xidian.edu.cn;
	spf=pass smtp.mailfrom=stu.xidian.edu.cn;
	arc=none smtp.remote-ip=162.243.164.118
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A97606A326;
	Mon,  2 Nov 2026 08:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98A97606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=IIx5Id2p6U
	omVqlMJQwLEL9OVFN79ieEtDwmL+E+5vU=; b=KgD+QsZscNImx7W3n75tF1czX/
	xJhP1n8O1H9J24c9FSUVuUgKVbe/xAph5NLNdDqebMCkzmbJ7DTT1HO+3EWFNQPX
	tz80HEdVmXQmC6Ki2YibeE9W/25BMEFzoHZ8wDWUKO3vRtav7nSh0UitIAldoxGn
	lPzOi4TjSRHVguCkE=
Received: from user-virtual-machine.localdomain (unknown [113.200.174.55])
	by hzbj-edu-front-2.icoremail.net (Coremail) with UTF8SMTPA id BLQMCkBGjwReTuhqAMkYAQ--.27848S2;
	Mon, 02 Nov 2026 16:48:31 +0800 (CST)
From: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
To: Helge Deller <deller@gmx.de>,
	Steve Glendinning <steve.glendinning@shawell.net>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: [PATCH] fbdev: smscufx: don't free registered framebuffer on probe error
Date: Mon,  2 Nov 2026 16:48:30 +0800
Message-Id: <20261102084830.9890-1-25031212351@stu.xidian.edu.cn>
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
X-CM-TRANSID:BLQMCkBGjwReTuhqAMkYAQ--.27848S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF17Xw4rKF45uFyUJFW7XFb_yoW5Xryfpa
	n5Kas0qr15trWfXr47C3W0vFyrtF1xZryFkFW7t343C3W3Cry5XryxKFyjgayDJFn7JF1j
	gF1Yg3y8uFWDWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9ab7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
	8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x2
	0xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15Mc
	Ij6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l
	c7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6r43MxAIw28IcxkI7VAKI48JMxC20s026x
	CaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_
	JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r
	1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_
	Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr
	UvcSsGvfC2KfnxnUUI43ZEXa7IU5CiiPUUUUU==
X-CM-SenderInfo: ysvqjiysrsjkur6v33wo0lvxldqovvfxof0/1tbiAQUFD2rnVdSL8QAAs4

register_framebuffer() can return an error after the framebuffer has
already been installed: do_register_framebuffer() bumps info->count,
creates /dev/fbN and stores the fb_info in registered_fb[] before it
returns the result of the console takeover, and that takeover may fail.
ufx_usb_probe() treats any error as "nothing was registered" and unwinds
through reset_active, which releases the fb_info and drops both
references to struct ufx_data, freeing @dev.

The framebuffer stays registered and can still be opened, so the next
open() of /dev/fbN reaches ufx_ops_open() with info->par pointing at
freed memory:

  refcount_t: addition on 0; use-after-free.
  WARNING: lib/refcount.c:25 at refcount_warn_saturate
  Call Trace:
   kref_get
   ufx_ops_open    drivers/video/fbdev/smscufx.c:1033
   fb_open         drivers/video/fbdev/core/fb_chrdev.c:351
   chrdev_open
   ...
  refcount_t: underflow; use-after-free.
  WARNING: lib/refcount.c:28 at refcount_warn_saturate
  Call Trace:
   ufx_ops_release drivers/video/fbdev/smscufx.c:1135
   fb_release       drivers/video/fbdev/core/fb_chrdev.c:378
   __fput

Reuse the "has this fb_info been registered" test that ufx_setup_modes()
already uses: take the error path only when refcount_read(&info->count)
says the core did not register the framebuffer.  A failed console
takeover is not fatal for the driver, so report it and keep the
framebuffer registered; the disconnect callback will unregister it
normally.

Fixes: 3c8a63e22a08 ("Add support for SMSC UFX6000/7000 USB display adapters")
Cc: stable@vger.kernel.org
---
 drivers/video/fbdev/smscufx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
index 5704f60e1741..2aa001d58aaa 100644
--- a/drivers/video/fbdev/smscufx.c
+++ b/drivers/video/fbdev/smscufx.c
@@ -1697,8 +1697,16 @@ static int ufx_usb_probe(struct usb_interface *interface,
 	dev_dbg(dev->gdev, "registering framebuffer");
 	retval = register_framebuffer(info);
 	if (retval < 0) {
-		dev_err(dev->gdev, "error %d register_framebuffer", retval);
-		goto reset_active;
+		/*
+		 * info is installed before the takeover can fail; freeing @dev
+		 * here would leave registered_fb[] and /dev/fbN pointing at
+		 * freed memory.
+		 */
+		if (!refcount_read(&info->count)) { /* not registered */
+			dev_err(dev->gdev, "error %d register_framebuffer", retval);
+			goto reset_active;
+		}
+		dev_warn(dev->gdev, "console takeover failed: %d\n", retval);
 	}
 
 	dev_info(dev->gdev, "SMSC UDX USB device /dev/fb%d attached. %dx%d resolution."
-- 
2.34.1

