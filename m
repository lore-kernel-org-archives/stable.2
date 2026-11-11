Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416792;
	b=A9z8q/aNbGnYEKQP3ijm0bmA9tJv/0xBT3MSf/RvkvSci5tKLA9X8IFH0oFbg7MOXslN
	 FC7lBLQnrlFrnEwS8n+I24NoCivngOyvVcZgQvaQ4UtMLwFSXe9PF3Agcrvr7Bh1OLvuT
	 Ndqoxh+SJaOVeiM0tzRnMO/sC8xXDcluXXqf3ZSNoj5kY16+K4XHlU3Lnh57Et6U1dGVk
	 8E0iGKeG2rp76PElZe57QfekEjVj1WE4K52O3AxE0p726lfn18nyMH9MpzelpBnY0gjFs
	 qxPg24JqvthMY6MPqexzeBGLDo53rPD3w7MKMnMjUm3Pjv0Yr+aSYBRb6E+KU/NLxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416792;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ns0mK7GB2aUiMzbKbDOEOFNZvgJgjycCEjFF6FmprIU=;
	b=sAxqaJfl8ht7MvXeCeiYjmWQamRcM6/JFTxRaShwt+UJ39lKKpIUfSvM7WMggUgQrJk/
	 9s3SPoNJYSoEzSAcZ7m3wi0KjVCEviuQ4XU+fxTrpuERoAzI+TsyfSVQebPt4fWXJv74D
	 tWgYBpupVaUGsyT6Sjo+o9401z58O3XT4HVGESEwnTFE/rgKNh4bQq2hfxMQ/qnfuXhFm
	 qC4d0ILffKUfuR80+yY1WL2KGdqnhFr7i192TdNOFAFta8mFe4e/auVIqFApzlji6C/UV
	 2aM5qLnK41iLerumZMYrl3XS1+xrUX/g2fQQqeqGBtjc00+eq9sTaw87SCkAdmvTUJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z+BUx/Dm";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B846D606A898
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z+BUx/Dm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2101F00A07;
	Wed, 11 Nov 2026 17:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416792;
	bh=ns0mK7GB2aUiMzbKbDOEOFNZvgJgjycCEjFF6FmprIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z+BUx/DmbNPOuqdSMkHaIPkJTwTt6BXvj+hXc9Fg3NL+pLofX1UjklWS6wQ6TX5s6
	 n5Pkh3hl9iG0b9HHGUc7cmhIo8/gEpRVjNPw8ECt4qCR3hY8RXaWGAdq2ii8EKx7mB
	 azIIcb963c/G83bw17q/5d8EqJaKwc56tLOz047Rru4HKcHx9o/dRzjloCiefSYzWU
	 gCoSJt+OzjNu/oYTjrm/7L/mNqY9Ll4ywItGZf5UpnIpkvHU770YMLHBBv/2wHkkpZ
	 QwCvvsc+38cI8zE0x63/BEV8LOY8w9z8l6fy2yExIgJlAHtbOK9R4hkYCWlmDgu9el
	 8dAe08qIDnPhQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 3/4] dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
Date: Wed, 11 Nov 2026 12:06:28 -0500
Message-ID: <20261111170618.3423248-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111170618.3423248-1-sashal@kernel.org>
References: <20261107050550-failed-7.3-1dc3871ce7ec@kernel.org>
 <20261111170618.3423248-1-sashal@kernel.org>
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

