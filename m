Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E956139A7FE
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612407; cv=none; b=MqPxEi5AaBcbKrfdWNzmciDOaBgXYspuORCnDYiT62dGnrcQH1xF+RDnfidEMaxpxT0tPTe9F9+gx5g/IRTTJg4ysPAk86k+CyomF+6EYULmcFTzhoc5U5F1DdFBFX0CksQa480JN0tk5h95FBvu9pYANy/U19lu0beLZt9KiYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612407; c=relaxed/simple;
	bh=8qqMgERrsW8kiSIjTIoGsSh0S/bWLG/WBbNoFfhnDNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdcju/5BRa4AQ5ODM490UpTjAGKAfsscv/p5xmWn1Rdiwhc3OPE/oUr78n+RRF2qcBAPMjiDWqzjb3ydo8bvlb6SDnK4dpf/Txrp4sX9j76BLgQKIarOtW+U+Vlnuhp02kE3Ocv9z6lUNqGiVJKUI/fb5r0VlcLgU+sCw8eIjHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=koBLFuHS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="koBLFuHS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A551F00898;
	Thu, 17 Sep 2026 02:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612403;
	bh=WcNmTwRhEcB61A9yBjzuLGdbILU4cKfbSGysL2RRXvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=koBLFuHSL8qpTh69rhj7OrM5GoKrKFVMtiNTUYzy5QV+vHB3np0hIopSFujoLv2LC
	 dkGgwKT4BApDO2QDKfTQHxN5VC2m1vNglgl5MQZ5NOYMCf4TC0OPbv9IX3wp8/2Lrv
	 7ehwMYW7k691aVb1LEfEvYYtv/53Mg2BH0pmk5OSwqNpZF/+J2Wi+yjkKnbTX42o6B
	 ityhU9Ot5G0wbpwC34EM+2y/BYMjb61WGji9/DEERibAuKquW5cr1gWbvMOW9CjBP3
	 92YWBVGrldVG7SxnPThetGBLhJb+FxD90c0Zatw0APya3FfueaR+0xE2H2tC25LCOg
	 rViWZOJuOxoWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] media: v4l2-ctrls: validate HEVC tile counts
Date: Wed, 16 Sep 2026 22:33:20 -0400
Message-ID: <20260917023320.3876251-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917023320.3876251-1-sashal@kernel.org>
References: <2026091645-habitat-untoasted-f76f@gregkh>
 <20260917023320.3876251-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Bommarito <michael.bommarito@gmail.com>

[ Upstream commit dc694a9929f7cb9c88ef91e45eb982b7bbe5a477 ]

The stateless HEVC decoders read num_tile_columns_minus1 + 1 entries from
column_width_minus1[] and num_tile_rows_minus1 + 1 from row_height_minus1[]
and use them as tile-loop bounds, but std_validate_compound() does not
bound these u8 counts. Reject a V4L2_CTRL_TYPE_HEVC_PPS with tiling
enabled whose tile counts exceed the uAPI array capacity, mirroring the
existing compound-control range checks.

Fixes: 256fa3920874 ("media: v4l: Add definitions for HEVC stateless decoding")
Assisted-by: Claude:claude-opus-4-8
Cc: stable@vger.kernel.org
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/v4l2-core/v4l2-ctrls-core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/media/v4l2-core/v4l2-ctrls-core.c b/drivers/media/v4l2-core/v4l2-ctrls-core.c
index e754bb2a8a4e9..89957c835d4fa 100644
--- a/drivers/media/v4l2-core/v4l2-ctrls-core.c
+++ b/drivers/media/v4l2-core/v4l2-ctrls-core.c
@@ -1903,6 +1903,18 @@ static int std_validate_compound(const struct v4l2_ctrl *ctrl, u32 idx,
 
 			p_hevc_pps->flags &=
 				~V4L2_HEVC_PPS_FLAG_LOOP_FILTER_ACROSS_TILES_ENABLED;
+		} else {
+			/*
+			 * These count the entries the stateless HEVC drivers
+			 * read from column_width_minus1[] / row_height_minus1[]
+			 * and use as tile-loop bounds.
+			 */
+			if (p_hevc_pps->num_tile_columns_minus1 >=
+			    ARRAY_SIZE(p_hevc_pps->column_width_minus1))
+				return -EINVAL;
+			if (p_hevc_pps->num_tile_rows_minus1 >=
+			    ARRAY_SIZE(p_hevc_pps->row_height_minus1))
+				return -EINVAL;
 		}
 
 		if (p_hevc_pps->flags &
-- 
2.53.0

