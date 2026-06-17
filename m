Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E42B29B78B
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726566; cv=none; b=AcFdDy2EK9YdZDwdan9nv9/aIlc+poqijIv7mdgyRwBI0o+HwMRP922FdbtdyU7tWnc1lEPKs6VvJMgtDwVHl6xKG5FV0z7BvBL8VHXxBE42/6a8yGhql0oinhCNOEBpijMHYAdLbB9Kl7tEMuOR3PB5Y6GJs4rjKnE+SfXLCec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726566; c=relaxed/simple;
	bh=cPPwbiJu1InR6qdyp47byYY4EVMiWEDoG6qjRIAOpVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ae61GKMHZIYH3fc5tQ2mt3aNiqfskunTguV60SJKFFF+Se35BB+grb8l1fzlwvG7C8C6gV/g0uUnUqPKWs/sy4vDo4lxQXxQyU3GaLLsb7MicrXnLJQpoCbItM2rK4N6l+DUBCN3HKYM5Ii4D1NmBP05TXq/tFzEmt3+yCN100U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7D/h1RR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7D/h1RR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541321F00AC4;
	Wed, 17 Jun 2026 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781726565;
	bh=Vz4AXzM0BHgoFLgYvpB65azNmDi00N8b4PCnCNEvLUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n7D/h1RRBSxsuezZdbfE4NZPRm5bjbX9ab4izPb894ANF/25crceeI2+7+HAcNyus
	 8VIayQoMlIUuAgJ2KgOViLUBQP4jPnkCbBcbo/zZxmPLE2DZ7LU92lGzJh3gFdtIyv
	 jSDSSOsW5q4fTjCxMyMhyRTFEFRxwfwxegjBSxxac+DM9lHta5u+2cOs8p/7tzw+fu
	 qXxcH2NEL1g2ons1MRbRNr366U2znyNMrkRI+CUBWi3buRkbL7woVNA5rzBp2IQDiJ
	 DXiXkw0noZi9g9nOW+7WHldKcNwz6gLs24D0KDsG8y7+V3Psorv+vyXOK0mWq0MgHn
	 s3Ch0+PDK00/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Date: Wed, 17 Jun 2026 16:02:40 -0400
Message-ID: <20260617200241.310475-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617200241.310475-1-sashal@kernel.org>
References: <2026061505-reverb-graceful-8efb@gregkh>
 <20260617200241.310475-1-sashal@kernel.org>
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
Stable-dep-of: 2a9d50e9ea40 ("slimbus: qcom-ngd-ctrl: Register callbacks after creating the ngd")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index f8cc2c93e8e999..3c65b413f891d7 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1664,22 +1664,21 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->pdr)) {
 		ret = dev_err_probe(dev, PTR_ERR(ctrl->pdr),
 				    "Failed to init PDR handle\n");
-		goto err_pdr_alloc;
+		goto err_unregister_ssr;
 	}
 
 	pds = pdr_add_lookup(ctrl->pdr, "avs/audio", "msm/adsp/audio_pd");
 	if (IS_ERR(pds) && PTR_ERR(pds) != -EALREADY) {
 		ret = dev_err_probe(dev, PTR_ERR(pds), "pdr add lookup failed\n");
-		goto err_pdr_lookup;
+		goto err_pdr_release;
 	}
 
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

