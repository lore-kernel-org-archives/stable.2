Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.136
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677426;
	b=Dz2bSgm0nNDCjtRkflIYXePjMG2geH1oNs0w9KLDiRdTscyp6l+oupq5JjB0iCm2fn8P
	 AyDhng/PUWDugagtBpcBsiiZD4peD4pfMbrJNhSZTtG2VfkIcJJbTT7JbQ/hKqaPhxV2I
	 x3pDXHSV6b/d9ikR3FtENI/brRBYVD76jVkDfsJ3Js3nyTsFpYdUjvxkQ+kCzR153Npu8
	 hbBZmPq5rdra1u6kpQ8JP6WJKXW5ML3Dj3+nUXWoHdN0btPpaYpNNEUl4QOrWaEhNzltP
	 Y/UYAnmugTfmAzGcZ+nzcDPfeUVvVjKGoWCzI5S3nJPyyiKeVklMqGc50vO6GF8dHyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677426;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vUdHoaBVYZmPnE/s62HT4yYg3gzMJTqDR+eMVLrtAyE=;
	b=gqQ9VJgQSF9ycfp2N/Mg/dxXZQf8YKPtnQQVB++pNH5ZJjej+t9FyZxwPyc+7swqzK3U
	 epxiROqRS1K3CSGmnGHtv0PDU3xqXhCMFlfUq+6PXrhEE3ZYk0p/gGg9iX5CmxC10EcIp
	 YZH6z0SPIAzbPXYj/OoCul5mzW7RM4MrozB0/ZW0RNY57UgDRNb5AXKoWdJqvzN6mMdP/
	 roxBszmaWznFa+sKsBdeP32LEXu/946dcauOKSb15kO9L+iOdjRtzq83Bj2MdtkiNUCpd
	 SKaJnIx+C0J/m8N50KuBnCP5fHpmoNzBjBlObt2cPYEj+WFZH8Ozfg7AH1iPlWGXhqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VO+j36SU;
	arc=none smtp.remote-ip=74.125.227.136
Received: from mail-pj2-f8.google.com (mail-pj2-f8.google.com [74.125.227.136])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753E606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 17:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C753E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VO+j36SU
Received: by mail-pj2-f8.google.com with SMTP id 98e67ed59e1d1-3ae93a86008so1301411a91.0
        for <stable@vger.kernel.org>; Sat, 14 Nov 2026 09:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794677425; x=1795282225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vUdHoaBVYZmPnE/s62HT4yYg3gzMJTqDR+eMVLrtAyE=;
        b=VO+j36SUqGGpA926liLeazEis4wYu8nJBE6tHFHArWkXpDn3VFtBMT6QC1l0bYtEOI
         Dj+i2mY1RcFmAlKB8dqsmnesBBh6DND2Kb/NxEzsOfwHZbhykgX447qlv7DCgwS3IAcc
         3ymje0s75BzSjpmsML2Fh+gZqsQpuKT+30uqWO+wnCK9FO4lypYS1AIQlkA0kBbIAbTR
         PtSc3mhiNMw9HIwH+7LJDQ+HHUbXUoT8S+41HAEpjKUrIk5auPUA9m6HFvvcruALLMvB
         U7WOJ0pL66WG9WoJIOSay5mWq2aI8/fAUN4eIVcGfQxj9a+1vfXi6eOeWdKMB4o7RcXc
         wSZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794677425; x=1795282225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vUdHoaBVYZmPnE/s62HT4yYg3gzMJTqDR+eMVLrtAyE=;
        b=b8UlaZuiomYAmWT6pwj95c/y7mEJhHMIlZ1FmeMFJ/ux62qTXtaG2ayL50JSIKy/HR
         FEkMbm+QILAowNA4e8DhzLo4YU/jvZR3eQ2Sp2Dl76VT+unYBarbO5csX55hJ+SMAMO7
         DMzK3KWeGGpTYkItZzSHtUIhO9Skg48Diqmed3+xE5KjrnXvLhZYK8RXJSIrLGnuaUbz
         R3m/C1rN6nZ2cZN920Nttvr7aBgECWP36UuyyQ8lyKS2lwmNiARbPZZeIIN8xFPMDZlp
         Bfpx6vlXXHEfdXaMoWKQncKVvHOryIZ3l1P/E+E/7PaiO02jfAy8YRnC9o9yHWHMQz5m
         F9lQ==
X-Forwarded-Encrypted: i=1; AL+hErGt4o2hNrnL9OAL5GDPBTVwPvJbt1YU4fDQvXeTQG4mNzKY+dD3eNpCc/V6tMH1WsS30yueyYE=@vger.kernel.org
X-Gm-Message-State: APuU4Z95ApCWA6bj1gEN20gPZ6CDNR+xpcYkt3NLAbhYwYOMs9SdS1rS
	Xd8oX12Mlo1pyfP1NyMZrhAajjb1uyxiUcmYmI9ILNRZ/ycOdZyNMbAd5J9JTu/D49Y=
