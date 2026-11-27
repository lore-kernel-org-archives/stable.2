Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795788421;
	b=IWlpJbyxi6MLzXN8xuQAktUO8LBBnwumDiietTfZw+QrSkkE0RSd1KCooJUOr0jJOUQr
	 TcZfBtXDy3qFbzkvTFMbneJQ7u5WpIfnMQ+Y1t16wevRx1LKl/ksA4WhDj7wu0uRrln3O
	 pTzIwQu+FjhCkTW7CxTaLkdIf8vwCerLRIncTwNhk7YIZqx5VtL059cI/sOuB1nWnad1z
	 bJtMziJvTZsWZpSdymzxk09mDTNRToO7aYE71Bp2olOKHG14zco5rv9tfFi/1TABkAweY
	 TPJDPLyzGM13jTsvI+VNIULukd5IpOY9ghIGNchC/oCst4RznMAKF4WDbOqG4qJfGnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795788421;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uNUonCSje6cN/9VgWCRU4BluxhQF/CKb3stuIn8gK6A=;
	b=rjspD+9w6HswIDY/7w1vsbDtqbl4hX6AUYR/G549bwqwNmBhlzF/83Ne9JrSdKKzrG3+
	 /Ty9uPRulG+UgGRnDS0Qs4wMsk5fuS+AK2zV477UcZw7fXgxFL0uJTH8Iev1EL3t9TfT6
	 1mp4/CR4AeRgaErbv+sQAteyJ27VT4kVYKMoces+E9kllxQbOiOKY/knxdd/GJpXV5EXD
	 fEukYJ2yQRa5daUWRXUw7S9n+ENw8hPY0Pw08Bx1lwJqNkld4aps2OF0QGWs6TxRe8KIo
	 w8pWkyyk0KATIW3820a73pC4LlRdsD4JVDvg+bEzXsbgr+2Orut3dXQjTRHCEp70yFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bV36hIyA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EF0606A31C;
	Fri, 27 Nov 2026 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bV36hIyA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267911F00924;
	Fri, 27 Nov 2026 14:06:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795788420;
	bh=uNUonCSje6cN/9VgWCRU4BluxhQF/CKb3stuIn8gK6A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bV36hIyAeeaKzStqZ5R6BHZh20r32LzuGK4Gm68ZCpeAeuz4FlcKODY67wQXGl18L
	 qhz/RMcxsxB2724fbx9/w2S823Krp92tbDIdz7Wjsp7zqt9DxL9qVLU9CACrhHmzre
	 ylrGqUw3rUz1mT5iVjdTi2kG9bRir7oZ9jJcGOUJZ9wzlcSqTXcBfcllWsdXxF0IYP
	 vVS+tuBbMdme5k8hVYX09rN3BdjAwFlZGDHjKU08CG72jY55vuxpuD3Wbf9jjHOiqY
	 i4KEVyHPDf5If9Dyv63xi7Mkz1oJ8u0NkQ9XgA3FmY7Nj5bm41ELYUG4OuWMuL50X0
	 hiAUZOS0GbEHA==
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
Subject: [PATCH v3 07/12] pinctrl: nuvoton: npcm8xx: Propagate npcm8xx_gpio_register() error in probe
Date: Fri, 27 Nov 2026 14:04:55 +0000
Message-ID: <20261127140602.2790001-8-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127140602.2790001-1-lee@kernel.org>
References: <20261127140602.2790001-1-lee@kernel.org>
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
v2 => v3:
 - Rebase onto pinctrl/for-next; no functional changes.

 drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
index 40315e89b839..bf9eb1f0e5aa 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-npcm8xx.c
@@ -2597,7 +2597,7 @@ static int npcm8xx_pinctrl_probe(struct platform_device *pdev)
 
 	ret = npcm8xx_gpio_register(pctrl);
 	if (ret < 0)
-		dev_err_probe(dev, ret, "Failed to register gpio\n");
+		return dev_err_probe(dev, ret, "Failed to register gpio\n");
 
 	return 0;
 }
-- 
2.56.1.839.g22a8290db9-goog

