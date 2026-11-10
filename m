Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341483;
	b=rF/3XcNpgZG5bMix9vJjWjiSV96kj+X0PTHMBHsBQv4qhnfj/VBAD1dqw8SZCnvZzAFn
	 pNLzAEcT7oU3MSKy+RycXiFg7uuRSILHyKc/VIoCnpmJX880aoXzfTquxSHWH1eCSWL+k
	 2QvtMon7QbOAUK4/9FNGboxXeuUA4gHuF49p8t5W4ckY6ROqDZoHEzNuzm++jkLm/PsdT
	 s4JEKGkv3PoEwPqK1D6+Bg44o2cx8UMUCFvxvY2gM6snSOrmyv9LInF5tixYd6PJU0Ggg
	 Y4eOsRr3eTo7vx5fneiz3jB4irI54cJ8vrYRHg47qBG4snXZ1duG46GQggqw/34lROw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341483;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hlWOT1mmQ1ELiRZnc0uqyCs5IstElllfy8yf+CNjx0M=;
	b=gNfNY2Bwql2gujZ1xH1yjJNYN+0Z1yOtXUu2KS61eecvse24P+Jdnwt0aY1A1n4vVGBu
	 6BYultph/t/9O+7yDdyPMB3GihVD17wvuf4omfJjYEvQwosovS25OVsX4d/P1nWzzGOmC
	 uBoALOt5GpSGeGX1KnN/9lDy5T1M3u4+ZaqI45BLYNM26n6zJZ33/97Fzip1iSw1qomUC
	 8dFSc2lHBiH64JzFX76l4SH5kO9pYg5hlUZJ7PRHbIgFNJ7AZY67vSOykRQJVxtqXcBOG
	 UnezyygOozvsU0dWOg6wpPXRkJZSy/NtXbpadhcTikkPmj1yBMXXgV4RUnRHwg5S+6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbIp9pCa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F29606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AbIp9pCa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AC71F008A3;
	Tue, 10 Nov 2026 20:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341482;
	bh=hlWOT1mmQ1ELiRZnc0uqyCs5IstElllfy8yf+CNjx0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AbIp9pCaDoniYvdpnO+uQb24BXN0IEkAaLA1vjquyBdLkBks3+M544KwzBRZEOPe3
	 r4Lgf9skBRz6TtOu/3bNt8VmxSY2U6gobIgBuznucwFQAnMJ+HqKXZZ7sAy35qnefI
	 jZkqznL1G7nTYEs/+7W2+Ssm2ZwKN32aidxj1d7Dj53g9xbT8M5Xw0/iGSYkULx/b7
	 XjcYhT9R7Kx+HHEXrQRbOOwEoZT3nFvMiDplw2A3EDW/5Oj+jYQszusjqtEoWhfCyW
	 5pp7mKimnUTs0LVyO1LT549BkO+MSsq0SEAdImKgsFi00gjK0kPZO8YSx40wmJNZv+
	 BQ073lHfvQ2zw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chintan Patel <chintanlike@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/3] fbdev: sh_mobile_lcdc: Make FB_DEVICE dependency optional
Date: Tue, 10 Nov 2026 15:11:19 -0500
Message-ID: <20261110200947.3702749-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110200947.3702749-1-sashal@kernel.org>
References: <20261107051054-failed-6.18-317a8be73091@kernel.org>
 <20261110200947.3702749-1-sashal@kernel.org>
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

From: Chintan Patel <chintanlike@gmail.com>

[ Upstream commit c2925992232fdc4e90f030b77e7867921db071b5 ]

The sh_mobile_lcdc driver exposes overlay configuration via sysfs, but the
core driver does not require CONFIG_FB_DEVICE.

Make overlay sysfs optional so that the driver can build and operate
even when FB_DEVICE is disabled. The kernel naturally ignores the
missing attribute group, preserving buildability and type safety.

Suggested-by: Helge Deller <deller@gmx.de>
Signed-off-by: Chintan Patel <chintanlike@gmail.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
Stable-dep-of: 317a8be73091 ("fbdev: sh_mobile_lcdcfb: Restore the per-overlay sysfs attributes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index c6da5a62f8c5f..1b7b9dd19b623 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1346,14 +1346,17 @@ static DEVICE_ATTR_RW(overlay_mode);
 static DEVICE_ATTR_RW(overlay_position);
 static DEVICE_ATTR_RW(overlay_rop3);
 
-static struct attribute *overlay_sysfs_attrs[] = {
+static struct attribute *overlay_sysfs_attrs[] __maybe_unused = {
 	&dev_attr_overlay_alpha.attr,
 	&dev_attr_overlay_mode.attr,
 	&dev_attr_overlay_position.attr,
 	&dev_attr_overlay_rop3.attr,
 	NULL,
 };
+
+#ifdef CONFIG_FB_DEVICE
 ATTRIBUTE_GROUPS(overlay_sysfs);
+#endif
 
 static const struct fb_fix_screeninfo sh_mobile_lcdc_overlay_fix  = {
 	.id =		"SH Mobile LCDC",
-- 
2.53.0

