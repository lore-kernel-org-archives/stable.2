Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B185B30EF6C
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724283; cv=none; b=erzdr/4XA91yaYliPrFs0pT/a1OzUZZMnTLAF31qwq4AuWUk2XhBjJeqKEEOAwfbTo7Q81+4I768cptcNN9y7O3VjEUwD3CiaBhbzRyt4KYV+QbAAdZ/apV0oz54faZObIWsZNFlqXXYnYqNPtMuSG+SbzCUcI+wWBjfHsPh6x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724283; c=relaxed/simple;
	bh=aW+/V1WWAWFnrpwOJiDOOct8IsHFQyLPpFXolTq7cIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ai25EHuxGDozyZs8E2smBS4nbPdfly7VPOVytK3i7SFAdlvy/9UJnHjIsum26njBAWhLfG0QKmrPwEODACNyYcf/FunHcsa5rQpWjZN14JAQ/ZfrLCOXEWSzGaUP2R1QQ5FPA2YZzeRV7bVjRFXNmDxD+xZP3TsiWlQd74Dd1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BDz6ML+h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BDz6ML+h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 070D11F000E9;
	Wed, 17 Jun 2026 19:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781724282;
	bh=ZFCJbyMliJt1WwJkGyxPpLSWGOgpFPyEeb9vd2YnoD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BDz6ML+hIovP2m7AAsUGqZ5zuMy8FBB8HfF7UFD+S8JmYwNNbsZeRcbPCZGT8sH+g
	 t/VZEnXIKJtdHyycdHZL33bjPQJKL9HwXyO+ubT2Ldr0rUj1UQwJpSu6SvOP4w06Xs
	 Dgq7VAcKZPuzy4Pvp1leNR2iz1n0fYEmYUpIIGelM5j4G/JlThes6Wb4AsiCxbxpw1
	 VkuvkZd+XRMq9c+8eePgH6v+mgxV+7GdtW9MPoqlX5LT/kwj59sxz5VcO3+Nfhe2HC
	 aMU/TzJVPPp3NyIXChflx3ItOnX/EpkZXtOl2EeaWRxW+JNgx8/N4NErJdxsGe43aq
	 u/zG+G6juNHSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] slimbus: qcom-ngd-ctrl: fix OF node refcount
Date: Wed, 17 Jun 2026 15:24:40 -0400
Message-ID: <20260617192440.296434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061556-wrongly-backless-8e40@gregkh>
References: <2026061556-wrongly-backless-8e40@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 120134fe75c6b0ae38f14eb8b548ad1e5761f912 ]

Platform devices created with platform_device_alloc() call
platform_device_release() when the last reference to the device's
kobject is dropped. This function calls of_node_put() unconditionally.
This works fine for devices created with platform_device_register_full()
but users of the split approach (platform_device_alloc() +
platform_device_add()) must bump the reference of the of_node they
assign manually. Add the missing call to of_node_get().

Cc: stable@vger.kernel.org
Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-2-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 8384f55ccd43e3..a9b9c6a7f74b53 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1369,7 +1369,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
-		ngd->pdev->dev.of_node = node;
+		ngd->pdev->dev.of_node = of_node_get(node);
 		ctrl->ngd = ngd;
 
 		platform_device_add(ngd->pdev);
-- 
2.53.0

