Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735D55A464B;
	Mon, 19 Oct 2026 14:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421110; cv=none; b=HPzAuTGwyqt2MzGotCwLnoRXENHRkEAdVi57i/cXwnxtIqcwowTNaauFr2hIiBwRS99Tiy/6e83m2qqgFYLSCs2UoLDS0U7dsM8V1bIJPYn/tk0XlnI3m8It1IeNRhKvKyRVcKv9Bv6dS1FDm/ixVmMv8azoQLAedilvEn0DBwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421110; c=relaxed/simple;
	bh=ovb7U+uq+9QeSwofIj8eRgCEi/0jkp4bvSww3oA8N4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZWJpfwWS0CoY73OV0QUHyJy1ED4q/6Ds8eOCHtIdtSHDA+9epfnaCPLbqH3B074W5OvcbbAeh5fordlTn8uC1Fogz/yHkLJLMngCDLMeN4YBBOAXJLsDMPcM7nEILWDVp+dtBc3/UxnegHeQHbHt+/Chvv5HClinRdsIwfwe9Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Dnbg2257; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Dnbg2257"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792421109; x=1823957109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ovb7U+uq+9QeSwofIj8eRgCEi/0jkp4bvSww3oA8N4c=;
  b=Dnbg225766INxAgF+POI8vjFQebVF8AqsoE9Ok47VMQnMHXgAvnQHUM0
   qbDPU4qOoiYedbooPJ90MdsAAVuCb/l0Dt9D+WST7t7v4W0NN9X4F7G95
   bfbXo3h7Fygpf4sNTl0FbMq9/JBGvHkGKXu12Dqca5LAKXr5T2wHDRliq
   7ac+tZrUMptcnD1k792njaUTT7UTiS06TGepyLyRWVRRRdDj2y7Ip5+zr
   6pu39WQ2qFcjcaACZq/nMsznCaU5+f8ju+v0pLR+I65iVSViVtVx8YxND
   5B+fOYDXRgizDh5Ja7kzzu8IAFyxFMkbtlcOe2JOw8he/VTzV7b6TM+/V
   A==;
X-CSE-ConnectionGUID: aMpjJz7XRBGyZO6hoNx8mg==
X-CSE-MsgGUID: ZjLV3kakRECyuNie82EvWA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1123034"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1123034"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:08 -0700
X-CSE-ConnectionGUID: Kv8vWQR+R/KdxrzvYSjY2Q==
X-CSE-MsgGUID: kGh1Nj+6Saek/YGVizA+pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="3025007"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:06 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] ALSA: compress: fix buffer leak on failed SET_PARAMS
Date: Mon, 19 Oct 2026 17:45:30 +0300
Message-ID: <20261019144533.30665-2-peter.ujfalusi@linux.intel.com>
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

When the driver has neither ops->copy nor a preallocated dma_buffer_p,
snd_compr_allocate_buffer() kmallocs runtime->buffer. If
ops->set_params() then rejects the parameters, SET_PARAMS fails, the
stream stays in the OPEN state and keeps the buffer. The next
SET_PARAMS allocates a new buffer and overwrites the pointer, so
repeated SET_PARAMS calls with parameters that the driver rejects leak
one buffer per call.

Release the framework-owned buffer when ops->set_params() fails on an
OPEN stream, so that a failed SET_PARAMS leaves no buffer behind and
the buffer is allocated only once per successful setup. Use the same
ownership check as snd_compr_free().

Fixes: b21c60a4edd2 ("ALSA: core: add support for compress_offload")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/core/compress_offload.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index 5c0db178d635..50301f72579e 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -702,8 +702,15 @@ snd_compr_set_params(struct snd_compr_stream *stream, unsigned long arg)
 			return -ENOMEM;
 
 		retval = stream->ops->set_params(stream, params);
-		if (retval)
+		if (retval) {
+			/* the stream stays OPEN: drop the buffer of the rejected setup */
+			if (stream->runtime->state == SNDRV_PCM_STATE_OPEN &&
+			    !stream->runtime->dma_buffer_p) {
+				kfree(stream->runtime->buffer);
+				stream->runtime->buffer = NULL;
+			}
 			return retval;
+		}
 
 		if (stream->next_track)
 			return retval;
-- 
2.56.0

