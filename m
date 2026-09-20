Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7653C175A9C;
	Sun, 20 Sep 2026 02:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789872169; cv=none; b=E411hgibFM09eV4Z77Z0GH0IlHI8XomPd9nnELxFVG9QoJ9KHMI4z9E6YVpgWZS+TV9t4byqHgJ5gvC1B5k0wjQY3SglYQN/apGbB5ND2U8NPArF/BEFofyGv0nESWNBTbzdUFlwXtt21rYDys0XbKJrmj897he0Mx4qV2IsD1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789872169; c=relaxed/simple;
	bh=odp0zXhuJ25xtcNo60On5RQmjhndEnyqpfoyX1JO9rs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FxyawdluRsznWsZlTGFt37aZQsnEsSMdrKGlCZzWZeRbLCRDcX2kug9nmVJ6hz7ZSOhzpzVSPllgQsnvBdqeLz8E3ULqCUkiFKYfOxtQ+cu4HIquV+4Fo3t+l/CkDR65f4dApKMoB8dswRCwR9Z2dJgnZ8dWle4Xa+C7vuOzICs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vbk3QDwF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vbk3QDwF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789872167; x=1821408167;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=odp0zXhuJ25xtcNo60On5RQmjhndEnyqpfoyX1JO9rs=;
  b=Vbk3QDwFstRWANnbabw55hH/mAuzGLVsdW/BGCZTU99rMofUgpSK1z9A
   YSOT+KUB2PJIOqLOuPmQpjjaRdi/0APc1uNTZxTiZ2H5BCKJJLndOxKQk
   rh0wh07Aj34KJgLvXacTroMqu0n1t/jmY9eJvg1Je2h9ysWqPoGtxMF2x
   k+7fD1DFJtI7pfVbP+2LjvGgqEnhJsE2FJEHiOX2kNG7nOgyQsneHsYwl
   Sct/RijW+GD08MWiD4/DDdRpPEljVX/gnqY/opv0i+n/DaKTt9Rvvg2Wn
   Q6+E9hqx4Y+lmKnSfwAnVIUVf57S8YwRLlAXoleFfrqY2IIKmNFi6SDH3
   Q==;
X-CSE-ConnectionGUID: YT9bdpMTT0K3/j7H2OMJuQ==
X-CSE-MsgGUID: IjIKXbd3RF2byuebOVfHfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="77949180"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="77949180"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 19:42:45 -0700
X-CSE-ConnectionGUID: n2KMD/YsRhe1p1QNkYIEdg==
X-CSE-MsgGUID: X2t4uyOtR3qnkvOmM9ZWNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="280184439"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 19:42:43 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Oder Chiou <oder_chiou@realtek.com>
Cc: Shuming Fan <shumingf@realtek.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: rt712-sdca-dmic: fix drvdata type in the gain controls
Date: Sun, 20 Sep 2026 10:42:32 +0800
Message-ID: <20260920024232.710189-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rt712_sdca_dmic_set_gain_get() and rt712_sdca_dmic_set_gain_put() take
the component drvdata as struct rt712_sdca_priv, but this driver stores
a struct rt712_sdca_dmic_priv.

regmap and mbq_regmap are at the same offsets in both structs, so the
register accesses work. slave is not: rt712_sdca_priv has dmic_component
in front of it, so its slave overlays rt712_sdca_dmic_priv's params,
which this driver never writes. When regmap_write() fails in the put
handler, dev_err() is called with &NULL->dev (RSI below):

  rt712-sdca-dmic sdw:0:3:025d:1713:01: Defer on undeferrable control: 40800f13
  BUG: kernel NULL pointer dereference, address: 0000000000000058
  RIP: 0010:__dev_printk+0x10/0x70
  RDX: ffffcdac45f83cd0 RSI: 0000000000000008 RDI: ffffffffa09cb5cb
  Call Trace:
   _dev_err+0x7f/0x99
   rt712_sdca_dmic_set_gain_put.cold+0x20/0x25 [snd_soc_rt712_sdca_dmic]
   snd_ctl_elem_write+0x19a/0x1f0 [snd]
   snd_ctl_ioctl+0x658/0x8a0 [snd]

Seen on a Dell Precision 5690 running 7.2.5-200.fc44, with alsactl
writing the control during boot. Compile-tested only.

Fixes: 63a511284c9e ("ASoC: rt712-sdca: Add RT712 SDCA driver for Mic topology")
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2532834
Cc: stable@vger.kernel.org
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 sound/soc/codecs/rt712-sdca-dmic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt712-sdca-dmic.c b/sound/soc/codecs/rt712-sdca-dmic.c
index a9f3aa4e143ae..882390890738e 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.c
+++ b/sound/soc/codecs/rt712-sdca-dmic.c
@@ -246,7 +246,7 @@ static int rt712_sdca_dmic_set_gain_get(struct snd_kcontrol *kcontrol,
 		struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
-	struct rt712_sdca_priv *rt712 = snd_soc_component_get_drvdata(component);
+	struct rt712_sdca_dmic_priv *rt712 = snd_soc_component_get_drvdata(component);
 	struct rt712_sdca_dmic_kctrl_priv *p =
 		(struct rt712_sdca_dmic_kctrl_priv *)kcontrol->private_value;
 	unsigned int regvalue, ctl, i;
@@ -277,7 +277,7 @@ static int rt712_sdca_dmic_set_gain_put(struct snd_kcontrol *kcontrol,
 	struct snd_soc_component *component = snd_kcontrol_chip(kcontrol);
 	struct rt712_sdca_dmic_kctrl_priv *p =
 		(struct rt712_sdca_dmic_kctrl_priv *)kcontrol->private_value;
-	struct rt712_sdca_priv *rt712 = snd_soc_component_get_drvdata(component);
+	struct rt712_sdca_dmic_priv *rt712 = snd_soc_component_get_drvdata(component);
 	unsigned int gain_val[4];
 	unsigned int i, adc_vol_flag = 0, changed = 0;
 	unsigned int regvalue[4];

base-commit: 174d160884199cad97413f33fe1b56027dc0d3e1
-- 
2.43.0

