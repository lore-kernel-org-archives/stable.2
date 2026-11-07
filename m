Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048095;
	b=Uy5yGW8y0BievpUHs3+OFOcJNqeq9+l6ik0lEMsUS4PgKgORVqz2hY63umgUXLtEBIPf
	 xlp5BaCgVwxeVlaTUiSjC3HrdjERvx9FxagdFWGHqiaCiJTTrfSGA7vyqFMnSXkeJIToI
	 mDZ3SS8are4HZPbWzS0F4KXXnPqkdlw13HVRtxN8N8bx0sNACRm/wSrJ7jJjUi+srb3qD
	 VNJp1TD8AVR7IVexmrqpQXjhBb5f5Zsud/hiT9sGyNcCS0573YEpbA2oXVVb0rA3dxbOl
	 JmvypYUHnKG1OmMjlBuSFZQJfVUX1eLyhi+3yOSLbd9Kq9ucmz/jkaoAFAAV0qrVWvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048095;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eFUwOBMJ+xNkMkFxwsRNCGAIiDC9b4pDaUc0i/rur3c=;
	b=iHx051dr4XMX249AO9Wj2FdRCW6qHgAo1XJupbHr+tUVpHU6XEWfVehJ9BYWDnxbK0G2
	 aLGr3qD+xp065RQKZ2NzkoASs3wMCENuAmyct82VEIBtCmCwHIhh6bNvKrmjJucmjXyvG
	 CLAdHh21Lh04F/V2SsPyljCb9I0JnSvt99c/uKEcwaWhywlhtJiziqhmXwOmu1954QE3b
	 w1mQVtKgbZcdwEsSyllMEi9uEmqz3JDGlLRcCs1f9F1CC7vdPUtlMupqGNSAjhAVLQo7D
	 SYWC/D3Una5sB1YZbE2nLrwq2J+mhPsqjt/Ne1PfFLP9NXEpsQFQAolSZI8MAAt86LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpjvmCBD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A91B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KpjvmCBD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8628A1F0089F;
	Sat,  7 Nov 2026 10:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048095;
	bh=eFUwOBMJ+xNkMkFxwsRNCGAIiDC9b4pDaUc0i/rur3c=;
	h=From:To:Cc:Subject:Date;
	b=KpjvmCBDSdItpIGEehcK3agm02phoJAuiJZWEq3VN5qU9RbEbNrgaG1pS2kiX0iSI
	 g9Op7+dlkks2iiKmGXlwIDp8x+HnCAKfHisbLq97mTgCfeq2L63qbT/lvCbSVMQK2+
	 MSun7MIIWYlqF5e1IymePWWVBaom9jqUhSml+wlzBt/5YNlhL8fRtlaWrL46RHFyat
	 YSVhw652XSvkYkXETqj7FUQxHcGgDFbAiVn14IpX0lgL5a+iHsdeVU3amD3g7YAFZW
	 nfbuaO3w2GEG5H4wamaVH8WiBWtjrayTqpDN4fApTlCo7fCI9Nt2zozm1hrctH5E2Z
	 a3xxgZnxZBJfw==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix SBGGR10 Bayer pattern" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:33 -0500
Message-ID: <20261107054133-failed-6.1-bb96c78c5f87@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x bb96c78c5f87072913f8825faebe64bf711a503c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054133-failed-6.1-bb96c78c5f87@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




