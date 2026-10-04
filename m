Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF99D3E51D4
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791085182; cv=none; b=oakFNi+fkH/Li8+6s5N88xuLI9P+EMV1IYAmnXP1cO4Xf5KK8BhgDd7jQDfRz1R5ffBhyzLcbndSPtmUdn4FhEztdJf4o0oQqeHB7dOMVQYlczxzI4l4OA1uUJ3mEhiu5r/tBd/UpmshCUnPtjdJNcHPxml/Z3jgkHUBZPFx+VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791085182; c=relaxed/simple;
	bh=z95tIApCMgMzMQtaz0iwv8U5sDTYv5+wpk5hvmgAC+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ghphUo3xWuQIu59dTsvZutT+dDiKRlJBGWvnEDaltONUfqACsR2YEds3CBnO6Z0DPYSi5QGYviCmm4W+qNB8sjMLdxz61oLIV31Nnob87JLM/EKbHJ0brEUcaDa69yLzlv5EPT+5NQloQqS9zZvX5Rat6jUbTMM14iT02hq/QyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSoyEAOu; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSoyEAOu"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-9142e83204aso9896156d6.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 20:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791085180; x=1791689980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhk8BTSKwUwdy5UN+oAwyMBlhIqn2OVRwoj4KbDLpxI=;
        b=HSoyEAOuPl8WAW+P/95zsfIYZ3QPgejpHgdl3FnvsIaX9xccc+H2Liuo2hTPqlbxSX
         erv2zjQKSjPsx2W3npxOPkuJwJdanzKtDf+mKT99REO1XZSnfHmYhx8uhQD/H6jbI+uc
         +26FudofiA5xK7wMsQNp10fpjPZT/MLA1BlJIW3b7V+LKIX5106JcM4EVqJ1Xmfgtbui
         jbZP6Nb7XwaLOG0vWgQbqYWDah00rMWY+m1WgkF/XIFTlHkARJIH0LfnQGkL728B1LT4
         kWmWtw6QZrdDEUodtkNBfrXUgnB7g2/Ejwu5N+lU94Mx7cB3Hy7Zsas2tORjhlkeQclw
         Sw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791085180; x=1791689980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhk8BTSKwUwdy5UN+oAwyMBlhIqn2OVRwoj4KbDLpxI=;
        b=eZ1NluhCFk4ocDTolgbWrb+DmDFI8uuYneA2ZU1On6oudNFC+N2P6Zm21IjHE35QRr
         hPa2q9how3p0cZ4S5fuKtujbGoljzgnEhRkasSWP6UqN/rXISaei+usYjaHYpY1rrWPQ
         7XAlEOycFeI57l/DLMUU5bi+2uwSf05tZ7ZIRdutxZuc6ewCBaVdlRWgIlyBwiJI+zYm
         u5LJWnA36ug621NOJWekSRlxjGjlNXhcKtnqAampG5KEfrHe+8bD2goqz9aNfH1kqfvd
         ZxbMcW+LX9OHgqv8Fls8kefFby+X92RYn0CHmJrBcdMZdKZj6jwE4uHFvl8hpVxYLXh3
         N1aw==
X-Forwarded-Encrypted: i=1; AKwUvBwddl0gLD74svvbailmY1WSCmZGR2RID/4+5yMLodUjxaj1QWHXBajTAXDirgslKqBaxrIYEvo=@vger.kernel.org
X-Gm-Message-State: AFuF++kKez4W9FFdV47YrsEAFKbsfTALM+YiGYJEYp2w7hXruu4CsOli
	1nkZL15el42tksYe7sLIwrgufTTMgzl3eaAG2gBzf+3mSIYrk7RBdQ0=
X-Gm-Gg: AYBFou0RBba8QhgwFUp4ayvlvJUwQH+Kk5O5JaP4TzsfsEUytm2yN43sxTN0pw0wkly
	a/rXa2Ev5NQQ0prJ42O1ywcDip86ttPKxFvS30NpZZYh0SXLFhiUnJJJG/DPMzrMpxDuzcQ32pf
	9Snk82MhgdASkojghPXpngkt+ufp5FDNUbPwn3m9+aUg9/hvxW7PkOrmwxyFh6P5ivAOykS6agO
	WjCy/AuHAz8oYfcvGA54hK8oxiLaD3nIa8qydFman+jXR6ARDBVu5AuqP8XatIOWZnegVjblYLj
	XwhOpR51YaQSTosqZWlFv4UArpmYSi6mTEajyEmgGGIxqTwVyE4QWsg1gAw/pxm9ZU6YodidhNl
	UAbsWtABIDCOLXtTcbZepe65PJCXA7zQI0fhGb0F4vgKZQmbdjVjvYi1rd5Q/O91cadp/wK5qrM
	5vEEYjT8CwIGNaAQJUO3aSRD2lu70/vA9Ia3J2Vf65uQ0KzTYGZBXVj20eK4sreFOl2jUDqKnjr
	fvaGQL+eWhZt0hl7Fs5SDPZ/BqplrAcKMlwQmrhVjEs5WPaUPGcceiAVL63C6juF9xxNJQnU1C8
	ypPMbp+4HO+SiCABg6NPSYU9FleL
