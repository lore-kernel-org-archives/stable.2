Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794311795;
	b=rWVS5PMCEgAHFKdQQld0XbCvAcDcgQBBFkEXIrJwydFwR79WKLFAmn9Tu0khaYzafGlf
	 JR9NtB5/j6qsi5HUq4Oy5zq2OEc4z6MqSszxcA9gpK4bl6W5hPcmqZMG2DatDrXz9+xjA
	 WybaDUijOAI5Cs1GNzrhaRy3MeKw8Bw74kWBxvet+5XgJ9h5w3rHlXA7aAv2m8WG/LTfE
	 PG0TtfpFTlxJi/D5Z3PkEBIAop8/J11W9OGpEk6MHlYxXZSmC4YJ/vZjbBmU9xRVnMvL7
	 zUq2K5pJKnFaNOSz/lbx1K6zgIDXxd7mCGp90luNXZ+xaArs98FTTqSrJGZxRw28w+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794311795;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ilb7lPLrUcCiFp9DQs8Sy8q6c3Os9gkD+V+anpE99bg=;
	b=osE6FVmknJFIIfuYDyICr8I+N6U+35Z/UvHN6QMOH7QLq0TV/r9IQPSxy7yEQ0FpxatQ
	 AZQWn2sBJuOcPkj7V46PmbusvQT3ik9dLGm4Mvao33mKeft2q8qYnVNwR3xK1Lu9ktnSn
	 adFae1dN9LwNycwcYuNtu/ViuzuMq9Xe7WCcSY6/M2dKhDQTQEIdKpef9kn5EhJaSfENu
	 onVY9Len5A0OXRxKLUUOSKGq9WWFIfP6hxcGP8fXv8bYlVx1/DeQhsiUy1EMxzAGLeWxY
	 MJZV8c085m277HEgJYx4/iMteXe12Tp+ZMI+q0+I7qkCEgaACwkXoETQoEh7qFLFKtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=on4rh4un;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F760A2606
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=on4rh4un
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBB41F008A2;
	Tue, 10 Nov 2026 11:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794311794;
	bh=ilb7lPLrUcCiFp9DQs8Sy8q6c3Os9gkD+V+anpE99bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=on4rh4un3t2obxK1bo9oc6lvhWVNDUHTVHGVtqZLQ/h+U5hBRgEiFNqUNC9M4Ssqt
	 W+glbR9wIv9HSBQWyGZdyPnnrRJ7VtZRrnLSimByjjKSY17Y2k3g3z1h+HvCVAq581
	 OZVNAy6sqljw+EeH+T0F2q1TQ9H04bThviXft2bIDwQTNvaY/mdevNK4NeYv2EJxh6
	 EpRtb8raxu7yAH1XjMxKyJAFWfOAU3HEsbbAe8iO8Te/HdbohYJIMHQvR7kDLo8WR9
	 PlA8RloE/JNcPK77KmEmrAumhKETiLrHhMBpNNkdwLU+KjTAUONRDczePcDHMUkVEG
	 1JY5kkhOXQgaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balakrishnan Sambath <balakrishnan.s@microchip.com>,
	Eugen Hristev <ehristev@kernel.org>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] media: microchip-isc: fix SBGGR10 Bayer pattern
Date: Tue, 10 Nov 2026 06:56:30 -0500
Message-ID: <20261110115623.918583-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110115623.918583-1-sashal@kernel.org>
References: <20261107050633-failed-6.18-bb96c78c5f87@kernel.org>
 <20261110115623.918583-1-sashal@kernel.org>
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

