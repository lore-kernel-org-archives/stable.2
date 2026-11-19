Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121471;
	b=PAJ1kzK4Gx1uynsMqAQWICGW9C4R+8a6zUJJ0mcrmGkcahyKwl0lSh9MAtoEpE/+6Rn8
	 3hEhUJLuz20dkiN65Qh39jsAoHoen1JDz8mO4wirCGrqepcAcrdKZIsZvM8jwwkU7GsxV
	 6THrL28qnuEHhl80zVqrUB0Kk+kj18Qsa6SKZ0EMD45tp8dRmz+72183RXcOf/t4ckMM2
	 JRpEuwJaTslCYvPSzAFJt4B9P1PvbIkz3cGblZze7zao5PlbpnzXgb0qQ3ZttBnwsGhN/
	 ONsGdyjU21M9RNK3G5t2Tmnaezs5gi0WLIdulvAjmDorqiytb7stL7wklMWnjymmSHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121471;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=w785jD0T5Pisp+wBka588XQ3quIRcHgbBG4Ss1sWiiM=;
	b=DTW0zNxPh2yakbwlByIGIBnf4X4OfzJ6EIdOkend1PIKGIZ4xhxhhZg7yc08c4aQoSTy
	 9nOKPRKqgJuOgY5t9Lld8yQ4az8X0t5daUT77CTib5475L3mxeJUHprVe+zTwbjhyouDZ
	 sg9NP85Cn33OyHIOdOkNKSRqiwtd213KEsh07SLQto/uy/LVRLWcLVrKP8jIVG8nS6BYm
	 OFw67ULby9VlgrDYxZMB+Tvwi7+C11NMyBNkO1lgYmj6EQT9plm/jWLqgAYL2bWIFxTl5
	 FA2ehlpnBu0N/dRmQZGijLiMOLP3Wq1/ysIk7qE+zSxUHdqhDAAgPll+YP6Mp3jn+mA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHlDrqmA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1CB7606A337;
	Thu, 19 Nov 2026 20:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FHlDrqmA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB431F000C0;
	Thu, 19 Nov 2026 20:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121470;
	bh=w785jD0T5Pisp+wBka588XQ3quIRcHgbBG4Ss1sWiiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHlDrqmAGyVJJ7jlxOJX97khMiyrO1bJh1YQjOX338pdI0aV/CFTHOAc8TKSHLpLh
	 JfrK09s/D/DV6NTZwWzyUEabN0dZH8HONmxWe2LeJUowptsHR/BH4L+78qkkhY4k/l
	 dsyL84ggcTSqpAbOTXwR4Mx0nh5d8nQhwFLMimJWyBlwwIaQfYKjEpkuBzkYN1nZ/l
	 iXAHia1aHVkb0muu7TjpjyXiuUReXqF1H13//gNbxwgizzCSnN/QkGvaLOVm/dZ9ne
	 2eCDUzTE1ea72iXo6mPXAT7W8HD3JrzxwSULikzcWzaH+m9ZtzAHP+zJ8Q/txAt1Op
	 Yx32gyc4zJI6A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	Linus Walleij <linusw@kernel.org>,
	tomer.maimon@nuvoton.com,
	openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 07/12] pinctrl: nuvoton: npcm8xx: Propagate npcm8xx_gpio_register() error in probe
Date: Thu, 19 Nov 2026 20:49:03 +0000
Message-ID: <20261119205013.2563811-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261119205013.2563811-1-lee@kernel.org>
References: <20261119205013.2563811-1-lee@kernel.org>
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

npcm8xx_pinctrl_probe() logs an error with dev_err_probe() when
npcm8xx_gpio_register() fails, but omits the return statement and
returns 0 instead.  Propagate the error returned by dev_err_probe().

Fixes: acf4884a5717 ("pinctrl: nuvoton: add NPCM8XX pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-cff468bb-80b4-4cb3-a5ff-2b3a8fdb151f
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index f300c3cd924a..6c124d8129bb 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -2598,7 +2598,7 @@ static int npcm8xx_pinctrl_probe(struct platform_device *pdev)
 
 	ret = npcm8xx_gpio_register(pctrl);
 	if (ret < 0)
-		dev_err_probe(dev, ret, "Failed to register gpio\n");
+		return dev_err_probe(dev, ret, "Failed to register gpio\n");
 
 	return 0;
 }
-- 
2.56.1.750.gf70dc682cf-goog

