Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFFC3EE1C4;
	Tue,  9 Jun 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994110; cv=none; b=hU0G/Klb/M8j2dwEf9BwylxWVDGWr66Y2c78LqgJDo0+QWJ92j1xcYRwbtuj+nMdCsK/5JO4d5IORSZi0M2W3jQlqWaFsJcvsH6xmzmlXoJTRBAaEr68kqba3q+G45e5Y9e5cxyLx3ZT8X2tmAgL2nzHs2wL4WlLr4oaMvaayic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994110; c=relaxed/simple;
	bh=sV8Uu1KS2QPG+rRHOiTVxK4dhq86UBz/cYe4q+TPndg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EsFeImvgspIakhmbqsTRm07ZPpyl/12X0LILnt7KuV76nE7EsFVEnPfoWwFJ+6MaCKBtqU1C8YdKPe/eQWIeo1CRjISMtsBHTnueXr2RXhM5sk9WRoxJXY6G1LQi3HUTud1RNgyMv8bbZErPfRtWnMFlKncD7mWCMqf6A8FAh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=czfaXA/6; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="czfaXA/6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780994109; x=1812530109;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sV8Uu1KS2QPG+rRHOiTVxK4dhq86UBz/cYe4q+TPndg=;
  b=czfaXA/6X7P0KUJHOEEyCnvCq8DuF36dHQUhtjOFrf1xcmUq5cvF6OBE
   0TPsq/NjEeQaJnNBXgRyUiBWRAAKLIFGLiB0wsFd5AhrRihMNm/oz5Lxp
   LMumCA2kjZo8Wl6rKykJ6VNICTDXJsv8cAFGkIREL3YmWyJazeJlDFHIn
   clNMNkfnc0Tq8dxH+1Lc+b++VAbsGGfU7J6rsfj0h/Jt1lmjRyEF6V1wv
   hFHr8OVrukRI3hSafUJMHNIjArbB3ZNiemj+3hWAOh9wO1cKqwsM1b9A6
   W/nMuXETv6U6jm0BvfA0juNocbyVulxCauXJhrwRTuRSTGuakpj4qccrN
   g==;
X-CSE-ConnectionGUID: C9Xd4vvARiybA+ydbRD2Bw==
X-CSE-MsgGUID: 9HE6QqX8Qyi3FhhYh2AmGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93235457"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93235457"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:35:09 -0700
X-CSE-ConnectionGUID: AjsmvtOPR5a3u70AkL8RpQ==
X-CSE-MsgGUID: wMEWUETQQtKLfmVD8e2fDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245650222"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:35:06 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 6/6] ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get
Date: Tue,  9 Jun 2026 11:34:58 +0300
Message-ID: <20260609083458.31193-7-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609083458.31193-1-peter.ujfalusi@linux.intel.com>
References: <20260609083458.31193-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ipc_control_data buffer is allocated as kzalloc(max_size), where
max_size covers the entire struct sof_ipc_ctrl_data including its
flexible array payload. However, the bounds checks in bytes_ext_put
and _bytes_ext_get compared user data lengths against max_size
directly, ignoring that cdata->data sits at an offset of
sizeof(struct sof_ipc_ctrl_data) bytes into the allocation.

This allowed writing up to sizeof(struct sof_ipc_ctrl_data) bytes past
the end of the heap buffer from unprivileged userspace via the ALSA TLV
kcontrol interface, and similarly allowed over-reading adjacent heap
data on the get path.

Fix all bounds checks to subtract sizeof(*cdata) from max_size so they
reflect the actual space available at the cdata->data offset. Also fix
the error-path restore in bytes_ext_put which wrote to cdata->data
instead of cdata, causing the same overflow.

Fixes: 67ec2a091630 ("ASoC: SOF: Add bytes_ext control IPC ops for IPC3")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc3-control.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/sof/ipc3-control.c b/sound/soc/sof/ipc3-control.c
index 1f5538bbc50f..d1697401b1da 100644
--- a/sound/soc/sof/ipc3-control.c
+++ b/sound/soc/sof/ipc3-control.c
@@ -398,9 +398,17 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 	}
 
 	/* be->max is coming from topology */
-	if (header.length > scontrol->max_size) {
-		dev_err_ratelimited(scomp->dev, "Bytes data size %d exceeds max %zu\n",
-				    header.length, scontrol->max_size);
+	if (header.length > scontrol->max_size - sizeof(*cdata)) {
+		dev_err_ratelimited(scomp->dev, "Bytes data size %u exceeds max %zu\n",
+				    header.length, scontrol->max_size - sizeof(*cdata));
+		return -EINVAL;
+	}
+
+	/* Ensure the data is large enough to contain the ABI header */
+	if (header.length < sizeof(struct sof_abi_hdr)) {
+		dev_err_ratelimited(scomp->dev,
+				    "Bytes data size %u less than ABI header %zu\n",
+				    header.length, sizeof(struct sof_abi_hdr));
 		return -EINVAL;
 	}
 
@@ -436,7 +444,7 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 	}
 
 	/* be->max has been verified to be >= sizeof(struct sof_abi_hdr) */
-	if (cdata->data->size > scontrol->max_size - sizeof(struct sof_abi_hdr)) {
+	if (cdata->data->size > scontrol->max_size - sizeof(*cdata) - sizeof(struct sof_abi_hdr)) {
 		dev_err_ratelimited(scomp->dev, "Mismatch in ABI data size (truncated?)\n");
 		goto err_restore;
 	}
@@ -452,7 +460,7 @@ static int sof_ipc3_bytes_ext_put(struct snd_sof_control *scontrol,
 err_restore:
 	/* If we have an issue, we restore the old, valid bytes control data */
 	if (scontrol->old_ipc_control_data) {
-		memcpy(cdata->data, scontrol->old_ipc_control_data, scontrol->max_size);
+		memcpy(cdata, scontrol->old_ipc_control_data, scontrol->max_size);
 		kfree(scontrol->old_ipc_control_data);
 		scontrol->old_ipc_control_data = NULL;
 	}
@@ -491,10 +499,13 @@ static int _sof_ipc3_bytes_ext_get(struct snd_sof_control *scontrol,
 	}
 
 	/* check data size doesn't exceed max coming from topology */
-	if (cdata->data->size > scontrol->max_size - sizeof(struct sof_abi_hdr)) {
-		dev_err_ratelimited(scomp->dev, "User data size %d exceeds max size %zu\n",
+	if (cdata->data->size > scontrol->max_size - sizeof(*cdata) -
+				sizeof(struct sof_abi_hdr)) {
+		dev_err_ratelimited(scomp->dev,
+				    "User data size %u exceeds max size %zu\n",
 				    cdata->data->size,
-				    scontrol->max_size - sizeof(struct sof_abi_hdr));
+				    scontrol->max_size - sizeof(*cdata) -
+				    sizeof(struct sof_abi_hdr));
 		return -EINVAL;
 	}
 
-- 
2.54.0

