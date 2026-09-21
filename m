Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D46544F578
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789979179; cv=none; b=Lc6+4lfrsaqFLrXDtvDomXDy3IfJobqAi8R6V+5QJpFYphbNvAMSqDsRbemWki7M5e7ZHgChriBHm50koaAEWULNBx5P0zNprp95LgKY+4QXJICcdRX5DynSjcyzIZuooX4BLID/WHYealZIz0DapybsP+e07MeZOY4AH5WioVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789979179; c=relaxed/simple;
	bh=+hgLRH0kg/URrpkpVtllXKugJJqqqN1Pj/iK4V01C3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oKfk1EN0Ak8BvZ6CvFCSKxlpkMcLSIGH94ZOETzk4UvBJ7jNkjjp/kYn3a/I3zvq1OQQq03Hb+MhynzC7s/1yioYmRzGgdLLvrfnIQjEX8yIGszRCpFGp7HVDumL+zzpew2oWQt2fNTuGQvutODd0VjoyzMGWbEFkJmmxVLrpH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZPBJn6A6; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZPBJn6A6"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469a34908so2418768b3a.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789979177; x=1790583977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ooL0yu/97MAI2sEUI7eblr213Ntkqb5Ie04YLHmVRm0=;
        b=ZPBJn6A6UuIavQfwfEF3TMzBky5+JxVvdcC4bEd0urtHtwh13IixqcOynkeEyUNcDT
         ZCOmX2U3vNF7m34zpui+btP3BKrLVzd/fUE2sPE2otYGFUWyCuWdz+lQbx5wK6JsLOzH
         7TKt+tRywyt1usVGuEVFkazjoc06ABaT9vBSKZQV1lnIIIiV+3xvy+75aUE5qItfXMe0
         ncvW7r0sLRE9aw3WtvTnQfq+ZMD7Q8n4b25Sfy0IhT/7Y2tb1F6UoTzbh0iy7kB2jYqk
         JwFD1x7sRhS4lFLOy+R70PzYZ8gX+zGAwGErqPVbYKv7if2tYEnh/ktLG5WH9apb6b7O
         R0VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789979177; x=1790583977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ooL0yu/97MAI2sEUI7eblr213Ntkqb5Ie04YLHmVRm0=;
        b=Kd4L2P83mMXPfMsqHGT8qd1Ye//aGtXyczPPPEdNVMpmcpdbpQYda6v1fsh0e0hjl3
         +to1rBIpToCl7xQZU8cU4rTgWtH234A5rfA6WkoAsF7mDv5z5oEVuSPGf8bms0qYD7tw
         e7MusVhFtcFJS6j/7OfaMGv3hONHMn5xMyG8I2Bbupsy6r330836H+YNUtsd4TE6Spcq
         9yEw92JSQbH34bao9R33IzwNVdSqw+fG170jAf3rtOG3GGxnbboJCUZkqFHFfb63qrPf
         Pc9lWL6aiP4fu3vSGTXhoQz4lG0bUkOymr1KnN26acRItZDeC03o4paPBLpFHinq40uI
         vrbg==
X-Forwarded-Encrypted: i=1; AKwUvBzDsXZx2mGmk+Kqu2+xJCLx9785Cg5LlBuxifxjzzabeteO96Fa5QVQgG2PInxwJSRPL7dkobs=@vger.kernel.org
X-Gm-Message-State: AFuF++kz/1EFF9ZJYuByQhJ70ZehMNuhHRAu09jnzY9Tibg+VF21F4XF
	1HsUuXcpktH5sAdV7HlKNA7WiyNpg4VQ8FormhwT5FPP3zlLjK7LKUMe
X-Gm-Gg: AYBFou3nyoBRFCvLSvZm0My5hdR62IFMftPUfTxGOPn+y6sGfnUA7dTaYvxIwJYAwwK
	lujRLN2KaDqIG1Sea4b4eJQIr6P/YMZNEjaddqJX7nty/6fyewJ2YO7+UDqZ5X1/EXEJwuiai/t
	0lc0j8Km1thlPBuAuvJxKna1fXoHTQTkX0fNVfwELdTSxTu3YhWDsjD9AixgXBTIQZA8o7tFeQ+
	Z6q/7wnpEnrqomI4VT+4YbDszNr1iUvlFfOKZRTDCWMYmp0k5RdoXa6lB0LQd3CPizoVikjJKwh
	sX3YHRqhZETiY+I83LVjwpXt0Laq0LxTCtwfgE8/ZTAxZS6GlKMVdDlfya301uXRpyMug4nwGjj
	+8ean/FxMy61a/MRU5ix1w1VnEDstzRkYxj0ZlsiJwYPWJPr9fuOLuWPUCCI7tOOLq9IHx9lxSy
	RS8p/5X2/o407sfSVIqmeG6dRIPR6fx6KB5XD+liItYnzwcOHdIFOIgg==
X-Received: by 2002:a05:6a00:f0b:b0:878:34d7:697c with SMTP id d2e1a72fcca58-87834d76ce7mr6581070b3a.42.1789979177544;
        Mon, 21 Sep 2026 01:26:17 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a95f916dsm2872054b3a.31.2026.09.21.01.26.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:26:17 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86/amd/hfi: fix platform device leak on init failure
Date: Mon, 21 Sep 2026 16:26:09 +0800
Message-ID: <20260921082609.244774-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

amd_hfi_init() registers the HFI platform device before registering
the platform driver. If platform_driver_register() fails, the function
returns the error without unregistering the already registered platform
device.

Since the failed init path does not run amd_hfi_exit(), the platform
device remains registered and its reference is never dropped, preventing
the associated platform object from being released.

Unregister the platform device when platform driver registration fails
to properly unwind the successful device registration.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 5d902ee5609a ("platform/x86: hfi: Introduce AMD Hardware Feedback Interface Driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/platform/x86/amd/hfi/hfi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/hfi/hfi.c b/drivers/platform/x86/amd/hfi/hfi.c
index e0ebcb0c4acd..449aad914ad1 100644
--- a/drivers/platform/x86/amd/hfi/hfi.c
+++ b/drivers/platform/x86/amd/hfi/hfi.c
@@ -530,8 +530,10 @@ static int __init amd_hfi_init(void)
 	}
 
 	ret = platform_driver_register(&amd_hfi_driver);
-	if (ret)
+	if (ret) {
 		pr_err("failed to register HFI driver\n");
+		platform_device_unregister(device);
+	}
 
 	return ret;
 }
-- 
2.43.0

