Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6378239CD12
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789043512; cv=none; b=QyoZUCHQ2EbpzKOu94a8QWl/5rrUUgqnPQBS94pNNkGPX9sAn4ihVl+Nc2n5xJuBi/mtGvaNN8zPOJ/FsDYXDsMeGmEBMcTMbDsDdyxwNNryG2vGbv7d1qYQKJH0n0nM0rQDYW1YpSS1crd7Dhojw3q77wQwJSKkdqfUnEBIblQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789043512; c=relaxed/simple;
	bh=YmVPJmZmJJpy+H6Vad8twxgOfHzx/5SWDC+0B4W79UY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IFQiDtaWPLjpQzKkCvPsSjFymWNofMdfUiTjRr3FSHXdDmvAFXTmGP7AcZd911vqw68CFjEYKJliIXZHnWT8/KMnvxJajB8Gnvekj3/MiG/jIaL9qUEKaPhEYeysJAaRmmv/+JHsAjTZ5LvIHcbdBqCdWe05EN+EGreeru6BQvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NJ5aRiu+; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJ5aRiu+"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-395cf2535acso904201a91.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 05:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789043507; x=1789648307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=saSILGaN9dWmcZOtLftRveD8MyTd0A1bzqhRd73xrHQ=;
        b=NJ5aRiu+OzuZQQ6HZnFQN1J+PWapRUdAh0D10O4pl9gkR03lvOPWiwgpAZXdwIOcsT
         tT5pvpfrHEv/KArk6dP8LHX5xBFHxJv4buO6NxYvEB+yEav4/gzPQriYKProAy6MP6py
         N6WnR6WinaRxakBZt0DIiIhQz/2fwF9DYWbwvYtrUTmvEAJCOr4aWXdK1HUEcGeW3LQS
         yhZB95+HGSfh70xdj0BZLSRO2QL3saK0X1pnJh9iOPx1Eog/1aCJ1+5Azf5BNYLc3Iu4
         vaUMsRYHS2H1OYO1eNdaervrA1KPiYg/m4kftKfg8Dt2b5zctA1Hq5+RgyXmDXG1lGdH
         m1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789043507; x=1789648307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=saSILGaN9dWmcZOtLftRveD8MyTd0A1bzqhRd73xrHQ=;
        b=o8HnFuV80iY+isv7t+cHtHd/yiYptAce+qPya9bXR12fSc6iAHQ2FfDv2NYhEvrcYx
         N5/vV+FFIOe5+DDJgebCf38cO26P6f0o4dxP2zM/TUOb1M8OqZX8VhKEFWUeSLTgXScx
         ZThGJFOLgQjgas8HQDfZ2sYJ2K3IrQprTH0xR2Xb5MPSriR2s8HG9YnlpDreS8Is0Amt
         27c9L2Gu5rSoApfj0A06YpBKLKVDpA7VpMYfxAEazegwiu12C76+eAdocNL9CmfeX8md
         RAOd8USHGGpPPP3Q2w1MAv6jSji/H4BmxDa7efVBl7Uw1kPklGZW0SCknJYCkK6JSZau
         nlCw==
X-Forwarded-Encrypted: i=1; AKwUvBwjpPKWuF8cEIY2oWRKfRHNURHZNgEag6NdaAdcqYunMaabnNM5JG93Up/iC39nXePMvetCCqI=@vger.kernel.org
X-Gm-Message-State: AFuF++lFWRHeWul05FJPAiQkQvxnxUkvrkNBSWMWe1FUOlmpkaN1dBrV
	66LrZ6+szEFR81Kh2QN4dvWHW8cdfOlX6zAMWvlse7R68RemBxru9YwS
X-Gm-Gg: AYBFou1HtXSPx4lp85OngxA1gKQHqGmbRDbRNgrpgK2Xq/daj2ggygXD2DyrOP4XFM4
	jA3hv+yfPXeUHxleRlxEU5lcYX9H+m8rxLKeU+X6rjtbsgckMukp90xA4IMLsnWChvuIq7e6Srg
	pjLWPeMbgWzZa0zItV3CHs6Bed9WwvVa+Ls3TwLUFRmSNTUfT0wYXpiar9j6o5mUPZKapaLn56u
	t/tZO+BmIy1jthhPHrUiyLrfKut7VR/GlK51brWTvPciIggwbhX31qdzLKKL+yP2YlUOfO6znSn
	H7y4SF3cpLRzhTPU8A4j8smGaIlRMzyoR+bwiWer1I7GH6SOJJN8jUacBkRGLpt7EenEJnoqPxC
	Zi3UxrxQyMP/PZkCMUcQ3hDrVupmyOKF5cwkuB4JqekjA8D1xxHkBT840ANhdhX7NxCnDYAiJ9h
	TP1yoXtF7pz7w0zPeRe3CHh7i7LHGB9EnXxakxqVPzgJRwn2F9jD0Ausgi8Lnz2SghFsCldGI=
X-Received: by 2002:a17:90b:4ec7:b0:398:a649:8fa3 with SMTP id 98e67ed59e1d1-39d77b770ccmr6323288a91.23.1789043506633;
        Thu, 10 Sep 2026 05:31:46 -0700 (PDT)
Received: from lap-0341.. ([182.176.170.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3342af0bc08sm52658522eec.17.2026.09.10.05.31.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 05:31:46 -0700 (PDT)
From: syedlabeeq <syedlabeeq@gmail.com>
To: linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: stern@rowland.harvard.edu,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>
Subject: [PATCH RESEND] usb: storage: sierra_ms: reject short SWoC info transfers
Date: Thu, 10 Sep 2026 17:31:28 +0500
Message-ID: <20260910123129.16793-1-syedlabeeq@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Syed Labeeq Sajid Bukhari <syedlabeeq@gmail.com>

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
---
Resend: the first posting was whitespace-mangled by a webmail client;
no code changes.
 drivers/usb/storage/sierra_ms.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/storage/sierra_ms.c b/drivers/usb/storage/sierra_ms.c
index 177fa6cd143ab2837640c26f8336781ddd3cf9cb..8755fda42eed2afd3235283e990a35aac14cb829 100644
--- a/drivers/usb/storage/sierra_ms.c
+++ b/drivers/usb/storage/sierra_ms.c
@@ -76,6 +76,12 @@
 			(void *) swocInfo,		/* void *data        */
 			sizeof(struct swoc_info),	/* __u16 size 	     */
 			USB_CTRL_SET_TIMEOUT);		/* int timeout 	     */
+	/*
+	 * A short IN transfer leaves the tail of swocInfo uninitialized;
+	 * only a full transfer is valid.
+	 */
+	if (result != sizeof(struct swoc_info))
+		return -EIO;
 
 	swocInfo->LinuxSKU = le16_to_cpu(swocInfo->LinuxSKU);
 	swocInfo->LinuxVer = le16_to_cpu(swocInfo->LinuxVer);
-- 
2.43.0
