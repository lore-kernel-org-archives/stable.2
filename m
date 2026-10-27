Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=111.22.67.135
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084503;
	b=qaPzu5F4U6iK3ze6TrC5Kp/Ao/ilEGK+kBmu4J0BBQNhHXgVgDo8GQ3QGGbhSFshyg3A
	 O4M1Wim6snz+Sz/DOWM1drzpKxVHDyFM39yHpT0APpK47eEssLIFIbU5k/N85no5tBMXq
	 LCC8TkulNthkG9qFU5eIwXzlAyh6IVsBj3y27S8i7/FWTciI2KeOh3sUOP8iosfswbxec
	 Y3Rs8cYc/vkAOPr/L4DzniOxPi1oo6zDYRWuB4M7+YDMi+22nffqQiddVIbn95pl6bGTu
	 gj5EF9Hba0pYyW/iTWWLbkIvvR5haofzHwwho/H9NjBlxYQFyyt+8HqUAsmmWd9y1dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084503;
	h=DMARC-Filter:DKIM-Signature:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:
	 X-RM-TRANSID:X-RM-TagInfo:X-RM-SPAM-FLAG:Received:X-RM-TRANSID:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=02Uz2Vl5PMj3H0XVcfZQT2jH6lSBsH/c66JZZZkAW9I=;
	b=WtaWxSeKlTnA7mg0jym1ZCTZVCrxYPQ0G5XMk3j163944NyieJASt6zZt+TkHMCRTD1y
	 d5MPg1OxdRFIU8Gjoh8352fNWMnD1/fnuRaot4l5g03j+poT1ZM99Ah7GPMZb8gf3uMSe
	 W3f2pFz8+xgKTgeCYtp992p9d2VKCsMY3bhC8oV1IEfPlWkPtz3rX+wgTZo6UiLBRwIdn
	 gi6Z+HE4Wv+cTFhjUITsqzukflT0oCAAFJ89nVjBqT7t6ZCtGwiPCGs0N7MSV/+QZM33x
	 rJpaIfLkfRN35K+EUgKLVgzoenkxawEOor4qnLFnsSBdwWpCDJlvlzBc5hvDtya51Vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cmss.chinamobile.com;
	spf=pass smtp.mailfrom=cmss.chinamobile.com;
	dkim=pass header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QUyR5bYW;
	arc=none smtp.remote-ip=111.22.67.135
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBBA606A324;
	Tue, 27 Oct 2026 07:01:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBBA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=QUyR5bYW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=QUyR5bYWgCnNOP98IU3IUwTAcW2T0o3LaxF7vkDZ08XxWb5Pf7iPKVMGXuWdPyQwJM87GRuaz5GKM
	 INxMm7mSb5y+0ME0zPODLP6TEEtyCetrEvswUTlYQrM10CSGmyG+gjcuq2dfc4zS36Qvj5JmwnyChZ
	 iJjqO0EijAcXmVw4=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee36ae04c536e2-21444;
	Tue, 27 Oct 2026 15:01:39 +0800 (CST)
X-RM-TRANSID:2ee36ae04c536e2-21444
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from  (unknown[10.55.1.71])
	by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66ae04c509fb-d0e59;
	Tue, 27 Oct 2026 15:01:39 +0800 (CST)
X-RM-TRANSID:2ee66ae04c509fb-d0e59
From: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
To: netdev@vger.kernel.org
Cc: krzysztof.kozlowski@linaro.org,
	linux-kernel@vger.kernel.org,
	syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com,
	Zhao Feng <zhaofeng2@cmss.chinamobile.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] nfc: pn533: add timeout to USB frame send completion wait
Date: Tue, 27 Oct 2026 15:01:35 +0800
Message-ID: <20261027070136.1339-3-zhaofeng2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261027070136.1339-1-zhaofeng2@cmss.chinamobile.com>
References: <20261027070136.1339-1-zhaofeng2@cmss.chinamobile.com>
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

pn533_usb_send_frame() waits unboundedly for the out URB to complete.
A device that never completes the transfer makes the task sleep
forever in TASK_UNINTERRUPTIBLE while holding the command mutex, as
reported by syzbot (hung task in pn533_usb_send_frame).

Use a 1 second timeout instead.  On timeout, kill the URB and return
-ETIMEDOUT so the command in progress fails gracefully instead of
hanging the task.

The transfer may complete between the timeout expiring and
usb_kill_urb(); in that case urb->status is 0 after the kill and the
send proceeds normally instead of reporting a spurious failure,
mirroring what usb_start_wait_urb() does.

Fixes: 9dab880d675b ("nfc: pn533: Wait for out_urb's completion in pn533_usb_send_frame()")
Reported-by: syzbot+1c5368988052dc2d8201@syzkaller.appspotmail.com
Closes: https://syzbot.org/bug?extid=1c5368988052dc2d8201
Signed-off-by: Zhao Feng <zhaofeng2@cmss.chinamobile.com>
Cc: <stable@vger.kernel.org>
---
v2: check urb->status after killing the URB on timeout and carry on if
    the transfer completed in the race window; add Fixes tag and Cc
    stable; the pn533_wq_cmd() error handling fix is now patch 1/2.
    Issues reported by the Sashiko AI review.

 drivers/nfc/pn533/usb.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/nfc/pn533/usb.c b/drivers/nfc/pn533/usb.c
index 0b7e3b118d..265baf2213 100644
--- a/drivers/nfc/pn533/usb.c
+++ b/drivers/nfc/pn533/usb.c
@@ -30,6 +30,9 @@
 #define ACS_VENDOR_ID 0x072f
 #define ACR122U_PRODUCT_ID 0x2200
 
+/* How long to wait for the out URB to complete */
+#define PN533_USB_SEND_TIMEOUT_MS	1000
+
 static const struct usb_device_id pn533_usb_table[] = {
 	{ USB_DEVICE(PN533_VENDOR_ID, PN533_PRODUCT_ID),
 	  .driver_info = PN533_DEVICE_STD },
@@ -184,8 +187,20 @@ static int pn533_usb_send_frame(struct pn533 *dev,
 	if (rc)
 		return rc;
 
-	wait_for_completion(&arg.done);
-	phy->out_urb->context = cntx;
+	if (!wait_for_completion_timeout(&arg.done,
+					 msecs_to_jiffies(PN533_USB_SEND_TIMEOUT_MS))) {
+		usb_kill_urb(phy->out_urb);
+		phy->out_urb->context = cntx;
+		/*
+		 * The transfer may have completed between the timeout
+		 * expiring and the urb being killed; if so, carry on as
+		 * usual instead of reporting a bogus failure.
+		 */
+		if (phy->out_urb->status)
+			return -ETIMEDOUT;
+	} else {
+		phy->out_urb->context = cntx;
+	}
 
 	if (dev->protocol_type == PN533_PROTO_REQ_RESP) {
 		/* request for response for sent packet directly */
-- 
2.39.2



