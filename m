Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434005;
	b=gY1klUS7S420QNuzjuCXzW3uDT3iETHh9zIfQ/WzrdhvMUL3NgbfnvlAdmzYeG8D4a0Z
	 aKmBfrNTsbDpJpgtybNIE4PUEkd36t/BlqJdFMzupb8UjTF6Jij2dwWOa/G/dJYu1D538
	 9iCCF1Vkqpo0s32Y8iaFjRvTQcWlL20oqeyrsLquK0UOZLjbyICaRCo+uuKVxcISRLfJ2
	 SCkV9Y/JJGOX71QEdr5XEHVpT5blw7FumBmwXozRFc3dwaRy0xWtFAc2rkyHyqlvfk6JC
	 vC18prf5xIuHx8zWODabdr10vpRyz5RXwPs7BrIN6gfelhnwCuqe4oejoKHws1xcr8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RUt0eamBGSiAqwO2GwEE5rxkTrKqiDLlnkwJFDQBAZY=;
	b=RG9KN7LEEchoen1gQlhIJckV6Q0th6feyQMYzG9um1z6O6O2b0yGuImbksn6V4wujXCS
	 AbsWgvDLq60LySjr5rhyQQ83nw1LNs2boYJShYM3HvDeedGrQu28nqUQhQaBeBdDcbABw
	 GuUcWQFYoj34dzORf8jafGjIkhIz2yxb2mfspzxbihsg7Ol4bb5Vs2r39rLM5l1uxZPM8
	 UVVXN1PsxMOsF9sIKQ0pOWYnIZiHQGi1rC2lq39pjESg/PpFRjZha7DiDgOuXPom/Ssqb
	 mAzD+77mVcTnQNuuY3XeGCf+vb6ULza9PyiRcY9RfglFDN5RuLK0NfZNYkBFq5ZRk/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUN41KzK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE50606A327;
	Wed, 11 Nov 2026 21:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XUN41KzK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ECB1F00A09;
	Wed, 11 Nov 2026 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434004;
	bh=RUt0eamBGSiAqwO2GwEE5rxkTrKqiDLlnkwJFDQBAZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XUN41KzKEErQDu4KreLiURpr6gTZ2b6tx0kXuUbvlgJ7+h2AlXbpobqVsyQMa4ecL
	 NqGHozL9jmzC8t2lqx81lzjal9mna0itUSOnfwF9wIRxrirIAnBfMlpkdVNsU86fv8
	 tQE0qWUPk9S4ibEnEOvzJ5euemD0FDLO8pF+ckvUaCEK5uhEpOtH+W/xXPPZ+WjjM8
	 NjxfRFvIMNxHwJHxVxYuNktLN+vG9JlorSPxZBuKxshGXeQ7fIvvTAC3uIEAdINCqJ
	 mGAzrNuJxbW5M29AcnmKhivp2Xapgot6+8EtBx0HRpSGcsJgbCWL93QWsQp7DTs/GX
	 l/+y0nw8LBq7A==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Linus Walleij <linusw@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] pinctrl: nuvoton: ma35: Assign fwnode to gpio_chip in ma35_gpiolib_register()
Date: Wed, 11 Nov 2026 21:51:48 +0000
Message-ID: <20261111215256.1982044-4-lee@kernel.org>
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
 drivers/pinctrl/nuvoton/pinctrl-ma35.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/nuvoton/pinctrl-ma35.c b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
index 04528e734bc9..25c66b9e8dd2 100644
--- a/drivers/pinctrl/nuvoton/pinctrl-ma35.c
+++ b/drivers/pinctrl/nuvoton/pinctrl-ma35.c
@@ -518,6 +518,7 @@ static int ma35_gpiolib_register(struct platform_device *pdev, struct ma35_pinct
 		bank->irqinten = 0;
 		bank->chip.label = bank->name;
 		bank->chip.parent = &pdev->dev;
+		bank->chip.fwnode = bank->fwnode;
 		bank->chip.request = ma35_gpio_core_to_request;
 		bank->chip.direction_input = ma35_gpio_core_direction_in;
 		bank->chip.direction_output = ma35_gpio_core_direction_out;
-- 
2.56.0.567.gdb80ae8cd5-goog

