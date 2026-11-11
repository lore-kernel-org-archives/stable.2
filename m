Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396019;
	b=BIotr966ybEgGy2DGC8yy78SWypKdc+3xpgZ4rG8NXmfR2fb8zvfhRGZEiTFb4dh3DAq
	 vfHddeP5fLCHDsXjfihl7H2juBIpsSrvZgKIHCpec+b1gp0rybQ0+uHqWNa/uz8IzqnGW
	 n0OUgTqQOcowEnoMbcgSHQGw0RgLqDQ/xg5Rj3V2GpB42CLLquydetQUkZ+BWAmGM2KPU
	 0tCEhcOcJkd4N+Nk/szAIAeAPLQ9Zsy+La3iepD9DmLbqsKtwyNDoAmlbq1sHtTYkM20G
	 GO+dJpdlFwBuqir3iPAbeIAuEcReJ6NJZph6ipcWwUuzcY9sNgU1zzCsz2jZxwG84rQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396019;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Organization:Content-Transfer-Encoding;
	bh=FBVB8sqTtJPf8xjUZUMmIG186d2OinjNZ/8dWnuGzVs=;
	b=04WSi1JgR8ETFWdT6WSed2esWu2ie6kib/Mx6866aCCJSnEApQpkvNys2H1AhDJ1HH55
	 0pS6NHT9f1YlsXJtdthnaswOgQE1DkoivlmlsfQetOVCZzsiVFBIk6fTr8wPo1XFRI2KR
	 bdM0LubjMLZcPx7/1CREf8ewGo+yOLYlq4mA6+I3K+uo2jdKFXPtNfz5HVfqc+XpC9Uns
	 5NSap+JzYkJ06V/HHHVBS9qczWm8wIr0vXVPFyOA7Z3sAqe5K3m52k8ivLHQOKhTnbis8
	 6A6s0BxNP2G2GM3YoL50bbo/YLqWc/4kmiyCCqhMsB3EvarZhjxO1VX5UOjQLAatIBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GgA5c049;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795E8606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:20:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 795E8606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GgA5c049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794396017; x=1825932017;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qNLc7C/ksAcsb1zqBb542iU+5OkYDuDq/tXyx0DCpHw=;
  b=GgA5c049Hq+s8nzLx67wzZX8lcsTSjvRvM10ZuxSg29msPwymDH3F3zg
   s9aEAdsCEWfkHTxP5y81WFIMQXjkIpN1mJDXJRn9XiajPIK1Ub1C6dWE5
   zWL9M+XKQDjGszjKKwp37IVZ8eOqE+plEsnUV19aeiEd+AHv6iWFZTx9s
   905yTcuavA4XAm+jxpbEFTe48YfnfSBM6TxRX+zjf1XfK/EixbKWiv9ET
   YraER4FKiRM5YfB+Zt+jOKI0KE9lI3b9KQp5ywXzIxYkqXsTsdc/Y5Jqt
   69skc8pWqNap6LTkZbJE8RjWoBHFi2RooOWMwP9hUcuyoqYJW09PSbzSR
   g==;
X-CSE-ConnectionGUID: MkhwyXGcRa2yI96SIGFqyQ==
X-CSE-MsgGUID: LO/dGOG1Rbu35nl/le+gHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11962"; a="3209258"
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="3209258"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 03:20:16 -0800
X-CSE-ConnectionGUID: b8OHYNjWTOWVHwESFYhbWw==
X-CSE-MsgGUID: 5KUBlb3aQSyITb2L3zFDRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,207,1787036400"; 
   d="scan'208";a="8560457"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.181])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 03:20:14 -0800
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 01/13] drm/i915: Bump surface alignment to 32k on MTL for async flips
Date: Wed, 11 Nov 2026 13:19:55 +0200
Message-ID: <20261111112007.16790-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261111112007.16790-1-ville.syrjala@linux.intel.com>
References: <20261111112007.16790-1-ville.syrjala@linux.intel.com>
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
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

MTL is seeing tons of GTT/ATS faults on async flips. Bump the
alignment to 32k to work around the issue. The magic number
was determined empirically. We already have a similar
workaround for ADL, but there we only needed 16k alignment.

I looked at this case already some time ago, but didn't really
manage to root cause it. It seems to be a bit more nuanced than
a simple "always need this much alignment" because IIRC I was
also able to work around by adding some guard pages around
the DPT mapping in the GGTT while leaving PLANE_SURF itself
still misaligned. So maybe some kind of prefetch thing or
something...

Cc: stable@vger.kernel.org
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index def4798f8502..667abfc31464 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -591,6 +591,15 @@ static u32 tgl_plane_min_alignment(struct intel_plane *plane,
 	if (intel_fb_is_ccs_aux_plane(fb, color_plane))
 		return mult * 4 * 1024;
 
+	/*
+	 * FIXME MTL sees GGTT/ATS faults with async
+	 * flips unless we align to 32k at least.
+	 * Figure out what's going on here...
+	 */
+	if (display->platform.meteorlake &&
+	    intel_plane_can_async_flip(plane, fb->format, fb->modifier))
+		return mult * 32 * 1024;
+
 	/*
 	 * FIXME ADL sees GGTT/DMAR faults with async
 	 * flips unless we align to 16k at least.
-- 
2.56.0

