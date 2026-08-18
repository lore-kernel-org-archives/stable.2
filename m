Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB843B6CB
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787043450; cv=none; b=g8CaGB5BRMVLFuRvz/0FYq9UB0ZEWIqbhiWIAWyMyOsZQm5FVltfVXtldifHX5P7SZPqQ2TxhQNMgSgmk/zRqbU9o+Z0SH4LJS9fr4SgxB2hBL5A0d36JSghxeAcXuImNILaYgsyDkB4kMPjDnoeVYfV5FCudaNL9PvNJGP1rhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787043450; c=relaxed/simple;
	bh=kE3IGiRBfT+OP9aoR2Sy7p8mz+Jai9RJi1voXK4dbu8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oW4vQGV4fMv704yvf+bL8o/swf69GVCkVc4XPKN+lkuB/yCqrqYF/AWgDxdOrIAm7hRjCUmhCQYT9Gu9SN5iDbqpU4Tbj6qOXrahrwUEybsk9TbYiw9S8yKvVjPte7PEjeHr0WmKZUFi32S8DAmmKsQqVWZg6So2dt+9EuQwtVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY5niDhe; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY5niDhe"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4980dc26022so44194145e9.1
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787043447; x=1787648247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eu5Qnu4amjO34gGljjkfb/hRSwAhGsO9O9HKCuZFn60=;
        b=DY5niDheQOP4kUeXhCXcU9tlmagYBKLN45uT41dHJZ5KNDG2lFprRd2bPD+WC1jtN1
         zmWK0AlK+AYAXHROg3mSuoUmlaJtLOf7EUaloOtI2Rvv0g+ejrfLQ9jHXy+WtxQvDdl7
         daywLerXs4jxKYIj7ex668qTo+3ygdMJH3kpNQ4Cle3DC6KQ1mEsP4ypVV5k/lHddrDX
         vltp3AmXTix3eCX8UCYs4XQV4FlzLC17E1xZ2cI0hql9tQsKIY6SUFHFpOzRj7XJBaNR
         MLPQWt9PM/rJ3iAJ5ZOo6GOBwXR/x0fgSPfoP2nuLY952h9MhggMrDFrc3z+qxJagIuW
         0JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787043447; x=1787648247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eu5Qnu4amjO34gGljjkfb/hRSwAhGsO9O9HKCuZFn60=;
        b=MdOPRJJU/jvGkQXyqEyi7xBYg7dqG8Ns+xbm0NMdHtvL/NvT42ol7cXk3ALoFWT3vM
         paMLI8+js86COGYTe4vszd0SlWgP7o9wGWXln4kTY8IkaCVAyHJvM2mFtPxn+SYwIHQX
         U2uOSSO4VWzSR/MWQ+xi5wKS/8aeTn2mpcU4tvLc08kv4F2ywSNMAVLCRoreWnkBVr3c
         K7WpoKeEe2Q2wvvqUJPDO3Lub6Grr8fmae38MQPoiH2ZbdOgxRO4ZCKoQPzul06BUhQ+
         v7hIMstwU3QozsSwVHhFPlNleLiC1ww8vIxTgQ7jBKMO9Zj0f3e9d0I4gBtfxiykAK2q
         mw5g==
X-Forwarded-Encrypted: i=1; AHgh+RpjVjWrKmejElOIrYjLrieYkodEz2empP63ZDM2PYQOuEhi2Px1TP/yMYvp0D8+Q9scjDQiZec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydn8xHEgDS9R27SuwAxczf4l1jxQo3+PWuYYz0aAFV29dTB4dl
	dAnUw4JtjyHR/JipFruSI/9x77LJtFKps8JTBMXoYLvAgkCXpimz5CqZ
X-Gm-Gg: AR+sD12Tx9EbXj9bOtqkmSwbj0TsbWVxwvnmMKbsaoKLd0MQG8pVNbSkBLMZQ0MTgcd
	Zhm4BO1FlzTEtUO+kDiIvqtwWhgt2Gyhek77Vc/rN98G3xG9OGDb6BNQHajUmTB0Nq2mX/EBcu+
	WfYfECNkhtEUn6e2UtL18ma0AYCfWs1iMjGEXCsnInMKq9VDRwXN1dd8DWPw7HN8T1OgyFd8P6E
	uEtLFyDdq93vnYdMCcLxMysDT8s4CiLA/sJ8tUNMcYaEZUzoZZJKRsv7jqAAClgnS8DV8VFgmgn
	E2JRF992xP5Slar5fsaEsiHJAwpXmSxevh1c7U1cOK7sRrDITumyUBRj1TqFlIDEsRFcyxO1scy
	dbQHd6A4JykSxyCMf/2ek78t518mC5wemudXKshNL02teZJalWEsd0T2te+MwzS8Enm9/eJdloz
	om29iEVFCdOjP5eTe1OZjteP6B3kdZkjj67nUFks0SB0kJzimLMRPezJHW6b61xtQlvVrfHnJFs
	9fV+SSom+IGzvy+uN2FYDjZs9dD+UkOJgE=
