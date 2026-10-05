Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977D41A77C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203891; cv=none; b=NxJRvkEw0eYwzeUJswv7Fss1k1mWUQ0PdxIkBsW1t4WnVC2WfnpWH8gw6+cJKPH+QA51+urm1mpFuutqxRdIeZBQh8y3/ZjE3+GpnauKIOlUYwEHXZdZrch4EFBFK+ujfqJfFGQ2VAAmNPDDkOJoNPbP/uZenG6ybNATvQP/UpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203891; c=relaxed/simple;
	bh=8gudKLf9uJ+hjH2JzEw6N8naGJyGFkShXD1DRKlstFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h2X9EEyVlmi7iL8Q6CiDUV65O/CwcQSOWUrS6MeCercywy+QmGEmt+yN1t9GD0KcQLT8qgbdbfdEW17x9VNu8DPuwrK+7BVL3uWRGsezOBuE4NWm+U6ouoRU2+Thuzq3jQieV5xDS+iLg2MgK6s+8CEXi8EzcQndSP1i4RZEuB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gUrJwnCj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gUrJwnCj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC6A21F000FF;
	Mon,  5 Oct 2026 12:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791203889;
	bh=pZQ026Nax+F1HCVSFVvw5ZbhKI/GUFgGQxa52NpLins=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gUrJwnCj7FH4WaqM/9zDxSP/Z3LlQ0CGzVJPkFEYezUNjEAoX2dHJcWO/8LQ/2Y/T
	 7RWc54R+HZmsfG50+v52sGx5geaPHeXu/q+XDIIpX3B+i6PlAlQwfIZbNP9xZdh8OE
	 keWyJ8l4afAeqrQVmilWuRh11V0j+wtwxpU99EQZU4Im8vS7wtByz5IzxEc8rxT2WU
	 U+vtXPH3IyrLAZ+GZWLrnke2aSAKhhER3NeVIWc6sDt8lUhAWiz84ETJlq72y5CSMg
	 oKL3H8WBBvZR38ZH/Ik0bCRgL0W+tjzgDSnXJS6OM7cyyj6f449TUbbgw/HzW3o3Av
	 5rEVXKh2acRbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arthur Heymans <arthur@aheymans.xyz>,
	George Zhang <george.zhang@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Preserve eDP mode on initial ASSR failure
Date: Mon,  5 Oct 2026 08:38:04 -0400
Message-ID: <20261005123754.1908896-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100540-reassign-willfully-2f3e@gregkh>
References: <2026100540-reassign-willfully-2f3e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arthur Heymans <arthur@aheymans.xyz>

[ Upstream commit 5e08102d1d336593160d1434261d50b0c0f6cbe6 ]

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
Assisted-by: Pi:gpt-5.6-sol
Reviewed-by: George Zhang <george.zhang@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Arthur Heymans <arthur@aheymans.xyz>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ccb6c2702033f1002b45807fb3cc938760f26f78)
Cc: stable@vger.kernel.org # 6.4.x
[ sashal: Adjusted context to preserve the existing diagnostic-message formatting in dp_set_panel_mode(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h                           | 1 +
 .../amd/display/dc/link/protocols/link_edp_panel_control.c    | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 390f948dad393..a24a225f3de81 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1624,6 +1624,7 @@ struct dc_scratch_space {
 	struct ddc_service *ddc;
 
 	enum dp_panel_mode panel_mode;
+	bool panel_mode_initialized;
 	bool aux_mode;
 
 	/* Private to DC core */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 5e806edbb9f61..4d2d4b7fb5806 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -91,6 +91,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 	}
 
 	link->panel_mode = panel_mode;
+	link->panel_mode_initialized = true;
 	DC_LOG_DETECTION_DP_CAPS("Link: %d eDP panel mode supported: %d "
 		 "eDP panel mode enabled: %d \n",
 		 link->link_index,
@@ -1293,7 +1294,8 @@ void edp_set_panel_assr(struct dc_link *link, struct pipe_ctx *pipe_ctx,
 
 		result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
 
-		if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
+		if (!result && link->panel_mode_initialized &&
+		    link->panel_mode != DP_PANEL_MODE_EDP)
 			*panel_mode = DP_PANEL_MODE_DEFAULT;
 	}
 }
-- 
2.53.0

