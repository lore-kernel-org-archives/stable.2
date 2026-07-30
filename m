Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8961B3B4EA5;
	Thu, 30 Jul 2026 08:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785401921; cv=none; b=ZMBSmR6mcFjee6ImskohKPsx7FCcBY0zmaqgr990xr41lu8XxB3bglhyWSpvCmUP4ItVI7H704iaq6LLeiFqZgZiIx9gwbA6tJQKkUumwTGiZfaqTqMlyqSKs3z6+AuqZ8H0N/eV6ak30PwZMmgEUhntAew6B36zgVlJ4EpUPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785401921; c=relaxed/simple;
	bh=3kJPsOEKbz+FFSfvEJQNeyfVV8bpdR2Q2Cxeg9WBEdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YRQmjKtoFer5VZWatwzsOLomEaAcO5ouRnkPI9pzbW1meUHmbkMDCTrrIbR0Kf+Y+IUgKXBcxqu3HZ2vRlW8c4P+KutJc+SOpxWFExyvfp4PbkxB2InSMT/vJ6E812TLBu0SjLCj4BazN5NV0o0T+Ba4uDWO9erG+zQgJ4NDrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mixDEZJm; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mixDEZJm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785401920; x=1816937920;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3kJPsOEKbz+FFSfvEJQNeyfVV8bpdR2Q2Cxeg9WBEdo=;
  b=mixDEZJmxBuZqnQcfZ9Vsro+JvNvQMJ/KuaxpyAkT0ScQsDAYtBEn+Xk
   I/B+PBJ0Q8Emg9/YrkbGfkeE0kFEGC56gIIN8GhQVopqiokO4avvKJH7k
   pweAyvONz1X2P4qTynUhH+rAQKcPpzdyB9K2ciyvEoVG8b0t5iY/36jV0
   HLRuEAQRgKObBd/4xpuHlRSt2ejBb7xEJFPmO1teo3t+XlI8B628KWKh9
   MbhabGimJzQvNT0r5toJI3rdQB3QTyEPlWeBIcirHOjaOFuHTqK98bbkt
   LKt7KX7k3n0KrMGKbBjcg/ojEz2semYkraHDSG/lVXojxw26z3tUxdTSO
   Q==;
X-CSE-ConnectionGUID: 1Mawn5wqRXemR67DNJ16jg==
X-CSE-MsgGUID: gSLCBosdTdecvP7VXpZmZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="96601938"
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="96601938"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 01:58:39 -0700
X-CSE-ConnectionGUID: rvuyYdTQQfyPc55Lc5JP0g==
X-CSE-MsgGUID: zzYymCpqRWWhLFNr9s/8Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,194,1779174000"; 
   d="scan'208";a="257565833"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.79])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 01:58:37 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: sof-audio: Fix error path in sof_widget_setup_unlocked()
Date: Thu, 30 Jul 2026 11:59:14 +0300
Message-ID: <20260730085914.27546-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If either tplg_ops->dai_config or widget_kcontrol_setup fail during widget
setup we would double decrement the use_count of the widget because the
sof_widget_free_unlocked() would be called twice, similarly the core_put
would be invoked twice as well.

Since the use_count and core_put() is handled within the widget_free
function we need to return without falling through the pipe_widget_free
label.

The fixes tag is picked to the last change around this part of the code
which is adequately old enough for backporting purposes.

Link: https://github.com/thesofproject/sof/issues/10826
Fixes: 31ed8da1c8e5 ("ASoC: SOF: sof-audio: Modify logic for enabling/disabling topology cores")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index acf56607bc9c..24614e506019 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -146,7 +146,6 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 {
 	const struct sof_ipc_tplg_ops *tplg_ops = sof_ipc_get_ops(sdev, tplg);
 	struct snd_sof_pipeline *spipe = swidget->spipe;
-	bool use_count_decremented = false;
 	int ret;
 	int i;
 
@@ -225,9 +224,10 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 	return 0;
 
 widget_free:
-	/* widget use_count will be decremented by sof_widget_free() */
+	/* widget use_count and core_put handled by sof_widget_free() */
 	sof_widget_free_unlocked(sdev, swidget);
-	use_count_decremented = true;
+	return ret;
+
 pipe_widget_free:
 	if (swidget->id != snd_soc_dapm_scheduler) {
 		sof_widget_free_unlocked(sdev, swidget->spipe->pipe_widget);
@@ -242,8 +242,7 @@ static int sof_widget_setup_unlocked(struct snd_sof_dev *sdev,
 		}
 	}
 use_count_dec:
-	if (!use_count_decremented)
-		swidget->use_count--;
+	swidget->use_count--;
 
 	return ret;
 }
-- 
2.55.0

