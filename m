Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317530;
	b=AQwUexSm5efTMFhfS8PkxuzdX3uc/3JkCnT+4EboBmb+aZlqA26AL5X6Q4clD65YKXqM
	 uGsguTJmMwf7Nn92J0z6v6oIeOejaX52nWWzbBtJNdZtUjpGEpwhr+4n29YeOGBEB79Pn
	 fcFUryBnkO/sFcdlbZI9RLrYB7dTFCkWG2L+BxXoj72gKZSk9X3rVpgTBQyXClNAnHwxg
	 GSbfAAfgQzVO3fnYCjpElmW2DVyMRmAqG9Ig9ODX4VHLSzPF9cUh2t2rjgxkUmkwKhuz3
	 PfY/pls01+Z90roUutLY9KBcYUON9k7f0h1oz/2teHPTSRwEaHaCbQwuEzzQLWyk7HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CRAQyvmP7ia5mKc1IH7lF7PjoIR3u3cWfChfv2vBg4U=;
	b=y89tEx11lbKrvlbgXI9CIM6VFO0ASNDYzwXk2ehUTqmqmW4/cuKJiOrXpz+nbmlv+J4U
	 8BbM2WQVT+WEu5IkUzDbX6hh/pH/Ln9IQ0DNx4f8hp+n7zPMrBhOooWBFhasBYnEtfGbU
	 yL6tjcP4MsxR24V9gkAwb1fbKFNeHmW1kLTHuyP2cXkcoSnz8MPJDCrp2gOnRD4/uoo8F
	 k0eTQiXxNkZ1s42QJ5L9yVV5yPzcrtAorpVsvQsK4XyJMMi50SL3Xmh2wvZP9v2rpa6EL
	 PVmGOIF/GJW+oLJImzKwcF0KV/WpqITNOf0hnmIw6ntCnCHt37RojipLJtKIP+a8Tbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUIP+cL7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2567606A768
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cUIP+cL7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3F51F00937;
	Tue, 10 Nov 2026 13:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317529;
	bh=CRAQyvmP7ia5mKc1IH7lF7PjoIR3u3cWfChfv2vBg4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cUIP+cL7LRoduG2E1qAMMd/sJZpFsEtuvjjtWgtJ+WzklsNFZ6IDdWCxZUDIr/3mf
	 IwFRQdNbvL2pI8fVlcQBdsOxjroZCMgt8RKw/R4k3UJFHNasj7p4c9JFvJS5EAX1gK
	 V9a9l4W2ZfETwDAdKmZe3A1k2KH8P/JPxacRTMAGMnVqr/kU8yIDEMHN7C8VoWml7V
	 koYCoq0tboNq8qqSnBcxx3udGE5SDyOZn37FoVD9Lu3yhId4uqNvLWxPV09Zgl0Iky
	 H0vzGZrIwlsG0k0DGjriF9OC1OnkG7DxW6Nbh1VKALtFAOQCTlUulWBBmYZsRiUSP4
	 uLVhE+0v9KxHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: bui duc phuc <phucduc.bui@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] ASoC: stm: stm32_i2s: Drop redundant error messages
Date: Tue, 10 Nov 2026 08:32:06 -0500
Message-ID: <20261110133158.1746140-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107050833-failed-6.18-1b207c85551f@kernel.org>
References: <20261107050833-failed-6.18-1b207c85551f@kernel.org>
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

From: bui duc phuc <phucduc.bui@gmail.com>

[ Upstream commit a6cdfb6230944082e7be64f9166eed64656b1162 ]

Both devm_request_irq() and snd_dmaengine_pcm_register() already log
failures internally. Drop the redundant error messages and return the
original errors directly.

Signed-off-by: bui duc phuc <phucduc.bui@gmail.com>
Link: https://patch.msgid.link/20260720074044.87528-3-phucduc.bui@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 1b207c85551f ("ASoC: stm: stm32_i2s: request IRQ after regmap initialization")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_i2s.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 6ca21780f21d4..100a50a88d6d6 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1245,10 +1245,8 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 
 	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
 			       dev_name(&pdev->dev), i2s);
-	if (ret) {
-		dev_err(&pdev->dev, "irq request returned %d\n", ret);
+	if (ret)
 		return ret;
-	}
 
 	/* Reset */
 	rst = devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
@@ -1302,7 +1300,7 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 	ret = snd_dmaengine_pcm_register(&pdev->dev, &stm32_i2s_pcm_config, 0);
 	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "PCM DMA register error\n");
+		return ret;
 
 	ret = snd_soc_register_component(&pdev->dev, &stm32_i2s_component,
 					 i2s->dai_drv, 1);
-- 
2.53.0

