Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999754;
	b=Ho9j/R3YGt+puZ3IZHo/PCuhkUchFU1MrJCDoKTCmwZLoHXlvhXSMqthPj4q/EGYOta4
	 c0pvWXQ7R3qB3bDgjPLTwbFadir7J4ne7esNuT09wjiEoR9BeTpnVAmxN/OcE3ZD7X4Mz
	 zucjpf77n5TxGHHWzErxoH7YOX3bv5f0dz9f0vi8woBveFpqlEFrxHjkaWKhTxYQpI6sy
	 EPY4PqqE7V9OvZh0gY6qGPzG1ujg/bpya1sFU2I0Xziw38gSGD4ya/8/KHUVN4lHNJtcT
	 Ke/bhf95+eoaft04id0IcIJFpGTaWzwqDQ6KY3Bi0CEsx7XXsSkGARso7Ee9zrUIYKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999754;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:Organization:
	 Content-Transfer-Encoding;
	bh=VP2Ho0yVQBQbmYAdfwECk1lQKQTIUB09kP8yRbsZdHY=;
	b=1m4PCTZECxEuG31nkKQvKHg0LtsKx3x4l1pvUfWUZTG5sigWMcWc/6Em92P1/eIFPLRU
	 Fs0UctCM83WdzC2uc15rwV2DXyn2DrGyIS9LRabjc97gHXnnR3O9QCO3r9kFjQ9UlCvTv
	 kllO83Q73uLvBIf8ujF2GmORjP05eLj9wTlUsDv4tFWkKcTAL6a8f/sUj2dWwB8by/Zvx
	 H0SVhGvgS6wgn4O9kPcn/Djg9p19fY6pIMRdaoOu+jcxVtfnVh7i8tHm1RL2Hrr9zwrxC
	 58JCx7t8npNuibbVlmdZ3gxlF/a1E5mVinML+nHSVTQ1hEBg1mHqfjlp8EeSzCziwlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EGvv6KOW;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C31606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:02:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C31606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EGvv6KOW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794999754; x=1826535754;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WT/e90wemZ6wkOGEgi67Yz9+ZXxRD8C7Nq7SJ9kE7RQ=;
  b=EGvv6KOWkF7f45KztoEhUDAKBbAw1sMuw09rjNI7aEkTCte7YEYCNnHY
   OeB6RSMWa1eueKSq5YD3zaWfukN83d8KBIjcxnDfjW+tDqR41UqEpHUZf
   TTpG5fSUZAtKTkwBtn6cC20AVTCp1+q7f17P64MFHojh2CuomsmW20PoZ
   ds4+xl9Jnh9DjS2+2aJ06Af0MdO/q3noaS/wzlU6n/rVDohZxroGmUzEx
   xP2JKEBTezt3pblsTXBWJO74C83P7KWS7fADJO8Odn0N78HHOretzsFIk
   BDuAjeDR2MJmiWXPvcnQ48jlyb78BsoFmMN8XNnWlRP+hPQcEubj+nJka
   g==;
X-CSE-ConnectionGUID: TYDJ6FcGTQKIN2FCesLouw==
X-CSE-MsgGUID: PW4Q8QogSMuurhltjCQY0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3845559"
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="3845559"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:02:34 -0800
X-CSE-ConnectionGUID: +UmDrNOUSjaTBOiLzesDRw==
X-CSE-MsgGUID: MlrElevCQkO1uKXo08gXTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,219,1787036400"; 
   d="scan'208";a="10514400"
Received: from abityuts-desk1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.138])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2026 03:02:31 -0800
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/i915/psr: Adjust Xiaomi Book Pro 14 2026 psr2 disable quirk
Date: Wed, 18 Nov 2026 13:02:20 +0200
Message-ID: <20261118110220.77370-1-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.53.0
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

We want to apply psr2 disable quirk on  Xiaomi Book Pro 14 2026 with
differing device ID.

Fixes: 5e79af5db00b ("drm/i915/psr: Disable PSR2 on Xiaomi Book Pro 14 2026 as a quirk")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9575
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Mika Kahola <mika.kahola@intel.com>
Cc: <stable@vger.kernel.org> # v7.2+
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_quirks.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/i915/display/intel_quirks.c b/drivers/gpu/drm/i915/display/intel_quirks.c
index 96eb9a40df9b9..e3303d5146e89 100644
--- a/drivers/gpu/drm/i915/display/intel_quirks.c
+++ b/drivers/gpu/drm/i915/display/intel_quirks.c
@@ -270,6 +270,7 @@ static struct intel_quirk intel_quirks[] = {
 
 	/* Xiaomi Book Pro 14 2026 */
 	{ 0xb081, 0x1d72, 0x2424, quirk_disable_psr2 },
+	{ 0xb080, 0x1d72, 0x2424, quirk_disable_psr2 },
 };
 
 static const struct intel_dpcd_quirk intel_dpcd_quirks[] = {
-- 
2.53.0

