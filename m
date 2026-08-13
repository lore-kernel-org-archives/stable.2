Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BADE3BB11A
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 17:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786643015; cv=none; b=JF+urWLHHKWurfFOtNYLIXDqGJj5qF0EBW0TZsTy8CyejcrYqRst5MN/7HalfJ5gJDhMriQ16TmXKSr+DLT2vQxiNaH8Rl4xRr2btUuweEVqFLD11wKL64xoCGWZ0aV/sNGJb4xmA1Me7nqVJDDjqvmdp557VvDd5m3SrVTQj3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786643015; c=relaxed/simple;
	bh=3Bp/wiO74y4rVmIS1HLOq7vys5FAwtoPCVF8zj3hR3w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rF8r+IRW2yi+E8FNeMJiI9Ad8RZEC8pn5t8nmJLMcTfD0oh0im71wGywIqmgx9Mp4uS+z5AOL/xKW3oryusIc5uM1w1XZb50PYqyYXQfgNpcpSB+CAEWMTfrGoTzxf4A+wXKOELpal+KcNaVy13Kkb5IoV5kqfS3GRjBPljaHhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=stG9zfJd; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="stG9zfJd"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so70121a12.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786643014; x=1787247814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Weuf4GkCz4gjV3iqv4P06kigpBGcY4+7kCy4Zc1Nko=;
        b=stG9zfJdXqe2iNfAcjjpX5KPtTo5tR3aNvAw6/nAjDBiE9ajflF2gGdHFhYKrkya5g
         9i/4Gk5+ZNWzEUHLsgc7O67H9N1PQTA1L6GP+0J18rVgudF7vSeJMak7JCHSi9Y1H/O6
         zctD2NIpC+lwSm86fOg8fKNuoNfaMe1PtSK8wouXSPJgKfl94Mjki8bjM1Aqotj2ZECC
         5b0J2KRiZamYL/W9LU/vgWMRnuwfd6PAejD24a5KCbVMP1y7RrlIR1K7nmmMynF4fXmP
         OwtnChSbPzyGXUtOCjaNVwdIBNTXSfmyDVQqV6eihNa2teOMiTYi8YtfNtuHz6zCylGa
         1i3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786643014; x=1787247814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Weuf4GkCz4gjV3iqv4P06kigpBGcY4+7kCy4Zc1Nko=;
        b=RFZ5uU+VuoX3RWBokkV/hLE5O/rLG3fowp3vNhWHFR1nN/XuBn1en1yXPLXinMOY9i
         Hcccl6KKNgY+MA0V1hZio2dv80BVrOJg/UtDKKrmtFOmt5zuhs5mf1wNRdIP3WTKbN8O
         XZZNL4mFn0XjycuIp4i/ANf4rqDUxFISR6hidEy10AxPudGdnkkN84R/dFMrmOTV6luZ
         uQL06tebN5/xf/jwn8y6iKWMm5RY6P1f5aS8GjAD3FH+GJJuXs0yvP+LDXfjG1wDsm4b
         TmemesOXAJ3kfWNp7BzaGy5XYkzQx+A1AuGcGsGMK46x95iq/Q8JFQde2ABk1S5w4MFh
         b2aw==
X-Forwarded-Encrypted: i=1; AHgh+RpFPzJuUUU5VmiqQOfWjJT3+nKruPLgghkf04SlE0wX70F+ZDBQD/A7k9LDjrp1PFEsGmySZ3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBnX2VatrmQ6sTiujM1+CUPlR7FAVlYm2SNapSAJ9PNRW2betD
	OtcmBoI+9MUqkUYK5Fer4QMH2wA1v8P5mvXOYboAXJ42q3ZkWmkVGJWh
