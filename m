Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0F4718E9;
	Wed, 30 Sep 2026 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760196; cv=none; b=JkdbWrnojq0Qh43kCzkk/VRbOF/iSncXYsGBKrbmk0+llFImfIsSFcssAirbJEUEd561k09mgeb9NAffee6vBJW182YHDLCbHKQUNJ7RC8KaPMlQn242KMBFqmfnDnoMK+EbSA6/UxSOeO34/YhLk2Im8It+bf74/Lh9WqBhakw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760196; c=relaxed/simple;
	bh=CjyHv2Xo02Ky3iBL7MJ3DnZ16ucdhlgmQ50S0J3M2Tg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DFWtJGIUj0yPdIIPU5NUBWYg1v60J6GFxf+TXNd0uQ+wsgYU/fFVXh2T+kwugnX00AjSkywBKneQrzAxzXY/bdwFeq0GBvXq+ewRyhERQoYcq2kNySYeyg8RxOYucxQQ89UID6hstLs7X1OETu5v/HG/tpG0cpBSnpTMvMZblh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=b9VLn/Jv; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="b9VLn/Jv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790760195; x=1822296195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CjyHv2Xo02Ky3iBL7MJ3DnZ16ucdhlgmQ50S0J3M2Tg=;
  b=b9VLn/Jv4uv7SEnhkfywHAKcwsJQXyrCwZf9NgAcG8Fu/52Rx66W4u+G
   hHSYKMo1nwfDDI9t6T7xGvItiP7/AHpQL+XW8rNobT9fo3/DEugG//E8L
   Q/9yhL2cCpJn2lKrUpiXgedzIbClliS3CeE9Rdv8qR4CtVWA7UgeAovtX
   7KOE5HZ6jANk9DXoVO5RZa/gxtsbpnkS9yyrAMuXlMwPOQVwkaD20qvcH
   nHPPooRMas+9rmubgAiWdXU4a0GToEa3sM0BQXw5MkVEQfmrjHA+Yru/h
   pOY2gASaQEBvHeytWB1f0pU5BFhcsZLLNt9AwhzVuInEGXSZxjj5RjOPj
   A==;
X-CSE-ConnectionGUID: iQMWRCAeTua1WhI9TM/+Rg==
X-CSE-MsgGUID: OWiXT+ahQHGhw9uy0tYOhw==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102020381"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102020381"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:23:15 -0700
X-CSE-ConnectionGUID: IPqJJQwTQDaVrhCN+DnEtA==
X-CSE-MsgGUID: ztAq+Vb8TZiJZvdmwc11kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275202797"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:23:13 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH iwlwifi-fixes 4/5] wifi: iwlwifi: mvm: don't send LARI_CONFIG_CHANGE to old FW
Date: Wed, 30 Sep 2026 12:25:06 +0300
Message-Id: <20260930122439.a23d894e48dc.I245ab48bfddddf51e5f2bd4dad7fb316f27b93f5@changeid>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930122439.f8a1ea3af242.I282fab02ab2f183633df0f070229fb5a2d5c9ec3@changeid>
References: <20260930122439.f8a1ea3af242.I282fab02ab2f183633df0f070229fb5a2d5c9ec3@changeid>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

Lari is not supported by 7260. The firmware doesn't understand this
command and crashes with BAD_COMMAND.
Devices 7260 / 3160 and 7265 that use -17.ucode are affected.
Don't sent it to firmwares that are too old to support this command.

Fixes: f5b1cb2e615f ("iwlwifi: acpi: evaluate dsm to enable 5.2 bands in Indonesia")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222030
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 43a7230f1ab4..e3503f01171a 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1553,6 +1553,9 @@ static void iwl_mvm_lari_cfg(struct iwl_mvm *mvm)
 	size_t cmd_size;
 	int ret;
 
+	if (mvm->fw->ucode_ver < 26)
+		return;
+
 	/*
 	 * LARI_CONFIG_CHANGE triggers a profile update, so send
 	 * LARI_CONFIG_EXTENSION first to make sure its data is applied
-- 
2.34.1

