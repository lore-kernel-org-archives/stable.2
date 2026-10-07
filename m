Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20253411FA8;
	Wed,  7 Oct 2026 13:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379532; cv=none; b=Y6XfRB8ux0CSilIErxGWU595/UahNyR3j18kIrNZNtTYINOgcg5VGche8p7S08wWQRO22E4Udyu4XP6BSAzmC7jraZase3RdPCX77SATVMDCL+cjcv5OsAZ5tJPJd1z5q1ddELjQe09C5XGx6xQVcCEwPV5KTYOshdIw/sZLjh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379532; c=relaxed/simple;
	bh=3zuqBW+rZVkIha8hArGbkAfU2wd+SRp+UShEmzT0sZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FQgfqyXqAj9c1ib29QfXJj5kqeuWcRnvkKSBseRlYVZGiDTkeWFWooSESvvrZn2r/ElAJYgrjzUfEhiBKVKzQ96MYu2IuDQF+Rhr3CWYgC3XxWGmm8ojt/NRAqxCXJrtvWCOhhCAdG8LD9prdupOcILnQUHmqY50TOZmmviAe9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KNlLs1I7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KNlLs1I7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791379512; x=1822915512;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3zuqBW+rZVkIha8hArGbkAfU2wd+SRp+UShEmzT0sZY=;
  b=KNlLs1I7nAFhpc8/MUyz6kG+VNY4eodpN6L5k+EDC1jKoAXkQI+cnbCB
   ps9hADiR8wWTPtsdODYyIeuWx5GbSGDxO7NgnnUMtrCTUn9ZBhpVbF/MO
   1GS6Vd6cbd57DBvVg5MRbeIzJUjO9hO9xBawPKO2iNRUoMhWP53OiU64i
   d/N0iGASildnYpbqQBdHYnLPMn61y3M/4vw3hOxq2Y5Gd5/E0YFLRCc+w
   hsF/m1M4LPtkaHqBNEI5+5oJbqZpwtOnyhUotFqv98+L/835wzZgDTAQg
   fgEHdp0Q8YYz9K9uHnT7516wQ+eChLZeFtn2waF+MfOof2Gdy2aCpoTIZ
   A==;
X-CSE-ConnectionGUID: VwU2r9yLRQ6mfruA8oSwdg==
X-CSE-MsgGUID: ClpARjE8RGqiAFJQFhSzHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="39786"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="39786"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:58 -0700
X-CSE-ConnectionGUID: juYXj83lTc+6IHGF+xwqzg==
X-CSE-MsgGUID: xwBLHMuNRMq4F7y+dm9+ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="305434452"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:56 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 4/4] ALSA: compress: reject restarting an ACTIVE task via origin_seqno
Date: Wed,  7 Oct 2026 16:25:09 +0300
Message-ID: <20261007132509.18237-5-peter.ujfalusi@linux.intel.com>
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
---
 sound/core/compress_offload.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index bf13fa0877dd..27bc490aa3ff 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -1154,7 +1154,9 @@ static int snd_compr_task_start_prepare(struct snd_compr_task_runtime *task,
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

