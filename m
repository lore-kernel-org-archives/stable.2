Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391866;
	b=TQtEfizjEoxhA0uKzyntBIAJ+YtCEpMGI3vd6bmdokS7ITqm05KiB2YtDQWMZaWui+XP
	 rd298rGMxHivQh8vNjpQUGd5WVT8V9QBNGBc3ak2MhJv8sGwBV8bboEmUx/4/GY89MR+k
	 oSD23/RydL8xoF23xRTPvhp/HDnXbCPTaht4YFs9YOk6kQnETSYNi3TpT433TsLygbyZO
	 7xV8OL/9sfSW/9rxVsmfcHaJikxVNtjpu/1TG/RLimc834XXSAJtWKymFWUyIBkQtJavM
	 aLX0l+TVZmxoE77z3Oj0RDEYxJ3uARug4Zh2yAL6wtpXBroqJ4JuavPiQfBHB3nXn1g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391866;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RcxfDSekYHt6ucBS4YdOO2qZxKQfdCAsVFgrNT1LI9s=;
	b=dbXNJcZ/b+RkYNpqPSGfck2yqzsaS81lujCFDj+WFrLbpPGm+O0I3bQ5C5vTD6Aiz7uA
	 Xy4Sb1E+gxb3VO3mfKVmTKrqr1oD7zFi1PkRBP+u41UOPmy1TC494SNaA7mBuv/oveNJy
	 RJE5U7rgY8hNkyL+mYjZm0mCBSCiBQxBXRT1Efmes20Tohx8D4S7I5NEzkmKOJbBfgpro
	 9dyT+A3LBqu/gJJgJzVBc2axX/jf0tyw9jsHH6lI5q3DufzAKh4VuWjWYKExDySUuHoG8
	 6HM74UmCGvTUYLxjEwobm8lwvADio92AhrGsYJqyEK2CMLy1d4UzW8/eXRPvpPUp/hw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgrQVlaJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5366606A88E;
	Wed, 11 Nov 2026 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgrQVlaJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794391865;
	b=NRrPwUb+hEfsHNApSSTlIrSnCZ76g6m8JLfAF+0E7O+eCvfQftHM2pXbeD2iYFYCV2DX
	 Jn74YGtiBfuTymdrLWVPdskSvmY/uoiw8eaI1Ad72vynrWnYc9SXBifhk44GFI7VGFqdF
	 7+5qtqVsTioQDHSKtsJu5PQvKSuS9ASkwixQQprp4Ne/lVfzdooIEZ9tmTgxT3iDnjHTu
	 HrFJ02MiuM98BKt0Xu8VsAQ0c6AjnozmsRuyCrSNw8fZm8jSglrI5J86rxntaM24TbJoF
	 tDyvhri+UIkqabwGw7SnSSAYGg6xKYvnar1Vo66GzZCy/kUPuPH4DL7zKK4d+JxLjpQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391865;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=RcxfDSekYHt6ucBS4YdOO2qZxKQfdCAsVFgrNT1LI9s=;
	b=Ik3rLtaMdvKf+3hkRbLQ1rJwyTuxBO1oLqgmAW5fYvI3bo6HUE9U4Q65zfZeC5ZvwA91
	 Z+6ThdhjcTG0Au5wK5DnzbF77XkqeBHR5g+bam4t9WBA+4sHjeQSSQioxTX/cqftGw9/Z
	 KJdV7MznbsnzDuu7XOwJyg2DarI5qlIaxZrnZe+VrCBKdwCCidLBmXO/CZITixtyQiq5/
	 GlmlrieCwyfSJ+pK8ZoD42MO+Gwczh4+sr8xsTbe3/AUnu9Jcbyin8K/vawyUMZgLHOw6
	 CMSOJ4YGp+BvOx7z2xtR07aFXiwZoS7k8YDgrX3mvf+U3b1j/Uyx3HYKKctY+ps175w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 832691F00A08;
	Wed, 11 Nov 2026 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391865;
	bh=RcxfDSekYHt6ucBS4YdOO2qZxKQfdCAsVFgrNT1LI9s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=LgrQVlaJl+zjHbwifuApc0KRvamezgVPcV6pqtXrii/Cmdn4prknk2e6DAYLBeBc4
	 X3dCTNoMj6HDm/qWMZoEC0/QksoZhOgiHed98g7Zs/WWdqWFUNJ5dYsFmGIGC3Th3Q
	 odkYL9+lgDm3V62fE9jBIGCVAMCBYSvnmaSHerO5vZ2VVR51gtyniAkyICZI4/lhXp
	 01OzsWfRer0RRCaFFPbPd2/iWr8wZh1SFdQB54fXCPAoqBc+T82LDW4d9+peswgtmC
	 6b2VVdzBV/a0uVzJVmkBI6o4TglCV/GBu+JlaWbuJEf0sloI03zC/62put5yGkmgW7
	 fQyD7xoPbXIIA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 06C1848F37;
	Wed, 11 Nov 2026 10:11:04 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Wed, 11 Nov 2026 11:10:58 +0100
