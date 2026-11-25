Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620954;
	b=OdNYcWOTZM+CoqYiaYGu5HfwcSZXjfQJ+YigFw1a1cDIfAbdgIzCiDfJW8yaasZq4f5o
	 dHqO6jAnbWiBuFg8yUO3lYVbHl6KdIRVFR+SVfkOzGazR34vGvh6cY34CSHCjfGL61DiB
	 NxvaZ/AkFjBZwuXFaT2K/iEBofo+3Nm2atxJYxIKTbryy4NzNFYTG65LXOjHA2chqdOTG
	 rj/QOGmjMWUBeT2Zx/paAZYjrvPYrB7GP1TRlL/wqnpezZErqxJefJ8RqBqjpDGU/WQ6v
	 DYky1/j+hDLXKEBtY2IGv0/0+mXB6hYdKRpkUFXaZHi8XE85DCe+9ALFA6kfpJsVq3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620954;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VuxqO60SfIBEuqsK6n4/P79x+kzhDZYWP7FbuCsCQ34=;
	b=edb++NxDS/sXTcLb265I46Q0Xvo3h4FWQC4nkFgmaA1eL8oAcf1e0V4H0TjClo2FgK9J
	 uEGDLXIJk2JkYu7cTbrSfB4Yu9XwHqWxmTRlNwPUXcBXhzgyEoUtUTW+XvXgF4cpHsJYb
	 39VMPm9hMJ2UgcJUnPgzEA27mJB7is9or38DREHOCi8VoYF+DIgBP/n/CrvcslzO/nu9j
	 bcD7d5hcbrqrvKi6qj70LcTR7DrhwjmnI3b2rsHtpeNJjatnUElZdNHpbnEgKHH51qtyo
	 MhA30o4Medf/wQhru1DXAi3ZQWAOkfAdmLaxnnCayCy6wDj4PW1fr8ghlXbbUBA1pkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="SVPIy/Ce";
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A2460A383B;
	Wed, 25 Nov 2026 15:35:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65A2460A383B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=SVPIy/Ce
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795620953; x=1827156953;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TpcPUxXUMiuSzfXM00FOshGXSknpfhiuyV6xSE4ppbE=;
  b=SVPIy/CeHobiWaw0Nnkgu1fSr9TGxSU8XaJ0EMXl38VYbA3pYCO9De47
   GFhRQjGwuXp3laHz2OaKCxCfCZ6FWBqMrqFJdUZ2IMk/CKMWbUd1Bho/6
   AHeX+Po5RfEP0dkPlb5nGn1DEGBuU20eVP3ntOVkvl3mLg1n1Dxhp9Eo2
   dn7672awqqwvI3azvgazg6b/ii0ANOXqGF2ircyJqj2OXx8g2kW4sYjFQ
   6Yw0foeaN37IPSqMdXvqcaWVLtiBt7jDUe+x4rqdIDU1gYUVjqgb9iafe
   1Y+4cXD+xkTym2zfamlQfbX+o4/8lmyAeZlaiJHtAJRVqJ56k10F+gT6k
   A==;
X-CSE-ConnectionGUID: x8f1IUaRQhqFJEp2+PY0tw==
X-CSE-MsgGUID: 5cYYTHncS22hJun4Jl05yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4434294"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4434294"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 07:35:52 -0800
X-CSE-ConnectionGUID: DQ2nQHpGR1G6/Pu9chbd5w==
X-CSE-MsgGUID: nY4lbNS/TT29N6hdU37N9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12480861"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.1])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 07:25:22 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org
Subject: [PATCH stable 6.18.y backport] ASoC: SOF: Intel: lnl: Enable offload for UAOL link
Date: Wed, 25 Nov 2026 17:26:02 +0200
Message-ID: <20261125152602.22513-1-peter.ujfalusi@linux.intel.com>
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

Cc: <stable@vger.kernel.org> # 6.18.x
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
index 2f3222040f98..7b859bb9dea4 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -20,8 +20,8 @@
 #include "lnl.h"
 #include <sound/hda-mlink.h>
 
-/* this helps allows the DSP to setup DMIC/SSP */
-static int hdac_bus_offload_dmic_ssp(struct hdac_bus *bus, bool enable)
+/* Configure DSP offload for DMIC/SSP/UAOL */
+static int hdac_bus_set_dsp_offload(struct hdac_bus *bus, bool enable)
 {
 	int ret;
 
@@ -35,7 +35,8 @@ static int hdac_bus_offload_dmic_ssp(struct hdac_bus *bus, bool enable)
 	if (ret < 0)
 		return ret;
 
-	return 0;
+	return hdac_bus_eml_enable_offload(bus, true,
+					   AZX_REG_ML_LEPTR_ID_INTEL_UAOL, enable);
 }
 
 static int lnl_hda_dsp_probe(struct snd_sof_dev *sdev)
@@ -46,17 +47,17 @@ static int lnl_hda_dsp_probe(struct snd_sof_dev *sdev)
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
@@ -69,7 +70,7 @@ static int lnl_hda_dsp_resume(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	return hdac_bus_offload_dmic_ssp(sof_to_bus(sdev), true);
+	return hdac_bus_set_dsp_offload(sof_to_bus(sdev), true);
 }
 
 static int lnl_hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
@@ -80,7 +81,7 @@ static int lnl_hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		return ret;
 
-	return hdac_bus_offload_dmic_ssp(sof_to_bus(sdev), true);
+	return hdac_bus_set_dsp_offload(sof_to_bus(sdev), true);
 }
 
 static int lnl_dsp_post_fw_run(struct snd_sof_dev *sdev)
-- 
2.56.1

