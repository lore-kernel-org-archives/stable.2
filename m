Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C7530EF6C
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 19:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781724281; cv=none; b=HhV/0d3tzJHQdrpA8WsoEZwj0jYI/hU0nJxHVrV6ERUJxQ8OCRn92HPX0630t2k4BoikJIAvu8ZVLeYBWMpSmJ3/IXnIuQ8XpJvuRPZY9Ov46YdwP2gCoZyPfszIfGXgBgTCQs6l6TwH91RvXrT1jT8daDq+7V1ZEzmHkkQu2aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781724281; c=relaxed/simple;
	bh=wLYly/vKB76bxraq24rSpvurjHDZAAov+UJuBYAbv0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qK9+Zd9rtubjuFH51DsX1rvBqPdqQtZGCDRx5J6OmkIL6saSAq2I1dF8IrI2kTB8HicNClOcw+pFwpsV19pL8GkvLXVZRPnVjBj1M0v3sSq5wrGBe8VZzLIRZgongcnzUwczwqzLFfaqRgBxMDakT0izkLOKAtiGo9ftpkL+ASI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwP8Zwmj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwP8Zwmj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182D11F000E9;
	Wed, 17 Jun 2026 19:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781724279;
	bh=p6SAvb5+xQHC+3TfdiAhcAGTDjsCrTSbeyjs7Ltonec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jwP8Zwmjrl5qCtWLX7p6MXrBZlzqHdPCPE+jLPUPD+Hdhrnz9PjIJyNUDVMON6VuJ
	 jEpF0cgK/fYL3WfzcWAKFyouBtIcQ+Tpm1wQy28SIl7mqu5IMZ2vt1F+6YhryD9u3N
	 n7Od2xUgk0HjXFOgCoApIxNPNSIz1Eee2ZxoAzUTQWzLCkrbI6s6HnuKgMV51uAkJj
	 uJBKwGFld4NufK4TOd5N9TjsIDBgGhVv7bOII4MWh26qO0UFo0VfwTZCxoSv/TsYaG
	 uwfCHAHLZmVDHSARYY3eeU9VS8bB5qtLR9x9C6oQKK05rmMn0HIgpCXxVKdhunfWTJ
	 XzKgRrFgcMBkQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Date: Wed, 17 Jun 2026 15:24:34 -0400
Message-ID: <20260617192434.296380-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061542-agency-national-2795@gregkh>
References: <2026061542-agency-national-2795@gregkh>
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
index d0d289c49c8d11..55473d5e574fc5 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1657,23 +1657,22 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
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

