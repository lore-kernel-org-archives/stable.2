Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606BF335BDB;
	Thu, 27 Aug 2026 14:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787840870; cv=none; b=jsfOMc1/FFU7J6MGczGDs9w3F0s79Wyqd1LPXhXvO6knM2AlOHUcZ88i2fNij+cw+BBWnp99UFICfgUL2xTzXu7+HVnzarUS+3zd6DcOQuSPexMut0SOvgRVWTOS6kkrJRKpbtumHo0eUulvC6vEg3946UP+kU42+O27ixqPiIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787840870; c=relaxed/simple;
	bh=96d1y6IwNLTHpd55ifEQd9+Whi3rWgelovKHkNLq1J8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Qdx3M+I4KZ2WA+9zhT6QCbTiWH8XbzlrRHTuvaN07F+idPWn5nUE0a0k/OOteDS3PWShOQfRl0EcyKTWDcR1BQFrpiN6ovgGABF+OAwgY0yf5swmd+9FOBnLhejcJIv//muGComOToYaOivhLmsYywiFHd/x3lRuySq4ay7uAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxPXoCr3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxPXoCr3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DB34FC19425;
	Thu, 27 Aug 2026 14:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787840869;
	bh=96d1y6IwNLTHpd55ifEQd9+Whi3rWgelovKHkNLq1J8=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=BxPXoCr3q80QCcbic4B0BLtj9jdQ3mYAVR33/5vBgGLshojZEINb0A+4G1EOgLYsw
	 Ofs5xhQAapyLZST8J0xNRDXYD+4I23cnaNTeOp7ZmeRWUAYk0ECvjHKAUhm6+jLnJF
	 h7tXvQO9EfXR9QEFiLju9Kbd3UGptrNuNoGFa/r7vJFzyMLWjMMfDfmeOKQPRMUE+s
	 al0qK0ZP+UelcpsOS0sELbdpBJUxn0071z93pJQwaKHBExYhuIxhZEnHyiFCpQhK3s
	 FCZVV8vECzzRggG/tlvn3sG2Pk0KLSmiyH3JnkkPkd0ggNhHVzKz6r63YcDuHW8T6k
	 yqen3UKtrn4Qg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E51C61DB9;
	Thu, 27 Aug 2026 14:27:49 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Thu, 27 Aug 2026 16:27:41 +0200
Subject: [PATCH] mfd: Fix MAX77705 dependency on regmap
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-deps-reg-max77705-v1-1-c83a74d3d428@ixit.cz>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CQAxA4auQrmlSxkAHrkJcjFCxJvxkimYSw
 t0ddfkt3jvAJKoYdMUBUd5qui4ZVVnA8AjLJKhjNjhyDXnHOMpmGGXCOSRmphrJX+rQkm+ZG8j
 dFuWu6ffsr3/b6/aUYf+O4Dw/ONQoLnUAAAA=
X-Change-ID: 20260827-deps-reg-max77705-0835a9089776
To: Lee Jones <lee@kernel.org>, Dzmitry Sankouski <dsankouski@gmail.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
 phone-devel@vger.kernel.org, stable@vger.kernel.org, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1508; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=QX7JkiZbHlW0D55dPU0RlQr972FkBkLXUTJRO6pdqeY=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBqkElknuZIm/NYkZXg7Xt2bid7sZ6JEAFx+AMRt
 PXGnID3HHaJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCapBJZAAKCRBgAj/E00kg
 chMOEACpS6o4pAozT1WKpIs7KcZyTvKxndxnrZpXi1iGLUPhkGd5dU0GZoiOEk+D5iyY50emJvR
 nw9iLvGZn2TyTgtQzB18XwMVPxUlv6DBYvoR2shXdxRxF5Rll8jh0PCxLPOeT82XOUsudOXmc6B
 1vBGgiCMc8SbRBTw0zK9CLfyKZfUGubRlKxMeNJbgf1MmJh026Pil2SSxNIDQnLH2MVmVmJQzEv
 w5alpjNGPM6T+TIqeBIUoTuZupSHihh4sQTT7OGm7vfHp3IU8BOGqHfFlZRBU3hE/9YaPHsReyL
 NPIFv83r1s1ylog3+sThQItEyqPrJfQH7YCrDT18yYkCeU3hE9+dWWbbf1ujQJvxA17A25u3yjo
 F7pFiz3y/OBO0c8G2XoDnlcDbbenW60rKAPj+mKW6aL7qy5oJ6us/GYM8VNImtA/VFhDMPOT1AF
 R87hOY7D1WRvpeBvGL+7KmwsT2GPkcRksmjqa6avPJC60w83i4dcUuloDoOJoy/bSdjS7f9ROiV
 kQJmPI6l9RmJBpsER/lXnxcTYACTJldjwY9+ATB2ZADpWVrmcseYjD8eMWnQBjVSpavYm4BNyqt
 7RlSi0i+Uzv915slto0Y7TWUU7PUpJbUDD+ALd+Du11DSVUi2qajmCnE4yyxx0GkwhIgYE95/29
 ffzu6KRdQQwYyRQ==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: David Heidelberg <david@ixit.cz>

The max77705 uses devm_regmap_add_irq_chip(), so add REGMAP_IRQ
and REGMAP_I2C to what the core driver selects in order to provide
thise APIs.
This fixes a build error:

drivers/mfd/max77705.o: in function `max77705_i2c_probe':
max77705.c:(.text+0x250): undefined reference to `devm_regmap_add_irq_chip'

Cc: stable@vger.kernel.org
Fixes: c8d50f029748 ("mfd: Add new driver for MAX77705 PMIC")
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 drivers/mfd/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index e4fd4572472f9..857ca3bb0d5bf 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -1001,16 +1001,18 @@ config MFD_MAX77693
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 
 config MFD_MAX77705
 	tristate "Maxim MAX77705 PMIC Support"
 	depends on I2C
 	select MFD_CORE
 	select MFD_SIMPLE_MFD_I2C
+	select REGMAP_I2C
+	select REGMAP_IRQ
 	help
 	  Say yes here to add support for Maxim Integrated MAX77705 PMIC.
 	  This is a Power Management IC with Charger, safe LDOs, Flash, Haptic
 	  and MUIC controls on chip.
 	  This driver provides common support for accessing the device;
 	  additional drivers must be enabled in order to use the functionality
 	  of the device.
 

---
base-commit: 7079a12d7506b07fb53b54a664bfad5fa9b16d70
change-id: 20260827-deps-reg-max77705-0835a9089776

Best regards,
--  
David Heidelberg <david@ixit.cz>


