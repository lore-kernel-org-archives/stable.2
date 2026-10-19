Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85B85A0AC2;
	Mon, 19 Oct 2026 14:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421112; cv=none; b=JI2/GoBbVG3YIwH11RoMw2djR9dC46+yW5eThJEyEg4LO8WQLtcu6l1daepZAv1dn5yTblm7EBvSvcOncN/E8yLAasNuoD7qXu9unlXCcG1O10gJ2eo+7fG1No8eNfHGlGHfxAc7YUHtKRJYhM66leBKqU8ZPwGOSlUMDRYOJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421112; c=relaxed/simple;
	bh=06hRCLIDVOJIYswwkKQ0o8ey3nms0c/AfKp+VGvAKro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tNVnz7dLkf9n1zVsT3i/p8urBdB7MPjZ/Zdk/O4a4h09H8BZG5JDnFSXZaZ2K/0YgFMVWETU+4y+NFL9fFgdFlL9ZcKYAah/7pPfepeghzAV01stpAaLUMS5dyM60gkzqLHl4kqF7p9Xz6+TcClPP32uvNrKlCMRQactv5/kMQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GIhx6iOW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GIhx6iOW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792421110; x=1823957110;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=06hRCLIDVOJIYswwkKQ0o8ey3nms0c/AfKp+VGvAKro=;
  b=GIhx6iOWVyDJgBMNqdM/p4mPZahvAzMendgqtZ8o9I5URRp21z0Ld0Y+
   Fn+pSVhg0qb2PNjWG89xiR4scIY+k3mJ+2LjhH+Av8A3+mKmEkPVd5AKL
   kupEhLgVQlnB5o0gJysJMP+3kkBaAXk/ewTP3/LEo9Uo3HG3gzFE6OjIm
   h6eqpWS1Ttxw6ZeZIft/VnUMp/mOFccdiqlAM2DIhtzr33P0ZGEEyiKz8
   H6JQojn/DEHssROaZHgcaHCRPfQqNvKv/HTrA7xyfWWMRuE9XY/cafPr5
   8fYrq3hYFefXCS50loCi4IDQ/PiBlomDAphS/zTzB8V4gLB3bEiz3Ov1F
   w==;
X-CSE-ConnectionGUID: ZD5+aGKGRyeovyI1OG99fg==
X-CSE-MsgGUID: pKuWxzX0Q8u9SEji8tqMTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1123042"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1123042"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:10 -0700
X-CSE-ConnectionGUID: z01/uq3lTgCVeH5eFflsng==
X-CSE-MsgGUID: 9txREH7ySOu7ISgAWfFedg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="3025031"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:08 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] ALSA: compress: reject buffer geometry change on gapless next_track
Date: Mon, 19 Oct 2026 17:45:31 +0300
Message-ID: <20261019144533.30665-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019144533.30665-1-peter.ujfalusi@linux.intel.com>
References: <20261019144533.30665-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

snd_compr_set_params() is invoked from the gapless next_track
re-entry path, which calls snd_compr_allocate_buffer() again and lets
buffer_size change while total_bytes_available and
total_bytes_transferred still hold values computed for the previous
buffer. snd_compr_calc_avail() then derives an avail/count value from
those stale counters against the new buffer_size, and
snd_compr_write_data() copy_from_user()s that many bytes into the
new, potentially smaller buffer, overflowing it with user-controlled
length and content.

The buffer is set up once, with the initial SET_PARAMS, and neither the
core nor the DSP expects it to change for a gapless track transition.
Do not call snd_compr_allocate_buffer() on the next_track path and
reject a request that changes the buffer geometry, so that the codec
parameters that the driver receives match the buffer in use.

Fixes: 9727b490e543 ("ALSA: compress: add support for gapless playback")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/core/compress_offload.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 50301f72579e..d6863336f21c 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -697,9 +697,19 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 		if (retval)
 			return retval;
 
-		retval = snd_compr_allocate_buffer(stream, params);
-		if (retval)
-			return -ENOMEM;
+		if (stream->next_track) {
+			/*
+			 * total_bytes_available/transferred still refer to the
+			 * current buffer; its geometry must not change.
+			 */
+			if (params->buffer.fragment_size != stream->runtime->fragment_size ||
+			    params->buffer.fragments != stream->runtime->fragments)
+				return -EINVAL;
+		} else {
+			retval = snd_compr_allocate_buffer(stream, params);
+			if (retval)
+				return retval;
+		}
 
 		retval = stream->ops->set_params(stream, params);
 		if (retval) {
-- 
2.56.0

