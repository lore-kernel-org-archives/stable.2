Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1D93D6CA5;
	Thu, 17 Sep 2026 10:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789640198; cv=none; b=kd/Dg+3c6S9qgTLirtDqldJjwoCkkoPJusmS67BBQ7kBAEW1hTf1wqOJDsVCwPuLZoBXzOLz79JFRC1+NXWEoODvz1viZ+r2ixBhz6Tt/afsLWUtIn/Nnyw4yDgsyIhoZVe6wCdYv0985QrPA0LRAzfzq6Eh3kUDck9UgNyyrkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789640198; c=relaxed/simple;
	bh=Jz+LzWvsvtf+xl6zc4tCwPMEpNznmcmjvbrTAwGMMzw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Grdo0PH5fHCd3rpO6Isnxv9XP/PRiZty8UolY2s90QH0InKeM+xhdV1dHo3jlszSpvBl1GyRZXr4AKk+w7AiLW5ckSr6J/9aIh9WZvILZVPsmLWuxUzE2qZY1hWeApy2IlEfQuoM1kJeIJ8g/krjhFyM8TEXzTIu5tJVgw+a1dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from dfae2b116770.home.arpa (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAA3oDr3vatqq29+CA--.404S2;
	Thu, 17 Sep 2026 18:16:23 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: alexandre.belloni@bootlin.com
Cc: bbrezillon@kernel.org,
	claudiu.beznea@tuxon.dev,
	krzk@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	nicolas.ferre@microchip.com,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org
Subject: [PATCH] memory: atmel-ebi: Fix SMC clock reference leak in atmel_ebi_probe()
Date: Thu, 17 Sep 2026 10:16:23 +0000
Message-Id: <20260917101623.2146392-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAA3oDr3vatqq29+CA--.404S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr48Kw1UZFW8KFW5Zr4DXFb_yoW8Gry5pF
	4rWrWjkrs5X3yftanrJFyDua4Fgay8trWakFy2kas7u3WYyFy3Wa4rZFW2qF1DZFWkZ3y3
	t3W8JF4kXFWUZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB2b7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7
	v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0E0s8F02x267IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48Zr
	WUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4UJVWxJr1lIxAIcVC2z280aV
	CY1x0267AKxVW0oVCq3bIYCTnIWIevJa73UjIFyTuYvjxU7WE_DUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwMNA2qrrRk+TwAAsO

atmel_ebi_probe() takes a reference to the SMC clock with
of_clk_get(), stores it in ebi->smc.clk and enables it, but the
reference is never released: the driver has no remove callback and
none of the error paths after the clock has been enabled call
clk_put(), so the reference leaks on the success path and on every
error path.

Drop the reference with clk_put() once the clock has been prepared
and enabled.  The clock itself stays enabled, as the driver needs it
to keep the SMC registers accessible.

Fixes: 87108dc78eb8 ("memory: atmel-ebi: Enable the SMC clock if specified")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
---
 drivers/memory/atmel-ebi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index 8db970da9af9..cd138a3b793c 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -561,8 +561,13 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 		ebi->smc.clk = NULL;
 	}
 	ret = clk_prepare_enable(ebi->smc.clk);
-	if (ret)
+	if (ret) {
+		clk_put(ebi->smc.clk);
 		return ret;
+	}
+
+	/* The clock stays enabled; drop the unneeded consumer reference. */
+	clk_put(ebi->smc.clk);
 
 	/*
 	 * The sama5d3 does not provide an EBICSA register and thus does need
-- 
2.34.1

