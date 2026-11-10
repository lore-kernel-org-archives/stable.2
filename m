Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312285;
	b=Ug/ARboRykKHK+MdvgUGfdj01bmOi9LnUAfzCU+H1VtxBktPhjFTGG34KvOOjGFu+qYZ
	 meF4C7aZ2sXmEdXB0qBU5aIR5NTmvOcgzV4E7qib7BTQdKs7Jhca085HMtQoTxMUvqAwW
	 KhOaEnrqT74EpoM1onGGioRIIbxt+AAN1nvgoxNhMMSgIgGCaarTGEefTdtSKepB2Tydp
	 fnFwxVG9fznVWoAiqZZZV2UKH5C9Oqa5GCHzUodPjN/iIK5HOkkCws7jr302W0VaETbja
	 pg2DYbFvvWIhSDmfX6y3EdmlFsBOd/fxy3SyHO2lBYGC/26mGhX5rERSsV30ka3zf8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=HXlXArJPNU6retuJfUnJXF/tU1phGicK8rKCEm19Bt8=;
	b=WGDSsL3xfnJlEuOx2TpoxJoPjtJ3cnN8vUgNWEsm1OHm29PRmCQlOCfep58SVU2uL5TL
	 xL+V5JZl8J8R5CQgkMOzSpcQyBlF2Yd2GKZVmeeOlxh/I89nDFY44KKzIJlbwsXvOlrd0
	 XkcYnOsAkk5s8y5AnbFvN28seGF32SH3HqTb0nkP1OVwcKwjoQJFzofVesKafWzsh67EW
	 iiBBYzgP72ppExIbaR2ILcFJasoel+I5Vcb1DuWWpEZ+FFV8NPZaRtjQZZC4zprBhL4la
	 SUAtsPQ5Azb3hPyrAPzZaJeMx+fQcU0Wi4aPyO/GxHgbo50nsHRVOTFRcj6BL5DBM7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LQQ/uC0y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91799606A335
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQQ/uC0y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77E91F0089F;
	Tue, 10 Nov 2026 12:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794312285;
	bh=HXlXArJPNU6retuJfUnJXF/tU1phGicK8rKCEm19Bt8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQQ/uC0yn56J6pms3BvfzxJY0wxnsTqvprXxlGO1HWrD/KZzc9J7PL8qW0nE45uXY
	 6bSKDdGO5WgHf4f8U08YCBbGCzxkvfwEypPNi9K+MekqukjZklSM5Uog5d1K3CEVjO
	 PuhlKqKyWi+M5la8D5ABLCrsK86A9Ku3Vb1Ji2/Ro5wCI5zDLfQAa6X8muJevHUx3m
	 purYf22gAFVmjLZS0Tt1kGwBzUcmXmdo9t7xJSV/jLfHq74byDOWflP2IikaRQjPzd
	 CY9xOLF7xsNPdiiBTz8MxO9qX75AZ1AjuOJpsV649eXqikRvbLTQSvpcjs/XW2ZJlP
	 xDp6Ma8iY8NVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] media: microchip-isc: fix SBGGR10 Bayer pattern
Date: Tue, 10 Nov 2026 07:04:41 -0500
Message-ID: <20261110120434.946561-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110120434.946561-1-sashal@kernel.org>
References: <20261107051644-failed-6.12-bb96c78c5f87@kernel.org>
 <20261110120434.946561-1-sashal@kernel.org>
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

