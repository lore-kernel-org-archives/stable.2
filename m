Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792597695;
	b=GavLEixG7d5HVfSga75gjZik7e1JtDnFioQ5bY1bCUHZ2bQ0S2Bpu2OmNaAaZMRoBPbG
	 4pl17actNQ+7pntKcjdOCg3w55Zx3mnGGmIJ5x76uG6oqe3dZs0RWazRQZaR3uT003GwZ
	 rydOupohMcmQF1eEQBodOThvJqpmL9FA46Y6fUoyBxiFKfqupNgee59VUGxubbeLmcyQk
	 bv7WTWGU6WTItMqpBYW8a9a/J3YiO5jd6stQs4MfQnLjML0hI+RoqTeW1tFGqZxCzaEw8
	 sus2CSviwlzueJuWbn5vCeFUJ1BKu60lSSqVXpxCHW0zDIzvm6EGhSg7BJslnxlaa9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792597695;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pVmPtQnfohqF6KvWdD7hK640VkjjGjCnIC271nP0U5U=;
	b=Kp9BRmz2FvpbkM72znjbzFch0CYRzXYSpaoMwvG5/RTuNPnu/GKWbPzOK3c97p2vpLtu
	 nGSbBMFdh1L5ezm5ANdiVT/KAJ3fuoMOhnswDUfA2oPPDoYW5viBAj53FAx2YC+6DYgwW
	 W02v1W007N/HwOXy3euBr+nPRb2EaWEYjZBE3GmcsAMnYLAJa+3xClp5Yp8HHm7G1p8bd
	 bXQCmfKHnFUxNtDLEyipD4zGFsimuuhsK0pZk2R5niIRv7fF4+gVyx/p4CAR1abLnq447
	 uD41HLLKiOv+j+tG0jvm5Gjmox1cO7dVOuv3cw8Y9YJuMJ40kyNhAgr8L0DJNIAtg3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4OyM8fT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FFE606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S4OyM8fT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 464391F000C1;
	Wed, 21 Oct 2026 15:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792597694;
	bh=pVmPtQnfohqF6KvWdD7hK640VkjjGjCnIC271nP0U5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S4OyM8fT1PlzPhoppISg6ptaN+PcxGbP+zeeTP927nU9A8KGYsUtRDIkZwku39pH6
	 SHVZyLfpvzHZMtFgi0nfeZ1PuReUZXi92UGa9xdodBlTF8oT9NwG/Fvx7DovigG0Xn
	 ef5BSHY00jE3TSwgJyd4LHL1VMZNW4V19N4oOqDstiEsRB0m7voNbDxsdNb98M0AQQ
	 2B1xIi7KzkUH8Itn5kVa+dzlV4wdy0KskwONnEqZ7DY5jq5yhxQURt0s2BOM064T/H
	 C1ZvRkVTuWKbShQTtec8lRiNU1paTeY15Ms9gzrde54VF+8lqlYkxPJ5lZ3r1YHVJN
	 pTjuGQq2pkU4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture
Date: Wed, 21 Oct 2026 11:48:13 -0400
Message-ID: <20261021154744.386960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102125-stole-applied-92e5@gregkh>
References: <2026102125-stole-applied-92e5@gregkh>
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
[ sashal: used a standalone guard because the playback-specific conditional is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 8911c075251ca..8e16ec8038382 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1690,8 +1690,20 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
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

