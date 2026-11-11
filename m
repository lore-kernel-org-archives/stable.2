Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391865;
	b=y6mdlcgRbUFtDM3zWaT2cRDmswjqE9Z7da1sGe0EF7V/HcObwVm54264k0Nj5YtvpNeS
	 b1SZV8xropNpc9ruyKs7PxhO1EQy28BaQHo9wT1L2Hox9MgLNKVCoE+mpMfKUto1pEmJK
	 WlUylaBJQrIt/gz0MA9jryCRT+ibiLQMu35GX5tKQ5PAGTWfLpNyfPnRXbQ8WH1FwHaKD
	 MnTUQZLcFwepezGLzcpEmBydOndsS0wTjtTFMrzdwTWdBUGPXzcLd8CwxCqQmW+LwoERE
	 eX5bD04X9kafx6AX7rraecDmN+PYS9ZKoyc57U4Ubfxk/BRD1E4W0FIva2mfJPCV1mQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391865;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GEsylJqHfV7t6xP0By6QnSVqMCDFT6AOk4Aa/qVk7zY=;
	b=Uy5uY7sX12ncR84efFaU7jDYumNeG7FJinAf7pEcNqvEeIAKQJCtSmddsYTfSe6n+Amn
	 DVcMr0msnCQUVOtIWx3FbmPBD/UMWuVcEBHIQABPcZLfT60X7hTYQSv3HKOB7w5t6lE3g
	 DoxzxYZzJ91CYckg6TFdWvHulPh0+IWoI36hayxbGdv/graEgoB+SaamMI3y452hqFKjh
	 CgXQJ2sGX9V1NfBQFSXrqHRPHnELGF1zBBf/d1jvM8D7cuAQQ8LrFa1f8uOgiCl7aiQHH
	 spqeCnDuqUSqnEffFMHkUze4FurZpVNoab4z+wta2pyh0hIk3ZpMT5PP+pgcMBSMJkg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz84woZ9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3FE606A31C;
	Wed, 11 Nov 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nz84woZ9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794391864;
	b=Zu54Bz/X6iE9ff/zFPh0ku0fgDTYnm3L4DsmXFoJgmAKKXE5Oh0umw34f88x4PfI5qZV
	 krpS+8EKqRMuWCJndTgyKheurOJUxzi1jbNvfirCNXqCi0NUO6dQQ/9/poO+q4XjWF13r
	 Y3FwajbRXx2sFeYwCmO6kEdB7CrXK2sSiIWthENIjyJmc5Xqf/LooyYihX2wu3zrH+RB+
	 KIOeWn6cXPoR7aa1rbWWOjNSt4qlDN6W8IKB8hnoGssD01trKDr4MdtxTVAc7Z6eemMbE
	 znCZYj/ozc7LhBsx0D9Ggq9Pe1njZcqoO3X8dwfkVkWMoSCesw2wmcjfNIoiYuqHung==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391864;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=GEsylJqHfV7t6xP0By6QnSVqMCDFT6AOk4Aa/qVk7zY=;
	b=HEF+p3XQZ83VIeqZ5dGKmkNTUnGn4HUyAkgYAEBNx5f+zPX/HCDgCOKct8xylaRZZaRA
	 wksNR6XNZud5MBmh/Ir4CfYy4q0o2bu3HfhY94XTcm8VlVZ9cWsrF2HJp9ZkRfWGBdsN4
	 eYnLOAYkYIouxXmrC8SEaI7HAWW6V/wMDXyZU6VNkffFyqlQ4v+Lrs+iXLM2kHtfgwYGF
	 uhBJ8StuTPnS5MbThChWACHHZz0PuxM1WXd25O8Q3+H252FadPVOKe+eqqwRrl53YA7Uo
	 PEKEKQXw3cIo0gM0/nATZZEfKooOx84/esi0Rs/OdZ1YJ1p4Xo75PPVTS+vL0dQO7Ig==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 366931F00A05;
	Wed, 11 Nov 2026 10:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391864;
	bh=GEsylJqHfV7t6xP0By6QnSVqMCDFT6AOk4Aa/qVk7zY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Nz84woZ9jtuNDH83f3owqsLN7pg9y73N8UqUarAAcdgzzPnAVyG2WOXkb7MNHOvFp
	 semsROA1ye3HQipTXa/MA+JVNmHxDufasx76DfikR44kNj6Kd1JC0fOsWYFib9aONm
	 RS/tfzQTcC/iUEAuHINxOmiPpLG58MaYqLj8Tr0U6e/f1yRP0KSOFHXHtOS/xHWyA1
	 SjcR2FjNgv8fEkb4Ytg1jzEsxr3fXxS823S2o5MhWpNVquJXd+JSQNqRNdnOrvrsGp
	 dSbCT+x2V7HaqnX6RYKP2gX3ry8IdltRpIvlvLioboSC5NnZLhPipVXWeah8o7eXyD
	 iCgMIp0RPmehQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AAF2A48F2E;
	Wed, 11 Nov 2026 10:11:03 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Wed, 11 Nov 2026 11:10:56 +0100
