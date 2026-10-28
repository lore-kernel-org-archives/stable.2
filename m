Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171651;
	b=BQizNU5RX3LO6diVrXsie+4wElAYpraPvQED89WwRHQ+y1pVewyYZv5Gjo8ADdxZNAXM
	 SdUgLDHoc9x80lz1PzFmdfjHZm1JaFi9C3G0t9keZb4Ssjx0mX5n84mOOSfS45WFA4uGs
	 P+0KBUnfIkbRJ+NmAGU9wlvIVwcfTOWPGtfM7e9r9zdM47eR8JG+fyfzJoKoQ6yJSDgn5
	 wVDIhPcx0f3Bfw2IZrvI9I/3/Q6ZCi8FIe2DBzIj60G/hzd1O6hmnxK10Ihc7n3efhk8S
	 JKKcIwQcVc/o4BPRJ4BODvB/8bPsr7qxETmbNs/R7V3CJS7fAF7dBRIQUZ2pdunEspA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171651;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FDvougpXx2osKEvDtAuIH73gGTCBv49/uNek5kST7d8=;
	b=kiAXGEcZAslOr5shpt6cZzR25tYOcOMlU7pjIir2aXvxqYvHzyIcB+CV7I/zYCd2qsQZ
	 8Ez0erj5GTJma+UoDnuG6HCLHyPRHImuI1tBlF5ozFb3GFsOIAHjGEtxBRwM0AECUX/Vy
	 KHSCDRJV7qPr7uHOT0/JjoeQyo9GWFhLjYsoZH1/rnH5zZP0WKbYhEvkM+maFFjmUkMtW
	 0AQqaS2qqWeZyDEmQzwCFgJT8993cWhBLDScze0nJaO96lBi7LCYFRNO7lxcaySLhySN2
	 eNNgzVaz9sqL6m6gAquxcECOf/PHlEPCBWK0UIrwXk2hsRlVgq53e+6/HMXETAH8s1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H5pi78hR;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D34606A329
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D34606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=H5pi78hR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793171650; x=1824707650;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SqKllC9jgTnkqxdWg2PSU/JgGUPmz4G2mSjflupGQY8=;
  b=H5pi78hR2d9IgnZgEYcrl2yugT/IqW3i6nrsexQxZcrq6timvXxtMFgU
   81tKre949TAdSlxhQRjkyo2dHydmnHrq0rXuXlDcRsFiJqefClN5iT5mb
   19GhyZMg2qz2Eq5sglPkxYBp/ALXMM2FCl4mDAsO0sg4rveaz/rJEfQu1
   8gbKzpl40iHLxeStQtqI39yLYFerkwQCMB90hEYLh1hS09weMi2BYkSx2
   jtMg18xX3lxJI4rOQK1VWV4DseFrUqecY/I9bv5xeN2I9Jp9+TDpjwejA
   TzxKG3UEDpn0rJ2rMKcyNTyzABDB+kIqfzgWZtJIcxQ97a8eTQl2bQ0KP
   Q==;
X-CSE-ConnectionGUID: /ugmYGn8T6aEcb9z5enOyA==
X-CSE-MsgGUID: /q4lpQr7RgeRo+/PkFqnyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1765951"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1765951"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:14:09 -0700
X-CSE-ConnectionGUID: 3K9x5UX3Rwaj2kFGYhvT5Q==
X-CSE-MsgGUID: 5r22pNxXRACSwssw/SCSfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4868263"
Received: from vsrini4-xps-8920.iind.intel.com ([10.223.167.75])
  by fmviesa002.fm.intel.com with ESMTP; 28 Oct 2026 00:14:01 -0700
From: Vidya Srinivas <vidya.srinivas@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	uma.shankar@intel.com,
	jani.nikula@linux.intel.com,
	Vidya Srinivas <vidya.srinivas@intel.com>
Subject: [PATCH v4 0/2] drm/i915/display: Limit scaler count and disable pipe joiner on WCL
Date: Wed, 28 Oct 2026 12:34:02 +0530
Message-ID: <20261028070404.1913843-1-vidya.srinivas@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261007072334.1801956-1-vidya.srinivas@intel.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pipe joining is not supported in the WCL display configuration.
Modes that would require joining are rejected, matching the
4k 60Hz maximum resolution documented for the platform.

Also, WCL supports a single pipe scaler instead of two.

Vidya Srinivas (2):
  drm/i915/display: Single scaler per pipe on WCL
  drm/i915/display: Disable pipe joiner on WCL

 drivers/gpu/drm/i915/display/intel_display_device.c | 5 ++++-
 drivers/gpu/drm/i915/display/intel_dp.c             | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

-- 
2.45.2

