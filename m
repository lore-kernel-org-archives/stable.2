Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792596597;
	b=IghCRhMALxEOE/6mF7g6xG0sfoyqxdYrk9kmH1z01kAdyhoh8/jV5jaH9qzy3yFThl7W
	 fbjp8zcweIg2O+LUn843BgtpUmoyoNxY7bsYDqQqa90WQHZmBqFWZ4nmZeZa177FuREMa
	 1GgTnUHCo2EAsj7UAvbuQwIzCzmgOFw3IbPssR6ir2WYLeH1cIOm2bUDLH1tHOFCBZUXP
	 9wiWJV+J7xV/QfEi2whHJ7YCQ7/ABAbl8nqMywVqQn8fquHD5UZ8BH0MMhPsd9BWEe9TL
	 +cBFK+w2/mvcsoEbx/nrvr6iIH1gXz7nnmyiwJuW3JukTYOVXWvY6gt8yTbD1kr1y8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792596597;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5n0gDyaEJNwm5DX2KoGvBK/FpXmEq1x8Hw2MMoFrhXw=;
	b=w+lzNyvkdYC/EgQ8XjnShdaLXH1Tv/rfbIa4XLhZr19me38B+x5M+ojb6f5AThQwzYQa
	 rRcttiDTY594o9TqVYCi7LVnVcM4XlvesSv1BO7k2lt3In6hMhNMAGK6toS1wjXCLFQ6W
	 097maC+lFA/e91vXhtnfCLZBoZeVqipEXRxM2D+BIq5Lf0de6zgMzW3sr5INkyyq3uJys
	 UEKEod0O0TF9yJQCISugBPhJACtt66e1GBYPllJYllA1/TOT+SVcyIcQK4dl4WEgBrDCW
	 /UW2CihOLguxyTMHpfPb6QkUYS9GtJkxcn3sa/TgKrlSlq3hZCv1wtCHRwzvhcon3Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Trq2glKA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4967D606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Trq2glKA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EF31F000C1;
	Wed, 21 Oct 2026 15:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792596597;
	bh=5n0gDyaEJNwm5DX2KoGvBK/FpXmEq1x8Hw2MMoFrhXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Trq2glKAQzX+p5M5c2qAsDxCZMK/qYkdsTMtZH9n8V5HNnAw2XQJodgP4+6XOihR1
	 JZNY3vuhsld1xfldTh2VgyF6+/BLq4ftxA6fzI+NUFGFB2AMnC/+hGgyw1CFd6OuNt
	 MEh/09XfTmCQ3Tx2LKEcW51H3bfs5YUCeKQwQtzmTft8rc2YjXo5ALuCwRef3JTa5y
	 cFfE+OkP4fGEBBNGoWNNanSURax39mGCbWsRA+xS4KRKHUDCjMX2qU5W5XT/i0syb2
	 4OOHbXkFIqdXKQD+B+EwG1oS3nLRbNK4kJYx1PwVnSwQZ6pyfp4kOF3Vaj11PgVmbD
	 6QJr7qIF93EYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture
Date: Wed, 21 Oct 2026 11:29:55 -0400
Message-ID: <20261021152922.287978-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026102124-wisdom-print-3a6c@gregkh>
References: <2026102124-wisdom-print-3a6c@gregkh>
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
[ sashal: Added a standalone guard around the mask calculation because the upstream playback conditional is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/sof/ipc4-topology.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 5701e4d1ac130..7178279ddfb77 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2286,8 +2286,20 @@ sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
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

