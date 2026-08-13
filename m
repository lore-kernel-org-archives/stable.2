Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA9C9366049;
	Thu, 13 Aug 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786607243; cv=none; b=gyEmmVEAJrkobEwr78vCdv4qhWznXtU9uDENZqddKl00nwWPOsJDpb+sBqQuxh9N5uwykFXbd6bwJ6jEMa9gsIBbJIrGeXCUggRibfsLU2mm9SC+1k+0drbZS5m0GmTtSwwM9p+VHn4yCu/XxazrHJDw0TXgSDH+I3+K8K9H18I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786607243; c=relaxed/simple;
	bh=X+OXOYPSsrmDy2c9iIRPj5nfv23VvKfuTz2FMN7o1Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F0hBomdkiwHa5N3lNn93nJjJVewekiYKOomDiCQMkXRYLWNWLXTu6TjJLOAhO0RGusOnUVv4KTBrYmobs3tqaNUHJe5ybjjC3Zx0Lknt5wkB8XVVc2sgWncTAskiwDas3ZqxkKO14naT9xr89nVzxQPsB++GDY4bHDOX8xg02uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=AAS7fvz2; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="AAS7fvz2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1786607213;
	bh=zicWAm5MbU2tRVVIPG38J10zV0U6MnbAHb2MbjusmWo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=AAS7fvz2dhtXYvs3SYOIuL+JLJE8LwVuTXJ7s+5Cv7l5nPMZ/KfaTchcVBBik8aMJ
	 45nDRMWagxON2V3raNyTX0SzFvFz6cWo3XlEFxgOfrRwbYdaAv8PD4G4HRlgkdJViD
	 vbos4CyUwuVP7i3aq5UZnUyGBtduc+y5qvnkLLa8=
X-QQ-mid: zesmtpsz3t1786607196ta47fc170
X-QQ-Originating-IP: ufYBX3axfKCgt1N0BtezjlLIVWAeAsFZh7C3+ehIa98=
Received: from PEN202512010004 ( [113.57.152.160])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 13 Aug 2026 15:46:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 4013999842750200519
EX-QQ-RecipientCnt: 7
From: raoxu <raoxu@uniontech.com>
To: laurent.pinchart@ideasonboard.com
Cc: hansg@kernel.org,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	raoxu@uniontech.com,
	stable@vger.kernel.org
Subject: [PATCH] media: uvcvideo: preserve status URB interval on resubmit
Date: Thu, 13 Aug 2026 15:46:32 +0800
Message-ID: <F0F008459FFA835D+20260813074632.2021311-1-raoxu@uniontech.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MvyKdZyVtFx3ogxxWRGDkb3YiPYHKwZBiMFHcwwAbqAQD4Dj38MNHzYE
	jOL2LecPNmYpW3fXozzNdeT36QpbwI8Zjvm7WtNu+qG/tWS6ox3XEipnQelmTtph6gba23+
	wybXdlo6Sm4xIW25/2tAL4E46kRiYpO+OFykOLkxMtZanh74sDqzGSTUj7wdAL62LgNaj+a
	yFd96HYxJXgplzgpGIhzwRpqzaS9E7J1YVo5zCR9mCzWCGWtIFGvZ0MEz+lZzGgbcM5NvaK
	e0k4/JrOuKLXhuMwrz1TdUCCxQwPxzMtjVuJR/G2pcALgMifobdGpZwEjNpf+x1K6qSIg5i
	TByMgQ8PoCwjEvbln6YnMQqw6/kyEEtw0urjIrwvkMLrw87XrytWdrFLX1n+sEP9Xfa/ez2
	3G/uGiaklLOJDETJLBx8p1IE/YOWzXss83aQ2dXBbTNYikU5HphWdBvpFWGW0R85l/pb31+
	ymW1T63FIDNcnzThsRbQwGGj4ZBLcw+6FZANH2mZAH5GCeLU38ccsf/M3rE0sMNdFcz7kMy
	EDxKldsgVHyEUn7Szt9+4wZtfN/ux966Zdmi4OLV53NccwU0egfsRYEj9ng9i+m41qXupZ8
	ggYbsmMiA3ubjAfBUZL37xtCw7cSyLCeA3XjF+60Ril5ccsKLVyRgZo7DbdVwC86Fc+wiN/
	X7EkiR+2/dTqbDuHQQmT4jS8HaQtrOLxCtIDr2IajXO+0bZQ7UEy65sOEZIqhwUGzUNcb22
	ueICrsHcqTdnzmO9y/k7xHQDilvbZZhbHiLEqe5akMbohMglIkzOB1yokGGuzhK6OzsGq0+
	r61sYJzlXhavPwWzbUOlD2YDtms4eWbLX7+svXzSwf7uLCov0tgKBoVlgxsntpJ55zpVoBM
	gPE9Sq34wA1Y0YVVpFEtZI1L0Rn8PEOyDB3fA13yBJkulE39gFgnXyaHV2VYg/VQeeZirS/
	9I0cIobwrbdQ2ATaumbT4KSnAIrlIM9Tg7yFLFbK4WhiFNjI388WdRhqWE2ltNY2fUcpTCK
	GIg/b05cJjmLia7wCaCl8IxRx3+5GbyaY8QDGBA/l6fml6BAtqkBiirTn1hwQ=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0

