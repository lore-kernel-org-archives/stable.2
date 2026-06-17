Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8882326D55
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781723334; cv=none; b=Pv6T0qdlS3jh39yyQuL+b8Q2Zo+7dFvlhGtxkql2zGSun7G9g9Dv6Ag50vwsJS8nPFOBZVSZqjNV0fQE0DfygG4+gBUH29TUmGeRPPyNLK4DdpbbEgp4BdlLVSQvwneXc57ke/eyT/TSj+MozbV3pEAZhUlECl9zvmclGchWUcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781723334; c=relaxed/simple;
	bh=Jff/6+V1cUAik72AFkRXIeD0K/PqnBlNx8HBUOJjZ6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HUh7zSu/WvSqd+XGGKdSk98LbbnL0aDaKjD9aVDq6QgCfNP85NjeIpxwo06bV2jQ/JKxSiJ1/Aq4NugjQPtCB/TGU1K4yfx1qWcDqVGgiieavw8hZixQ0sKe6ipQV64w6ROs0x7iavu4eo/ssmor20+uU0vTZ0olkQ/etFZWAhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aZO8ME49; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aZO8ME49"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041961F000E9;
	Wed, 17 Jun 2026 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781723333;
	bh=ZkGUgQ0Q3EpjDOi/bUAWnSCWDLqSZtlBerXIjwC+g3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aZO8ME49vpIy+vtodPodJ0wbnBceMmfu/vcYK6X5+YzIwQtW9+XoxyObeLH9DkP3e
	 FRZ6Ke6YfHVpKnH4gVQ7GE+BhT5mcfFy2jVqanmJ5Q1YX+k24UO1ivNCI2M2pqX/0G
	 bM38t/xPyPZoFVRWBMZbewl9qHNggX5OJYayUSeMtJaCdDT/fEKPz+oqQad1s52FuF
	 8nUazraxBR+Jk+4mCZCloWvnUpHnLgb41EPRhOj2lHPOfCV1q0mz/skKgzCw4Ty1Sg
	 5F35j5nRtExQijeNdFwhj+d+fSbXg1fyAyHrT98oZsYi5JUdScEoLUmmnW27K9H4/4
	 N/6N9VTvsTEVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] slimbus: qcom-ngd-ctrl: fix OF node refcount
Date: Wed, 17 Jun 2026 15:08:51 -0400
Message-ID: <20260617190851.291276-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061554-verse-rekindle-3ba2@gregkh>
References: <2026061554-verse-rekindle-3ba2@gregkh>
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
index ed1eb491430bac..c0970a0e108392 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1461,7 +1461,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
 		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
-		ngd->pdev->dev.of_node = node;
+		ngd->pdev->dev.of_node = of_node_get(node);
 		ctrl->ngd = ngd;
 
 		platform_device_add(ngd->pdev);
-- 
2.53.0

