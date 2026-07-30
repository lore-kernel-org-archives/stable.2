Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2F942E000
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415242; cv=none; b=uvnhmlWJPo5umhpbIIHRtHd7s/eNx3sRLXmOaSXqEdmTeEA6M2die998F6D/ZUqpwd6SJ8CHA54zhfHX5SmP/BTxprlURtV6Tc1jkMLd4yUrzpejKbIno59hbDE9H4EzB4j6T/dVIPp6tEiSM7ncbUGzAu+7+GJvu0s2EbyHisQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415242; c=relaxed/simple;
	bh=fONK/6k9BVEQqKWlP3oR8VWpkLY1KDrJ8eIRgRE2WHU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rT5qEIt3ZSZMSleYpNHiSMmJyH7QUqhI4/EIBjhVq2JZUyAJD26n+njp8Al8DpxtxSTQjjvX7+qtKZyRtX3U2/ReMLFPg/5TWzbnIOhdXdwaoKBdEbtIo1hoPtZMWsx/XTULkcqyLHcVRfpsDrvgGJD6/DxmGRhqLUII25ixspg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b0G/MzSN; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b0G/MzSN"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so1307816a91.1
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 05:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785415238; x=1786020038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L/7dzEjrRgdyFmDtxdz5LPMscHhW5+6zoxnA0y+daes=;
        b=b0G/MzSNGUO7w1s4yeP70jU8pUQ4wPWSnruWA4khCCAOiHhnK35PhlQWIVl/PgmNWt
         tFnAeL3osMVmCQDo82VsrV7G35GH6b28B9j8QQb2tjDyKbrVvSd0rEUT93WF/v5Gv5RA
         jItfEvxrqlikvDH26kuNn1YDsxobVqWY8gwf6zTvOyoiH9BVxngYjcADqza/CqlZeuTq
         M08wUOL8/yVh9hb5hvUGjA3l7LJSx8sgs9Z/iXSCEcbwPVDgJ7Rpsqk+Het6OKBdhwyt
         6/9tCoazN581mvDIo83YmuegB2eRaFnETP/wkHJQb7qsYFdFBQCtBP+yf4sAGZUBJS3I
         Zkbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785415238; x=1786020038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L/7dzEjrRgdyFmDtxdz5LPMscHhW5+6zoxnA0y+daes=;
        b=YxzEGAgpxNnnvTvEFchK+M4+/JVMbt/qftsFw01DECB1Ef9xcd6T6R+sS3S+wUFpXr
         40RO1bagz9LSm5XNYqZmvoH1sVQCDAuVl5nuJDxVRBXdL+Hx4QG4WACib54mJpO87bCq
         Yy1v1IkdX7YMugCxgFscj4LYEZQEdRqTkJam5TI0s26dmzrWdfmRW22J5SXMhI8Ouw7R
         4er7zLWL6IH/JEk30Pcor2f4Tm13XXCuUuP8hro2ltH61fe0FwegjyVCyOHLlzcZszXP
         X7vp0axmjvDbv8JaeL/mUCx1JuEC0I8e27j3mPTcEegwGQvSD+W80rpoyTPfS/PQFAW1
         Hb5A==
X-Forwarded-Encrypted: i=1; AHgh+RqWT498X42pb+HBpFPksnhoV9z2DTCYbFx3DneJCtcyTcBpTxfokJnFIhI+PFhsF5XQN/ZF/5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPObjLPyMAyzXXSi0jaCCC+tRpow9LMdQeUypX+HDUDdQ4GwKJ
	avJY9Jr3l/WNB8pLguhqyadGBsiKFyabZfUoCnSdgx4dhG60DHMVM1+k
X-Gm-Gg: AR+sD13VeqyOs6/OKaHQAwBR5JAZanXXs5t4U1zyBlkVmN2A10lVprs35ltDI9hXTIo
	LWLcGvGoS9SODamw195yRNaBP9dciYIiiZuccKCJUzV+7OBTRsTCKoyqWsXWUEyRUfk/B4FVDE8
	fxmfirHRdKQoZfmtVUfy73CR+S99Bhn9LHH89v5Hy2F6n4gKwlgQd/wuDZ6XRrTrZ4//S6WdYcz
	zRzUe2DppqCAQdLamrwbpp3YaaYgNMV3fyU+vDwaTqMgxHj0+vjRaAtel8d1ZDHeOuiFTauVXjs
	DMo1QB70Wfx6GE+/XFxKFxT74lmHjoVpxuJ5i1o+hdSVI9/0aSBM/uqe5ZYjvHyoES9QsNov3V4
	HiSIvrzlv9QFihM7rYucsEw3E37LtERQU5e7DE4NS7wUMcUeW5PwpKO+B46PicDNI+6vXv+XfwF
	inPayRIS8bA+lwjBFw4gVqsbEWRdLmbeHHlwQx4wOEDcqYT9x37XQso9hlPANVowuO
X-Received: by 2002:a17:90b:3d47:b0:38e:2e86:ed02 with SMTP id 98e67ed59e1d1-38f9be181b1mr2001265a91.14.1785415237935;
        Thu, 30 Jul 2026 05:40:37 -0700 (PDT)
Received: from Default ([2409:40f4:10f3:2277:aebf:f6c4:d4e2:70b4])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e72643a12sm32622646c88.5.2026.07.30.05.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 05:40:37 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: Frank.Li@nxp.com,
	kees@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	panjunzhong@linux.spacemit.com,
	xu.yang_2@nxp.com,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v5] usb: gadget: uvc: Fix Null Pointer Dereference in uvcg_video_init()
Date: Thu, 30 Jul 2026 18:09:41 +0530
Message-ID: <20260730123941.8180-1-jeffinphilip14@gmail.com>
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
Fixes: 7ea95b110811 ("usb: gadget: uvc: rename functions to avoid conflicts with host uvc")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changelog:
 -Small fixes addressed in v4 discussion
  https://lore.kernel.org/all/20260730093948.7800-1-jeffinphilip14@gmail.com/T/#u

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

