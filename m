Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEBF31618C
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789225902; cv=none; b=bMJhFAhU3/mxCWJWeWXXaIq0++mpxIYkZBu7dYWlrpUpEVXQN28StPrevT53TS/erW1ztADemy1ZOZme+Uw/LBo8kH1bfXOBKYW3ro0IqrJI2URmLQy3ctv97t3abk3excOuHAS5RdwT3IIO4gYDdJjHHZJe2wfMiLLN0fRZx3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789225902; c=relaxed/simple;
	bh=lSNHqvRhMHGwhckSbpdghGzhXyliVNB3ylXTKjvZ0Oo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tsLG5+NUZwqaQzTgJ3kKEP5F1YkvhSYShVfcDmWcsxw8Ls1ZuM4Zd/IGSwgGhU3jkCnP5u/plAarAznjD4yYnYtMtTf9uMBhkzZV7zHIaS4bDhu4TmNfqjnMIToF0ojhOH2zENGykMllrLNFviWUEKMbR0MMqYnJMMcsBY7o1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz; spf=pass smtp.mailfrom=aheymans.xyz; dkim=pass (2048-bit key) header.d=aheymans-xyz.20251104.gappssmtp.com header.i=@aheymans-xyz.20251104.gappssmtp.com header.b=lzGz5IHt; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aheymans.xyz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aheymans-xyz.20251104.gappssmtp.com header.i=@aheymans-xyz.20251104.gappssmtp.com header.b="lzGz5IHt"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49cd38e0f79so3850145e9.3
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 08:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aheymans-xyz.20251104.gappssmtp.com; s=20251104; t=1789225899; x=1789830699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNp2ej2UnoB5ep8eGYhUlJSsYiFkYUAkgSgRSLrvMp8=;
        b=lzGz5IHtdYHxzmzApAljNy2K7DMePqMft9KM2wG7lt/0tn7y13ypuPr3nodlREZiDO
         WAZknuqnJ6z2mxMyInRrJq8DNZovJvKKmgVQbbcF6fd4k32hrerIiAWL3raDMpdatdbL
         AZs83vf3a2qBnI89M07tzY/G1HPvRUiVcartsPUIrXGSJxE+OPLiODXWfJVyTyqHtIrL
         qa1mrEBHvL7knK1VdpKvNm3a5rLnsaVoPw4jgerNrSl5NnuhdpZkioBfY7Fjz42czn09
         L1USwypVcgmvfXWqSB5v99oDgj30RTn7cwtwgBwn1s2FRvCrLH0taOSSDhZvIzhe/nlU
         6uRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789225899; x=1789830699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UNp2ej2UnoB5ep8eGYhUlJSsYiFkYUAkgSgRSLrvMp8=;
        b=mUoJM0OP0uc9zlPjbggGRH3amBlxB3UUG7o+FzDp6y5ucMlUbfg7YseZdN/iOQE36E
         SuIAgJTSIRQlizxoPAMxj6+oUglVzJ6L4jkBlahN6xfVuyZUXl57kj8KvWrCIaVXClU+
         IyggNJOY/ZdiWK/xdvxyY35+Bpo5J66MJgS+GOLJovGX3tDTCdttyy6KBI0RgxxosPc6
         PhJScH5HoHqt+Ju9UaxcaYTgMlwOjNeGm9JtVhcegab4Ofh6wvu2uofP1Z+3auhEggDh
         BlSuq87vJLQv+ksmCqW18jISQ3lXif1dqFtKYe/kMqzCfxpC8RSdiP5XnlLiKvgAl9uA
         L5cQ==
X-Forwarded-Encrypted: i=1; AKwUvBzxPhuzJFodjdtxhACKhSHqQsDKWN19ctTrt0emzHv+m0rSLWFL3biv+KoYaCa2tRzGhmr/33o=@vger.kernel.org
X-Gm-Message-State: AFuF++kiLl0aPtWY6BEWYXL9bIRtr9f21h5UEg2DTZuTH+1gX5l0Ld38
	qF1vun8bMelgV0eob4CvnWHPn4UtPnphpWH3VsfEFhDRYZQ6vOgsKvQyRQ2egbrJe0o=
