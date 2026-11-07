Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049090;
	b=Em0/aRwb5f1Mjfu8CeKP+7amWsP9yqeUbTYvhXXyNRWTqw3miwtEvpcobvxkP/GjwtsY
	 vwngcN6zdT6q4YzcSJqF0fnRiYSX/oQxzylV22uxYE26rHs4pypG1VDhSeGcFDKSArAbv
	 SGWdhk2VjSv0EyzRkC+294GbASKU0Iy6cl82QSFO8sq2Z57W7J/8/Qq0UtnaCHeg/DHFX
	 IqXmRe8XPh0baIbslYweF6qm//GwS3lWAcHjxU/K+ot3qlgH6acHP7BtwfqovfPIRN6R2
	 t6j3SkDLKeSP8ho/HzOiZogjEXLKG2EG8XGlmB9glE9vAe+uRLv2og1ivzCEgKVxqeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049090;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=qSEreG6qAW9Opoq0uBuzHZi6vC5vp551m6Ly+LrfvEU=;
	b=r6GQvhdK+0oaU7CQUdf7E5DN9M+8JY+yF5Ow/xxXaPXFo1OOjtB0HTzAWJu1LlTJhNRb
	 A8B1RxTmJkY8wuwRWrbnVVKRbO4Au/TN0nWbefQIKrevm1QkE3pdylCTqeAK0VrLnecp3
	 3t+trgl5wHQ/iP2qIaezbPIvH/i9ALZWCHlb4iFrnUPKJCEz+loBOaTaLxkKbYE23s+SH
	 gxerQ/RcdlXPlvFNKAohyFJvVYLoLzyGW6miBuSx6R7K12y7OSGdudkbpNgkcuzTJExAS
	 86FDtgNK50lUf9zTYPidEJ49mhM/LybbnkmE6qeuYF7kxh9S4M+qiiFldUi3Kbv7JpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+Y3x82Q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A284606A334
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J+Y3x82Q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45951F008A3;
	Sat,  7 Nov 2026 10:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049090;
	bh=qSEreG6qAW9Opoq0uBuzHZi6vC5vp551m6Ly+LrfvEU=;
	h=From:To:Cc:Subject:Date;
	b=J+Y3x82QbkHfejqdT+V+1fx35DP8UeD2IYqx7Gk8wXRgBfgvs5nA+CTjdrd9cwGQc
	 QOzuK4DfHLSemczelA4Uc4FRFSYgofhFQHGeLC+H2vQRAemDrUxfpivkzZtqQ4Wvzj
	 tZ6ax/DNdYpy5FoZLqt+yJFQNDF3ZESBH+mVcX6IMgpSzqgv5fhzfup4Vaztj1gM/S
	 QIrWUoe9qWgBrL7d2UwKSPKeRSpiyRjtrXN1zeb+sggt08CSPRNs48glqGDvvtEGXJ
	 ig2JAU+OB8paRZBT0Z/Yr4Z2m0MQYzSMfO0Qgos7bGI95joH4W4ssslgFOeJuaAxcZ
	 hulftvYd8WpXA==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix SBGGR10 Bayer pattern" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 05:58:08 -0500
Message-ID: <20261107055808-failed-5.15-bb96c78c5f87@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x bb96c78c5f87072913f8825faebe64bf711a503c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055808-failed-5.15-bb96c78c5f87@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From bb96c78c5f87072913f8825faebe64bf711a503c Mon Sep 17 00:00:00 2001
From: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Date: Mon, 17 Aug 2026 12:22:06 +0530
Subject: [PATCH] media: microchip-isc: fix SBGGR10 Bayer pattern

SBGGR10 was mapped to ISC_BAY_CFG_RGRG instead of ISC_BAY_CFG_BGBG,
causing red/blue channel swap.

Fixes: 1e8f401474d6 ("media: atmel: atmel-isc: reworked driver and formats")
Cc: stable@vger.kernel.org
Signed-off-by: Balakrishnan Sambath <balakrishnan.s@microchip.com>
Reviewed-by: Eugen Hristev <ehristev@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
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




