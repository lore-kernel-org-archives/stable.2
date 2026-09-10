Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C537AA6D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789046624; cv=none; b=NlhW8JiDMEXMbOA7u/G7cdPA0TzJNKvjYYdZAsHaL1q+D9d1oR7EgXTAB4plbSJNgcYgssDf1pemPaCpCtoUxgLAf5cwnP23KmhSecQJWgV3YLZyiLdlU6RjBzNS2bqks6t9OPk68Kq2lfPtgqxM+WdqxtFVx79hB0h7aH19yyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789046624; c=relaxed/simple;
	bh=ayVkUiozgwsd7e6jc25ZL5AmSZ5xe9nMdUfwLA0OYEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZrcfugyEarE8iflRjrHTXo+y7940mc9ILX9gujMmezwloOqDOWQYxE1nMCyk1YsEvB9JwspMPiUrGBgCuQkJZjYRCsL0UeoSwCY10uNmKsRZNtGS2r6TghRlfOtN0FoZKwpimFGo6KKj8kks3LwBDoQqBb/p9rDrX0irahJhYfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QD1Bv/fL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QD1Bv/fL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616661F00898;
	Thu, 10 Sep 2026 13:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789046623;
	bh=oYhyiwe020UHjtQS5aoJ2i/e/DrJ8SB7zNN0OB7dlJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QD1Bv/fLEbS9fMvK+nkimh0ndHhrxQG26qXvLhkGuHB52Pp4TDOiVsZYpj+Ova44C
	 urWHbK5Ygc3CPaHtQYzpj6jmpdWWDvlwq/UC23dZOtFd+B8LN8cgvVh6zneoembeOW
	 /QLNZaddM1mB5pFdB/z5oCg1KZmfVzo3jtLCIP+J8+TBucyLpcH83pkNY+osIgRRb+
	 7InEkNe9W7idZgONLJuwMHtOzxaQCkSkn3Dq0T8r58Oh16cFx/PISEDJJ5uTmwCjyP
	 wUPXLPudWkEQt6Wn01c+wXpL/YkeKWtzkjL1HtVtjQtbtAy4rgRMlHh173opi40RKH
	 3IsTYFaxlkAHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] spi: bcm63xx-hsspi: disable clocks on resume failure
Date: Thu, 10 Sep 2026 09:23:39 -0400
Message-ID: <20260910132339.247410-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910132339.247410-1-sashal@kernel.org>
References: <2026090832-duration-catering-fe4f@gregkh>
 <20260910132339.247410-1-sashal@kernel.org>
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

