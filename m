Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FAD3EDAC9;
	Tue,  4 Aug 2026 22:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785882146; cv=none; b=NjJo8dBz9gZonwy//o3+VwZYKT+L0To3XsljlhxM26kt62Qls3QXW1hgpvFkH6GhxCfIDfVHfvu23IKPpnK8kMWRODMspXzL/PJtG0hZcTnxwne6VGML1bI33+I4jNCfxVEXZAl2GXqwmp/gyNOd7UAZoRyAZWs0aEumlVBoJOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785882146; c=relaxed/simple;
	bh=yKwZ56JR7d804mFiMT2heg4siLo1MPyS54AZOxJWQyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ihhh/KuyuH90fscD/WgpuxVOXnMNJJYRMFr9+j+D9WViWK5YsDwcq014S1ZBdXQYVw3z9OKr8A43NqdpuXthCHJ5yZ4AuEpguqBcOs0F2t71OaReALwgN/BJpEUPHWyfhxjvtGK0JPP7oyU8Vh04+uhndZacny4Nna47t3wgyGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GlR+p0Sa; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GlR+p0Sa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785882145; x=1817418145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yKwZ56JR7d804mFiMT2heg4siLo1MPyS54AZOxJWQyQ=;
  b=GlR+p0SaH3RxdKZ/j2YIPoPhrupMZdCIJatyqGHXJkF2P0yxeEZTApVn
   VOfTvDhGWNVTM9tiYeY7Wj3c/NiUaHHDZvijQ9fNCqedUPT5YxEc9juMT
   QDYKZMstCKwNnkxPzrly3FpnW4wjJ50jImvqJacyx/qXiK77wQnVJKXRQ
   /Y8tR1WY2fOXMSwOw0JSOOHqt6+QPWAOjUPrTIt8oYG8mfLi70TLNMsxZ
   KEsEngSxISjMrI6jwf/i+pTnrjHCMzzmnoLvdjvXx2SdUHk1gWrRq0Ffk
   /lrUNjEZup+I307UAZU1zzUSARcW0q67yDH1bBQazwCfyR3aYpS3HWTYS
   w==;
X-CSE-ConnectionGUID: 7Nd/K/BuTc2RmTqbK3O7YA==
X-CSE-MsgGUID: s1OteW7cStKYS5WlZiQsJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96803452"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="96803452"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 15:22:21 -0700
X-CSE-ConnectionGUID: guOoDLwuRSGshuYNzQv1yA==
X-CSE-MsgGUID: C4iw56jXQ5uiJjKBcrgUUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="257308003"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa006.fm.intel.com with ESMTP; 04 Aug 2026 15:22:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Aaron Esau <aaron1esau@gmail.com>,
	anthony.l.nguyen@intel.com,
	arkadiusz.kubalewski@intel.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: [PATCH net 08/10] i40e: fix memcmp of pointer in i40e_hw_set_dcb_config()
Date: Tue,  4 Aug 2026 15:22:01 -0700
Message-ID: <20260804222205.1580328-9-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aaron Esau <aaron1esau@gmail.com>

In i40e_hw_set_dcb_config(), both new_cfg and old_cfg are pointers to
struct i40e_dcbx_config, so sizeof(new_cfg) evaluates to the size of a
pointer (8 bytes on 64-bit) rather than the size of the struct. Likewise,
&new_cfg and &old_cfg are the addresses of the pointer variables on the
stack, not the addresses of the actual config structs.

As a result, the memcmp never compares the actual configuration data,
meaning the "no change needed" early return never fires. Every call to
this function performs a full DCB reconfiguration (quiescing all VSIs,
reprogramming via "Set LLDP MIB" AQC, and reconfiguring VEB/VSIs) even
when the configuration has not changed.

Fix this by comparing the structs themselves rather than the pointers.

Fixes: 4b208eaa8078 ("i40e: Add init and default config of software based DCB")
Cc: stable@vger.kernel.org
Signed-off-by: Aaron Esau <aaron1esau@gmail.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a04683004a56..0ac1be6289f6 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -6907,7 +6907,7 @@ static int i40e_hw_set_dcb_config(struct i40e_pf *pf,
 	int ret;
 
 	/* Check if need reconfiguration */
-	if (!memcmp(&new_cfg, &old_cfg, sizeof(new_cfg))) {
+	if (!memcmp(new_cfg, old_cfg, sizeof(*new_cfg))) {
 		dev_dbg(&pf->pdev->dev, "No Change in DCB Config required.\n");
 		return 0;
 	}
-- 
2.47.1

