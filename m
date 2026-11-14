Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640618;
	b=DsNmIOAdg627K9l1tqeigwGn4Ut5Fvw+keFmfDHh/Dc4iqHEPUBmrdK9sNs9mOvOEhRo
	 O4oOgD0WWmSggN1zhHuKAoehLH6xmyjs2jjA9/2z6LuveEtpU6UlbcMw1yWEQ2mdX4d6X
	 gso9YmDpWulfFCef1XI1UF4F/7fiaK14Sf76TI7YVWbYuDwCLCYsKSk1HUZBEsdo6hs1/
	 SEAfCLGyFFkfhC/V8tFv0w3qQeQ1W0H2Qtav/KWOlPXa8+KA0x8y326ghdZO0nJ19J4Yr
	 O8hXoHobCOUI4Eh6w5pWAe+ZVj0AqaRsWp7Fbowz2qFABDROyorg/L6k5BFrSriLbvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640618;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A7n5WM5eoUe84bcsKGLlc35N+LnxPZjMUgreXGX2s48=;
	b=1rWgjDchBp+NNRHu7SV2DIw2D12MI4LSjXF6s0CCqqI750Dpd9qdaguneWthvH6EwhlP
	 VOcYHrXtKmpy0pmDJ1zfqCQ7H0G97b4Rf0KDzw+EbXtEu0JYu0YfBC60hLoX+3Lie6k7q
	 KbW8/n9izrjS5sZ7sVdPgmg2AaS3UhZ+Ehm55CyecS80DCz9HAv7Y3OwfLadXwpLgHPfl
	 Ji9newHlPeDHyJ7u1w6fJnLostGCeKbrpXOIvJZVeU7ctlstYhsqQ3bLM/oznb03YYVMf
	 IiHt/NP+4LrFRRAjVLPoS8kRl9YFjDE+vzzgpwOHnBtvE3Dt6zqCBvAJN79S6PDXiJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LzTRyBbS;
	arc=none smtp.remote-ip=192.198.163.11
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86D8606A323
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 07:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B86D8606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=LzTRyBbS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794640618; x=1826176618;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2zycnUAnU720S400NhnYzs+dFnikglYbF7hfXGIyrZQ=;
  b=LzTRyBbSfZzyA05WFWFd+6kINPZ/A5xdAHQDL3ZRocFgbz+yP9uCPafR
   huedLD/MdJtfxwfAbAdwueNnsIayu23i3qUuKnRE6j/C4fMx7xeu7wqlV
   nMLsq4z1+UZdHUd/+dyZbt0Ix6H808TRn1YdUXXAGAMHL+TJ2nDkpKyiu
   hJlJl9PXlm+RGfg9Z6s6PPeJMYZqDuyQsuxzuvevU9HdhN4NE/Wg7bRsd
   j7NCbxiKH9r4CwKaZVeTjmqQpSmhXnCFvsXGatnrZ32Ksh2shl4bvX6LV
   OXlEjd6ogB29e2CQU7tlhd4wjXsdiVO/HpX4TxXmS1MUVaaGOwne8TJ8j
   A==;
X-CSE-ConnectionGUID: l7N5IDfNQAuj+e5nCvSjVw==
X-CSE-MsgGUID: vKVzciDsRRSIZ1ovw1M8tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3366147"
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="3366147"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 23:16:57 -0800
X-CSE-ConnectionGUID: dc1kbF9uSty/02xzcMt5SQ==
X-CSE-MsgGUID: n2UNkuk0Rxu1QGN7elkeqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,213,1787036400"; 
   d="scan'208";a="9110541"
Received: from srr4-3-linux-103-aknautiy.iind.intel.com ([10.223.34.160])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 23:16:55 -0800
From: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: suraj.kandpal@intel.com,
	Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
	Krzysztof Karas <krzysztof.karas@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] drm/i915/dsc: Fix the helper range_bpg_offset()
Date: Sat, 14 Nov 2026 12:31:14 +0530
Message-ID: <20261114070114.3308451-1-ankit.k.nautiyal@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261016101713.230013-3-ankit.k.nautiyal@intel.com>
References: <20261016101713.230013-3-ankit.k.nautiyal@intel.com>
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

The helper used to compute range_bpg_offset() uses an incorrect divisor,
causing the interpolation to occur in the reverse direction. This can
result in incorrect DSC parameters and visual corruption on some panels.

Correct the divisor used by the helper.

Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/9247
Fixes: 3abe2824e1af ("drm/i915/dsc: Use helper to calculate range_bpg_offset")
Cc: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>
Cc: <stable@vger.kernel.org> # v6.15+
Signed-off-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_vdsc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_vdsc.c b/drivers/gpu/drm/i915/display/intel_vdsc.c
index a6556a6e45b7..7a6452557a0c 100644
--- a/drivers/gpu/drm/i915/display/intel_vdsc.c
+++ b/drivers/gpu/drm/i915/display/intel_vdsc.c
@@ -122,7 +122,7 @@ static int
 get_range_bpg_offset(int bpp_low, int offset_low, int bpp_high, int offset_high, int bpp)
 {
 	return offset_low + DIV_ROUND_UP((offset_high - offset_low) * (bpp - bpp_low),
-					 (bpp_low - bpp_high));
+					 (bpp_high - bpp_low));
 }
 
 /*
-- 
2.50.1

