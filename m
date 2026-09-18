Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B37E35AC2C
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789702234; cv=none; b=mBEnLthe1+q2MSy5W9mfh5+3eHAq4uYhgdP+o+Jm2kZJf0wA4GdaM0fcrpgB67gjXWXKx5+1+ddPhyU+iVFX888pnsc5YXJPof82w1DJ3vV81rEhB72LH3f8Wo1JnlSS6Bi9kwX5lolpPJBq+1bxMaMLIBkEgRoAXitbDVFEueU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789702234; c=relaxed/simple;
	bh=oL7iBYRGTXGLUYEI615o03nOb0m0bTLF3HdlXZTknbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rhjze0lDQgMJHShKUxyqyH+jvSTL46XDJXv1iWGokcxuF8uVukrDQB0gN68yGVxCpfe6teS1nObfphdkVsVn6fW9cka0IMAtAcWQd8gEsToF+AUvHepcOvBhxp6GpNfoNv9fRBIbbty/Kt3vorQvaSKAeSuoTdNksFGX0SZYUik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mhkmqi3n; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mhkmqi3n"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-39647184c73so1230269a91.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 20:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789702232; x=1790307032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NsTXXf0bosmROP35BjT3pvO2TNvWL1hxMB3vfvtmPCY=;
        b=Mhkmqi3n/qPy4geBhcotXJHzyx2Es70VcFh2hL+VhOw/XMh+f+hDb5mxtWhGN0XO0s
         bQvMZG6gHxAEMcxBe/kjtedQ680T7cMj/xeYppEoWDZLDFdehcsyoIQeoC5qwll8ac+1
         716FO/PcB52SwuwUl3+u48UZIQbLJyPJtkjq3xVzFYH34m7q0YGVoXGQ5jN2w/C+qpq9
         CCAAbmPZos3NCYYd48Qn4AmVS8t5vjT/l1IEoNO1f8lRsd655QyoM0fJkV4soOlxeQkK
         YF01lYpwfVQA6BZI9oXZOnyqoDphQrBLAWFsMNQXe8Ek0T0Tot1ykXSdZzCl9xoS8yxb
         CkDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789702232; x=1790307032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NsTXXf0bosmROP35BjT3pvO2TNvWL1hxMB3vfvtmPCY=;
        b=KO1XPeK0lYMZlQoP2Jp57jcnC1DSCWi5IIpLurw6/YHs0jhzPMLheZc0FP4r/ARl/6
         Xs0x5jqAihA+vhVt7fJEoI4qmfl6Q1c1nTu0F6D8lia+j/ptICnSjSzliD6xO4IuuAM9
         0URpz36eXSbOzqzSH/YD1Bs6U/LDsxEPMIGlgMDuOhFTBne4jqGTeg4gv3qBnb8tD+AV
         ei0nAy10bjIf3gR1Fq5nErFdaplwiXlF8dJzqaxjHnRe6piOJxc444Ksj1G/WW88OyWE
         WvTGHe2ZXNBqhwPQZ4bOI4hn40D2mdyTXUy6TCbqRRk1rVjmPT1G+puB5yeFOKXqsofD
         909w==
X-Forwarded-Encrypted: i=1; AKwUvBz4wWluS7tL80XB+RyOz9jWA7+adZw60/WqD2PMDRWu1hd/lWMWNz+D2t8elYqlo0ocgs9VhM4=@vger.kernel.org
X-Gm-Message-State: AFuF++lnT0QE+DP3jx5wxSxh/YkBtihY/r1I7Ytwhnoxdk+g4sVzrtk1
	YVKMPOqmVjs+/QQ4URnEoSgOiuLJSKl0OOodeaEalcffNdq8pdjZJ7Et
X-Gm-Gg: AYBFou30Hb4TOVFxKLvJjVLgqzYXuCcljGtkKDdSFB8PxPLsZOm/agbWZUSmybQrUk9
	/A4YIopkaqnmSyBgnZEvlcl3r++cB1ki0jKor+fL/VmLQah/4+FgR5KKe3+ym47s/Gvz6dBG1+z
	QVFmHY5PT8VtS9S+3gJ2DhMdIEXRB+qiKyw+0DpBCzKT7gZROheE0oj0TfUD7ISQRWGvytm3DTI
	/edVEz8rm8Yna6MbJWAW7VvwW5U9xPxiieec9DBuBNo0PSuFVIv2bX3GOeY7xbP3atxRGhKdOBR
	7M2jb3IsuHVxqNZAZPelv95fh4Hj4S5Tjo6bj5b4qiOa+yVgvatWkilTFotqx1jrvs4JDoYbB2X
	gjZjaanh91w+xyCYzTcTstr9ZUamdL0KSMktdXHFTrCSCV7cuXxQiNaBsaufbp9eDR377/rmm7w
	ONv/NA1XMcHPA7M6nK8SR+yu19U8SBRmuKJIr8O+BoAxPT7JZQWiP9Bw==
X-Received: by 2002:a17:90b:4acc:b0:39e:5ba1:ccee with SMTP id 98e67ed59e1d1-39e5ba1d12amr457366a91.24.1789702231551;
        Thu, 17 Sep 2026 20:30:31 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33c2874bb0csm613271eec.16.2026.09.17.20.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 20:30:31 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Ed Blake <ed.blake@sondrel.com>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] pwm: img: stop using autosuspend on remove
Date: Fri, 18 Sep 2026 11:30:17 +0800
Message-ID: <20260918033017.3441183-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

img_pwm_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe failure path disables
autosuspend again, but the remove path only disables runtime PM.

As a result, the runtime PM autosuspend setting is left enabled after
the driver is unbound.

Call pm_runtime_dont_use_autosuspend() from img_pwm_remove() to undo
the setting established during probe, matching the probe error path
and the runtime PM API requirements.

This issue was found by manual code inspection.

Fixes: e690ae526216 ("pwm: img: Add runtime PM")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/pwm/pwm-img.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/pwm-img.c b/drivers/pwm/pwm-img.c
index 91e0b19f0c08..c0747f5e0020 100644
--- a/drivers/pwm/pwm-img.c
+++ b/drivers/pwm/pwm-img.c
@@ -339,6 +339,7 @@ static void img_pwm_remove(struct platform_device *pdev)
 	struct pwm_chip *chip = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		img_pwm_runtime_suspend(&pdev->dev);
 
-- 
2.43.0

