Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312932;
	b=olXP97Max/QOHWdOwD31wgl1FGCxQ0jJABP433jRrN5JURMU9LAHc7K75s9KUKGV8j0C
	 RNrOI8ulhpRIOp/PIqGNRs5ifthrlFniIqEW1RDWeUfxENdIYDCaQdkBpkS+Co5UiPWI1
	 VGLHyWnbKOzWBd4Qzse4Vv8WDci40L8mA5sXnWGCP04An98Y2Aj61sxGclfDD0JTzo4HA
	 OFgMODbDaPvq7ZhqUpJrToBuOEdwjSakOocoNnL3Ct5uvQg3Z/ifWz7SVlJCZ6S410w2h
	 0K4ezomLzOdha48PWsj/H7q+jt7kxXIhBUhcn+6uCQ24vu2VkRubLZ1d+8Wi1VSicww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312932;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HXlXArJPNU6retuJfUnJXF/tU1phGicK8rKCEm19Bt8=;
	b=nVfZwwA7g0fXf/aiRz8skb9/hTWMVtQsRJYz0LZy2OY+TNgH+sRM+d8OxcJSw1uYupXq
	 BbfMiWkDrbwU3KBib2N09dHn55bO4IhwMOhjljVmtvDh8dcbAO1vGwj2LDX9jmyL4jNZ2
	 ck0nDQm8c2/fWPkQ33joy58xGUJhskdVtE456lj9IuX/5LVwLMQgFS9wNFHJCNc0hPOyC
	 6jBmr/PIE4UTJz11vSgZY6hgs0th+6BVVMGwoTrpWiAIemUV/l9cn/EtpUeA2c2wu1iUN
	 9FvgoI9Oa6h0uMB7StfxBzkKjEvLCTDe/0V6dL/2VBvBYoBhaTjyL11A3zVhIUjzC0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U530vYk3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA605606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U530vYk3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B22691F008A1;
	Tue, 10 Nov 2026 12:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312931;
	bh=HXlXArJPNU6retuJfUnJXF/tU1phGicK8rKCEm19Bt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U530vYk3IWoagKOU/cB8o1sR3dFqwr0D1Q+ZJBMAVUbanrTtbOc8uJz/Yo1c8F6pm
	 H7YkasZV484bhCg+D+byi9qomUNw5xqsNDS8sRarVYoWDnCRnoLwaKhtGOEndLiHqa
	 xb0AqjzY1L/ZHtius1F3/tB9l/IO7mU2fzyzSVf0yo8Yb8vr+2MSQKJ4RS8UsEqz+G
	 UvkGvXk0PvKOFI4sco85aE+1J+a+Ej5ZNdSi9PUiiMDlbCQcM64cbERdz8JzzaN859
	 OBEoVvDcQac0rmdikGQ2NNu2UYXCqhQki5Bv1kssGOqiRCCDU5HVmwfAFw5FQg0lMx
	 JAmss0ASuiX7Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] media: microchip-isc: fix SBGGR10 Bayer pattern
Date: Tue, 10 Nov 2026 07:15:28 -0500
Message-ID: <20261110121513.981491-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110121513.981491-1-sashal@kernel.org>
References: <20261107052849-failed-6.6-bb96c78c5f87@kernel.org>
 <20261110121513.981491-1-sashal@kernel.org>
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

From: Balakrishnan Sambath <balakrishnan.s@microchip.com>

[ Upstream commit bb96c78c5f87072913f8825faebe64bf711a503c ]

SBGGR10 was mapped to ISC_BAY_CFG_RGRG instead of ISC_BAY_CFG_BGBG,
causing red/blue channel swap.

Fixes: 1e8f401474d6 ("media: atmel: atmel-isc: reworked driver and formats")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/microchip/microchip-sama5d2-isc.c | 2 +-
 drivers/media/platform/microchip/microchip-sama7g5-isc.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/microchip/microchip-sama5d2-isc.c b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
index 9b74c92ca6eb8..a5d9d37b4c40f 100644
--- a/drivers/media/platform/microchip/microchip-sama5d2-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama5d2-isc.c
@@ -148,7 +148,7 @@ static struct isc_format sama5d2_formats_list[] = {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
 		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
 		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_TEN,
-		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
 	},
 	{
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
diff --git a/drivers/media/platform/microchip/microchip-sama7g5-isc.c b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
index 15ec519f61870..ee4f66526bd60 100644
--- a/drivers/media/platform/microchip/microchip-sama7g5-isc.c
+++ b/drivers/media/platform/microchip/microchip-sama7g5-isc.c
@@ -157,7 +157,7 @@ static struct isc_format sama7g5_formats_list[] = {
 		.fourcc		= V4L2_PIX_FMT_SBGGR10,
 		.mbus_code	= MEDIA_BUS_FMT_SBGGR10_1X10,
 		.pfe_cfg0_bps	= ISC_PFE_CFG0_BPS_TEN,
-		.cfa_baycfg	= ISC_BAY_CFG_RGRG,
+		.cfa_baycfg	= ISC_BAY_CFG_BGBG,
 	},
 	{
 		.fourcc		= V4L2_PIX_FMT_SGBRG10,
-- 
2.53.0

