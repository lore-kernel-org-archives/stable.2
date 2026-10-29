Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793266388;
	b=4Y3TkTdyohR56R+xiy6nJVWJ/udJRK/EJnKBpLCE3Y1TzzY8w/zyDGha1PX8WFA/dy5V
	 4CI5WG2us5v3hvPQ0z8kucRp1YzqOU1+rn12AoFnNfGS352DmcYB2/XiEnEd1B99gpgOL
	 1piRGII/qzsJss8M5Vw8bsUIrTRl++uJvrBGHNYnCkzOSs7A1RskdlYRFklTbK1JZ6JXM
	 eTsQi6TWhaKjqbriCSgo8INQ1fuPTQuX5HA5DIRAO1kMFpTR3/2qJHzp0wgljUgGh7iqF
	 7Dpt1b/tUD5nMWHyOzpmGdIOFe9WCoAV9Jf1N1GjlikxuB6D2UwzYXKhrL3WZnFlHqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266388;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D2VRF1UIw2L4uB0SVfNxu6kmcdfbw/3EKqehM5bCLkA=;
	b=z1Rkqv+8lmadRorw7XslfskyWKiOvN49NXE4Zt0Xq82IujuMJH1ecO1605NgUbuLLrGO
	 78pi255r8yMzHRb9A1za8my5mHkqt4y/+hDPtBFkdXHbbi7f6W4n+mpx/fszboDQzobJk
	 ME31XEZjAdaKVBI45pGDL2myK1odkz0kD4Yt4q4tdgxGZNKsUyjJXD8Z87teipZvWYHmA
	 CR0G4lgJqOlTb7BGWqswmGI9LtPvnHuHeDv6WluC6fmFh7ss4m4m5qCdOQllhqXbv8zWf
	 YXKYqOAlVGOFk3CbYGHgklx8XweoKg7bz/1U8hTsT6hegpzmsX16K1v4WJ9xYnwHG0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSlZ0c9q;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409D7606A31F;
	Thu, 29 Oct 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSlZ0c9q
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793266387;
	b=RafwU4pyPS7EYktQblZVVeUJUF5RKLntq9YFAJ71sA7w2vrxbD5HaOwYNBoBf4DaGl35
	 CU5ZpiIGB0Ikf17q86fIedxYzbcC7uDPgfnxJSpOiTbPxRI2RFL3GDb1XQJtniZfXu09d
	 HltPIJ50Qlpax5kI/o9YZxmjPq6qm44V4E0CuaJuNw4wF0lz0IGZjyMkzUF/D9Pc7qxo9
	 3kE6zpofPCfwDAMc1qV8ae2ezu3WDmJmkIjbBOjUreQ7lNThkMXgt3dd9qbScBGYozYMC
	 zd18dmXo/iKEcrk1Ya2gaVZH6wMixNhS++FquzQS1ZPfaL7GPCNJuWcfwxJ2dJuS4lg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793266387;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=D2VRF1UIw2L4uB0SVfNxu6kmcdfbw/3EKqehM5bCLkA=;
	b=c8/Nc3Ek7Q5I+4Eis3sV5rAHNltEOepWIEYLDheXCG/yu6+p05tQxttNKnl1uJyhTW1+
	 Ee8+auKhrs2e/wjonqfAd2KSwU4Mc9tqG0NEf65jjsGYpMSZvNK6NEd1/w3gGCCAyxpTP
	 wENewzr0R52OzSDNRKdu3CQJ/Pfy9DKRlikY3WLV1RSFhPJEkOf9UpBC+7+La6Kv3kin/
	 isnQhmo2ZucI6YkdnnpWB+irN4VUnwsyz+dgZBPj/Z5QmBaUnELgyyyq1yfeIToLhPyQb
	 0bfY1R8LNgeUEGqcPS27hKVmJwT9J2YocO4Qxic2ygiaj65kSEzJasqrHW9ZYa6KYsQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 8C7F11F031E5;
	Thu, 29 Oct 2026 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266387;
	bh=D2VRF1UIw2L4uB0SVfNxu6kmcdfbw/3EKqehM5bCLkA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=GSlZ0c9qa/DNsF627Ye0ZhrEJ/fLCeRUYf2ISuLFhJUKhVfiHtyDLboXuMIiV/izj
	 A8PzY5dyKQ8H306DKSDROsIkmWkG75wMTd4OOdUiaYUydhr4G351JSMP/2212+tjCT
	 Bnr0lzdKTXbhpo1FfBnc/DLwjavOUobX7oCkPNpWAi24Uw4hzWUgIZcDrHvLPfXycs
	 Gl6awXvEoTTNXP7NEr3ICDBwJSLRBzpTDXCds/e9t04r33AxQimRXpxfeJ6zI0oZxc
	 UQ3RyamBuW1QPandsmsMG43TOh8CE1fRHqMMK03K6Nce0cpudaABn8FVpjLWxX5WYF
	 xLbk7z3Duvd6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1BF37457D1;
	Thu, 29 Oct 2026 09:33:06 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Thu, 29 Oct 2026 10:33:01 +0100
