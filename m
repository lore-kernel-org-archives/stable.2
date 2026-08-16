Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2053304BB3
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 06:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786861050; cv=none; b=B18UR6CUA05Vh8Wq4WA5/alClLtT1X1wfkkHdA6wpXgixe88ih1NXNj/FEEKAhfoo9ylO2Z8oYQxri5iSvKq4MZZBr4VMKpMaH276pudebJtvbKxnKxsgkCM3yS+IcIfjxau2zttUZkbqc8Brtzq8ylCQcqQlz1NrT17FGtQoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786861050; c=relaxed/simple;
	bh=9rkh+l6xraLTWwL32qe6TKz2/frEdnGi3YOr9WdAETs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FU3zWSq2crLKbt8yXIVa/UsWRYaOwOYa9XtmJCAxm/8c1pdZpB4iYd5AipEK5xCVSCFh3kKP95exWL68RbDE3Z9hSThgaIF79Hk+SYKqIO0KWBvPWwfuer60prE+lf2oIaHrMJOUzm9VDwv2a017npkABlJatwPx+8+D0ruA9JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEE9Swyi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEE9Swyi"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dfe7eb825so1789645a91.0
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 23:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786861049; x=1787465849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/lt0MYPB2A8n9D+NrNfP6TZGyktOpHcmig9SIzvH9ZY=;
        b=DEE9SwyicVMYdnUaIW1jzVnbllX3Na5ABZ7ZwM7WadjOJrd+aW9UXvmeJUJoAl7/Cc
         yyOEMM1iCuhZR0Uh5uyZ5PzYcMX93bLZg2qaiH9WMl+8aAcTuO0JwfQu+/v3W0e/gEn4
         2/CvOFqUr1kg7XspSrdWLLLp5k9ItSi0pzUDx75Hh6r3OYbrnqBG/KjwHSa8lhzaCCpY
         Z3lmuGWm0TgqLF7T/tnVNi3ATuS4aOA1x+58FgVlpbwT6GJ4S4cNo6FlR6jlEKogQnoO
         rGj9Z/hZlhYYxt0IfJJ7ec4v6bKLkw/40RfO23gYCc3pR1e2Fsudjk55tlB3aKEXGyMW
         Si9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786861049; x=1787465849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/lt0MYPB2A8n9D+NrNfP6TZGyktOpHcmig9SIzvH9ZY=;
        b=SH9f+AYoRjuR0O6ziCN5P0q1QTBJD5tFa/KJ3XGzOrVboimKAfOV6ThmcPXgWikNf9
         0XmeeeF7ixAUxmSQUYxTvsEZfo6YWb9xr/2bA3M3zlqxGYuU1mos7Nd/D9/Y20CXfMrh
         hRNSVyv4YyFseL1DBfPAHW/8u7EnUDKvLdZ1RlAPvQmFq4hHRN4tqgIW+zEfB3PVTzU3
         4fCQzSOI7b1t+KRFYAOdJgiHsKqz/s5VSPxLffeNXQg6KiUJF2MfFVCSUaO92HeEBAxQ
         Y/rs4awxyjpbf5EJbBYpHQZK4Cl7tI0tup9zya3scTgpAQQ8aB/yoikJyXrGtCZRihsH
         4FtA==
X-Forwarded-Encrypted: i=1; AHgh+RqyKEbg/dASEXi0E8EbVHItU7risv9ytWrnG7UPGDIIsXf+d7arwWOY30oyx2qUyYlZ84yIbgg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr+uPvED3xAgOIydu7zoHgqlAzwJLZlq1G48nt8D9nXasQ8F5d
	2+WJ0cfSKaWjl6tOchkENOrcHDOiwbgzQbpwFAY+anSxaI7YsNBUn0GW
X-Gm-Gg: AR+sD11aTUT1srmljuWLyqU/KBAgoZ1ydBJBS++hhWbeidyFaZa9uUVm0R8CEMWf+f8
	a7Arc2QrPbTY4kQFloeejwjhauj53utbCuimQmXYfnnuAatH/b8Gx+ocegaxSUPbyyEZQuJSc8e
	uARV5K/Xbb3pPImdfzEstQT1wUdJT+8XyO+R+3B5cNkLtWCbga7cpangN7teUpffFZr+3rSnQRZ
	jNMsAhmIuN1VFN8EMx3c8Sdgs2nCVw/3IHrv22jdQ0nIMj2Em9J8EGXDJQ07DU9kCVumUVCLxN/
	ljbFzKyFkS1cIOas/GwamyhVWo9qK9ZrxG0kYCTaW4zZn7HKn0kOdVtg09+DPH3yEvvGguq+7Jc
	cK/9cYFvAQHpHKnQpYWXCS0x5iDoNh2XIIJsUUWmCjjvONqH+pajwnn4+6Az2pv4cwGZpWYo6y9
	5GIevmmaeR+Kbp3RPanE+M6Pl3HRQKUL2ezvSa3QWnj6TtcSeBoQanFFxS+0qLpNi2qw==
X-Received: by 2002:a17:90b:3c91:b0:380:f85c:94b4 with SMTP id 98e67ed59e1d1-3933b78e3c2mr19285769a91.7.1786861048973;
        Sat, 15 Aug 2026 23:17:28 -0700 (PDT)
Received: from Default ([2409:40f4:1032:c11e:2df8:ef26:4db8:5cbd])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141387e49d3sm27378993c88.7.2026.08.15.23.17.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 23:17:28 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: gregkh@linuxfoundation.org
Cc: jeffinphilip14@gmail.com,
	balbi@ti.com,
	bigeasy@linutronix.de,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+fd6ef980cf1c722be639@syzkaller.appspotmail.com
Subject: [PATCH] usb: gadget: fix null pointer dereference in usb_put_function_instance()
Date: Sun, 16 Aug 2026 11:47:12 +0530
Message-ID: <20260816061712.15547-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

usb_put_function_instance() attempts to dereference fd inside fi struct
to get mod in uvc_alloc_inst() error path. However, fd is not allocated
until later in try_get_usb_function_instance() after allocating fi in
uvc_alloc_inst() and thus guranteed to be null in error path. Fix this
by adding a null check for fi->fd that returns if fd is null.

Reported-by: syzbot+fd6ef980cf1c722be639@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd6ef980cf1c722be639
Fixes: 0062f6e56f70 ("usb: gadget: add a forward pointer from usb_function to its "instance"")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/usb/gadget/functions.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/functions.c b/drivers/usb/gadget/functions.c
index 203361a64212..70e31c40e267 100644
--- a/drivers/usb/gadget/functions.c
+++ b/drivers/usb/gadget/functions.c
@@ -70,7 +70,7 @@ void usb_put_function_instance(struct usb_function_instance *fi)
 {
 	struct module *mod;
 
-	if (!fi)
+	if (!fi || !fi->fd)
 		return;
 
 	mod = fi->fd->mod;
-- 
2.55.0

