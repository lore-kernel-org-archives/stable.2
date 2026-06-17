Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797AE37B019
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 21:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733063; cv=none; b=cQhx3ztfHnDza1QP1L/GXMeTpH/7f6HGVS5VZ/uqap6gqjLYZ1dNgbyJyxLaYHAM/Md3cZqD0nURdrEMSkeMTkfiLTXPCrYUhZYQKhxsKZI/5u9kve1QW8MSofg3oQ/r5hDfvDNUtgB+wV6OSFZs5hH4ru1G0OD53qGm9g8yK1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733063; c=relaxed/simple;
	bh=EMWOAsQXRPa39VmTW3+l40habSIy7028jz/enIsYA9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AaOZ1CHg1qBpCQNjTsuz+hEBKi+l+eMike47HCWg/QgdCCEq7fgrkQ/dWzbgpcg5UOtc696jRD54jHON87C2UJhj/csuPdxDHY+Kg7qnv3n9PscBIh/q6xdjH2oOt/D42Nw5ffcFDzpqiPZsYv0HStx5Jrh1w6j3LD6V152drNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9Z6CD27; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9Z6CD27"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DF31F00AC4;
	Wed, 17 Jun 2026 21:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781733062;
	bh=ehu3XE9Nd19gRPV7j4khu6TtnPlFjJzVW1W2lV9MwPU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9Z6CD27jCq1jnyZue6Kw2DcbBoTtJMkr5fC4laihAFdli2Bbl9eBp3K72kVxxwQS
	 U0kC3NBl7rahOoxZlB9a5EjqBdVZv/fzfjB0zDZfikc6l2fEbnkAwZuNTULW5nhQeE
	 JUwzARnZP0h6xkQpfXjc949ll9im1K9I0okhaakuV7UjPw75GEkDfpoiCI30rVkPbv
	 IujP/yw56Us6Lwm2FCMRPQ3wmg8limhq7g/hXYxI0arpSm67zW6e+QFJx+OaYaveIl
	 lqhxAr7KF2FvPqM1/xEAUOxcOHVfbdCkfYNitnOSrHLWbDSXcnT6xE1A+X46yj15EV
	 CF6lh8F41Bonw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Date: Wed, 17 Jun 2026 17:50:57 -0400
Message-ID: <20260617215058.418058-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617215058.418058-1-sashal@kernel.org>
References: <2026061509-identical-efficient-87fe@gregkh>
 <20260617215058.418058-1-sashal@kernel.org>
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
index a62b15c0e3a3cd..0d118998f00ab8 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1580,23 +1580,22 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
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

