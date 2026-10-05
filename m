Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0567A473C66
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207452; cv=none; b=lIeUsAXy8IAez2OXllS0hDGpH8kquakUun4mqMtgBJvna/UkWnzLPk7YO9+++sSD6Wy19rQvcM0Da/qLPa2pjLn+6qaxF1gi7Aa1PBUTLpJ5XL0sEPNhPunUGfGCC+1iIBeCMX4Av81wt/fosgR9ky+bL3KOuUpKdRsqDFuHA7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207452; c=relaxed/simple;
	bh=2md/x+YRJRZDKCJXF3hz04x/FrrjrzXmxP+Li/7LpCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dz/ZryViRTWvRkdU0lKe8v9zu1/eOkSh1PZLJrVU51kTpIXvyeLVnjtQYOsNMmcQmI/qFOFA3XuxIKlMZDAM7sZ34MtB8r+18AVT0/M2OLSkv62aQRf4zTwBV8a9LF9BNRrpjcAPjdPutvFoJmgrfihJV4dunWTY9E1+nga39vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+jvcn+q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+jvcn+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEC01F000FF;
	Mon,  5 Oct 2026 13:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207450;
	bh=Q1XqN7Rsc/CiUhMzcka18akISAi4imDznVqIfrI1e7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T+jvcn+qzDd+FFXgHZOXj28gRfLewF7jbyVCs9pzU7ED9l7twjq7aTujMc3zcrb2A
	 jGEE9DnXh6qIT6s4aI33xF5wWuAHNi9Z4EFqOIEK9c4I4MuCgpNL0JpdxWdF/783qn
	 Y6bJwYRgmiVlYTcJZbOl7CyqeY7kH7TFxK8WxJqRqe8XqCYo1yqYbwMYL0niVoex9M
	 oH3qpHT+LWarZ1s66B5PLIPyPaWQkv2qAzFUK3m3+26zNyvHg8gjRRILG9kIitSyGM
	 Ir5f4KN0wH0DidxcMytK1KhxpN59/+0SPERfiS9//Mmwo8HhuFYk/wsS/w62a3WCFU
	 xuti70kkVKBoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Fix fast updates on DCE 8.1
Date: Mon,  5 Oct 2026 09:37:27 -0400
Message-ID: <20261005133651.2692021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100549-unselfish-oven-e619@gregkh>
References: <2026100549-unselfish-oven-e619@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 687d31ea9ac76b299817060fa1e5582d6c752ae0 ]

DCE8 should use legacy fast updates.
This was already set for DCE 8.0 and 8.3, but it seems
that DCE 8.1 (found in Kaveri chips) was forgotten.

This fix should be backported to all kernel versions that
have "Refactor fast update to use new HWSS build sequence",
but this patch won't apply cleanly to older kernels due to
another refactor in "Remove dc param from check_update".

Fixes: 0baae6246307 ("drm/amd/display: Refactor fast update to use new HWSS build sequence")
Fixes: 9ec11bb842b6 ("drm/amd/display: Remove dc param from check_update")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://patch.msgid.link/20260923122033.1046651-2-timur.kristof@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 57605379559e3b5044c8274a1010ec658e5e73af)
Cc: stable@vger.kernel.org
[ sashal: omitted dc->check_config initialization because enable_legacy_fast_update remains in dc->debug. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index b645c0c8ec3c5..9874d2cb632ce 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -1121,6 +1121,7 @@ static bool dce81_construct(
 	dc->caps.max_cursor_size = 128;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

