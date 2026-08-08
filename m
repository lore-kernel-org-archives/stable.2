Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6843B2AA
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786190499; cv=none; b=rU+ipbU/kmR9wTcIiL8c+0AIsiytOwTUOEH4smAizsfnZ2ZWpwuFBldYvcrQchQYWzLlb+h5lsOlg3KLFGnARG1vs5tFck/BoxGWu2U1tTlCpYSZJ6p+M9ZQRnKr7RrQvni8FXHvzA+G35uDd8NbufOK/gTYbvo+GIhWJI5t85c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786190499; c=relaxed/simple;
	bh=VdKmF0MAy9JnfTs0lWJz1o9FwtWgy0AQWX/cZmeJ1i0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nfj9yDmJ5TCxt4Hgpq5ZeLGhs9ZpytnN8MAHIR0rQOuAzAmXuzrtFWYk5zZBcktFBFZURtugCZsyn8XsY+ngfPg61BVGlfBxDf83sjfvVwq1AKspy2eSaRVxdhrggC7632jNg9YduAy+3vtfN/I7NUeOohq5xhIILqOsFPGwU28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meotUP5x; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meotUP5x"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d004f135b1so5006185ad.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786190497; x=1786795297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=K/VDwU6YKDYusuf3bOyqkfoe3Kms6rSYmSwfDWd4AYg=;
        b=meotUP5xW9HTCr6QK2vUhrYpiZ1EFmoLxKYtRrahu1TkqLv5+VqSMK5iA1h5Jneceu
         5FVNZKjkwoYTYTLnwrHb4mhADXsDuplAWFbtJSmaNx6k9+EfYRk8RkQTNmrtD4o8HBON
         cnl+7BMWdEzh+vIQj8g2NhD2j9iECkDMoYdugWvfZfAMqdDgx/QTct3bF5bFqHVudtbH
         IChVsTlm3c6Nt/zEgCLwLEpAfeYR9zPAqZiAZiUTHgLUl/c/Axt5S4yBzE19uNIByTH/
         2+DuyLGr7oOJ4J0IWgKI0gAyBvMNo/cZOSvL3e93G6Dm3+eRgfFqsuXF18//Rl5zWBUN
         iFIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786190497; x=1786795297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/VDwU6YKDYusuf3bOyqkfoe3Kms6rSYmSwfDWd4AYg=;
        b=CoNYJVI9w2+x1ub/PnXCfw/4rXzVz+lYeUIZYqJfs+c6kHXjgzF0uhZxiQe4wFYNB5
         K+0TQy8WeQsryUnhYbZQS1FqVaUrstICzOzYjcLnC2Ta0GwlO3JO6mrj1KAwUBRHhORl
         VyutDuVChARmLMzBHmsH7/gN0LJ4QIOpZJfFxhEXpCZmmUHNeOcNQYFlpralmlf97B67
         jMB3jFVB8k7c5dyHci6MWwATvJIFJpgkn2ZL79TK4KlBSJ7hbTCUWuxnw4Oe0gqkYzyX
         tYe62S6eAOut3c1SHPHZ7AvQsImP0ZLPGGSRx38mrUO0OG18f/9NMvCgXzyApXEoAhB7
         pqsw==
X-Gm-Message-State: AOJu0Ywsovj57W9pt0Zyp8nHGEQupxSof30+sESZ9eW+xIGpbl3iyy+y
	hyvBt58q0/EWc5XIDaWe7yNvk8VQ9DGKnEwlkvobYybLJnsMjhlU4gN7
X-Gm-Gg: AR+sD13kOV8VlyqNRaoOM7aFMTPbExO0+QqYjR2JWWgrMmgyVUqlPPagZOOJWp0UpYW
	xno36NUV+C9q/YyY2LWd/5vh2Dm7wE+b2DGKhKsZ3WgI7w4TSuJQJE5b/YaRgElHVh7ws/8JUDo
	W6zT9oyINIBlcukBgvXn3SFnQONsApnJ0kjMzPDna9/ytU3K4mPrvE7KcwQfobHLHISm+YLzc3+
	9dCwH3+NclFKB2Tt1Qk5aywNqHiNUGVdV/XkIxrXbydEOCYdQZVaBPD9bDUF5R0NQkTLpJFke2P
	wFJycMtqRj+Mn8cWBCKhHPJF2PPFIvWGEZEToWEKSl0qz2deYIlGBuaZoncvJr2CqmX1yB8KYP5
	O7j88lnEtpxjFZ+GlTYpUJT2LwH6U7CCYhs7npEiMH7YQehwVxG6p58qVPyfuJtUn8gpdfdeXbY
	78WKnSCFsC+QE3ccayfLFz10plRKtE6sD1sMvbNMfv5SY=
X-Received: by 2002:a17:902:da87:b0:2cf:4c0f:5129 with SMTP id d9443c01a7336-2d0caa03fcfmr299424925ad.17.1786190497182;
        Sat, 08 Aug 2026 05:01:37 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14dbeaa88sm18073605ad.39.2026.08.08.05.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 05:01:36 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Frank Li <Frank.Li@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Abin Joseph <abin.joseph@amd.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Kedareswara rao Appana <appana.durga.rao@xilinx.com>,
	dmaengine@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] dmaengine: xilinx: zynqmp_dma: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 19:52:28 +0800
Message-ID: <20260808115228.2798481-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

zynqmp_dma_probe() calls pm_runtime_use_autosuspend(), but its failure
paths and zynqmp_dma_remove() do not call the matching
pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
failure and remove paths.

This issue was found by manual code inspection.

Fixes: 64c6f7da8c2c ("dmaengine: zynqmp_dma: Add runtime pm support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/dma/xilinx/zynqmp_dma.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/xilinx/zynqmp_dma.c b/drivers/dma/xilinx/zynqmp_dma.c
index f6a812e49ddc..635c3f6cc5c2 100644
--- a/drivers/dma/xilinx/zynqmp_dma.c
+++ b/drivers/dma/xilinx/zynqmp_dma.c
@@ -1116,8 +1116,10 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 	}
 	if (!pm_runtime_enabled(zdev->dev)) {
 		ret = zynqmp_dma_runtime_resume(zdev->dev);
-		if (ret)
+		if (ret) {
+			pm_runtime_dont_use_autosuspend(zdev->dev);
 			return ret;
+		}
 	}
 
 	ret = zynqmp_dma_chan_probe(zdev, pdev);
@@ -1152,6 +1154,7 @@ static int zynqmp_dma_probe(struct platform_device *pdev)
 err_disable_pm:
 	if (!pm_runtime_enabled(zdev->dev))
 		zynqmp_dma_runtime_suspend(zdev->dev);
+	pm_runtime_dont_use_autosuspend(zdev->dev);
 	pm_runtime_disable(zdev->dev);
 	return ret;
 }
@@ -1172,6 +1175,7 @@ static void zynqmp_dma_remove(struct platform_device *pdev)
 	zynqmp_dma_chan_remove(zdev->chan);
 	if (pm_runtime_active(zdev->dev))
 		zynqmp_dma_runtime_suspend(zdev->dev);
+	pm_runtime_dont_use_autosuspend(zdev->dev);
 	pm_runtime_disable(zdev->dev);
 }
 
-- 
2.43.0

