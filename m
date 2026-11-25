Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795621836;
	b=UTKEjM7+KU69th4X6dEqTfnJx3M5TP4yYwAyTkFRDoWgvyviNOZ4vVqXGz2bk8Jp1coc
	 GgdD9ANzi6Y3yl46X2TcZfXAikixzragC0e8PwJ0zzEtliXfDAmq+eoiKT4XGy/2PWX0y
	 tI8vLeTPSp+5vVE8WadmaPNc5Z/GWmdIg02YokVj1CNRljq/88iuRNA+tjkg/NRAmLqh+
	 KTwJPRIJWJrJYDDfvl0lwX9rWpQnM6VDMNZNvKOQXO8F1mgu84yIJr/zt3/zMBVdhNiex
	 c7gw4VSTalTz4azydXUCNCS6oPjndeLLJ0Fq2XYMnfREJRU8bQ2vPOSajItUCxfA8Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795621836;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=XLwCuf7M2Ga/clCF7XSJZKgDh7EqOrTLwYVq4lWZ5K4=;
	b=yiGa2jBP8rTqZi6bXz+29j5rA0dx6uoOV9NwPXxcadTEtfowvr0gP5g4G4xQks0KaHiV
	 /H/rBcHcmtPD0uYOgN6C1rk5fxLn0otNWUCo1ngCOJYC8lkhiAio3guxDgv98HjeFOysw
	 gQiEDTOCWu6czDquVuUBjNZQb8Gf9ixnr4ufl+2CgtE8ojAguMVpQGoRQziFGIGBMJVI3
	 CJgp11Re0BdaatNMSSGvtLgJhAx0ysHen1/kThrNFKs0GUYUpEbbjaalSJHPGav/egl2c
	 itBMba1Dk34nzuWGyo0yvngfksoRVUxWOAnyRVjgehXoEu1nvukoMZJ5glRDLCZiQ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fd9tvuie;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E59B606A330;
	Wed, 25 Nov 2026 15:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E59B606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fd9tvuie
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795621836; x=1827157836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sHPGjlZBOvzDEu84WUTKFdQM2Q6afKWCCaXdHKe2KLA=;
  b=fd9tvuies1xic8b1kWwGvmqOO6Zbk98Q5umwWakA5j5k5yTn5xYedmco
   wlidoxtDJaMmLsBMfUAo/3cXlBs34FZhxhsuYzxi2y+qAbG5lGVPG+pH4
   VqgQabtcR4aVhE3O+T6b5jhTHP8T5D2iuMTt0PKi+eBdLa/m7KGXUYvlJ
   5fWl54M3jmotEPsoE8qkHCCCDRHLhPG6rTKUAdkBaORcQ+e9NovMNdMBI
   Dc4Mc8DvKmKdQBLwVlzn/KukiydO+yPv+dXGjkK+N4vSUcXd7Z1y6TLel
   x2J5epWlATvU6tcKrR97EEHZHeDbhPFbA7AVgiFtJIVhmTgvtPNa0dpqM
   g==;
X-CSE-ConnectionGUID: s80Nd/azRuCjcwi80i8Dfw==
X-CSE-MsgGUID: SiO4flDOQzWVueZ4xkQd1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4561658"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4561658"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 07:28:46 -0800
X-CSE-ConnectionGUID: 6vQBSlZgTmK3wDns/adbww==
X-CSE-MsgGUID: 8ulM3UDES1SpBzypkbNKpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="11779883"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 07:25:44 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org
Subject: [PATCH stable 6.12.y backport] ASoC: SOF: Intel: lnl: Enable offload for UAOL link
Date: Wed, 25 Nov 2026 17:26:23 +0200
Message-ID: <20261125152623.22645-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.1
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

commit fdfbd9ff86a145f09978ab49305ed7acfad66a1d upstream.

The handling of UAOL (USB Audio Offload Link) is similar to SSP and DMIC,
it is handled by the DSP firmware.
Set the offload enable for it similar to SSP and DMIC.

Cc: <stable@vger.kernel.org> # 6.12.x
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20260520150639.25301-3-peter.ujfalusi@linux.intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
[ Peter: Adjusted to the int returning hdac_bus_eml_enable_offload() as
  commit 978152b2cab5 ("ASoC: SOF: Intel: hda-mlink/lnl: Convert offload
  enable functions to void") is not backported. The helper is renamed from
  hdac_bus_offload_dmic_ssp() to hdac_bus_set_dsp_offload() to match
  upstream, since it now also handles UAOL.
  Firmware built with UAOL support reads the UAOL registers and crashes if
  the host has not granted the DSP access to them. ]
---
 sound/soc/sof/intel/lnl.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
index 3d5a1f8b17e5..48202b4d8069 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -31,8 +31,8 @@ static const struct snd_sof_debugfs_map lnl_dsp_debugfs[] = {
 	{"fw_regs", HDA_DSP_BAR,  MTL_SRAM_WINDOW_OFFSET(0), 0x1000, SOF_DEBUGFS_ACCESS_D0_ONLY},
 };
 
-/* this helps allows the DSP to setup DMIC/SSP */
-static int hdac_bus_offload_dmic_ssp(struct hdac_bus *bus, bool enable)
+/* Configure DSP offload for DMIC/SSP/UAOL */
+static int hdac_bus_set_dsp_offload(struct hdac_bus *bus, bool enable)
 {
 	int ret;
 
@@ -46,7 +46,8 @@ static int hdac_bus_offload_dmic_ssp(struct hdac_bus *bus, bool enable)
 	if (ret < 0)
 		return ret;
 
-	return 0;
+	return hdac_bus_eml_enable_offload(bus, true,
+					   AZX_REG_ML_LEPTR_ID_INTEL_UAOL, enable);
 }
 
 static int lnl_hda_dsp_probe(struct snd_sof_dev *sdev)
@@ -57,17 +58,17 @@ static int lnl_hda_dsp_probe(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	return hdac_bus_offload_dmic_ssp(sof_to_bus(sdev), true);
+	return hdac_bus_set_dsp_offload(sof_to_bus(sdev), true);
 }
 
 static void lnl_hda_dsp_remove(struct snd_sof_dev *sdev)
 {
 	int ret;
 
-	ret = hdac_bus_offload_dmic_ssp(sof_to_bus(sdev), false);
+	ret = hdac_bus_set_dsp_offload(sof_to_bus(sdev), false);
 	if (ret < 0)
 		dev_warn(sdev->dev,
-			 "Failed to disable offload for DMIC/SSP: %d\n", ret);
+			 "Failed to disable offload for DMIC/SSP/UAOL: %d\n", ret);
 
 	hda_dsp_remove(sdev);
 }
@@ -80,7 +81,7 @@ static int lnl_hda_dsp_resume(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	return hdac_bus_offload_dmic_ssp(sof_to_bus(sdev), true);
+	return hdac_bus_set_dsp_offload(sof_to_bus(sdev), true);
 }
 
 static int lnl_hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
@@ -91,7 +92,7 @@ static int lnl_hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	return hdac_bus_offload_dmic_ssp(sof_to_bus(sdev), true);
+	return hdac_bus_set_dsp_offload(sof_to_bus(sdev), true);
 }
 
 static int lnl_dsp_post_fw_run(struct snd_sof_dev *sdev)
-- 
2.56.1

