Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801EE49D5A1
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209560; cv=none; b=t1/G2TKtHyxalEymE+VuY3dQqukgI+U0jhsxHbt4oWE9F2BYCkK1fNMMGYrd1+e6FqrFfndY9T6rtpBc/QxBncJAnyowRk71GCPxthe6Qit0NB4Ng62F6X4kiYfBygmFauWfQx6xQYW1jCeNnuyrqzpTN/8B/YPQs25xkzvk/0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209560; c=relaxed/simple;
	bh=qbLmuY/wHey1BaZJOXtXLRZ4tNqFfOdZktQ9++o0vOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4bDMa99q27dxKelFr+TFkO7LC+UF0/p1P3Ag3Qzvj7vMellUvcnBik3dfTbmcYQqi5I126QI/oALq7iXsocGhpEtwFtMJ6QgVud8hKNsBlG+JJXUZBGVucc83F2KViQacqBHIiXOAM4lT5DHF9VnTnBLofAAgR2n9UU4CWGolE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8tFHcFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8tFHcFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF5D1F000FF;
	Mon,  5 Oct 2026 14:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791209549;
	bh=W6uup4zfCidd0J1i57jDrvb56hw3sqodnBVmtitST9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J8tFHcFMsLJlDcX1nLTDr8gjhR9YZXx6xCSMcgPLAS12vRY3pi3LQ/cAcLqZHLzpG
	 CQlcfHR19uHVe8/9kjOIciD0K1N4xNBOoOtWQxjtyEdXEp98xZLHoGfxIVgvMJfhPJ
	 cp8fXa3QGypWARdNOhtNh0Uma/2P3s3Cvdsbg+9FUHVVzNTlroe3iGp8Wgu19pa1bk
	 C+FlKn8wM2mZ6tYRRgAGoLF15Z23pQMcmH/0yLTX+UqDH3UvrBDJYYX6jQUNAuk8em
	 sdoQJujRUyXCW8XE+atjEaj+xAx4v5zv48KGljwc/+OsZocaEQzdhOc3GDAC1iH7Ci
	 X4UfDLBoNkyzg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: Fix fast updates on DCE 8.1
Date: Mon,  5 Oct 2026 10:12:26 -0400
Message-ID: <20261005141144.2994846-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100526-romp-swizzle-c0a7@gregkh>
References: <2026100526-romp-swizzle-c0a7@gregkh>
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
[ sashal: Omitted the unavailable `dc->check_config` assignment because `debug_defaults` already contains the flag. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
index 061221394ce07..616cf2cfcc383 100644
--- a/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce80/dce80_resource.c
@@ -1174,6 +1174,7 @@ static bool dce81_construct(
 	dc->caps.max_cursor_size = 128;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

