Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F7C471269
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 17:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790099483; cv=none; b=VDtF3UO+X429J5056n8RUSFEtMwTgfjbGjhB6d4cLl/z4anjZ+cU+YNxep7PxujpG0/TW1O7bsto8hxCx7Rn1wvb46vq+D7jm5fYPwORK+vxAzQXIMQ8WujDLM3F/OyLjGOPrrsFBcGACqAdqj7Aila+gEO+gazD2Tr1xzX9e7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790099483; c=relaxed/simple;
	bh=P0xSKV92wE5c+XcGNhho/1VgCGhSIK9sO5k0vXf2t7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M0RYCUlnK8Ednz/ueusyZjavSdGMNOAMGHl7nE3NfiWXOrwcq1G/589FDj3bwgRyCOz0BPudvgxJXIWavp0qWvErNc7FPgRMKrmEbGKAiCSl7BsEMBR99XObTTwg/4i7/NPb+pciXPEuwc8/Xx9gPV398N1/hpney87JDiyGt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DOh6qmj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DOh6qmj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14A821F00898;
	Tue, 22 Sep 2026 17:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790099481;
	bh=UcUM1ymPb6iusR3VVtoDCLJTkBIw3QsvQ4z3+0eY+Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DOh6qmj1G270b26eKQRUeRRPiRLBHLfNc1k2Q2AYLzwCcvLFJsH6iG0fy4JhBlM2X
	 DfuP/jTgZIUQV6I5PMlbZC8OluaAgNMjFDAw7VxcgcO2FpAwXA7YLU0BeIuocKpFqY
	 F9VCm/gjGkgokY21oWJ9rGfDxCj2TU9QL+XqyQDpq1v0d2Ifv1Di8lztX217YC+6GD
	 XEIhOPqC0K1Cl6hL4F7j+lxCSQ/F54WA0HRq8+0kGrhhgd7aYAZ6rOBah192u5mJDq
	 C1Qu2D4e+1k41FHxgI6rEEQe+xkqB3JOk04fDLn/pEyTX2qlnPiUyxbh2O51nHzUpg
	 dR2kGFc4LU7VA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] i2c: imx: disable autosuspend on remove
Date: Tue, 22 Sep 2026 13:51:15 -0400
Message-ID: <20260922175115.3308967-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922175115.3308967-1-sashal@kernel.org>
References: <2026092239-arguable-reunion-62af@gregkh>
 <20260922175115.3308967-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit e0c3e9d76adbe522dd420a766ce42d03ce887c29 ]

i2c_imx_probe() enables runtime PM autosuspend with
pm_runtime_use_autosuspend(). The probe error path correctly undoes
this setting with pm_runtime_dont_use_autosuspend(), but the normal
remove path only disables runtime PM.

The runtime PM API requires pm_runtime_use_autosuspend() to be undone
with pm_runtime_dont_use_autosuspend() at driver exit unless runtime PM
was enabled with devm_pm_runtime_enable(). Leaving the autosuspend flag
set therefore leaves the runtime PM state incompletely cleaned up after
the driver is unbound.

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: 588eb93ea49f ("i2c: imx: add runtime pm support to improve the performance")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Cc: <stable@vger.kernel.org> # v4.5+
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>
Link: https://patch.msgid.link/20260914091544.1667137-1-lgs201920130244@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-imx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 7bba042bf2e53..3ef97023c4bb5 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -1355,6 +1355,7 @@ static void i2c_imx_remove(struct platform_device *pdev)
 
 	pm_runtime_put_noidle(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	pm_runtime_dont_use_autosuspend(&pdev->dev);
 }
 
 static int __maybe_unused i2c_imx_runtime_suspend(struct device *dev)
-- 
2.53.0

