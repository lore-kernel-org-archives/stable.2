Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D322F5A680B;
	Mon, 19 Oct 2026 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421115; cv=none; b=RstlnANAJ4UnDgn7TWIQ6Q2d64/03dVpjWtTsSkx2Q1YSIc5O7BSrZNPJ/a79gBkZyfqEThkgs3WmfDuh//7klpReIEiaGGNNOFNoH9S/MtybKVqa0nYLNmhR0vSTBSlZUti242b7A/eOntErOdzBrP1Q/IzDlkdUbvDgNmCxHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421115; c=relaxed/simple;
	bh=rgsD8t0ZcXiqX1/FDYWG/cqbH89m6rxdBKJ2cUmCe8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XjEqFSwZyB4GEKXPvgJax0O1F4oes2XeICARmDSoYIosR6uzplCVCu1HnBiXmveVL4Vh06GzUZbWypogMdg0Rb/UXBA7G8mLl7zIqH4ntsVwPhvQQ0dbgEeHhK8MbakIfEOBtiL7IJPS3AajFLGJuGDW+fh/jUakWOJx6vVWVak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I29nkUeG; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I29nkUeG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792421114; x=1823957114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rgsD8t0ZcXiqX1/FDYWG/cqbH89m6rxdBKJ2cUmCe8M=;
  b=I29nkUeGDumhdE9szQuBQTLeBIQ+Ruou6ci8cICPGqIr03wytsL2HYyJ
   szYjer5XwPKF1TlqwUFf/DwomhmTaAsyYzGItbDRrwMrtkCERhMtisGLN
   7fK9AaeZo/PB1EtNvz6E1xyieafU8jl8smUcC+P+nxGi6KZJv31DmzXWR
   gVYLZaOmhKrhzb1Vfs6rGU4S6bpl5I8rFnn2nvHKCqkruGU4TE8H/mteq
   61YGVJ8CjkHWG3iCyUruqlw7PldOFiVSOjMapBBG6SYFJN1tA/B5apziJ
   7L2nIPdJ38h/mu9SIkUfNuHMQoFhnZBUuKLktTN1AL6x+v7r3jqYMh+su
   A==;
X-CSE-ConnectionGUID: PC5ATWyLTdWOT8T3cHdq2g==
X-CSE-MsgGUID: WJg3Fr1rSrW/7pO0LA9sGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1123059"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1123059"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:13 -0700
X-CSE-ConnectionGUID: sK1H2zYdRMqBvH69HJchOw==
X-CSE-MsgGUID: 37q1gpg2Rjm5BziZEFisMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="3025097"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.179])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 07:45:12 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 4/4] ALSA: compress: reject restarting an ACTIVE task via origin_seqno
Date: Mon, 19 Oct 2026 17:45:33 +0300
Message-ID: <20261019144533.30665-5-peter.ujfalusi@linux.intel.com>
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

snd_compr_task_start_prepare() only rejects tasks with
state >= SND_COMPRESS_TASK_STATE_FINISHED. Since the enum is
IDLE(0) < ACTIVE(1) < FINISHED(2), this accepts ACTIVE tasks and
rejects FINISHED ones, the opposite of what the origin_seqno
mechanism needs: origin_seqno is meant to let a caller reuse a
FINISHED task's buffers for a new job, not to restart a task that is
still queued with the driver.

The seqno lookup path in snd_compr_task_start() has its own explicit
"task->state != IDLE" guard, but the origin_seqno lookup path relies
solely on this function, so it can restart an ACTIVE task, causing
ops->task_start() to be called twice for the same task and
runtime->active_tasks to be incremented twice without a matching
finish/stop.

Accept IDLE and FINISHED, reject ACTIVE, on both entry paths.

Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 sound/core/compress_offload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a250c6b53996..5e5e0f78f26d 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1206,7 +1206,9 @@ static int snd_compr_task_start_prepare(struct snd_compr_task_runtime *task,
 {
 	if (task == NULL)
 		return -EINVAL;
-	if (task->state >= SND_COMPRESS_TASK_STATE_FINISHED)
+	/* only an unqueued or already finished task may be (re)started */
+	if (task->state != SND_COMPRESS_TASK_STATE_IDLE &&
+	    task->state != SND_COMPRESS_TASK_STATE_FINISHED)
 		return -EBUSY;
 	if (utask->input_size > task->input->size)
 		return -EINVAL;
-- 
2.56.0

