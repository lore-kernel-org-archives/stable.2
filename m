Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6A2350A18
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 23:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602127; cv=none; b=RAQLhtnmLmMVmIVcyVDKtVGJUa4IGwD+uomAELdimLrMZd9TxUjhsMR4SZa1Z28MDaQlI/6PACCWh9FuilAtuEew0bXfOdcI0FVTTDNjyPm5iUUOko5zg0H4O1B3CVrsvf5tGtyxHNjlFGcLk1rOm6jeMO7by4357c6UrgRQuWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602127; c=relaxed/simple;
	bh=Tv7HhGidTeWpAwmQDUb+GCOJf1HWMt9nQQy1Y/2MJBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+Y7tvMk3rDIv6kMmDUvtiG9tIdH424HQZXXIqgAAvkqwQDJzRdPrbGYdLYaMydJ6etVTs+ZaDGZOnDzVulm0isUsHawP9H2Cgb76ZrHSV2WkpfYZ/nBj8/5kWvJpEt9uNPNJ85X8MYt1lCUitlizPAS2dW0geyd3Iyst1+FQUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ciYyNcIW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ciYyNcIW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A22A1F000FF;
	Wed, 16 Sep 2026 23:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789602126;
	bh=vW6uivZaPJIJcpDw+iqmirRyKyUu9bmTPw2Vhe2gLF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ciYyNcIWP41BhHpHwzuZdMfVM6u9VHXF8FRZqe954e8vl7BtObnNetaEErMC6COOk
	 LLLP+kiFWEeVQWbdC7P/UD4qwlX6ljTVw1Iw2wztYLhasOvX2neBnqYFvR5tg3/huW
	 sPJoVglIatoG1VHhvpCJNKkhAjf7K7dls7oeAv8DbAJHxcjcDSNwRgxJFrx75kJG0L
	 ReD2DLRIkWy2OUtIUVkiq5Ny1JbKO7FpxvbNgmuY7TXPqEFo/bta3fsKhiHEwpYUPL
	 tG9xnbQ4BmcZg2t6vLkjhXX9UcrpXKqn2OC7Ix41VjMc3VRAqUDe8aq5J8AGWzXQ57
	 JYDbVOIJ91mHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Satyajit Roy <sroy14@alum.utk.edu>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: Propagate HDMI RGB quantization selectability
Date: Wed, 16 Sep 2026 19:42:04 -0400
Message-ID: <20260916234204.3295905-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091644-upheld-bride-0921@gregkh>
References: <2026091644-upheld-bride-0921@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Satyajit Roy <sroy14@alum.utk.edu>

[ Upstream commit bdcd0411d7d186225a52458fd42bb70d54ca917a ]

DC uses dc_edid_caps.qs_bit when constructing the HDMI AVI InfoFrame
quantization-range field. Although DRM parses the sink capability into
drm_display_info, DM never copies it into the DC EDID capabilities. The
field therefore remains zero and the AVI quantization range stays at its
default value.

Copy rgb_quant_range_selectable for HDMI sinks and extend the existing
EDID-capability KUnit test to cover it.

Fixes: 6eb4c13a3845 ("drm/amd/display: Support "Broadcast RGB" drm property")
Signed-off-by: Satyajit Roy <sroy14@alum.utk.edu>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 892659399f64642e33072562a11ec1b2e7bd2263)
Cc: stable@vger.kernel.org
[ added a standalone HDMI condition because the upstream HDMI/FRL block is absent ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 25923b00667a0..ddda474d58788 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -156,6 +156,9 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
+	if (edid_caps->edid_hdmi)
+		edid_caps->qs_bit = connector->display_info.rgb_quant_range_selectable;
+
 	apply_edid_quirks(link, edid_buf, edid_caps);
 
 	sad_count = drm_edid_to_sad((struct edid *) edid->raw_edid, &sads);
-- 
2.53.0

