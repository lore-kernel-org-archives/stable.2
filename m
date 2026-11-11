Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391866;
	b=crv9Hlys7DYDeuo6LUdCY0vOdkhzTQFulV3WrtJ5FnyuWOU52GIhAU7EcEO33FSGDqnB
	 OUFgJRzrQcEgcF6mxPAIxKPaQ53MZfGEQRYYPVIf8+vEl1ABFqjPWvyhEhlSkNSt4gzh3
	 MenrX4AOcoOTQIvjurWb+KN0nxvgyK1dS9oiVv1zgRE9s0poc0haDXCo0b4iBO1E6/lhx
	 781Ow1o3q9YEFrnOiIMHPdeIllkj8sN4Pp/XKMC/ugeZ5i4+8nT/+ioqMajZNrrBg7IcP
	 LSM6hGUbzdH9NFlG7UWiBVumVCaZN/AXs+qZRXqcuysI2vJEZMid060J4ZpEKfWoTOg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391866;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hqG/5n2Fw0o37ScKdmyH8WTD+AUmkp/qEcM3NOL2EWE=;
	b=XA7LxphlmDgqGTZTwv/iwnYM3yuY+stYZp1sNtqN7NNBI4rtMiIfv6lStvyqeWcWkS26
	 6y9q+AdfO1eTE3kOLsRH2H/POYyXDd9zmCmbByRZFpjguUzjplPV8Wcdwx72BTrvJOZs9
	 2FE5Emagh/ZgpKz/m1umt1DKTtDO1WmhaztJB/4tpmpfDOQ/kscmbQOmFpD8+3izB8eMI
	 PWeKYtgBhHjbYytbN1nZc3QtO/G2lr2GFsf+QU2a1G/B6K4B5Sbhs3SuxzbhDUGu3vPMp
	 TBpa3H3RvgU+qLf4fM5aukiRU1+kGDBA0yRPWiVifK304wEj0FECKgaYCQpRJYS0kkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPYzvAgP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C57606A8A9;
	Wed, 11 Nov 2026 10:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gPYzvAgP
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794391866;
	b=Jb1rXNpqA0D30uDhoQtZzG30pxzpkYfwKnLI5x7IUuC9wYjpjiuUi6OpnsgE8lQh6oVh
	 0Ug/+SjkHaJd6fs3UB6O6EBb06NKBT4lvcXe5gFBSEwSfQZgQMY1Ks7KJkTez594I+17g
	 ykm8t1DdRQlw6fYLbn5BDg1yzqB3B9a71cgdqJaeyalrohiSLCC2QZgKnp0tKGej/oEAi
	 Pc5AgcRBUg2J0vyTbifj4UBIrGzLojJRISxADm5ST1j5Y2DEg5Qj1rkue35m8daFSLoHV
	 TsfOm+6qHHjC7yBSnenxyLg4KiV2c5Qvgq0mnz2cLfoO4+Li/3e0VJkx0wH9EzqxrSQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391866;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hqG/5n2Fw0o37ScKdmyH8WTD+AUmkp/qEcM3NOL2EWE=;
	b=snp505tNPs2O14hf4KLj+p/LhWxX/iILX0l7U/UcncsPYJrPHp/c9MDFb2r3falAAcLb
	 4AlZPGfdprW1oU01hyaaEa4vgf9i98fhuLvO+iH7i6s4vymXntBLgJIGIImCHlN8ucygM
	 wJDE+Bv+5d8zB/Khb9OsWY8QrBHKM/OJvQD0m0dB81+CE/CAKdMIysy2asLO9t28ZVxq8
	 zpBET1WGgxSg5D1UvoX5WRhv22Y2YcktV1idA3wk5Xz3Uc+pPLhOHGXaZt4r7KSx8HRzk
	 b7Bo1PEHxJ9ttHEG9RFltDkbSBYLN6tLh594cUGUTF72dAl8rsPi5JYl0RKTKbYyLNg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5A8FE1F00A07;
	Wed, 11 Nov 2026 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391866;
	bh=hqG/5n2Fw0o37ScKdmyH8WTD+AUmkp/qEcM3NOL2EWE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gPYzvAgPHeXswVngIHMUTD5qy9uJzv8uNoBdhTyBSBbQHBON2FwP5UPTPAWBQ9j89
	 LDrLp76tVoOMoGbNYype7FMNcmjxlpZx3gZyLBqnNgqGhjwb49hnFpBCVEvkco2ikd
	 z0ekySdh9F1xc2j6uiS2lUNLTmLbaderunUN6/VMfHYx2CEiOyjWc+5u7m2jpSc6u9
	 7bu91/5ECrRfpUqqHbwZhCvQ3aQGsGmxyZhRCWfqA+yc/5nfhrDhtUi4oeizGDWr9U
	 B2Njh5HPc9YTGBZWerRPmacaIvVLGYwVClyJQgnxDV1hAo+t1BiN96KSM/Ei7s9ZbH
	 ZgEeLPMOpO+ZQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D511C48F33;
	Wed, 11 Nov 2026 10:11:03 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Wed, 11 Nov 2026 11:10:57 +0100