X-Received: by 2002:a05:600c:19ca:b0:499:7ce1:d8a2 with SMTP id 5b1f17b1804b1-499879426e9mr406445745e9.8.1787043446852;
        Tue, 18 Aug 2026 01:57:26 -0700 (PDT)
Received: from HomeOffice (046125138157.public.t-mobile.at. [46.125.138.157])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4999d10ba73sm119747925e9.13.2026.08.18.01.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 01:57:26 -0700 (PDT)
From: Panz Dev <panz.development@gmail.com>
To: Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>
Cc: Denis Benato <denis.benato@linux.dev>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Panz Dev <panz.development@gmail.com>
Subject: [PATCH] HID: asus: fix touchpad multitouch initialization regression
Date: Tue, 18 Aug 2026 10:56:23 +0200
Message-ID: <20260818085623.18467-1-panz.development@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In Linux 7.1, commit 7253091766de ("HID: asus: do not abort probe when not necessary")
and commit 0919db9f3583 ("HID: asus: always fully initialize devices")
introduced regressions in the probe sequence for ASUS I2C/HID touchpads
(such as on the ASUS E200HA):

1. asus_start_multitouch() was placed inside the claimed input check block:
     if (drvdata->input && (hdev->claimed & HID_CLAIMED_INPUT))
   On ASUS touchpads, (hdev->claimed & HID_CLAIMED_INPUT) evaluates to
   false during asus_probe(), skipping asus_start_multitouch().

2. The asus_report_id_init loop in asus_probe() was executed unconditionally
   for all devices, which sends keyboard initialization feature requests
   (asus_kbd_init) to touchpad endpoints, corrupting touchpad probe state.

This patch fixes both issues by:
- Skipping keyboard report initialization for touchpad devices (!drvdata->tp).
- Moving asus_start_multitouch() outside the claimed input check block so
  multitouch initialization is always executed for touchpads.

Tested on ASUS E200HA (where touchpad functionality is fully restored)
and ASUS VivoBook Flip 14 TP401MA (confirming zero regressions).

Fixes: 7253091766de ("HID: asus: do not abort probe when not necessary")
Fixes: 0919db9f3583 ("HID: asus: always fully initialize devices")
Cc: stable@vger.kernel.org
Signed-off-by: Panz Dev <panz.development@gmail.com>
---
 drivers/hid/hid-asus.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..7f19ca1e5a1b 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -1294,12 +1294,14 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}

-	for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
-		if (asus_has_report_id(hdev, asus_report_id_init[r])) {
-			ret = asus_kbd_init(hdev, asus_report_id_init[r]);
-			if (ret < 0)
-				hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
-					 asus_report_id_init[r], ret);
+	if (!drvdata->tp) {
+		for (int r = 0; r < ARRAY_SIZE(asus_report_id_init); r++) {
+			if (asus_has_report_id(hdev, asus_report_id_init[r])) {
+				ret = asus_kbd_init(hdev, asus_report_id_init[r]);
+				if (ret < 0)
+					hid_warn(hdev, "Failed to initialize 0x%x: %d.\n",
+						 asus_report_id_init[r], ret);
+			}
 		}
 	}

@@ -1327,12 +1329,12 @@ static int asus_probe(struct hid_device *hdev, const struct hid_device_id *id)
 			drvdata->input->name = "Asus TouchPad";
 		else
 			drvdata->input->name = "Asus Keyboard";
+	}

-		if (drvdata->tp) {
-			ret = asus_start_multitouch(hdev);
-			if (ret)
-				goto err_stop_hw;
-		}
+	if (drvdata->tp) {
+		ret = asus_start_multitouch(hdev);
+		if (ret)
+			goto err_stop_hw;
 	}

 	return 0;
-- 
2.47.0
