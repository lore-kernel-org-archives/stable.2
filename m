Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B676B371876
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 23:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565445; cv=none; b=dWQB2hlwFJEQ2V2xPHtMufXBWtUE6cR4Ai0vMYzqffAxvZLr02Gk7uCMiprIzCd9ccspotvMDy0EsRig9Dg+yl71Tt8HbNwkmKfeWiy8ysjzaehSzOq6daErpoxio1fywVJxg+LctdWiZOIH+pLGLWrwE8v6bMUkIk1jR7+2/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565445; c=relaxed/simple;
	bh=6j7QtbafL0GjId7kZIPTH6hRjGmJBCaIWXYGOyGCfIM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=seVItqItHlM3UDwCDSB66Hcu/QsmoRFzLAs1QIxQ0RUoAwYfay8AWiLvUtwpE0oS1DqIEq0hO584zElLQvycBkwc8RFrp8vKCuLY4ais1tB0T6vhr841llJkp7D+aMhwIB//aPl3JeolNgNhnWaaX15hSKWtcDf/WPhWyFwQf84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=A/BLVheY; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthies.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A/BLVheY"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc1d85c012dso2483197a12.2
        for <stable@vger.kernel.org>; Fri, 04 Sep 2026 16:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788565444; x=1789170244; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=43MbP1qjgGN4vZdi/2GkDDZJfA5MhGqHcArs08teQ7w=;
        b=A/BLVheYo8MtMcD/W7YdnE6CUvW3KfqkaZ5WaVV4L1xt+h1g5cBjK39A+ZlEqgc9zJ
         KFUOdT9QFVdA0yogtzLCyfym1/VHZC0RxNLI9DJ5NDZHymmcIlkg+of8nnwk3KB7zwn4
         +Ma8DLQwLsw2qYeAMKyXtbBOlGK8Z7HFb9egxwLtzfnGiFt0luc1Sx2Y594X9jkDiMHH
         xuHQhCK8Sh3g4Otp5sEYN3456rBmnr4pfdTjdg0PNY3hw4visMbyalF81Hh5gaqbWRDL
         N4WzE972n4gB7DzBTV+G34Vf13/5G8C63WL9UbtELnuKtOlmmzjkARi9uVexyV2w/bK1
         B41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788565444; x=1789170244;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43MbP1qjgGN4vZdi/2GkDDZJfA5MhGqHcArs08teQ7w=;
        b=SH+HA/PVdP1boVQpIsHzte1pPA2m4GB6bVsfAmDZODVPD0JiAc3i+r2hip6DeC4Tgv
         hSo5RG98eB/UH3ImWpoQHVWVk9o1QpflT2igxo5Vz1F33UWS2QDIEHwV8AroIW/lzh/w
         VqTDg24NNITETfk9DRpkc1lgHtI/6Dw+YTJk0doV4/1pI0n/7mwKn1XyhdMdaM8PYdnN
         PA1QCfh/WToweBcrkMU6UeW/u+2DpHLmmp75cJs8/zhVF77OJTB32vDzWeFEJc0csEXk
         U6s2lTR27FwL3dR+aSDI3uPnysEbLqC8sXTJF92ATvOp5u0mJ0CtrovFih4rDbTppjhr
         6LiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzqNeqDZg+wM+3Op+3p2Y1yoHQrcAiFDFCM3FOKJPUqPxOTSMdzMyJxzqGOi+6bmde55yVV6jY=@vger.kernel.org
X-Gm-Message-State: AFuF++m/LSBRAy1Z74YizKJdySjveS5NO9atu7afu8IBcUMlY4hEBWzc
	pI+az2XtjV0xSFQZCL+3sHIorQkONGehKUF+bOWLzrvwLHaXjLsX0rOEGd9fJFaQwGI7t4Z+tGK
	a3eGNMg==
X-Received: from dycag16.prod.google.com ([2002:a05:7300:fa10:b0:328:430e:e346])
 (user=jthies job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:a06:b0:3d3:aec2:4dcc
 with SMTP id adf61e73a8af0-3da3a0fd0f3mr15160633637.24.1788565443779; Fri, 04
 Sep 2026 16:44:03 -0700 (PDT)
Date: Fri,  4 Sep 2026 23:44:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
Message-ID: <20260904234401.2339633-1-jthies@google.com>
Subject: [PATCH v2] usb: typec: ucsi: displayport: Fix OOB altmode array index
From: Jameson Thies <jthies@google.com>
To: heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: bleung@chromium.org, gregkh@linuxfoundation.org, akuchynski@chromium.org, 
	Jameson Thies <jthies@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The UCSI displayport driver indexes the connector's port altmode array
with the GET_CURRENT_CAM response after checking it is not 0xff. The
port altmode array is UCSI_MAX_ALTMODES elements long. If the PPM
returns an invalid GET_CURRENT_CAM response above UCSI_MAX_ALTMODES and
not equal to 0xff, the kernel may crash with an array index OOB error.

Update the UCSI displayport driver to verify the current cam is less
than UCSI_MAX_ALTMODES before accessing the port altmode array.

Fixes: af8622f6a585 ("usb: typec: ucsi: Support for DisplayPort alt mode")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
---
Changes in v2:
 - removed 0xff alt mode assignement when GET_CURRENT_CAM returns an error.
 - return -EINVAL when alt mode index above UCSI_MAX_ALTMODES is returned.

 drivers/usb/typec/ucsi/displayport.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/ucsi/displayport.c b/drivers/usb/typec/ucsi/displayport.c
index 7067f2561b84..572da7bbd29c 100644
--- a/drivers/usb/typec/ucsi/displayport.c
+++ b/drivers/usb/typec/ucsi/displayport.c
@@ -71,11 +71,14 @@ static int ucsi_displayport_enter(struct typec_altmode *alt, u32 *vdo)
 	if (ret < 0) {
 		if (ucsi->version > 0x0100)
 			goto err_unlock;
-		cur = 0xff;
 	}
 
 	if (cur != 0xff) {
-		ret = dp->con->port_altmode[cur] == alt ? 0 : -EBUSY;
+		if (cur < UCSI_MAX_ALTMODES)
+			ret = dp->con->port_altmode[cur] == alt ? 0 : -EBUSY;
+		else
+			ret = -EINVAL;
+
 		goto err_unlock;
 	}
 

base-commit: cee9395acd8043be0644b25c34bfa86623f2b935
-- 
2.55.0.979.g7e5102b832-goog

