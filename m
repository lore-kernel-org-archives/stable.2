Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794671667;
	b=Y/05g/Ll9nITCVQ6w0SR4seh9ieQwA3iz2WQH7ARwFIZU554nRN+ySpX3NYQuVAgTKqK
	 BGQwK+ZJ82RL+6l0JpEAfCWpVlZ7/tC6aPX6bs0eh+rXMhe2dRLYfFevDRKW2v2Iuov8X
	 Sq8+BKYnlv+j4BjomXRMmKXF6McKoJMFtkM3eSSWtYAcQ8qjfdtVQuuXKo2zYnfapfMyM
	 rRdosDwYSQBqwAoROhoCmapRoTT/3hnK0tHrQhJFyMHjVagibEL8Dq6Lya3Gf4+K68rZ9
	 N6kbKSU4c+oMVD7DHQjEk7Tfgqm3xjg+HZ/SU4NgL712Lc0ExZBUD2xogrE7Fic7JUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794671667;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=By7+brSZZWYz1sUpqyLJ82dpZfFR+/cv2Os3AFMQDl4=;
	b=sZGqUApff5g4DTPqeGBTSyUZU+0XIDZdPVxrEFQY3R8pQZlI7FcwweCuYYJo4VVlIqPn
	 Q4AlxzTbQpH8W+Rys09X29dC2lEg9zY2jQdGNUB0LZ929N8DvjUag95KAyL/qXMdzdOli
	 hAAVQi8kvOAkDhwklrKrVMibnbC2PUz9kJE2LmyPQMFCIHPsxwQtUtndWf1Op/ut3LSXV
	 l19Cem18aH8TYaj1A2f9m++Rf1efGy64rRsh5lP1NcxxLmy9od0tWy2peHXX//GUSH12e
	 vN/w8IMynh/tYl76OKHqEUoAfra9R1E0SLoHsvNOf5hGtVDzBEiq8BbYiwUSSH895BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyPlyklB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11F5606A329
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 15:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QyPlyklB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679221F000C4;
	Sat, 14 Nov 2026 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794671667;
	bh=By7+brSZZWYz1sUpqyLJ82dpZfFR+/cv2Os3AFMQDl4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QyPlyklBzLc0P40whAORNsGzUG/v6f7e4yKBEM8QktBjj66tCm7924W9969mx7445
	 tQ5Ed7GEXtLI0a/PBTUfpN5i3Ns9mmaniOYBJIgYfSvynzHe70s7w/z8v6C4VnJF+c
	 LBI17gr6LUGLZcNsFRE6KhZRfIeEruRC0PWTHnF9ywDky0y6HjGlQUsbED2CBunXO3
	 CCdDeprtQb9KBhd/r9stZSaHG2J4ufQ9tOf6RgiibsFVFP4tSr9+4TxxM8JOHG+mze
	 3EI0+jzFMAa1xdedH0hPqYsvIXhigsJD/qcwkQmSWmfbJCtKkZvtluM42rVsVM0Y9K
	 qjRArPO99as6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/amd/display: Minimize wait for pending updates
Date: Sat, 14 Nov 2026 10:54:24 -0500
Message-ID: <20261114155316.3656278-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200958-failed-6.12-f3afbf7d832a@kernel.org>
References: <20261109200958-failed-6.12-f3afbf7d832a@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[ Upstream commit caccee7b296b1f6c37f09b5d4808606c66438e9d ]

[Why/How]
Move the wait for pending updates past prepare_bandwidth if the previous
update was not a full update to reduce the average time it takes to
complete a full update.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: f3afbf7d832a ("drm/amd/display: Reset DET of HUBPs without a plane before outstanding updates")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ad1cc546ba48d..0975616b53004 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3802,7 +3802,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	dc_exit_ips_for_hw_access(dc);
 
 	dc_z10_restore(dc);
-	if (update_type == UPDATE_TYPE_FULL)
+	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required)
 		hwss_process_outstanding_hw_updates(dc, dc->current_state);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -3829,6 +3829,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
+	if (update_type == UPDATE_TYPE_FULL)
+		hwss_wait_for_outstanding_hw_updates(dc, dc->current_state);
+
 	top_pipe_to_program = resource_get_otg_master_for_stream(
 				&context->res_ctx,
 				stream);
-- 
2.53.0

