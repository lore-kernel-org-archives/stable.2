Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794290583;
	b=Z9fSmziFcBDT6zD007KIqmMtNlg4SQHX9QuuFD29WTmioUZtFwWmANqK69JqBsVOqrlc
	 Kx2DryP91x1dST3Nvyjv+iqV0RJleKEpkgGWpQ0V5rNMEv06+kOG4zQMqvjfSJKepScjL
	 aqRgxbmMRikaWZY1lM0KPfKY+3Xn++rt9zJIwktVQLutk8fK3p0JjV35asVGCa169R4Ga
	 xzax37HeDjZsfpRct1jogVb2nkl2OYjAkMHcEJe+J9dW3jkllpxevcH9JU6Uba2hOW2dQ
	 Tj5WPI3AZzdYBjxKWY5WoTdq+IOiN91DE1YcJvFjWurff6JCSp4lLiXK4pGy8Obg80Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290583;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uVHJ66IBAZ9HrGJiF0rEsb3YQgbuxpQdp8RZ0wE379U=;
	b=vJe383eIAMGBumGIyke+rAbl+gSJW+UKw9oC9SosJJbM5IwqNhrwQMIc+bazoJei+qY4
	 +DzBOzW3VwEvn+ocaHjH4qTQvLa1myGmXRu26Ar9McGl+q3wh+ui1lQwrIZm6jI10wonU
	 2A+Z96g5lhFIz24CqE3H1hBxwUNs7eMSeWQpdTXU2PPSq+mX2RYZ6en9ss8ZLq9ZFd12z
	 2y2D74T0y5/M3KjNzhDoyfEl7ivXY301qhPInUMtSJJBzYc7eQ21e1OuiCkQRc5Hxo/1R
	 50BMPQAlQAO8wEoZrk4ucDeS0GQAa5ImZo6fYAz/T1Fp6wnsvjbBVF7RXy24gmIpShA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3X1yiNX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D38606A326;
	Tue, 10 Nov 2026 06:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3X1yiNX
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794290582;
	b=PLZJA4EHGjmTZlKo5teAVw7+xilqfT0j1T8J6+iVqAMXAD+8axGoZRy3THBDHExW0xrb
	 GsS+aoQqqoe2U6/PDO/Z/VLp5aBULe693rVg/6HVRVgDnVbDTHSGzQL606LihF1lBylNh
	 ZzWlk2M1Vxdmh5KEtl3Z6vIV/fZH9qFQaA72uS/TanjvCz63CDtWA3QFEixC3VlITo3hZ
	 TDZQ5z8/YFZFsaDzc8/QemMq7bUUs8VKodPN2fcK5Zeb8hLZSI8OWhgJx8s37nphCTPcL
	 rqIm7u8whpXIfVlGLG/DWrhRhj5SLJOt+j31UOJGjWdIVXo8gCDuin1lwdiVRaK8ehA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794290582;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=uVHJ66IBAZ9HrGJiF0rEsb3YQgbuxpQdp8RZ0wE379U=;
	b=KPCyhNQWmjcrA7Em+9ab1psolLWODajrDgwzp/0QK+sOAF5I+AAQBGydsRHVvIgODKp0
	 79DUOWYewzu2cJ/pjYrXdmdiSr81bClF/zdZzLoItTtNQI6FOVsOWsytGL/RoKCQX5oLM
	 NtqoCDq2j5TKICZN0LA+GWaMqoVTfcVcyNx9CWbe02gI7yFjpvwbU765XeyMfV2Ehsizm
	 Sy5EouvdPgfLmUv79rs/M3sr9jeNPNfAOpeRp7KlCyZLSyYCjB+y5q4sIupEdbhCjRWGw
	 Ar59Wurj+WV/gBQngQzsErhucReOuCezKrxXSby8bEnlHAtJAZscuiTgkG8U7i/5Eag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3D6271F008A2;
	Tue, 10 Nov 2026 06:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290582;
	bh=uVHJ66IBAZ9HrGJiF0rEsb3YQgbuxpQdp8RZ0wE379U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=V3X1yiNXqYniAM+eRk7KLMipxr8zp1mqP83OdHaWqwq2wTuvdZ3Z13WguUgQGj+Tb
	 6qvb+TNWLmzams9edQjOiibqduNWX54R/9InWAQyZdEd/jNtDqSi24hxZ/ngMUiMWT
	 92A06YppjPhHuSRb8UYjpt4DdQtPz11fB4Kii5CSR8AJprkkAXLL7AecqFVk9K0J5F
	 2GukO6GBr0YhbZlR5EIt2KafKM+dTAsGX4mDCWL2btAAV20T5RugboynKxfOJQVmTb
	 RTP6Zkwfpc9MemxkcMxbeQWAY8iqiMNhv+LNgfxZqXCvVLhslwYAHr1Ga3BPTZ9W8f
	 KaD425rLoVtbg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B2F12488CC;
	Tue, 10 Nov 2026 06:03:00 +0000 (UTC)