Subject: [PATCH 3/3] clk: tegra: dfll: Get the voltage step of range-based
 regulators
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
Message-Id: <20261029-upstream-speedo-t114-v1-3-81457cc9d94c@tsv-stahl-riesa.de>
References: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
In-Reply-To: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
To: Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, 
 Prashant Gaikwad <pgaikwad@nvidia.com>, Stephen Boyd <sboyd@kernel.org>, 
 Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, linux-clk@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793266385; l=3247;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=gDuzbARfWGkxqaRftjXwXdKDlFHjKq5qyD4dHr0p9zA=;
 b=UCEkvo1iL+WYXKVi+OSl1d7CVjMUf8WfbDywb4ejuLsyVFLuyGV4tLMHXRHQfNkaschpr9pgm
 pK4anvbJKLdDoDHmbZjnADxSRDPI5Bd1BMeWQYy+ACSr59oV2cGEbOn
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

get_alignment_from_regulator() takes the voltage step from
regulator_get_linear_step(), which returns desc->uV_step. Regulators
described by linear ranges, such as the SMPS of the TI Palmas PMIC,
leave uV_step at 0.

With a step of 0, round_cvb_voltage() returns 0 for every OPP, which is
then clamped to min_millivolts, so all CPU OPPs get the same voltage.
The I2C LUT is broken as well: find_vdd_map_entry_exact() and
find_vdd_map_entry_min() divide by the step, and on ARMv7 with hardware
division the result is 0, so selector 0 matches every voltage. The LUT
ends up with a single entry and the DFLL never changes vdd_cpu.

This affects boards that run the DFLL in I2C mode with a Palmas SMPS as
vdd_cpu. In mainline these are the Xiaomi Mi Pad (Tegra124, since v6.19)
and the Asus Transformer Pad TF701T (Tegra114, DFLL enabled for v7.4).
The AS3722 and MAX77621 used by the other DFLL boards report a linear
step, and the PWM mode does not use the regulator.

On a Tegra Note 7 (Tegra114, TPS65913) all 16 CPU OPPs are at 1000 mV
and vdd_cpu stays at the 1.10 V left by the bootloader. The CPU runs at
about 1.34 GHz whatever cpufreq requests. With this patch the OPPs range
from 1000 mV to 1270 mV, the LUT holds the 1000 mV to 1270 mV selectors
and the DFLL follows cpufreq up to 1708.5 MHz.

If the regulator reports no linear step, use the smallest step between
the voltages that are usable on the board. Fail the probe if there is
none instead of running with a step of 0.

Fixes: b3cf8d069505 ("clk: tegra: dfll: CVB calculation alignment with the regulator")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
index 457a77c5bb62..5bdea4775076 100644
--- a/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
+++ b/drivers/clk/tegra/clk-tegra124-dfll-fcpu.c
@@ -642,6 +642,7 @@ static int get_alignment_from_regulator(struct device *dev,
 					 struct rail_alignment *align)
 {
 	struct regulator *reg = regulator_get(dev, "vdd-cpu");
+	int i, n_voltages, uv, prev_uv = 0;
 
 	if (IS_ERR(reg))
 		return PTR_ERR(reg);
@@ -649,8 +650,33 @@ static int get_alignment_from_regulator(struct device *dev,
 	align->offset_uv = regulator_list_voltage(reg, 0);
 	align->step_uv = regulator_get_linear_step(reg);
 
+	/*
+	 * Regulators described by linear ranges (e.g. the Palmas SMPS) don't
+	 * report a linear step. Use the smallest step between the voltages
+	 * that are usable on this board instead.
+	 */
+	if (!align->step_uv) {
+		n_voltages = regulator_count_voltages(reg);
+		for (i = 0; i < n_voltages; i++) {
+			uv = regulator_list_voltage(reg, i);
+			if (uv <= 0)
+				continue;
+
+			if (prev_uv && uv > prev_uv &&
+			    (!align->step_uv || uv - prev_uv < align->step_uv))
+				align->step_uv = uv - prev_uv;
+
+			prev_uv = uv;
+		}
+	}
+
 	regulator_put(reg);
 
+	if (!align->step_uv) {
+		dev_err(dev, "failed to get vdd-cpu voltage step\n");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 

-- 
2.56.0


