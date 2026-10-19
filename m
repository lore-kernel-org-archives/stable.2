Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8CC5A6809;
	Mon, 19 Oct 2026 14:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421113; cv=none; b=oi4sSWC5e4UFbqPTLw0lvyt3CMxvnGl7xlQrVkM5aOdLnkF17tixbP66CBKnmb36EkVm3ID/BwlJ6cnj+L/HHDlng2cDCyvGAt7lVmt6NXduChKi30gdZi5ENSdKAbmmu9xND1Em+36hPtY1v6fDlodAhZUphn8Gr6vGhkMIz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421113; c=relaxed/simple;
	bh=6JCEUBSzGCcRAZhZlnyXh6v4VUYm/aqRadJgI0lFBiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R/jpNPU3OGBHl9W2aXezoAHxVTie1XURxbRXEb0emT4KSg/MAUwR0pEgioNJtJQcrtBKaGM8fHXlZ9X5XLOEnCCOfJZyeKjajDytZcT5zENsyKBy2sZY7tYSl/w7fEK7YllZq3QjJvRM/BIt2M/HdHaFBmhYI+qhOTn+YGJGABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dC9TjhDx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dC9TjhDx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792421112; x=1823957112;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6JCEUBSzGCcRAZhZlnyXh6v4VUYm/aqRadJgI0lFBiQ=;
  b=dC9TjhDxtSwmGwsZwGwM1MkfQdjgItNawybJ3DOZz2Rb7GPRVmm0zes7
   rMJalhTP+hh58aj+TFAbrFUggvynivVk5fzRVfG8HkpyvVHQbcoSwnTeK
   9s1VSfucJ7YTLqSF5Tp2M+3VZicHg6+YEfaTXzsjiIwTIi8NneJI3VyQb
   D4WOqqH1cL9h+rI4FPybcn53g74K5tvoAUpIsKjWgnht/QTQQOpxHrV3U
   6r3u9Egb5NszFxJyivSuwWj0l03ZeUevUzCUIzmpCcVA7CMMlkPKBSgnD
   +9RG8thVxqt42i2tVilXYfYZALZ7gPlPIsCfMf3cG2tMcM4y1275q09/g
   A==;
X-CSE-ConnectionGUID: SlwWnXbgT/6fIePBWGQe/g==
X-CSE-MsgGUID: 627hyBsYT/G5KlIqZHkNUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1123049"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1123049"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:11 -0700
X-CSE-ConnectionGUID: B+t/KJBXRqKyUjVVPAfMLA==
X-CSE-MsgGUID: GbSP7zLgQjWAvUNAyKfExQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="3025065"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:10 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] ALSA: compress: add missing OPEN-state gate to SET_METADATA
Date: Mon, 19 Oct 2026 17:45:32 +0300
Message-ID: <20261019144533.30665-4-peter.ujfalusi@linux.intel.com>
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

snd_compr_set_metadata() calls stream->ops->set_metadata() straight
after copy_from_user(), without ever checking runtime->state, even
though the function's own comment says a parameter change should only
be allowed once the stream has left the OPEN state. Every other
metadata/param entry point in this file (SET_PARAMS, WRITE, ...)
enforces that gate.

A codec driver's set_metadata callback can assume SET_PARAMS has
already run and initialised its private state; calling it while the
stream is still OPEN can operate on that uninitialised state.

Add the OPEN-state check the existing comment already documents.

Fixes: 9727b490e543 ("ALSA: compress: add support for gapless playback")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 sound/core/compress_offload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index d6863336f21c..a250c6b53996 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -789,6 +789,9 @@ snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
 	* we should allow parameter change only when stream has been
 	* opened not in other cases
 	*/
+	if (stream->runtime->state == SNDRV_PCM_STATE_OPEN)
+		return -EBADFD;
+
 	if (copy_from_user(&metadata, (void __user *)arg, sizeof(metadata)))
 		return -EFAULT;
 
-- 
2.56.0

