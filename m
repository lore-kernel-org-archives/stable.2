Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE2140961E
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 16:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781540489; cv=none; b=iZtO7NFw68d8YTym7fRclSy8rsp0uQIqxbDmWqqGdhQ70RM/l3xBD8n4eoP1MGCeEO+URtB5TwLIqJG2BND10RPQ9/maVyj36klSJT1Mxq3ZDGTXXW3XhMIL5fyGom6GxZWiWt43NHfBBs1y2Asv7tBfRVz/zmUI0e3PPhRJ+/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781540489; c=relaxed/simple;
	bh=6d9+ptbLyx12poobEuqZtDy2ri+1lQcXgeshHluHZo4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YwiF6rjYxna5W279J5ELzPlS0LgsZY4g+I4hcc5OyOO5GiItCsq9RqrBzVy2GuNmzQxpjG4ffKqOR3FwQVYKKlGoMGGxO7UFLn3ppxYgEV3QL0XrdWEJXkricjN88iViRj+hQnTGKMYf1LdXpPNO+irLCuiSyPlbdcVzYKFg3WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hvDAf6R9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hvDAf6R9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39EFE1F000E9;
	Mon, 15 Jun 2026 16:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781540488;
	bh=JdmBSZRKgNwqRPMw3SghRZKwrgIj2OvJ+9vUFn5HWcs=;
	h=Subject:To:Cc:From:Date;
	b=hvDAf6R9k2QQWXyWXVoOC6F9PqCHZEvuW2SDIcGN1NjqsbpcImTPWubTW/hzIFVNH
	 2FU1QWDBn74MeR9TWoG9eO2XZoXHLdpYfjup6oncabK2k5DzWoSSvv5BIzVasYDsVE
	 EKUWSOgCj+6H91LEd1fBKn+dMkzsTi66LxQpOmcY=
Subject: FAILED: patch "[PATCH] drm/xe/display: fix oops in suspend/shutdown without display" failed to apply to 6.12-stable tree
To: jani.nikula@intel.com,matthew.brost@intel.com,suraj.kandpal@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 18:00:20 +0200
Message-ID: <2026061520-pediatric-private-c0b5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 68938cc08e23a94fd881e845837ff918de005ce7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061520-pediatric-private-c0b5@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 68938cc08e23a94fd881e845837ff918de005ce7 Mon Sep 17 00:00:00 2001
From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 15 May 2026 19:09:20 +0300
Subject: [PATCH] drm/xe/display: fix oops in suspend/shutdown without display

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

diff --git a/drivers/gpu/drm/xe/display/xe_display.c b/drivers/gpu/drm/xe/display/xe_display.c
index 00dfa68af29a..b17fb698d2f8 100644
--- a/drivers/gpu/drm/xe/display/xe_display.c
+++ b/drivers/gpu/drm/xe/display/xe_display.c
@@ -124,6 +124,15 @@ int xe_display_init_early(struct xe_device *xe)
 
 	intel_display_driver_early_probe(display);
 
+	intel_display_device_info_runtime_init(display);
+
+	/* Display may have been disabled at runtime init */
+	if (!intel_display_device_present(display)) {
+		xe->info.probe_display = false;
+		unset_display_features(xe);
+		return 0;
+	}
+
 	/* Early display init.. */
 	intel_opregion_setup(display);
 
@@ -137,8 +146,6 @@ int xe_display_init_early(struct xe_device *xe)
 
 	intel_bw_init_hw(display);
 
-	intel_display_device_info_runtime_init(display);
-
 	err = intel_display_driver_probe_noirq(display);
 	if (err)
 		goto err_opregion;

