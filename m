Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C15B4A092E
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210633; cv=none; b=l+Rdvneto2IWNQXQVW/jKKkKcIQHmZ0W5cPVM5rmcOQXwjjeN3uevfFX6rTXruoHmgQv7v3LnQcP/wxz9RA9/Eprg4gYfmCmdP1fbJRmbb1Eq61uEbl8PyXSpYp7Z35AUVaRY+BzqJ1QXTs6qtXN4zngi5Vi5lAJU49nEfvCYCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210633; c=relaxed/simple;
	bh=DPlUHVHTnC2b+Y78/VEw+TaslDEe+lwvbjL71lf1N1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UnyZWckvQY5Nbk+Mld9u1iUR/YpXwXVm/5RUjHKCy9MTX4Neb9uMYE0Sgujutf+087kxoxM9OxsQQZfewmmNWdDCET8L8Axv0QaTiEW520FXP2PY7uk0LNQmie+WKIN4L+tGQk+TBvgPQVeXiGIIBgf4mRzC9xYgDmVBGY2J53s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3Il9lk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3Il9lk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F81D1F000FF;
	Mon,  5 Oct 2026 14:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210616;
	bh=7rKiU5QaE40wXoDa8a3sSkz1cDk6fVgI6IqHMIYweLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c3Il9lk8wYdlmp8KGMc2+oMmKfPgEUgxkTDqenE9sjK6KooSvz8Nv+MlynQkdi5kg
	 trn4J6KlJkaCvvzep16n1HpKnVlGm464yp84sLPY28hPG4k3iF+yocIoR0SvKEor6e
	 SbZSAvIAGGfVn6b61aKKHBWTv1efP2EIhsmqW02GTbBHYDZZ6e99eq5qGvPeAf4LjF
	 JarlRQFQI9658kzYGfR0OMhZwsrp4zCW2vjHmvxv+rY1o4hAX3+hTQ4/l5lFEnwx7a
	 3N1UVqobh5JAR9fJ2PgZ2ZiXFaKBCQXm2JaccXZx/W94RQGHQqBMSnVIx6HGcpX4xa
	 KRXngQy2vWmGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/amdgpu: fix ACP MFD device leak on init failure
Date: Mon,  5 Oct 2026 10:30:12 -0400
Message-ID: <20261005142928.2984405-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100553-flattered-brought-ee78@gregkh>
References: <2026100553-flattered-brought-ee78@gregkh>
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
[ sashal: adapted the error-path changes to the single device_for_each_child() call in acp_hw_init(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
index 173ac5677d467..0f359f1fb041b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acp.c
@@ -354,7 +354,7 @@ static int acp_hw_init(void *handle)
 	r = device_for_each_child(adev->acp.parent, &adev->acp.acp_genpd->gpd,
 				  acp_genpd_add_device);
 	if (r)
-		goto failure;
+		goto failure_remove_mfd;
 
 	/* Assert Soft reset of ACP */
 	val = cgs_read_register(adev->acp.cgs_device, mmACP_SOFT_RESET);
@@ -371,7 +371,7 @@ static int acp_hw_init(void *handle)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -389,7 +389,7 @@ static int acp_hw_init(void *handle)
 		if (--count == 0) {
 			dev_err(&adev->pdev->dev, "Failed to reset ACP\n");
 			r = -ETIMEDOUT;
-			goto failure;
+			goto failure_remove_mfd;
 		}
 		udelay(100);
 	}
@@ -399,6 +399,11 @@ static int acp_hw_init(void *handle)
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

