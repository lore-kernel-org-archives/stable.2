Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEBE47C0E6
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101274; cv=none; b=SCCUPDrOpvlvXboSph/LQryEbPJIuD98o63JUOqcqPk4RP9mmSMJep6aUQIF/Oq9t9lUcu1zuMoi62Ij8id9AHpJoqFcHqpZF8EH1oyCEB9/rQD7adUtCTiM2TSI/detOja9898Yti3PHmWOaYLQSAtqUcq1qdxaqoP6S9kmLHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101274; c=relaxed/simple;
	bh=I8IiP1if2F0cD9W6jE38uBb6NATYPh2alemak6c3FV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jv4gA4VTuzrg+o+IpbsDLWvI1C1JxioashVszFEaLRmkQC1kkb2H+2boo9zI3uIoWczEoD3ZUhsYjmJ15oTKT5MPq+o0oY6mXu4VnhqHmEPC2y/zPYYCdHfoQtAuVwKiekJHDy6p323p/ShRRm29v9Yzx+zT7XBQJ8KsGFFsCsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxH56BS3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxH56BS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100601F000FF;
	Tue, 22 Sep 2026 18:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790101272;
	bh=B11Z8pV4LCTOInIE/irsiaInR521cLikmcZfDAFEdCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HxH56BS3bSv7fWGAx1vbzRBqk/Q53nfbVkWGsfZjYAOveKIxfU7EzzS+GsXG5XgXn
	 W/Ln2vbIFybo85wc0kYbZnQ//2dhwc56fXRx5NtZthFpv+LJDz6hQI4vC/RYaet/RY
	 TEWkBjPGf7+64ER+N7aYbqyJ4AyiJCWwzN0TYQeAfSZ4id1ugiy28pR626guZpj8mN
	 vLvNxSEC6Mq0Uq+zV2hfgrl1PSRCSf5pnmX+iseaw3czUOGROztCHyYMxvvNxmDGH0
	 PVQdLAS7rrQ2E/8WfAAa7TKwN/0AuxCuiVHO+un8SOqqw4BRToHtzFiRMb7/rHd+af
	 XAHSBbdofTqbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] Input: adp5588-keys - use the right header
Date: Tue, 22 Sep 2026 14:21:07 -0400
Message-ID: <20260922182110.3568173-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092232-wanting-charbroil-6f57@gregkh>
References: <2026092232-wanting-charbroil-6f57@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Linus Walleij <linus.walleij@linaro.org>

[ Upstream commit 9d9bfd180c8e3748be1f1a8843b0b54ed0ef42c9 ]

This keyboard driver is implementing a GPIO driver, so it need
to include <linux/gpio/driver.h> and not the legacy <linux/gpio.h>
header.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20210820222958.57238-1-linus.walleij@linaro.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 21efadc62272 ("Input: adp5588-keys - cache GPIO state before registering the gpiochip")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/adp5588-keys.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/keyboard/adp5588-keys.c b/drivers/input/keyboard/adp5588-keys.c
index 90a59b973d00e..1592da4de3360 100644
--- a/drivers/input/keyboard/adp5588-keys.c
+++ b/drivers/input/keyboard/adp5588-keys.c
@@ -17,7 +17,7 @@
 #include <linux/platform_device.h>
 #include <linux/input.h>
 #include <linux/i2c.h>
-#include <linux/gpio.h>
+#include <linux/gpio/driver.h>
 #include <linux/slab.h>
 
 #include <linux/platform_data/adp5588.h>
-- 
2.53.0

