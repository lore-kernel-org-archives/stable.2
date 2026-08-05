Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524BC3E2771;
	Wed,  5 Aug 2026 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932857; cv=none; b=FNc+aJCT+UnSOgc2Zpzh61IgJgOCSnRbtsanJdn8Uhr1EbbsaXWYnwj8CTRXjDayzEpjGivfcByi0UuB8KPZEjApE4/iXUVyuf4dwBzw9aYOl+cZacJNTGV9mKgaoQzjONXKSKH6+ReepE+6KSmqgXQBIQc4NSvLQ1OXnscnqgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932857; c=relaxed/simple;
	bh=zDPVTFjlruS0YRzvckBKotu7R9XKqeDkjfqiJ83H+rA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmvGE7Ug9DRQ5sU67M99BMnu1AlJASGO65HoCgoQfBQZ/zduB/vxdQ+wp9rPOZ0SSsgkrZXzQSL+TqZQyR1/vByiacIeceQmyu3ndigdcNZP7XTSmH30T9BDg6U70SeNvxQRJKch935ilcKyttpfcTXxz4jB94ui7O2yjxRu6go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X2O+DJQg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X2O+DJQg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785932856; x=1817468856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zDPVTFjlruS0YRzvckBKotu7R9XKqeDkjfqiJ83H+rA=;
  b=X2O+DJQg5roUjp3dIVpCzmMlEEJPPoQfFekC8TtK5cBTXd8LHQD4diG7
   8MAXeLZ4nDVtzRT2CIRA6hO/+dFRxGUnkBMZh/NejDq3ufv3HVyqIUW76
   TzERaOkemfqRTRU2N3E0WospLGEOGmNzzBF1gCzz2AbbTe++k2mvz2FS+
   qS950X2x+W4RI1JnfB4eOSaCKxGYe9uw0SEUkALheEaB/jDRAMqdHhmK5
   oVm9joaXdHkob7INJSW41hv+C+jX7OnQMD3nlvAVdu//lSZILEyCbCXyG
   /lbgyooJvciMZOQ2EPBdVxQVecaoLihz18heu65L7Sobo8S2BQK1o+6Hk
   Q==;
X-CSE-ConnectionGUID: L48+FdzMThm4J3rZhzkmqw==
X-CSE-MsgGUID: +roNZ4/TQ26rZPrEIA0KFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97098724"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="97098724"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:13 -0700
X-CSE-ConnectionGUID: tQA4xz+mRVSgEOVcpPdBtw==
X-CSE-MsgGUID: Cc4KjLaRQKSl4AFvzRGhDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; 
   d="scan'208";a="265296068"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.246.218])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2026 05:27:11 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sheetal <sheetal@nvidia.com>
Cc: linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/3] ASoC: tegra: sort the reg_defaults tables
Date: Wed,  5 Aug 2026 15:27:45 +0300
Message-ID: <20260805122748.13090-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


reg_defaults must be sorted by ascending register address, since
regcache_lookup_reg() locates entries in it with bsearch().  When a table is
not sorted, bsearch() cannot find the entries which follow a descending step,
so regcache_reg_needs_sync() falls back to reporting that a sync is needed for
them.  Those registers are then written to the device on every regcache_sync()
even when they were never touched.

See commit fd80df352ba1 ("regcache: Add support for sorting defaults arrays")
for the same problem in a different context.

The series is based on broonie/for-linus (05eebef3c7b2).

Affected tables:
  tegra210_i2s_reg_defaults     2 of 8 entries unreachable
  tegra264_i2s_reg_defaults     4 of 9 entries unreachable
  tegra210_mixer_reg_defaults   1 entry unreachable

Peter Ujfalusi (3):
  ASoC: tegra210_i2s: sort the register default table
  ASoC: tegra210_i2s: sort the Tegra264 register default table
  ASoC: tegra210_mixer: sort the register default table

 sound/soc/tegra/tegra210_i2s.c   | 8 ++++----
 sound/soc/tegra/tegra210_mixer.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.55.0

