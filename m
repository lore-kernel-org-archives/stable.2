Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F242414A11;
	Thu,  8 Oct 2026 09:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450089; cv=none; b=s0dVX123hw5F9LPe+5g3fMQr/On4O8ZFA8n4/rZVqmDVRr6adw/ZzMK9Kuu6SOJCQprwjUZQ8mDPW8SUyzbe0f/g1Jwx0pWOwogh2C/DCdtw+fNSJAXfu/zVIgcWzvJGsywsxtJgHub0LF6nyALNNHQDMfcx2CBypCvlp8Z0CTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450089; c=relaxed/simple;
	bh=UzWh3o7JrLG72pI//Xc4lOL9qFJ7a5a7+551VLglAB0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WAPhhII2KMz8xx0Fn5DElZC3ruF1DQSK6vOtcfVNYhtp09eVI/v/V/oUq8cdYFHczpdWZ0P11sTj8YpK0S0aTawy2mSvP0e3oy1axqT9NHq564wh9RcaVjvZj7Og9jlf6ioA71Q+GVNFXz4x9r4TUpaEPupyNzeK8PK9l6GVXrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VYrjOgl5; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VYrjOgl5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791450088; x=1822986088;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UzWh3o7JrLG72pI//Xc4lOL9qFJ7a5a7+551VLglAB0=;
  b=VYrjOgl5fBQiwd3j/5em+HXdKOFPMBFcv0VePN/Md6/QuWPv85OPoYpq
   N5Qj4LNCqAAhpWpcUIXpqDc2w54KRb7vjwDG29IHl8EG9C2GsIpX/b1WW
   9xIyTvFWYvMxDgEK7EvfmavZIuASUIqdchWuNcp4rtCo+ptoVM7ll5DF2
   C59RuX55upGEmJh8HJqRvFTe/YYyNetWvHoK00c6JssKZF3M1vwSDZyIo
   MdthgjtyypkqLxZiRI7nVjzA9TYptk7ESHjrVOHn36bkwwxUxvlqKveht
   gYuZWA91OPuYiDASuecWriS63s/De7kOfeyG/Yi5/aZxu9eTZPg21Kv0o
   Q==;
X-CSE-ConnectionGUID: mPv5gVJBSS+GksLH/PeLzg==
X-CSE-MsgGUID: Vp0/jiU/Tp+PoEPfIwZeyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="235301"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="235301"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 02:01:23 -0700
X-CSE-ConnectionGUID: 2sr4R3+PRxuMUq9WFaRZjA==
X-CSE-MsgGUID: eaeTNracSTacliCvQ1mc3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="420078"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 02:01:22 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: sof-client: Use event-handler mutex consistently
Date: Thu,  8 Oct 2026 12:01:43 +0300
Message-ID: <20261008090143.15158-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect IPC RX and FW state handler list unregister/dispatch paths with
client_event_handler_mutex to match list registration and locking
comments.

Fixes: 5c19da34df02 ("ASoC: SOF: Use guard()/scoped_guard() for mutex locks where it makes sense")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/sof-client.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/sof-client.c b/sound/soc/sof/sof-client.c
index 64da8df15bf2..21084cd98e43 100644
--- a/sound/soc/sof/sof-client.c
+++ b/sound/soc/sof/sof-client.c
@@ -576,7 +576,7 @@ void sof_client_unregister_ipc_rx_handler(struct sof_client_dev *cdev,
 	struct snd_sof_dev *sdev = sof_client_dev_to_sof_dev(cdev);
 	struct sof_ipc_event_entry *event;
 
-	guard(mutex)(&sdev->ipc_client_mutex);
+	guard(mutex)(&sdev->client_event_handler_mutex);
 
 	list_for_each_entry(event, &sdev->ipc_rx_handler_list, list) {
 		if (event->cdev == cdev && event->ipc_msg_type == ipc_msg_type) {
@@ -593,7 +593,7 @@ void sof_client_fw_state_dispatcher(struct snd_sof_dev *sdev)
 {
 	struct sof_state_event_entry *event;
 
-	guard(mutex)(&sdev->ipc_client_mutex);
+	guard(mutex)(&sdev->client_event_handler_mutex);
 
 	list_for_each_entry(event, &sdev->fw_state_handler_list, list)
 		event->callback(event->cdev, sdev->fw_state);
@@ -628,7 +628,7 @@ void sof_client_unregister_fw_state_handler(struct sof_client_dev *cdev)
 	struct snd_sof_dev *sdev = sof_client_dev_to_sof_dev(cdev);
 	struct sof_state_event_entry *event;
 
-	guard(mutex)(&sdev->ipc_client_mutex);
+	guard(mutex)(&sdev->client_event_handler_mutex);
 
 	list_for_each_entry(event, &sdev->fw_state_handler_list, list) {
 		if (event->cdev == cdev) {
-- 
2.56.0

