Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95D37B40A
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786199074; cv=none; b=R2Y1s7oVFKIwVqswOboFlwZd09QoEmoCYOc4PeMp73sTmwfUzD6hvmYOZiJW7JWvWKob6sFwyGJ2XapeYNZf9+q9tc8jFAZIWIUv3JrSOJEzi7Eonc9MJB7H/A2da/IdaRDz2Lju2wdOjwAEx4ZBkunO7LhqIqwVjizM7zqpXd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786199074; c=relaxed/simple;
	bh=av6XO+17J96c4SZFz2NPpPHSbOVHbpxI8Aytmo7MDKY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ajMIU6yS3KQ3UwhlDkM8oozHSzEvF62nwviPveZMgAw+GgktqIVormj9VOgJXqHA+0zf5rXXZPWTgy3CRvSqpynNf5rvTTPgKlpml67fAVwRrF+XBvPqzXPtW+70nuU0IHQO+M7GTCx607zXC+Aud9E0q/O8JlQgbhHDM1zGIgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuLI4R2+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuLI4R2+"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-383cb94f742so455695a91.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786199073; x=1786803873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BxpSzB8c18EmT5JtuB1eU+b+G1XkrOHh1hT/Xfy0Dn0=;
        b=EuLI4R2+jXlzcYCPMTO26NwWbpWmsNTf3GHgPXaUue8fDV1jRKSAf/p+8GX9Ud6t/P
         qc1B4oSJVv6NL3n4RwuPTMbfjJL8X0Rr/5iY17TtDPkVDgt8DFqmWikQ7gbzeoyjfcx0
         PKhkm4W88o4kS17T2ZXlz0gZw56iWE493hlbOVrNT18ydFaXhn/yZPuPjBVDxrMB8DQl
         MzWaeGzhvdqM/QvBko9E1h+BTu+3pW1Dr+2p8lf1C1yUvoYAA5wkn3HgxP9F9XbY6gXC
         pRn+iHG8a812XPnAE9BjWIwGnGFji9tYlEfDQz5cI4Y5ybq1Z4LfT9ZNiaHlm0PmCGH1
         NVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786199073; x=1786803873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BxpSzB8c18EmT5JtuB1eU+b+G1XkrOHh1hT/Xfy0Dn0=;
        b=Dvpf97hyf2aSot9/CjhMUs1lh9EWRL9mYdfQseRLSVtK3r8Q+vBdlddotl8/Nm79v9
         XKy3CUxuruMCjbXg0s4N9o5fwyv6uUckC/pIDdNgAQkVf8m5gcbI03XOBTNLw44zs3sp
         wWx0uBxi4TfRzFAnHto5IUf7Fm26ZobCCAJ5drhHUbOTobaxwP5Ko2+ho2z2b6sY7V88
         MIdkLIVQwpg9zPY6b3ljRe8SjDgl6h1zSNxqtBMbRrtaPIqZqVvR8Bz7Itla2EO/Qs2A
         dEGMmzfc3Uxmvw56GkdcOvm+CeEj7TJUnmIypIa+fA4H67ywtIt3KPvnOuzTirXqHiCZ
         qFZw==
X-Forwarded-Encrypted: i=1; AHgh+RoXcAL9xolZAZ/N8PU4JUrpJpiRGd7QoSUhG6oWeP2NSDhXyKBUrIU7ZPqRh+evFK/Wwq8Ez3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNNCy5Bis4J3SI0uNVKoJstnEsJda3jY7tSqrX+cugKoqOHFSh
	qJtOuGLS21Gw0oYAt80G5mx4MaNnaEaMNNJ2usCDT82u6HrETn1wndBm
X-Gm-Gg: AR+sD11Yh0W3D17jGGiYG9vjEyCt7lHYcXGFQYHH3/z1O+hh9Rr7PkSBb3wqJUajKS7
	R6NrULOy1u3QwbX6Sw7MARdMhuPbkBxH2Zfho7tmrT6+ME4zxF4SZZTQAyfAcyabU9z/gB7KmRw
	SRnTCpzq4EuzwzyliD4n8iGH/SWzEe/FU0Y9mjNLaN+3QnyoutSL8PoPsXIOHkFmYXSxV0yVQs5
	+BV2Ay8Xiy9Wk/1gKKjfX6yORrkBzmWhVFXJPpiz2kLoduRZ4/VZf6s1TAMBzLO2acu5ixECvrv
	ZIUYzupry5hIUnm8tGAWGTnunQM9pFW0BmNfw7J8R1+kQn96w+FibXvvHZoXsXGoZQVPgqP2YaW
	XMevsfk0RoUQ0E4d9HP3XdeEhIvdtk40BQYNCJv9sSbXaMvWw5skQA/Kzcoapoxgm+LQ+ZrnR3z
	NCvzOPP7nn1LY4bQTL7INrAASeP2uauNIc8w9Mpsp0ALk=
X-Received: by 2002:a17:90a:d010:b0:38d:eaec:4396 with SMTP id 98e67ed59e1d1-3903c58bdd2mr30385694a91.11.1786199072815;
        Sat, 08 Aug 2026 07:24:32 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085f2b2easm8638206a91.11.2026.08.08.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 07:24:32 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/tegra: gr3d: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 22:22:16 +0800
Message-ID: <20260808142217.2893936-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gr3d_probe() calls pm_runtime_use_autosuspend(), but gr3d_remove()
does not call the matching pm_runtime_dont_use_autosuspend() during
teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the driver
remove path.

This issue was found by manual code inspection.

Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/tegra/gr3d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.c
index 1ec6ced959e4..5fd1fd32fcc0 100644
--- a/drivers/gpu/drm/tegra/gr3d.c
+++ b/drivers/gpu/drm/tegra/gr3d.c
@@ -534,6 +534,7 @@ static void gr3d_remove(struct platform_device *pdev)
 {
 	struct gr3d *gr3d = platform_get_drvdata(pdev);
 
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	host1x_client_unregister(&gr3d->client.base);
 }
-- 
2.43.0

