Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417120;
	b=Hy0V7PsLFSuXN8/Z4HvrmWgOfovNiZjRwBblOEcb24+AYlQ0sIV3DErSnga3Au/hCe6I
	 NpJLSFPHaa0veqSmrE6IOdWZvJBfdx932nBiGX+Fh5tzNsJM37NoC7Qxw4jDmqJ+cOhiQ
	 SGzlepHI6tlA9W6WSfohMONneu18EHrvztZSZAtcaULVVVPiHA85vDyxFR+H2xiZcZmfX
	 sXV5fWsFCz8IyN8mh3TLoUMHkydGi5tptn/NICL3IJMD1tJivxP55n9KhPZV/uX6mkuK7
	 m6Sg6DAu9JZNCECwcJiiwwkESiydvk5Nvj4yS3lD/5hz8FNEpTc4eSECjyefBjRVUmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417120;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ns0mK7GB2aUiMzbKbDOEOFNZvgJgjycCEjFF6FmprIU=;
	b=KIz/OMznzfesHII/MtIDFMWESPthcJV/T8sgeiLQ6xQ4M4/TwwPR7/18fO3MfWhxGGjC
	 +7mDF/pduNIWferXMVTO6YEidjF6DBfpzch0rNsyx7k+NTZ/UgM+YgX7oBufUe/xuapVY
	 Y28CO36i+0j2K8uxbfj4gsZxNMoHz5AJa/CRsOR9SRXfgH0wd9uk/CbMWkii5s7zFNhZf
	 VdCFwIPpO8Ko1gKN+C1UhTDb2H2AqelSHApR9RN5QtDe/ZAlupdWpAktFevYXr7Tg8ifX
	 TRw5RHNo6w5zAZlxHgvfsAgoaXB52plrmD3uk6wT8/PlXb58eko4v6KSPIp5PSBGU3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABaa9qnK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A6D606A335
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABaa9qnK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F641F00A08;
	Wed, 11 Nov 2026 17:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417119;
	bh=ns0mK7GB2aUiMzbKbDOEOFNZvgJgjycCEjFF6FmprIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ABaa9qnKIzfRkg4Gk6Z8CV5dhOU5+cZOo6G8EULsPm244QEQDq+Z4/lB8UEhhwCwv
	 ZF7pNliekpczVRdmrHbFzANeNPXdntGz6TLlnmpAOU6KQCTKWmGsHXzf4EgFt7+uZ4
	 scn/P/d1rKza2UAk/L8La0E2Nemm1wKmduvyXmZn+cA2eo2lZ0FHRawzKocq1jZjGP
	 hMrKwlbhBFLVzMdL1vTaP/cIH45s8H9rOP4jbcstiKjbMfl1vbdVVL2x4PQ05MYKIN
	 RZ5nZlLAVBqgFmUgpI+t1AjR4hUIWCXP7QVor8MaKwxH7UfAW3QNPe0NWauShp6y58
	 Lp9ce56CtmjsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/4] dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
Date: Wed, 11 Nov 2026 12:11:55 -0500
Message-ID: <20261111171146.3480409-3-sashal@kernel.org>
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

