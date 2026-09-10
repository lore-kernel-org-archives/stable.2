Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65593939C1
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789048934; cv=none; b=XHTPVfdMQJ3ztw8E+o28HWBKz1WyAHAu6yeIQnq7Xjydkukm4brDrkCyrdunXuDlWQtJmLi9KejyUNLNAUrz3wPP5dQRtaaCDeOk+qanIf9GY35GwA8bPV8Zhv6Ocao8iT8tjf7l3+sy2+18cO4IPoguW7eIZuRxMRkRdtScLP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789048934; c=relaxed/simple;
	bh=Cy750GzBll6bROKUYBd0OY8+u3cY55k9qpgc+XdvLXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NZ9vDcZ+h1X8QZcKPM1GYWff8wWsyq68xFeakvXTLIllJkHxHvHq46h080+/aepWGjit0jqKw/iQpX6zVLFAUEknswxg3eFrmWL9MH+7ppfbfoES/EGxiCrDoR/FgzzWnXWHLs3R1+u8hOBNsy8jtle4Uv0V1T5nqX/zye3xNnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K74qrI5K; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K74qrI5K"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4a46a53abc9so5556671b6e.3
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789048932; x=1789653732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9J+JrWjpvpXQUYfZhH1A5CtyfDunCqzubZiL0OyBK0=;
        b=K74qrI5KuYSQ2AKcqQgqPUvinFRvMoB/PC9V7vkT6TaZnXdlcc88G7BMaqm0dv+XmV
         iu7SsiDaVciDiqnLzTX8Dy6KsATC3CdFJswDb32EaTRn26U9GMufmXT0Xw6Q1Z68bCM0
         bx9SI1jWHcZ+7nZszb2fll1fiuOK8T+8bqzjq2VLlrPE9yf2GXJf31GBgmTyIy91asJt
         LM345/LJWebQrDTZ8h4cJhm/1x38QP/dmXq41kpBX9AqTRrIA8WD8x3BRnm5H3IItvF+
         lexlsjy0sqyBRSv/Mkasq3bUZRQ69uoUA1OkzUXOGyrOidg8hErY+9SspKcqFcXZTKae
         ao9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789048932; x=1789653732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9J+JrWjpvpXQUYfZhH1A5CtyfDunCqzubZiL0OyBK0=;
        b=r0bQOdz1GOS/JBelqAdMkSUEDG6at+or0HPW5Bk1p5b3ECiju419s+c3GwXoqmKwHV
         rLfvAPhtN7rulF6Cf1CIepmKUUheQWMoi/TOtoDv4S3gxOyltuI8Ww5exCH36Z0/2Ras
         ogiUexyWSjAnAxbgsgjwyBARi1w0YTD7IX6n+4ZQjuOoAXKZLd3IRWOl+9Wr/d1pRsi5
         rKpLRAtQ6JTXySj0MDAXLAyjOEi9bzgYdF4tfE3oocOJanWbRTkBdGOxnwQWONI2IWl+
         FxYFPWFojcubuZntWwcHSvZW6w/D2pTB9DmdDhpql5uzCBR8TNTV/l39vSBi4ZLQ6/ih
         pn6Q==
X-Gm-Message-State: AFuF++kyqPhmQEi1I6hQ8xgQjMFqtxPAZbRnGnEbq5o9UalxufG+Ryd9
	WBxhR0RlQF70XBWICC7b34OguoONieyEBIhPVAmNMoHbe1OEVK9fQ/NfOl/dU9/T
