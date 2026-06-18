Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0222E7369
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781750695; cv=none; b=RmW9CWbMk87xGVpRTzq0hsq1KQrqtTLesEXVHI93Iw9oaFi3MNpQyRwKbOnqruJj8Al54mrvaEiGYVG4pTk+VWytjHXuOvGaVnZL7rUGoLABd2tUwDxioRH95tJbcCs3HMEiAm/QIBSivyj4Gk59XUsN3Iu7GR75fYEgqY6GhBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781750695; c=relaxed/simple;
	bh=3OM4OHi7eGkxoyxRywCOf59CDm6JAJnEQ3H+DAMDh7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W52Zq2uHo2x7130P1FyyN3UxPMXpsbOze+l+xeGCV6tyrcoTW5bRLIbdyF8g9iIom2HRrqTHBxJzNHmm2hO9yyJ8Bh0K7tIa9O/ZXebw3MF3wDn9vWe9WL1LHMMXaCIsE8JkebnbSLl6ixnsnQwXCmhuFM8YKmWglIqGhykrxKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl38/eYT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl38/eYT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A08E1F000E9;
	Thu, 18 Jun 2026 02:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781750694;
	bh=s02CEcZXspKQH6k74YSL3uiQV+Rjp88TlVN3osgfgKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tl38/eYTwpMWRfgfFCws0dqSKJzCrQ9L2B0zgB+wR76MU7f9UCqstF7hUUc98734A
	 aXWpSmqfEtTGt3OKlnnTIISq2Jmr5YIFKwoM/OUtMLU78fgioT8BOGd1fZHz0NBQM9
	 Ns0wgk+WATjxvwy7oxHEVX4On7vTMeIBWOf1Z7XswdkkIfdKd7hRYeM+cDYLnuhf9l
	 ZRDBhpRVB7pMjU9TgsJ8TbOkkBde/njSA8cDOPnI52izZQIa17kMkX55ID2NvsU9JH
	 1Wqd7ttt4Ga1b2aLAhlPD4r/6SZ1f0KgJ5dbEAlUuKI5T57SG81F83RciG0Vyr/AI0
	 8J1sY9dnZmO3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/xe/display: fix oops in suspend/shutdown without display
Date: Wed, 17 Jun 2026 22:44:51 -0400
Message-ID: <20260618024451.549042-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061520-pediatric-private-c0b5@gregkh>
References: <2026061520-pediatric-private-c0b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit 68938cc08e23a94fd881e845837ff918de005ce7 ]

The xe driver keeps track of whether to probe display, and whether
display hardware is there, using xe->info.probe_display. It gets set to
false if there's no display after intel_display_device_probe(). However,
the display may also be disabled via fuses, detected at a later time in
intel_display_device_info_runtime_init().

In this case, the xe driver does for_each_intel_crtc() on uninitialized
mode config in xe_display_flush_cleanup_work(), leading to a NULL
pointer dereference, and generally calls display code with display info
cleared.

Check for intel_display_device_present() after
intel_display_device_info_runtime_init(), and reset
xe->info.probe_display as necessary. Also do unset_display_features()
for completeness, although display runtime init has already done
that. This will need to be unified across all cases later.

Move intel_display_device_info_runtime_init() call slightly earlier,
similar to i915, to avoid a bunch of unnecessary setup for no display
cases.

Note #1: The xe driver has no business doing low level display plumbing
like for_each_intel_crtc() to begin with. It all needs to happen in
display code.

Note #2: The actual bug is present already in commit 44e694958b95
("drm/xe/display: Implement display support"), but the oops was likely
introduced later at commit ddf6492e0e50 ("drm/xe/display: Make display
suspend/resume work on discrete").

Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7904
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/6150
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260515160920.1082842-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 7c3eb9f47533220888a67266448185fd0775d4da)
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_display.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index e164e2d71e1157..de1fd4dff0e869 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -148,6 +148,15 @@ int xe_display_init_noirq(struct xe_device *xe)
 
 	intel_display_driver_early_probe(xe);
 
+	intel_display_device_info_runtime_init(xe);
+
+	/* Display may have been disabled at runtime init */
+	if (!has_display(xe)) {
+		xe->info.probe_display = false;
+		unset_display_features(xe);
+		return 0;
+	}
+
 	/* Early display init.. */
 	intel_opregion_setup(display);
 
@@ -159,8 +168,6 @@ int xe_display_init_noirq(struct xe_device *xe)
 
 	intel_bw_init_hw(xe);
 
-	intel_display_device_info_runtime_init(xe);
-
 	err = intel_display_driver_probe_noirq(xe);
 	if (err) {
 		intel_opregion_cleanup(display);
-- 
2.53.0

