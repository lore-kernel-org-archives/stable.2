Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC947D442;
	Tue, 11 Aug 2026 22:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786486899; cv=none; b=Nj5IFeUggWRrkVO+96rrCE8xbt3r/wvw8/MZyQsqy2zmuXxrwqabqdO4NoSCML5QrFI5swjD2EX4x+hdm7iMPNUfHhPDbVZPSyxckaL7xKsvAimLmoFrEkXKstR2qtACttrdTpJtbFkgmATvde/yGsXPF4Q6ygbvFRifvJbqOeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786486899; c=relaxed/simple;
	bh=ilam4oTb4r4c8Bgf5KH/L8PX3CIIhttRIlosf0InKqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T7JjAWjpnDDhaRxo9Q5zhfK5hT8mLXKstq9/v9eJe/AveeH/ntjRNvCN3YF9GMh8OQgHhIaKTojG3AnPClf2VoKfXtPgXs1ftl4zywCXMXvXIb6f9URvuEHbYK6CGsD0MDvIs3j60pb3/iyUyIdBpTCvOyVUN3tcqh8mARR9qHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MNJvxh67; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MNJvxh67"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786486898; x=1818022898;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ilam4oTb4r4c8Bgf5KH/L8PX3CIIhttRIlosf0InKqo=;
  b=MNJvxh676Rs2M4bJfyHGcl2uT2mUjvnlb3ifhtygDki91UmoWzthV8KA
   6nwbTaRxhutsFNDVDeUOA8AH6B7ElNB3Hwbk3tQgmlvZRXTp1iStiJtym
   B5fjouPJMxT28FzLEBa4wczIPI6vSxkuP9HTNonWztuMx4o2kay7BWnPB
   jUu5dtKSkAxViVKa47lIY+LTY+UVG4ufhnWuL3KeYQDz8+bDHX+bUFg1e
   unTxf22nLhiYKfU/epi6droxKaKXdkeob9vkyiZWlz4QD7HJ3BN8Vyuiu
   p69IjgVZXzs/XvkJ+jksqQ7U0bIkk2wZG7UO0lWWo+Znv9T3zIQIVW/4R
   A==;
X-CSE-ConnectionGUID: VwCbaDGlRayFblRLqw8qnw==
X-CSE-MsgGUID: gcBk6khoQWiVCCOqmRUcIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11872"; a="87041818"
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="87041818"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 15:21:36 -0700
X-CSE-ConnectionGUID: 2mtCp6xJSEeIRiV6dn8ngg==
X-CSE-MsgGUID: 23iEovgjRbaSMOLv5CtLfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,218,1779174000"; 
   d="scan'208";a="259189857"
Received: from spandruv-desk.jf.intel.com ([10.54.55.20])
  by fmviesa006.fm.intel.com with ESMTP; 11 Aug 2026 15:21:36 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sammiee5311@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] platform/x86: ISST: Add a NULL check for sst_inst[]
Date: Tue, 11 Aug 2026 15:21:34 -0700
Message-ID: <20260811222134.3912626-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260811222134.3912626-1-srinivas.pandruvada@linux.intel.com>
References: <20260811222134.3912626-1-srinivas.pandruvada@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

To be consistent with other places, add a NULL check for failed socket
loading by checking isst_common.sst_inst[].

Fixes: d805456c712f ("platform/x86: ISST: Enumerate TPMI SST and create framework")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
index 68c3a06004eb..e6d370907c01 100644
--- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
+++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
@@ -1433,6 +1433,8 @@ static int isst_if_get_tpmi_instance_count(void __user *argp)
 		return -EINVAL;
 
 	sst_inst = isst_common.sst_inst[tpmi_inst.socket_id];
+	if (!sst_inst)
+		return -EINVAL;
 
 	tpmi_inst.count = isst_instance_count(sst_inst);
 
-- 
2.55.0

