Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8532BE7A7
	for <stable@vger.kernel.org>; Sun, 13 Sep 2026 12:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789300960; cv=none; b=Fcrx/UtWWeZ5FYw4af6f/YD/b9nWSD4qVgbmFWCwa21B4j83/VOJgfOO8pY8oJzbWoIMAvkUrAV51lrYlki/+CVpPLAOturGxDVKI0cIbmsK4z0QjFHCpQxuLOVFIHQKXDStXP2WTu1Acmx/BYhk8EwDzeT2lDHPDv06NWy4kFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789300960; c=relaxed/simple;
	bh=mL9fNglYsSBvG//gsuivigf3fT0Ig+s5Ce4nrXosrxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ksfPqyjxChCB+hPqMdNQXnvB0X+RR+Q4SRJNyVVgyRmqsaH6YM4un8VeoAe4/9X/Z77g8rwtQr+eA/ijHLIWCwFIrJKHKhiN3FfrFoZzp2hIriKdW646D8whvhMgBoqW+5coQSUaxk8fEHc7GRyV+pjwh0vQQ57KI4zV2HNIZXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pps6kOBX; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pps6kOBX"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91c22d27dso4715795ad.1
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789300959; x=1789905759; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dZ5JOsCZ04J11iAGe8msFZoGQpgRKm5XQ0vjKi0ufM8=;
        b=pps6kOBXgjgktfbjeWsZsfWvMadI2JM+QKzeJ+3lUrSVVGa14nXhHEQiM7bk3WS6wa
         fGRG03vq/OQs+61qJ0BlWyNsIb6ZN29hYz9yk3qaa6EItYFdm/0uD2LloyCbgGS6HUxH
         UDky9gnfRCgMHxACrEx+l2J+W8Xr2lAWz+NO7N049cHY5EhW+YGGw4mv96jr9Bvz89d1
         hqSTIuCn6x02p1SZ6txABP49QJQLqSBIHbw6x9A98v2ZkhE7InDOkJ5UbM7F2TDe/A0m
         heYamyWLigRyFqoMF6LaCc5dIt66I/vTF+GFxBUJUHSYglgz34xe2l5zECaHyfcgBzxs
         mdug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789300959; x=1789905759;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dZ5JOsCZ04J11iAGe8msFZoGQpgRKm5XQ0vjKi0ufM8=;
        b=kWusx+Xtpiipxeow7atvuWqZT46ZaLFHiYA5P0rSUKUPkMui55muPrf8xQYrS4Zd4x
         Si8ieXcR8arwFuphqBM0zf2OEJuO++diiZ2jtVBqWHBP7+HoI+4zZCC2bwX6F7AmmPWm
         pc0pP6QICOcYfancn4qCxGg4OAvpGTCJgMJfg+bi2q0h4FVzQ2b2717SpEF0Bl2qlA8p
         BemT76bnGxhC1zH5qmtuvnS4B4dqYj3wSkD7w8Z7AOzcc03e3MEViW4lHUh7fgy1k57r
         /Sp/+fPNYBBVEgPP84bXg3ZnOuCnstZq3wE8paC5j7XzUoWtsfJuQrNq/XWLj+A1Of6X
         xYvw==
X-Forwarded-Encrypted: i=1; AKwUvBy5d6SD+d4PrXV5vbcGTV6zNTTHXr7mqd2X411v55VDFNXlvZOtPzdAqMvvAnyvqCqBcppI4co=@vger.kernel.org
X-Gm-Message-State: AFuF++lN0FI27e3TC1U83/cxKuHDIWD/VNzlJsZav+40jCvO7IWNzutl
	nSc5HBhj08YtNh/DELiPRLvJaoIWW6vYZm5tY/bsX9MK+DHxfg9gTjfO
X-Gm-Gg: AYBFou2EjTpltTWqRaOFXmeX6PZ9Ku7JKibL02sNeGEBzFQ8WxTmhdJ02XEDVC+5dC9
	sHBUdRgDUYhyyQqW0xVqmyWhgT10YA4ZUdrzUmj0HrAZWynzb0hOxfwEXbxbxd1JzaoAEwIqVTu
	oMB1DN4JORyH2Cv1BZJN9eQXqeu5x/2z3/jlczM1PWQBpnALkQZjUqVvEMkl4N7HAM95FvumgUw
	qubGL3g0znrzuevv2wSgQ3dKxu+tUNw52lbhpLLmniSliz//k+0fp3A5XR4ykXtbwsvjZHadh4p
	EXyT0VHdW3hd3JmXDVnoe5SMQGbRTibnzTytOLKPwhni5lLZ/vO3P91K4oH7OxLdCjMUqPhviQ3
	+vZua4tG3CLwAcqMo6IYNCYk6A75xCosv5cVkLmLLlQL1vlRkle4e6otTx9DaKNmmN4iPo8QJe2
	4eb6ei6+ufE3kcUjCBSumkYwHBnz3v0butync0zW2nQV/EyS/vNZ7dYOY=
X-Received: by 2002:a17:90b:52cd:b0:398:b426:ca4b with SMTP id 98e67ed59e1d1-39dbc6ef551mr12049002a91.22.1789300959024;
        Sun, 13 Sep 2026 05:02:39 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd3e2dabc4sm27365725ad.19.2026.09.13.05.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 05:02:37 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Dmitry Osipenko <digetx@gmail.com>,
	Ulf Hansson <ulfh@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] gpu: host1x: fix runtime PM reference leak on remove
Date: Sun, 13 Sep 2026 20:02:27 +0800
Message-ID: <20260913120227.1559129-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

host1x_probe() calls pm_runtime_resume_and_get() and intentionally keeps
the runtime PM usage reference for the lifetime of the driver because
host1x is not yet ready for dynamic runtime PM.

The probe error path drops this reference with
pm_runtime_put_sync_suspend(), but the remove path only calls
pm_runtime_force_suspend().

pm_runtime_force_suspend() disables runtime PM and invokes the runtime
suspend callback when necessary, but it does not decrement the runtime
PM usage counter. As a result, the reference acquired by
pm_runtime_resume_and_get() remains held after the driver is unbound.
Repeated bind and unbind cycles can therefore leave the runtime PM
usage counter increasingly unbalanced.

Drop the usage reference with pm_runtime_put_sync_suspend() before
forcing the device into suspend during removal.

This issue was found by manual code inspection.

Fixes: 6b6776e2ab8a ("gpu: host1x: Add initial runtime PM and OPP support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/host1x/dev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index d2c64728f804..bb6a1647e4db 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -729,6 +729,7 @@ static void host1x_remove(struct platform_device *pdev)
 	host1x_unregister(host);
 	host1x_debug_deinit(host);
 
+	pm_runtime_put_sync_suspend(&pdev->dev);
 	pm_runtime_force_suspend(&pdev->dev);
 
 	host1x_intr_deinit(host);
-- 
2.43.0

