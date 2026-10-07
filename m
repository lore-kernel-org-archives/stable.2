Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA874AD4CC;
	Wed,  7 Oct 2026 13:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791379511; cv=none; b=hNoO4nVrgwnz57dOVpK38jX8bczbctLUUjJ2mLqC/PUddi/9DuuZc8WYHdZKEmUXpmGtyrkSOUXEMDPD3YAJEO9duELG0N+nSyOAaOZKZFH8yYCGrTC3rSabP9sSR8Tj5+fosgqo7oFk7W7GM7m9p0er7VOiBM+4d3dT68+JgEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791379511; c=relaxed/simple;
	bh=g2g5jfO68Nk2/jkByE2jdA96084dNfiolacGZbXAkD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XBCDk1uM5TGjmcDnN8cism92yWq2tLFHIpRxs0vSUDMG0YsmPdLyNIghQNhdSPiPTNI0iNf7xWWKZfkw9aDKAeNcSX7lvqJP+q7vcDw3h9q5Fq3kXgfiGcL+6mOgCeD9FhL+7e91T06SSjO80x4EUqoICAOkWgK/3hwfgN2EJ+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a3MkWZuj; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a3MkWZuj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791379491; x=1822915491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=g2g5jfO68Nk2/jkByE2jdA96084dNfiolacGZbXAkD8=;
  b=a3MkWZujvNS4qt6pxSU0etihVy2eS0x26PfjxFADQ1MDc2T0cI5pXd2J
   gKclSOH0NAMo2WvYV70F3G7bhQhIEkD4kVQvBvSAAuKlfLbibwyXjIGXl
   9v+xdse+tvYEZbUKq1rqxy3cA4hvvYekvSFigUAg5sd3q2Bbi+hPfrWPg
   I3E2aNsMgMBsYkYgdFvbH3ji4BTd/344E1G+ziNfqnUff9ADWs3XEiz9j
   pKlwZYsWl+sh8gZBZjBSvWTMN2/0i0iuiRRNEDwm3zgjjPjQAv7NuUcq8
   Oj0HABx5kQxA4wD16G89muKfaItfEm6+e+kRzlvUliD26721Bh7TZR4Cz
   A==;
X-CSE-ConnectionGUID: ceWfgE65RdiaGQxMDO4zdA==
X-CSE-MsgGUID: r/LLYANVTN+F3+kaLrRThw==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="39753"
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="39753"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:50 -0700
X-CSE-ConnectionGUID: VXPm+M2vQJy309fDgtXmZg==
X-CSE-MsgGUID: H0CF7OAeTwu862GzZl5tkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,144,1787036400"; 
   d="scan'208";a="305434447"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO pujfalus-desk.intel.com) ([10.245.244.188])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2026 06:24:49 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: vkoul@kernel.org,
	perex@perex.cz,
	tiwai@suse.com
Cc: pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 0/4] ALSA: compress: fix buffer handling and state validation
Date: Wed,  7 Oct 2026 16:25:05 +0300
Message-ID: <20261007132509.18237-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

The compress offload core has several edge cases in buffer management
and state validation.

Repeated SET_PARAMS while a stream is OPEN can replace a framework-owned
buffer without freeing it. During gapless playback, SET_PARAMS can also
change the buffer geometry while the byte counters still refer to the
previous buffer. Separately, SET_METADATA can reach the driver before
SET_PARAMS, and the origin_seqno task lookup can restart a task that is
still ACTIVE.

Address these cases by:
- freeing a prior framework-owned buffer before replacing it;
- rejecting buffer geometry changes on the gapless next_track path;
- rejecting SET_METADATA while the stream is OPEN; and
- allowing origin_seqno to reuse IDLE or FINISHED tasks, but not ACTIVE
  ones.

Regards,
Peter
---
Peter Ujfalusi (4):
  ALSA: compress: fix buffer leak on repeated SET_PARAMS
  ALSA: compress: reject buffer geometry change on gapless next_track
  ALSA: compress: add missing OPEN-state gate to SET_METADATA
  ALSA: compress: reject restarting an ACTIVE task via origin_seqno

 sound/core/compress_offload.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

-- 
2.56.0