From: Arun Iyengar via B4 Relay <devnull+aiyengar1990.gmail.com@kernel.org>
Date: Tue, 10 Nov 2026 06:03:01 +0000
Subject: [PATCH 2/2] clk: sunxi-ng: h616: Let the S/PDIF clock set the
 audio PLL rate
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-h616-clk-emac-spdif-v1-2-e5e36e8963e4@gmail.com>
References: <20261110-h616-clk-emac-spdif-v1-0-e5e36e8963e4@gmail.com>
In-Reply-To: <20261110-h616-clk-emac-spdif-v1-0-e5e36e8963e4@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794290580; l=1435;
 i=aiyengar1990@gmail.com; s=20261110; h=from:subject:message-id;
 bh=uVt5p9JtVDMkgUlUZbZagSzjVS3EEVHXWn6aQwkqLrw=;
 b=kyMvMV20BqetCpzD8DhhjOaPMNYBc6IvDDTj5ZZGpdi3HSJMYV5oXMWuEqnn44dsbYCkeVEBP
 oquoJsXrKj8Dp4E5xE8a1X/8YjlP2M+IRWPHyU1Gt919aOwQnKRLddx
X-Developer-Key: i=aiyengar1990@gmail.com; a=ed25519;
 pk=zXpRgUTrhaFe6jLyPqbBy3ccfkj04w0g2690Wv3mg+0=
X-Endpoint-Received: by B4 Relay for aiyengar1990@gmail.com/20261110 with
 auth_id=1480
X-Original-From: Arun Iyengar <aiyengar1990@gmail.com>
Reply-To: aiyengar1990@gmail.com
Content-Transfer-Encoding: 7bit

From: Arun Iyengar <aiyengar1990@gmail.com>

sun4i-spdif asks for 22.5792 or 24.576 MHz on the S/PDIF (OWA) module
clock, depending on the sample rate family. The spdif clock has no
CLK_SET_RATE_PARENT, so it can only divide down the rate pll-audio
already runs at. Unless another audio device has already set the PLL for
the right family, the power-of-two divider rounds down and the request
succeeds at a wrong rate: about 12.3 MHz from the reset PLL value, so
48 kHz content is sent at about 24 kHz.

Propagate rate changes to the parent, like the audio codec clocks
already do. This is the same change as the one just applied for the H6
[1].

Link: https://lore.kernel.org/all/20261104185027.883011-1-jernej.skrabec@gmail.com/ [1]
Fixes: 88dde5e23da1 ("clk: sunxi-ng: Add support for the Allwinner H616 CCU")
Cc: stable@vger.kernel.org
Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
---
 drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
index d2625fec651a..f703d690a563 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
@@ -529,7 +529,7 @@ static struct ccu_div spdif_clk = {
 		.hw.init	= CLK_HW_INIT_PARENTS("spdif",
 						      audio_parents,
 						      &ccu_div_ops,
-						      0),
+						      CLK_SET_RATE_PARENT),
 	},
 };
 

-- 
2.55.0


