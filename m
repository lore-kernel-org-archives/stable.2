Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3D5313E2C
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791942255; cv=none; b=ZwLx99r2Qsp1UQtMqfMQ+UAoZOWVAIoANRS/5slcLPiM1aPzQtoOm6dnu8BQ3TMTRMRdIPGQUL7sKZeugG3VM8bYdkTCDNxIN3ULRITvliwbPaQgjs6X1APhlCq6ypDVCTiZCEKKCi08iHGXcfOwPNQmmfAqDbzSlb1bRWZ9CB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791942255; c=relaxed/simple;
	bh=pZLuHo5ZWjv39EmAfep7f0DI3I6NdzNmEzWVgKx/rls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pt/G4dANXMIs7p88391GmZ57dcH4WK1+gaUw1iYCGuC19Iampurno++Iv0MkRKLfl54g8tHCWQr0H/wMFEHE++4syiuxIli5IuCbJOUyS0SJn7qesCK+6vrHguE7hodsLcEBdH81aykCCymtub4g4hIwlUzuBZEURhCID1X0RPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net; spf=pass smtp.mailfrom=voidship.net; dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b=qkRM41ms; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=voidship.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=voidship.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=voidship-net.20251104.gappssmtp.com header.i=@voidship-net.20251104.gappssmtp.com header.b="qkRM41ms"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-53391022dc0so41493091cf.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=voidship-net.20251104.gappssmtp.com; s=20251104; t=1791942252; x=1792547052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Dlj6aFpIYGfY0eqR7kOi/l3Gq5Y654XQkcpULmP78WM=;
        b=qkRM41msFbZxLdCCQXtPBrNJXZlirtPFWl+68p+vcX4rPpYR60J3jGXOYO3gt2awAk
         vGwDQek6LAhnthSebka1pgXWfFkR7yqaFvu/VuWe1AOlVs4GKaa9teaEX4pJAZ22lPsd
         xfv1tdGwUZp2CbMLXnsIHvcBhUzRSQld1LxVHDtQtyaat8+Tt58vgpdGHlOfDnfB16Ei
         GfjYfhjhFHiuknz9dNcUx+KH+G0F+XXzQPkzVQaEtf5N2QQZAln71owJ/GgTNgFbe6OP
         5RenyIQOFhdeZwBtv0EJbrogu8HtdgbVR9P2lHunBEYpoG4Q7ingji9NU3YD6Ol7DXG3
         b4ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791942252; x=1792547052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Dlj6aFpIYGfY0eqR7kOi/l3Gq5Y654XQkcpULmP78WM=;
        b=dpSkkcQDYfJ5ggUzJDxzyS7XB40tXJeKFUHNHuWRaYGiix5FwK8PVqlXPKPtXyYezR
         LNbsERygkzbeUuFpevLtX3+kZY+3KrhGAcW40i2WHne23ffmPx7ddJAuBGnhz4vjYTsi
         32Jx7ZCkYpLEeXLrkBMUmsXUjJulgvbdnf7+BhT8pSwW+OZqRaVUkcq7IA+18B6t7h6w
         N+vsSh7SZMEVTEnUyrJiVZfPCLATj897UYPLj5ngKXwVDhUsENdLNddDCV7PULcElZM2
         qIgaRyiXh62hVs7pecH2N2rmClzEWmJuKNN4CsWbDSGonlGf+P/Y19/yCRYNMGLzvXVi
         rzNw==
X-Forwarded-Encrypted: i=1; AKwUvBzoZTqw9YzTrAR7QMV86WNURgmpj1BEJ+PVrKiJ/tODGPjyyVS7n1B1S/LuAQfCmJl/V354wXA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLzp0hKcshpySvrHTIXGAxA8X06RsFAXkGtbPo5m72eKMmYQc0X
	bFucOZzUkLlMGuX9ywusfVR0P3/0AQmeJKDbjmnMwjuMzF2cfUCLDYCIyNyKaBZQhzI=
