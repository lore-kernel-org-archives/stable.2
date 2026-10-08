Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CE478842;
	Thu,  8 Oct 2026 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791450073; cv=none; b=Oco2vboemBRDG/sOBnisHk1o8r17CosOHcruzDsvPePozAdC5CY6ltxsqhtkqn1dz+mHsx67LRjRHkWjX47l/+fHro0TtdLZ/C6DpMFEe83Yofsbe6iwRmtZCK200VumNaSyjla+9WffrUc+iR9Blet2wlEVoco6jHzol2x3C/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791450073; c=relaxed/simple;
	bh=v4jns9pDD/PeTQYhkB7WzQZLRV+oKLKAUZhnb2iVRV0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bj+VI39Ktcq9ezStnvImmleqjXQ9myk9eb+pysNR3Gw7hIdhlSLJ7NEdtfXVaL3Bu6yPD//q86dpDLVS8Wap/GFXDbhUMX4iiw7C3BffqxnR1u6/B1mjhKSZ/6C5WeLerjX2lCu8lcDT43xaUHlpYTc83pc6DXCt1MgcFXWtRpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dZm4MJP/; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dZm4MJP/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791450071; x=1822986071;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v4jns9pDD/PeTQYhkB7WzQZLRV+oKLKAUZhnb2iVRV0=;
  b=dZm4MJP/20rupkoqIFdcTdGytzOh6F0lwpfB7lJuwtWCxexzguXvL/1/
   M2SAsR4CosO3O8yUze6uW7xcS3GNubBf/77m0BtCGYK2VOv1vf+Psu5V3
   tlARx5ey4uyC/1WKGxBVnhTU7LQ9UrIr1pwszGCnLOPAT9AQxNqJr5QSF
   bKihLrjIj++zzvAxiY/sEtJV1KvMOsOWgAXUXRemQKfrbM+m+v/SX2YN7
   MlRXaSLovOGjkX3fz33F+q8k3d1Tmd0FVFbdyq9kzvMpc6c+oDjfQJJfc
   Zbr54cbhwTDVBfAw7hod2RZltYP/yUTGA6FHh1GeYKAmOhGzLJGQhZi/u
   w==;
X-CSE-ConnectionGUID: Ui9ig394SKeaQ+tPSIefMQ==
X-CSE-MsgGUID: V5FYUIbhQ/GINp4763PgPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="124258"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="124258"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 02:01:11 -0700
X-CSE-ConnectionGUID: IpVNLe58QSKdh+cgXkWicw==
X-CSE-MsgGUID: 1MkOzPW2QTWVpZ/ZCBjKxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="94128"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.245.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 02:01:08 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	stable@vger.kernel.org
Subject: [PATCH] ASoC: SOF: ipc4-topology: Fix shift-out-of-bounds for aggregated ALH capture
Date: Thu,  8 Oct 2026 12:01:30 +0300
Message-ID: <20261008090130.15135-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When ch_count is smaller than blob->alh_cfg.device_count (e.g. a mono
capture stream, such as a SmartMic, aggregated across multiple SDW
links), step = ch_count / blob->alh_cfg.device_count truncates to 0.
The subsequent GENMASK(step - 1, 0) then underflows step - 1 (u32) to
UINT_MAX, causing GENMASK()'s internal shift to use an out-of-bounds
exponent:

  UBSAN: shift-out-of-bounds in sound/soc/sof/ipc4-topology.c:2363:13
  shift exponent 18446744069414584384 is too large for 64-bit type 'long unsigned int'

Treat ch_count < device_count the same way as the existing "channels
equal to output reference channels" case: apply the same ch_mask to
every aggregated device instead of trying to split channels that
can't be evenly divided.

Fixes: 0390a102cc18 ("ASoC: SOF: ipc4-topology: use different channel mask for each sdw amp feedback")
Cc: stable@vger.kernel.org
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index f6617dcbf789..c7ff687ecc1d 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2473,11 +2473,14 @@ _sof_ipc4_prepare_copier_module(struct snd_sof_widget *swidget,
 				ch_map >>= 4;
 			}
 
-			if (swidget->id == snd_soc_dapm_dai_in && ch_count == out_ref_channels) {
+			if ((swidget->id == snd_soc_dapm_dai_in && ch_count == out_ref_channels) ||
+			    ch_count < blob->alh_cfg.device_count) {
 				/*
 				 * For playback DAI widgets where the channel number is equal to
-				 * the output reference channels, set the step = 0 to ensure all
-				 * the ch_mask is applied to all alh mappings.
+				 * the output reference channels, or when there are fewer
+				 * channels than aggregated devices (e.g. a mono capture
+				 * stream split across multiple links), set step = 0 to
+				 * ensure all the ch_mask is applied to all alh mappings.
 				 */
 				mask = ch_mask;
 				step = 0;
-- 
2.56.0

