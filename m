Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417703;
	b=loMdF3DwuTKfvZRYgi/4QxEnODkKuBaRJnOkXhebRiJj4H3cFJlul04teAicTZdsVH4b
	 GVxiwDMtImvnocYJtJ4O28dKwHNoIwVXMNSah3DLT0fVvxE+9s7BrX0Z65wvuqcMiGnM6
	 9PqPFVszHirLA9hgB5QL6D/5H1Q48PM8TleMKpBy8eYbrdgSnficRK0afJUAaFYvmSg20
	 ljR6AAVIcBqtsj4GpnMoU6D+GsR9EeRzueHFpZP1yhu7JFXgbcqPhZIxg30+oDRnLcgSy
	 SbF2UjWW7uKX8T99gmQ2wnKMKMpInZzhoFIMP09Zy/qUUVWvyxMn0uP9lxj3ee+u1dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417703;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Bg/Kgc6L7imsGE/8F9XOk762txfGaoS9sODIJYRJBdA=;
	b=ECKgYMpGWNB38L1EuvH63kYRJLOafE7OvqW7JZGstjDMfEg262nWJyOg9uQB940AUwsc
	 W/yG9Vgaq+RlUZbiWdA4ZsV8nAAr4BaYfd5EFtnRiS2MUp6Ks1lW6Z/TrwwsMh3ELO1c9
	 VvbYdBTrUHu/CmIB61hPfdOdP0AxTNn4SnezKSYJ7Q7fprdo+nj/Vph9DmI4D0Y28a4sf
	 c2nzznNMJJDAaGdSw3yjP74sM5TSsypbhv8sLYAmTu7vl+lPKcDWpMY/MFywRD5GOJslG
	 GPoBQ3AwLeAgjyhIDjuKKuYs9OoE/T/6hU8ZZtuK2c8EjUlg6Q21O96LC/ZdWe69GYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EooUfdut;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62BC606A33B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EooUfdut
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 162D51F00A05;
	Wed, 11 Nov 2026 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417703;
	bh=Bg/Kgc6L7imsGE/8F9XOk762txfGaoS9sODIJYRJBdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EooUfdutRwUQ1obI4rL/WBLX3IEaSZIh8wXKCYSQ6fI6sd2LsH2lKpmXUklzS1mQD
	 qY5LiLlCJPf25G9Ge8QmuX0xiiuzZitrqA8Fc7JrTUoZS5h493wOr0B/UeE5UIaml4
	 X4mcN8dMf16leJFlMQalJXJ7PwpBQnRRn2K9u9YwOVdKHHADfv6HBiirKv5i1tHI+D
	 0X9DEz97tfFy5tRQEJIphWofaAV4lP87yoD5OrN0SYSv9bgC2vwQKjnaYoACT4hDM1
	 ThjsWHXiW2b0uJBlwRWNCAtBCSMuVObPo6lpl5VCuEWB8LqtXTtzPL3PVN6kn8SYDV
	 Z1mD0psB/KVhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
Date: Wed, 11 Nov 2026 12:21:39 -0500
Message-ID: <20261111172129.3551299-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111172129.3551299-1-sashal@kernel.org>
References: <20261107053946-failed-6.6-1dc3871ce7ec@kernel.org>
 <20261111172129.3551299-1-sashal@kernel.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 653738db38c7c7f0fb959a7870f9461cf4987825 ]

Drop CLK_MAX_IDX define of MA35D1 include. This is not a binding and
should not be placed here. Value is defined in the user driver.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260930-perso-ma35d1-upstream-clk-v6-3-48937ee6c9bb@bootlin.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Stable-dep-of: 1dc3871ce7ec ("clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
index ba2d70f776a6d..2d6a44a7e55c4 100644
--- a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
+++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
@@ -248,6 +248,5 @@
 #define ADC_GATE	233
 #define EADC_DIV	234
 #define EADC_GATE	235
-#define	CLK_MAX_IDX	236
 
 #endif /* __DT_BINDINGS_CLOCK_NUVOTON_MA35D1_CLK_H */
-- 
2.53.0

