Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DA24DF4D3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 22:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789598778; cv=none; b=hkIGxAmAsf+YSrREU4xwXYMBYIS6wImkVqnG89J5AaZNJ4AF0cC+ELXjUmhQiOyLPQQRry1HUXfK/1fvlvcBgEdIeBiTUYx2zMciGaHw/lPxqdr23WuEtULO3pc2LWmMepsASAVMug+rnnymfDxnJPOGom0FIuyWQ+sWMIHRG3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789598778; c=relaxed/simple;
	bh=w7/4zr5wfmri0sX2GxQ22dhJ8bcJbmHISKUGsv5FxBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Psub2y3j3P3nYYJ4YW1kCSfMzFVHG+hjwuNS9qEL+Z+3t2hG1VjGV6D6zCgvaeeZTO0w3M8SpNdTaI38D/nV06B1kBbNjoAd9wCGFvxsLANQ3Ja4O19ghTKxJsLDCncW04CZJIFzqQYXfGgQnq5YDO16FCeN6IhIa0E5SQTnfnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0dS4Cw4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0dS4Cw4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7FE11F000FF;
	Wed, 16 Sep 2026 22:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789598770;
	bh=gkrxfLQyWhAufsNq8Z7Oh8eqf3+qT99zKlFGjDNBNOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T0dS4Cw4qWOSnBXDUb89Ttx8yMMekRCFIr5vpl66ShE3EUJiaDw9Gxywh0g0A/lTo
	 9UKo2cpEiOhGZsF1aUKKhfn9XWb4TcalNqZK6KZAxuFZlBb24EKSSpmvl+gAjP6eKe
	 +SiuXSbibLS8WEcAt5ifPAseaxNkkCgDFeD9gAMPfDQ1gYEaPwS4lPmN8DittPzy1x
	 iWqP6IUA8RcfWkVCC59Wp3hXSIkQ5qO/G3Hdb0y4GakJ6CQVK3YTvp3mRSJCVYxedF
	 hpS2BSoSyRdehPqJlTZo6M47JHNNua8Nu98xOeI5YvG6VSSNR7x2u8d90Vbjm9yUpK
	 WTbgAZ2CVdH1w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Satyajit Roy <sroy14@alum.utk.edu>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y] drm/amd/display: Propagate HDMI RGB quantization selectability
Date: Wed, 16 Sep 2026 18:46:08 -0400
Message-ID: <20260916224608.3195520-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091644-exceeding-greeter-5466@gregkh>
References: <2026091644-exceeding-greeter-5466@gregkh>
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
[ Omitted KUnit test additions because amdgpu_dm_helpers_test.c and its supporting infrastructure are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 41aa8f9bb152b..fe5b97e6f9603 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -197,6 +197,7 @@ enum dc_edid_status dm_helpers_parse_edid_caps(
 	edid_caps->edid_hdmi = connector->display_info.is_hdmi;
 
 	if (edid_caps->edid_hdmi) {
+		edid_caps->qs_bit = connector->display_info.rgb_quant_range_selectable;
 		populate_hdmi_info_from_connector(link->dc->config.enable_frl, &connector->display_info.hdmi, edid_caps);
 		drm_dbg_driver(connector->dev, "%s: HDMI_FRL [%s] max_frl_rate %d\n", __func__, connector->name, edid_caps->max_frl_rate);
 		if (edid_caps->frl_dsc_support)
-- 
2.53.0

