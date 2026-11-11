Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415880;
	b=o3vEcd/eOUhog6+dWAikXrcub7oGtbssuIpm+onp2RaLz7WbMEnQ91owl4oPgywn8UBk
	 +QmfW0q8JebJ5bZwG9JzOYoQyVO4zU+ExMgkY3jMz1ldapBkcLH8D1+ikKWQnfaCwE/5M
	 lM2VtfcMVhD6VyNlji+TyqPIdyOydSJfNfyigab/8aKdt7gMmLqSstGjICHdLN0/Ht0+g
	 9ISt4/5EcyWPqSbxYSUSwnU7LFLHN8nPcGXTfunE4qjRKoU7/YO6vWZ3u0GiyixDvj61D
	 1pYdttXdK63yI3gkvX7dx3GQCL7sgDwcMpddiRnM6BzrDQPHA/sTT5w+ViiSwoSFSrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415880;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uuHX2wOJ0cA5DPtyug7aK1FJSizLcEghg6bPyiMXoUQ=;
	b=Zo10uGMjH7z5Fs1Rdh3MLWffREklxR9mgu5SxA2lhRtYbMKcJYV5ASsU9ozwiJfWU2k1
	 +6FWgMFRf4ar5/J6xnPkdX9Vf9TLz8fzyBUsQUZ4Hbqzn6U3SUK39mr3zmgXt1E8YcZ7E
	 3qZ/6VFziE4y++7EHBDGf4KGI1GK7srVfiFTS8CiANqJ90ES3QrgN1d+0q6qoI8n8k2Yh
	 +LwCYFD04uwgK3ncqV4ayjnoPLkumM4rBqUnbFoZRfFJc+qe08lEW35WAEvxIWX+ItuxU
	 WN9QL3mggEU5NahVur7XEFjpFGslwH23Y1/zM77gEDP8KN9vZTGzLCF10MfYhkGmhaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECtCiBlA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BA7606A89D
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 16:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ECtCiBlA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1100A1F00A05;
	Wed, 11 Nov 2026 16:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794415880;
	bh=uuHX2wOJ0cA5DPtyug7aK1FJSizLcEghg6bPyiMXoUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ECtCiBlASvK2eY9tXgUoPBdkQ28l6Xt4L2GXmo/9H/DTOCSa+0jI0XB5k3g0ds/B1
	 ucx50U5JaGu1TJ1iig7JRPOomYZorfLW86HR/0hh/lgHx7epDRQXcEBbvedjQgRDYA
	 b6D1tp00n69wB6Wpyf1gvPAWT1tUq0qtSE1m2ANmpluGwY3NRO/v0m1Q9Yx1q9DziG
	 LfDR1x5cQfV+JUWNK0UqPtclHES+M5K5gBjLStb5Rjg4H7XQvgCD/68bteAEHmiFRz
	 2q/ionZz2UImUmd9qPSgBgdyo2g2nSjXHYJYqwiJc3a1B+FOMQARTWuTgN81YpMzrk
	 D9XT+/+um1o6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans Zhang <18255117159@163.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] spi: cadence-xspi: Use FIELD_MODIFY()
Date: Wed, 11 Nov 2026 11:51:15 -0500
Message-ID: <20261111164957.3294291-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111164957.3294291-1-sashal@kernel.org>
References: <20261107052239-failed-6.12-ea9854a169e9@kernel.org>
 <20261111164957.3294291-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hans Zhang <18255117159@163.com>

[ Upstream commit 6fa473f4c5dcc20db9799f90da48b977730e05f1 ]

Use FIELD_MODIFY() to remove open-coded bit manipulation.
No functional change intended.

Signed-off-by: Hans Zhang <18255117159@163.com>
Link: https://patch.msgid.link/20260430155456.36998-4-18255117159@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: ea9854a169e9 ("spi: cadence-xspi: reject SDMA transfers larger than the requested length")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-cadence-xspi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi-cadence-xspi.c b/drivers/spi/spi-cadence-xspi.c
index b6b42daae1bce..90c6d9fa4dbb9 100644
--- a/drivers/spi/spi-cadence-xspi.c
+++ b/drivers/spi/spi-cadence-xspi.c
@@ -453,8 +453,7 @@ static bool cdns_mrvl_xspi_setup_clock(struct cdns_xspi_dev *cdns_xspi,
 		writel(clk_reg,
 		       cdns_xspi->auxbase + MRVL_XSPI_CLK_CTRL_AUX_REG);
 		clk_reg = FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
-		clk_reg &= ~MRVL_XSPI_CLK_DIV;
-		clk_reg |= FIELD_PREP(MRVL_XSPI_CLK_DIV, i);
+		FIELD_MODIFY(MRVL_XSPI_CLK_DIV, &clk_reg, i);
 		clk_reg |= MRVL_XSPI_CLK_ENABLE;
 		clk_reg |= MRVL_XSPI_IRQ_ENABLE;
 		update_clk = true;
-- 
2.53.0

