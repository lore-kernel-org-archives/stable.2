Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7DF1D7E5C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226047; cv=none; b=h8uI5CIJmnZB9h2GKLXJuF9LGgS9dTZx4pBJPXm67U0n1D8n0MwtgsnIvN89X03d64CMDJdVAEswuoD9ueKxkfLLxh46SHqw7TCnNO2OqDa97bJOI/K/8+6VWj1Hz6b/e+9DT2klkdqS0dg30ofvT8YSc453poeiebRCag3idVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226047; c=relaxed/simple;
	bh=DUP49Bnqs7WDzVN0Q+rqb305YBlFXe+/OGZUxFIN/6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A0OKf9p1S+jp0mpMJFu9Edm+OVrwJ0tllrHgORY9TUYV5s7h5Y/6rBHmeOfjQQlix804UpQEWdVdwpfum4tQO4pnwL51dsQud/6US+caf8AoigxDGNOLxPJ6JchShoW81uhgxz32Q17a0a2PWjVse6x5Jd2BAPikQGgACWdeEL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nSQLCZiS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nSQLCZiS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A988B1F00898;
	Sat, 12 Sep 2026 15:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226046;
	bh=e6CZpcbOLvOtL3PgHM8f7vB01cmdHb4tLwZiQ0y16io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nSQLCZiSAox/d8WOoseaG0ysm8dIzSAzK+Q+64wKIxATyqDyUQxjF9uFlstLP/sld
	 O835QJEatU0x+fcxdJ4iGmxeHG7yT80PQ4skCGOg3py0ITQ0wM2M6LT4GRcutmWQo2
	 rjJMVsN+4tWpJCZt+VwWtctnwLk9BD1KeaQbNmmBubmDa5cLyFO0seV/2MqOF1p1yU
	 FD6ZnzjoZMV5Hk8JKT+PT2WdmkC06UctS3A4vggPOwuwSMn7CuU1fn7iJ3yiR1wtXM
	 jDoHJd72xOcUlLBYINayz45/XjyXVZIe1Gp//Q1RzlU1DJiRIATUIssFkYJAuyFttl
	 /QuUpdgLpsgiA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/amdgpu: fix autosuspend cleanup during removal
Date: Sat, 12 Sep 2026 11:14:03 -0400
Message-ID: <20260912151403.3071211-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912151403.3071211-1-sashal@kernel.org>
References: <2026090919-halt-gusto-67b7@gregkh>
 <20260912151403.3071211-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit ef5fcf2a6c320676bf8be2dadac93d9023b468b7 ]

amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
amdgpu_pci_remove() does not call the matching
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

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Link: https://patch.msgid.link/20260808120934.2813010-1-lgs201920130244@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 7f2e71a51e0e6..d4eebeebaed18 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2122,6 +2122,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	if (adev->runpm) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	amdgpu_driver_unload_kms(dev);
-- 
2.53.0

