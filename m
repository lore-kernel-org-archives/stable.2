Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E342DE6E3
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 22:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944285; cv=none; b=tHOFunsyoVofsoQ//tVaau6n1QF7uV8uXvzOCm0u8SV4nYF43bYPmW4zd3vPp+4aBTp8r+TUbARCykoCVpiRWGGEX3QkHOn2NGvRGmPqeRTbX1PQ36Qlx/63rwLilTAiwQ+7ZdoiC4OVCaJuB+9PNlOr0i3YnVa9n8LJgf7TaDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944285; c=relaxed/simple;
	bh=nCOVcS5Xjk1nB+bnIBUwvH0i7poNAUWnO3X659ZGnvg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G5eZ9PqVJ5MCOS3dpB9pUQKpThSyEoGHdrNTMyGwRXvwEfAAyjltx/42sZE5d/L/kJaD3PExER5nSu1wfxixgx3J9aJACoZOxxd4xKSOHWL6Qb1T3kqV8c4xIrMQDeRhYVpWeBZrZQfc5Rk6KhWtgnRiWeOtUgYfQrP8jIHx7bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIOw014N; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIOw014N"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aebd52488cso1154091e87.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 15:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782944281; x=1783549081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iq6lRh8f1Za1oSMuyvvaFYD5RB3Lmh/p/MiUmv9wGms=;
        b=VIOw014N7J/t32H61bZ8TXV5pmvOYXG0Sd594hILZsE2zCpd0XnLiRzPn0cKPb+Sju
         zoCjUydOHW7lMJ8flk5yXMymqgBCMYXOXya9TdMAgW2qIvi6seEPdCtBdnbeycJ8Busv
         fP37/o5ckENNDNzv/Gvn+QN2g5qcv9GuoPl5mw+2qwokD213BGu3a8Tv2JRSDf8osBh5
         rfsfxOPaal7SmLzeJ4R8xyr1PWDDZsK/auRQKpfhhH1BtEAVvXDnpzPKs7p/rkIPc88R
         +oiRR9XwvJunnU/6AKOsaQuHCZqMq3gHkn/Kff8k0aJjfmAlHpjKaGie5kzZDFlvnu/0
         WZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944281; x=1783549081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq6lRh8f1Za1oSMuyvvaFYD5RB3Lmh/p/MiUmv9wGms=;
        b=rVW9uBCgKwP2RPTpj3h4iuN9IJ+SCeItFbE8UE0MwoD2+uQQ+Qu7+mDZITmddOCPMX
         uGh+4hakEmXwmSgVGilCxV9ZOuCpgM/2chDWBAe2lcOiqKrIPQFXvYMOYY6NGpyhXgSb
         S4VQR3bhZL5mHet5MWlyB9UeZPfv9h0kIdUkye3hNpdPPgN7iw5Abq5sxCcfkBGYveej
         5OS3rLOG7AiMv9HpBoPRK1QggtDKtelJZnlfR6xSuz7RuVQC9BVwIfAP5Xz6zFFzYD1m
         czgcmsnooB2+kcKjOhQaefJYKmmkMirzq8VryGq0Qfa/DC9LBFa4Wz+hhlSOGcKp6e0x
         Uq3w==
X-Forwarded-Encrypted: i=1; AHgh+RqrV6YjvugILffYhc/4OeASlgEFOtiWSssix7wH9qI+Lg76uZqYKtcAnDjZnMFdG6cDMpl+/EE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywzim7xEUsiaRNOs8Z46EG7/LpdssJpjyjX+snGHLdJORTBPHEC
	n/nl75QDf/Xs0Rm8HM4BCjbLJ4LAIhMVNmtxX0OR6VRxI2Y812FJmr4r
X-Gm-Gg: AfdE7cnN9eKLtpj6BybtlQU9x/X3KLAwtGl2MDC8YQaCAUc6u/hdP8/0BxKnJobm3Cb
	RZDVWAoNSCNp53uJaERkc/vLvE9i6MRWVpAViF27Do9ioaeggcSXnDbUbdVMFipXicUaFspWkyl
	btxwxTet3XdErc8x0X2PJ7UlNeU/OmgW52aM4G03Nzb10YtQGDY1DStfgjsdRCGzuF/1LBy4Dc/
	yuy4jMe0+TWxkd96DmSv5HLSBUr+9kyQXt3UIn+ymdrIUTjknasNgecIZTddIUTdliLJRG0wpu5
	ninjX5Ay4DhXpkMIltu+PhAMpFr5MavwSdqfkYH84zCvaAiT9Mn0eIKS24H5uJURUGf2WL7BtKI
	mHa6oZh2Ry4v+0TAenoMbiR/t/9ClM1kkpQSA+e9dCh82dR1M1K8qHtR/xXPxBO5DahAhOE36G0
	YzhBSIB2TJVife2DdHUV9I62MBD5pF7io=
X-Received: by 2002:a05:6512:22c5:b0:5ae:a9ec:3545 with SMTP id 2adb3069b0e04-5aec7338d31mr590751e87.54.1782944280234;
        Wed, 01 Jul 2026 15:18:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89dc478sm267767e87.68.2026.07.01.15.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:17:58 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: protect mode sysfs reads with lock_fb_info()
Date: Thu,  2 Jul 2026 00:17:57 +0200
Message-Id: <20260701221757.231490-1-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

show_mode() dereferences fb_info->mode and show_modes() walks
fb_info->modelist without holding lock_fb_info(). store_modes() takes
lock_fb_info() while replacing the modelist and freeing the old one.

A concurrent reader can load a pointer to an old modelist entry before
store_modes() frees it, then dereference freed memory in mode_string().

Take lock_fb_info() in both show_mode() and show_modes() to serialize
with store_modes(). In show_mode(), copy the mode to the stack and
format the stack copy after dropping the lock.

Impact: local kernel UAF read when a privileged writer races with
sysfs readers of /sys/class/graphics/fb*/mode and modes.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
A userspace reproducer triggering the race is available to maintainers on request.

 drivers/video/fbdev/core/fbsysfs.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index ea196603c7..6bdb25f7be 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -82,11 +82,20 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 			 char *buf)
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
+	struct fb_videomode mode;
+	bool have_mode = false;
 
-	if (!fb_info->mode)
+	lock_fb_info(fb_info);
+	if (fb_info->mode) {
+		mode = *fb_info->mode;
+		have_mode = true;
+	}
+	unlock_fb_info(fb_info);
+
+	if (!have_mode)
 		return 0;
 
-	return mode_string(buf, 0, fb_info->mode);
+	return mode_string(buf, 0, &mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -134,10 +143,13 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	const struct fb_videomode *mode;
 
 	i = 0;
+	lock_fb_info(fb_info);
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i += mode_string(buf, i, mode);
 	}
+	unlock_fb_info(fb_info);
+
 	return i;
 }
 
-- 
2.39.5

