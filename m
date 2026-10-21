Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597356;
	b=tTF8jAf8bsqRVKnGnlKA78J7J8H3ziH0Wekjh7ri9jn/K02BY71wMp/FwoOfO9UWZynV
	 0k3wh1O7Mk9Z8VKR8+l1qPAYikqX/vTL2Cexed5gEHuVzL3ECkQDWUs6xAxy4AjgjTw3w
	 ZlcWA8muCLG9EykFx/tsWYhZlcsDEs2Ok668SkeFz6xekvYhKe0KzXvsbyq80xRCIsBV3
	 6xh+OTeYfwyojoGphUmANEPi8i/d/NpMCEdhjJzXsmL824UjeBuQFPQcH6dlAxWO6Xmol
	 JVchULZmBap54N6NDMUSUZdW9JgebQb+LgvKAZ8MLHLwnn+u7QAMq4hrPpfDFIpd9JQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597356;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0wNixMRLPkkVerKyjxJH2ZEnjy2b0K9DPCyAkCOusaU=;
	b=v///qhk+PaRqF643Ba/MNS1d+IrfGM/BMd+PE0qKjQfyxDWDGVVDTI4cJIKHXvKPUEe1
	 yGBy5Tj05Pon00dm6TgbZq5g9RAM98KpppMnDg93QGCaBaVSmgMFVtNzEbSghm+CJ0Ppu
	 epfGF6cL8FMUdV/bp1kbm42BiIy7xlg/7HtMZNkSU6xZV2898YRaQKMPUCCWP+6qcBem1
	 136SaVVLrSqp4Z7N7+ZinHarOG6qyDGMPYGayHLchOM6hNptEYGDzdNCCHoM3TIrRVjoV
	 JGzmoFx0FkeLpIsA1PMYfVYz/WVQlZ4VSdwVB2igHVQJfZtEydKzgoVocnM1xxqqI3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ET0tLzC/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42126606A319
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ET0tLzC/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B0AB1F000C1;
	Wed, 21 Oct 2026 15:42:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597356;
	bh=0wNixMRLPkkVerKyjxJH2ZEnjy2b0K9DPCyAkCOusaU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ET0tLzC/BEs47dI4+MSjeacsoAN6PytyKbRglx6t5szEtWlI1vDQN5oW5PITGl/xk
	 oIX/lBWTyOvbXq+ritaQhtk56f81e+MZtRzMHMvNVD0ENWxj/yC+k9UINYqEsT+8/F
	 oEv9qVOKWIy5RvVMYGE0crDEgigbSTqAw7fCH85+V0daTpI0KSpbYEziIbbahUlAL0
	 Ju/a0sRVHc27YBv0e5qrmnLQws8KW92m/xLkKJHCiL1JKcRrszpHl60U+k/84gpSXs
	 AI5CkEWk2sLzFYbZKVWWuJzv8mCaRM5xp7ynCgNEzcRfOgtj2f5Jw12BtFNpGkvhN5
	 IY30BDm/3qaTg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture
Date: Wed, 21 Oct 2026 11:42:34 -0400
Message-ID: <20261021154216.364952-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102125-trapeze-unfailing-89cd@gregkh>
References: <2026102125-trapeze-unfailing-89cd@gregkh>
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit 746de48c3a250f0c264105dcbfcdf0c5001e970b ]

When ch_count is smaller than blob->alh_cfg.device_count (e.g. a mono
capture stream, such as a SmartMic, aggregated across multiple SDW
links), step = ch_count / blob->alh_cfg.device_count truncates to 0.
The subsequent GENMASK(step - 1, 0) then underflows step - 1 (u32) to
UINT_MAX, causing GENMASK()'s internal shift to use an out-of-bounds
exponent:

  UBSAN: shift-out-of-bounds in sound/soc/sof/ipc4-topology.c:2363:13
  shift exponent 18446744069414584384 is too large for 64-bit type 'long unsigned int'

Treat ch_count < device_count the same way as the existing "channels
equal to output reference channels" case: apply the same ch_mask to
every aggregated device instead of trying to split channels that
can't be evenly divided.

Fixes: 0390a102cc18 ("ASoC: SOF: ipc4-topology: use different channel mask for each sdw amp feedback")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Link: https://patch.msgid.link/20261008090130.15135-1-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ sashal: used a standalone condition because the playback-specific channel check is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 6af0cc154f3d7..5cf272fe93ff6 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1973,8 +1973,20 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 				ch_map >>= 4;
 			}
 
-			step = ch_count / blob->alh_cfg.device_count;
-			mask =  GENMASK(step - 1, 0);
+			if (ch_count < blob->alh_cfg.device_count) {
+				/*
+				 * When there are fewer channels than aggregated devices
+				 * (e.g. a mono capture stream split across multiple links),
+				 * set step = 0 to ensure all the ch_mask is applied to all
+				 * alh mappings.
+				 */
+				mask = ch_mask;
+				step = 0;
+			} else {
+				step = ch_count / blob->alh_cfg.device_count;
+				mask =  GENMASK(step - 1, 0);
+			}
+
 			/*
 			 * Set each gtw_cfg.node_id to blob->alh_cfg.mapping[]
 			 * for all widgets with the same stream name
-- 
2.53.0

