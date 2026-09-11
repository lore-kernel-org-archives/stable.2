Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69471380FE0
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789091040; cv=none; b=WR8RDA7B00v9US0yBF2DVyenw5lLXjXnNS9Vu7vFdsTfp1BDC7q0iTH8nCcKj78TYFIJWdCUwtEeby9kXndSIoUP7k7WWFhqgU2kStX//fpPlyi8iKewg9GNHQgElDnBy6K3ndxZSbKrrVoDYDISdaEKpMtP4XiBBswzoJVTviM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789091040; c=relaxed/simple;
	bh=YqMwrUv8usRu+Jrq1qhLicBtx9MhyaTjbMkaZasHo3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lfQr6WB8Jf9dW0DGrmG4TLxFsG36zZS+gdL2nyM+C0xzxhctFcMnr1JEVJnGbPdHYDJdtVSk7oKA3Qr7X0RcdDOnp/rCPHit+SmiTEiOhDSBAnabc8Gwy6xZgFl8ZnKKzBQYtvNlRzPT8MRWkf3ib24c0DFrsNMCFcS5yaDO3IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9dzLoXt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9dzLoXt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C54381F000FF;
	Fri, 11 Sep 2026 01:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789091039;
	bh=ki59lNAVhW7GUefZCaC7NLF9hwzdMil6tJQf+KpL/ig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M9dzLoXtxkN4BiIhbpu7Me0mM4WvvOkWWLCc76lX5eOoLoxlCXgwM501NvT/0dPVJ
	 Y8CS5fjdJNeoeLAmDTKwFPh/yUD/aNIzf01WpGV3o1KOEoOnyA2O/ABIknPceLsE6q
	 iBU4SwW+T6oH9sEIJixangt8iniWbOG73MQtfG+dOGwOIurYeIg5DPROHxLZq93p+B
	 Qj9M5zaqj0SyvStJCdmN9LU75ukdTSW0OrVFcNqfM49/4Tc20XnLoNGKI1DENH/J/p
	 CJkW5nJ7inxWYOO1ObANJLlhH7DfiHQFVo0UZfWn3QFw4Jmbwc/OWnWUTKUucLDzDG
	 MquAsbmPjw0HQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] ASoC: tegra210_mixer: sort the register default table
Date: Thu, 10 Sep 2026 21:43:56 -0400
Message-ID: <20260911014357.4149699-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090906-choice-delicate-818c@gregkh>
References: <2026090906-choice-delicate-818c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

[ Upstream commit f70bc276fc7f712ff5c8e995d5050558a3198df2 ]

reg_defaults must be sorted by ascending register address, as
regcache_lookup_reg() locates entries in it with bsearch().  See commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

TEGRA210_MIXER_ENABLE (0x400) is the last entry of the table, after
TEGRA210_MIXER_PEAKM_RAM_CTRL (0x434), which makes it unreachable.
regcache_reg_needs_sync() then cannot compare it against its default and
reports that a sync is needed, so it is written to the device on every
regcache_sync() even when it was never touched.

Sort the table by register address.

Fixes: 05bb3d5ec64a ("ASoC: tegra: Add Tegra210 based Mixer driver")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Link: https://patch.msgid.link/20260805122748.13090-4-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Stable-dep-of: 5442b8093a2f ("ASoC: tegra: Fix the MIXER enable default value")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/tegra/tegra210_mixer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/tegra/tegra210_mixer.c b/sound/soc/tegra/tegra210_mixer.c
index e07e2f1d2f707..7808a54810626 100644
--- a/sound/soc/tegra/tegra210_mixer.c
+++ b/sound/soc/tegra/tegra210_mixer.c
@@ -57,10 +57,10 @@ static const struct reg_default tegra210_mixer_reg_defaults[] = {
 	MIXER_TX_REG_DEFAULTS(3),
 	MIXER_TX_REG_DEFAULTS(4),
 
+	{ TEGRA210_MIXER_ENABLE, 0x1 },
 	{ TEGRA210_MIXER_CG, 0x00000001},
 	{ TEGRA210_MIXER_GAIN_CFG_RAM_CTRL, 0x00004000},
 	{ TEGRA210_MIXER_PEAKM_RAM_CTRL, 0x00004000},
-	{ TEGRA210_MIXER_ENABLE, 0x1 },
 };
 
 /* Default gain parameters */
-- 
2.53.0