X-Gm-Gg: AYBFou2h4mVkyYknZb+rg55f8Ne4b3mzsstwkmGa3zp30gBxnRPQhgwucwenPogaUFI
	Z20MhKsgnxFkpe/egQ7M2isJ618FEBI3XUuFb4lDGNBZczWJEQGeO6ZDZ9DhmvQFh/nKp8lFaVd
	fobwAWliUYHs/WkjH1R94QJMEe/YrGhzk6JYnosYZ5ReR4V8pnJ/3hDo/AeM4h0ehek8OQyJBXS
	WSqKsgzuCQqRjUOOH7bhQtyDak4bDGX8fc1g5rgIajhm/BLjTOKf3a2h84wgoef53xQ8Fv87wg5
	nqTzm9jujnDXMEJpizCPFh+GUBJl/or2f6+XasE4quO6NfrJ1y0If5q4mIlHoApYXs6wE6TK9zL
	Xfmyg9y4VrscrSlMMQ77SnUJoUDAklOxH2GhIcnRVwDvIOi0kKOFNu9mX2klasCbAevWYmeLHU+
	8xH1fQf2fyTYdJ0Pyr2VGZz4nMiP0cafe9aWyfpQ4A3KraaZd/x4b7SR2s6uldQQbOb5qg06YLy
	MTFfyk12p5ZRXSKDEVYqmbhGBFoqjfvFHUtudMAK0q0dFa+k9/lPnLPimo38VStQe645hl4Scyo
	OW81ieSauAWtrsRmwNCJ0BFjrU5gyF94FGimkks=
X-Received: by 2002:a05:600c:2301:b0:49d:2555:1a6d with SMTP id 5b1f17b1804b1-49e619cbf88mr155925425e9.16.1789225898398;
        Sat, 12 Sep 2026 08:11:38 -0700 (PDT)
Received: from localhost (2a02-1810-b422-d400-af60-1d41-c104-7560.ip6.access.telenet.be. [2a02:1810:b422:d400:af60:1d41:c104:7560])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaeefsm162063135e9.12.2026.09.12.08.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 08:11:38 -0700 (PDT)
From: Arthur Heymans <arthur@aheymans.xyz>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com,
	sunpeng.li@amd.com,
	siqueira@igalia.com,
	alexander.deucher@amd.com,
	christian.koenig@amd.com,
	michael.mityushkin@amd.com,
	nicholas.kazlauskas@amd.com,
	qingqing.zhuo@amd.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Arthur Heymans <arthur@aheymans.xyz>,
	stable@vger.kernel.org
Subject: [PATCH] drm/amd/display: Preserve eDP mode on initial ASSR failure
Date: Sat, 12 Sep 2026 17:11:37 +0200
Message-ID: <20260912151137.3913987-1-arthur@aheymans.xyz>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when
reinitializing hardware") made ASSR failure fall back to the default panel
mode unless eDP mode had previously been applied.

However, dc_link is zero-initialized and DP_PANEL_MODE_DEFAULT is zero.
Before the first call to dp_set_panel_mode(), panel_mode therefore looks
like a previously applied default mode. If ASSR setup fails during the
first link training attempt, the driver incorrectly trains the eDP link
using the default scrambling mode.

On a Google Vilboz Chromebook running self-built coreboot firmware and
PSP verstage, this leaves the panel mostly black with corrupted output
along the top edge.

Track whether panel_mode has actually been initialized, and only consult
the saved mode after it has been applied. This retains the recovery
behavior while preserving eDP mode during initial link training.

Fixes: 56d8ce9d8c17 ("drm/amd/display: Apply correct panel mode when reinitializing hardware")
Cc: stable@vger.kernel.org # v6.4+
Assisted-by: Pi:gpt-5.6-sol
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4ecd5699ac5e..0db55a73da0c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1912,6 +1912,7 @@ struct dc_scratch_space {
 	struct ddc_service *ddc;
 
 	enum dp_panel_mode panel_mode;
+	bool panel_mode_initialized;
 	bool aux_mode;
 
 	/* Private to DC core */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 9883216dcc9d..cd90576bc6f0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -93,6 +93,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 	}
 
 	link->panel_mode = panel_mode;
+	link->panel_mode_initialized = true;
 	DC_LOG_DETECTION_DP_CAPS("%d eDP panel mode supported: %d, enabled: %d\n",
 				 link->link_index,
 				 link->dpcd_caps.panel_mode_edp,
@@ -1300,7 +1301,8 @@ void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 
 		result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
 
-		if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
+		if (!result && link->panel_mode_initialized &&
+		    link->panel_mode != DP_PANEL_MODE_EDP)
 			*panel_mode = DP_PANEL_MODE_DEFAULT;
 	}
 }
-- 
2.55.0