X-Gm-Gg: AYBFou2+fFMH6qhMyndNoPoCKlCTfGciSx2bewLgRfg1Pqypo7Yw/JWw9NLf92Voydz
	Y+qYgfvfl8Ck6hEhGCGMCUbwBE2RRQMNYz1AEHKQwHBzjexa/UOPpQ9B2I4sfU7RgNwXxh1SeZ8
	fg20eEwonKN4CRW4zpqqvYHpJ97y3s0tOW1v4n3HPv7C5zgvjqSfMww9qyel0cdvo3O7VZiABYZ
	gq9Iw+1eLHFpnck6uz5g621gPre64tyDvTg/H/1y3LdyFg9XWJjIdpSQFkX6BlXZBdJvrxuBpAq
	utO/eAOknnyfL6uM/EGVzW4sct/uckHkkKHwzHK29bgYFTMJUH+P7+6p3KYmd2Y/DSokchDG31W
	mA66D3DKi3tqPKTLs3WNYgA79oRMJtDdWef2fiQ9iZlc96rnnMle75A0CJ2A98xu8YM+pyqYgqm
	LLeAsfeF0aqraystxxZeQ7Q7rBeLfbhwBWVZ5Y1zIIM+8Tj4w+WEYcFJjjNS70lDo36DPaRlPX
X-Received: by 2002:a05:6820:198c:b0:6b4:117e:543 with SMTP id 006d021491bc7-6b6fc5dc03amr23927800eaf.21.1789048931393;
        Thu, 10 Sep 2026 07:02:11 -0700 (PDT)
Received: from lap-0341.. ([182.176.170.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-338f7bad290sm21735667eec.14.2026.09.10.07.02.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:02:10 -0700 (PDT)
From: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
To: syedlabeeq@gmail.com
Cc: stable@vger.kernel.org
Subject: [PATCH v2] usb: storage: sierra_ms: reject short SWoC info transfers
Date: Thu, 10 Sep 2026 19:01:56 +0500
Message-ID: <20260910140156.47847-1-syedlabeeq@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sierra_get_swoc_info() requests sizeof(struct swoc_info) (60) bytes
from the device via usb_control_msg(), but its callers only treat a
negative return value as failure. A device that answers the
vendor-specific GetSwocInfo request with a short IN transfer is
therefore accepted, leaving the tail of the freshly allocated
(kmalloc(), non-zeroing) swoc_info buffer uninitialized.

truinst_show() subsequently prints swocInfo->rev, swocInfo->LinuxSKU
and swocInfo->LinuxVer from that buffer into the world-readable
(0444) "truinst" sysfs attribute. An emulated/malicious USB device
(VID 0x1199, PID 0x0fff) can exploit this to disclose up to 5 bytes
of stale kernel heap memory (kmalloc-64) to unprivileged userspace,
once per sysfs read, indefinitely. On kernels built without
init_on_alloc this leaks recently freed heap contents.

Only accept the transfer when the full structure was received.
sierra_ms_init() already retries failed queries, so well-behaved
devices are unaffected.

Fixes: 32fe5e393455 ("USB Storage Sierra: TRU-Install feature update")
Cc: stable@vger.kernel.org
Signed-off-by: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
Assisted-by: Kimi:K2 [Kimi Code CLI]
---
v2: add blank line before the comment block; add Assisted-by tag.
    No functional change.
 drivers/usb/storage/sierra_ms.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
index 177fa6cd143ab2837640c26f8336781ddd3cf9cb..d8fe9561b2b5f4cce6aa8702309cfc195bc3c891 100644
--- a/drivers/usb/storage/sierra_ms.c
+++ b/drivers/usb/storage/sierra_ms.c
@@ -77,6 +77,13 @@
 			sizeof(struct swoc_info),	/* __u16 size 	     */
 			USB_CTRL_SET_TIMEOUT);		/* int timeout 	     */
 
+	/*
+	 * A short IN transfer leaves the tail of swocInfo uninitialized;
+	 * only a full transfer is valid.
+	 */
+	if (result != sizeof(struct swoc_info))
+		return -EIO;
+
 	swocInfo->LinuxSKU = le16_to_cpu(swocInfo->LinuxSKU);
 	swocInfo->LinuxVer = le16_to_cpu(swocInfo->LinuxVer);
 	return result;
-- 
2.43.0
