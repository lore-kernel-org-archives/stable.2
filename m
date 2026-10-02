Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E801847DD73
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936620; cv=none; b=RoVo7U7i+2W49mrY7DWsz4ZqjUHNrqAEGOAMpxRlDZmQPnjLqsN1XOEe1eKcIFhyyWhzLKRo/qhIxG8Y3eWoqZUpOWCd4auUj2kxv+a9K8ih/qARzx0dIBhpmmhG07NPbIAiksoc14wmVDwxq42yxvVfKGWs4Pg//g0+7AdUIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936620; c=relaxed/simple;
	bh=/WBAUv0rCtdrYA798x+bjIVJkl7azMwI6GE7cMrjl9s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxA2prz6EoROGOwSEVLLk+4ge+OEqovJU+gsNrcwqDAGgnRXSj2yjYgqiYrNUwxzw7X6a0cMT1tFJpNNo42uN6w4/+jEacpawprucez1neFGcAs5xecaDyHmcQ6VxKmV79DDJxcKv6IjE1qmE+u1rurKIWaoyaMfvkcH5GrP/DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JJDPPDJX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JJDPPDJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790936619; x=1822472619;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=/WBAUv0rCtdrYA798x+bjIVJkl7azMwI6GE7cMrjl9s=;
  b=JJDPPDJXVhez4FglEJ2IXvVCHva/NbifW/KFDIlK5jJD9W+a/LZuhxs3
   yzN6hPjllRE1kE8/Hi5P9oPtazliOK7Q+eYZ9fhjs4waIyfkdeWLVIO9l
   2CsFI7A9pFZfpMeWApNYvVqbh5ZI8TqUYc/SiXteyIUFuZAg0MLx4jWZ6
   UacO2jwd4xSiBSXUvKxjsQWV5+UNmqJ9EMbjPs4VNWy0vqzUOZe8SvSaX
   +RgKLXhS2gqQVg4YNwdodVMgASmG2w1oBFq3Qhdfi4tyKcAks9ggfmYcm
   pJGM100dT4ovNZhDRKUqeqT5Nde/W78SkFxJvnFK/xmYPSM+u9hhX+1/c
   Q==;
X-CSE-ConnectionGUID: mQu7yJDJS6KBRiFTiOGsbA==
X-CSE-MsgGUID: qRiII6oCRI2yCP427ILjIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="101864388"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101864388"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:23:39 -0700
X-CSE-ConnectionGUID: qJe4lW+2R5aT5X6lLL6aOw==
X-CSE-MsgGUID: WXK/FpaIQM+g1eafJX3zfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="302475338"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.171])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:23:37 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Subject: [PATCH stable v6.12 backport 2/2] ASoC: SOF: ipc4/Intel: Add support for library restore firmware functionality
Date: Fri,  2 Oct 2026 13:23:53 +0300
Message-ID: <20261002102353.26919-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002102353.26919-1-peter.ujfalusi@linux.intel.com>
References: <20261002102353.26919-1-peter.ujfalusi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The firmware will be able to only save and restore the context related to
library management.
This means that even without a full context save, the libraries do not
need to be re-loaded to the firmware after second or consecutive boots.

This is reported via the FW_READY notification, where BIT(15) indicates:
0 - the library restore is not done
1 - library restore is done

This bit is only valid if full context save is not enabled, full context
save is by definition saves and restores the library related book-keeping
as well.

Add a new flag to tell the platform code if the libraries have been
restored, no need to reload them after boot.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Liam Girdwood <liam.r.girdwood@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Link: https://patch.msgid.link/20250619105623.4546-3-peter.ujfalusi@linux.intel.com
Link: https://github.com/thesofproject/sof/issues/11229
Signed-off-by: Mark Brown <broonie@kernel.org>
(cherry picked from commit ace9b3daf2b4778358573d3698e34cb1c0fa7e14)
Cc: stable@vger.kernel.org # v6.12
---
 include/sound/sof/ipc4/header.h  |  2 ++
 sound/soc/sof/intel/hda-loader.c |  7 +++++--
 sound/soc/sof/ipc4-loader.c      |  6 ++++++
 sound/soc/sof/ipc4-priv.h        |  2 ++
 sound/soc/sof/ipc4.c             | 14 ++++++++++++--
 5 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/sound/sof/ipc4/header.h b/include/sound/sof/ipc4/header.h
