Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F0747F2C2
	for <stable@vger.kernel.org>; Fri,  2 Oct 2026 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790936618; cv=none; b=fZvAaIpaLyi8ZaLG457faQ7Fm0+VPz2lH9cMxeH9Zv4qQb3PvHNtef0MKcNsuI0nfVPupK5oJM5FZcbzIAMPkSvUoGdpbJnO6dp4UCbsXKkdO5cZU6UexB0MI4GhMe0xh2IqbptxBrIdTTF0hUBcN7DgFKcxl6HD7mmyS3eYUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790936618; c=relaxed/simple;
	bh=9I6Ir7dX3dZE9FPtDYyxmN0iT8pb+ijL7w50qmA3NKw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=mn/d1H5LLfxYAWSexgZh7VeB6KEwR/gwqQcL6u5A1P0JoGymJ6sg4cMY9faTT7bEqhPecNYyxCanf/+oBmsNR0UCPXi7lH21d0/RWWLFqbDbDh+yfIcduTtcCqEKD54ZeddCGDBHO0Mmp7/aKsM/H/8Wii32aUfKKrPaUdlEY/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VM0Ip+hq; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VM0Ip+hq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790936618; x=1822472618;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9I6Ir7dX3dZE9FPtDYyxmN0iT8pb+ijL7w50qmA3NKw=;
  b=VM0Ip+hq0LlXKxKbAis7YNAsMiVAdOs6532RiwUXXewrQImFFdwClRtR
   ecBtryNJ1OVFAU91K6XJntcKpnPovYL6gjBrrfW1K8F72U/L/zu8lthD3
   NmhbA9BzVly8kjT5UXW1LNfl+dqnpLMMGC8G5sF/wR8brCQbFIE/A6hxA
   o3ZRc9+zHZSGTvwSPPdwmaS7ZfPHOi/OnEkyLvJOvIaj+GAx++cErKRpP
   XQz5YWhndHHEO+F3HOh064lAhUBMwnGNR/K9l/RMOzTkWoWQLGldSJncm
   reQwE6V+EfcC+Gb6pVkDqDMDSvdTrxZyh/sHG8KsAwq/vCFO12ehl3svH
   Q==;
X-CSE-ConnectionGUID: uKIEaxfFQIuflBG7GHSlsA==
X-CSE-MsgGUID: RH1jidqiR/Cont2mMP1wxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="101864386"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="101864386"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:23:37 -0700
X-CSE-ConnectionGUID: sjA6TYstTIqHSdNDproGBw==
X-CSE-MsgGUID: 1GkYFy82RUmgUhyppdMI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="302475335"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.171])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2026 03:23:35 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: stable@vger.kernel.org
Subject: [PATCH stable v6.12 backport 0/2] ASoC: SOF: ipc4/Intel: Library restore firmware functionality
Date: Fri,  2 Oct 2026 13:23:51 +0300
Message-ID: <20261002102353.26919-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Please pick/apply the following patches from mainline to v6.12 stable:
cec49fa47bcc ("ASoC: SOF: ipc4-priv: Add kernel doc for fw_context_save of sof_ipc4_fw_data")
ace9b3daf2b4 ("ASoC: SOF: ipc4/Intel: Add support for library restore firmware functionality")

They apply cleanly and are available since v6.17

Discussion link (user facing the issue on 6.16):
https://github.com/thesofproject/sof/issues/11229

In theory v6.12 could be used on Lunar Lake hardware where the issue happens.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: SOF: ipc4-priv: Add kernel doc for fw_context_save of
    sof_ipc4_fw_data
  ASoC: SOF: ipc4/Intel: Add support for library restore firmware
    functionality

 include/sound/sof/ipc4/header.h  |  2 ++
 sound/soc/sof/intel/hda-loader.c |  7 +++++--
 sound/soc/sof/ipc4-loader.c      |  6 ++++++
 sound/soc/sof/ipc4-priv.h        |  3 +++
 sound/soc/sof/ipc4.c             | 14 ++++++++++++--
 5 files changed, 28 insertions(+), 4 deletions(-)

-- 
2.55.0

