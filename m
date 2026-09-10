Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D85318BB5
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045323; cv=none; b=cfX33YTTHW7qsMJ9vZCJv5ifJ/b8VKlZSrckuiJfI/AYTsjZLewTOs5CAuKcgeGx4QHD8ABxLh7Ha7xnxtmBmgOxwwzcG+wsQKHYXTfCRyV8Zy5T6M55+r8lU2OtXjlyXQcdN/+GXY1bSZU10yxaf1y00AZFcXA+R9hXPQh6WHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045323; c=relaxed/simple;
	bh=jikTayNHV/L9SQXJvcq6crS10HxBDegdeL01aA/ICco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkppPbtQ3IoLNmKB6hbDrQFbGxELBE/nChkbbzfy02o5qDzMrHAf6GqXg6Db8R6R9mqZ1j39wGGGmVEj9raXIK0hkeOsB8GN2Q+cv8sODUs+8NSFGiV5wL8sLw3ZVpcJIudpYECpTygQZ0XK+5GuIKtf3y96p3z/GAFluq1BD00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuLF2Q7g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuLF2Q7g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A584A1F00893;
	Thu, 10 Sep 2026 13:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045321;
	bh=HAi/jszH7lTqEDYr2Z4419NO0ngnlEkHbnCebU2u7wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TuLF2Q7gMjW4Eqo/1c73fniRkMKIOTTLLHVxreaH4LVey8pUrs6CQg6Y8o+ACuhP4
	 4TmHTHfHS51VwIvUScqmimPSY1gxLvYSa5+bgS1DP6elCTIve+PhlAT/q1iaU7CaiW
	 W7DsMY6xobYq6PeKS9sJp5Lu39ylUB9siptzB7gU5EIuPlsPmEIdbplC8/fwZOYC5a
	 ScLVXef3R9MB9Lh+XtTtxPSqDunZpF9/R1QD/QGPUR16z2TrfvU96JczSjcy4aVpsk
	 FA2WIQMaGwfBMrZ/qBgJKAdaPvvmFnbOt9+PmWSYwU8ezwb8uz51b/M5g/4MRt+1Z5
	 OPlMoWBIGZvoQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Can Peng <pengcan@kylinos.cn>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] spi: bcm63xx: disable clock on resume failure
Date: Thu, 10 Sep 2026 09:01:59 -0400
Message-ID: <20260910130159.211467-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090843-quintet-dyslexic-a9ee@gregkh>
References: <2026090843-quintet-dyslexic-a9ee@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Can Peng <pengcan@kylinos.cn>

[ Upstream commit 2b62c2c134fa32d9d3a9e7323c8ac74518eeb4ac ]

bcm63xx_spi_resume() enables the controller clock before restarting the
SPI controller queue.

If spi_controller_resume() fails, the function currently reports success
and leaves the clock enabled. Propagate the error and disable the clock
before returning.

Fixes: b42dfed83d95 ("spi: add Broadcom BCM63xx SPI controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Can Peng <pengcan@kylinos.cn>
Link: https://patch.msgid.link/20260804071831.860784-1-pengcan@kylinos.cn
Signed-off-by: Mark Brown <broonie@kernel.org>
[ changed spi_controller_resume(host) to spi_master_resume(master) to match the older API and variable name. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-bcm63xx.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index e05f8913ccda9..0c4735f58c6e6 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -665,7 +665,11 @@ static int bcm63xx_spi_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	spi_master_resume(master);
+	ret = spi_master_resume(master);
+	if (ret) {
+		clk_disable_unprepare(bs->clk);
+		return ret;
+	}
 
 	return 0;
 }
-- 
2.53.0

