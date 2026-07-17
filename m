Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A47314D35
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303475; cv=none; b=ABKQxywhA82X+LCnSSplx9XB18idR9pdiw0OYdI7pfIMfM9kNqAiJ5NfQ17lWmT5Yp++ra8Ai3CasdmYUogYBY19i9k9br5EfcZ8ZGZhYCVUoyRpgi5iPa99RBaXTlN42b+lhLLSNtLOA+6Hg68xBAzfWrJfUzThOSASLwxvvKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303475; c=relaxed/simple;
	bh=GYJP/Qkkuv8SC1nesZ+zygEQnpqogv4O8mP20JmumIg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PVDzwuLo97kXsRU9M8iF0uJBScVONa8qE5Lh706X1JvE9Yme4DaTr8yCNDQyuqhpLiuN7xGikJ88Q/mKNsBTMMnMz7uy/3PKCgQHxQzec4zTMxb7KGKDOEhjzWnwYx1SVttikrQ1eUD8Zy1SHhpdBfd3a2DuESvuWh8001wJIZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DVsv/XcZ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DVsv/XcZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784303473; x=1815839473;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GYJP/Qkkuv8SC1nesZ+zygEQnpqogv4O8mP20JmumIg=;
  b=DVsv/XcZMtxM+DT0l5WQNZjQ7iRbsrxicVgnMCjUurmIixEsrhnecbat
   JXkR00azxQH6aggPQ8yonltu55EutQ6sr32FSFxLEpq9t1ryIEQj0FpIO
   fB758zN9oZ9jVX9o+c8ai+fWqMRGidoDETjogSRmIfKsSi0MIYVqKu0Xj
   EXpAfVCq8I6Nfa5ej9iNPSycV6P1G3aMguA59lTXs/tKam/YRBYpo4nCr
   uT9Tjx9kiqppdXRfDt4r6cxSWre6SoG75D4kvP3bLJ9zyutW0V8Pc2l91
   9zSFppgvMXntFOfoJmMfxElqhTOxQvdF5jYDrqJEjqvo1x2/Nq2ni02db
   A==;
X-CSE-ConnectionGUID: 3onBN8tzT1uIBs4uuRLT3w==
X-CSE-MsgGUID: HOcbt2q8SxOFHJoVckmfUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96112550"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="96112550"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 08:51:12 -0700
X-CSE-ConnectionGUID: 05KjFR8HTwO1JHWIrXr50g==
X-CSE-MsgGUID: nAsNTk8cRAmFYlI9eCCxng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="257452336"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 08:51:10 -0700
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 1/2] drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+
Date: Fri, 17 Jul 2026 18:51:06 +0300
Message-ID: <20260717155107.17801-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs Bertel Jungin Aukio 5, 02600 Espoo, Finland
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Apparently PTL+ no longer has the cd2x pipe select field in
CDCLK_CTL. Take that into account during CDCLK sanitization.

This currently triggers a spurious CDCLK sanitization during
driver load on PTL+ which will causes a visible glitch on all
active displays.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
Fixes: 3f9de66f8acb ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index a53d88727177..9e5e15b0c4d1 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2381,8 +2381,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
 	 * dividers both syncing to an active pipe, or asynchronously
 	 * (PIPE_NONE).
 	 */
-	cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
-	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	if (DISPLAY_VER(display) < 30) {
+		cdctl &= ~bxt_cdclk_cd2x_pipe_mask(display);
+		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	}
 
 	if (cdctl != expected) {
 		if (DISPLAY_VER(display) < 20) {
-- 
2.54.0

