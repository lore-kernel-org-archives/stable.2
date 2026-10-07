Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D64AD7D7;
	Wed,  7 Oct 2026 13:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379528; cv=none; b=nbOKUXkMwvoubsj0epcyFBhFcBXOf32/V+XSq5BBACwxSCqhSp/ayyDxOd21XvyiavUhDDL7DUx9ffnR/sjlEOFdk0eyp2DnqSEZUlQOMHO9TY3O3GTPqv40hiPl5awlqDWiuwmaot8It6YEi120WLJNtiuWwe/8pEZJP0vBLYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379528; c=relaxed/simple;
	bh=xWcdt8diMLLFQASgGdaQaBl1Mi+wRxG1/Wqa8R7gD8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/xcENIMPPI5Es0iz+lKLgV0qo5ER6zxLRoKYVtsUqmRHLdmo2bJOkX3G9Z/ySPwtIUdKOIw2im8xk4m9D6/4zQIyBsKu8Z6XfdOhkvxEJOZ3g2Ldx9MSuX/18JtDADYcI2Z1fYBRzv5NDp2VYfRCcSXBj7Sh3cK5ZQSxCTmNUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=It+J+9kH; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="It+J+9kH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791379512; x=1822915512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xWcdt8diMLLFQASgGdaQaBl1Mi+wRxG1/Wqa8R7gD8E=;
  b=It+J+9kHueGhJVKmbhVCvjMfsUsU/rfCHg1LSPsn2nOh6MMvZpGln3HC
   vazXmHucMNNwLwYANbU4y8vyTFlJBAOv2oXV3MQGh+BpnQxcG+kG2GPWT
   yHUH4ajxG9wzsR2any9Vwr9rN6ulZ8D3eLVJvt8aNbZ27TOXgJxf994Oe
   KWFnCOa/AaSAHyNVte2XWHVOxkwyIR3FVTHdNOjlOlTCMvSG/rhgXrV3x
   O9ITXjN8Kv5YF6V9QQrrh/Qzhh6MIIuj6tLwBiAv+TJCIgkctY85+zk20
   rof+hvOPMOomg1K2ctXjymjtkDFyP9b3eCw0TnbKX74fVAAb9mXxTEetx
   Q==;
X-CSE-ConnectionGUID: NBdjce+sSy269vrp0jM9kA==
X-CSE-MsgGUID: t0KCEJrxSMCcE2PwABOWLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="39780"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="39780"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:56 -0700
X-CSE-ConnectionGUID: uMCjlJdQTd+c0be5Qd5YSQ==
X-CSE-MsgGUID: JRD8W3pfSxydvt6VlNol+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="305434451"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:54 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 3/4] ALSA: compress: add missing OPEN-state gate to SET_METADATA
Date: Wed,  7 Oct 2026 16:25:08 +0300
Message-ID: <20261007132509.18237-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
References: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
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
---
 sound/core/compress_offload.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index e1cc34ba2c2c..bf13fa0877dd 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -759,6 +759,9 @@ snd_compr_set_metadata(struct snd_compr_stream *stream, unsigned long arg)
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