X-Received: by 2002:a05:6214:85c5:10b0:917:a7a5:af08 with SMTP id 6a1803df08f44-917aa303f2amr145553496d6.25.1791085179220;
        Sat, 03 Oct 2026 20:39:39 -0700 (PDT)
Received: from i4-gl-tmk5904-1.ad.psu.edu ([130.203.156.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-917e0c11022sm57924096d6.41.2026.10.03.20.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 20:39:38 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dipen Patel <dipenp@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	timestamp@lists.linux.dev,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH] hte: tegra194: stop IRQ before releasing provider state
Date: Sat,  3 Oct 2026 23:39:35 -0400
Message-ID: <20261004033935.1114168-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Devres unregisters the HTE chip before releasing the IRQ. Disabling
the controller does not wait for an already running FIFO handler,
which can still call hte_push_ts_ns() after chip->gdev has been freed.

Request the IRQ with IRQF_NO_AUTOEN after initializing its dependencies
and enable it after chip registration. Add managed actions to stop the
controller and disable and synchronize the IRQ before unregistering
the chip.

This builds on the linked slice-lock fix in the HTE maintainer tree.
The IRQ lifetime issue was found by static analysis.

Fixes: 09574cca6ad6 ("hte: Add Tegra194 HTE kernel provider")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20260830161747.2719220-1-runyu.xiao@seu.edu.cn/
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Based on HTE for-next at 30167fadbf87. This IRQ-only patch requires
the slice-lock initialization fix:
  1329abe1bae4 ("hte: tegra194: Initialize slice locks before registering chip")
already applied to the HTE maintainer for-next tree. The same
prerequisite is required when backporting onto older trees. The
diff also preserves the earlier IRQ logging cleanup c21530a75b95;
older trees without that cleanup need its context applied/adapted.

 drivers/hte/hte-tegra194.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/hte/hte-tegra194.c b/drivers/hte/hte-tegra194.c
index 189f7fcffbe2..9fb16b6be231 100644
--- a/drivers/hte/hte-tegra194.c
+++ b/drivers/hte/hte-tegra194.c
@@ -799,6 +799,13 @@ static void tegra_gte_disable(void *data)
 	tegra_hte_writel(gs, HTE_TECTRL, 0);
 }
 
+static void tegra_hte_disable_irq(void *data)
+{
+	struct tegra_hte_soc *gs = data;
+
+	disable_irq(gs->hte_irq);
+}
+
 static void tegra_hte_put_gpio_device(void *data)
 {
 	struct gpio_device *gdev = data;
@@ -854,10 +861,6 @@ static int tegra_hte_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 	hte_dev->hte_irq = ret;
-	ret = devm_request_irq(dev, hte_dev->hte_irq, tegra_hte_isr, 0,
-			       dev_name(dev), hte_dev);
-	if (ret < 0)
-		return ret;
 
 	gc->nlines = nlines;
 	gc->ops = &g_ops;
@@ -913,21 +916,33 @@ static int tegra_hte_probe(struct platform_device *pdev)
 		spin_lock_init(&hte_dev->sl[i].s_lock);
 	}
 
+	tegra_hte_writel(hte_dev, HTE_TECTRL, 0);
+
+	ret = devm_request_irq(dev, hte_dev->hte_irq, tegra_hte_isr,
+			       IRQF_NO_AUTOEN, dev_name(dev), hte_dev);
+	if (ret < 0)
+		return ret;
+
 	ret = devm_hte_register_chip(hte_dev->chip);
 	if (ret) {
 		dev_err(gc->dev, "hte chip register failed");
 		return ret;
 	}
 
+	enable_irq(hte_dev->hte_irq);
+	ret = devm_add_action_or_reset(dev, tegra_hte_disable_irq, hte_dev);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, tegra_gte_disable, pdev);
+	if (ret)
+		return ret;
+
 	val = HTE_TECTRL_ENABLE_ENABLE |
 	      (HTE_TECTRL_INTR_ENABLE << HTE_TECTRL_INTR_SHIFT) |
 	      (hte_dev->itr_thrshld << HTE_TECTRL_OCCU_SHIFT);
 	tegra_hte_writel(hte_dev, HTE_TECTRL, val);
 
-	ret = devm_add_action_or_reset(&pdev->dev, tegra_gte_disable, pdev);
-	if (ret)
-		return ret;
-
 	dev_dbg(gc->dev, "lines: %d, slices:%d", gc->nlines, slices);
 
 	return 0;
