Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171653;
	b=ex+epPhzdulF+siY5Pv+gP+bVIG85w6RgI5/p5QuA0JS8gKo1LltvMc2nbMiSWSLKT0b
	 C1vlBj2es4PCSheX9AqQ1FdXBO3hlzEczK0Y7yi7Dz1CJnOl96adVLVQwoJH3DYxESH6p
	 pIW7vtfjvcsis9tqtA9rmanzJtO/TRIqc86LsjTb1PfMkq0ywu7Du5SmXAMyP56x7CP+b
	 75GP6P2wRENLTR6+N3mFJYVlrXvfQIAuMpV1uWQFcAUPFL3t9dv1LwMisLUoU78QKpJ8G
	 MoMGogfZzhGNJVB7St+RANWNbnX8uNh8fMt8tI4vAxpet48unRQAbAQYjEvSdZIVf8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171653;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=lf8CvRA4cR/CBcRYieZfRRDsEFRoalKr0/OBMPiFV9o=;
	b=PdjQ1ZnvMC+NqL1ATqyllRAAnSWynx6N/bcobdBoJv77xSysIs9hBtz3RatiQvlTnb7Y
	 i8Vltjm0FwKSULERm3/rK/q+IPM56nyxnBPRG3zN9CxG/w0IZXbAw9PdLvBxA4XrZemkV
	 uH21lqiJNATVpDQWYF6q2FbIMCSQ0IcYRvTyFpG8erNXDVu+2DN36Nnmbfj96SszoX2Mu
	 oWCY7j1MG+TnFSovsozK3LEwYcpbUDgjpM8U3ADSCambFkh6gzdEyUbf7vonXsGxAF3R+
	 a+FxdDv1oWy1s2kvuK3c17gHk8JttyAPPeAlKyj/ex3UCrppnIVRvnirHOI5aaW9Xiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KNFNYXc8;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684F2606A31F
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 684F2606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KNFNYXc8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793171652; x=1824707652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kHt+04oaA1Le04one5WWSP1q1x24VyDsyjTtPRDVk4Q=;
  b=KNFNYXc8Gv41ie1CAsxp+OrLXIfNJaOc4EZK3ZGid25ZJH/lkiKpOn3d
   r4ylvmnfoT7R0GEaf47x9PhsFza9+pkmvTVAyDgAFgSqTIWlollYlz6OW
   X5+Izoy4/s/ZUYFAZhkfyiKTRw1XdN2ifnsD1/MheBrXRD0vdctdWM1tA
   bqwswgdaSZQOSX5GdjTXZdv+JxplOzyew/3HtM8KRfJu4oEeI/eu6ScEe
   tYvYgesIzJvG+MmGze+iy4BHADXfvozLLWqVMiN2fV7RwS+zMDIMbLnN/
   WrDz2+JL+BdtW0aSvIVyehdNea+MMUk4PwZ7RIRu0m1nIixkSqFGLTXCN
   Q==;
X-CSE-ConnectionGUID: WhLW0QjKRiWRNahWes1UVg==
X-CSE-MsgGUID: hx3VoyXDSkiYQGuA/rbiMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1765957"
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="1765957"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2026 00:14:09 -0700
X-CSE-ConnectionGUID: PjjQVwojQoicyrRSZEQJuw==
X-CSE-MsgGUID: pYtNR7lZQtqWoq39rltnkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,182,1787036400"; 
   d="scan'208";a="4868301"
Received: from vsrini4-xps-8920.iind.intel.com ([10.223.167.75])
  by fmviesa002.fm.intel.com with ESMTP; 28 Oct 2026 00:14:07 -0700
From: Vidya Srinivas <vidya.srinivas@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	uma.shankar@intel.com,
	jani.nikula@linux.intel.com,
	Vidya Srinivas <vidya.srinivas@intel.com>,
	Charlton Lin <charlton.lin@intel.com>
Subject: [PATCH v4 2/2] drm/i915/display: Disable pipe joiner on WCL
Date: Wed, 28 Oct 2026 12:34:04 +0530
Message-ID: <20261028070404.1913843-3-vidya.srinivas@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261028070404.1913843-1-vidya.srinivas@intel.com>
References: <20261007072334.1801956-1-vidya.srinivas@intel.com>
 <20261028070404.1913843-1-vidya.srinivas@intel.com>
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
Report no joiner support on WCL so that modes which would require
joining are rejected, matching the 4k 60Hz maximum resolution
documented for the platform.

v2: Rebase onto latest upstream
v3: Fix up the commit message
v4: Split the scaler and joiner changes into separate patches (Jani)

Bspec: 74286
Cc: stable@vger.kernel.org
Suggested-by: Charlton Lin <charlton.lin@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Vidya Srinivas <vidya.srinivas@intel.com>
---
 drivers/gpu/drm/i915/display/intel_dp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
index 00e02e019d25..ef164a797618 100644
--- a/drivers/gpu/drm/i915/display/intel_dp.c
+++ b/drivers/gpu/drm/i915/display/intel_dp.c
@@ -485,9 +485,9 @@ bool intel_dp_has_joiner(struct intel_dp *intel_dp)
 			return false;
 	}
 
-	return DISPLAY_VER(display) >= 12 ||
+	return ((DISPLAY_VER(display) >= 12 && DISPLAY_VERx100(display) != 3002) ||
 		(DISPLAY_VER(display) == 11 &&
-		 encoder->port != PORT_A);
+		 encoder->port != PORT_A));
 }
 
 static int dg2_max_source_rate(struct intel_dp *intel_dp)
-- 
2.45.2