X-Gm-Gg: AYBFou2HV2qTvz9mAMmALxL4iOZob1zI6VDCpiqaON9zQ0xrICifwhbZmy63BB0kRJ+
	y4iYvBhj8MhUH+jxRJkPnxTYEOyKYIGSlyqs8s4dJR9R/myUq6Ug7E22U3At2lvCXLwdk1RZPcT
	5A3+hOdx+gfPCyerP86qw+lP7c0rlgEiwXKoM7k9tw3A6x4kht9X5uAXlRtM1XMZ7ZIO09641+L
	YRg1zUnp+qPwBlo2X6wuTHNfKl2ytoWX7nnLl6xc/Qd0yRtQL8TsAC6nNRq+U/S5LTmqOtF9WMl
	69apfrWLi5JkINw0dhkGs7ODTWezrYuRhp65IcwTPHOipwtR6fQsxGSZ05tr00U+MTeYryU6Hpa
	UYUw3qPPoPhbhck6slt3FBi1GjGSgt12ZIAyRKrmqZ5vBDIaIqaGbAZMDn2sUK8UfKOp99Yxgjw
	xYhKLvbjAQ5RBX+7f5OVAUb3DbriWCC2r2MwspoCH2P8pGX/UoFpOCFehR958grUKHVRI6XcrhY
	o3ULIXZ3/sYtE9MyERx/fNZH5uXnDD6QEvdI4/m
X-Received: by 2002:ac8:5743:0:b0:533:90df:fda3 with SMTP id d75a77b69052e-535fc8a0915mr24634181cf.50.1791942252446;
        Tue, 13 Oct 2026 18:44:12 -0700 (PDT)
Received: from boomzilla (dynamic-acs-24-101-237-49.zoominternet.net. [24.101.237.49])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b97c4a7d9sm40377936d6.47.2026.10.13.18.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 18:44:12 -0700 (PDT)
From: Karlos Abel <kabel@voidship.net>
To: dmitry.torokhov@gmail.com,
	mpearson-lenovo@squebb.ca,
	hmh@hmh.eng.br
Cc: derekjohn.clark@gmail.com,
	hansg@kernel.org,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-input@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: [PATCH] platform/x86: thinkpad_acpi: Sync initial switch states
Date: Tue, 13 Oct 2026 21:44:09 -0400
Message-ID: <20261014014409.14579-1-kabel@voidship.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <98c68af25f9fc08500eb818a6d77d0d7@gmail.com>
References: <98c68af25f9fc08500eb818a6d77d0d7@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hotkey_init() reports the initial switch states before registering the
input device, but does not terminate the packet with input_sync(). Since
input event buffers are allocated before registration, these events can
remain queued until a later SYN_REPORT.

On a ThinkPad, a userspace LED update and SYN_REPORT delivered the initial
SW_RFKILL_ALL=1 event to the rfkill input handler after registration. This
undid a software radio block that had already been applied.

Call input_sync() after reporting the initial switch states to flush the
packet before input handlers attach. This requires the input-core fix to
accept EV_SYN events before registration.

Fixes: 0cd587735205 ("Input: preallocate memory to hold event values")
Cc: stable@vger.kernel.org
Suggested-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://lore.kernel.org/r/98c68af25f9fc08500eb818a6d77d0d7@gmail.com
Assisted-by: LLM
Signed-off-by: Karlos Abel <kabel@voidship.net>
---
This is the companion driver change requested in the linked discussion.
It depends on Dmitry's "Input: always accept EV_SYN in input_event()":
https://lore.kernel.org/r/asx50uz6iafsyAd5@google.com
The prerequisite patch ID is included below.

Validation on 3857c2fe5449 plus that core patch:
- KUnit/UML: all six input tests pass with lockdep enabled. The two
  regression tests fail with either the core change or the pre-registration
  sync removed, and with both removed.
- The tests model the driver's event sequence with a virtual input device;
  they do not execute hotkey_init() or operate real radios.
- The actual ThinkPad driver object builds without warnings with W=1,
  configured both built-in and as a module (x86-64/GCC).
- No new physical-hardware run of this pair yet.

AI assistance covered the change, message, and regression validation.

 drivers/platform/x86/lenovo/thinkpad_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 1661f070c..ea8679398 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -3497,6 +3497,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 		input_report_switch(tpacpi_inputdev,
 				    SW_TABLET_MODE, tabletsw_state);
 	}
+	input_sync(tpacpi_inputdev);
 
 	/* Do not issue duplicate brightness change events to
 	 * userspace. tpacpi_detect_brightness_capabilities() must have

base-commit: 3857c2fe5449541e24afc5efdb0f81a8a8f9a3a0
prerequisite-patch-id: f8539bd5b5201ef9795823552ba68a73b7dd6298
-- 
2.56.0

