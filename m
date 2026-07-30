Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDE2B9B7
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 07:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785394962; cv=none; b=m0An8chp9nQXaVUsf3UFmrBs1bBvmHAyWcQ0852mjU+QIPztflMoj6C2lIoEkOt6n9+xQIRJbtYw3++Npl0ovMA4vTjiLQeD3qBMJM/lK7yXYy6dIbRRbFkPUUFXJa7WFA26iSLJwEWjlWRNcD8ZdX8PsZstCdwIsFVm5GYILvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785394962; c=relaxed/simple;
	bh=wJU3jDsZvwe6A/nHebd71vYMuOQRCT1kM2KdZRJa4hY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ePjwcW3ppr8Ao3KZY0rUo2mkfXwIrIi8kgF+tK+MApi6liJYRqOLD/uHrzW45Y20fbbUcvnpPvmrx34NpzqBChkKXNTPg8Igp1D+VFx9zSzj6U0LixoUhQb9soEHVu7jKo0xlEprjxnZX9GXoZ9vjifoFMHu3L/hEEXS0ClTuzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GrZPQHTr; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GrZPQHTr"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1878012a91.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785394950; x=1785999750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h+MtJnOvs8AYg7ENm20sNfdBwSbBhTZCGHZJyclXCfA=;
        b=GrZPQHTrRkdsH8IfNBqfrr9HqPq/1MHM+nBjQdGCYPfaLf2nf5rcV2LJ+UiWb3armt
         EWRn51TMpyIZCa2/v880R2CdQDa6si4La9UG6SuLrlvJ3tpG9B9Ih5k8clf8jAyCyaS3
         K+xt0f5mXeK0ls6C3JFo9bPN1s+oQA2LcB+Tr8XdblSDlZ8tp/YkHm9tWBV1K8ES7e4Q
         /vcZVZXlIVnJHrHvUsy86mkt2iM0rufpyQH6X5riTN8pm6zubZ2M+bMmefs6xAzZjb6A
         DjRhaS7t6EJUopjXe99M+ZL9gpIt+ahyq735yUwDFo9pU58Lti+4Cd5iiPSehJsOxYWt
         LTHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394950; x=1785999750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h+MtJnOvs8AYg7ENm20sNfdBwSbBhTZCGHZJyclXCfA=;
        b=WyxGTJ0YKuIPf75pZ00XS1wphcl5wrP2rqkd5VnUQaOcyDdvx+jACq7cKloWUpNmYD
         B/9p0iRXuEImB+eNCoQSjvSwvnyw/XNF94xTFjMFBnS1ODYRiyIpxnoyfyQyvKjxyb0Y
         FmIIy807aOfzrNP84ihOM4hl0NEKB9qANwI3dnPdezYqmWS1zjI4Wqfb77iVMh6jFUhJ
         eyrd0kiUA7QAKT0KBgyVVtfzreljthyxFQttKAasIpjcZ/EsZYn4JcQpGhEqrFNvCb5R
         KOD02asuZn+B+gRLXUyy3kehcYIeFqi1DihTPvqPM3OP4jWQh71mwzKqZmRuWpQkB5zl
         /Bug==
X-Forwarded-Encrypted: i=1; AHgh+RoFSxI+hPpnNKgJjMdP3GnEMoHdQAoUhWMsB07/8+h3w93cuDsLi5SEsvvDaqDanAcl7sozNCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgt0RG70C16SjcHYb4F4VTbuvs2OjFtwmMFbJUsbQ498po5B3Z
	sNQHzL8uPhkWXD4Xbis1DDkUAIzm91dfDxMV3OVkSElbZDTvvJcTMhfE
X-Gm-Gg: AR+sD12afECNrnwreCAHW7DHAMffVUSgDMX5w3ezdnls89OvvLIEde8xnzA8bZVc0Cn
	Lh9WXvwe5VjmHtxH2DX1ctGCH/XZPQx61MDULP518lsxQyiCeDwqyWgOODsw7S6RPsMLcIl3lgV
	vfT0paWdC+nFflxQBInNYXcx/y2S/iK/6Q4JCq1Tssn2jl2t8i1G/13lmT3JP0EJw9Z9Tz2sSdw
	qmNa+MBsueEqWEjZgFPCSarHDe+YMqu895D5GoFsnMVn+zHRqIXNV6YqBx5aiuGmuU4XDUr5NdD
	hy2DOegfP8VAkVxdTWcy9+SKeTtBzNTw051QuzvdUU8AgafXApHl/4RWfku6gCQQY+Nrcdii1YK
	ZgWkNzpfvzWsjJ9M2dOwjTwUVAOD2tbxblSmQy+T7edPaR3IOAxAm22e6DNHAhV77S+r7w3x/bo
	Johu7WUBP2+TeAKTYQgB3UJHW7iyY5BK3hc+q6bF5TjSUYY/ei38IhxwIWV7dAmvyuYA==
X-Received: by 2002:a17:90b:2583:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-38f9bd83fa1mr1421020a91.10.1785394949977;
        Thu, 30 Jul 2026 00:02:29 -0700 (PDT)
Received: from Default ([2409:40f4:1008:1710:a945:87ad:2d3e:163d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504dd42a9sm21046149eec.30.2026.07.30.00.02.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:02:29 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: xu.yang_2@nxp.com,
	Frank.Li@nxp.com,
	panjunzhong@linux.spacemit.com,
	kees@kernel.org,
	jeffinphilip14@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+8dcac923582c28505fd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: uvc: Fix Null Pointer Dereference in uvcg_video_init()
Date: Thu, 30 Jul 2026 12:32:07 +0530
Message-ID: <20260730070207.16065-1-jeffinphilip14@gmail.com>
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
Fixes: 7ea95b110811fa8e41f5960c278bcfc80b8b21c1 (usb: gadget: uvc: rename functions to avoid conflicts with host uvc)
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
Changelog:
 - Implemented fixes suggested in v1 discussion
   https://lore.kernel.org/all/20260730055705.13784-1-jeffinphilip14@gmail.com/T/#u
 
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

