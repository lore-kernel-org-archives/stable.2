Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13906396D19
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789425322; cv=none; b=OHWUj6OBVQePv0XaX9HrFn3OlUU8zaenHQGZ/C8AANwhg19732KagMxIYFWyqyfIwuRc/FrXU7H46d4AoW7PlQMBVUGopbatkfIev05rbnQLXYqaPc/I1SXAP9Bcjh1sDYJYKWhTuScaxjUXIcsSMk7Oqm3XxVJdXWfsS+9J+tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789425322; c=relaxed/simple;
	bh=lPgEvreu0zPGM3ILg+o19Q8j1zzZ/FcyTs9QLV6/qZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m0TOpKxqGurGl7z6l9Ivlv911vwdqE/F6jRuO8T6FQBKZeYSBQpYKO9lhlk316nCns5pj8ddktcZwUnPtjxBGZDfrUKvaae05Q1qnF/1dLv/cWhOmcgPqZQB62qVMdenPhnkqrhB3WZ2VUMIrwihd9/Dgyy0bDTD4mpWE8/KGxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=paZw3DSg; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paZw3DSg"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-9103228ef53so44708936d6.0
        for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789425320; x=1790030120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EFwlG4gnZYkH84K5Z6UxkyDABvsd4Q+eyxbwPqCRkks=;
        b=paZw3DSg+Y5euFpKVEViYKsZXWDoCmlgn2K0ZJAJnu6v49+jQluFLkJ1s2CwNolcZE
         yChKbfz7bKSmycC9oJam01Ev7bYozTHofpfdIkLy1MUSkNGgTPPxqk/yoeh1V6yze2EH
         WF8IRT/voz9R9RUe+AI486jyY2gV7wh9Rv4HHcUe91VCX5zodPWjDz3jm1eCoZfTKVEp
         VK+TSog4xvSwST3mJBXTBXvrkBFXzK8oxo4L1VC6oxkE5lUVGjtzZ5bprWBi9a3WshpI
         L6wkYge7BXTY2lYkyRzVUTqQkoPtoFmWXk1qh6BGslzPm7897fg5HB4w2zx14Tf95upg
         DMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789425320; x=1790030120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EFwlG4gnZYkH84K5Z6UxkyDABvsd4Q+eyxbwPqCRkks=;
        b=aueF/dILQ0Htk97cqW396Ir46XVIwhyN6tH38WMZGpTOEOAspG3UMIsQjudNO5I+oY
         QQksVRk/I69VpltfKukoUAeRpHEUrKqAE/Xykskdmz8IqOZI7qhSwgum1usP3gwNuBwm
         b8BqyFpmMhs2Sc+m0kLQRUQ+RmnViiBqLY6YitCwznDT/+FRbe3agy0nB4BFsqp9F9DZ
         UXPHK/oNlpM3Gnlf6TZNioA/Ux8SwgYKCr9YwG4EQtD3MaqUCxtwjnOob2+mSr6cEWQK
         ORfGAqqCJTJzF7H91iqXH45rWao6hzJ1sn9FsVwGhmNUTQ2WMf9sb3PR4fPDqAQrpZlx
         eJvA==
X-Forwarded-Encrypted: i=1; AKwUvBx8kovzV5YvMWCwOTAYNQFt14ShzLBdlXHe/pp1ph3lvgjBWvTaMuHXkpvVU3KdR7qpm3G9akg=@vger.kernel.org
X-Gm-Message-State: AFuF++lX9N17C+CVxChGgNNNqGWWGztF8NGLvdaNGdcZKpydLHXCW2/r
	bZrYVrzc4D7KZFOMjxr0QrSlhcfzwIZ8C3hFGAxKorcSdSQ2OrygEHk=
