Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793266388;
	b=EuAEKrIUdPpl6CAM7tXgeYAhPHe/44YQoPIGCtuMzAhctbrVaCaLFlTDim/lgQZIGH2o
	 C/S3bR8kgyt+j2L7+QgVA57PazldBU4Xm7UcymXw+gq+E2L0yVm9DLkW7V1TFYV/uYt+d
	 IlN5tgoz5LU1Jc4uJRDjWQlCI1J+vmW8D5nH5Y1Kl8QWFSJjJu5nIrk+beY4e6Ljs2GqX
	 zzU8xEKCTOwBBzEIJkptz4cObY8N5TvPzJevf5WdI0PSsZKJA5TFOehEfongexC9zVIO1
	 aFPJVpm+7yGChzcHWKeQydT4VnG3y+qypcx7gCwfWwYdBxwAxfd/x4/dXMwLp876m4w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793266388;
	h=Received:DKIM-Signature:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=GL31jgXRFIfptssau1/G2Hf4cv+6lZIIXvgonuIhO0o=;
	b=AMBQG70cqA99NOLymMKDnw48bomhfUcNA+/ZoHcHJOggMcsZ6rTZmRIJV6sH55uysMAo
	 Y3KojkrHtO2IvSJTOLLjEcClTTqLnZWbO2aAwDA6Jz4nqB9NayUN1khefKF4YH8eCHGp9
	 ba+c+jVmEvZNw4L/c5/rkDd52aKFfLmUvTIug0Qlq7wKpg4HdcoG/v6T2WkVbzgShcXpc
	 A2HeJstWMXi/pYC+7iYgPzqRFW/URiY14/DohA0BL3yvSZIyCy2Z2jiep+WDu1NHgFmrv
	 BtIa2clB7yFd0gkva/uaGyw3fT9qRlWqPAakek7BtOLP+kRVJd0m6SPyn9gP7sALcnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiY4gYMM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A48606A325;
	Thu, 29 Oct 2026 09:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DiY4gYMM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793266388;
	b=DHmKFLslKpBg8WAkTEF0yV16JwQLezQaOlU4DILdDB/1RgH4Ns/PGTjucRJaLf52kVIN
	 3023xlXOX7DsSf1j8aowNgVNCEqRQOLXfiLqGsqMBxRytbRf1x12SXjXNWHxb8lx/ouBV
	 0vexa7fCXofVhdDqfhtgbum3i6/zj6sGg3YR25BBaHzGI0pHQytevQejhXZ7hsyTdmAFE
	 0mf7ysTOtv0XYrqR14J4LBUJi8Dqf2nsA5neNETIRp9qLAUD8E5DilTgUo4ydKf+DPG+9
	 zjMqCn9dRetv4rPWs5aXwtFsRl//wcpdd9ogct2ca3uE41XkIV/rawnJOdMUUsLm7EA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793266388;
	h=DKIM-Signature:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=GL31jgXRFIfptssau1/G2Hf4cv+6lZIIXvgonuIhO0o=;
	b=00Tm3yzgcK12dYYyrxrKd0+XmwkiUWYLWN3WQ7qFgybH6+WbZWH5CE7AMkxQkHygo3Lb
	 c/RcANivw4blQvQD4XCJ13sPTzciWgTDsMcS8hm8sCsvLOPaK1i17/QKgkEHqaJ1RdNxY
	 FDzS52mHuRpx11xlykH1lkAd4IxWLjpxip51VlcoLdLAvyI3xxhOcrOiHfF0L9686HrAA
	 PgzZkBHRjHAiecAtU1uwSlndkaV+IXByPyoGsLtzLjCHX25+IrFpx+OStDf4fAhhok4TQ
	 ezDB9Msm3/QhJqGNsDufbXa4Yd1Iv7B6cWKuDo/Xj27qyvtAO4opFKUR6nP0LoH5FLA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7654E1F031E2;
	Thu, 29 Oct 2026 09:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793266388;
	bh=GL31jgXRFIfptssau1/G2Hf4cv+6lZIIXvgonuIhO0o=;
	h=From:Subject:Date:To:Cc:Reply-To;
	b=DiY4gYMMSrafWJ+9WSgFB6dcJ5q/nJz1wwPg616KuMqq9DI0AzL1aow1SFwVAFUcT
	 EufoUldSOayfj10zH63JVJ/jhmcpMkqPLUOo28QwTvK4pCYd2BEYGxLTNbgnMDaA8l
	 kb0RFNg+ueb5IW7Ou9LtSD/UifUYEL6iA8XL0Pytw4OnjAXpiY7YNyvazUXGk/6GTA
	 +wgpHnZXPo+MxEdZ9WX3wNIzZynr6GfwwKxUJw0iSHj5wQH4kWOg9P9rXYRoX2lDzx
	 sIEujwiwNzdxJPT1y8ui2j+Z3yfoIC18pI9o+z3HFi7ZJbfZRoe5lf2AuJdLpGWI3R
	 j0RZ2+fo7NRtg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E7D50457BC;
	Thu, 29 Oct 2026 09:33:05 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Subject: [PATCH 0/3] Tegra114: Fix CPU DFLL voltages
Date: Thu, 29 Oct 2026 10:32:58 +0100
Message-Id: <20261029-upstream-speedo-t114-v1-0-81457cc9d94c@tsv-stahl-riesa.de>
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
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMBCE4Vcpe3bBpKYFX0U8xGTUFWxDNimF0
 nc36mEO32H+jRRZoHTuNspYRGWeGsyho/D00wMssZns0Q6mjWvSkuHfrAmIMxdjTty7YRx7F52
 3gdo1Zdxl/WUv17+13l4I5duiff8A9Srl2XgAAAA=
