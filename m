Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417361;
	b=m9HtoU2T3NmYyQ+talm7kMGjiPTSKwC1jvvDXfyzHyyx91apRGimBcywmrQruhVJ6mO3
	 tgve6rPSRQabj3Z372OyWrU0u/u+6GVp0mU1PZjZqW8voQlgDYdVAzD/RJjMF6v21b1SQ
	 S8tZNUdRMBJ1frsDF8VXNAEcA8soiRzKvKobo7EOZ4LGVzkLjGlo3NOFGKxmxG650nCH5
	 PyIg3CtQkqNJE4U6nEXi3TGYfCzu3IqT9wkDnzkaUDhxP+onpleCpaDFtwZ3tkCg0aMD8
	 EfL9EZgqMhJoY146xp13iqmkhPjZkYxgl64jeu6hathM2qb6/XTjxxq8eF6L2gA0Kpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417361;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Bg/Kgc6L7imsGE/8F9XOk762txfGaoS9sODIJYRJBdA=;
	b=NlxVA2kikADa9vedgL2G7c5pzoryB4QG0DFolWWnGTu/PEdhFreTqF8zGKGRQfxfvlGP
	 UrIlcDjAHGenbIrkX8LhqHeMOmHiIWNWPhSDoel+8jJKbJ3l4BkjlknWoU7Bv0KCntEV+
	 +MyhqOAikqdh8OucJggnO8MqyMSHIBPinNEI6jwf7z+fYabC0ffxsdclkDMamDu1uqpkz
	 UqPXAyar7UffpX9LIKDsl9Gk+a0x0C4OwhWlfASsDfeeyC2Z76mF2e3bCfI4jUF6jzaoZ
	 JZE4jsLQsqyB3rXNcrS2KRlhETnObJtq2slMnJ2cg+Z24SHE4XNDhpXcOIV0PNsRL7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iL6L9r0K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22559606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iL6L9r0K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55BD61F00A07;
	Wed, 11 Nov 2026 17:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417361;
	bh=Bg/Kgc6L7imsGE/8F9XOk762txfGaoS9sODIJYRJBdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iL6L9r0KRh4HkQ90rjx075eDdcg4ScbIAkWf4LTQDa+ee5flxK9naBjHxOySZDqeb
	 oLk7ddjcIHhsIE6WfUtwzVlk1QzMDuGeqOYxndCSS/vugiDAaq6aDRZWiz0qdPuR6H
	 XkwI3BkVneynUwdNj3eylfre9jt1yIAsMznUjRpcEfLCo01AFiL0NDERiJJRhSIT9R
	 ro+PtqQri703945ujLRUbbKQs47NCKdy+/e3DjnrCazmhxDPErTEhG1E3mC++Lcr0V
	 jinpTjOgGEzOEb/gw2NTILdhFNyCKe1BK4Gjrso4McaTgU46pL+PBceNBy9fkpVeh7
	 unEAtSPdQZF6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
Date: Wed, 11 Nov 2026 12:15:56 -0500
Message-ID: <20261111171543.3521975-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111171543.3521975-1-sashal@kernel.org>
References: <20261107052657-failed-6.12-1dc3871ce7ec@kernel.org>
 <20261111171543.3521975-1-sashal@kernel.org>
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

