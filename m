Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19D030DEA3
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 14:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789222857; cv=none; b=kGWL5U8Bd9mpt5KeEQXCJwr/eQhs6021Ij5F1jPxGnbeMrHcCZodwGHtIAUkLw2WKOOlfb66HdExucbJ1Wwblnxsn34x/mI6voFd6hsWVtcLExybHdP1s37Ix8F4LoSh2BgPE25WuJ+in3ab4qymhfHsX3SRxmw4Yf8xZn+dbeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789222857; c=relaxed/simple;
	bh=KuWk7cc/t928C9mAHGzc3+VAo/HwBU3h9Cs/wZ3EeEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1tkHOOaJ/PK4VKcANLv5zZNHk+6vBEZjAAStAxRdVOCsOWEVh17AK+4m5Hf70rDRIYkTPluW/agZwlONAshlJnfy+LK6Aaaq1vBqPdLqm1ODsi9QBgp+8IhqPIC3ZAvSXVVzs4dQwDPiswVQvKTSQZWYRBzRNcZs3+0m4hymH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdncN60o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdncN60o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC451F00899;
	Sat, 12 Sep 2026 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789222856;
	bh=k25g4TqTYZBnYexzc991Bz7Wo3zEWtRLNzLFYSktVaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GdncN60ojiBrGauci6frafWHhZQg+eiPSompyICDMsv24vz3V1qHuAHkrA+9XKGew
	 WYx5Mn7R/xTLR5xD2kx9HIc6L+K/WWIxNUUrSjdUciqF3KLOypkwBCeLYysoyjG7u6
	 ihnUcn6Ikv1TdYpQXH5xzMiTJ8lHY8ZpxcDjH8xwvw/wDxB+Ao2C71UQBhWnM03Bbf
	 LrBCg8OPJpsqWLgVmxxA/85fTFHE7tehzbryaX0jFfrQccYFPybvWmWdvnvhDI5AEt
	 uG2bEJ9Z0bFnMFLwcOfWOlAreJ/5Q6SfCg41/fygWtJhxdmfbgT7ihOmvGop2+Q4Ud
	 eJ6z+z9uO3YEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] drm/i915/cdclk: Avoid spurious cdclk sanitization on PTL+
Date: Sat, 12 Sep 2026 10:20:54 -0400
Message-ID: <20260912142054.2911854-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090942-slot-trapeze-8273@gregkh>
References: <2026090942-slot-trapeze-8273@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit aad969968824e97ba8d70dd7a95691f750438ebd ]

Apparently PTL+ no longer has the cd2x pipe select field in
CDCLK_CTL. Take that into account during CDCLK sanitization.

This currently triggers a spurious CDCLK sanitization during
driver load on PTL+ which will causes a visible glitch on all
active displays.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8550
Fixes: 2ee8dbd880b1 ("drm/i915/cdclk: Fix up CDCLK_FREQ_DECIMAL without a full PLL re-enable")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patch.msgid.link/20260717155107.17801-1-ville.syrjala@linux.intel.com
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
(cherry picked from commit 1786d26887817a779641d3a093c66ac91382113b)
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
[ Replaced bxt_cdclk_cd2x_pipe_mask(display) with the equivalent bxt_cdclk_cd2x_pipe(display, INVALID_PIPE). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_cdclk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cdclk.c b/drivers/gpu/drm/i915/display/intel_cdclk.c
index 7bc9b956554ba..0438f5ac78c02 100644
--- a/drivers/gpu/drm/i915/display/intel_cdclk.c
+++ b/drivers/gpu/drm/i915/display/intel_cdclk.c
@@ -2366,8 +2366,10 @@ static void bxt_sanitize_cdclk(struct intel_display *display)
 	 * dividers both syncing to an active pipe, or asynchronously
 	 * (PIPE_NONE).
 	 */
-	cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
-	cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	if (DISPLAY_VER(display) < 30) {
+		cdctl &= ~bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+		cdctl |= bxt_cdclk_cd2x_pipe(display, INVALID_PIPE);
+	}
 
 	if (cdctl != expected) {
 		if (DISPLAY_VER(display) < 20) {
-- 
2.53.0