X-Change-ID: 20261026-upstream-speedo-t114-3567735d5a2c
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793266385; l=4081;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=/lrIR8C9aN0HrUcDE1aMGU8c1QUaKAoG4KgVSPwL7/s=;
 b=sDqEJpNgmEA5eRDywidt+SLNcWdfGwXPBATBDqtk2yn4iRbSKEeYFNrOXiunqPjQ2H90QRFC6
 RWg2mWdmOF8CsvJ0MXR6mUbgPtAmFWdvM70SrH2N3TbSmG/jhwvGWGx
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de

Since the Tegra114 CPU DFLL got its CVB tables in v6.18, it computes
the CPU OPP voltages from tegra_sku_info.cpu_speedo_value and the step
of the vdd_cpu regulator. On a Tegra Note 7 (Tegra114, TPS65913) every
CPU OPP from 306 MHz to 1810.5 MHz ends up at 1000 mV, and the DFLL
never changes vdd_cpu: it stays at the 1.10 V left by the bootloader,
and the CPU runs at about 1.34 GHz whatever cpufreq requests. Three
bugs cause this:

1. Since 2014 the speedo code reads the Tegra114 speedo fuses at offsets
   that are 0x100 too large.
2. It never stores the CPU and SoC speedo values in tegra_sku_info, so
   the DFLL computes with speedo 0, which overflows in
   round_cvb_voltage().
3. The DFLL takes the voltage step from regulator_get_linear_step(),
   which is 0 for the Palmas SMPS. Every OPP is rounded to 0 and so
   clamped to the minimum, and the I2C LUT holds a single selector.

On its own, patch 3 fixes the Xiaomi Mi Pad (Tegra124 with Palmas). On
Tegra114, which includes the TF701T, it needs patches 1 and 2: with
speedo 0 every OPP would still overflow to 1000 mV. That is why the
three patches go together, all with Cc: stable.

Since patch 3 is only useful on Tegra114 together with patches 1 and 2,
it would be easiest to take all three through the Tegra tree.

The Tegra Note 7 device tree is not in mainline yet; I used
Svyatoslav's tegratab series on top of v7.3, with these patches
applied. Results on a P1640 (Tegra114 A02, SKU 5, CPU speedo ID 1):

- The fuse values match what the vendor kernel prints for this device:
  CPU speedo 1742, SoC speedo 1156, CPU and SoC process 1 (before:
  SoC process 0).
- CPU OPPs: 1000 mV up to 1122 MHz, then 1040, 1070, 1110, 1150, 1180,
  1220 and 1270 mV at 1810.5 MHz, as computed from the CVB table.
  Before: all 1000 mV.
- The DFLL LUT holds selectors 0x38 to 0x53 (1000 mV to 1270 mV)
  instead of a single selector 0.
- The DFLL rate follows cpufreq within 2% from 306 MHz to 1708.5 MHz,
  with vdd_cpu between 1020 mV and 1260 mV. At 1810.5 MHz it stays at
  about 1.74 GHz at the end of the LUT (1270 mV). Before: about
  1.34 GHz at any request.
- At 1122 MHz under load on four cores for 480 s the CPU stays at
  52 degC with 3.15 W from the battery, compared to 73 degC and 4.48 W
  before.
- No errors in a memory test with 25 passes, in three 600 s load runs
  with cpufreq limits of 1428, 1606.5 and 1810.5 MHz (throttled to
  about 1.0 to 1.2 GHz by a board thermal zone), and in 316 s at
  1810.5 MHz with that trip raised (DFLL at about 1.73 GHz, 1270 mV, closed
  loop throughout, stopped by the test at 98 degC).

Svyatoslav measured the CPU OPPs on an Asus TF701T (CPU speedo ID 2):
without the series all of them are at 1000 mV; with it they are
1000 mV up to 1122 MHz, then 1020, 1050, 1090, 1120, 1150, 1190, 1240
and 1290 mV at 1912.5 MHz. The speedo IDs come from the SKU and do not
change, so the core, EMC and GPU OPPs stay the same, which he confirmed
on the TF701T.

Tool use (see Documentation/process/generated-content.rst): the patches,
their changelogs and this cover letter were prepared with an LLM coding
assistant (Claude Code). It compared the fuse offsets with the vendor
kernel, read the fuse words on the device, traced the zero voltage step
through the DFLL code, wrote the code changes and drafted the texts from
my measurements and instructions. I reviewed the changes and ran all
tests on the device.

---
Patrick Fischer (3):
      soc/tegra: fuse: Fix Tegra114 speedo fuse offsets
      soc/tegra: fuse: Store Tegra114 CPU and SoC speedo values
      clk: tegra: dfll: Get the voltage step of range-based regulators

 drivers/clk/tegra/clk-tegra124-dfll-fcpu.c | 26 ++++++++++++++++++++++++++
 drivers/soc/tegra/fuse/speedo-tegra114.c   | 16 ++++++++++++----
 2 files changed, 38 insertions(+), 4 deletions(-)
---
base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
change-id: 20261026-upstream-speedo-t114-3567735d5a2c

Best regards,
--  
Patrick Fischer <admin@tsv-stahl-riesa.de>


