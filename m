Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644E03C73D1
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134456; cv=none; b=FO6xNH9d/Ea1jUbO8jclx6bKtdlWgxmcKrUWCAuBYmtHLA/c8lk0oaQJ5vJmuGaNVO0ARnPR6LPvftBg1Bx1cimBbm4xOHlI5d7PSSFvIZ0E8lGXz3qvZuNfIUhPkhbqAYbRhZ5pzvQxUy3t4syRPWfO/4p1o1kxhlowtn32FaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134456; c=relaxed/simple;
	bh=ftvTo28/wOcLM1qG8QIuLTNOiLGU3H2YIfHP4cXchOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZpievbMXyaoekwpFDuqyrEj658rYrs6Q+rCLQQAdKhLrIAm/lrOSfetmB7jeLvRj7n01oRnxA349mj35Z+dNy3vm7wcfWrHPveDciHAQ2VvAher5ZrstcAAkduRxSZ3ZONb10dmza6ilqd4MuLMJzWOvAg0AS+H4jjKHOnUSvlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IJh50Glt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IJh50Glt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FDFB1F00A3F;
	Wed, 15 Jul 2026 16:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784134454;
	bh=oJDMDf/aai8JL4J91G0j9Fr1aLHE76gmuq2GBKKZCRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IJh50GltRRcO922JStaLlblp3DzbowBySWDgWsft50QPu/urzdA/3dkf4Qa5YAVSx
	 gQF1htPXm+G+Nayk/0gKuiaqvOJnP1o6ix2cAEaspsgrpE2Vh53KPEmcP3iShuPggY
	 x0Mc29tUe6xwObxFfza0qkB1XHfYDzCl54GscEnHpnuqP1FJAc8E2AP59ozazvjeCu
	 emxBe5qoQ2tEwAxNKcO6CSQCIIwyPx2e2QC0dg3+YkBFwWVdJQv7H2z6ZOGiUWSizE
	 t4nnE5PcLJ8kM4/3Nvtpom2TdtkiXYNUFEqolwdFyvpVk+LS5hbtY/mGsu4ftA4ULk
	 bdSespdv1zrfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Li <Frank.Li@nxp.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] media: nxp: imx8-isi: use devm_pm_runtime_enable() to simplify code
Date: Wed, 15 Jul 2026 12:54:09 -0400
Message-ID: <20260715165410.963211-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260715165410.963211-1-sashal@kernel.org>
References: <2026071345-pureness-herald-7920@gregkh>
 <20260715165410.963211-1-sashal@kernel.org>
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
index aa2da758392b06..8b2f91cb47ac74 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -474,13 +474,14 @@ static int mxc_isi_probe(struct platform_device *pdev)
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
@@ -503,8 +504,7 @@ static int mxc_isi_probe(struct platform_device *pdev)
 
 err_xbar:
 	mxc_isi_crossbar_cleanup(&isi->crossbar);
-err_pm:
-	pm_runtime_disable(isi->dev);
+
 	return ret;
 }
 
@@ -523,8 +523,6 @@ static void mxc_isi_remove(struct platform_device *pdev)
 
 	mxc_isi_crossbar_cleanup(&isi->crossbar);
 	mxc_isi_v4l2_cleanup(isi);
-
-	pm_runtime_disable(isi->dev);
 }
 
 static const struct of_device_id mxc_isi_of_match[] = {
-- 
2.53.0

