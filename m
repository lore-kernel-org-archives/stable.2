Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311413;
	b=4Q+YYOdZDyqFPmDS/jN/4Z1Ty/wSabPi/BszOaujlL07VHXLxWMCDeVGl+PgH48/nec2
	 bpgCJvcpoTbb707kpOTO9/T3tiJySTKB7TmZAdc2U6nVQRWvkTOF7+T7zX3E6jD12B/6r
	 YiWbxTM/VkBIFIocSOVixKJrloJH8upYg0iNuV4lGYllK2gvXtoz/YdNm+g8SedmtsPec
	 wIpFFKMgAUTET5vEuku6KnTxpFEyINyojwK5oVClMPh9SEd9/b/UDIJlp83LAwGHLx+Qc
	 /1wIP8u5mfhe0IHNCDhiXtFIeVKUAPn9JoEwNbsyKzJeoc7CgWYDhfET1deujbomppQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311413;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ilb7lPLrUcCiFp9DQs8Sy8q6c3Os9gkD+V+anpE99bg=;
	b=lm8qcZOoH2OZs8hZJlO/6Fl+av6rQm1vzc/gnHPxMB8PcRS1tOSoUPJAJToTQoRRVEL9
	 dzyTjCqw6eyiy7EZ9uWh7N9ESdBh/G5OVcmLPm1y96xyQa6Hbpr75tNbx9HVYHSo8GY6O
	 6Q60ttBkSh/Mz6uZymrXnwZM1VJfAWvsdYAaDJOJn9Vb9hCPZUd8mssCGmUJL//3d30lC
	 FQ9QHmDQGzQ47jqYLazjZpUERHIfv6epU1hLCHj+o09UUGxBMfmpMuVMftd20RhoCAL5c
	 MPMbN0ycvrytz5djawNXS2nLzuWq44adsMu7GvfVndvr+haQ2U2kW0A46GDPqGBFb1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXWaou5u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D7606A9B2
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXWaou5u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5571F008A3;
	Tue, 10 Nov 2026 11:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311413;
	bh=ilb7lPLrUcCiFp9DQs8Sy8q6c3Os9gkD+V+anpE99bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXWaou5uD+CCwGiwNVYE7J8zoavDFVaNjom5zN5/n0J9VAC14pD89VHZhONuXb1NG
	 8r2FubNs9CgnAp1D0+iKlYNkHJJ9k4YBi4ex3fCbjFQhC/NPvknNarEt9OIiki6tgT
	 UlvlMUcRLuACt2fxkEyNVS5dEVLjeWT6cRSpifiPbqKCi05cOYsqetOxuKv48s3Jwh
	 s7CYDH4qPs5LUgVaYSoOC+xeQ60ZBqDM0yoATYnk7wTpEYqaQOhIXtbTc1K1Fj2dKC
	 +D1QkonFw51NnRtay4dgPBHEFGmigIVmv+frEg94O2xiBBflwIVHJD5Bj7yXlYMowg
	 fvH4bp/dJwkSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] media: microchip-isc: fix SBGGR10 Bayer pattern
Date: Tue, 10 Nov 2026 06:50:10 -0500
Message-ID: <20261110115003.614804-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115003.614804-1-sashal@kernel.org>
References: <20261107050300-failed-7.3-bb96c78c5f87@kernel.org>
 <20261110115003.614804-1-sashal@kernel.org>
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
index 57a5aae3cabfb..5e41eee45dbd7 100644
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
index a841266ffc30f..9e78ea07b013a 100644
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

