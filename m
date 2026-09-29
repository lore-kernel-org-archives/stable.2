Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1771025392A
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707577; cv=none; b=ow/QEpZXdUrXxOeRq215fCUqce7jV+hlv68L/lI/GT56NoVgA78bZuetl6o89R13J4evj+5+RlinRubg7u8Av70Pl9wOZyUZdiflHEbSwc6Z/789zkT4Tcebg78Xp08N/IP7QwI4mfuiN1LwVPacp7MwSPP1b2C7UhRgdmt9TdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707577; c=relaxed/simple;
	bh=14Yq42Dk6J3jqW+dHuaSyvrELogyOPp2B3lg/mkZhms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+QrVpmD87rSKzt+GQkoUJMxKDTS2/JvEZnwgfU8StSfkzg0xIGnSZ9YrJ1Xm5gizG2PyOics8zaMNLbFPk/Sju1jxCL1mXpwt8JFztczKM7uHoAaaSR9fNX6s+WFzaVz6LeHD1rqJ/QFrFyPWW52Vjk+7Bmr1QlMy993F2GL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAXd+vKa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAXd+vKa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22BE71F000FF;
	Tue, 29 Sep 2026 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707575;
	bh=ycNjucG9nDbhoTZetvClJCMFX3pQgKQKYYlB75V6RgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZAXd+vKaMHAFDtzpMuKixngnRdsjgfIKZpOevLuenmZYS/Cp3Kas5HwzVO6ZYvYsy
	 87DF6W4ksmVWnvM/gOwVHwVEBtsbMVOZmhoOuT755/NdTXiJifuitMDdMYulDAYavf
	 AIn1p7FMNfiXT2hSblVbd+C6/tNJcPlFQ6bKMHLu2nIHigXkIWj0+vV8VVWpKSGp4k
	 trkHfiAwHWgE39CCuc1miHGdpRg5ku1MrYvRtDfYwGGMtdLTXrCB6EIuiKQ0LBUMny
	 T8Ts7sk0u2OLgbb7TwtaXzGng10aDVT2Zug8QXiiGUGqoLZ9mKEh9MPnpDYG7Ukvg/
	 MwzVXObv0G8kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] drm/amd/display: Whitespace cleanup
Date: Tue, 29 Sep 2026 14:46:12 -0400
Message-ID: <20260929184613.521461-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092930-shrubs-hankering-0ed0@gregkh>
References: <2026092930-shrubs-hankering-0ed0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 3335a13535312c9fad4d8d1307a621e6617d6ed8 ]

Commit 075e2099c32c ("drm/amd/display: Fix race condition in DPIA AUX
transfer") was backported to stable, which I noticed because of git
saying

	linux-6.1/.git/rebase-apply/patch:37154: space before tab in indent.

while applying patch-6.1.21. While fixing the code location that issued
that warning, improve in few more places.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

[5.15 dependency adaptation for c5fd4eaad50d620c7e09ac2082b2fb55ee54170e]
Keep only the dc_stream_release() indentation cleanup at skip_modeset.
Drop the unrelated comment, FreeSync, audio-label and DPIA AUX changes;
5.15 lacks the newer FreeSync rate and DPIA AUX implementation.

Also clear new_stream after releasing its extra reference. The target's
parent already contains this assignment and the target hunk retains it
as context; whitespace cleanup alone still leaves a cherry-pick conflict.
The assignment is safe on 5.15 and prevents the later color-management
error path from releasing the reference owned by the new CRTC state.
This deliberately brings that reference cleanup into the dependency so
the supplied target applies without changes. No functions are added.

Stable-dep-of: c5fd4eaad50d ("drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9a6c0b17745e5..7d628393415da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10483,7 +10483,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 skip_modeset:
 	/* Release extra reference */
 	if (new_stream)
-		 dc_stream_release(new_stream);
+		dc_stream_release(new_stream);
+	new_stream = NULL;
 
 	/*
 	 * We want to do dc stream updates that do not require a
-- 
2.53.0

