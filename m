Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B543560AC2
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707967; cv=none; b=GpUpZLUZ6pkY8V3tKwQOd8SCuAEqXtb/CPOHb4G0ZfWtFDz0ve7kAyHcOUd8udnuFpDn1X+ksnQoU99RAKfq9MBR6LA/QOrNiq2bWZdSTD+J4KyfWLbOfvj8P6VIy9AeZnMGoDUd1QGBcWWUyjplqcROscnY3L6p5zbUwHF9o1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707967; c=relaxed/simple;
	bh=SxZYS5VdAC4iDdKqqenPLfBb/LUG62Jz/lyNM2m2X24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmOc7pR8psRoPgoEMvO+y5v8rbLKUlk0FKywmOku4J+h/LfLxvZsHa0w0vFP7Gbl+qicMx61m0VyhsEVM9d8i1sqsgrMLk18YNjywrbesa2wbs20Rje7qIl/H5UVhCDBhIlGWP+d6TA1O1x5NAX3Ola1QsrvKk34BQmX/tgsvmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+QzMyl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+QzMyl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9DB1F000FF;
	Tue, 29 Sep 2026 18:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707965;
	bh=ZNq9VyEAnSUsYvGJDDsfpcIidT7kTPb1AfGM2gC1PJc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O+QzMyl8hfuNmg4Pnxw7be7uoj2gWmjFoSCmPjimSRn95ksyaSQ6lB1h3R1I53uLz
	 //0vMJg8w7fT7jHUpw4THKbDDs5DyS8IQG6SKWoOc2RnjZXZxLsvNBTBEDRpk91ods
	 3jM3w1uVNtUiswSUfrljf0N8jlbf53NxCv7SaOHbvW00kheno5ymCRHEOjpGL/Qfgj
	 6D/w7ovZ/sS3pacaqmCUltsZT96GA4qXP5AWqJ+ci9D8ExnCTVBFGci1Ch0lgT3R1h
	 2aWyFqTwhaklHucGJjnwuU0MwjluaLDd16PsRXo7oRI2IpyvRAEvCVObwoiOACPmD1
	 tpYhqJYVxRpng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
Date: Tue, 29 Sep 2026 14:52:42 -0400
Message-ID: <20260929185242.537806-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929185242.537806-1-sashal@kernel.org>
References: <2026092930-agile-pumice-f8e6@gregkh>
 <20260929185242.537806-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

[ Upstream commit c5fd4eaad50d620c7e09ac2082b2fb55ee54170e ]

In dm_update_crtc_state(), when a modeset is required the newly created
stream is stored in dm_new_crtc_state->stream and an extra reference is
taken with dc_stream_retain().  The reference returned by
create_validate_stream_for_sink() is released as an extra reference at
the skip_modeset label, leaving the stream owned by the new CRTC state.

If amdgpu_dm_check_crtc_color_mgmt() fails afterwards, the code jumps
to the fail label which releases new_stream again.  Since the extra
reference was already released at skip_modeset, this drops the
reference owned by dm_new_crtc_state->stream and the stream is
released while the atomic state still points to it, leading to a
premature free of the dc stream.

Set new_stream to NULL after releasing the extra reference at the
skip_modeset label so that a later goto fail cannot release the
reference owned by the new CRTC state.

Fixes: 7cd4b70091a5 ("drm/amd/display: Rework CRTC color management")
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 102a47065a62dc8f6bbbb47cf082a2934282eb08)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 194b9faa47ae7..29f19d8b39386 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8446,8 +8446,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
 skip_modeset:
 	/* Release extra reference */
-	if (new_stream)
+	if (new_stream) {
 		dc_stream_release(new_stream);
+		new_stream = NULL;
+	}
 	new_stream = NULL;
 
 	/*
-- 
2.53.0

