Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672865;
	b=lniYRzdxhrk01uKG7YJHwnYL+GAMR+XHTC+65GAnYdmCzNWj/KzZBg8s4UdQ+ppslRVo
	 P+H6UI8VqdqvyKk+vD1k5FJmUPjsHEpMtIeYoCQblRdRUcJ2r5+nRU/RRkC9W7JWOstgi
	 4+QNKEE6nnINR6wz1AJuQ6sesuqiGIWvvsHmkLOK3PRC0hwj+KeZFp64oXzymlJ1YSsfW
	 oeod8CH7+kViZkq/cMGsj3nImtW1y9Um1O5k3kve6ujr9ODFMtXje/Db9cmh8Dp08fnXK
	 d1YRWIg2B4IZNJgo/kLC7v8MGVa2c4mr6WkaS9D9JovQZ8wmczQCGvCN9B2NLe8psiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672865;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=p8Gfu7m3jVEYukKEc7L9eAr2IwmBTUG/Vj2feSFNAgQ=;
	b=kQag7B4jucYOzvWnf7NhgaQUj2v4b/NljQaDVPU4YfjDGWGsfelPuCnxdB9fprbbud2n
	 p2GdbaHWY9LparFhrPxitnw03e1qZz3x2bdz3KG2xvglLAK6mctiW2lzGEhmMPPtzcI2X
	 EbmUhtzg3j0ElN66I8bsLSGgAfnLUx6wg+1/UZSfGD9trN+9OTbU5AOA/1vpZ/NmMqaKE
	 hF2dtSmmA6X+9viXnjQDV/eFSydmEBH7MYL/CNMQeE19lC0fMKSecksT9LHV9+h15W7Zh
	 xHD7m2S8Q1aEKKTQdppZH6xFHaxDU0c4KVSNzipGuSAkRAz/4krDZDyrc/OeE/PZQsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mYM5HwkO;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89936606A326;
	Tue,  3 Nov 2026 02:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 89936606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mYM5HwkO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793672865; x=1825208865;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SQ13tx7di0W4Idm6/YUJIKkQi+15W7dpYhnzBWHKOWI=;
  b=mYM5HwkOc7RHzxxnLFvHQhF+C9ElHspd0118ZK1wVzEQ57tlymTWEHQg
   rht3+j4AEgsk76zaVfxZa6yF70IzOtScZvJ9XjlXOmN+Eh2qed/d9gvY2
   UUHmGlxpQUpGpEWwTbj5BJf2gOrojcW0JNfmfnQfLk8PvnWbrhRH88y1G
   8SPLCL2tifLsYvQtzzz0JPWjo5DXmU5+ZVA/3CBsp/l4uZwsmdlHHSSmm
   neNvnzMUD7wCVD5lgXte+17I+XprzXJiqEPMhgt3/JS2FYc5E1mZ0dyvj
   9jvogl3xKU7QY+0S8g1qlta+2SjA/rUFWoVV3WfAqC7G5YATgtw3F3Xof
   w==;
X-CSE-ConnectionGUID: xNn0LjLARQWqyf+WBuj8nw==
X-CSE-MsgGUID: dnlMqDAGRWGRCIgDz44CLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2263874"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2263874"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:27:44 -0800
X-CSE-ConnectionGUID: GsbJAB9mQJKdODKnrSQSEQ==
X-CSE-MsgGUID: 0UF13+5WQHGVAcq4ug7Gcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6380580"
Received: from emr-371.sh.intel.com ([10.112.106.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 18:27:39 -0800
From: Baoli Zhang <baoli.zhang@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Baoli Zhang <baoli.zhang@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: Fix pin format leak in process widget setup
Date: Tue,  3 Nov 2026 10:17:10 +0800
Message-ID: <20261103021710.3647599-1-baoli.zhang@linux.intel.com>
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
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Baoli Zhang <baoli.zhang@linux.intel.com>
---
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
-- 
2.43.0

