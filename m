Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675123909A7
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 03:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785553858; cv=none; b=PwICBw0w9OKKvmvoWW8oF0LB7Bz2hK3tDJnoNefbvuEakh4OB/2THDGwYzTjPmuEM5PGcFcptAMDxIUCTnGs4BxO6GHCTfDwT/rKYXodi90gGJmpf50zhn0AILFKwX1nXQbukV3759xJRqQASE4hl4NU2ggVhGK1BcL777Z89Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785553858; c=relaxed/simple;
	bh=WdCwvS24D0gKLKNH56n+Bb4bQY13bAYOVneK8UxlUJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sXAHXFtWkmM/kMcuWgoE2Hb30CRx2gkkm5SEqbkYir9Sw3wZgzxrU/4Fqrf+joL6CRCZ6833kQHx2xdJ5Q3s2WcC5R7z65VXbxTq0qkAvuhnAWCqii1Ae4dLxUBl+cQbsNOvMarV2La0NJXOwidvAxcesLfD8gXfPZyqhyK6f/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oODMKYxP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oODMKYxP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C381F00ADB;
	Sat,  1 Aug 2026 03:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785553857;
	bh=eYPp5AfN3A43FvuvM4qwDFKY78OgFOAe5muhDplvGjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oODMKYxP31XU3mDxqD5+LvOqdvD11nXKv0SKCJiJWjC83c04DqPpvOQqAoUVOoG/4
	 SMNEJPRkWTjoTa3ZYYYV3jMw5BVbtGF/WSEy4fIfpwP6Rk1G8djBr6sJkGB3MU05s+
	 a1S622Ok9V59M6yAA/RXnCD9RbBzVU+T+CYiwKBTZILwOWNJSfqxtJ4CZZ1X/t65lO
	 +/PRN2wGOdhFiRy/j4xeYDFZSQOsPAHenae07jw/w2QUHAlcObXEP9C9k+ku8p4sco
	 KiqCH323sMXq0dewSjsToPxFrGOPANXEEkVZmvU00Jlylx5BTA+rdqrmYPaDhQuktU
	 BT7460P2yx5GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Tapani=20P=C3=A4lli?= <tapani.palli@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 6/8] drm/xe/xe3: Apply wa_14024997852
Date: Fri, 31 Jul 2026 23:10:48 -0400
Message-ID: <20260801031050.987390-6-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260801031050.987390-1-sashal@kernel.org>
References: <2026072902-purity-frenzy-fc0b@gregkh>
 <20260801031050.987390-1-sashal@kernel.org>
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
index 57c6d39b2f1e..b568686973a8 100644
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