X-Gm-Gg: AR+sD12GVINI/HaCzZFSt9k0kNOXdRcQj7xLSRo14dZZdrnpw7tw7zCM5vaLy0ZLzHZ
	EXA/Ejk5x76lzJAQbl9xUXDxTdAArv21Bhs6nXE65ED/Jl5tKZR/CBqB1FgmoZMeu0B9ftmFfV7
	UO71FKIW4MGkXq+FI6pdwXwcPa6B0LNJVyY4p0YY6grM2NkR7574TvKSLJ6htuInPw9ZFRElHvz
	mqMboRSrLDjTeAqHFWw9CLrShAdyluO1sB9NqTrMgG+OGXZjJ/2LzVaXtNsJcHt1HCsDpV8Rxy7
	FRj6ZRsKl654sP7MPD3J3maqEfkmhca7EYWjzLt1G9Y+oDikultcLvoA9bKsqY1623wJk9jxRaz
	B7Q5J++PLa4kBIlaQiqtHYhzfV8IvFehKb39rGCEafsg7FoDKwfHvryH3aa7NODZHATEBKhKFt0
	u1RtUPuuxpDEyFbiEeRNt9qqL2UVk3pXyqUpiF0vKEOtgt3TG3G7GPVY3CM263OW26
X-Received: by 2002:a05:6a21:60c4:b0:3bf:b8d8:8296 with SMTP id adf61e73a8af0-3cc55488526mr10345897637.26.1786643013438;
        Thu, 13 Aug 2026 10:43:33 -0700 (PDT)
Received: from Default ([2409:40f4:1003:e90b:67c1:9c95:4ba9:3e5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebf732526sm8723722eec.19.2026.08.13.10.43.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:43:32 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	xu.yang_2@nxp.com,
	Frank.Li@nxp.com,
	kees@kernel.org,
	hhhuuu@google.com,
	jeffinphilip14@gmail.com,
	kai.aizen.dev@gmail.com,
	balbi@ti.com,
	bigeasy@linutronix.de,
	andrzej.p@samsung.com,
	laurent.pinchart@ideasonboard.com,
	syzbot+de553c19cb054f174a35@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: uvc: fix dangling pointers in uvc_function_bind() and uvc_function_unbind()
Date: Thu, 13 Aug 2026 23:13:11 +0530
Message-ID: <20260813174311.130823-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uvc_function_bind() error path, we use usb_ep_free_request which
uses uvc->control_req but does not set it to NULL afterwards. Thus,
uvc->control_req is a dangling pointer causing a UAF. Also we do not set
the uvc->control_buf pointer to NULL after freeing it, which is another
dangling pointer. Fix it by setting uvc->control_req to NULL after we run
usb_ep_free_request() and uvc->control_buf to NULL after kfree. Do the
same for uvc_function_unbind().

Reported-by: syzbot+de553c19cb054f174a35@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de553c19cb054f174a35
Fixes: 0f9df9393855 ("usb: gadget: uvc: fix error path in uvc_function_bind()")
Fixes: 6d11ed76c45d ("usb: gadget: f_uvc: convert f_uvc to new function interface")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/usb/gadget/function/f_uvc.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
index 73dc7e42875f..d1bf3ea75197 100644
--- a/drivers/usb/gadget/function/f_uvc.c
+++ b/drivers/usb/gadget/function/f_uvc.c
@@ -889,9 +889,12 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
 v4l2_error:
 	v4l2_device_unregister(&uvc->v4l2_dev);
 error:
-	if (uvc->control_req)
+	if (uvc->control_req) {
 		usb_ep_free_request(cdev->gadget->ep0, uvc->control_req);
+		uvc->control_req = NULL;
+	}
 	kfree(uvc->control_buf);
+	uvc->control_buf = NULL;
 
 	usb_free_all_descriptors(f);
 	return ret;
@@ -1075,7 +1078,9 @@ static void uvc_function_unbind(struct usb_configuration *c,
 	uvc->vdev_release_done = NULL;
 
 	usb_ep_free_request(cdev->gadget->ep0, uvc->control_req);
+	uvc->control_req = NULL;
 	kfree(uvc->control_buf);
+	uvc->control_buf = NULL;
 
 	usb_free_all_descriptors(f);
 }
-- 
2.55.0

