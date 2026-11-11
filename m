Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417704;
	b=CSJpNzGXeWHkBsGLJQeBB3w2r0IYcsGP1oCzjFVXJoXN4p7y18tI4E5YQURXfcZE3b56
	 ScbCLUyDkKqWyrcAGJttTWHIrEJZQzYFL9M809Nks8xost5w3Xmk0cIrd7glTNWR+B6Tp
	 CstfjsFKkvpACsKVtB7GbhUpUPkiLKYYkGJOiMpzT7HRg2hdCjAPjWLX1TMWeq4YHMa6I
	 Fwj24XK8a0qfXUpUCKRgqS8yUvEbzb1/hxaMakN19bQ4Q4Xcp5ZzSI+hkV4rD/YKVa6zr
	 V13Chusef3zhBcV2+HYZl7r7vEtl9xdA8tGU3EJSXzQv8aHKpfB7pVXvV1w7jIkr/RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417704;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ns0mK7GB2aUiMzbKbDOEOFNZvgJgjycCEjFF6FmprIU=;
	b=u3lFTFsMQdMwykrYnKFqUCrwEx7/DKPSAXSdy4FiHQeQ+6xTj2AdykpgmFTX5pJR8+Gm
	 Ed7MspMUY87lR/MF28/L9OgRziBV3RXFLr92vdRwiqDRm2hXKKrSxI4JhUy4SZvmEd+z1
	 Ncddtu66C7RqA3gAGe+gwcyBqcBVJ5U24hPNFdVwksgv2EZgNQShmCU4u3NT73hln8Ive
	 9CK37eb5071myuNXKqEpaGkqSGIMuNRHO4pLXHDIxfYdSko2UMboroQ3SbjBeCJdmNb6Y
	 ePGJXKnE7ELZS2EJ3vtXrbhBJnVs+1XWeCLSVOg2pbcqvJ2pSvRDDD0qro4sDECPStA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRfjoMw0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B1606A8A2
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GRfjoMw0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007511F00A08;
	Wed, 11 Nov 2026 17:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417704;
	bh=ns0mK7GB2aUiMzbKbDOEOFNZvgJgjycCEjFF6FmprIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GRfjoMw0mI4wXz7QyxOpGiUgAqeKY4hdrGOjNAM3S9Tog+qiSXP1RzUQdvnSMV1Dm
	 Loy0tliPY6ZElNZi8ypws6uukgMU3ykYDAHlKAxLklFw4J2QdaujL7xiR2uc4emini
	 S4gmDSlNxQ6FN0OBbOQ8h+NPnVKaVlMYOx0MVvUyfRYXDD8aKLUwHwpRVvAUqJzR6K
	 erMlmX9VcL3nKzeMkNjGSiigSIa6HyCchcy4ZthvTEcsd7nfUSILkXPAdIcHuCEI6P
	 Jm9SHpmyprtVxR7Xm6pmpqFoI0RRecpS7uP9XniJzK7stmbjhg4HB4Igcx4tlYBYy6
	 jIm8h1Z9f6zKQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
Date: Wed, 11 Nov 2026 12:21:40 -0500
Message-ID: <20261111172129.3551299-3-sashal@kernel.org>
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

[ Upstream commit 8c7453cb0b01bee47ec2f902a9ac1872d3b77f3d ]

The WDT and WWDT muxes have PCLK3/4096 and PCLK4/4096 among their
possible parents, but these fixed factor clocks are currently not
defined, even though they are needed to properly describe the clock
tree. Add them to the bindings.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260930-perso-ma35d1-upstream-clk-v6-4-48937ee6c9bb@bootlin.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Stable-dep-of: 1dc3871ce7ec ("clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
index 2d6a44a7e55c4..764d837d6162a 100644
--- a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
+++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
@@ -248,5 +248,7 @@
 #define ADC_GATE	233
 #define EADC_DIV	234
 #define EADC_GATE	235
+#define PCLK3_DIV4096	236
+#define PCLK4_DIV4096	237
 
 #endif /* __DT_BINDINGS_CLOCK_NUVOTON_MA35D1_CLK_H */
-- 
2.53.0

