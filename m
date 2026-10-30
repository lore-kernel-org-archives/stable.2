Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793343994;
	b=mjzZs0Mg0AY5fRcWHbFh/FTBgGbjSTcR9uIgevt7fSuY6I8j3Ci156TbONiQKIFaCv9L
	 cJUh/mApRkCfKv/z9oCahQagyFthcUwYg17b++tjDDSO+gqjZ6/ZJ3PG6ym1ORvIAbkU7
	 AWQyiQUhmt0mVkHuR2RvnJmE6f3PkNZIz6FnJwDM9Tw9gm4qjCbS0xyablh7E92rfnInx
	 +zYxy5kuZfQy2VqnWUJdly/ZVywpBoFAo0aJotS/ZD+cQyngbpFJvBWcNRuiEA8u3bypg
	 i5Z/q51C2UxFnftYpP8RPluwGeW6RH7K6+gYPdWxP31uBbXe7qUgUnwp5J4MoO6H0bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793343994;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Organization:Content-Transfer-Encoding;
	bh=3TZfJ35+/9VSoda/eWaWEh+8C6g1aFJGNAl6ZDTePD8=;
	b=IdnG11RIrx61whkm/xGa0abz6YNI38Ag9Vk7ljN/JIvmxEXazlJmSaNBqtNCyVW22N5P
	 fcSEIJCE3tiVIU+zHLBpMTpS27cF7Vly3VoQLPXCIwhu4Qm/03pThlygInWdAHY/6SO/P
	 0dfTVHdnJLPxz9sMar+SWZzOCz52UcG39O35junW5ui1T0AFhWVtfZJojxIVmMnZK3Uwy
	 ZqscNI8uFqeSXpDWVSF7RMqX/L+YWWI86joWsrz930bVDXE9Wi10tz5u9IdFeeOVnoUh0
	 /O5PnrLzwvc9DjqD2paoDE9klAONF9oH7tG6HCWIYOE0K1YkOSQKN/mkKF2dAf757fg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y08pti1N;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EFC606A31F
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 07:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28EFC606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Y08pti1N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793343992; x=1824879992;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcvCQAQiW6MzZ6IY5r+d3o5BM2LDy32d/YeuJ0VMAIQ=;
  b=Y08pti1NWkFIonJ1dYmh1yIvsJWV2VNUitWhjVPXxQ/t1uioyPPiCFIZ
   qNzOLlKIMno7dWqFrYlh4K+l1zxTKEOYJSgvqadQ9K8YNsb3ysU/kw/9v
   S1/I8C59aIDVNke8PqFlTHhLYSpPFd8510OXcVNBiLdWTn5xDHunuqhxG
   itVPRm/p/0CtNdHUNKR0fxWznIMAkAQ5iOxmbNP+iRAxgoZyJu1kd0eQ/
   C49ERiU7JEnvu4nkiXU96tGGW41gdhhhcSu3lbTttr6zs0dKJBHCm7mVe
   WKD0TBvGXclHhxX/+36LlhvLjd0r+AJk4TDB4F7Ud+8w3Pxmu1y7nFFOV
   w==;
X-CSE-ConnectionGUID: jkzJvbUDTae3qWLMBVGFPw==
X-CSE-MsgGUID: xZS3W/mwTlm1/6fKtDfEWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="1985052"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="1985052"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:06:31 -0700
X-CSE-ConnectionGUID: gQltKq11TviJRuzl0e77mA==
X-CSE-MsgGUID: gAchhe2mRZOP4fbxS4GdUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5485189"
Received: from szadworn-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2026 00:06:29 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915/psr: Re-arm PSR after flush
Date: Fri, 30 Oct 2026 09:06:12 +0200
Message-ID: <20261030070613.181026-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030070613.181026-1-jouni.hogander@intel.com>
References: <20261030070613.181026-1-jouni.hogander@intel.com>
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
queuing the work that re-arms PSR.

Queue the re-arm work after each flush when PSR is inactive and no
frontbuffers are busy.

Fixes: ef39826c12b4 ("drm/i915/display: Fix glitches when moving cursor with PSR2 selective fetch enabled")
Cc: <stable@vger.kernel.org> # v5.16+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 288836d4a993c..752edc1adaa1b 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -3822,9 +3822,6 @@ static void _psr_flush_handle(struct intel_dp *intel_dp)
 		 */
 		intel_psr_force_update(intel_dp);
 	}
-
-	if (!intel_dp->psr.active && !intel_dp->psr.busy_frontbuffer_bits)
-		queue_work(display->wq.unordered, &intel_dp->psr.work);
 }
 
 /**
@@ -3870,14 +3867,18 @@ void intel_psr_flush(struct intel_display *display,
 		    (origin == ORIGIN_CURSOR_UPDATE &&
 		     !intel_dp->psr.psr2_sel_fetch_enabled)) {
 			psr2_dc3co_flush_locked(intel_dp, frontbuffer_bits);
-			goto unlock;
+			goto rearm;
 		}
 
 		if (pipe_frontbuffer_bits == 0)
-			goto unlock;
+			goto rearm;
 
 		/* By definition flush = invalidate + flush */
 		_psr_flush_handle(intel_dp);
+
+rearm:
+		if (!intel_dp->psr.active && !intel_dp->psr.busy_frontbuffer_bits)
+			queue_work(display->wq.unordered, &intel_dp->psr.work);
 unlock:
 		mutex_unlock(&intel_dp->psr.lock);
 	}
-- 
2.43.0

