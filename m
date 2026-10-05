Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8134248CD52
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208106; cv=none; b=UA+cqxnXrz38su9n0yv6nTOaX8lKlg+bpsxhy4vx38c1DNWr9yreLoEdpHbicowhVPOb64dEPqQ4QTm7OeCKvyhReRO5SdymURT6zADGrY8JrZcWO/WcEdN2dcOC2C0pcd7zY6HzwCZt7dwJ1zv5W5bZHcnR5qz0Adf83mc6mo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208106; c=relaxed/simple;
	bh=1MwiCrUBkhdWfsVzM5DfpefEDw73DMl4vYgaM82dOAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqRk8olOuyQHI7c/Kz/nmxVXGJr5aB51PNy4NpgPKZ3y3LcRSa8PngCBQCGOWyYUJGQ7AeYqBnFpeJy7qwEYjgoFAt/uaA1qNNGBao/domqtVOBwp1PkCJDlND6IE7ogYpni85zMgHUCIZFez0o/FY2mcmF7spJ2xeR6s2ZOAR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJNJ7ogn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJNJ7ogn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FAF1F00893;
	Mon,  5 Oct 2026 13:48:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208105;
	bh=97YdnZVFq3Yai/jFgb0XtYIxqnCQM7zvwggEBvrQsbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJNJ7ognl2aRF78YjWqQjtpshl6yKoOnS2c094cAVAkN+vOr92s+BwOfetOHFz5Uq
	 IV0ie+EbNLjauJg8ysFlm1Xajn4+Killd3rIYgHzkZqN16YsMg72ixdiUblNVXUo8O
	 qYNhuXmBZw8AO6sYW5SgdIvLebynn4SlA8W/OY0nd+emidYwb/t7BP6YJoIAZLvnEL
	 XHSHf2gD7Y89Z2U59i0/ugeyP2Tq/Y7GVhIybeSnFOmlg8OOV/H1wOJa63S4zVmCks
	 IfDgC/cZi0w5RfBMPAKuiyjL1CxrpLMMBb7ONh/XzATcfOh7A2ClvHqKWUN8CYjplD
	 SdpTfxtPw+OIw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/amdgpu: fix ACP MFD device leak on init failure
Date: Mon,  5 Oct 2026 09:48:20 -0400
Message-ID: <20261005134736.2691825-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005134736.2691825-1-sashal@kernel.org>
References: <2026100552-handbag-remission-3ce9@gregkh>
 <20261005134736.2691825-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit f0013046151b7467e62c471c1c83d63ea255799c ]

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
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 63da68d6a2279ec945581c990c5a59a5ae8b5560)
Cc: stable@vger.kernel.org
[ sashal: Adjusted context for the single initialization path without Jadeite-specific code. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 2b998d1245956..62ee3217842bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -344,7 +344,7 @@ static int acp_hw_init(void *handle)
 	r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 				  acp_genpd_add_device);
 	if (r)
-		goto failure;
+		goto failure_remove_mfd;
 
 	/* Assert Soft reset of ACP */
 	val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
@@ -361,7 +361,7 @@ static int acp_hw_init(void *handle)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -379,7 +379,7 @@ static int acp_hw_init(void *handle)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -389,6 +389,11 @@ static int acp_hw_init(void *handle)
 	cgs_write_register(adev->acp.cgs_device, mmACP_SOFT_RESET, val);
 	return 0;
 
+failure_remove_mfd:
+	device_for_each_child(adev->acp.parent, NULL,
+			      acp_genpd_remove_device);
+	mfd_remove_devices(adev->acp.parent);
+
 failure:
 	kfree(i2s_pdata);
 	kfree(adev->acp.acp_res);
-- 
2.53.0

