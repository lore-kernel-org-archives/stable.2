Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613675;
	b=smKOJ4p74TaHPJuAmS1SJT5qFOSXaeFDJ5QbNGeDHNbHsyzOSlBayME4HpQ8FUI6PkMb
	 kctpOIw2VT0KFwU8p7fGYoBHcosoSau3ywGsjCIXUArcuN7CKHJZHH+TQxIORO2HmknCs
	 hcJyU/zZOii0UFGn9T6k9aB6UJ9W3SF0whJ9yMNyKiJJg9qA8GZ6HoIEfGbCH2hLldV2E
	 vpORzGhTt4doYJchButkCwUtkaybrxlk4PFmFw0643vY7hL43X1r0ZXqWUnUZkRvylcG3
	 ox/jxa3NwaYnYo8v4fPoUvhdJPIrvIy8J2yifcv1WeOnjxFrEnBhxiNl4cYp3TwT5CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613675;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Organization:Content-Transfer-Encoding;
	bh=y6t9DKjoxmVJ/yUpUxNzjW3BEE2jjsr4Z9f9pVj1FHQ=;
	b=v3W7j+BHSqvQsCL9qvnVTebPRFrkdCzwZ4ORgX4NYyxGXN3+2LHeJuxUMBg7UTio8L0a
	 UR6nKoExjJFyL/2vH1B5z79Y90ugQPMEx3lc9wX2S0rvD1W0Z3u/sFxXpg4BeXDubX0PM
	 PpY40GGH/xu49DXa4oxvlQFhzgnPHepkaqZE+VBJSE2DivweUrbI8cFuoo6or/V+MmATi
	 CjS6IbOCfVEtKjh9hi5CflKCSDhKC8hbE5Mbhk0CnE990/VH9GL+FIQqPGvgEE5ykYfBV
	 UPVDjbPkMKE8+Mh+kn/x1PrUVxZH2WIoyUufjN4kDuLOzWWGGHfraoMSStmA+rARt8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="HTSZnxa/";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A127606A327
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:01:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A127606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HTSZnxa/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793613675; x=1825149675;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9ceAY1VV30ShnVeuRaMeV2/Ycz5KJfv1lgnbnTg4kO4=;
  b=HTSZnxa/3KwJuu9u7KDMWgGyxOfAtr283cDkeisCWGka2Ku+m3nXfbi6
   7r8s3N/E9JVUKM9Ey+BKJJk4olj/0Ss3KUYnsXhVe0//s1Tibh53UXMnD
   cSfMkLSNVutZ1VJ0yNHVy9xgl03jtn7mRXnqHsqmdO7xLKooor6xNkn+u
   y+eo0YhE4DAJ3gmmc/Stoy+Qv7uddRRX9AUCEHsgq1pyK1U21j0zfn4tn
   qoZ/sIXs8hIYgMFJt0SelWc7JcNc9cCfk2KdG0rvbjdvD1qlVBf5ERjIA
   UzA+Y7OA7HMtCYeytHGN4YDdIZQWtosiSJOlH6fi5/psTiebdLuUBfbpg
   Q==;
X-CSE-ConnectionGUID: txyYcy7TR06A0xP//Mq/jA==
X-CSE-MsgGUID: K02Z3Y4tTPKxui9Zpg3lCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2204604"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2204604"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:01:15 -0800
X-CSE-ConnectionGUID: uu94D5AERiKGUUldERdgYQ==
X-CSE-MsgGUID: fKHlAxCfStms2W3lx7S53A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6068346"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:01:13 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] drm/i915/psr: Clear CFF state on flip flush
Date: Mon,  2 Nov 2026 12:00:50 +0200
Message-ID: <20261102100051.272137-4-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102100051.272137-1-jouni.hogander@intel.com>
References: <20261102100051.272137-1-jouni.hogander@intel.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

An ORIGIN_FLIP flush can clear the last busy frontbuffer bits without
running _psr_flush_handle(), leaving the CFF state flag set.

Clear CFF state when no frontbuffer bits remain busy, and queue PSR
work only when inactive and not paused.

Fixes: 805f04d42a6b ("drm/i915/display/psr: Use continuos full frame to handle frontbuffer invalidations")
Cc: <stable@vger.kernel.org> # v5.19+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 29 ++++++++++++------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index be1edd9099fb3..bd16563603249 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3798,12 +3798,6 @@ static void _psr_flush_handle(struct intel_dp *intel_dp)
 		intel_psr_exit(intel_dp);
 	} else if (intel_dp->psr.psr2_sel_fetch_enabled) {
 		/* Selective fetch prior LNL */
-		if (intel_dp->psr.psr2_sel_fetch_cff_enabled) {
-			/* can we turn CFF off? */
-			if (intel_dp->psr.busy_frontbuffer_bits == 0)
-				intel_dp->psr.psr2_sel_fetch_cff_enabled = false;
-		}
-
 		/*
 		 * Still keep cff bit enabled as we don't have proper SU
 		 * configuration in case update is sent for any reason after
@@ -3859,13 +3853,8 @@ void intel_psr_flush(struct intel_display *display,
 
 		intel_dp->psr.busy_frontbuffer_bits &= ~pipe_frontbuffer_bits;
 
-		/*
-		 * If the PSR is paused by an explicit intel_psr_paused() call,
-		 * we have to ensure that the PSR is not activated until
-		 * intel_psr_resume() is called.
-		 */
 		if (intel_dp->psr.pause_counter)
-			goto unlock;
+			goto rearm;
 
 		if (origin == ORIGIN_FLIP || origin == ORIGIN_CURSOR_UPDATE)
 			psr2_dc3co_flush_locked(intel_dp, frontbuffer_bits);
@@ -3877,8 +3866,20 @@ void intel_psr_flush(struct intel_display *display,
 		_psr_flush_handle(intel_dp);
 
 rearm:
-		if (!intel_dp->psr.active && !intel_dp->psr.busy_frontbuffer_bits)
-			queue_work(display->wq.unordered, &intel_dp->psr.work);
+		if (!intel_dp->psr.busy_frontbuffer_bits) {
+			if (intel_dp->psr.psr2_sel_fetch_cff_enabled)
+				intel_dp->psr.psr2_sel_fetch_cff_enabled = false;
+
+			/*
+			 * If the PSR is paused by an explicit
+			 * intel_psr_paused() call, we have to ensure that the
+			 * PSR is not activated until intel_psr_resume() is
+			 * called.
+			 */
+			if (!intel_dp->psr.active && !intel_dp->psr.pause_counter)
+				queue_work(display->wq.unordered, &intel_dp->psr.work);
+		}
+
 unlock:
 		mutex_unlock(&intel_dp->psr.lock);
 	}
-- 
2.53.0

