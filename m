Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0766A40EB9E;
	Wed,  5 Aug 2026 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785926479; cv=none; b=LuCqjZqzpPtqVZY529NhvD+kNhLM7KWCQtHWLJy83/tfP7B8A/zJkM7nJ+tXBGPxApL9ba4YsSxNJFDmrltZ+4vscJJLvI0qqNgI85OZLYYaMiFT7UXNs5NpgW6ok1BdUfDxVskcFgAf+jEKKDheGUngRp5sJ/hYtORKHaUcUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785926479; c=relaxed/simple;
	bh=89qVP7+o+OEpBO0FxFFAcnhuSlKqq7Kl3P/mbViyo8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W9rGkBmbGxhVXpnG1TscBrHjYArsvUlJoUJSxRyUWbstl1xzggkRaiil0YvDpTvWYsyacPEZNjkMgXfQqch2q7xfGuNjgy9SCru2PHC9h8s3P/TxvHCVcWIoQgt1H4UaW3gAgeGV5iWuAL0r45mn+n4FCZE7LsZ5UyFgaPErLws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lS+BvDB3; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lS+BvDB3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785926477; x=1817462477;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=89qVP7+o+OEpBO0FxFFAcnhuSlKqq7Kl3P/mbViyo8A=;
  b=lS+BvDB3VsEroZK8qVk0/FIg0VXHlJ6Im8fcMZdZYW80/ETOTYpszjLd
   nx36TYVy7QCl2SnhjO7ImiBFlXt4ofBMOOYEwcOe6fuDg5z4J1toSClRo
   vd5kPp9howMUZC9BT0efy4X8jcfiu84MSlnuzK4XSpFnOG3y8RiPDKfIi
   aldQ2c+yFLZzQTPIa5CkVRj62Wwkr4WsdydaFImCCCRaxanbpJhbTXO+y
   0pWIOp8eX4X4IDNzHUsMwLTokR4d0alMm1lbHljq5KMgvWO6v9ieZlJ/H
   GJ7M4dZbwO8MWv3lU43HHx4vQRniRDMW5IbxxZtbyAr/1JN5auyZQ3fKK
   w==;
X-CSE-ConnectionGUID: ZsRDkO8RR4qoqTCFeHXrkg==
X-CSE-MsgGUID: qbySyt3ASuuY+bOm4i07pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97143811"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97143811"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:14 -0700
X-CSE-ConnectionGUID: 2eDHXOJJTkaemjrYrS/gEQ==
X-CSE-MsgGUID: mFGo5jQyQ4eipe035V+C9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265278522"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 03:41:12 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/5] ASoC: TI codecs: sort the reg_defaults tables
Date: Wed,  5 Aug 2026 13:41:44 +0300
Message-ID: <20260805104149.9795-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reg_defaults array of a regmap_config must be sorted by ascending
register address: regcache_lookup_reg() finds entries in it with
bsearch(), and regcache_init() only kmemdup_array()s the array, it never
sorts it.  See commit fd80df352ba1 ("regcache: Add support for sorting
defaults arrays").

When the array is not sorted, bsearch() descends into the wrong half and
a number of entries can never be found.  regcache_reg_needs_sync() then
cannot compare the cached value against the default and always reports
that a sync is needed, so those registers are written to the device on
every regcache_sync() even if they were never touched.

I found this while chasing a SoundWire NAK on an unimplemented register
and audited the reg_defaults tables in sound/ by replaying lib/bsearch.c
over each of them.  These are the affected TI/Burr-Brown codecs:

  pcm512x_reg_defaults    45 entries, 24 unreachable
  tas675x_reg_defaults    69 entries, 14 unreachable
  tas2552_reg_defs        21 entries,  7 unreachable
  tas2764_reg_defaults    11 entries,  1 unreachable
  tas2780_reg_defaults    10 entries,  1 unreachable

The patches only reorder the existing entries.  The text of every entry
is kept verbatim, no default value is changed, and each resulting table
was verified to be fully reachable.

tas2783-sdw was fixed separately, it had already been posted.

The series is based on broonie/for-linus.

Peter Ujfalusi (5):
  ASoC: pcm512x: sort the register default table
  ASoC: tas2552: sort the register default table
  ASoC: tas2764: sort the register default table
  ASoC: tas2780: sort the register default table
  ASoC: tas675x: sort the register default table

 sound/soc/codecs/pcm512x.c | 40 +++++++++++++++++++-------------------
 sound/soc/codecs/tas2552.c | 14 ++++++-------
 sound/soc/codecs/tas2764.c |  2 +-
 sound/soc/codecs/tas2780.c |  2 +-
 sound/soc/codecs/tas675x.c | 18 ++++++++---------
 5 files changed, 38 insertions(+), 38 deletions(-)

-- 
2.55.0

