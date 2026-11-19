Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121445;
	b=gnqrSfcxCVAUHoFu4q8wHBBUBd6pHs8/nvBANkkjU2bSzqSkCReBW+7beaTx34i82F6J
	 r45/QS43R14gNRhcpq7S5PzwHuQNsu9fxRKBNxZTdJg9/k52fQpCkXn0Y895K7rN9dDWB
	 zfeaM+aWaHqmdDkRSi2R1ZuMBSohbZighyrUMayppkoLJKvtNJdXeMHeA2nusqhYMJ+Xs
	 9yqWUJMuodjH8JPW8dTzOXHnbjPIj6rWW2XQZiEtITelOGfnmL2+iFgjXar0va9dd0Jl3
	 qf8HW0BubNDxRwgsTf09NBaJ4pMdTdENlxcNovfmM8AiFixYQYBD19LKdaXDgC4ht9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121445;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FDB56P32FDl6bNezdwAQqP1h7o3uxulTq1XdU+fw3Dc=;
	b=EuE5Os0SlGvOwZdzl+jznqu7IanATT9lkq4+JO7izqUIENIwzrJld0uW2o15SScVAq6p
	 DXk1jIYipC/ES+3SfKoj6Ey1IAlFP05bD/uEB22KSaCjAo4nWEQJehGAHagCkl3QcHPhD
	 zk9K+WB9g1zeTF5M+Dju84iBWpvQXQ+dC0zm2KzTIkrUDAhxEs2padP2a0XqaDAEYyEBR
	 /mEG8Jg+yohIaHLABfSZwcnOnqpZLd4lLhFnHySSYkfcrpdp6lSpVJbshZcfaUm208vrV
	 /JszYB3rzH18d1O6Hg5As0VfJ1J2TQkiH88PC9jRdiPdLhoFG0ramexwrwpgJZYfM9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7n02MHz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A405606A904;
	Thu, 19 Nov 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k7n02MHz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACA301F000C4;
	Thu, 19 Nov 2026 20:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121445;
	bh=FDB56P32FDl6bNezdwAQqP1h7o3uxulTq1XdU+fw3Dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k7n02MHztF0PvsBN+690dzA3kvbjK4CRb1fMM0D3f0cFAmO5F267CgygHQZ9Z0/AC
	 jIDOp9koldOGaQcEwCo92stfsidMLOcD3n3w3Id07rWsw6q3fm2/gpeSHTR1wgastJ
	 mY/1XbhhrF0xC4sudKcprrg7SVuGwklHHxSdhJe4Mpvc9e4gv1SLLXZF5lkvfMp1oO
	 Zsyn/1p51f0X2s7/pAUjTSpjYshV0sC8SQ2zXJz7Ejg/JrfQp3b5+hVz38bzQwVzzV
	 IPRScHZgjSYZ0u5V8ljPaFELbkHtoONu28JUxQJWlN2TYUlWjNfhGMjkZAqWLcfYT5
	 rfjdaF4pyYKPQ==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 04/12] pinctrl: nuvoton: ma35: Assign fwnode to gpio_chip in ma35_gpiolib_register()
Date: Thu, 19 Nov 2026 20:49:00 +0000
Message-ID: <20261119205013.2563811-5-lee@kernel.org>
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

ma35_gpiolib_register() registers all 14 GPIO banks under the same
parent platform device without setting bank->chip.fwnode to the child
bank node.  Consequently, all GPIO banks share the parent pinctrl node
for OF/fwnode lookups, preventing consumer drivers from resolving
phandles to individual GPIO bank child nodes (&gpiob, &gpioc, etc.).

Set bank->chip.fwnode to bank->fwnode before registering each GPIO
chip.

Fixes: f805e356313b ("pinctrl: nuvoton: Add ma35d1 pinctrl and GPIO driver")
Closes: https://sashiko.dev/#/bug/linux-cbafd8f2-6541-4311-b97b-f7285d2e1992
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2: No changes

 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index c9e09c14a101..a92945b7821f 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -519,6 +519,7 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 		bank->irqinten = 0;
 		bank->chip.label = bank->name;
 		bank->chip.parent = &pdev->dev;
+		bank->chip.fwnode = bank->fwnode;
 		bank->chip.request = ma35_gpio_core_to_request;
 		bank->chip.direction_input = ma35_gpio_core_direction_in;
 		bank->chip.direction_output = ma35_gpio_core_direction_out;
-- 
2.56.1.750.gf70dc682cf-goog