Subject: [PATCH 1/6] memory: tegra114-emc: Stop clearing
 EMC_AUTO_CAL_CONFIG
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
Message-Id: <20261111-upstream-emc-t114-v1-1-54d9e1bceb6a@tsv-stahl-riesa.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391862; l=2555;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=VedvDoHeeh9Rio1y6TI1PoAGPqxv39pJW1v6xrOmiGA=;
 b=mXxhCsFz2yS8pLPwTfK02jdkktTzaRUq+XULbNJStzWwzYL3CXRJnpToHH73+rlvv+dObA/ko
 0MPJS13WleJCR7GD893vCIpKgc1YG3bS3RHmY016ye4+YT1tL6vhQkA
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

tegra114_emc_prepare_timing_change() masks the EMC_AUTO_CAL_CONFIG value
of the timing with AUTO_CAL_START before writing it, which leaves only
the self-clearing start bit. As last_timing starts out zeroed, the first
rate change already does this write. From then on AUTO_CAL_ENABLE is
off and, according to the Tegra 4 TRM, the pads no longer use the
pull-up and pull-down codes from the calibration logic but the static
settings from the pad control registers. On a Tegra Note 7 (P1640) the
bootloader leaves 0x20f10f0f in channel 0 and 0x28f10f0f in channel 1;
after the first rate change both read 0.

The full value cannot be written through the broadcast registers
either: channel 0 runs the calibration and channel 1 is its slave
(AUTO_CAL_SLAVE_MODE, bit 27), so a broadcast write would make both
channels masters. Leave the register alone, which keeps the calibration
the way the bootloader set it up. That value is not necessarily the one
in the timing tables: on the P1640 the bootloader uses the pull-up and
pull-down offsets that the tables only have at 792 MHz (0xf0f). A later
patch programs the table values per channel where the device tree
describes the channel registers.

Tested on a Tegra Note 7 (P1640) with this series but without the
channel registers in the device tree, which takes the path this patch
leaves for existing device trees: both channels keep the bootloader
values through rate changes between 204, 408 and 624 MHz, and a 10
minute memory test switching between 408 and 624 MHz ran without
errors.

Fixes: dce208b5405f ("memory: tegra: Add Tegra114 EMC driver")
Cc: stable@vger.kernel.org
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 drivers/memory/tegra/tegra114-emc.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/memory/tegra/tegra114-emc.c b/drivers/memory/tegra/tegra114-emc.c
index e50d71842d3a..eb1360627ece 100644
--- a/drivers/memory/tegra/tegra114-emc.c
+++ b/drivers/memory/tegra/tegra114-emc.c
@@ -609,12 +609,6 @@ static int tegra114_emc_prepare_timing_change(struct tegra_emc *emc,
 		emc_ccfifo_writel(emc, timing->emc_auto_cal_config3,
 				  EMC_AUTO_CAL_CONFIG3);
 
-	if (timing->emc_auto_cal_config != last->emc_auto_cal_config) {
-		val = timing->emc_auto_cal_config;
-		val &= EMC_AUTO_CAL_CONFIG_AUTO_CAL_START;
-		emc_ccfifo_writel(emc, val, EMC_AUTO_CAL_CONFIG);
-	}
-
 	/* DDR3: predict MRS long wait count */
 	if (emc->dram_type == DRAM_TYPE_DDR3 &&
 	    dll_change == DLL_CHANGE_ON) {

-- 
2.56.0


