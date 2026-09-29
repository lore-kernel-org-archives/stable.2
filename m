Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC9A3D1A81
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707577; cv=none; b=BDfsQUj0+tzU8eUsR1vsny/XWhqjy6UTAhgcY5hKLoXfGOdZguX9K5FH+nrp/51HlsJUOHXc2vOAVUA/DbfOu6o9vQetQ2+P3Iga5Q4LMfdHU3j88CZeEiqiUT5jxf7Dr9XuZm+TtWofDpc3wM5Xgi5pReQVOrDkfL0Hl+YlC2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707577; c=relaxed/simple;
	bh=8SC1qH2V+9OuLfeEGMQqgGnXYGRl5he45ogZop07QtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DW1uxXHkHKXcCUbBHZthBpUzxqiSltyZndFHHyqPxlVmb6NaXWngC2XkoSwKVenVnZl6e4O6zXKy0muE7dxYmhzmDTEWdJdegHuYJGNW0saA8dusxfQRvDEHYgAydz0CNWWFNr4p2q2WKb6zM2K24vp6EvvkWHZM712IPar5ye8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvkcFnEA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvkcFnEA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8DD1F00893;
	Tue, 29 Sep 2026 18:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707576;
	bh=GGaDyYF90SUuMX8GpVMJ09xqbEHwaWviYrdSdFEpwZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jvkcFnEAa3keQ74fflyty3JA0iThWCOw6oodFmlLYgitYG70NX43FzJKYI25g9j5m
	 w16pvWNRZ99bqGIE9CTPm6fYqqCpK4U81Rnqs1zL2bTgZoLSGkGgzhDVzWVJaKigA+
	 0atSWF4inKrtm23Ear3gK1IYsBCzLgGIn2MZzTwxVzVDKJA5qaJQW4DHdTnZi3jhNV
	 KiveslWqWplhu1JvnsLDd9G9uUIlnF+eZfe4IpCtdgH2Eda7qF1LnzAWB3U8LklpTR
	 iuTBRDmJBWHCN16jyCSmEVBWjGiX6Y9aTI7ygeSeJJjEJE8mRm7bH3aKC35HNL0/DP
	 hDEEkMWJXA/9Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Wentao Liang <vulab@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/amd/display: Fix dc stream excess put in dm_update_crtc_state()
Date: Tue, 29 Sep 2026 14:46:13 -0400
Message-ID: <20260929184613.521461-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929184613.521461-1-sashal@kernel.org>
References: <2026092930-shrubs-hankering-0ed0@gregkh>
 <20260929184613.521461-1-sashal@kernel.org>
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
index 7d628393415da..6478036a025f0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10482,8 +10482,10 @@ static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
 
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

