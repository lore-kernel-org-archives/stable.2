Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F1C48A8B7
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046893; cv=none; b=bYxOowbHlTwj9DBFW+6AQBoEDaeZROWKbgozv0SR9GLVoB9l58jkH6TZICENgEsAWqPiMdng1whdWYletQ2NLaXi31Ao/xf1avbDvuJFqiF1fvhvNMOaF4ah8ZgC1VzhKz/DIJUkmkomJ8pOafoBWh7qcx64yLjnNoa7hDX1i6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046893; c=relaxed/simple;
	bh=ayVkUiozgwsd7e6jc25ZL5AmSZ5xe9nMdUfwLA0OYEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UaerOZDs1kxAHQ0br3DWKwp1MBpHI2broKA9pGIy0UoEkalFAXwzLsM6dMSMCLiEQ+2Tb5fKqaK4OOaxFfqw0RFeTFXCaY+tni73L8XFflz7kuAL+lSgaeeuVvmzdwQV0bbYIyvkRQtR7r7revPE4sso2Gh5qEtTWUDb+qDUtJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgn2jGEO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgn2jGEO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12E3A1F00898;
	Thu, 10 Sep 2026 13:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046891;
	bh=oYhyiwe020UHjtQS5aoJ2i/e/DrJ8SB7zNN0OB7dlJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dgn2jGEO0Fxisb22BZGiOXIvnrwlEJRNt0jQJw9fmhNw7rxnFgrLEIShHxdoLYhQH
	 spKKao2VVg0jDDEbfIZV0zAqzJT7ElO+sPUyNduVwXdRITdd/6ZggLS57fv4jxo1DV
	 a4ujeW1tIhbmmXKfnQgi3sq2RAuFcQ+djwGPJfQUX1P6qShbDV35dtRGs975+A/VBv
	 p51oA4VNpNsa82spx3lhH0C4dX4M/IhNChe7/1fV3K3zZDpkX5lp82gCPNfQldIeh4
	 gQbzentonvf2NJq2Btd1m8hgWf3f3jfl07YaVj0MAXm0mHfkafQZtJ4yD+2f9lTx1I
	 p62TxDuZwlhCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] spi: bcm63xx-hsspi: disable clocks on resume failure
Date: Thu, 10 Sep 2026 09:28:08 -0400
Message-ID: <20260910132808.259891-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910132808.259891-1-sashal@kernel.org>
References: <2026090832-pout-curve-a0f8@gregkh>
 <20260910132808.259891-1-sashal@kernel.org>
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
index 34e7001191c0d..dea226f4ace0a 100644
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

