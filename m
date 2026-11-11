Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434020;
	b=rClpgrxJNKCgLp0g5zinwfw2rCU9rSLHe5kr18cBvmXtpUEbGXlMIa0mmIt1/PPj21G6
	 unDqCWR9ybtTtoCxngbBQYX0+X5A55v7+RJTEwPSvnFwVGATh3FG/Uxj9rpen3qDzhOZb
	 c13RjN4Cv91YS3tI6012rlxnIV/qrO3ZZSL6T4/CUZeioLZ22APz41omHgE8aZppb9vdY
	 Kl0xkEawx3BidGIaGmiEO1F1GCfyWJ8nnMq8lnpO5GefGbl/COTqGAfAcp5hvwMSc5US2
	 aBSvxJNYGicXfs6S4LKmH0GOlXEgLD7Br1pTXmbx6Pf+HoBIBUnSLZtBKfqqEHH3icw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434020;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=apIjcWhf6ft4S9T/nv2WWzs4no0FMzMPTMX+Kk+3eYs=;
	b=3oZZjGlstpW1b+c2ZoEGV03U09kvrhDS9HNz85QOfAMDo7Jk0aRKm9EC58CsFKGPa5uJ
	 RQdofetl7Jlic+rDB4tLl0kNkXBuyJiNDK/1Pp79HvVDAr2W+xZLIDYt5CEH1yIpl/qVh
	 3gi5dm5byuD0Ca4Cepvb8TjOLB9HG2AL6ElWTOlEF6V63RkpbGuf7U9H5q5iXKXJN+ZKS
	 TvBy2mLVq1+Rgs+znxPYNMJ1NJIAW1bii2O5uA042GJcsqtngsCvVegGJckrGNjXMAFP9
	 2FypwJ4M7tTwmvCiXi9cojRTscAN3Yprd7JJVA+1InFYr1ZQuE1By1NkV4ynsh3qKYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cc/97iSa";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9A1606A332;
	Wed, 11 Nov 2026 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cc/97iSa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 524451F00A05;
	Wed, 11 Nov 2026 21:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434020;
	bh=apIjcWhf6ft4S9T/nv2WWzs4no0FMzMPTMX+Kk+3eYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Cc/97iSavrA4IxIRd9mCOgRBAgykrO3P1diDKl3/aXyIRxwlJUUqpSPMSCXNw1mtn
	 iIVVYAuIXAY6urRd2MMraBg+A6Mf72dwzWVIWhyKArx0SHdRNjgUtELQxQMbFQhX/t
	 O7ofOti9Apk1c3OdSIIsAyasg63o96z4exmcJgmTd9TCASpwDYIdeFc6RM3sy8QdQN
	 hQqL2KrN5zXN7L77iZhjirgCf+Wb7iKRaWTC+6CShMrtyJH68UzPbm05mvCDr00xU5
	 T3Emo8nbPf5wMCebGmxAgfciuCVQsIPx2sM+7wcFyYZJskgZRtXczzsu4/KcaMbruI
	 FnQbO5/eWaYgw==
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
Subject: [PATCH 05/10] pinctrl: nuvoton: npcm8xx: Propagate npcm8xx_gpio_register() error in probe
Date: Wed, 11 Nov 2026 21:51:50 +0000
Message-ID: <20261111215256.1982044-6-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
In-Reply-To: <20261111215256.1982044-1-lee@kernel.org>
References: <20261111215256.1982044-1-lee@kernel.org>
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
 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 6150cde7e824..8a7cc46b5001 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -2583,7 +2583,7 @@ static int npcm8xx_pinctrl_probe(struct platform_device *pdev)
 
 	ret = npcm8xx_gpio_register(pctrl);
 	if (ret < 0)
-		dev_err_probe(dev, ret, "Failed to register gpio\n");
+		return dev_err_probe(dev, ret, "Failed to register gpio\n");
 
 	return 0;
 }
-- 
2.56.0.567.gdb80ae8cd5-goog

