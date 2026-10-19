Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886954FDA78;
	Mon, 19 Oct 2026 14:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421108; cv=none; b=C/Dmgi/rsRRrWYR4NuVLLrtwLQMljxaUUdEOHAH5+xdXl1eGSPPELXG8189lBs5/JjZqF2yuefiP1ne+Yutmw1RiVRrMcWNyXsIM/T9eYjQG4voJdHjwkawWUPwR5mLekOto91J2AjRTfq7iu0Lrp0dNtZqTfbfHMMKSRLQpOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421108; c=relaxed/simple;
	bh=o1I2P4LLKUAXyDLkgW9owSBphOOuwcmp6Esm1bXBFEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LTG+q+0lZicphzbCghhBg7hGuPNg0t7+QMCViu4uiVmJN8/qX7Uqz/aP5TZnUgH74Etx5yyXcJQnFcs0fkUKHtku3wPbyrUJ1bGT7iab1h6aOGnh2pRMfGCJfpsocWI2JjmONRpXwO5hKWfl9IdsJUc0bZUiV7euLUIwa+2HQVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g1+knSNN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g1+knSNN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792421107; x=1823957107;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=o1I2P4LLKUAXyDLkgW9owSBphOOuwcmp6Esm1bXBFEQ=;
  b=g1+knSNNsuOTy9ApMtMJnbjR4H8l6aEAI2VXo0DL9kWyoNpO8CC9DXH8
   /iEkomGR7fgqrxPQlN1QU5gZu8cOKxodiitlpf0O+vRafC9rqSfUUk1Ct
   tw0HuAV6XmW/pX6cwTRdoVu2s6vAjqlHNzm98D6pXgc4BSXQAyHJJSSdV
   4wrovfttSzAA0105LLxfgITYnaccf6uPBufZ3WZt2eBSHUzZB9tRKrO1l
   eBdpAuc8iF/nfwDStzvAqaPrj/BQbOKFPZma27JL/9XTWljfuf2uhwFn9
   wci1WGHWQ0LtMU6sOSWkecqrSk+3gO2wprhXbv9Xo/Uh/UeUwh/t9kmFS
   g==;
X-CSE-ConnectionGUID: XOIaEgvHS+e4vxvh/85PkA==
X-CSE-MsgGUID: yhJbDDIvQmijqQX++U5/mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1123025"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1123025"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:06 -0700
X-CSE-ConnectionGUID: 81cOPW6vTGa/BM4zDcCX8Q==
X-CSE-MsgGUID: ElRAC7FNSF+ntJI1M43W0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="3024987"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:04 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] ALSA: compress: fix buffer handling and state validation
Date: Mon, 19 Oct 2026 17:45:29 +0300
Message-ID: <20261019144533.30665-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Changes since v1:
- patch 1: do not free the old buffer in snd_compr_allocate_buffer().
  SET_PARAMS can only be repeated in OPEN state after ops->set_params()
  has failed, so release the framework-owned buffer on that error path
  instead. The buffer is allocated once per successful SET_PARAMS and is
  never replaced (Vinod, Takashi)
- patch 2: reworded the commit message: the buffer is set up once and the
  next_track path does not re-allocate it. The geometry check is kept
  because ops->set_params() would otherwise receive buffer parameters
  that do not match the buffer in use. tinycompress always passes the
  open-time fragment_size/fragments on next_track, so existing users are
  not affected (Vinod)
- patches 3 and 4: added Acked-by from Vinod

The compress offload core has several edge cases in buffer management
and state validation.

A SET_PARAMS that the driver rejects leaves the framework-owned buffer
allocated while the stream stays in the OPEN state, so a following
SET_PARAMS overwrites the pointer and leaks the buffer. During gapless
playback, SET_PARAMS can also change the buffer geometry while the byte
counters still refer to the current buffer. Separately, SET_METADATA can
reach the driver before SET_PARAMS, and the origin_seqno task lookup can
restart a task that is still ACTIVE.

Address these cases by:
- releasing the framework-owned buffer when ops->set_params() fails, so
  the buffer is allocated once per successful SET_PARAMS;
- not re-allocating the buffer on the gapless next_track path and
  rejecting a buffer geometry change there;
- rejecting SET_METADATA while the stream is OPEN; and
- allowing origin_seqno to reuse IDLE or FINISHED tasks, but not ACTIVE
  ones.

Regards,
Peter
---
Peter Ujfalusi (4):
  ALSA: compress: fix buffer leak on failed SET_PARAMS
  ALSA: compress: reject buffer geometry change on gapless next_track
  ALSA: compress: add missing OPEN-state gate to SET_METADATA
  ALSA: compress: reject restarting an ACTIVE task via origin_seqno

 sound/core/compress_offload.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

-- 
2.56.0

