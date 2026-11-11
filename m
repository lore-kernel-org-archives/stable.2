Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417362;
	b=va+fB8GhYONq673y1RG1c1Vw0LDN3mR4Zd9e99Cvv5BIiSNARuYx5n6++ALvgld1g5kX
	 A7ALLMXj4R6W0o/1DHzeM3WYvWm1mXXnbfg9GFhnT6qswu5JfXWfz1PyNlfokjuGrGyAK
	 UCpKEWAKI5yvtJ165Xkl1x1nCTEzkIj6nhzYTgelJ32hzUjSMaS9Yoh+IwJlNMxgBEBKx
	 xTuUK7wZMDLPO70Ipc0cgzIt8xNVKLN8pDk3dFUUHAybRQLwrI51cVR225jRYgq5Sv7pO
	 T5DYdEUwN8FhYNj7W7O7YVk3YBjcRlAVNaCZO9m0casrwQtc05vVBca8sAuaQkqeBBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417362;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ns0mK7GB2aUiMzbKbDOEOFNZvgJgjycCEjFF6FmprIU=;
	b=BCYjcA7kLIDI6FaRTEP25qiGl5EQfF7QYMGQ1X/942AkV2AHSIXKMHpEd/RHpkQ1HKpJ
	 YOa5p/qKWTi39JQbi/mqUgJJMuA6l9qq9E7rF8iItcchuasajQym92nZU5pSFuqt4Px0H
	 YCCBWjnQ2aUbMjvimsvhWezTFptmLjWpdLbUl8R1AN5pxxRTa5znLgjb47y6M042d/F4A
	 lbYJOMJ7sBzU+nBrOE8V0bTzu+NoRomM8IL35C9ruyze/6Hqrs/ka/DTXn5D8yJ3ap0G6
	 heh9vtKIwqP498pzXzVf82TBS8BksRcHpE2Sp2YrCi25IlEHu48UI3kFRZJGknVBbRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bozlkr5t;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52044606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bozlkr5t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4111D1F00A05;
	Wed, 11 Nov 2026 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417361;
	bh=ns0mK7GB2aUiMzbKbDOEOFNZvgJgjycCEjFF6FmprIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bozlkr5tSIY4viFVQ0klJarguzuDJbCAo4P+cJDdiEzQ6XQ07OAnYtOvjmvmYbke2
	 JUyJ2TYib9Ue4CWnUBuxX0j+93m68VruPq8538GvTr1fIlH4j79jnOlKxJhreAZT3V
	 eBfn30UbdgWo6Rx40uev5rFNiw6Ub5DaojuC0awMK4MPGNojHL0ehMRJI6dNYN/3D8
	 kr52JAvqWTUHeWtMbBn3VZxAGRsiDUkZvXxOvNpUHzoQVqK/23yzU+JekjBxRD/f2P
	 MNvTS/9bJZMWTEhIXn/WIqBpncxFzlPcA7ILEKldj2qK+IOH7yP2kiM3OXgrGiDxGL
	 fYABi92IhGfMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] dt-bindings: clock: ma35d1: Add missing WDT/WWDT parent clocks
Date: Wed, 11 Nov 2026 12:15:57 -0500
Message-ID: <20261111171543.3521975-3-sashal@kernel.org>
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