X-Gm-Gg: AYBFou0D6ivUCDiv2t9iSjJOqMIxjH0ViKoppoZivD13hWBNaYw57o7OpsnzKk6I1iz
	htqg4/PDEZGv4myco6eeFaG7vlqedBnjfMUGl3nJiTx3lRIXFXeBlsa9ZH+wNRT2piJVEwWYbBd
	6HFXLU5Pkf+PvS50WHuUlJRLLsn/vwZiKn7OzXNAu1lo8XAhS2IL8jJWTeAyFGyKgyoueSd1WxH
	t7+BpPYsUs5/BryjqqK+i6g9TbqvNaX+A0Gq2ZGMdznYTSmYGYFsVj2TAkw02ysHvRhla3/pZec
	sJF/QKsPfJzbF/JGh7DxjGsOXsIS1nLhvwgKi27wViqEIY75B2WgxhIBCKoJho+xm7rhlBTx6P6
	W9plPds3aUGUWDKxNJUZj+G/XpvHhTdMd/knP5w+gbPZYNie5q7zfpSVIILgSF/EL/w4CYXzJ8t
	SCi/oGDwee647S0QsS7SkdTNzzMQMLaMwQDlqka1GW8Lqh4huKgA+9oJ/Rp9Z0PXGIg1L+LImob
	K5oYqS17wScoR0bTTnNLjG6xWv8BKO4VtWVUWhJ/OJhbhB66agC2+3aXtwkMeWgsZA+EREFjDsk
	6D+E4bkzYgID31UuQgBdy1GMdcU40tdpYrkshrqhJbpDidelfGZEKRnaYJfZXa/yxXZYJg==
X-Received: by 2002:a05:6214:320d:b0:912:289:647f with SMTP id 6a1803df08f44-9122e6906d0mr85830766d6.33.1789425319817;
        Mon, 14 Sep 2026 15:35:19 -0700 (PDT)
Received: from 6e-wmo5420-02.ad.psu.edu.net (6e-wmo5420-02.ad.psu.edu. [104.39.213.233])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9120f477d42sm106004416d6.18.2026.09.14.15.35.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Sep 2026 15:35:18 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] pwm: tegra: Use managed runtime PM cleanup
Date: Mon, 14 Sep 2026 18:35:12 -0400
Message-ID: <20260914223512.31049-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Runtime PM remains enabled if the initial resume fails or force-suspend
fails during probe unwind or removal.

Use devm_pm_runtime_enable() and replace the force-suspend calls with a
managed hardware cleanup action. Order cleanup so runtime PM is disabled
before turning off the clock and selecting sleep pinctrl for an active
device. Preserve the probe error and usage-count handling.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3da9b0feaa16 ("pwm: tegra: Add runtime PM and OPP support")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI:GPT-5.6
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Use devm_pm_runtime_enable(), as suggested by Mikko Perttunen.
- Replace probe/remove force-suspend calls with ordered managed cleanup.
- Retain clock cleanup for devices that remain active at teardown.

 drivers/pwm/pwm-tegra.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/pwm/pwm-tegra.c b/drivers/pwm/pwm-tegra.c
index 5cdbe12..b68b690 100644
--- a/drivers/pwm/pwm-tegra.c
+++ b/drivers/pwm/pwm-tegra.c
@@ -314,6 +314,19 @@ static const struct pwm_ops tegra_pwm_ops = {
 	.apply = tegra_pwm_apply,
 };
 
+static void tegra_pwm_cleanup(void *data)
+{
+	struct device *dev = data;
+	struct pwm_chip *chip = dev_get_drvdata(dev);
+	struct tegra_pwm_chip *pc = to_tegra_pwm_chip(chip);
+
+	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_status_suspended(dev))
+		return;
+
+	clk_disable_unprepare(pc->clk);
+	pinctrl_pm_select_sleep_state(dev);
+}
+
 static int tegra_pwm_probe(struct platform_device *pdev)
 {
 	struct pwm_chip *chip;
@@ -344,7 +357,15 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pm_runtime_enable(&pdev->dev);
+	/* Disable runtime PM before cleaning up the hardware. */
+	ret = devm_add_action_or_reset(&pdev->dev, tegra_pwm_cleanup, &pdev->dev);
+	if (ret)
+		return ret;
+
+	ret = devm_pm_runtime_enable(&pdev->dev);
+	if (ret)
+		return ret;
+
 	ret = pm_runtime_resume_and_get(&pdev->dev);
 	if (ret)
 		return ret;
@@ -395,7 +416,6 @@ static int tegra_pwm_probe(struct platform_device *pdev)
 	return 0;
 put_pm:
 	pm_runtime_put_sync_suspend(&pdev->dev);
-	pm_runtime_force_suspend(&pdev->dev);
 	return ret;
 }
 
@@ -407,8 +427,6 @@ static void tegra_pwm_remove(struct platform_device *pdev)
 	pwmchip_remove(chip);
 
 	reset_control_assert(pc->rst);
-
-	pm_runtime_force_suspend(&pdev->dev);
 }
 
 static int __maybe_unused tegra_pwm_runtime_suspend(struct device *dev)
