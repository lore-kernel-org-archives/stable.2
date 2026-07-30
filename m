Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8745833A6E9;
	Thu, 30 Jul 2026 11:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785410591; cv=none; b=YOML002dl77mWc7WJ2KDzxEVI0LspblrYDXQCLZ22Ald1e5wUqY2GLX4cZoKZ+4A81XSXLWGjpYVHrQg7BP+l6OiKLyRcWfrqOAy9UMWQiYV41SbyL++AWmd32ly1zaFYKsi+rH0eHvpUfHS2dZ5mMT54K2T2P5uZDDAfI5wh9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785410591; c=relaxed/simple;
	bh=zzRYmisyqqYyJCmjGp5EB4x2yS3D8pL5ExRDwJkhsI0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ob1lk7EQoPB6IWgtiKQJZ9LCfDAwLen7Ve4wqhJNjUok0NIP5TK63jkFQw7e0tli5I2/gzSDqniQ+IlNwNjO/UUpuzfOjkbPucOduqQ7B+qf0btWrNjtZKaj04SZ0OcbPSxoyupu0qPpQZ5mTZIwUHaq6Eyvpv6gQ0oYlFoNW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bOlnJjni; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bOlnJjni"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785410589; x=1816946589;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zzRYmisyqqYyJCmjGp5EB4x2yS3D8pL5ExRDwJkhsI0=;
  b=bOlnJjni7jpNUdzIQBOvojJkvh1zq2SSKhxuRhlfG+Ub7sxxJ8a6rdWU
   2t/xK2a58/imjjhv+6rlc7aj7CLBiI4Yr9A/+baYlg48kIWBRvYrEBwSF
   rFxXeDHWqXX3rpDwnWrkb2zJBQ4X9UQ1w65VYmocxv/sU6UDEhs78lYu1
   WOLcAMfYeVh+SYSVs0aEIIXN/YffnPz3fS3UEuF/sQWJCZqYc7YNcsXE8
   qNp2+HG+LT0xaezXACf5+eg+UiPkQI1I/J7zzrtLL+fjrtAf48arbi1Bv
   CrXk2MX4sPvR2thOfVGyPrD87yRAP60V4tQHvik/3bLAgHSEbiOkyoufC
   w==;
X-CSE-ConnectionGUID: Jv0QhcOjSKOtfT30OqLCJQ==
X-CSE-MsgGUID: ISQYo26cRsOj7A+E1A4zRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="86064366"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="86064366"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:23:08 -0700
X-CSE-ConnectionGUID: qc5gURjnQXmYa/FQAqK/nQ==
X-CSE-MsgGUID: utmTLGbUQK+ZF4iq6VF77g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="257599630"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.79])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 04:23:07 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-pcm: Continue the pipeline trigger in case of IPC timeout
Date: Thu, 30 Jul 2026 14:23:43 +0300
Message-ID: <20260730112343.26687-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ignore IPC errors for pipeline state change if the firmware state is
crashed or the IPC has timed out.

If the firmware has crashed the kernel still needs to go through the state
changes to reset its internal to be able to correctly work the next time
the DSP is booted up.

The case with IPC timeout is a bit more problematic, but it has been
rootcaused to be the result of system scheduling blockage and the firmware
did actually received and handled the message, but the reply handling got
blocked by issues outside of the SOF stack.
So far the best way to handle this is to continue with setting the state.

Fixes: c40aad7c81e5 ("ASoC: SOF: ipc4-pcm: Workaround for crashed firmware on system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index fc3ead77e5ea..5929ecf6642e 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -528,7 +528,19 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 	ret = sof_ipc4_set_multi_pipeline_state(sdev, SOF_IPC4_PIPE_PAUSED, trigger_list);
 	if (ret < 0) {
 		spcm_err(spcm, substream->stream, "failed to pause all pipelines\n");
-		goto free;
+		/*
+		 * workaround: if the firmware is crashed or the IPC timed out
+		 * while setting the pipeline state we must ignore the error
+		 * code and proceed to set adjust the local pipeline states.
+		 *
+		 * If the firmware is crashed we will not send IPC messages
+		 * and we are going to see errors printed, but the state of the
+		 * widgets will be correct for the next boot.
+		 */
+		if (sdev->fw_state != SOF_FW_CRASHED && ret != -ETIMEDOUT)
+			goto free;
+
+		ret = 0;
 	}
 
 	/* update PAUSED state for all pipelines just triggered */
@@ -560,14 +572,15 @@ static int sof_ipc4_trigger_pipelines(struct snd_soc_component *component,
 			 "failed to set final state %d for all pipelines\n",
 			 state);
 		/*
-		 * workaround: if the firmware is crashed while setting the
-		 * pipelines to reset state we must ignore the error code and
-		 * reset it to 0.
-		 * Since the firmware is crashed we will not send IPC messages
+		 * workaround: if the firmware is crashed or the IPC timed out
+		 * while setting the pipeline state we must ignore the error
+		 * code and proceed to set adjust the local pipeline states.
+		 *
+		 * If the firmware is crashed we will not send IPC messages
 		 * and we are going to see errors printed, but the state of the
 		 * widgets will be correct for the next boot.
 		 */
-		if (sdev->fw_state != SOF_FW_CRASHED || state != SOF_IPC4_PIPE_RESET)
+		if (sdev->fw_state != SOF_FW_CRASHED && ret != -ETIMEDOUT)
 			goto free;
 
 		ret = 0;
-- 
2.55.0