Subject: [PATCH 3/6] memory: tegra114-emc: Always restore the
 auto-calibration interval
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-upstream-emc-t114-v1-3-54d9e1bceb6a@tsv-stahl-riesa.de>
References: <20261111-upstream-emc-t114-v1-0-54d9e1bceb6a@tsv-stahl-riesa.de>
In-Reply-To: <20261111-upstream-emc-t114-v1-0-54d9e1bceb6a@tsv-stahl-riesa.de>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391862; l=2143;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=TAnBAqYy7A55BHTS5zRoiWh6peV/YQug5wzY/XpzP7U=;
 b=3bGYVrsXMzw14FnvFfHSX/wK6/A6Ih2qMJmxlqJ4s8ey7rwdjmEj/OqYyDMe94ALBtxWVK5Bx
 Ms/t3MLnUf3BWPIanBMyhLDk5EHYXlPtz9oZ85nCA6+QS7HtVc2V7ub
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

tegra114_emc_prepare_timing_change() disables pad auto-calibration for
every clock change by writing 0 to EMC_AUTO_CAL_INTERVAL. The interval
is only written back if EMC_CTT_TERM_CTRL differs between the old and
the new timing, which is not the case with the usual tables, so after
the first rate change auto-calibration stays off for good. Read back on
a Tegra Note 7 (P1640) after a few rate changes, EMC_AUTO_CAL_INTERVAL
is 0 and EMC_AUTO_CAL_STATUS no longer changes.

The Tegra124 driver this code is based on writes the interval back
unconditionally for DDR3 as part of its BGBIAS handling, which was left
out for Tegra114. The downstream Tegra114 driver (tegra11_emc.c,
rel-tegranote-r8) also restores it after every clock change.

Restore the interval unconditionally.

Fixes: dce208b5405f ("memory: tegra: Add Tegra114 EMC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/memory/tegra/tegra114-emc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/memory/tegra/tegra114-emc.c b/drivers/memory/tegra/tegra114-emc.c
index 6ec1bb2c3ed0..9de3f2e728ea 100644
--- a/drivers/memory/tegra/tegra114-emc.c
+++ b/drivers/memory/tegra/tegra114-emc.c
@@ -706,7 +706,6 @@ static void tegra114_emc_complete_timing_change(struct tegra_emc *emc,
 						unsigned long rate)
 {
 	struct emc_timing *timing = tegra114_emc_find_timing(emc, rate);
-	struct emc_timing *last = &emc->last_timing;
 
 	if (!timing)
 		return;
@@ -714,10 +713,9 @@ static void tegra114_emc_complete_timing_change(struct tegra_emc *emc,
 	/* Wait until the state machine has settled */
 	emc_seq_wait_clkchange(emc);
 
-	/* Restore AUTO_CAL */
-	if (timing->emc_ctt_term_ctrl != last->emc_ctt_term_ctrl)
-		writel(timing->emc_auto_cal_interval,
-		       emc->regs + EMC_AUTO_CAL_INTERVAL);
+	/* Restore AUTO_CAL, it was disabled for the clock change */
+	writel(timing->emc_auto_cal_interval,
+	       emc->regs + EMC_AUTO_CAL_INTERVAL);
 
 	/* Restore dynamic self-refresh */
 	if (timing->emc_cfg & EMC_CFG_PWR_MASK)

-- 
2.56.0


