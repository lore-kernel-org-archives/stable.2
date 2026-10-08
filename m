Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BAA3CB544
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486800; cv=none; b=b+GRfYKyetA8MiPUMof8Bdicga6IfRvEe+cmCP01haYNN2Ay0KADTWd1djLX3vIbD47BOko2L7uyBR4/ezPvirV+0P2Cxz4inOQUeROsP61r3r7DAeNNqq8T1nD31w7nlThSZDiHdxpmr/AwMUyfvXKL8Xqe3wH9vRDAeZn/6Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486800; c=relaxed/simple;
	bh=DXiazg6UQaRF76JYvcx8H+xAmZxX+Ufp+SNzoF0UFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pkItaQ2NizwppNR6t8LZv3IvVaQ9GrXEIzIO/TOQ3uZQHEmU5IjbWptqiZ9y4B1o0WMhoC8qNhfDGfEsx2C93Mx2MbpO3FKwbtrprnNEEOSqX8+iCknQcyLMY8DzSi+m50G66J9uf9kOREFfDhd78oYqGA1K9Di2V1hsqbVClow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=INmdfW9O; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="INmdfW9O"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33fb4680717so2079377eec.1
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 12:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486796; x=1792091596; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IWU3gZsRjQK7kls2sJA9yEwySYblQEWHXA6BXaEKqjg=;
        b=INmdfW9O+H+7B5/3X6RGDluPhHT+Y5KHtiwZQvgTA5viCZbLjFbeNGpR4Q08SYBOWZ
         36XKXFnZ/7ikB/aKCMslP3MOeznOvxoHvI5DyXCY7+UJogg503gh5HLJKnmoJpN3JW9P
         K57j2+pYhe6/Musg+Iv0j7vFLJkGHNVc2fF6/t5jGf1s6huIOsMz4bEQce3rqdKYxxwi
         57QOB+FrbNx3tL6YgL8tFHDX9n8HXtQ2dSsjIetSoMgICvBf/4I5J71D5lAbUqglk/4E
         Ux/ZHynYetNf8uWDQBFQEYTFeWtuXfSvnXhgfv2AQRbXfz/VNjkttA8PAd+lBa68OIo0
         nCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486796; x=1792091596;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IWU3gZsRjQK7kls2sJA9yEwySYblQEWHXA6BXaEKqjg=;
        b=eLSAB/kgfrEGALggvaO7fZl+pht/eICekyeH4cd1T8uPVTLRXdtI9hEshwLkeIKnsF
         YBGpSvNRGy1nUBGnvrMZq1VmTddGNRoJFVZF91sW/FWXnfCOQO4MW8xWO2fRLLw2XVcF
         lufCJkSO2D+Ogt9ozUgYY7onKu7v3bsGeyiNuqXYH4uvwouPw6N2S+w7vXC/Qr8LT04e
         mqwf0P2WLOmvpInqpplpHX91a/88SLjQ7BiGWWDSZShqZOo0Y/2rIbfDOXoO99IxUJ8q
         B6VpPBmEcyjvUFHjMYyvRDwjZJLD0I8T81BQdkOyyXl+1fKE0qV/QwAxXaWN6SzJvWwY
         5ebg==
X-Gm-Message-State: AFq9FYKW8+k+b+uAIvj0FmMRMfK5iMy3wRthapNCFv6GZWCrzUzWFMzQ
	wHZ2NAffppbSEaLv6u1F64QEZL+HEPm8C99xQC3dJHSQhFGHmKxubPRW1UXGFXYTYhduxzX6iQq
	6haLnas/iIg==
X-Gm-Gg: AYBFou2YoFjLosgtUZEvUhhEWcKvr0NCJn4CF8rp4C9NKYUCm5to3lqb3rjzgXo6lCB
	bWKDu28ilzsSs2c9XJeWH1b9l9P5Hu8pes1F9J+w054qsr5eBAZV7Ratbe8RiEEfMPp2tczs1+T
	z7WMQo0YDpvedll/u6kUygmAcDk4ObdbFcKFswKdsrPqqs1zRoMRCQDtLv6KBXYBsxP+PNSrmoS
	e0TrgsAdmjBZqPLxl67FGh8FErLABqYzIUoph1sk2oWrgE4x5ygqC5C5U5bZIXeY/65nbTQJfQC
	8gHxJb4hU9xzmnDeCsxrxpjmIBgw9G2kHJaUAqMP/xrUC2hBIMjGx5xVADcUriq+JpWzAoE60bW
	yaTxLUZtylK3kkoR/ou3RP+bhS4SLA9BiZgpGmpL/tOq02JO8fXxK60gffg3qiFKn7NmsqXb8AV
	dIGoAbf8Kt8equ+Mig6zEX3AKVRWoI+TQRKwte0+x/MV+1Jm8V33mlnbD/dh/4mGj207NDklSRb
	a4HKS+32uhRbnNizj1is0rx1mM11QMixhqT7A9RhOy3Ynf5STjz+185EDPLhO24wWHk50g=
