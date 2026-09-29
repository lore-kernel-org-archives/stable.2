Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EE5560ABD
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707965; cv=none; b=l1ZGHJgGBNwuhJOlroIMj3z2kDIz/9Zzd2VZIlml41efsdyk7FRxcnjAzYM51bGpJC9awXh/gaa2bZldAOD7hphXq+GIdCllLhw50mO+x/JcTEaRaiF9jtyLmpLmJdlUOORI+gT2Dqq/2KP8msUo2BzfneTgXZjdJbCUc+Chzfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707965; c=relaxed/simple;
	bh=ojumq9tfD20bdCpdc9lrnq2TfAF24/MFM4bEN5rl7rQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAJkEp8PFYVuTZkxuKWDlzapAMruK5D0DG8Wzm9U3adwHo0r5qEvw95sOSxlKvwap3BGqsy3kk5kzYMBFQ4ciX0Y4gl+5QN2dUDEebDjyE0U+Hr20xtLN9tBZZAX74CvJRmtsG08dnCfzdyBC80fJHMSZ2M0bi2fmqkCSEZYzSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B137GGVA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B137GGVA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BB31F00893;
	Tue, 29 Sep 2026 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707964;
	bh=Yb1tcZhAaV021/8iLriGYGAvIG7rWWv3osQNeZjx7Q0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B137GGVAsXhouFHK0XiSdzlU6Ubz55Q2R4f+ppfBQ0qq4Kbw/LEIz38xAgUnO9uvQ
	 4wD0Aoa6wqCWvDcptwyPr9LjylIkRF1bMKdWUzaNwp/ZXJLKRfoFfGTI5hGT4yBltV
	 6BkUug+M8ukcphNnPuu8GggsDEpDTVt6d4S2W9nXpWxruN+lQj1PvomRfh4/JFuIZB
	 2cFua1aTPSamWDfuPDSRiYBmyOQzhnOZ0KyfmFW/aYziUVHt1CX2g4Kty73oToxa6N
	 RyalsGowUGYiRsWnLBG9px81K6H/OLZMIbuINtBraRhjW/Te/KjccHk0CiPmKTYoKr
	 z7DCA6B0vZeBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] drm/amd/display: Whitespace cleanup
Date: Tue, 29 Sep 2026 14:52:41 -0400
Message-ID: <20260929185242.537806-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092930-agile-pumice-f8e6@gregkh>
References: <2026092930-agile-pumice-f8e6@gregkh>
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
index bd15de4dee75e..194b9faa47ae7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8447,7 +8447,8 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
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

