Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3DA37DE99
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791204008; cv=none; b=Q/t149fHBiKZkyWCW2nczQZ/a9s4M8S2aUNy2mWw7kyZgrPQteVtAqK/Cq3Dh3HZO5MITIingwwdayz5JrHbXfhOnnWB3dtZ+trz55yAullfW+XUGufq7qeqdp+H5MgTTCBIW1pc/KaFP6BhyZXqaCScsLhtUbU0zG4kiZ2zbIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791204008; c=relaxed/simple;
	bh=A2gOQwPVFfpB1i7FeaMRjygpFEOnDR2H4ehaCMX14hg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XzM2bV+Kyl4hR9TNleMto2HGvuMwiXwDXz9hK9FPwtH7EMFuhknwoYxj1YN81NAdN4QpI3afmqDBrGZQEx958RpP8FT3XEWoc7WZzUYm8g3Trv2XzQhHVW1qRPrbugFcxCcChOLxsHuPr86+ND72aBaH6HSrBHSSyb0BYVIbQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFOzNyeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFOzNyeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372991F000FF;
	Mon,  5 Oct 2026 12:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791204007;
	bh=3OtDlW19Md9L7Pp9PLcq9A1UmmpzLPhhylXnJJesskY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mFOzNyeCfMKhyDCAe3e2A2Np/sWMNfXIuhP1R/8sjK1qBZWP4rR7gfNnc1ylMj2Ed
	 f8lJlHgvl1rXo4/JadWnRI/5UoU/VGe/epe+wyf0gygYCo7mCc4yYSW2TRh1FdRLaR
	 uL7rKLM6ZA5Wtcso9onh+Lh1WQHK5aRLemyL1N8sU4H522Xh16MV0A2CT4jSsoG6rB
	 yeMej6ZBvlqve3BFsdWicEDaA9n9na+3i3kVfnddInL89BmewPgBv9Q0fvIYMFmkWv
	 olCU/YAiO3diggBCvvEb+V7OmjRMtTwrXxSsAbEenCKFFa2huERqlpfzoYOVZ1pHZk
	 Lb2LT7X6X0/Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amd/display: Mark DCE 6.4 as not APU
Date: Mon,  5 Oct 2026 08:40:03 -0400
Message-ID: <20261005123954.1910251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100514-expletive-duplicity-53b0@gregkh>
References: <2026100514-expletive-duplicity-53b0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 3a52d587d1fc8e8bf94ba1b07374f7ec91aaffb4 ]

DCE 6.4 is found in Oland chips, which were advertised
as low-end gaming GPUs in 2013~2015 and then have been
sold as low-end workstation GPUs until 2017~2019.

These are not APUs.

Fixes: 7c15fd86aaec ("drm/amd/display: dc/dce: add initial DCE6 support (v10)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260923122033.1046651-3-timur.kristof@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1072aa811ea1e61d5f763e4ec1bc6d24bb61f14a)
Cc: stable@vger.kernel.org
[ sashal: Adjusted patch context for the older source layout with missing initialization lines. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 0bbbb1ca5e251..c5bf95b71b1a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -1367,7 +1367,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

