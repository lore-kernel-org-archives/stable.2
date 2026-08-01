Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA781D130E
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785545144; cv=none; b=WeXnSStmKsbqcGGumwtqqzGElZQqL67RpLKj/181qoBVWrI4f3BZDIqgkKRZLrslDp/znytF3C4W1QMlqGbKBeERtkKGMIS+XscXJf8tfKx+wkURCIP4Nt2SlC4OCtDqdubUS9df9SyukYn2jGdQXU7lzUM5kUUQEQQ0wxpmwlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785545144; c=relaxed/simple;
	bh=xtwaH00Ak/fkdPxsEaYUmSY54Sa/IpGRMFGDWb9mjq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIntEXEQJuUx9+tfjncvFx7hA+kLmpPBjomAoenhBGD4t+a/o/LqVsS21bL5AYliiRqAx4GsOOvJ1TVdxs0TLl4ZFQuUgflzZuDbm3RnpomnBDnEF3OwpexxVNZb9VNtHlUSOkUJZqCgwM2iiL/YN41GciSgaDYRVj8zeCnPhsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rrc2c2vQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rrc2c2vQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63D1D1F00ACF;
	Sat,  1 Aug 2026 00:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785545135;
	bh=6u1103nSyw0E/9TGF/cGY6zS/xQaw50C7jO4I1niAbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rrc2c2vQ/qRwlo9IiY6xlaegEQ6DaMnbeAVj3HsEvVDLVUVArsniKpeoI+EIpHfUL
	 LUx8P83MAitlSvD1EWUDznoWfuVOKkAa2x/3xEuIBrWIG9wO1o9McJh0aLUdDDLoZJ
	 F9EtA95xRUAuX2PO+Rj7ihpS664fZ4TV6fwCMYvpjrtYJ7F2PGrkH69w7h7s0QflCb
	 3k2fN3m4g4fKtLc4yPAzXuUgMYPmkAkDBSx+tOTd2Q1+fQk9GyDjJfzzhKMo/rcVSq
	 GummU3kf9URclkCQR5erb9+/KMKwnK4Khjb5VvWAlcBkqTzTmPyNVb3rKLE9QuXrKe
	 sV1bE1QEcoFHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tapani=20P=C3=A4lli?= <tapani.palli@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] drm/xe/xe3: Apply wa_14024997852
Date: Fri, 31 Jul 2026 20:45:31 -0400
Message-ID: <20260801004533.3663723-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072902-gorgeous-negligee-5e08@gregkh>
References: <2026072902-gorgeous-negligee-5e08@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tapani Pälli <tapani.palli@intel.com>

[ Upstream commit d24f7d1f62e2ed1bce9664566c32ea13677958f4 ]

Whitelist registers needed for userspace to control autostrip on xe3.

v2: fix GRAPHICS_VERSION to match xe3 (Matt)
v3: use GRAPHICS_VERSION_RANGE to match all xe3 (Matt)

Signed-off-by: Tapani Pälli <tapani.palli@intel.com>
Reviewed-by: Matt Roper <matthew.d.roper@intel.com>
Link: https://patch.msgid.link/20251029085057.54210-1-tapani.palli@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
Stable-dep-of: e70086a3a06d ("drm/xe/rtp: Add RING_FORCE_TO_NONPRIV_DENY to OA whitelists")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_reg_whitelist.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 21763dc51150..9f4b56808a27 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -88,6 +88,13 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 				   RING_FORCE_TO_NONPRIV_ACCESS_RD |
 				   RING_FORCE_TO_NONPRIV_RANGE_4))
 	},
+	{ XE_RTP_NAME("14024997852"),
+	  XE_RTP_RULES(GRAPHICS_VERSION_RANGE(3000, 3005), ENGINE_CLASS(RENDER)),
+	  XE_RTP_ACTIONS(WHITELIST(FF_MODE,
+				   RING_FORCE_TO_NONPRIV_ACCESS_RW),
+			 WHITELIST(VFLSKPD,
+				   RING_FORCE_TO_NONPRIV_ACCESS_RW))
+	},
 };
 
 static void whitelist_apply_to_hwe(struct xe_hw_engine *hwe)
-- 
2.53.0

