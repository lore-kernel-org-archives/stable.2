Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1112447CA84;
	Thu,  8 Oct 2026 08:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791449633; cv=none; b=q47OBBaf660xtpaNQKFzH/7/M3U8m3wsVeIYGLM1d9dgqcdykvcyPSVTbaet/XE5mI0ZUTtYxjVCYzA7+MouB3c/73i9L6BneDcGfoxGYAmoHHiWyifxH7Ua6w2I6xEvY+tehXuPa785nhToUnTHLPiB9Y0HNmMAVd/4P7FdcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791449633; c=relaxed/simple;
	bh=5v92Q4fjl9gWWkBp5CDXzJLLgH7DAwCkYuU0DPOQmdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e1EPeX7VPqSVwSOWax+Lu+k7w7lPkRe+JUy2C1ZQJ0d28mL6j2aOwdNhpiQ+gLILQiOLx87acXg8FHTiP3hNxgiYNo6d3I9yZsrpHfQk/k5QA/eOfxZis0q8YbNDOlYLrBhUIAMZRNlmQh4rh4tQUjQlpf0EZq9u3BMspXehMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcGKTAgi; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcGKTAgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791449631; x=1822985631;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5v92Q4fjl9gWWkBp5CDXzJLLgH7DAwCkYuU0DPOQmdw=;
  b=LcGKTAgizCfmRJGLQ2QxBFeySX9FSMxlAoBnk6qlhnRiKxe3HqCXO2Bg
   E708dK7iUcHyvTLr7WBA+9y02z5V4oMmgIkVsBhTJOEo24LZEgfLlmy0J
   IbM2w4s5KLu+FLzVo5hWVAhtQuCccjjOzDyJMLr8xZ08y0uHkbEK30Yde
   K/YJKyuVoPUCNwTuL/MhD3btzLCMEJRYJn9+2c0duyfeumZQGfU7GATvU
   nWcizI2AQh7bjYJzCK6cC9RjZ7VvwJXrnyrvbKjN6GXuZ3ltiX3PpY0pc
   8JssafKUvKmYPXMJKBaPXj/tNqDwF+s8GHbQCJuQKUF5nmm5Eyxvk/KI/
   w==;
X-CSE-ConnectionGUID: yIlnMU4QSmqoEloP2Ii3Iw==
X-CSE-MsgGUID: T6QrMhiuTam3alulht147w==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="122785"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="122785"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:53:51 -0700
X-CSE-ConnectionGUID: E+2esff7SROTlWnBBWhHVA==
X-CSE-MsgGUID: aKe0uzOcQ4+N2RGf+57+7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="91428"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 01:53:49 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] ALSA: x86: hdmi: fix chmap array missing terminator entry
Date: Thu,  8 Oct 2026 11:54:11 +0300
Message-ID: <20261008085411.13742-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

had_build_channel_allocation_map() allocates a single struct
snd_pcm_chmap_elem via kzalloc() and stores it as
intelhaddata->chmap->chmap. struct snd_pcm_chmap.chmap is expected to
be a zero-terminated array (see snd_pcm_std_chmaps[]), but
had_register_chmap_ctls() never overrides the TLV callback installed
by snd_pcm_add_chmap_ctls(), so the generic pcm_chmap_ctl_tlv() from
ALSA core is left in place.

pcm_chmap_ctl_tlv() is reachable by any local user via
SNDRV_CTL_IOCTL_TLV_READ on the "Playback Channel Map" control and
walks the array with "for (map = info->chmap; map->channels; map++)".
Since the driver's single element is never terminated, this walks
past the allocation. The same pointer is also freed on hot-unplug and
rebuilt on hot-plug under intelhaddata->mutex, while the TLV callback
runs under card->controls_rwsem without that mutex, so the walk can
also race a concurrent free of the array.

Fix this by allocating a second, zeroed element so the array is
properly terminated, and by dropping the inherited TLV callback
entirely at registration time, since the driver never implements one
of its own.

Fixes: 5dab11d89777 ("ALSA: x86: hdmi: Add audio support for BYT and CHT")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/x86/intel_hdmi_audio.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/x86/intel_hdmi_audio.c b/sound/x86/intel_hdmi_audio.c
index 9f67244d4946..542fc35ec9b7 100644
--- a/sound/x86/intel_hdmi_audio.c
+++ b/sound/x86/intel_hdmi_audio.c
@@ -475,7 +475,8 @@ static void had_build_channel_allocation_map(struct snd_intelhad *intelhaddata)
 	kfree(intelhaddata->chmap->chmap);
 	intelhaddata->chmap->chmap = NULL;
 
-	chmap = kzalloc_obj(*chmap);
+	/* info->chmap must be zero-terminated; allocate a spare terminator entry */
+	chmap = kzalloc_objs(*chmap, 2);
 	if (!chmap)
 		return;
 
@@ -575,6 +576,12 @@ static int had_register_chmap_ctls(struct snd_intelhad *intelhaddata,
 	intelhaddata->chmap->kctl->info = had_chmap_ctl_info;
 	intelhaddata->chmap->kctl->get = had_chmap_ctl_get;
 	intelhaddata->chmap->chmap = NULL;
+
+	/* drop the inherited TLV read: it walks chmap without our mutex */
+	intelhaddata->chmap->kctl->tlv.c = NULL;
+	intelhaddata->chmap->kctl->vd[0].access &=
+		~(SNDRV_CTL_ELEM_ACCESS_TLV_READ | SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK);
+
 	return 0;
 }
 
-- 
2.56.0

