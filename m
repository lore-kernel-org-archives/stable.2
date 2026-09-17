Received: from out28-53.mail.aliyun.com (out28-53.mail.aliyun.com [115.124.28.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11C74534A4;
	Thu, 17 Sep 2026 10:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641101; cv=none; b=RrmP8I3I7oXbyfr/KPZSsx+LoKpZyCEhysSeNa7fABQ8Z+76sECf1Hx7g277gRc/uG1uhXYv/okf8pFrFGzhT3wTkgYYyhHbkXqcLO8cZrBlH5aCnK89lXDS2I2RXJzwQaJ7n5bMaqjO57dUrGdF8Wps4Ii0//Anot2b7VusH8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641101; c=relaxed/simple;
	bh=6WwM4zWmyml5U1shtxD5HvQwmjM/0qzDzTH0FYMZf4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c4KT6/NM+scMC21zUuxmvlz9Oi7g94sLdyY28KSsJf0Rlht78Ra+fUtsDSwYUHZtk2Qw8FiEUpVH2hpX6DF0eK6ncRrtlhzYyIi6ihDB3+xBbAbdidaC52ZfV7NVaeulOjhvMoYxrD7ib69eotluMt/Ev45XfhM+tLOUJOavl34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=RDlShUc5; arc=none smtp.client-ip=115.124.28.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="RDlShUc5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789641086; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=VTxY3B8DXpO05NycXHLAtYasw1r4ZUPz9JH+D+U2R3w=;
	b=RDlShUc5tPOHWCxTShomaU0bVCG9bS1R76/uGn7wPOZv7Y2sxQ/e1n/X6v3JIhV6qxCMLtonVUpfnOQcg1LT8apjnd34FQQkciLM1IOg6JsR5dMvcLlwhOzRR/3JgKH0vDR+GXHrfJqIvZuXJXJpvSITsPw0i5ZaU5IaYwrwhnA=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.2178468|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00468059-0.000105028-0.995214;FP=12672549288533534592|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033040074035;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=7;RT=7;SR=0;TI=SMTPD_---.jFllRrg_1789641084;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFllRrg_1789641084 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 18:31:25 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: laurent.pinchart@ideasonboard.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: uvc: reject zero interval in uvc_v4l2_s_parm()
Date: Thu, 17 Sep 2026 18:31:22 +0800
Message-ID: <20260917103122.3045458-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v4l2_fraction_to_interval() returns 0 when the caller passes
numerator == 0 with a non-zero denominator.  If this zero value is
stored in video->interval, the isoc path in uvc_video_prep_requests()
computes:

    nreq = DIV_ROUND_UP(video->interval, interval_duration);  /* 0 */
    req_size = DIV_ROUND_UP(video->imagesize + header_size, nreq);

The second DIV_ROUND_UP divides by zero, crashing the kernel.

Any local process that can open the UVC gadget's /dev/videoN and issue
VIDIOC_S_PARM with timeperframe.numerator = 0 followed by
VIDIOC_STREAMON triggers this immediately.

Reject a zero interval in uvc_v4l2_s_parm() before it is stored.

Fixes: 0525210c9840 ("usb: gadget: uvc: add VIDIOC_S_PARM and VIDIOC_G_PARM support")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/function/uvc_v4l2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/gadget/function/uvc_v4l2.c b/drivers/usb/gadget/function/uvc_v4l2.c
index dfa0521a2..e9b9288c5 100644
--- a/drivers/usb/gadget/function/uvc_v4l2.c
+++ b/drivers/usb/gadget/function/uvc_v4l2.c
@@ -368,6 +368,11 @@ static int uvc_v4l2_s_parm(struct file *file, void *fh,
 	video->interval = v4l2_fraction_to_interval(timeperframe.numerator,
 						    timeperframe.denominator);
 
+	if (!video->interval) {
+		uvcg_dbg(&uvc->func, "Invalid zero interval, rejecting\n");
+		return -EINVAL;
+	}
+
 	uvcg_dbg(&uvc->func, "Setting frame interval to %u/%u (%u)\n",
 		 timeperframe.numerator, timeperframe.denominator,
 		 video->interval);
-- 
2.50.1

