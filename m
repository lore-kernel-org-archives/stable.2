Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BFD2E401
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786170046; cv=none; b=HBr9z6jkbl3PvwDfiRpnJ/dY8TLAyjMXHablHFbVWqoQfMed2Hh6Xb5AHF5S1liy1AD6j5ylM4KQQOooUXQBOpknEiGbhKjthVoT3Zch6g5uHJxyOqER+jAK3lkl0xkQpgQ4SG19+n45UmWfF/nuwmvR3U0Y7IFDNAp5EYWSURA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786170046; c=relaxed/simple;
	bh=NFa9GnuhwXPiI5dsbr0iH6GqeKKs5mM+DrvDRZs6m+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sy5jDsMW668Y1WXZkdE/CI6hx3f3T3nAZSH73ljwdDa8vGtPgC5GapD4XuLN9ZX9Bhhr+8XnT9w0RaYiXLcLIAAMoQV2tIIjWVQKFr4WeD+RTy5kikxOao0gyiT5V/GzPXMfBsooERQ1JwtQ5EulmsVsEt25l5ILMVAywRdHa18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tNSXTqT9; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tNSXTqT9"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso299418a91.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786170045; x=1786774845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKhyMQrWu8wbOkY8L+PT3L5GzBtcKEJdYmE407RmSq8=;
        b=tNSXTqT9CbKWKs/wDBtSLwz0+nlWkRXicvAPiIz5cLdgNZ69bP7iMUFqMVb8Bk/2YJ
         cUAjnoxAc5W6LGgBsbTqbtINjPwfQ52haFxRyyMXFRW7H5JViff2kKhBmnVvUocCFwBZ
         UBQaQz9gzuj12agopbS9yMHpvIICNPcN3/q2i53H5Un09zpz+ZehEPaguqAAPWQiRm9a
         0lcSKKFKX02M5Nt8yvqp8DhJTKJkKCE5moG5lXyXQhuvUtsNTFlEQTu5T02mjnhi34e7
         qLmLOpKT299bPTQG9d45jv5e1lpdsVBfqowMAkC6oQCk/mXizKqMkTklETAj05XZXgHb
         qT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786170045; x=1786774845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKhyMQrWu8wbOkY8L+PT3L5GzBtcKEJdYmE407RmSq8=;
        b=YCHJwTOnu1a4k39VLoc0kRP+/rI8C3kEh91Fg0KOB/AUblbL0NIc8Xb1mVp6/rrdRv
         ox93C9YMPGNlcC+H2oy2DLWNf5uw8DOng7zb/NTnoY+0Oj9MzfTI0P0Q8ulNAtRjGzyj
         pN139sVl4sjHdnhU8rbkiaiWxW0Xt68uDfqWwjgVvinH/LvibrBrJoeSfg0Vq9Q2cfAi
         isyRmvr74fm6HFha0OmlohEdu9ZMLK2aFsWRe7LLlum/rmo4K6mXyexGfiYsJLAJkMub
         Ickc/GwNKEK7Gl33p4CV4n2BD19psJdQwL6t4nMEPAFfcsoDoc9Ne9dMyBpR1gofGHeR
         Xndw==
X-Gm-Message-State: AOJu0Yy+PIMbhCZvafxkXlLbJ2S/EQa0dwxSeyufLpxQhlzL7CqCbJiJ
	JdQsHb2QL2nv+nvKMxKSIYID7aifDooYtxhNd28yhDwjadjAwbTTkYVy
X-Gm-Gg: AR+sD12vNGIrCJUj2TSuMDbVFC0cw4zBD0ahwQzbAYlm1JOtGbgQ1ASgTRBAgD0Tnhq
	jUJhPrpNXdbLaLM/SINKOyf0I38HeqNrhHPFOXYde8IgnFuNncDzyodCieo7VqtnHg2JCMkefdN
	qC2JY8DhGWyQMfgd7xJjAkNZ9A3v8JAiyKDC8jbgrQeRKX1orvpMCtMFzr+40BkR1eJQbkvGMsK
	tNi4wrqtI5NSGSFkiypsGqClNnJbjYsDrYDoMd8G0MzsABu+BpuPk9MUrj/dF678E/H0qD+2X4G
	mTS+D5ahPRkjEiahCnqxK2r97kOSN9vQHLhXdfyNaSvr6OSwND0z92i7Z0GzuQ9+vl1gFiTzpgp
	n5MW7nsHw+CnENQaALc/SBM+Q4H+qNDqpZKVglb8p1KJCkAHZ4ScS3d9C7i8m6f1CIeTNC0enKh
	k0P93nvnt4hhmhmejyk9yez2SgXeWsiAiojs8cGToMDNHHfx94bhc=
X-Received: by 2002:a17:90b:3a10:b0:38e:70d5:b12d with SMTP id 98e67ed59e1d1-39261fbc353mr9787630a91.6.1786170044921;
        Fri, 07 Aug 2026 23:20:44 -0700 (PDT)
Received: from lgs.. ([152.32.133.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6dab4sm4996353a91.3.2026.08.07.23.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 23:20:44 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Andrey Skvortsov <andrej.skvortzov@gmail.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Maxime Ripard <mripard@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] bus: sunxi-rsb: fix usage_count leak when autosuspend_delay is negative
Date: Sat,  8 Aug 2026 14:20:29 +0800
Message-ID: <20260808062029.2597581-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sunxi_rsb_probe() calls pm_runtime_use_autosuspend(), but
sunxi_rsb_remove() does not call the matching
pm_runtime_dont_use_autosuspend() before disabling runtime PM.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during driver teardown, this reference is not dropped and usage_count
remains unbalanced.

Add the missing pm_runtime_dont_use_autosuspend() call before disabling
runtime PM.

This issue was found by manual code inspection.

Fixes: 4a0dbc12e618 ("bus: sunxi-rsb: Implement runtime power management")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/bus/sunxi-rsb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/sunxi-rsb.c b/drivers/bus/sunxi-rsb.c
index daf0ea563e47..cd4c857756cf 100644
--- a/drivers/bus/sunxi-rsb.c
+++ b/drivers/bus/sunxi-rsb.c
@@ -815,6 +815,7 @@ static void sunxi_rsb_remove(struct platform_device *pdev)
 	struct sunxi_rsb *rsb = platform_get_drvdata(pdev);
 
 	device_for_each_child(rsb->dev, NULL, sunxi_rsb_remove_devices);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	sunxi_rsb_hw_exit(rsb);
 }
-- 
2.43.0

