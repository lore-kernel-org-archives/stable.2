Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB01D4CE68A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231344; cv=none; b=aCJ6LNZJbwv3jhujeNVrKqnmfHR997sZ2T+agyy7lwdFQFvOkx4tcQWr8+euT+nCgPiBv4oWx/SDtPJvcVieeb/ZTtXI5Njy0jS15QXl2noyZEDQdGM0Of+kdwXy6z9h1Yn3sZa+5E7OKHhCwdyKdSEOeFvdK8/YkbV0/pVQbvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231344; c=relaxed/simple;
	bh=QwxDB1FpYafbNsLTcJjfhQKWrqKqlDwEs+muxCcA3Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O7Bm9++mZjFG5npB/cGvpdffG9pmHnstJ0SJ+EtUXiyuIObHsdn7CdEFmXtCMQIh8OfGgNSaW5rzB6olhhrTS2QFDlTHa+iQPx5707t1/l2Lfx01y8KpDieD3l19BkUufVUxNcVI/oUzrdvlVsnJ/GTvmstyyJPUaUMx6q+pQE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jP3j5NQS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jP3j5NQS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B98F41F00893;
	Mon,  5 Oct 2026 20:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231342;
	bh=IByj082Dz4VkRreboErMETumX13OH5Qz2qksEygUklo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jP3j5NQSLpsr2vhoMt5hxCKK4fjRgLLZf7AOqy73rkqKxW+vmVZDtDc0z4yFik11U
	 ofJld4rpyJwBDvMsWwSfc9XKqnWKyrc7VSZcdPCmLiwTUcYi1JZ9+8VzT0BWEoeXcv
	 MZOR4LwJQkW2wyq0k41YSBSwsdccmA05dUnfRuz6yZbM7tisoRJkzXM9l58nt5fqF4
	 czBskEr5LVxf92zDWLePjmBj18NMsQjJ8WSRXa/J439jPgW78JND4BrYtHN3elXQlQ
	 ZD5X4Fi1iEtA0T1mqs/kSa0rHdZmMRmkZSHawJysyoeDTmrDU1PcYMNw6r4vPrS+tj
	 79us5IOQURpdw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arthur Heymans <arthur@aheymans.xyz>,
	George Zhang <george.zhang@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: Preserve eDP mode on initial ASSR failure
Date: Mon,  5 Oct 2026 16:15:37 -0400
Message-ID: <20261005201510.3061340-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100542-ripening-rematch-74c5@gregkh>
References: <2026100542-ripening-rematch-74c5@gregkh>
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
[ sashal: Applied the ASSR guard in perform_link_training_with_retries() instead of the absent edp_set_panel_assr() helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dc.h                            | 1 +
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c   | 3 ++-
 .../drm/amd/display/dc/link/protocols/link_edp_panel_control.c | 1 +
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 88e64b280c90f..1f4292336692e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1512,6 +1512,7 @@ struct dc_link {
 	struct ddc_service *ddc;
 
 	enum dp_panel_mode panel_mode;
+	bool panel_mode_initialized;
 	bool aux_mode;
 
 	/* Private to DC core */
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 539f57858dfec..aa46e0e84ce4f 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1608,7 +1608,8 @@ bool perform_link_training_with_retries(
 				 */
 				bool result;
 				result = cp_psp->funcs.enable_assr(cp_psp->handle, link);
-				if (!result && link->panel_mode != DP_PANEL_MODE_EDP)
+				if (!result && link->panel_mode_initialized &&
+				    link->panel_mode != DP_PANEL_MODE_EDP)
 					panel_mode = DP_PANEL_MODE_DEFAULT;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index d4d92da153ece..9f7ace40092ba 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -88,6 +88,7 @@ void dp_set_panel_mode(struct dc_link *link, enum dp_panel_mode panel_mode)
 	}
 
 	link->panel_mode = panel_mode;
+	link->panel_mode_initialized = true;
 	DC_LOG_DETECTION_DP_CAPS("Link: %d eDP panel mode supported: %d "
 		 "eDP panel mode enabled: %d \n",
 		 link->link_index,
-- 
2.53.0

