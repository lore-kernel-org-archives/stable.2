Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2CC3B47F1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790696556; cv=none; b=I/6TKZhGhv5fwzMyaM0zCYFQ/cCMsldMgFA/2sgdKxwtj4v9RtrP03IJccMATtIrzvlxHNogaqupulErQc+KrGUIWTa3/iiIxieB0V5x8BHCoUpe99JT4HEpIMN2PFY9V+zWAXgy82WOWVtWVs7KJkk4WOs0UTKOXs/v/EavrSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790696556; c=relaxed/simple;
	bh=o5lQxwar62uaPzKwwdajlfaJ3zStc30yBL1+0hZvZTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AVB4H0OiAn7H+38OFpXH06JluY2v7zZ9jOn/hDhlAZ9dFBJM7sxpfKK8bJoJ9HJzJ6d5CPRY5gDf/Co44qc0XdsrILW+RiIgUFslOMpDiZJhELB+gS59IDJtlwYOYcx30PG6kqXWtvetR4pqaF9q7PpUkhtgcJ895Lrdx4fsp+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owQf/m4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owQf/m4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D93831F00893;
	Tue, 29 Sep 2026 15:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790696554;
	bh=+zwV5JFxpUkh/A6srKkttOfm2i5aQEfPAGzFBZ8slBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=owQf/m4Ee/Ms6lDydsGTaTFl9ZR1Vy5QVVTcOJPksi00KvN+egji3HQcuczsHtjpl
	 POUEv9FdhOqkPcwRPPudhf/DBVmaOLwHU3i4dCEuekJLHoofFYUwFwW28pvscxJ3wW
	 WNmOnmVgR1aG6w2ZOvST618wzt7P7WvRBry6L2Gs85BD90nH6MCfvfs/gWBs52JFuo
	 XBCWKAEwna6cB+Xpda/QVj+AbFKp6X/7+IJqtPdZRBRQr/PyK881IXHBJF6+aCObBg
	 /YiUfjSy+n6vGgc3svI27x1JWHPSWrmy0xlYaYu3kF69TUW/S6LuCrxbm3kw3LhLF7
	 qH+WvWKPWHpBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
Date: Tue, 29 Sep 2026 11:42:31 -0400
Message-ID: <20260929154231.4087621-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929154231.4087621-1-sashal@kernel.org>
References: <2026092929-evade-cling-0497@gregkh>
 <20260929154231.4087621-1-sashal@kernel.org>
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
index b3ee95aa5af0b..ccd67d753a1ca 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9291,8 +9291,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
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

