Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046606;
	b=edUi8tAtOlqUlwOkG8ylj1EteVLeRNYBOQREM0/WyLeWxahsZ+JjJpczLaw+CXkBc6t/
	 0/kKJJ+sNJ74Swv/HnCtFGoisAJhPw97jT6g04Lc5lEPQku/U7gwRmmLlHWCKTb8puksw
	 eTTc/cxysHbQqOhOinA3G7hgklcqG+JpdkSMYOFIVnC0MGyt0VdBqMOxYs6oMdUnrW8F0
	 r2q7MmyUPLEKx85vkFBP3jhsei0cBNOWJGMmGa21OVV4oACiDIoAepwGtsVA/7wkoeAx5
	 thvaVxovb1xNp2swvyi17PJhYVeilUX6nw+Bs39cRnpHE4rKU/jYJh4icQOXBnhzpMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046606;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0U1XSXvxAyOpmXNI3S4pPqUrL1FmeQBoyFe1Vx0R+BU=;
	b=m11JbUXGVsJwDi2+iTt6mff7Nn6AHZnudsB71yQ5u1iFHzJpnNpQ7hrZ4HPocTHAk1o1
	 sEXeJVN+47MrDEaXCBexTmXjimNyjVwJpJMRm7ER91pqPGs2ZLgddxONHWQ54Mxhd8Ha0
	 Jm8HUU3Pv2SaqtJdrki/Nhb1yqofYHp+D+ajkM50JovcT+XIl7rFNsrGi9u7EfZrGlYFe
	 i4akRSH44mWHl5d6i/VzGWzODL6zk92PGL7AwTjfEf8HQgKqn6suxQ6WMLMsjoFZcqEXG
	 +cnW4odp3XcXJ6hOpoSxkqlUiyP6Cv8Aq/XH+ThfLMu1thSUtEBWlM7DWjN+vKprdoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ls5PDKWb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEC36082BD9
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ls5PDKWb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B1D1F00929;
	Sat,  7 Nov 2026 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046605;
	bh=0U1XSXvxAyOpmXNI3S4pPqUrL1FmeQBoyFe1Vx0R+BU=;
	h=From:To:Cc:Subject:Date;
	b=Ls5PDKWbu97e9SUhmR/ZOpdm2M93XfnnEiIyNzGOsmk50Wvp9iQRsvCTy7z19zoLb
	 DgQsAAW89IHb76fXT1mplETOcrfmu/5aayAlMlbFF2IPXpqlmAw5x3lPWUSj4WXiy3
	 kxhoMESOVpwrZV2wMvKLsJkyFikjIR1ug2QxA7v5tr+bMx7vm35ShVu7Go3h48JLaK
	 k0Xta/esSreaWzKW9YKNUbijRMlkiUryqNZlX34UChxVCxe/uUywrA9CpaSTFkhP5T
	 81/jDM4q3IgO36icecP7Q+BJ5CVK+raACX4DcdNXv9xUKkRxkhdrTHcAO4Z680F9lB
	 8SKQrGJjCUTjQ==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix SBGGR10 Bayer pattern" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:16:44 -0500
Message-ID: <20261107051644-failed-6.12-bb96c78c5f87@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bb96c78c5f87072913f8825faebe64bf711a503c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051644-failed-6.12-bb96c78c5f87@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




