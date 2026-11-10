Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320353;
	b=EFTCz9BlY0n8r1ZAauM2U++YjhLqtKGxzGxuxUCqD8GQc3NMYw40TL+QL7CQxs2WXmAz
	 0fcHa0AUI0XdCgLR4DYwpsKisR/TyFw4td83X5VvM/modf9nafSU+1w1tCow1rfK0H1Em
	 sjScXH2qvjlA/DZxfLrxnYzij61km3bRznP4hLLUtg97I8/9BidraxrhJbycQYv46ClXA
	 yGtaAtV3u7dZA3npUvCYImMNby2AtMay1U6vGNlEdW4rYwuN+XD7mTmVXaS/mC34IVnr6
	 pktFzCvzMSImCOmTEPWoxRoGNkitTglriqcBuqeKxj2O0srpZroNANLRvsqJ1FuJoKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320353;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=L+uc25INgXGPnWiudSZ6csjUHBw27vA/kBtTDTIkbAc=;
	b=zwIed3PzHvfzLz12TdYQrnDicLMozBiJYv8qC+/XTqk6/ZIX/PRhk/p3+I4n1Uhi+3rX
	 XIrav5BlKurMhriBepwSfMD5tMwlAgBuYrRcJ3/t83QsymxueozOUlMwCUtCGCV/GB0EZ
	 x5nsRU4am8gFLq6RhorUIseqFghed3SKbH1M5REvrs8HMzCgjF7g/041/Tyed5vXCLP6i
	 qmKjE3nx8k+Ml8Ke3xGLm6VthfZsQ6KXKGkLIbqopnLMV9tbM1EuRoSQmEO+bcg1zkLEK
	 9OrNtZYeydROSsL1GlT2boeR/EFlhE5fBevIHZei+UF5EsjyoFOClORnrPERbL5DiOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1xte0Vj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C230F606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1xte0Vj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14CE1F0089F;
	Tue, 10 Nov 2026 14:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320352;
	bh=L+uc25INgXGPnWiudSZ6csjUHBw27vA/kBtTDTIkbAc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1xte0Vj0MUZaDXUj57a9YQcr2HhfCzLB6744JMBi2LxHEHg+g+G/yuyA4pjPkALR
	 WWHvOIk1XMHeHI6UUkh4aU2cGjoWEMXr7QldHXtVHLDihQ2t/CIuZmvDhc0kFwtJlX
	 F+uzWMrMykN5Ggh8zpvHWOzCokwmrzK7TZF9vj0eQUpKUQg8zmV3yuucpqtl/pMwfM
	 rCgEb56oHZpbDo7QES0G/iksPNCY3O/DC04Rs3pN4jNE7dDNq34NqPQY3wtpGVrfZt
	 SjKRCPvaSCLE6wO4QTUO4d3WaIlORFD5E1WJd0WFYqsSjVc5fiACesqltcVNwVC9t6
	 KOU2yowBrblgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] spi: atmel-quadspi: balance runtime PM and pclk across system sleep
Date: Tue, 10 Nov 2026 09:19:09 -0500
Message-ID: <20261110141901.1859701-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110141901.1859701-1-sashal@kernel.org>
References: <20261107050822-failed-6.18-717e45f97246@kernel.org>
 <20261110141901.1859701-1-sashal@kernel.org>
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

From: Karl Mehltretter <kmehltretter@gmail.com>

[ Upstream commit 717e45f97246d1070cdf86ccd7a0fb872b45933a ]

On the controllers with a generic clock (SAMA7G5, SAMA7D65, SAM9X7 and
LAN969x), atmel_qspi_suspend() takes a runtime PM reference and returns
without dropping it or suspending the device. It disables the peripheral
clock directly. atmel_qspi_resume() only prepares the peripheral clock
and then reinitializes the controller with that clock still off.

On a SAM9X75 Curiosity board, the tested standby and mem resumes
failed:

  atmel_qspi f0014000.spi: PM: failed to resume: error -110
  spi-nor spi0.0: resume() failed

Reading the flash afterwards returned no data. The runtime usage count
grew by one with each cycle, and the second suspend disabled the
peripheral clock again:

  WARNING: drivers/clk/clk.c:1257 at clk_core_disable+0x6c/0xcc
  qspi_clk already disabled

Use the same runtime PM sequence as the other variants. Suspend disables
the controller and forces a runtime suspend. Resume forces a runtime
resume, which enables the peripheral clock, before it runs the init
callback, and drops the reference afterwards. With this change the
tested resumes succeed on the board in both modes, the controller
returns to runtime suspend, and the flash reads back.

Fixes: 5af42209a4d2 ("spi: atmel-quadspi: Add support for sama7g5 QSPI")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260709112006.390742-1-robert.marko%40sartura.hr?part=3
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
Link: https://patch.msgid.link/20260923012950.15651-1-kmehltretter@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/atmel-quadspi.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
index a917530f81741..d3c14e2ec8c86 100644
--- a/drivers/spi/atmel-quadspi.c
+++ b/drivers/spi/atmel-quadspi.c
@@ -1543,12 +1543,14 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
 
 	if (aq->caps->has_gclk) {
 		ret = atmel_qspi_sama7g5_suspend(aq);
-		clk_disable_unprepare(aq->pclk);
-		return ret;
+		if (ret) {
+			pm_runtime_put_autosuspend(dev);
+			return ret;
+		}
+	} else {
+		atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
 	}
 
-	atmel_qspi_write(QSPI_CR_QSPIDIS, aq, QSPI_CR);
-
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_force_suspend(dev);
 
@@ -1574,20 +1576,20 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
 		return ret;
 	}
 
-	if (aq->caps->has_gclk)
-		return aq->caps->init(aq);
-
 	ret = pm_runtime_force_resume(dev);
 	if (ret < 0)
 		return ret;
 
-	atmel_qspi_init(aq);
-
-	atmel_qspi_write(aq->scr, aq, QSPI_SCR);
+	if (aq->caps->has_gclk) {
+		ret = aq->caps->init(aq);
+	} else {
+		atmel_qspi_init(aq);
+		atmel_qspi_write(aq->scr, aq, QSPI_SCR);
+	}
 
 	pm_runtime_put_autosuspend(dev);
 
-	return 0;
+	return ret;
 }
 
 static int __maybe_unused atmel_qspi_runtime_suspend(struct device *dev)
-- 
2.53.0