X-Received: by 2002:a05:7301:b8b:b0:351:78e9:944e with SMTP id 5a478bee46e88-35178e99942mr4032116eec.41.1791486795573;
        Thu, 08 Oct 2026 12:13:15 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:13:15 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org
Subject: [PATCH 6.6.y 2/2] fbdev: hyperv_fb: Allow graceful removal of framebuffer
Date: Thu,  8 Oct 2026 15:13:05 -0400
Message-ID: <20261008191309.98263-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008191309.98263-1-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit ea2f45ab0e53b255f72c85ccd99e2b394fc5fceb ]

When a Hyper-V framebuffer device is unbind, hyperv_fb driver tries to
release the framebuffer forcefully. If this framebuffer is in use it
produce the following WARN and hence this framebuffer is never released.

[   44.111220] WARNING: CPU: 35 PID: 1882 at drivers/video/fbdev/core/fb_info.c:70 framebuffer_release+0x2c/0x40
< snip >
[   44.111289] Call Trace:
[   44.111290]  <TASK>
[   44.111291]  ? show_regs+0x6c/0x80
[   44.111295]  ? __warn+0x8d/0x150
[   44.111298]  ? framebuffer_release+0x2c/0x40
[   44.111300]  ? report_bug+0x182/0x1b0
[   44.111303]  ? handle_bug+0x6e/0xb0
[   44.111306]  ? exc_invalid_op+0x18/0x80
[   44.111308]  ? asm_exc_invalid_op+0x1b/0x20
[   44.111311]  ? framebuffer_release+0x2c/0x40
[   44.111313]  ? hvfb_remove+0x86/0xa0 [hyperv_fb]
[   44.111315]  vmbus_remove+0x24/0x40 [hv_vmbus]
[   44.111323]  device_remove+0x40/0x80
[   44.111325]  device_release_driver_internal+0x20b/0x270
[   44.111327]  ? bus_find_device+0xb3/0xf0

Fix this by moving the release of framebuffer and assosiated memory
to fb_ops.fb_destroy function, so that framebuffer framework handles
it gracefully.

While we fix this, also replace manual registrations/unregistration of
framebuffer with devm_register_framebuffer.

[ Backport to 6.6.y: retain explicit unregister_framebuffer(), but call it
  only after delayed work and the VMBus channel are shut down; defer
  hvfb_putmem()/framebuffer_release() to fb_destroy. This preserves the
  upstream teardown order without requiring devm_register_framebuffer(). ]

Fixes: 68a2d20b79b1 ("drivers/video: add Hyper-V Synthetic Video Frame Buffer Driver")

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1740845791-19977-3-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1740845791-19977-3-git-send-email-ssengar@linux.microsoft.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 2 of 2 in the ordered 6.6.y backport series.
This change addresses CVE-2025-21976. The target remove path unregisters the
framebuffer before completing driver cleanup and then directly frees its
memory even when another open reference keeps the framebuffer alive.
This needed a target-specific adjustment; I called it out in the bracketed
backport note above.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 drivers/video/fbdev/hyperv_fb.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 80e6d9682179..e0d68953aa1a 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -283,6 +283,8 @@ static uint screen_depth;
 static uint screen_fb_size;
 static uint dio_fb_size; /* FB size for deferred IO */
 
+static void hvfb_putmem(struct fb_info *info);
+
 /* Send message to Hyper-V host */
 static inline int synthvid_send(struct hv_device *hdev,
 				struct synthvid_msg *msg)
@@ -887,6 +889,17 @@ static void hvfb_cfb_imageblit(struct fb_info *p,
 					       image->width, image->height);
 }
 
+/*
+ * fb_ops.fb_destroy is called by the last put_fb_info() call at the end
+ * of unregister_framebuffer() or fb_release(). Do any cleanup related to
+ * framebuffer here.
+ */
+static void hvfb_destroy(struct fb_info *info)
+{
+	hvfb_putmem(info);
+	framebuffer_release(info);
+}
+
 static const struct fb_ops hvfb_ops = {
 	.owner = THIS_MODULE,
 	.fb_check_var = hvfb_check_var,
@@ -897,6 +910,7 @@ static const struct fb_ops hvfb_ops = {
 	.fb_imageblit = hvfb_cfb_imageblit,
 	.fb_blank = hvfb_blank,
 	.fb_mmap = fb_deferred_io_mmap,
+	.fb_destroy = hvfb_destroy,
 };
 
 
@@ -1246,14 +1260,11 @@ static void hvfb_remove(struct hv_device *hdev)
 
 	fb_deferred_io_cleanup(info);
 
-	unregister_framebuffer(info);
 	cancel_delayed_work_sync(&par->dwork);
 
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
-
-	hvfb_putmem(info);
-	framebuffer_release(info);
+	unregister_framebuffer(info);
 }
 
 static int hvfb_suspend(struct hv_device *hdev)
-- 
2.39.5
