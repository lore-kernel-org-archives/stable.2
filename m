Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7641028725B
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784133154; cv=none; b=hq6QkPwFsvHtARtz0Z2DDcfdJSQp4ESzIdYlNX1xtazWHiaMQQ/cy9keUq/RgnCDohZ2Qq1QdotM6SBaRL18mtflMr9tqrd3idQaziPP/RVfsTtyxDgXCckMGDS6bjKkuD3GRozlT+Ah327L+K7KDxbKlZlGTKXAvA99f35LzrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784133154; c=relaxed/simple;
	bh=hQNeQu3oP+BM3KFl3zjS1RCbfKis2Bs78ZOYm9bToWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHkRyw2ViWHhPyPEyqBY7reSVLNk+G0LrED0TLj9wjzDBwya9+NRPvaMuP4aabEEo0ar79iZtXOYhMVqp3umX8VIUG+O9UU1k9G3YN74yQ0fkxMeNeQcIvkjSsFvk8/FbLVf24U8LNx8zXBghd0mtxf2WXS3ahfni9k9gFidi2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRJ9X10P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRJ9X10P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A81F000E9;
	Wed, 15 Jul 2026 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784133153;
	bh=Ct3qYCRuK6C1KGQnB/Go44SXHZNAA8dZ/4MoMjurzhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gRJ9X10PHZgwYeYmNFp4tgGOuBZoa+fnbLb29MfpDFlTbuL/+z6BY4TL1ftxX2tQI
	 7VXqYmnDL75sbhPtRvxEiTKWGBcYD3EWuJonCtCiM+ZLkkl/ishzSKzYAWG5RvEvSA
	 SgTevlZLUqmwbZoGXT+tb/7yZ5hRxE//95/p4OoK8gijDIII5OtO4QjvAr+mx05uVo
	 OX0BprMW9BnwUdbizplpB3xEDQTTMu5LcO8c/o+UcpGEfVwfmkbpCW2awM+GWgpQiI
	 1e6vASKqYZDflnIb8UJMLeKmsZek8K4sjs2n1lyIauSLxrZNswVLB5GnJg01xTetjz
	 4HVnWLHHFZV/g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] media: nxp: imx8-isi: use devm_pm_runtime_enable() to simplify code
Date: Wed, 15 Jul 2026 12:32:29 -0400
Message-ID: <20260715163230.952514-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071342-backfire-varsity-a0ef@gregkh>
References: <2026071342-backfire-varsity-a0ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Li <Frank.Li@nxp.com>

[ Upstream commit 078161dd44d6f848a62a473206d69025607736ec ]

Use devm_pm_runtime_enable() to simplify code. Change to use
dev_err_probe() because previous goto change to return.

No functional change.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Link: https://patch.msgid.link/20260116-cam_cleanup-v4-2-29ce01640443@nxp.com
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Stable-dep-of: b670bf89824e ("media: nxp: imx8-isi: Fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../media/platform/nxp/imx8-isi/imx8-isi-core.c  | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index c2013995049c60..560d58ff2db8bd 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -472,13 +472,14 @@ static int mxc_isi_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_enable(dev);
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return ret;
 
 	ret = mxc_isi_crossbar_init(isi);
-	if (ret) {
-		dev_err(dev, "Failed to initialize crossbar: %d\n", ret);
-		goto err_pm;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to initialize crossbar\n");
 
 	for (i = 0; i < isi->pdata->num_channels; ++i) {
 		ret = mxc_isi_pipe_init(isi, i);
@@ -501,8 +502,7 @@ static int mxc_isi_probe(struct platform_device *pdev)
 
 err_xbar:
 	mxc_isi_crossbar_cleanup(&isi->crossbar);
-err_pm:
-	pm_runtime_disable(isi->dev);
+
 	return ret;
 }
 
@@ -521,8 +521,6 @@ static void mxc_isi_remove(struct platform_device *pdev)
 
 	mxc_isi_crossbar_cleanup(&isi->crossbar);
 	mxc_isi_v4l2_cleanup(isi);
-
-	pm_runtime_disable(isi->dev);
 }
 
 static const struct of_device_id mxc_isi_of_match[] = {
-- 
2.53.0

