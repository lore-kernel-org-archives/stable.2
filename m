Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2106036F909;
	Sun, 11 Oct 2026 06:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791699546; cv=none; b=BrhGvVqQKKETUo1UPttv4ftPiLqIj03gKVkcG+P6ugliAe4FNUUCnTwhVrRVD7R49x1L9XE0slQ26iR4qgLQ2JIabP8C/UMuTBTmiE6LWJDxhaUCGW4TleFDBzgo7t6GYa76+9ukWl7fq5qWE5ua16dfqRQfz7EmlWUxyHNe1Zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791699546; c=relaxed/simple;
	bh=MuWYjdaVT1yepwtgr2yHBEgjcM66qMMVSid18CYf9J4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dd3PxAEwkeMr9AabgLKXwWwKl3B4400VqZF+neePMT1Ma4AqUmWlW9+rDhC8vB5AoILj3WmQkl9GsA1u0tWAaJZCx+WKvJ9m5DYz+jn0N0TuOfOLwj8lQsKNL4nqvone11763w+LxM/1NnAUoz5jfv5Dwq+fXxBX9xDOKhYYy2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Ip664CDl; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Ip664CDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xl
	PPE6ZZY5T3PHV8A3Y8GqCesIvtKJSCm08ZYgXZh9o=; b=Ip664CDl9k8ge8BOcr
	Bk3pQIeHiS32Bi5f536z8MaYRmAzm9HycFVee37BNUm68+38atxAHIk3lXRY2vZh
	+mRtUi8iYiquxQuJzmgMU5Gzs1uF6c2B64aLBYBFncA784mkx9YZiMGGMgNgMpl7
	KGvxn//yRvb+Jr7pVJbaYU5wY=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDHjyr0KctqdBPSDg--.48609S4;
	Sun, 11 Oct 2026 14:17:33 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: antonio.borneo@foss.st.com,
	linusw@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	andriy.shevchenko@linux.intel.com,
	fabien.dessenne@foss.st.com
Cc: linux-gpio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] pinctrl: stm32: Fix fwnode reference leak in stm32_gpiolib_register_bank()
Date: Sun, 11 Oct 2026 14:17:22 +0800
Message-ID: <20261011061722.3159941-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDHjyr0KctqdBPSDg--.48609S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw4DXFyDXw4fuF15CF4rZrb_yoW8CryfpF
	W3Kr4YkFs8XrZ0k3yUAw1Y9ryagayxtrZxCF4Iy34fuFn0yay7Xw45uFWSvrs0kFWxXwn8
	tryUJay5ZF1DAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9R0XImrLKf00YAAA38

stm32_gpiolib_register_bank() walks the "gpio-ranges" property with
fwnode_property_get_reference_args().  As documented in
drivers/base/property.c:

 * The caller is responsible for calling fwnode_handle_put() on the
 * returned @args->fwnode pointer.

The returned reference is never put.  The function calls the helper
twice, once directly and then repeatedly in a while loop, and each
call overwrites args, so only the last reference is even reachable
and all the earlier ones are leaked for good.

Put the reference as soon as args.args[] has been consumed, both for
the initial call and for every iteration of the loop.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: bb949ed9b16b ("pinctrl: stm32: Switch to use for_each_gpiochip_node() helper")
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/pinctrl/stm32/pinctrl-stm32.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/stm32/pinctrl-stm32.c b/drivers/pinctrl/stm32/pinctrl-stm32.c
index 6a99708a5a23..93127da05d56 100644
--- a/drivers/pinctrl/stm32/pinctrl-stm32.c
+++ b/drivers/pinctrl/stm32/pinctrl-stm32.c
@@ -1666,8 +1666,12 @@ static int stm32_gpiolib_register_bank(struct stm32_pinctrl *pctl, struct fwnode
 
 		/* get the last defined gpio line (offset + nb of pins) */
 		npins = args.args[0] + args.args[2];
-		while (!fwnode_property_get_reference_args(fwnode, "gpio-ranges", NULL, 3, ++i, &args))
+		fwnode_handle_put(args.fwnode);
+
+		while (!fwnode_property_get_reference_args(fwnode, "gpio-ranges", NULL, 3, ++i, &args)) {
 			npins = max(npins, (int)(args.args[0] + args.args[2]));
+			fwnode_handle_put(args.fwnode);
+		}
 	} else {
 		bank_nr = pctl->nbanks;
 		bank->gpio_chip.base = bank_nr * STM32_GPIO_PINS_PER_BANK;
-- 
2.43.0

