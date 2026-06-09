Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0F62D0C7E;
	Tue,  9 Jun 2026 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994098; cv=none; b=PY2X3Z+Op85RmzwmzDIudmsVPCL86KWO/gAYcmINqDHtMibbxJRcnbCR7rqM3YkcSTRQbJLdfxtjL6ZziTJg5JZNGirIQ4Kljm/I2c30Tywd1//DWGTjMTWM1zeCZapETTB+JlB4YKzLrINh0/vzYjAN1a7mfx/PEB9pV8AskYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994098; c=relaxed/simple;
	bh=Eq9dmjrcV5i/aAEuPi5ASe4bgzRYmVfkfn+ew/YoOMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oll8eXTtDUFclJTY3Z3kiLx3WHbnV7kX60jLq8H3phEjRtcbN9EUFM7Aq6jJAa6URfTuivQRuzU83UfuXpjIIiFw+SZ94MtP+HbK94Z0jKUH+Rc2ePYKA9Koj5dJ6mW0e6qrUtELUxdWC4aj2OaLxFwE8+Wx3ACGPKD2bO4/fN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l5grbae3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l5grbae3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780994097; x=1812530097;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Eq9dmjrcV5i/aAEuPi5ASe4bgzRYmVfkfn+ew/YoOMI=;
  b=l5grbae3dJs/P0S7iBMUA/+gMm4d6tDzd3UxT9J4y24/KKA3fsmHm10o
   3xEGuDsUGL6trblXbdzSAZfPgymiShjlHYDZnjE15mRWG/cn1ruaAfkzb
   4sk8+yYnYgFKAMxF8I3bZ4PIhF4+5Kym/uynoie4AfbhHGhvJRgi9yBsr
   i9YK9rBgo7lrc3uZ23U5fgUsU4+y/A3VSNOor++a5yl9FunOjwGRJqauL
   W6w+fKAc7LxrB0e9nckHEMXvKZQqncm/B31Fu1l3z3uDoX/JZNjfgCv4a
   UBCLqRXX9q+nCEdsUNkUnBvOp//JtEjFLvSpmzzv/2IOjJPLw7by/lWIP
   w==;
X-CSE-ConnectionGUID: xPpftTZwR4WRUALzNWCznQ==
X-CSE-MsgGUID: fuXuXBeiSxqeVOvqS0Gkvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93235425"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93235425"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:34:56 -0700
X-CSE-ConnectionGUID: PZ3KtBfET3G5De5+w38GeQ==
X-CSE-MsgGUID: RnaqF7EQRZWIReO1G7/+Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245650076"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:34:54 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 2/6] ASoC: SOF: ipc4-control: Validate notification payload size
Date: Tue,  9 Jun 2026 11:34:54 +0300
Message-ID: <20260609083458.31193-3-peter.ujfalusi@linux.intel.com>
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

Validate MODULE_NOTIFICATION payload length before reading
bytes/channel data in control update handling.

Fixes: 2a28b5240f2b ("ASoC: SOF: ipc4-control: Add support for generic bytes control")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc4-control.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/sof/ipc4-control.c b/sound/soc/sof/ipc4-control.c
index aa31eed05730..8d86d32a16ca 100644
--- a/sound/soc/sof/ipc4-control.c
+++ b/sound/soc/sof/ipc4-control.c
@@ -875,6 +875,16 @@ static void sof_ipc4_control_update(struct snd_sof_dev *sdev, void *ipc_message)
 		 */
 		if (type == SND_SOC_TPLG_TYPE_BYTES) {
 			struct sof_abi_hdr *data = cdata->data;
+			size_t source_size = struct_size(msg_data, data, msg_data->num_elems);
+
+			if (source_size > ndata->event_data_size) {
+				dev_warn(sdev->dev,
+					 "%s: invalid bytes notification size for %s (%zu, %u)\n",
+					 __func__, scontrol->name, source_size,
+					 ndata->event_data_size);
+				scontrol->comp_data_dirty = true;
+				goto notify;
+			}
 
 			if (msg_data->num_elems > scontrol->max_size - sizeof(*data)) {
 				dev_warn(sdev->dev,
@@ -887,6 +897,17 @@ static void sof_ipc4_control_update(struct snd_sof_dev *sdev, void *ipc_message)
 				scontrol->size = sizeof(*cdata) + sizeof(*data) + data->size;
 			}
 		} else {
+			size_t source_size = struct_size(msg_data, chanv, msg_data->num_elems);
+
+			if (source_size > ndata->event_data_size) {
+				dev_warn(sdev->dev,
+					 "%s: invalid channel notification size for %s (%zu, %u)\n",
+					 __func__, scontrol->name, source_size,
+					 ndata->event_data_size);
+				scontrol->comp_data_dirty = true;
+				goto notify;
+			}
+
 			for (i = 0; i < msg_data->num_elems; i++) {
 				u32 channel = msg_data->chanv[i].channel;
 
@@ -914,6 +935,8 @@ static void sof_ipc4_control_update(struct snd_sof_dev *sdev, void *ipc_message)
 		scontrol->comp_data_dirty = true;
 	}
 
+notify:
+
 	/*
 	 * Look up the ALSA kcontrol of the scontrol to be able to send a
 	 * notification to user space
-- 
2.54.0

