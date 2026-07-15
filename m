Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2151843C7D1
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 16:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134456; cv=none; b=G4K9ZhykkQgBJyBfhCrg90zMwwa3KplXxgsBL0Gl9tyfxEddx1zKiUReeOb/yY/Jbu4rgHG4MdoxXuEZcFXKcdIeJ6xvEKEOSrUPyzyYzgLvsdXf/9l1D4WHzSTN7lM76UhMpZTowjlFst+VjHzjpcrYcE6GrJ9NW0SV+2/XJ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134456; c=relaxed/simple;
	bh=Mx1KckP9ad1N5MFeG4C803+wImi6ebQFYHy62qoTdTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OlvdsJb84NFO+YnJ5WRGgL+RQWYWfB4N5ewDeQ1CKYcTrXyYR5X54myFBgOUogkOjTCAmrxDdEOO9wqAwC7H0pErkCPtyDlwif0v4ym6EJDKUKNDnWpM4iBfvxFN/hJVwTaYcPElJqM/PGTCsU4/p+esJd7MU0+6FNDz76D6Bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLZ56ewv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLZ56ewv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20041F00A3A;
	Wed, 15 Jul 2026 16:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784134453;
	bh=wIy+HrwJDVi3Oz0JWzMyNbTIqRW4UaPcuiGYpjaroSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SLZ56ewvJ7ujosnbnHHjpc7BQSVsfbmTQJaig4gaCgXTxbsyDwAye1IaNC/YWXbm8
	 4shFOEAh9tpzdhCoJVXVUYi0/0EBy1c8LFuqR6v/H9q3ln8Y+84fkK2NO/HN6xKC8K
	 +SsyL1I8vCmJEqdlsswsdcW8UHqTzXkEa5WlDdU+mUFMpBPIWT7ieZOCDPMBkTm+I8
	 iHOiJrS3L8NMjt7HlRNgesA+LX7WJtjr8Fi+G3krs76/9zi2wCcHEP1W62j92adnyb
	 MSLvToxMRK8DUSZhBghZxlrlmWKcnLYA1IANcYCNjmcw0yWWfjzt1G2mdFHpl3Lq4F
	 jzNlthVQuGawg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil-cisco@xs4all.nl>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] media: nxp: imx8-isi: Convert to platform remove callback returning void
Date: Wed, 15 Jul 2026 12:54:08 -0400
Message-ID: <20260715165410.963211-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071345-pureness-herald-7920@gregkh>
References: <2026071345-pureness-herald-7920@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit e992ee7eb56f827088f63c9d5210ab4da25a5c4d ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Stable-dep-of: b670bf89824e ("media: nxp: imx8-isi: Fix use-after-free on remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
index 81be744e9f1b58..aa2da758392b06 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-core.c
@@ -508,7 +508,7 @@ static int mxc_isi_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int mxc_isi_remove(struct platform_device *pdev)
+static void mxc_isi_remove(struct platform_device *pdev)
 {
 	struct mxc_isi_dev *isi = platform_get_drvdata(pdev);
 	unsigned int i;
@@ -525,8 +525,6 @@ static int mxc_isi_remove(struct platform_device *pdev)
 	mxc_isi_v4l2_cleanup(isi);
 
 	pm_runtime_disable(isi->dev);
-
-	return 0;
 }
 
 static const struct of_device_id mxc_isi_of_match[] = {
@@ -539,7 +537,7 @@ MODULE_DEVICE_TABLE(of, mxc_isi_of_match);
 
 static struct platform_driver mxc_isi_driver = {
 	.probe		= mxc_isi_probe,
-	.remove		= mxc_isi_remove,
+	.remove_new	= mxc_isi_remove,
 	.driver = {
 		.of_match_table = mxc_isi_of_match,
 		.name		= MXC_ISI_DRIVER_NAME,
-- 
2.53.0

