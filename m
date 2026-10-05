Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5A543802B
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208544; cv=none; b=s/8ElsV3UKfvMxc2zWNfhpulALYAgwzkPpEqNavOhKiwmRu2TghC4ZO6qnz+YXPEFBLK3T3XkZbfyf0FpKd1qpUw1uVn4nIBqt7FZ8dErGbmXAnaWxtK8PuLy3tULTKYG8tFHYeCmVOunfCwYMGPT6uG2UOojvKFHg8xGmf4eDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208544; c=relaxed/simple;
	bh=87AaaWEUEv7tWedUyR6PJT8aO7Ph9VllpXUHIVQefNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sw/bHbLHKEj/dscoSS6fmRsUPGaEJ4vktT6T+H6J2r7IcNWJcZFyu7OPcV/UxZNq1U0tX2SxaE8JP5APbtxWv9WFabW1vbxRWIr1ab9SX5e5VrmurY1WaoNzzY4tTCH1RVC1IMO9vXEd8jUrO6/zBHXNOsgi/IubcVevFjncTr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAAxSUtO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAAxSUtO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 941A61F000FF;
	Mon,  5 Oct 2026 13:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208542;
	bh=11qWv1SBP6l/iHLEO3VaytXOsFoBofkx5MyS3CHwOEc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hAAxSUtOhp3WwtlNjJSK68kqMfpMduCLYDaB5eaU+buH88vTxunDyKo8JzE7mLJFp
	 O1blX/WUl6v/pA3hrAfFCsPBCWMau8i4332PVw5R51DOFzuFVUslsPhjZj6+9jksB3
	 qMDaqt1dJ6csHzNA+wWKu1Hn4ueTcqk+zsQktBTd4qB6duwi9PXRV0tK71tHL5N925
	 g65/NrnvrLp3uIToU240Twe32oatd/fRmfXZqD5pRMvI/EjZNzD7JxLaaCBGmzqiv3
	 Vsi9rdBXH+y7Gpt01jvFILysn2ruC88HLJASHheg2vuYILPScSJqwyHzy38JTau4nb
	 ss7G7C59dmXxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amd/display: Fix fast updates on DCE 8.1
Date: Mon,  5 Oct 2026 09:55:39 -0400
Message-ID: <20261005135503.2970496-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100501-overdrive-smashing-51d9@gregkh>
References: <2026100501-overdrive-smashing-51d9@gregkh>
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
[ sashal: Omitted the `dc->check_config` assignment because `enable_legacy_fast_update` remains in `dc->debug`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index a73d3c6ef4258..100a68778c922 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -1173,6 +1173,7 @@ static bool dce81_construct(
 	dc->caps.max_cursor_size = 128;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.is_apu = true;
+	dc->debug = debug_defaults;
 
 	/*************************************************
 	 *  Create resources                             *
-- 
2.53.0