Subject: [PATCH 2/6] memory: tegra114-emc: Use the full DRAM bus width for
 interconnect requests
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
Message-Id: <20261111-upstream-emc-t114-v1-2-54d9e1bceb6a@tsv-stahl-riesa.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391862; l=2117;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=UKyU8gpXKnhxvj2H37ZDY9d2HuSp5Dvn+JPZlIlWg+0=;
 b=N3OmQ1Ge4ojApoGjsEOZEqZvTWPcxMM0WKEHL1mgIyk4GG4Dw72eK7Oq9+XJzRvklgzMxjl/K
 M26mI6Vim7BDGO/wUHjVsVRAZdHlruwZz2RegL7L3wH4bcYFpAo7Umo
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

Tegra114 has two 32-bit EMC channels, so the DRAM data bus is 64 bits
wide: the Tegra 4 TRM describes a "dual-channel (2x 32-bit)" DRAM
interface with separate EMC0 and EMC1 register blocks, and the
downstream kernel says "On Tegra11 dual channel MC effectively operates
as 64-bit bus" and returns 8 from tegra_mc_get_effective_bytes_width()
(arch/arm/mach-tegra/include/mach/mc.h, rel-tegranote-r8).

emc_icc_set() divides the requested bandwidth by 4 bytes instead, so
every interconnect request asks for twice the EMC rate it needs. The
actmon OPP table in tegra114-peripherals-opp.dtsi already uses
kBps = kHz x 16, which matches the 64-bit bus: with the current driver
actmon at 312 MHz requests an EMC rate of 624 MHz, and actmon at 624 MHz
requests 1248 MHz, which ends up at the highest table.

Use 8 bytes. On a Tegra Note 7 (P1640) the EMC rate now follows the
actmon level (102 -> 102 MHz, 204 -> 204 MHz, 624 -> 624 MHz).

With the correct width the EMC ends up at a real 624 MHz on pll_c more
often. Both kernel panics I saw on a rate change to 624 MHz were with
the auto-calibration cleared, so this should not be backported without
"memory: tegra114-emc: Stop clearing EMC_AUTO_CAL_CONFIG".

Fixes: dce208b5405f ("memory: tegra: Add Tegra114 EMC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/memory/tegra/tegra114-emc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/memory/tegra/tegra114-emc.c b/drivers/memory/tegra/tegra114-emc.c
index eb1360627ece..6ec1bb2c3ed0 100644
--- a/drivers/memory/tegra/tegra114-emc.c
+++ b/drivers/memory/tegra/tegra114-emc.c
@@ -1163,7 +1163,7 @@ static int emc_icc_set(struct icc_node *src, struct icc_node *dst)
 	unsigned long long peak_bw = icc_units_to_bps(dst->peak_bw);
 	unsigned long long avg_bw = icc_units_to_bps(dst->avg_bw);
 	unsigned long long rate = max(avg_bw, peak_bw);
-	unsigned int dram_data_bus_width_bytes = 4;
+	unsigned int dram_data_bus_width_bytes = 8;
 	const unsigned int ddr = 2;
 	int err;
 

-- 
2.56.0


