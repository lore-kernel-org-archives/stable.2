Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3A348C4C;
	Sat, 30 May 2026 20:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780173881; cv=none; b=i64vTPeknoD9aFT6eSqV0NUU8aMJMkJJ8pIrusUzCY7TntvWuQ208FvhQjpmOWuayh0uu8qA8mhOszzx+J5xswc80izX/y0B5cDa5GP23oYk407lrIoQ47Wb1ZVB+o2SuA5iBOk0E/+mLjNEE5guna7ijj6Dqb9m+iWU0WgV5MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780173881; c=relaxed/simple;
	bh=YrQ9TWRiR9ZauWciOcM2foP81ki3GdMKCdh5VVUAAZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLd3E13Wm2qFNwKjIZRNYDDsI8nu7UQ0W1JRuy4MWZlUl9wGaCwyImhPQg3LZEjcAf2SUlHqCRQzJbP/aNuGHLKvF7HjgqCo0gFfvJguByqHPJyD+/xJqfL1d1deUEmLTJye5HUSI2roTs0QOX60/3CfSESZPD1NvyPb9q/drV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OnTdXAqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OnTdXAqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C891F00898;
	Sat, 30 May 2026 20:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780173880;
	bh=kHAbwq/SzutZYIR0K/AW/f6Kcdb7/efCvqLgYx1wWtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OnTdXAqLhHS4mkMq28Vjdk0T1Jy6KltIta3tv1eGBF8QTXEl58ddY6LXuiwmKYKlJ
	 aAqzaMdOFLFUPH8cYRxbVHLS09IgFqXGbCCA68IB4fUTz4cPq4YJMb+vEu6sJy++Wt
	 X65H8arcsETVvkbG/lYge/ccmbiTOVo4aJA9slpYjSheodmZu+yYQ/ZnhdklKMDek1
	 U7/MP8UG1ziD9pS1E/ZisyiwT3Aqba7jfku2KG8RK09GI7sb73uP919lc/jSJFB71r
	 43aoxpjKxUGYzFA60jJvTezBPQ1nT5Fx1ZYP0bVKYWQUsCfbS0gMPg6e8bYAMAqsXT
	 j6eTWgf/418Rw==
From: srini@kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	stable@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
	Srinivas Kandagatla <srini@kernel.org>
Subject: [PATCH 3/8] slimbus: qcom-ngd-ctrl: Fix probe error path ordering
Date: Sat, 30 May 2026 21:44:16 +0100
Message-ID: <20260530204421.116824-4-srini@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530204421.116824-1-srini@kernel.org>
References: <20260530204421.116824-1-srini@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>

qcom_slim_ngd_ctrl_probe() first registers the SSR callback then
allocates the PDR context, as such the error path needs to come in
opposite order to allow us to unroll each step.

Fixes: 16f14551d0df ("slimbus: qcom-ngd: cleanup in probe error path")
Cc: stable@vger.kernel.org
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Signed-off-by: Srinivas Kandagatla <srini@kernel.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 47ba9fb34d25..6b91a6f11cb6 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1660,22 +1660,21 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
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