index 0c0cf47946b1..5302721c154d 100644
--- a/include/sound/sof/ipc4/header.h
+++ b/include/sound/sof/ipc4/header.h
@@ -485,6 +485,8 @@ struct sof_ipc4_dx_state_info {
 #define SOF_IPC4_LOG_CORE_GET(x)		(((x) & SOF_IPC4_LOG_CORE_MASK) >> \
 						 SOF_IPC4_LOG_CORE_SHIFT)
 
+#define SOF_IPC4_FW_READY_LIB_RESTORED		BIT(15)
+
 /* Value of notification type field - must fit into 8 bits */
 enum sof_ipc4_notification_type {
 	/* Phrase detected (notification from WoV module) */
diff --git a/sound/soc/sof/intel/hda-loader.c b/sound/soc/sof/intel/hda-loader.c
index 9d8ebb7c6a10..a1cd80eba6eb 100644
--- a/sound/soc/sof/intel/hda-loader.c
+++ b/sound/soc/sof/intel/hda-loader.c
@@ -548,8 +548,11 @@ int hda_dsp_ipc4_load_library(struct snd_sof_dev *sdev,
 	struct snd_dma_buffer dmab;
 	int ret, ret1;
 
-	/* if IMR booting is enabled and fw context is saved for D3 state, skip the loading */
-	if (reload && hda->booted_from_imr && ipc4_data->fw_context_save)
+	/*
+	 * if IMR booting is enabled and libraries have been restored during fw
+	 * boot, skip the loading
+	 */
+	if (reload && hda->booted_from_imr && ipc4_data->libraries_restored)
 		return 0;
 
 	/* the fw_lib has been verified during loading, we can trust the validity here */
diff --git a/sound/soc/sof/ipc4-loader.c b/sound/soc/sof/ipc4-loader.c
index bcdb33d03682..bba5c1a8e27e 100644
--- a/sound/soc/sof/ipc4-loader.c
+++ b/sound/soc/sof/ipc4-loader.c
@@ -401,6 +401,12 @@ int sof_ipc4_query_fw_configuration(struct snd_sof_dev *sdev)
 			break;
 		case SOF_IPC4_FW_CONTEXT_SAVE:
 			ipc4_data->fw_context_save = *tuple->value;
+			/*
+			 * Set the default libraries_restored value - if full
+			 * context save is supported then it means that
+			 * libraries are restored
+			 */
+			ipc4_data->libraries_restored = ipc4_data->fw_context_save;
 			break;
 		default:
 			break;
diff --git a/sound/soc/sof/ipc4-priv.h b/sound/soc/sof/ipc4-priv.h
index 0889de04b017..bd3cb7908415 100644
--- a/sound/soc/sof/ipc4-priv.h
+++ b/sound/soc/sof/ipc4-priv.h
@@ -72,6 +72,7 @@ struct sof_ipc4_fw_library {
  * @max_libs_count: Maximum number of libraries support by the FW including the
  *		    base firmware
  * @fw_context_save: Firmware supports full context save and restore
+ * @libraries_restored: The libraries have been retained during firmware boot
  *
  * @load_library: Callback function for platform dependent library loading
  * @pipeline_state_mutex: Mutex to protect pipeline triggers, ref counts, states and deletion
@@ -87,6 +88,7 @@ struct sof_ipc4_fw_data {
 	int max_num_pipelines;
 	u32 max_libs_count;
 	bool fw_context_save;
+	bool libraries_restored;
 
 	int (*load_library)(struct snd_sof_dev *sdev,
 			    struct sof_ipc4_fw_library *fw_lib, bool reload);
diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index e4eb8e004885..9427d80ceafa 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -616,9 +616,19 @@ EXPORT_SYMBOL(sof_ipc4_find_debug_slot_offset_by_type);
 
 static int ipc4_fw_ready(struct snd_sof_dev *sdev, struct sof_ipc4_msg *ipc4_msg)
 {
-	/* no need to re-check version/ABI for subsequent boots */
-	if (!sdev->first_boot)
+	if (!sdev->first_boot) {
+		struct sof_ipc4_fw_data *ipc4_data = sdev->private;
+
+		/*
+		 * After the initial boot only check if the libraries have been
+		 * restored when full context save is not enabled
+		 */
+		if (!ipc4_data->fw_context_save)
+			ipc4_data->libraries_restored = !!(ipc4_msg->primary &
+							   SOF_IPC4_FW_READY_LIB_RESTORED);
+
 		return 0;
+	}
 
 	sof_ipc4_create_exception_debugfs_node(sdev);
 
-- 
2.55.0