X-Gm-Gg: AYBFou2NkZt0Bao4O3d82ee/QBEZG4m1/IRbAeUYM7jpp5iMsBm0NJSgAqlICOOovOk
	UE14HAyPeFbGdHiV3e4kCjpKGPS98j0LZ4xMl9Co13JNkY1ZoJQGIk9SWbjhLE4FGeSPR0gXNW0
	eckQHEe9Jt2q+c5gFm7H4Ayx3lF07762u5dE9v9E4JQ7unAFa8gt0kJbZQyEFxQajxj8UoaAGQl
	W1p8NYYf95ZENmik8iAjXrx2a7JDfaVX6Kgn7CYxV5yr6WIziWEx0hcxD6lz0QkR3JM0I8qzwn7
	0pOvci2hbt1yZcrWc8GjuIJRlcylILNEekYKeCI1IfPJjqrB0tEhVNyYje52H7uLcSe7IoSfPHO
	HsOa5kZ0Da7hrJHC1bWWDPCM6uwmm0Z8YVWNqr8lAxw2QWdM8/STkXQmhIZikOb8U8kBfBHM8q7
	EsQeI0Dgb2XvLopcv2PORqiEOLCodY5kHeG0rikXpwdDXfmNvVgcwJGPUKLo7kWllkDWG8oGQAM
	O1NTtHoyRDgiP5uIkPYdKuJHQXXB0x6XqGQFeA+GIzoVHp+lqi0iggKoyB5XrDfwzdoVJXrfR8H
	zh66sOOgj7ngaJLuPW4BIOvDISo3
X-Received: by 2002:a17:90a:e7cc:b0:3a8:59d3:5317 with SMTP id 98e67ed59e1d1-3b1b0a1000dmr6177173a91.32.1794677425086;
        Sat, 14 Nov 2026 09:30:25 -0800 (PST)
Received: from ThinkPad ([192.220.23.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b197d282fdsm14799570a91.14.2026.11.14.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 09:30:23 -0800 (PST)
From: Qiling Zhu <kmatzkaczor244@gmail.com>
To: kmatzkaczor244@gmail.com
Cc: Andrea Rabbaglietti <rabbagliettiandrea@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/7] platform/x86: thinkpad_acpi: Report auto keyboard backlight mode as off
Date: Sun, 15 Nov 2026 01:29:41 +0800
Message-ID: <20261114172947.55381-2-kmatzkaczor244@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114172947.55381-1-kmatzkaczor244@gmail.com>
References: <20261102151211.40701-1-kmatzkaczor244@gmail.com>
 <20261114172947.55381-1-kmatzkaczor244@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EC keyboard backlight level 3, which selects the auto mode, is
passed to the LED classdev verbatim by kbdlight_sysfs_get().  The LED
then reports a brightness of 3 with max_brightness 2, both through the
brightness sysfs attribute and through brightness_hw_changed
notifications.

This is not only cosmetic: UPower 1.91.x treats the out-of-range value as
invalid and stops watching brightness_hw_changed altogether, so the desktop
stops following the Fn+Space hotkey once auto mode has been entered.

The auto mode is not a brightness level.  Map it to 0, the value it is
reported as most of the time anyway, in line with what ideapad-laptop
already does for its auto mode.

Fixes: bb28f3d51ff5 ("thinkpad_acpi: Add support for keyboard backlight")
Reported-by: Andrea Rabbaglietti <rabbagliettiandrea@gmail.com>
Closes: https://lore.kernel.org/r/CAENjc+w0Rqy=kDSew7XtNJCSvyPiXPJ5faWdmCr5RGYFhpunCA@mail.gmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Qiling Zhu <kmatzkaczor244@gmail.com>
---
 drivers/platform/x86/lenovo/thinkpad_acpi.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lenovo/thinkpad_acpi.c b/drivers/platform/x86/lenovo/thinkpad_acpi.c
index 4f81855ad..2c3f8cf32 100644
--- a/drivers/platform/x86/lenovo/thinkpad_acpi.c
+++ b/drivers/platform/x86/lenovo/thinkpad_acpi.c
@@ -5102,6 +5102,9 @@ static struct ibm_struct video_driver_data = {
  * Keyboard backlight subdriver
  */
 
+/* EC level that selects the auto mode for the keyboard backlight */
+#define TPACPI_KBD_LIGHT_AUTO_LEVEL 3
+
 static enum led_brightness kbdlight_brightness;
 static DEFINE_MUTEX(kbdlight_mutex);
 
@@ -5191,7 +5194,8 @@ static enum led_brightness kbdlight_sysfs_get(struct led_classdev *led_cdev)
 	int level;
 
 	level = kbdlight_get_level();
-	if (level < 0)
+	/* Auto mode is not a brightness level; report it as off. */
+	if (level < 0 || level == TPACPI_KBD_LIGHT_AUTO_LEVEL)
 		return 0;
 
 	return level;
-- 
2.56.1

