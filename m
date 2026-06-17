Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A22838E12D
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781728446; cv=none; b=aBJAGkc6N6grZkftaFJ//PxcOVyQpU51LfEazMgzJusfp2m3NZqAT+NeTUMS4dRLKlyTzAAsurn1X0Mw5YZDkKw4A8AoDjwmDjAL4WpgwU1VxPLpc7Clikyb/Ld+FORSRYKxgAfD7VIUZ7BB5IF0dSzhkCcvTy+dE0RoPAPz5Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781728446; c=relaxed/simple;
	bh=RJiypjsJ1pY25f6RHJUFgQ+Tdba3VfAYABd0KDfGszk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poToVt2H6J57LnEck3jx5oyNFr5wjQt0IV1wPK6JVoa71+pyLk9kMXTLzCENHXDTE7fNmkj57UsHIVbdXVCWG18Xc+mOfTVjdKbfL89XuTrxjsnuQl6oCHJp/vzSnaon44aafEPSA/NzNVCXFTGLhsSsKLBhfIkr7KiACDPZcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+z7uouw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+z7uouw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694261F00A3F;
	Wed, 17 Jun 2026 20:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781728445;
	bh=/50oK3s9s09weNSXNmeANGLmV4xPp0F4sXeE/dmLSKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E+z7uouwGIADuU0DLrbk6tsnqY0GXUy6HZNS8/EjZk2ZMlnYmQIyJume7zaO0JMEp
	 pAOX4tPSuW3xaovcwftCalLR5AbRiIhj27yJu6n2sgWVhDF8qezUIRwa1Pw+8YE5wn
	 k0BYVcyMzJzbbxi2QlljTSgg963N/JCsS1tR6hYYwJIu89hKw8HOCAn390YHnPCJVc
	 isBezUN4jkDFxtQZa8LFa/4bYX045v2eRpxcKmEXUKO1Snd1FVL1D2ahbwT0aPIY/5
	 U2OOViHDSULiF1Rv5pNXlGV968BOqvkCLJG5b6yoarEDHs8blysu3N7RT/UpdI2i/Q
	 MN0DAVgSwNwIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Date: Wed, 17 Jun 2026 16:33:59 -0400
Message-ID: <20260617203400.334600-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617203400.334600-1-sashal@kernel.org>
References: <2026061507-squishy-ankle-c2e7@gregkh>
 <20260617203400.334600-1-sashal@kernel.org>
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
index 931bec1abc79ec..2f92622c29262b 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1593,22 +1593,21 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
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