From: Xu Rao <raoxu@uniontech.com>

usb_fill_int_urb() takes an endpoint interval value and stores the
period expected by usb_submit_urb() in urb->interval. For high-speed
and SuperSpeed interrupt endpoints, it converts the logarithmic
descriptor encoding to the corresponding microframe period.

The UVC status URB is initialized once in uvc_status_init(), including
the UVC_QUIRK_STATUS_INTERVAL adjustment required by high-speed devices
that report bInterval using the old full-speed convention. The first
submission therefore carries the intended interval.

Both status resubmit paths, however, overwrite urb->interval with the
raw endpoint bInterval before submitting the same URB again. On
high-speed and SuperSpeed devices this mixes the descriptor encoding
with the already converted URB interval representation. For devices
using UVC_QUIRK_STATUS_INTERVAL it also deterministically discards the
quirk adjustment after the first status completion, making the
workaround effective only for the initial submission.

This has been easy to miss because the initial status submission is
correct, full-speed interrupt endpoints do not have the same
logarithmic encoding mismatch, and the status endpoint carries
relatively infrequent control and streaming notifications rather than
the video payload itself. The problem only appears after the status URB
has completed and is resubmitted, and the externally visible effect
also depends on how the host controller handles the resulting period.

Do not restore bInterval when resubmitting the status URB. Reuse the
interval established by usb_fill_int_urb() and usb_submit_urb(), which
also preserves the quirk-adjusted value. No additional state or
interval conversion is needed because the same URB is being reused.

Fixes: c0efd232929c ("V4L/DVB (8145a): USB Video Class driver")
Fixes: e5225c820c05 ("media: uvcvideo: Send a control event when a Control Change interrupt arrives")
Cc: stable@vger.kernel.org
Signed-off-by: Xu Rao <raoxu@uniontech.com>
---
 drivers/media/usb/uvc/uvc_ctrl.c   | 1 -
 drivers/media/usb/uvc/uvc_status.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
index 3ca108b83f1d..6552f541aa0d 100644
--- a/drivers/media/usb/uvc/uvc_ctrl.c
+++ b/drivers/media/usb/uvc/uvc_ctrl.c
@@ -2196,7 +2196,6 @@ static void uvc_ctrl_status_event_work(struct work_struct *work)
 		return;

 	/* Resubmit the URB. */
-	w->urb->interval = dev->int_ep->desc.bInterval;
 	ret = usb_submit_urb(w->urb, GFP_KERNEL);
 	if (ret < 0)
 		dev_err(&dev->intf->dev,
diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
index b632cf5e3fe9..680c6c7f4ad7 100644
--- a/drivers/media/usb/uvc/uvc_status.c
+++ b/drivers/media/usb/uvc/uvc_status.c
@@ -245,7 +245,6 @@ static void uvc_status_complete(struct urb *urb)
 	}

 	/* Resubmit the URB. */
-	urb->interval = dev->int_ep->desc.bInterval;
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
 	if (ret < 0)
 		dev_err(&dev->intf->dev,
--
2.50.1

