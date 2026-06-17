Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A8B38F957
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733065; cv=none; b=HPIF5Zi9wCVMZox1XAJnhYz4iwfZX5OvClk79wRtq3CoFqns9U+/dJvZkLTJWo9yvftleL3Csi1Ug6U4EweS61MCAx3XY1AIr4COfbJuB8QhkmTNGur3bk3vuE7o0b5rz6B0Q7AhyDG22BR8ZdB6SheNBB/ogytS6YKczmK3ecM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733065; c=relaxed/simple;
	bh=q01bxzx8uhYhYEPxP44kqrnHchVi1D23HLYuK2jXIO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PcVOT1xS+VKYqpRD6VeJpJFYbx2Xv7cXWbGgPWZuS2iUwcY/NQ5br+SYpfU3HrqGfHD/w5/yQbjtZkkq3jrVk2kJoEotgchqHAImhJ9AMuVyniL1hT0csdvAtSpgWSpnmKuhSgCTfdT/KkSct/8Im2VI1PSlXe5FXCEJxoNHb9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDaUQH3s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDaUQH3s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC2D1F00A3D;
	Wed, 17 Jun 2026 21:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733064;
	bh=WCanlnpQJ0d7G/Yc7iVF94rdbIRljw2i+u0pBiG3MGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HDaUQH3sAM0fCHEhTzdIU0Sn0XV70jRn/OhOx2xuGTtsP+Wzlleb3BpUu3QnhoWym
	 3ACRXXzIjegTWDs20Zf/CJ2NIGLGZ1JHldIw5YbyGKKOz+G+F4T9vGgYQ8l8aJ84GN
	 //ShXW2eeRKyVWmnfiZi6SJkOSXfSbbEFHX6Ag2bTY8A8DyuHKwlRa89xDmt9LhYce
	 LU1K/0mvr9MXSGkoQaaWz3fhnKlvPBIJjeNyGu9iLrJpIXMDtzBKPSNAqMFs6Z9f2t
	 TyMy4nsaErJUqxJlb3kOcQ6Pc7XFt1g6XU0H+ssNLzKvRvLIL+UCnC2wYHJVyZ7gAN
	 UoAlh2ZOWmKrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Date: Wed, 17 Jun 2026 17:51:01 -0400
Message-ID: <20260617215101.418241-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061546-headscarf-monsoon-d5c4@gregkh>
References: <2026061546-headscarf-monsoon-d5c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

[ Upstream commit 2c22ff152d380ec3d3af099fa05d0ac5ca9b4c1e ]

qcom_slim_ngd_ctrl_probe() first registers the SSR callback then
allocates the PDR context, as such the error path needs to come in
opposite order to allow us to unroll each step.

Fixes: 16f14551d0df ("slimbus: qcom-ngd: cleanup in probe error path")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
Link: https://patch.msgid.link/20260530204421.116824-4-srini@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index ed1eb491430bac..c6433618b18d1a 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1573,24 +1573,23 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->pdr)) {
 		dev_err(dev, "Failed to init PDR handle\n");
 		ret = PTR_ERR(ctrl->pdr);
-		goto err_pdr_alloc;
+		goto err_unregister_ssr;
 	}
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
 		ret = PTR_ERR(pds);
 		dev_err(dev, "pdr add lookup failed: %d\n", ret);
-		goto err_pdr_lookup;
+		goto err_pdr_release;
 	}
 
 	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 
-err_pdr_alloc:
-	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
-
-err_pdr_lookup:
+err_pdr_release:
 	pdr_handle_release(ctrl->pdr);
+err_unregister_ssr:
+	qcom_unregister_ssr_notifier(ctrl->notifier, &ctrl->nb);
 
 	return ret;
 }
-- 
2.53.0

