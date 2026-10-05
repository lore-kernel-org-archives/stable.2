Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658C848425A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207032; cv=none; b=q8Yx11OQNMtOCZ3mIYp+9A3r4vq3qCSO+4+0SITh58SMkCOkJfNajkYYDZJYJMET4KKbGGYI9WvR9ZYSkUhNghuoQBRZ4101KSsnoswpoMJeH6DBrq2CxhdBJw+AD4ca91U52Tg+tfA7hfmuJwCDD+QFU32vIqGpAoBBFL77cFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207032; c=relaxed/simple;
	bh=3t/SupvoRXmRDLm3pmhYGXWDLZPkNmxu5JWKH1gZnPg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wnv7rRR3xldshMokkTTfLxuSHfIi5/fw94rwjD9gXBdQV+LUtlc9NxT6Y0MLznZ60YHabP48N5F7pXwdrMeDYT3bi6aAtyIKM0aBs0yas8C8vDCY1AC3oXVcmoTmC0XNJDTwh2ZZJ+VyA1CYeyH2VPMKfRRI9FMNir9Wj9wlzSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShCd91Av; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShCd91Av"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40431F000FF;
	Mon,  5 Oct 2026 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207030;
	bh=otgjoPXzUPL7+tvF3dFuEbvVcGVCnVJicrrPrrGCpuo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ShCd91AvOFWv8CTy4J6e7k3bdZqVc6nWS3EP4RSJc3mqR9/T4tAiuJEIqiMPTJxPe
	 WlVgthg13JnI+jcYTHTSpRhIGUeiyTD3fGMrizXPEgAmuXR6zcCJl2T1GBQrDMRHRj
	 0siETOCAs4dVzYJ0k6wS2tcXAu0VC4W5OFhNliSGMHrSw4VU7WMMd75GZhPeflLPK0
	 f3XyuPv8UTLRnypR0gyI9AWlO7HVY6lEm8TDUF9eIhIrQORGaUwboe96+iOjlFKgNU
	 anKl+ekuFb9VQyVp1nC9pAwUXKcJ2SWO3vg1SNadpSxMaTbkqQYKT5pGjq32QRFfUT
	 SyxspgkvtzTpg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/display: Mark DCE 6.4 as not APU
Date: Mon,  5 Oct 2026 09:30:27 -0400
Message-ID: <20261005132959.2689271-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100515-geologic-shy-9328@gregkh>
References: <2026100515-geologic-shy-9328@gregkh>
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
[ sashal: Adjusted context in dce64_construct() because the debug and configuration default assignments are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 8db9f75144662..556c453666a74 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -1355,7 +1355,6 @@ static bool dce64_construct(
 	dc->caps.max_downscale_ratio = 200;
 	dc->caps.i2c_speed_in_khz = 40;
 	dc->caps.max_cursor_size = 64;
-	dc->caps.is_apu = true;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

