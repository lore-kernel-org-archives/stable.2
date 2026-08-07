Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8DE2F6577
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 03:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786073694; cv=none; b=CVoZqlYBg1roRPf5++SOcMqIl4NtuLH+oPrPfz0Xq8XqW5vWwG4UYQhtpjrlyJ4JAfqM+FmqetejCE4KGKW4G6SE7gJ4OY+BTpaiqd3f7p175tNUC+X2e5DsNUv1zJ11bK7yVTsxF2nBuvrrvP2zsYvYsjH88NfQZ5Z/Rk3bl1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786073694; c=relaxed/simple;
	bh=nO7xa9aLLipAH3KLuWFr2WHYBZ6Qwyw+NPWNOip8dEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6gvmY0gmYrPoLQ4of7l5mVGlijIcQJWReDBEXmSTqDIb6jyKiMyDVPwnPOm4zeTvf7eKc5wXHUx0hOpZSxdhnPvALjb+f/DHcLezlM78zXGj0fR4EfDb5QsvX66mfpP573CmS7zwwtaO6f57dYicHtvzc/bXRTcUO+df+X7tz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O4KK54T8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O4KK54T8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED901F00A3D;
	Fri,  7 Aug 2026 03:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786073692;
	bh=ARkC/ZXubiYFkuNUuykK5LS4XF2xnlwh9oIFD+uUroU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O4KK54T8NCCBV//FXNiwr+sLKRwoCXYkcUp+Amj6X+RUPmRQuM3aZL0AQFmonB027
	 sHZ1C5IXnwrJudX0M77LEvaNP2nNNoew+mIZZuJ66vOTsoDumBMvlLaS3VScoLgD2e
	 mxSQM2wVApJU0A7ZeObV608RMvg4pHPLS/9wjWDVUNRqLnzJQn7n3RvV0PKo/BORev
	 Ek6ptZ8uPvQzr5q+OwjQnqjmjjwQb1uGUo2n+rD5k4hsLHUDsX38E0a5PlBAaPfrHO
	 dJvmzbLje97PvrU6kzJUDWMNFdbUAgkRdwB/yWEI0IkQjkiSp3uQ5tUMMiRwv2Dk3b
	 QHaRwPDXBtHZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Lech Perczak <lech.perczak@camlingroup.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/5] serial: sc16is7xx: remove obsolete out_thread label
Date: Thu,  6 Aug 2026 23:34:46 -0400
Message-ID: <20260807033449.1725763-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807033449.1725763-1-sashal@kernel.org>
References: <2026072914-sandbar-very-7f7d@gregkh>
 <20260807033449.1725763-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hugo Villeneuve <hvilleneuve@dimonoff.com>

[ Upstream commit dabc54a45711fe77674a6c0348231e00e66bd567 ]

Commit c8f71b49ee4d ("serial: sc16is7xx: setup GPIO controller later
in probe") moved GPIO setup code later in probe function. Doing so
also required to move ports cleanup code (out_ports label) after the
GPIO cleanup code.

After these moves, the out_thread label becomes misplaced and makes
part of the cleanup code illogical.

This patch remove the now obsolete out_thread label and make GPIO
setup code jump to out_ports label if it fails.

Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Reviewed-by: Lech Perczak <lech.perczak@camlingroup.com>
Tested-by: Lech Perczak <lech.perczak@camlingroup.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20230807214556.540627-3-hugo@hugovil.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: af071d9e07e5 ("serial: sc16is7xx: implement gpio get_direction() callback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/sc16is7xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index 717ba88a23d21..236388776430c 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -1397,7 +1397,7 @@ static int sc16is7xx_probe(struct device *dev,
 		s->gpio.can_sleep	 = 1;
 		ret = gpiochip_add_data(&s->gpio, s);
 		if (ret)
-			goto out_thread;
+			goto out_ports;
 	}
 #endif
 
@@ -1423,8 +1423,6 @@ static int sc16is7xx_probe(struct device *dev,
 #ifdef CONFIG_GPIOLIB
 	if (devtype->nr_gpio)
 		gpiochip_remove(&s->gpio);
-
-out_thread:
 #endif
 
 out_ports:
-- 
2.53.0

