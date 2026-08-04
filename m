Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E9A376BC1
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 10:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785840444; cv=none; b=TdSgy77tOYgS9pzKmMIKtW70eZ2mdYERC0/pJflC0CyHEM5rsYtsfRfw9H5s+aK+u8Pyr9xzQ8K1v6z/JlDE4rku0GE5Dx2vyTY8hDs2w/BO1EVggDn7AsJFprh/XIz9wS7VDAC8z3IBmdgF4M1LDcMCTRLvygAxlCuhXrZbONA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785840444; c=relaxed/simple;
	bh=bQNNpHwIcecqMAPd3YYRIvw2aO7OqNdi2y0RYS2fWBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXzUimfutqMVJpR4HRRT2Z0N283Gey8VIEfI54CCCpHWyT1Dzk/5A2n6jKaC8AEW4WlPQWRVf1IhxH+PxS3ILWb1Wms4SH18OpanU8ePxWtWW6yWdSifAC2baqYlobGWmnoZufkHXV6abRQwdOiGEK6phTHLhtVyLuUxSGTxBSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oawsb9qQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oawsb9qQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE7991F000E9;
	Tue,  4 Aug 2026 10:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785840442;
	bh=6sB0z7/qPyho+bqStMlepFjStBJebcOhYBuPzR74h8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oawsb9qQr0QUuOIdN6Gu+1DDPQyUxYAck4i8lRiOmRKnGiHE8VdzO2oCflOX6Wfoz
	 oQ1yfbSNK21SJWmWSLDQOWYknEOvIaoWhfB8czjQkqIr0t1XHRGcLIkH0Atmx2Ia8T
	 NtQ0euAsE1p6cuUnVZf7Ijfb6OkPr+GpCUh/ag1oDDvadZFNFr6LYeUMkyMp2NmV4h
	 btM2mIgN/E+D3tEKOi6yjnd08OmE3b/dONJHoBe/2vfgcn4pO0HctOl+k417bZk2fE
	 mnKfh7Ghzo0n8ltg/mjlYBQJZlbWOCO1zNx3yv/vnCl77AGZCpappj40E5gfZncMV9
	 TkoFQ7ZSlQo6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/i915/hdcp: require monotonically increasing seq_num_v
Date: Tue,  4 Aug 2026 06:47:18 -0400
Message-ID: <20260804104718.2825645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072905-drainable-smolder-6384@gregkh>
References: <2026072905-drainable-smolder-6384@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit db9e64c983dcb07ff256bd455f258c44aa530ff8 ]

The HDCP 2.2 specification requires the seq_num_v to be monotonically
increasing, and repeated seq_num_v needs to be treated as an integrity
failure. Make it so.

For the first message, seq_num_v must be zero, and is already
checked. We can only check for less-than-or-equal for the subsequent
messages, where hdcp2_encrypted is true.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: d849178e2c9e ("drm/i915: Implement HDCP2.2 repeater authentication")
Cc: stable@vger.kernel.org # v5.2+
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260625104407.1025614-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 58a224375c81179b52558c53d8857b93196d2687)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index ebc2e32aec0bc..eb03e540d3b6a 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1642,9 +1642,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 		return -EINVAL;
 	}
 
-	if (seq_num_v < hdcp->seq_num_v) {
-		/* Roll over of the seq_num_v from repeater. Reauthenticate. */
-		drm_dbg_kms(&dev_priv->drm, "Seq_num_v roll over.\n");
+	if (hdcp->hdcp2_encrypted && seq_num_v <= hdcp->seq_num_v) {
+		/* Reauthenticate on Seq_num_v repeat or rollover */
+		drm_dbg_kms(&dev_priv->drm, "Seq_num_v %s\n",
+			    seq_num_v == hdcp->seq_num_v ? "repeat" : "rollover");
 		return -EINVAL;
 	}
 
-- 
2.53.0

