Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFAF3B961A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 10:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789986809; cv=none; b=BxgkEJCiRYnHJx9Ol8Qgd/e78TrJsPpVJtURyyvRhITz7vqmml1+pKHY7p2az78YIEvUurky3MhaU6DbZn50l5EZ+83lGBIWEA9aPzfp49pz9aOyovnSRiINoFREG9Eu1ckaFm2ZyLzaTog1S3Q9r10ZkSYmEBck96jdg+bX2Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789986809; c=relaxed/simple;
	bh=vAqYnvLkKIWlQwQLLe9/d73/xtPVyLjg+aHrIsasr+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyWBef4kvvfH64sEKlxzGzuPEfV00Nv/yhdMH9C7tdGgsv1T3fYaxoFb99O/MPnFobh2GUyRNWyyHIKI5RXk5L2HP2R+gIM+zPuqtbeAxe3Dhna2LtQM17V54tIpwgxAUYKrroYMLrw2D+3U+xYrU4DUzmUctgwDeWciUFA5iEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHS66SOs; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHS66SOs"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-398cb5615deso3304508a91.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 03:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789986807; x=1790591607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LOJu4MS3w9MQaaK/54wLQUMKD8EsXJhG30omKcb0Cl4=;
        b=iHS66SOsMQ2Qu36qffkUlw1wbS1eQyg4hqNnLpzwMBWv2ZNnOlAoo+HWeTDXwbQSpZ
         InfsBf39I6WBMSjjzyrdyC4rLw/A/EsHLDU+gHrnU2ef7iVV/HSsvY5ZgT1+wy8DKNTW
         e6FESBj+6tmow+0txylVlTfuXrNhGlB5MGAJyZLWKT6lEvKBh7BRqMI0Ytgr1NEgOmRQ
         ajJirAjdycEDQ1vMM4B/CFb3hwgc/ics/OJFqfa3Evq30cgB+oUg0qvQYQNS9YGJnpfB
         dxLyaZcntdbEdqmYNaOuCRi9xlX8SP3DIMS1YgWEdvxILlt+pdxSbD/x4ZKPGSt14R/j
         espw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789986807; x=1790591607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LOJu4MS3w9MQaaK/54wLQUMKD8EsXJhG30omKcb0Cl4=;
        b=ipTjo/E3TzONJsYk7Plab2Xm1b4M9j2ypaSicpnwmFgHlt9LeGWWE6fw6FFymRED9Z
         g7+82tndoLI+Slj7UcSq9SIvvCCh2A9VCX0ssSn3hB0weBirusCQRbXonHepFLFIBsgU
         PuLLNUb3vaRXILJ5HD5PR2f2qOsXSpuvWPzRFGRb5Lp+4cvDnbQUe7mfQr8jPxvAPPPu
         sAZ+tb3Iufs/uQCdO/nDrC6vAqn+nyGPkHC+QPhLjQIx84GGtpT4QoGR9zTyE42kXs9+
         dXY/B9oqyDKuGQH+CbGpE/lAMP+57FXKrywnYTHdWGz6eDihymRTbtPCvai2sUmKSTs+
         hvGA==
X-Gm-Message-State: AFuF++kceAybXCmEtiKJdxK9jivcYQw7/jE5qphODgnCdBsjqncZXERX
	EyoLXUVu5YeCRfD8W1BGZyyyzmD1bc4ckGfq26OSdU9FauCwOj64ZqFI
X-Gm-Gg: AYBFou1E0uwq7iX2qNE/pyol7bMOrNBSkiqBSD/u/q8TFLcPt6p+anu4NHxluEmCnZG
	oPPV/S+mSf9NHxiCKSijt2jbI2MmL+fyavtkiYCuIYP6wAGJcXlDpvjB/QS/fZ4iE2FQzuz9lrt
	a40fi7Y/ht3ocxTZv7n5wrXnWuClEV0EjqTY+IluWqcDzRWu4RFgI/GenuM3DIq28tWtn9Ah1PW
	YHLJ9AG8kNtFn/O62J7gdeMqpd+TLWgSadOSeFro9z5g1BdoSHC1a0aMfJUOUk9+4cNq0wGhOmF
	Ow7UAupWBskI/dIXs0SUaImwpX/Xt5aIbdUMLqlrGVb9FIbm2n+XzuNyg3q7LwWDbE/GEiYM8Yt
	1rOk0HqOlvfW6uMgVM1W0z2L6FaBuwXzBO09fD/DNbMv2JgjLR0LP1Zrs8QhVLYF6TJerXvelZB
	tjisxyiJNnzKwUSfpwh0yJlJXXxcrUH613h4OoSNfxQ5c47GHwrK0j7Q==
X-Received: by 2002:a17:90b:1b03:b0:39d:f254:4173 with SMTP id 98e67ed59e1d1-39e54ea5e89mr16601552a91.21.1789986807374;
        Mon, 21 Sep 2026 03:33:27 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a023e44854sm4994658a91.4.2026.09.21.03.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 03:33:26 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ce Sun <cesun102@amd.com>,
	Tao Zhou <tao.zhou1@amd.com>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	Brady Norander <bradynorander@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] drm/amdgpu: fix ACP MFD device leak on init failure
Date: Mon, 21 Sep 2026 18:33:18 +0800
Message-ID: <20260921103318.353216-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

acp_hw_init() registers ACP child devices with mfd_add_devices() before
attaching them to the ACP power domain and initializing the hardware.

If attaching a child to the power domain fails, or if the ACP reset or
clock enable operation times out, the failure path frees only the
source cell, resource, and platform-data allocations. The child
platform devices already registered by mfd_add_devices() remain
registered and are never released.

Remove the children from the power domain and unregister the MFD
devices on failures that occur after mfd_add_devices() succeeds. Keep
mfd_add_devices() failures on the existing cleanup path since the MFD
core already rolls back partially registered children itself.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: 25030321ba28 ("drm/amd: add pm domain for ACP IP sub blocks")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 9014678d75ab..be4d00ac96b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -318,7 +318,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 					  acp_genpd_add_device);
 		if (r)
-			goto failure;
+			goto failure_remove_mfd;
 		break;
 	}
 	default:
@@ -443,7 +443,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 					  acp_genpd_add_device);
 		if (r)
-			goto failure;
+			goto failure_remove_mfd;
 	}
 
 	/* Assert Soft reset of ACP */
@@ -461,7 +461,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -479,7 +479,7 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -489,6 +489,11 @@ static int acp_hw_init(struct amdgpu_ip_block *ip_block)
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
 
+failure_remove_mfd:
+	device_for_each_child(adev->acp.parent, NULL,
+			      acp_genpd_remove_device);
+	mfd_remove_devices(adev->acp.parent);
+
 failure:
 	kfree(adev->acp.i2s_pdata);
 	kfree(adev->acp.acp_res);
-- 
2.43.0

