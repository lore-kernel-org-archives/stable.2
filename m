Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186403;
	b=krAxFw7Rra6cNLJVVPMikYnOZHdx38tuzsChDRUfoPwJMuoFcGyN+K0wAke7n5ndlh8z
	 /T9e8FQ2XXJjMwYKjlsKpYFCzjL3AXZwzVGLjbHE4f6MOyYHON0ep+u+7g6IiHiGh3dF9
	 g9SyC44m6LmVrh1ZLkdYFoDVg+vNm+xv5808LQEjaLfIubIyequhWbNM8Sdonbv1t1rIX
	 5EnIZrf18Mv8by3vKJ2eXC9Z1Gb9CzYWY9Wl8aZ4ODCpZoZOoBVV0+noG0pZdJ1wGUWj6
	 XdqNKkBRCp2qNnPqt2nk7o/veNQi6JlbWXFzjwwIMvY9vtazwPN6wBvPqoHlL17TrxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186403;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=I9FjbHD8i24UYJcaFeqQZjgk6FjjYVzkRcFhxcColNY=;
	b=Si5MrMLerFkCfS2MBqm+0FtuLfH8JNRBzclaQISyh45nogUkunwWX3roSEPeEckrrtgL
	 1P0QmADMAz0jtSxiw3o3lqix2Q42cOUBPi9XfIRidEwLRIxOZsVYa+3dx4DMjF4CARleI
	 H7nFMZwMU4xtWOrH5e+LpcV5G3BiWyCN92h27RIlvgJNTbxlybeX9Iy0xdraPMnUe2v4S
	 Yg7PVfAjeVuOzY0UrAVkrm1b6AP1xsQNgRia9moBOEPYgmHBNU6PLWdfEFCC2d4C4bcze
	 6DaHLEA+5dPurwJE2Az4+LKbHpim4qREe5LEwY2twbEBudgOVxJ6N319TC9IZNW1bYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oz6tZBPL;
	arc=none smtp.remote-ip=198.175.65.21
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0938606A31C;
	Mon,  9 Nov 2026 01:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0938606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Oz6tZBPL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794186402; x=1825722402;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OMzHEikxefzj16Pg9Hb4h3ySqWSCQ1IGc5pHzshqrjE=;
  b=Oz6tZBPLmFmZR1n+mXkcfbKnHt8tD9PYFKV5r8a5yQ444AS7KO9QZtvK
   7aes78hCX50wkDRN4ks8gB8x/4j9qabSILDdyNzSuHgcIIEgPKN7G/ZWW
   ORi30F/8F4oJdv+8SAuzes9nHKuVPRA+QI7tSD0EWth44v3mvtsH1ir5C
   igHwgSVUP5yIfyrV6Atb3Gv0IgnP1R1JfrwotBU75FwYIDxdHmYqgbIsu
   +mE9bEVKRxFP/l7g5ABXqBmdddb+EYjtniVWMRWNeusUa/tiAH3RMXLQn
   /3Evi4f6nXFlPEz/PyZVYHAA43lzShIL5HxJ8xMvmat+nPvFsAotqPQgJ
   A==;
X-CSE-ConnectionGUID: Ub5qDLePS7S96+SUhCPcQQ==
X-CSE-MsgGUID: V4LXYgoZRRqi4/pPohFDzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="3001312"
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="3001312"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 17:06:41 -0800
X-CSE-ConnectionGUID: Bh2Rx/AvSqqRfTLWLQ59xw==
X-CSE-MsgGUID: +lJ+YQlcSCSrXGBZW1QW9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,202,1787036400"; 
   d="scan'208";a="7904100"
Received: from emr-371.sh.intel.com ([10.112.106.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2026 17:06:38 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: andriy.shevchenko@linux.intel.com,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS),
	linux-sound@vger.kernel.org (open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM...),
	linux-kernel@vger.kernel.org (open list)
Cc: Baoli Zhang <baoli.zhang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] ASoC: SOF: ipc4-topology: Fix pin format leak in process widget setup
Date: Mon,  9 Nov 2026 08:56:04 +0800
Message-ID: <20261109005604.1004362-1-baoli.zhang@linux.intel.com>
X-Mailer: git-send-email 2.43.0
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

sof_ipc4_widget_setup_comp_process() allocates the input and output pin
format arrays via sof_ipc4_get_audio_fmt(). When the following
sof_ipc4_widget_setup_msg() fails, e.g. because the firmware does not
provide a module matching the widget UUID, the error path jumps to the
'err' label, which frees the process struct and clears swidget->private
but skips sof_ipc4_free_audio_fmt(). The arrays are then unreachable and
are reported by kmemleak:

    sof_ipc4_get_audio_fmt+0xc9/0x420 [snd_sof]
    sof_ipc4_widget_setup_comp_process+0x8e/0x200 [snd_sof]
    snd_sof_load_topology+0x71a/0x840 [snd_sof]
    sof_pcm_probe+0x77/0x120 [snd_sof]
    snd_soc_component_probe+0x21/0x60 [snd_soc_core]
    ...

Jump to 'free_available_fmt' instead, as the other process widget error
paths after sof_ipc4_get_audio_fmt() already do.

The other IPC4 widget setup functions (pga, mixer, src, asrc) free the
audio formats in their common error label and are not affected.

Fixes: f9efae954905 ("ASoC: SOF: ipc4-topology: Add support for base config extension")
Cc: stable@vger.kernel.org
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
Changes in v2:
- Drop the Assisted-by tag.
- v1: https://lore.kernel.org/linux-sound/20261103021710.3647599-1-baoli.zhang@linux.intel.com/

 sound/soc/sof/ipc4-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 8b13c97b34804..de03dc58021a1 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1313,7 +1313,7 @@ static int sof_ipc4_widget_setup_comp_process(struct snd_sof_widget *swidget)
 
 	ret = sof_ipc4_widget_setup_msg(swidget, &process->msg);
 	if (ret)
-		goto err;
+		goto free_available_fmt;
 
 	/* parse process init module payload config type from module info */
 	fw_module = swidget->module_info;

base-commit: 3ecd14f81434da3b5ff5c44d243715f96d52303d
-- 
2.43.0

