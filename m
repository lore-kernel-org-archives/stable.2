Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C9A3921CE;
	Thu, 17 Sep 2026 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648339; cv=none; b=McpQaibA7U3RA3ANszL+h46wx5ckPkvMcvN/LLQU9CYmhJbCguK+odI1ITq7SDmjeB6swjmcHsU1Rw3tnDIeyB6s9hYJcJnS2+kMPS8anqOcvPsmTy4teqNKbY3FEvOA0e1ZHITtdmKO67LwfAB7WyJsPHNZyEniW28NvhMukII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648339; c=relaxed/simple;
	bh=Pug7M4IT6rWwRxW9iTTNHGXKQzUxRzSZXDGkpLBNpIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dqhlpAXmrblwI7UT/VjdI6FCe5BnoWJ36D0nrZl+yGaI+NZZT0uOiAUzG3XXmnoB8+MNG65fn5EGl9hEvfVyQekSmtMoJqwSMpgXKPk1i3qt2GZXdHQ4Rv+TW1Jpwo1xfgzfQ1CDLwLnbWBpVYRlGmAlZbIv2/CIkQRidOocuoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=bCukumxQ; arc=none smtp.client-ip=115.124.28.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="bCukumxQ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789648318; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=8NF2rd+cv8YtGG4lXDipr2Cs0djPX++7fTapxfMoBbo=;
	b=bCukumxQH7S80H9B51VsCstku0JdVmST3dXad9Qy/pw2jssD2EQbSwREJnN7oky3PsLEv8bfvgrmzOoJV1Hb5D4TuZhOYyEm4svsK0yqWFNcdXRABgXm8KO1WEe9872lSt78HCvnuzFvjwvmq6VK2Ra7ayP+hH7Doe7Cx8R6HcQ=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09092806|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0228438-0.000426674-0.97673;FP=9691176561265935824|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam011083013073;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jFxK1w6_1789648317;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFxK1w6_1789648317 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 20:31:57 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: m66592: add NULL checks for epaddr2ep lookups
Date: Thu, 17 Sep 2026 20:31:55 +0800
Message-ID: <20260917123155.3763038-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_status(), clear_feature() and set_feature() look up an endpoint
via m66592->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK] and
immediately dereference the result.

epaddr2ep[] is only populated for EP0 at probe time and for other
endpoints when they are enabled via m66592_ep_setting().  If a USB
host sends a GET_STATUS, CLEAR_FEATURE or SET_FEATURE request
targeting an endpoint number that has not been enabled, the lookup
returns NULL and the subsequent dereference causes a kernel oops.

Add a NULL check after each lookup and stall EP0 on invalid
endpoints, consistent with the error handling already used in the
default cases of these switch statements.

Fixes: 0f91349b89f3 ("usb: gadget: m66592-udc: Add support for M66592 USB peripheral controller")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/m66592-udc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/gadget/udc/m66592-udc.c b/drivers/usb/gadget/udc/m66592-udc.c
index d77c11c4e..1d0755f79 100644
--- a/drivers/usb/gadget/udc/m66592-udc.c
+++ b/drivers/usb/gadget/udc/m66592-udc.c
@@ -977,6 +977,10 @@ __acquires(m66592->lock)
 		break;
 	case USB_RECIP_ENDPOINT:
 		ep = m66592->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		if (!ep) {
+			pipe_stall(m66592, 0);
+			return;		/* exit */
+		}
 		pid = control_reg_get_pid(m66592, ep->pipenum);
 		if (pid == M66592_PID_STALL)
 			status = 1 << USB_ENDPOINT_HALT;
@@ -1012,6 +1016,10 @@ static void clear_feature(struct m66592 *m66592, struct usb_ctrlrequest *ctrl)
 		u16 w_index = le16_to_cpu(ctrl->wIndex);
 
 		ep = m66592->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		if (!ep) {
+			pipe_stall(m66592, 0);
+			break;
+		}
 		pipe_stop(m66592, ep->pipenum);
 		control_reg_sqclr(m66592, ep->pipenum);
 
@@ -1069,6 +1077,10 @@ static void set_feature(struct m66592 *m66592, struct usb_ctrlrequest *ctrl)
 		u16 w_index = le16_to_cpu(ctrl->wIndex);
 
 		ep = m66592->epaddr2ep[w_index & USB_ENDPOINT_NUMBER_MASK];
+		if (!ep) {
+			pipe_stall(m66592, 0);
+			break;
+		}
 		pipe_stall(m66592, ep->pipenum);
 
 		control_end(m66592, 1);
-- 
2.50.1

