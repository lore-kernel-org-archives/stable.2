Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A88282F1C;
	Tue,  9 Jun 2026 08:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994092; cv=none; b=GR4n2mGbKsqjyoXQvoqBz60wfj4ZyRqHiAp74aTTy/morbHJXiUikl8Y8wpWZ4iNltwbS8f5P+VlORF0ysv+1rB7gEgsadprIALFrfdsoiZI0NCR1TJCmTMbjxwZgFBJTrW2UCDFN6lUPnlDry+O2HslDx0o37HJJMsPUCDfLGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994092; c=relaxed/simple;
	bh=ulFiS+uxq1jUcroAqoQgN0YZJut4XLWAYBUq1gB4/rc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8AR8HUubwaAYuuJd1aTXo23GPzFmyDthY1MyTUlQi3RlBw9G6VADJ959owEnen0LvUQBbPJkzCfUflaObJTcBJhdEO2LSlrhphGckXI3aJbGPLI18Enza0hKoFq7ED2+QMFe6uZWjSmrXW2cR1HUOmyhZB/z9J17hhAFEfWyZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HrfvxKaI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HrfvxKaI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780994091; x=1812530091;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ulFiS+uxq1jUcroAqoQgN0YZJut4XLWAYBUq1gB4/rc=;
  b=HrfvxKaITi5g+nJDeLFxQNfs7PXbObf8vMrsARxSESM4KgYn4QUaBYBk
   QfTaw5xI83+WO0mx55lst3GeSlEqcp/L57WuCu3xIwFPsCuLGVCgpTz+e
   dSWbzVxkjmXt/iQRt9xLjpPafLR03v1ZCax32VzfknsoualLaNGMDJOwr
   SYXiqhiVpDkHR1hcK3m6Br1pRDU0sGPaVzuFrzn/WMMoLuBCDG1Ifwc1i
   eLYpo6/oW1wXyGWok9b7LnuBzkcAGqvb4kqd9Arbwi95RsWFMSy7+MzbL
   9gOk2sLYy7+LKkQ6DORIYgk3QLnxEBzkagJNMIiww1ccUxDXN9dQriRns
   w==;
X-CSE-ConnectionGUID: WQ271N/kTzqOojz9I1J4Vg==
X-CSE-MsgGUID: kjCdJmYbT06/0nubTMtizg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93235415"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="93235415"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:34:50 -0700
X-CSE-ConnectionGUID: /kwyjwSVQ9yzpf6HcfiGgA==
X-CSE-MsgGUID: rpw8K34JQqGEjVz8Hfi+wA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="245650055"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.253])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 01:34:48 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: linux-sound@vger.kernel.org,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.dev,
	liam.r.girdwood@intel.com,
	stable@vger.kernel.org
Subject: [PATCH 0/6] ASoC: SOF: ipc3/ipc4-control: harden kcontrol payload handling
Date: Tue,  9 Jun 2026 11:34:52 +0300
Message-ID: <20260609083458.31193-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series hardens SOF kcontrol data paths for both IPC3 and IPC4 by
fixing size-handling bugs in put/get/update flows and tightening bounds
checks around firmware/user-provided payload lengths.

The changes include:

Fix TOCTOU-style size misuse in IPC3/IPC4 bytes put paths by validating and
using the incoming payload size.
Add notification/update payload size validation before parsing control data.
Use overflow-checked arithmetic when computing expected IPC3 control sizes.
Ensure update/copy bounds are validated against actual allocation limits.
Fix IPC3 bytes_ext bounds checks to account for struct header offset, closing
a heap overflow/over-read issue from unprivileged userspace TLV access.
Overall, the series makes control payload processing robust against malformed or
inconsistent sizes and prevents out-of-bounds accesses.

Regards,
Peter
---
Peter Ujfalusi (6):
  ASoC: SOF: ipc4-control: Fix TOCTOU in sof_ipc4_bytes_put
  ASoC: SOF: ipc4-control: Validate notification payload size
  ASoC: SOF: ipc3-control: Use overflow checks in control_update size
    calc
  ASoC: SOF: ipc3-control: Validate size in snd_sof_update_control
  ASoC: SOF: ipc3-control: Fix TOCTOU in bytes_put and bytes_get
  ASoC: SOF: ipc3-control: Fix heap overflow in bytes_ext put/get

 sound/soc/sof/ipc3-control.c | 79 +++++++++++++++++++++++++++---------
 sound/soc/sof/ipc4-control.c | 34 ++++++++++++++--
 2 files changed, 90 insertions(+), 23 deletions(-)

-- 
2.54.0

