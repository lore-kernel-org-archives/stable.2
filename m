Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045995;
	b=41mSe7+qP1gjR5vcPsFSPk7Q+w7/lYfnsNaYzooW4cpQ9fTtTmlqpgkj2oU7sCbDZkxN
	 J/Iu0JUU3/WWNszWnlLGb/dJJw0Z7/rKK9hVgK225wc9gjj5HVJY6+pfpb//ce2xpw4gr
	 shuRZh+sEOu/RBVI+qpjx4FeoeXpGOStxOS77YeOQnQFyB7fcTkCUyhG1Yjqc2QiJwhxv
	 hPluYhBwHRABU9DQ3vNS2zH4xLYt9IX0St/HOh5s8Gzn4TtgmddN3n1EuxxqwpngtiSPS
	 K+m5wnDOrEBnUhLM7DzLP6HfCPkCni1wTttr3OA/9w7N89kBPZ53u3R1XBJ1j5MEAEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045995;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=aDm8owSFzZfspNU7h1ONj26cEPZGn+RGFrDhbZv1YgQ=;
	b=WwyVdCVW1nBXQSk21zOnVk2EmRtq+5j9PAVg8s7nehkXSDy/5s+dhjruAk+vx6JV8wcl
	 OS2A62aOBGbu81xuoCZR2HttfVGKe8/vFl+/mSC3VtTreFQOU2192Z2IwwVV0iNsx+0TD
	 4ZlzW5D7aevLY4l8JZstrlG79jIE4s1G4OJagTHdxYXBcphw3wsR6KUwvYMGUgAS1Brf6
	 MLGgq55/joupAqhq3Q581sO5KoSchXOjQbbOZqezp0Q2FWPxhJTc9LKxSdFCCS7KWCAej
	 ObVJURIRynaPWDkJbGagndqa3T9++xvIllDXJ9zwYH5ZbruHKZWh1Tph2tLYVgjEK2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORBOmXuW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC04606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ORBOmXuW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F711F0089F;
	Sat,  7 Nov 2026 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045995;
	bh=aDm8owSFzZfspNU7h1ONj26cEPZGn+RGFrDhbZv1YgQ=;
	h=From:To:Cc:Subject:Date;
	b=ORBOmXuWZ/s0LqdKz2XaLakUjovC5c2ffFly5LfJGHPwZkLv0BIDnjNTmViJHCusS
	 B3S/sznjPf6YZeUh4yHEQ5/VX8A8g6bTFCZ5k0aj1tJ91cXx0COm91ZzaUwRptmLlt
	 8hWQCh1FtCdMuUeV2qnazAz5j7WbZXoV5QnaNOo9Jl37tFANu8eD294Oe1ti3bVbVZ
	 L/WHBOR1CgDUqevbP0UZj/m8HYe+vhZDWeTktmjCTj7t7BG/KmeZ4zSjzof44Ct5DM
	 Q2sCFYyKTrgLF8b3PNuMMld2n9rw/Rxjtq6xxXf4E60Y8KXHJcFnNr1gNQQQzSZDjF
	 8YbDS33ODgxIA==
From: Sasha Levin <sashal@kernel.org>
To: balakrishnan.s@microchip.com,
	ehristev@kernel.org,
	hverkuil+cisco@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] media: microchip-isc: fix SBGGR10 Bayer pattern" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:33 -0500
Message-ID: <20261107050633-failed-6.18-bb96c78c5f87@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x bb96c78c5f87072913f8825faebe64bf711a503c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050633-failed-6.18-bb96c78c5f87@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




