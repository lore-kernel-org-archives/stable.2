Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881173054EF
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553854; cv=none; b=M8bjSp4SDu/gvAtgQuweLACN9OnYfExmQ7syDw/VqBZ5PBS+MrawR5QQJQdovGCfFZTpHz6ltLAxQjGRRVLUF8XwB/yA5VZF0Ko0hJnMF+KEgMNF/cKd79jqm4Mcu7kU5V/jJVwG0iSXRX7SVuXGLaL6sXHQoAmClrPuI5h52+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553854; c=relaxed/simple;
	bh=iSdZXF5zHmZP8CmU1w+zURfFrLDs/HEiBrTn13AlG9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HSh80CLXq9/fwPb7ORA7b8enBomTW51mZCa8VXMEiRb++CD+Gx0iePWCxq9paIvDgN3BLgS2Jksf7p7z6XI9h+IU5jHYXDlmQWY+s6SHdgneCBfV/9Jf6fG/OHu5Ep2JaXpv6MqNaOEsgMr6PXT3PogirU/HEMRPF2fOwoMKUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwTTooNt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwTTooNt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D0F1F00AC4;
	Sat,  1 Aug 2026 03:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553853;
	bh=Ly7jxqiwIhdJNT4lLGAT6sPDEd5idT1afjUPSuOgQ10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RwTTooNtUH9nTI2AMYxTBrRs+XG/VlYHyIwJBThXgnrCD+5FNDcQSOumrkWSWU0CE
	 ggrovYtjU+HY+/V9rS7BuaGTIcANGcz9gGsKqctRUMg/zDFZos5VUN160teKdl99Rs
	 xAVJ2TXFsakrJEvFqpbVS6tG9SY/2zQXvvoI7cJXJbhie6GWRhTvVBqXsPrggoHNO3
	 bElZOAZDVy2FXioE/HYrBV3cXOBejyasVlZmp9kQmjxyR4gcwpuKbbL6G3hnvFWoTb
	 gKo1mkV+qrLh+LRLL6r6/f3fsMJlWoxiXKFzc0AHUVQbXtmnuVRE9opQHdkaughyIp
	 zcCTS/GHlyzVg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/8] drm/xe/reg_sr: Stop setting all whitelist slots
Date: Fri, 31 Jul 2026 23:10:43 -0400
Message-ID: <20260801031050.987390-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072902-purity-frenzy-fc0b@gregkh>
References: <2026072902-purity-frenzy-fc0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas De Marchi <lucas.demarchi@intel.com>

[ Upstream commit c1151691b5e97b600a9ef3efd7c31a3abf568e41 ]

Currently xe_reg_sr_apply_whitelist() sets the unused values to a known
used value for no good reason: it could just leave it with the HW
default. The behavior is slightly different if there are no whitelist
registers for the engine as the function returns early. This is not
needed, so just drop the addition writes for the unused slots.

Later this will allow to reduce the amount of registers passed to GuC
for save/restore.

Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241209232739.147417-5-lucas.demarchi@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Stable-dep-of: e70086a3a06d ("drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_reg_sr.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_reg_sr.c b/drivers/gpu/drm/xe/xe_reg_sr.c
index ae9e6df2f4e1..e7da8e97b39c 100644
--- a/drivers/gpu/drm/xe/xe_reg_sr.c
+++ b/drivers/gpu/drm/xe/xe_reg_sr.c
@@ -230,13 +230,6 @@ void xe_reg_sr_apply_whitelist(struct xe_hw_engine *hwe)
 		slot++;
 	}
 
-	/* And clear the rest just in case of garbage */
-	for (; slot < RING_MAX_NONPRIV_SLOTS; slot++) {
-		u32 addr = RING_NOPID(mmio_base).addr;
-
-		xe_mmio_write32(gt, RING_FORCE_TO_NONPRIV(mmio_base, slot), addr);
-	}
-
 	err = xe_force_wake_put(gt_to_fw(gt), XE_FORCEWAKE_ALL);
 	XE_WARN_ON(err);
 
-- 
2.53.0

