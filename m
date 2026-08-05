Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01A30F957;
	Wed,  5 Aug 2026 09:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920528; cv=none; b=hACzd40hYXhaOhVsLmWW9J24cGY43f9mGDwroUIy5gwGDeASB0o4+vmLSF4yAC7aMeXe7KfTEWXw/b8hYwfgFynOrcVeU9F97kMqdZJIGABnsgLYG8FJUeUyNIeh3MnnrGB4Y+xorX4Ta4iRhlzbvK9tGqXy9dQO7Wcomhwwdb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920528; c=relaxed/simple;
	bh=/138Jw8vKQ575vs8RAjgYgBWiQPHy9EB140fM+gYqco=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H+tSqaenX6fICHXFTZDA6x7t+1NQ8UullPe1WaDchK8bap1cr1cCx1jwHdjReL5LZLn6u4O8AwKwifojKl1D6rCK/TFL2fwacC0s8k4Sn3u70e7cF7R2JRJPwE+NeY8ANNwyrQgQK0La6iQkV+xYs4XSIOtBpI/cBcVryTRPuXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X7ucMbbl; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X7ucMbbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785920527; x=1817456527;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/138Jw8vKQ575vs8RAjgYgBWiQPHy9EB140fM+gYqco=;
  b=X7ucMbblWVMlqhUTDGUEuIPa7LZsg89UctpAdOS/dTi1mJDsLOuRxNFQ
   7vBFlvftbyzL9PVzHqjDFFW1T2mJTZvX57IZTF4We78/ZkGAMuAV74k8o
   vbVACbnv1UcZ9ALkp5nCwa/KRh2QYrHiD0wglk+3YaSAU59oV1WVmsCDm
   0yBos8di1pxAvvczuGAdLanaOAKzTDNjMoKp2EqN7IH7RaDI7Fzu8uacK
   Cdy2JXeWrssqHBfKZ2QMuo6aRUv0UunFLfyjaEwGqcVmxn48VLqavnDNU
   1sdmqFKDgzjrvf8nQYrHMvAV2MBIGmZ0Hl1QZyMwChwOMY1nDrx0vgm1P
   w==;
X-CSE-ConnectionGUID: iLzvex2cTmiHm+/Lw1ivuw==
X-CSE-MsgGUID: H7pnKxioQ6+B1fiVXXOrGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="96842657"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="96842657"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:06 -0700
X-CSE-ConnectionGUID: AGJHDAH4S3GeYaY7FN5jmg==
X-CSE-MsgGUID: G1tG9Z56QBC9xDqT3W4SHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="261813945"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 02:02:03 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shuming Fan <shumingf@realtek.com>,
	Jack Yu <jack.yu@realtek.com>,
	Derek Fang <derek.fang@realtek.com>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 00/17] ASoC: Realtek codecs: sort the reg_defaults tables
Date: Wed,  5 Aug 2026 12:02:23 +0300
Message-ID: <20260805090240.16991-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

reg_defaults must be sorted by ascending register address as
regcache_lookup_reg() locates the entries in it with bsearch(), see commit
fd80df352ba1 ("regcache: Add support for sorting defaults arrays").

These tables have entries which are out of order, so the binary search does
not find part of them.  For those registers regcache_reg_needs_sync()
cannot compare the cached value against the default and reports that a sync
is needed, so they are written to the device on every regcache_sync() even
when they were never touched.

On a RT712-VA this is not silent: the MIC_ARRAY function does not exist on
that part, so the extra writes are NAKed by the codec and the bus driver
reports

  soundwire_intel.link.0: Msg ignored for Slave 6 (for addr: 0x8e00)

for every resume.  For the other tables the extra writes are accepted and
only cost bus bandwidth on every runtime resume.

The sorting patches only reorder the existing entries, the text of every
entry is kept verbatim and no default value is changed.  Each table was
verified by evaluating the register addresses and replaying lib/bsearch.c
on them.

Entries not reachable by the binary search, per table:

  rt274_reg                     7 (of 33)
  rt286_reg                     7 (of 39)
  rt298_reg                     7 (of 39)
  rt700_reg_defaults            6 (of 320)
  rt711_reg_defaults            5 (of 269)
  rt711_sdca_reg_defaults       1 (of 54)
  rt711_sdca_mbq_defaults       2 (of 25)
  rt712_sdca_dmic_reg_defaults  3 (of 42)
  rt712_sdca_reg_defaults       4 (of 19)
  rt715_reg_defaults           25 (of 323)
  rt715_reg_defaults_sdca       7 (of 78)
  rt715_mbq_reg_defaults_sdca   1 (of 32)
  rt721_sdca_reg_defaults      12 (of 41)
  rt1017_sdca_reg_defaults      4 (of 110)
  rt1316_reg_defaults           1 (of 47)
  rt1318_reg                    2 (of 142)
  rt1318_reg_defaults           3 (of 81)

rt700 and rt715-sdca also have entries listed twice, those are dropped in
separate patches first so that the sorting patches are pure reorders.

Found by an audit of all reg_defaults tables under sound/. Other codec
drivers have unsorted reg_defaults too, those are not addressed here.

Regards,
Peter

Peter Ujfalusi (17):
  ASoC: rt274: sort the register default table
  ASoC: rt286: sort the register default table
  ASoC: rt298: sort the register default table
  ASoC: rt700: drop duplicate reg_default entry
  ASoC: rt700: sort the register default table
  ASoC: rt711: sort the register default table
  ASoC: rt711-sdca: sort the register default tables
  ASoC: rt712-sdca-dmic: sort the register default table
  ASoC: rt712-sdca-sdw: sort the register default table
  ASoC: rt715: sort the register default table
  ASoC: rt715-sdca: drop duplicate reg_default entries
  ASoC: rt715-sdca: sort the register default tables
  ASoC: rt721-sdca-sdw: sort the register default table
  ASoC: rt1017-sdca-sdw: sort the register default table
  ASoC: rt1316-sdw: sort the register default table
  ASoC: rt1318: sort the register default table
  ASoC: rt1318-sdw: sort the register default table

 sound/soc/codecs/rt1017-sdca-sdw.h | 10 +++++-----
 sound/soc/codecs/rt1316-sdw.c      |  2 +-
 sound/soc/codecs/rt1318-sdw.c      |  2 +-
 sound/soc/codecs/rt1318.c          |  4 ++--
 sound/soc/codecs/rt274.c           |  8 ++++----
 sound/soc/codecs/rt286.c           | 12 +++++------
 sound/soc/codecs/rt298.c           | 12 +++++------
 sound/soc/codecs/rt700-sdw.h       | 11 +++++-----
 sound/soc/codecs/rt711-sdca-sdw.h  |  6 +++---
 sound/soc/codecs/rt711-sdw.h       | 10 +++++-----
 sound/soc/codecs/rt712-sdca-dmic.h |  6 ++++--
 sound/soc/codecs/rt712-sdca-sdw.h  | 11 +++++-----
 sound/soc/codecs/rt715-sdca-sdw.h  | 12 ++++-------
 sound/soc/codecs/rt715-sdw.h       | 32 +++++++++++++++---------------
 sound/soc/codecs/rt721-sdca-sdw.h  | 28 +++++++++++++-------------
 15 files changed, 82 insertions(+), 84 deletions(-)


base-commit: 05eebef3c7b2e8595fdd1bd46912aac9c1de8587
-- 
2.55.0

