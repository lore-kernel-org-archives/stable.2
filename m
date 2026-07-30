Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6583B0ACC
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785399889; cv=none; b=l7/7lxITF4jUAxbsdpkyR5rnq3zht0VbUFOtIdWb06h+m+ff/RbwHT1yzgbeMpoTRmB155/+XCaQ7bkTx3syv2Yp1sy0f2id8aV3G25Cu4Zd28toTte0qdDi3Iqp6FzDgPOBmaHIx+2O3URbUF8XAyAgjUj2hWxBR/bpZPTkynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785399889; c=relaxed/simple;
	bh=gntGOjhXBA07pEHUhCuN5FxM8fYNhjoRrBO+RAoJbEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ekpcmjwptIKpevWnwtG2sQ3bSsEl2xwZ3v/UlRJd+GUUcKczOmnj3Sbcti4isKS9Gr+DjjXoCuR83DJlW4YkdsvDMlR+H9RzQq/NTm2C1qBWJnU2HoRA9ys5daujaZDI6JALicWthmMgNh0hIIL14uM1VmLEL6rord4cw9L2afM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PxGNGUN/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PxGNGUN/"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38e69bdb0fcso1417230a91.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 01:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785399888; x=1786004688; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=W5J4K0JrlDOYNnYHo+BgER+kVovsWbiV6MG4x4gNbJQ=;
        b=PxGNGUN/Qa8Ut/M97G+OzzqrceHThC3ny/kB23pNtkCFf70B52XpizRrEavs4E5oxM
         yKg4dLMxuRJchi5pUk/4ycC+qgEQR5UL17TAWGBGkAA1Xf1mvh8I0qiOPPkjg//snt0a
         A1fHM7CSxcPsBoibhNd18NmPRFR6IaaxrxIWKkCVd75bnB7o6ZgCTgp3aJt0FteZTy8M
         2Yv04QfTO279XSeVY9W4D4Kt7AegSE1ExkTsAnQQZdgCCvkZYi397Dvez9LTBJpZif0w
         hHnhWToUuNgGouMLaWXpo1V2Wl7mgNYdYvbZKRpG+oFl30Ksp9KxRABOB2Sw2p6suYKl
         E/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785399888; x=1786004688;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W5J4K0JrlDOYNnYHo+BgER+kVovsWbiV6MG4x4gNbJQ=;
        b=Z2OqaY0kLuoYe+rhxv55IF2vGuEkN4EHvprM4wN8Knujn7wSLj8e3OBCLjiqBoVbDa
         XuMYOQuSrxjm4rrdOihnEFo41QJymd5BP1oaoZxJwm+/szR04D0aCbzF1vliepwdnr0M
         4lImhAVbWh76raoLyCkZVoY4q7kHLtO7DMwZTxh8aaKL8xa6lEaZw9aI3mZD7BJ6/Q/R
         F9iHffKxtSKWNfGXo5oYYcMq5vcia7vR5VoTGkHkZxVvrMFGs8zEVC+6Xw0XKOtryCzM
         EigHyuexEoIky0XtYfYPDczsDRVZd8IqieXoQHB49wfsw8/CPPcXSYL5pyOjj5o/j5pd
         zImQ==
X-Forwarded-Encrypted: i=1; AHgh+RovFPn5C59uB5eGQOKRVFu8WZ/AS00ds/8uTOzkDAfFN70blgxDlvW2M1o1+GXVY9HIY4JBifQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6dW/AYlsKwXafkJH9dqrddaQKQpg+V7dH+1V4yIXWRNf15MSE
	WQ/IfzyhggUTWy/hDJcwRVDQ37AubKUfMJexzAYP4PHtdZ9XVyOZA5fl
X-Gm-Gg: AR+sD13RR3C8cX3QD8Z8Yed0A8PBYjlgeLf5KIOybryRscTknNWfopQLRXK3KNP7YR2
	53R0/1KXnRVq14+Yi3BV5M7Z10TVgnc6Hd784To/BwCoMYyfHlC0ktv1S2C6xus1siPYJrCvtFY
	cBwDCODO8C7u86BApOJQvXaRzJbxuARG7i5JxnJUGHsVIP9S27g9fs/eMYeCeEtgZocW7irj+Wz
	4a1XFWVOHawx/FVuKf+efcChMv8THu2D61krFz1/G5Fu38HVc8b93JPV/s3z8W3AnFTPgkOfwmG
	Wd/j7iTLxhC5gpJAYadKFNFFfMCebK+Q8DrAp2DWapR7pPzbYs8xHoYYGaw1dev3yhbW703haxs
	uDThdiJNFIjdJh1tK4iLp7l/4Hpf+MrugtOTWlcCjMRaNBw1gwi55qmvVYjiWgcELL7u0sG3Wcn
	TnpA2eou9PnoWXDWZOd+TMYbcGpSs+f23R+F3rP0CoqtmF9hNxj8Zv1ie+SSCcbtPNdA==
X-Received: by 2002:a17:90b:1d4d:b0:38e:5dc:af03 with SMTP id 98e67ed59e1d1-38f9c1016e8mr1412538a91.40.1785399887890;
        Thu, 30 Jul 2026 01:24:47 -0700 (PDT)
Received: from Default ([2409:40f4:100d:2c91:aff5:d71c:30c2:c60a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b124e4sm17281938eec.6.2026.07.30.01.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 01:24:47 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: xu.yang_2@nxp.com,
	Frank.Li@nxp.com,
	kees@kernel.org,
	panjunzhong@linux.spacemit.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3] usb: gadget: uvc: Fix Null Pointer Dereference in uvcg_video_init()
Date: Thu, 30 Jul 2026 13:53:20 +0530
Message-ID: <20260730082320.9597-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uvcg_video_init(), if kthread_run_worker() fails,
the error logged uses uvcg_err(), however, the pointer it uses:
video->uvc is not assigned at this point, triggering a null
pointer dereference. Fix this by directly using uvc->func which
is assigned already.

Reported-by: syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8dcac923582c28505fd7
Fixes: 7ea95b110811 (usb: gadget: uvc: rename functions to avoid conflicts with host uvc)
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changelog:
 - Small fixes addressed in v2 discussion
   https://lore.kernel.org/all/20260730070207.16065-1-jeffinphilip14@gmail.com/T/#u

 drivers/usb/gadget/function/uvc_video.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/uvc_video.c b/drivers/usb/gadget/function/uvc_video.c
index 2f9700b3f1b6..9ba09118bb74 100644
--- a/drivers/usb/gadget/function/uvc_video.c
+++ b/drivers/usb/gadget/function/uvc_video.c
@@ -821,7 +821,7 @@ int uvcg_video_init(struct uvc_video *video, struct uvc_device *uvc)
 	/* Allocate a kthread for asynchronous hw submit handler. */
 	video->kworker = kthread_run_worker(0, "UVCG");
 	if (IS_ERR(video->kworker)) {
-		uvcg_err(&video->uvc->func, "failed to create UVCG kworker\n");
+		uvcg_err(&uvc->func, "failed to create UVCG kworker\n");
 		return PTR_ERR(video->kworker);
 	}
--
2.55.0

