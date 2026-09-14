Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3E4416878;
	Mon, 14 Sep 2026 08:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789376319; cv=none; b=fWVoycmYXX9uhXWJygFbynkdXGSHviiApv2v0xMMAYjwpOH6BMG+0Ve+eHacvsUt92ZKdirKnZb5JP7EwHz3Y1f2xIQdeD4t3rDKQ4zWfzc9unpgWhY6pyefgyGZq5oyhSdagdtwqId+6Vy09Msnfj4J5PwoWpeMl7G4hqW5uHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789376319; c=relaxed/simple;
	bh=JeE+tY6GYgFDHEhWkOf22mR2pY6MuJp9GJvQBuOjXVY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H8eF+Qe0zv5Zz/HbWccKpV71I8DL4sEYO6cr4ESHptY4/bRWyqrcgHXo9wpF4rLl1AbW6XR35tpz0ktIAf6rSEsrd2XPSzMWngNpm3NUBKoafvks9ZGKVRIkS3Kwv1tXNqq78xT0x8kGJ8yJXU0zE650R46E2I4jjtRH0TRoDYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVSFbG8g; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVSFbG8g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789376316; x=1820912316;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JeE+tY6GYgFDHEhWkOf22mR2pY6MuJp9GJvQBuOjXVY=;
  b=DVSFbG8gNRf4k4S5onyTZ9ZbezGey6GRIfgs27g8exoJlPt3G9h0bIQ9
   MaQhO5yN4xsbXRrV88R3WX/2KDoBus4EDDGsTnXaj9KPEhWSFHNBfUwyR
   R4YrsEZ8ZVPe6VIcVd3VHwyWZtG7pKnb8BZVY0bxVkTEc8yPbnIEYXizl
   6BR6NJtHh5MccN4txZ9yeWeqyBxbHfXWD3FGDO4ix6ht8MucdGCc3KIuX
   1Hv+KaaNJ0aJ7fZKLxceZ9qs7Eoedn7iHSWUzCb8Snz1mSDAi/zVuU/Id
   6ICjKKw/1cw+OmhS+D4uAf9XiOATpnk+08fPnSncPma2HdajrBuyW2WK0
   w==;
X-CSE-ConnectionGUID: V5SBaUbfQtacFcYxWSpSQw==
X-CSE-MsgGUID: 1cqiBBjvTry4wUGpeLJKZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11904"; a="88666087"
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="88666087"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 01:58:31 -0700
X-CSE-ConnectionGUID: LubDt4NrTd2QnmaL1Po8yQ==
X-CSE-MsgGUID: AwT3oSrBQgW9yKJiisqIpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,102,1787036400"; 
   d="scan'208";a="276744495"
Received: from fred-panther-lake-client-platform.sh.intel.com ([10.239.144.217])
  by orviesa005.jf.intel.com with ESMTP; 14 Sep 2026 01:58:29 -0700
From: Fred Gao <fred.gao@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	jani.nikula@linux.intel.com,
	rodrigo.vivi@intel.com,
	joonas.lahtinen@linux.intel.com,
	tursulin@ursulin.net,
	ville.syrjala@linux.intel.com,
	Fred Gao <fred.gao@intel.com>,
	stable@vger.kernel.org,
	Chenchen Wang <chenchen.wang@intel.com>
Subject: [PATCH] drm/i915/panel: Only consider seamless DRRS modes as the highest mode
Date: Mon, 14 Sep 2026 16:55:25 +0800
Message-ID: <20260914085525.2669889-1-fred.gao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

intel_dp_mode_clock() uses intel_panel_highest_mode() when seamless M/N
updates are supported, so that the link configuration can accommodate
every refresh rate DRRS may seamlessly switch to.

However, the fixed mode list is populated using is_alt_fixed_mode(),
which only requires a matching active size and non-sync flags. Whether a
mode can actually be reached with a seamless M/N update is decided by
intel_panel_downclock_mode() using is_alt_drrs_mode(), which requires
matching timings and flags. intel_panel_highest_mode() used neither and
simply picked the highest clock in the list. A mode reachable only with a
full modeset could therefore inflate the reserved bandwidth and
needlessly reduce the selected bpp.

On a 5120x2160 eDP panel the DisplayID preferred mode uses 717260 kHz,
while a CTA mode with different blanking uses 742500 kHz. With HBR2 x4,
2160000 kB/s is available. The preferred mode fits at 24 bpp:

  717260 * 24 / 8 = 2151780 kB/s

but the CTA mode does not:

  742500 * 24 / 8 = 2227500 kB/s

Selecting the CTA clock therefore reduces the link configuration to 18
bpp. The firmware state is 24 bpp, so the mismatch forces a full modeset
and an eDP backlight and panel power cycle during driver takeover.

Use is_alt_drrs_mode() so intel_panel_highest_mode() considers the same
set of modes as intel_panel_downclock_mode(). Bandwidth is still reserved
for genuine seamless DRRS alternatives, including when userspace selects
the downclock mode as the active mode, while modes that require a full
modeset no longer affect the result. If no fixed mode is compatible, the
helper continues to return the adjusted mode.

Fixes: e6f29923c048 ("drm/i915: Allow M/N change during fastset on bdw+")
Cc: <stable@vger.kernel.org>
Signed-off-by: Fred Gao <fred.gao@intel.com>
Reviewed-by: Chenchen Wang <chenchen.wang@intel.com>
---
 drivers/gpu/drm/i915/display/intel_panel.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_panel.c b/drivers/gpu/drm/i915/display/intel_panel.c
index 81e638d0c7b3..343bd8439566 100644
--- a/drivers/gpu/drm/i915/display/intel_panel.c
+++ b/drivers/gpu/drm/i915/display/intel_panel.c
@@ -192,7 +192,8 @@ intel_panel_highest_mode(struct intel_connector *connector,
 
-	/* pick the fixed_mode that has the highest clock */
+	/* pick the highest clock we can seamlessly switch to */
 	list_for_each_entry(fixed_mode, &connector->panel.fixed_modes, head) {
-		if (fixed_mode->clock > best_mode->clock)
+		if (is_alt_drrs_mode(fixed_mode, adjusted_mode) &&
+		    fixed_mode->clock > best_mode->clock)
 			best_mode = fixed_mode;
 	}
 
-- 
2.43.0
