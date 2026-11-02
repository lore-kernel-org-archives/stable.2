Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613674;
	b=veXPiwidAVtZDuH1c84Keb84DoaNisgVlXBUOR7OTVmqENQILt7q23u+6x2h3rd7PbUX
	 MWg5CBLt5nAwggbWQ85Gri1UcTInDp1+GK4B2+A86pdLU4amuqxRiw7+UU8ZAwX9RlYmv
	 BHoqn3DnmYAEpbqLVkidVoNNZMomVyy1MCYeR0Tm9uMuqFCQavbQubz3OWEvYE5L7XaUp
	 eMDBDrOPWMszpK4FbirTojPzthTmWG9PW8AHHNIoCslL6r6Z60LbugHWveordQXpQsA6H
	 wy46YMJDbIzYXO+b00gm2dNY4LYTfNQjJEBNT469wHXsXnYRrbZFL0GKuQtpSTLOAMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613674;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Organization:Content-Transfer-Encoding;
	bh=ghtMTQQyBcxHQwUuxOjuEYt3VHkvG+pDAZAuy+qTrW8=;
	b=C+1l6bXp34diuNBgU+Asy5AwfDMN4ysrJzaOWOchPtRByPnsNMzMHKhpgpHweW2FKw4g
	 URc6OLZxzhGkyMWUdJ7I048d9UP3LlzQvKWOlFMsV/+HbtO96Pf+wCZH0KeIL2jNSo8BQ
	 YkPkNLhdAMRe/j53Rf5cmGukczMg85OrT7yvESvpmlMJlp0PtcldbY8x4+pWu+F4Eeht2
	 azYCqp/K6qxbylaAXS2gAlU8bduIDVDSguMza1M0DXmNarnVH8xN3if/eiO1KLJNJeW8R
	 pGBWMpesHjSn6TvOEGcKkciD9fwzKn8ptownWjup3KbumgZjv/uJpiNhb7rhHd20YAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HVjEgebb;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED9E606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 10:01:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EED9E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HVjEgebb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793613673; x=1825149673;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GJ3a7H2Pwgz4pUACG1Y52iVmzWsdZ9OWZCQ0/x4Uqfc=;
  b=HVjEgebbJIPZcuSDzOXKpeYDZdsbEyk2xmjx8l+3S1IxQfzMLZpy6Ixo
   Qclr4iu94qjAOXa6k+8OYN1YMMvrvL2d7qSFvtp4WtTTRA7rKH7Y5P26n
   FCN5y4j57Yol49IlATCKae6gwXstptE7Pqn1qJHXYrBBu2YWqHyo376Rt
   h/v0q/t4mEeMvQ2A+if1OI5X8gq8YCVB3N4/BeubXvWh7PzR0wISsvKXQ
   54rC59MrnTz90Mx41Uw6fTRu20sphvrEyD3sBgdJyfWj+UZwPjndt5Gub
   MP84Scq7P9GQK+SuyG13ZeSg5NwsPUewyyRPqMMu1CleFpPdeIe1oQQv+
   w==;
X-CSE-ConnectionGUID: g0kUp9H9RJiJ5FqRyo+zsw==
X-CSE-MsgGUID: deROUcuDQX2WeFL6qu5tOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2204599"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2204599"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:01:13 -0800
X-CSE-ConnectionGUID: WbTEPbP3S2aezdrNLVVNeA==
X-CSE-MsgGUID: Lpx4iqTxQYeELfImDTLRcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6068329"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 02:01:10 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org,
	Ambica Pramod <ambica.pramod@intel.com>
Subject: [PATCH v2 2/4] drm/i915/psr: Re-arm PSR after flush
Date: Mon,  2 Nov 2026 12:00:49 +0200
Message-ID: <20261102100051.272137-3-jouni.hogander@intel.com>
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
queuing the work that re-arms PSR.

Queue the re-arm work after each flush when PSR is inactive and no
frontbuffers are busy.

Move also pipe_frontbuffer_bits ==0 check to done right after pipe
frontbuffer bits are figured out. Anyways nothing is currently done after
in intel_psr_flush if the bits are 0.

v2: Do not re-activate PSR on other pipe frontbuffer bits.

Fixes: ef39826c12b4 ("drm/i915/display: Fix glitches when moving cursor with PSR2 selective fetch enabled")
Cc: <stable@vger.kernel.org> # v5.16+
Tested-by: Ambica Pramod <ambica.pramod@intel.com>
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index b37723ad56c42..be1edd9099fb3 100644
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
@@ -3856,6 +3853,10 @@ void intel_psr_flush(struct intel_display *display,
 		}
 
 		pipe_frontbuffer_bits &= psr_frontbuffer_mask(intel_dp);
+
+		if (pipe_frontbuffer_bits == 0)
+			goto unlock;
+
 		intel_dp->psr.busy_frontbuffer_bits &= ~pipe_frontbuffer_bits;
 
 		/*
@@ -3870,13 +3871,14 @@ void intel_psr_flush(struct intel_display *display,
 			psr2_dc3co_flush_locked(intel_dp, frontbuffer_bits);
 
 		if (origin == ORIGIN_FLIP)
-			goto unlock;
-
-		if (pipe_frontbuffer_bits == 0)
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
2.53.0

