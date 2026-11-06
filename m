Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.137
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793952783;
	b=bxVfbpkMOEUSos5cWpysuExu7uZXC6kXgzJGdqsx9BKvAsRCA77TYjulMFuTDI/UORn0
	 gPE5D6RvLiYX347HQPgWxWx311vpxyIXHUnjreJOF50OkA//MezznmKV4hVFTfW7gUpJm
	 j45CVdu0JwHAju+uBTqBlB7KcbmNjfY0Y/RwCbexwbyqpEI9M4tO8N8ySg9SmwMlpviL4
	 PPgyYszvrQQ8aHH0GTnWoLp2ZEzHLv8rnTgjRV5GLKc0IoK3sjDl2LeaFwCCaPTs2R0jP
	 OJD62c6r7EiG6Xdo3TsL1kOjCzBtm5L/5D0mB7uacWo1jCHMab/g2FjX8aTzbZ74dvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793952783;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=cpAgV4w6U0U/HuUVIVHBx3ZFGpiiR3doBeWDIG8xh+A=;
	b=HjALFGCmwAPgypRuyRHvChJqEh/dLB6vIZS5kB9UI5GomOlBHQPn2B45xtgFT4+VO3rw
	 wwL7+N5f1IiH906zAnXevrGaMDWiTIpCYZiDmxYIWvmEr6gjNML6cG+kAAWQWg8VMcpdS
	 NKdLIVkjOnnO6RITHJVsEtsTbbBfyUR6FjAHcc2EEOmAHK5WQe0epjpjY9FWfn4t9h5jr
	 39WmlOtCS79LZcEfSth8mDWjKITBoZ9EyluYqX/iVNL3kVl7rFNfaTeoi67JLZW7H4Mns
	 7FHu40E58mdfsWs7VJQgJ/MUNovdcmY4rrCrp3lC1HGH6NK6yKjqLBgrqxo4Bb9ZgpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bbElk0wl;
	arc=none smtp.remote-ip=111.22.67.137
Received: from cmccmta4.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76164606A333;
	Fri,  6 Nov 2026 08:13:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76164606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=bbElk0wl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=bbElk0wlLo5LB2pAoUs/ov3DtP3yxgvjIKvNuFdHGJpAfFV7TJDTFrdMIfrx3mXs39dXyw929wiz1
	 wmeWV4UiBU2HQ17TI5gpH+XbtKnWP2mlla8R4XmVaT+BIw87Rcr1OKtGpwEZ80NiBliCUahCj/btM9
	 GQKVXZAKfAq06Ows=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app08-12008 (RichMail) with SMTP id 2ee86aed8c092af-4f19e;
	Fri, 06 Nov 2026 16:12:58 +0800 (CST)
X-RM-TRANSID:2ee86aed8c092af-4f19e
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from Z04181456177947 (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee36aed8c0628c-184db;
	Fri, 06 Nov 2026 16:12:58 +0800 (CST)
X-RM-TRANSID:2ee36aed8c0628c-184db
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: linux-usb@vger.kernel.org
Cc: johan@kernel.org,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	syzbot+58b2d8b19cd6761a395b@syzkaller.appspotmail.com,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH] USB: serial: mct_u232: fix NULL deref in open error path
Date: Fri,  6 Nov 2026 16:12:54 +0800
Message-ID: <20261106081254.1389-1-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
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

The MCT U232-P9 has no bulk-in endpoint; received data arrives
through the interrupt-in endpoint of the second port, whose URB is
stashed in priv->read_urb by mct_u232_port_probe().  The generic
port->read_urb is only allocated for ports with a bulk-in endpoint
and therefore remains NULL for this device.

If submitting the read URB fails in mct_u232_open(), the error
message dereferences port->read_urb->pipe, causing a NULL pointer
dereference at offset 0x50 (the pipe field of struct urb), as
reported by syzbot on KASAN-enabled kernels.

Print the pipe of the URB that was actually submitted instead.

Reported-by: syzbot+58b2d8b19cd6761a395b@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=58b2d8b19cd6761a395b
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
---
No Fixes tag: the buggy error message appears to date back to the
original driver import; the introducing commit could not be verified
with the trees available to me.

Not runtime-tested (no hardware).  The affected lines are identical
in current linux-next (drivers/usb/serial/mct_u232.c @ ddfe51b0a0f5),
so the patch applies there as-is.

 drivers/usb/serial/mct_u232.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index 6570c8817a..ad11697e3b 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -459,7 +459,7 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	if (retval) {
 		dev_err(&port->dev,
 			"usb_submit_urb(read) failed pipe 0x%x err %d\n",
-			port->read_urb->pipe, retval);
+			priv->read_urb->pipe, retval);
 		goto error;
 	}
 
-- 
2.39.2



