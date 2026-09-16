Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31D4BA1F3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598804; cv=none; b=Co0P4KlcGcnAxAxGDkVs0EcUeVrYKBLfE+D1r2a4BlF4E67VgUIXf0kasJyYwDzPaxBHAzvKlli7j2fGjEJR3be25PB3vVQd8sSllQ26ofwCX1QJe1zNuZKxvlw86jZbhHk63sp7uEfRZq9kV9ru8cNkyemFbOeIt9U/wdg7vaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598804; c=relaxed/simple;
	bh=mXdTieoeGh5Q0aN4RPKuT+OjQEjyYUt5vwDm8KE5RZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qbHPdkP3ITIbPK1DyGik+RcGlUcLT8HooIQafONkX2W4X8efOL5TIFWm9CWzrYMHD1FEooYi81ViRFwXzt9+NgKZ9wxWJQCfp5OD74k1rbMM+a9BTNGLJWEdhKPrpClNOu5mdu5R7raotdlMEfdCIn03Xz8UlCkMvkxaY4fF/x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TI/vGvFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TI/vGvFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0071F00898;
	Wed, 16 Sep 2026 22:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598794;
	bh=8PkFGu8R08agGXEH0xMpiXl4DVPsWvdbhuSy12xc7Zk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TI/vGvFMrjLEri1jrX6wsHowbFA+8W/kLBm0tRxhEZ1DSigxQpv/hU9QSK15IyRHo
	 A28IYFc/r66+a4surx9T+JX155wuzUJ0XoJh7nmWBkduC4aNBOQ8rvgYmYJmCiME2r
	 XKvL6JZtLvdMTRDiTjAgcph7Y9Mw50LPEaKgfBRczDQmpZmikhunVCf9oK1/yibxyn
	 h6DEUUEUT/i6/GtRyRfrqU4ODKpj8eZ6X1bQ9Keav5aJqM35gcSB8w/dedxWP3Lj3Z
	 LA9tsHQ/XDaJxt4mI44gQq611erztzL6Gl8LVIQuqpDdcgnbBjb8WhnzlOdPaCgVoR
	 m2VUXlBReq90Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Satyajit Roy <sroy14@alum.utk.edu>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Rebuild InfoFrames on output color space changes
Date: Wed, 16 Sep 2026 18:46:32 -0400
Message-ID: <20260916224632.3198011-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091605-cavalry-polygraph-51d3@gregkh>
References: <2026091605-cavalry-polygraph-51d3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Satyajit Roy <sroy14@alum.utk.edu>

[ Upstream commit 8cfd9e22eb5c04b15b82985ff913944f84673d4f ]

resource_build_info_frame() derives colorimetry and RGB quantization from
stream->output_color_space. A Broadcast RGB-only atomic commit updates
that field and reprograms the output CSC, but none of the InfoFrame update
predicates include output_color_space. The sink can therefore retain the
previous AVI InfoFrame range while the source starts transmitting a
different pixel range.

Treat an output color space change as an InfoFrame change in update
classification and in both stream programming paths.

Hardware testing on an HDMI 2.1 television confirmed that its automatic
black-level selection follows Full to Limited and Limited to Full
transitions in SDR, HDR, and HDR with VRR active, without a modeset or
visible link blank.

Fixes: 6eb4c13a3845 ("drm/amd/display: Support "Broadcast RGB" drm property")
Signed-off-by: Satyajit Roy <sroy14@alum.utk.edu>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit d6faca79f5720893843e649e70aeb19147ee0578)
Cc: stable@vger.kernel.org
[ Omitted hunks requiring the missing info_frame flag and commit_planes_do_stream_update_sequence() function. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 927837249479f..3f11d145806c4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3602,6 +3602,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 				dc->hwss.setup_periodic_interrupt(dc, pipe_ctx);
 
 			if ((stream_update->hdr_static_metadata && !stream->use_dynamic_meta) ||
+					stream_update->output_color_space ||
 					stream_update->vrr_infopacket ||
 					stream_update->vsc_infopacket ||
 					stream_update->vsp_infopacket ||
-- 
2.53.0

