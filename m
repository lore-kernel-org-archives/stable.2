Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02867479862;
	Wed, 30 Sep 2026 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760198; cv=none; b=LJKSahOGhqvVjiNd1TySB4VbKYn+cCvzh2ipGOe5p0+cMVwiYkMR1siLZYdBsU/hbFmcuLwLQnFZwCmWs8KKLkYnFXHIZ0Byfar9l9TsDTexh9M59ewq30C9evkoAOvPTThK5kc0AY4xRyfeemFunr2nGYkj8SUDPZ6CBCBVPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760198; c=relaxed/simple;
	bh=Mo0ozK2toom/+IoL8b8z9I/pnPqqUbQ+h08FWCN+Nz8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HQGYVSfM/CTDR+5e6YV1I0yi+8tI8KM97Jxu2BZglnEa3bQ0I4kJLXcVf+Z5dT01cjGuh3SdiWdwR8ABWw4EwkDJsD2xJ35hKnpx3LYKvVM/VEHrQ3hbLTCyMMipCMvYMNXUwHb+q8Grv35h8ONbgVw325NI3FC8YSQ3Mj+YHP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fpjdw8Fp; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fpjdw8Fp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790760197; x=1822296197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Mo0ozK2toom/+IoL8b8z9I/pnPqqUbQ+h08FWCN+Nz8=;
  b=fpjdw8FpzEok5lqzfXRXIEb/4Dzdyy+jnoP99Kda3FKnhyFbvzI3oWHZ
   nd/Ppwuig+MP/T4LFGv+OqL4vRxJzkffVZu1Vbt2/BbwMC2WeRMuV1CSH
   JVI/QRTkAoHDVuk7UOywVbsbpUJflXcNvKbU/X3UWVcIZdC30eCKtFFoO
   tmSYbT7hl78vSx1VmbSY+wS0vaoLZ4FN083BzB5mNotRp/+72e8YHRzrc
   NOHAl30gtc6vkyXbEFHpvTd1WvGX9PWcPPORCPsIgvNt0uRkNtGLGsFU1
   YmmhcTfjWzsVvxDQB8PcbGTiJ9ddl8lCbvbGk3ekggmeApH3w6n4DR1ox
   w==;
X-CSE-ConnectionGUID: rcfCXPatSCq48M7kz/T6VA==
X-CSE-MsgGUID: HWAX6ZlzTYeD3KMX6z+jfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="102020385"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="102020385"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:23:17 -0700
X-CSE-ConnectionGUID: dzjfWPVUQiu86d9zV+tvgw==
X-CSE-MsgGUID: TjZDkk3LTOO7erQ5d0rV6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275202818"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 02:23:14 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	stable@vger.kernel.org,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH iwlwifi-fixes 5/5] wifi: iwlwifi: mvm: fix VHT NSS reporting on pre-MQ devices
Date: Wed, 30 Sep 2026 12:25:07 +0300
Message-Id: <20260930122439.67a780de1fc6.Ia9429e120ea269c781a36d5fa2fe601c7deb1a39@changeid>
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

iwl_mvm_rx_rx_mpdu() and iwl_mvm_rx_handle_tcm() parse the rate_n_flags
they get from struct iwl_rx_phy_info, which is in the version 1 format.
There, the number of spatial streams minus one is encoded in bits 4-5,
i.e. RATE_VHT_MCS_NSS_MSK, but both of them used RATE_MCS_NSS_MSK.

This used to work by accident: RATE_MCS_NSS_MSK was BIT(4), which
overlaps the low bit of the version 1 field, and that is enough for our
2x2 devices. Since the version 3 rate format was introduced,
RATE_MCS_NSS_MSK is BIT(5), which is always 0 in a version 1 rate, so
every received VHT frame is now reported as single stream.

On an 8260 this shows up as half the actual rate being reported:

	rx bitrate: 390.0 MBit/s VHT-MCS 8 80MHz short GI VHT-NSS 1

instead of 780.0 MBit/s with VHT-NSS 2.

Devices using the multi-queue RX path are not affected, they convert the
rate to the version 3 format before parsing it.

Fixes: 3592c0083fb2 ("wifi: iwlwifi: mvm: fix beacon template/fixed rate")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221685
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index ab1eb2eb0c3c..59dbbdd4aa35 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -257,7 +257,7 @@ static void iwl_mvm_rx_handle_tcm(struct iwl_mvm *mvm,
 				ARRAY_SIZE(thresh_tpt)))
 			return;
 		thr = thresh_tpt[rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK];
-		thr *= 1 + FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags);
+		thr *= 1 + FIELD_GET(RATE_VHT_MCS_NSS_MSK, rate_n_flags);
 	}
 
 	thr <<= ((rate_n_flags & RATE_MCS_CHAN_WIDTH_MSK_V1) >>
@@ -502,7 +502,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 		u8 stbc = (rate_n_flags & RATE_MCS_STBC_MSK) >>
 				RATE_MCS_STBC_POS;
 		rx_status->nss =
-			FIELD_GET(RATE_MCS_NSS_MSK, rate_n_flags) + 1;
+			FIELD_GET(RATE_VHT_MCS_NSS_MSK, rate_n_flags) + 1;
 		rx_status->rate_idx = rate_n_flags & RATE_VHT_MCS_RATE_CODE_MSK;
 		rx_status->encoding = RX_ENC_VHT;
 		rx_status->enc_flags |= stbc << RX_ENC_FLAG_STBC_SHIFT;
-- 
2.34.1

