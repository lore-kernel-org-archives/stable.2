Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1745F48A8A4
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789044780; cv=none; b=QRxF1xdyLcivVtwuQAikRZ7Q/QWuutFElulmcmS8iUHteyR67fVvT9vpLO5hjZ+KDcIg6jhHPOIxP/7zmi9/GFyl9OSrh0vxrzF8Ov8W4II8mAxjGZn77qMFVAc7BfyOoNzy3ipZtO037hWbsY3+1LeZRV07LXeIpDtUXkYb0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789044780; c=relaxed/simple;
	bh=uj1Yrqjmkwn+m1xSGvSvGcqS+LIL2fbXe1l5pDgOVT4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gsUXd05wyKptHhdRGolMfIIfEj0e2EVKd7+7rjfRaOcirdL4m0f6ENTfb3sXAUtbBzLI3MsGgwkb/wIVTI7TeNeJYJjt0Xfb3wjKSyNd40y4gHCqidhVjz5iUQ8pu+DG3eIkFybYn0LJlOszJlW/k5ZqXlmCJmuVPvbeW6BqSFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcofDfJJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcofDfJJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6496E1F000FF;
	Thu, 10 Sep 2026 12:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789044779;
	bh=i6k7wr9odofqhjFvJw87YUW5H5BW9WhP1XT+FKNr4eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JcofDfJJVaTcJzQKXZnYAM8yrIFD16Q4FT67n/CCr4uqJybJmyMAeknEWjDbtKHyt
	 sA/BVjbPxvAE+IlN8D+K1pWwr44gZUhVVkoJ0S2aEKJHn6y/OLdlQNqbR6/uSuSs3i
	 0puKb6hcCl5PbWhPzeynEeYm8P9zVDyiGi9BOt6GGU1z1rvd4Wy7JpBkL1WpVROcq6
	 5eBrv7r0B12hdYPg8xQQB1Oh3NVjqHE6NnODUL+/thNz31pROq4jx0vlPM6sGCDDE4
	 USKdnJE8V/lEZkWn5cCpiTAxbpDrnbrzP90kZgf1BrBl0TcP+nRB0qjaBg1wDg6OSW
	 Dt1RNNWOAfN/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] spi: bcm63xx-hsspi: disable clocks on resume failure
Date: Thu, 10 Sep 2026 08:52:54 -0400
Message-ID: <20260910125254.183393-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910125254.183393-1-sashal@kernel.org>
References: <2026090831-flashy-precook-e8f5@gregkh>
 <20260910125254.183393-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Can Peng <pengcan@kylinos.cn>

[ Upstream commit 3b0cee02664041aea7e4f787c66cb86c82eb4e97 ]

bcm63xx_hsspi_resume() enables the HSSPI clock, and optionally the PLL
clock, before restarting the SPI controller queue.

If spi_controller_resume() fails, the function currently reports success
and leaves those clocks enabled. Propagate the error and disable the
clocks before returning.

Fixes: 142168eba9dc ("spi: bcm63xx-hsspi: add bcm63xx HSSPI driver")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
Reviewed-by: Kursad Oney <kursad.oney@broadcom.com>
Link: https://patch.msgid.link/20260804072017.860974-1-pengcan@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx-hsspi.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 16e2873c4d4b3..cfac60c9671c0 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -534,7 +534,13 @@ static int bcm63xx_hsspi_resume(struct device *dev)
 		}
 	}
 
-	spi_controller_resume(host);
+	ret = spi_controller_resume(host);
+	if (ret) {
+		if (bs->pll_clk)
+			clk_disable_unprepare(bs->pll_clk);
+		clk_disable_unprepare(bs->clk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.53.0

