Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050107;
	b=4xtn/PgqCPt/3EuJpgCAWeT46lzneu35jEO7Lz5UMnYjWGkS0WEDuXjotXbD5umHQkDd
	 XUS7peg95Lw8hWnZ4BEcP1V119O6khzZUjxWIigh/JR3UKttGEPoAtasgjzLzKw3e5NQz
	 SBgCbX4GwSTKuoyUvr4PfmsVVlULxkGZDw0sNdJfr8IUccz+as/DyA8oRFjQ1Ok/5andh
	 nH8Bf6TGSyG8+yxESA5OJ29hrUu4Is1jA0nAds3Er5SCHsL8DenU6QnJ4sz7kaNFrpVSC
	 BJ4YVtZiEyfBOMWOtlbfEQvCCMpfPfwZAzzEmLaKsnmW52jtk1jlfg6Hc5E40lLfJMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=u78+ZCJ2ESNwa89ojQjMw3PIgfcn2Wtt+TYGaGsHt7k=;
	b=0Hxao/e04eYo+YlKiAvIzsBLuZBU7g6EuLErBmk+zo5cNhUUqH+8IOhn1xZ5e59eW134
	 SkJC+Z4tjguObPsTwR+RAMg08Juy9v1eqNUIGNbKrbakgqyFhfw/CJNHOJesjl+mmmTKJ
	 VumifYKuOFMl+zEGQTBbdt7/epQBCvaGIMqxIPayblEPLLYD8EpmWfuWO2r89QE3XQrcz
	 RUzz2x4rsk/Z9cN/klWMdy374Zyza8QIWXJLLo3c+Jmbb42P3l2LjFAPaV5X28feo1ewh
	 LqFD/KTwJ1rpphlx4hOza2jmgtPhzq+JYjoz2ulS69kZBPus9kepqarqM7ed3Q6Er0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHHEtK7v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE19606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HHHEtK7v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 015071F0089F;
	Sat,  7 Nov 2026 11:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050107;
	bh=u78+ZCJ2ESNwa89ojQjMw3PIgfcn2Wtt+TYGaGsHt7k=;
	h=From:To:Cc:Subject:Date;
	b=HHHEtK7vfR+r/PZE7uc9vUmk6HZNNc1U+U3JTxiqZliDKe7F6igSr5b9bNtWN0tzA
	 6mG1toZJ0RgH8yQcHwU76Qsm1h7ZZ9txnvL10YpElagF26fhfAFIdzCxlZTIqhdaOZ
	 AHtxXYBXkzlOvWkhI2OhfGjIegODmmqmE0sA/S8xq0ztJxVpdoygEWu3+UOLuIlQS5
	 YXbb3BgjZ6S695rsIYNiIncHTfvnfFMSZWO7AxclcWrhvNH6AJtmu4skgOHxWqTPEq
	 W9+Xx79xejw9ll9TLKjVvsFMiOpXC+0tbWMI3sOl5qSI3LHqcWipyPauFA7zhowN2h
	 bmQY6zSO3kHHw==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix SBGGR10 Bayer pattern" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:15:05 -0500
Message-ID: <20261107061505-failed-5.10-bb96c78c5f87@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x bb96c78c5f87072913f8825faebe64bf711a503c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061505-failed-5.10-bb96c78c5f87@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




