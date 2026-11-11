Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417119;
	b=EJU8wwfNVHWrzj5UkgpT0qzJWNdfUC8z1kXDdV9U7GMF/pLR5Kl2YHk26j4ccWCsiVYR
	 LtMepkZdLkzpmCAgq7kDqoLYkTTmkGy71r27tJ+mQJD+iTCKY2zzfj3CF7Q3YLLu7Dsnn
	 Wh59z8pCxkh3TybQlQBqZv5Ep7na8SBkfeQ54vakctN74q37yzxaBLabRNBNlM74svgoL
	 WBGGc30wl4lSZOf9KoplA1J1561QPGlYjjT0jli5bOsPgAJBsdyAhRrd1sjYT/C5sZvbb
	 Xuw+taq7YOKM+txotG9zKTmdjvuqPFgZfhTFdaC9HPlqvcnZrbYUs1VBksH2GdIikUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417119;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Bg/Kgc6L7imsGE/8F9XOk762txfGaoS9sODIJYRJBdA=;
	b=S504Ork9AROvQhw2MQo9opgnyeeeGBtXYG3hz0G2O/wUXc192X2rsxtuOaxeZ2KgmFYb
	 Dk7fRhSLn/Cg102tmIB/KKx5fTKkd287J/vhyAj+QA+iTlYA+CTWSVKS4VVt7pH6sJ5Dk
	 mh2LEGHOhyvUu/2HMjpYro4eBkneKPJJlJfc1wW4c8iejUu8z3UlSRpsQHfdilFkeCsxL
	 l4qZjHvzjR/VQ9PH9T3ge6JiL8SW+MGyrmbCBHmEn7RcYAHUIqtieZfrkJnvOiWIgS/KS
	 uZJVVUwAIKhEPheCVSfu1s5nS8z7zT0oR6CJw//7MfpUFuK0E+l7nuEy4oxiEmMFAPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJiTE9sX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SJiTE9sX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD1E1F00A07;
	Wed, 11 Nov 2026 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417118;
	bh=Bg/Kgc6L7imsGE/8F9XOk762txfGaoS9sODIJYRJBdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SJiTE9sX+pMLVivnxHKn83Zr4H/hzXLa5YfSBHSWEC2IYKHWTVesKKIIjsed4CGcH
	 LvhokFJqDO5TPBPLlGF6soWHDLwPXbBYcHZbFLqRdEUSjyhZ+seJaFiSTQPJ+5QdNS
	 /aw8RojtdnioDwYRbZXAzNAKegBrVMPnudftuBo5HVnqzi+A8g1gwArE4HTlxjF72w
	 Eb0UPJeKLlaUcWYTVzWenG2L1auyHhdygIA+zDsrwPNeg4FAfbqphdwQHDFNRPmkjp
	 wh2EFpdyh9e5NXYsU9m6Z1mkt3O2TzwklqLVVsPqYhdVclHEiNX5zIAxGfTwkh237u
	 U49rzzYXZqcEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
Date: Wed, 11 Nov 2026 12:11:54 -0500
Message-ID: <20261111171146.3480409-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111171146.3480409-1-sashal@kernel.org>
References: <20261107051509-failed-6.18-1dc3871ce7ec@kernel.org>
 <20261111171146.3480409-1-sashal@kernel.org>
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

