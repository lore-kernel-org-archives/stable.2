Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DBC3F4858
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785842505; cv=none; b=dY6fBq78qMBLaa/nVL0Y5jl8nLVgB8bCdFlEPQioAF1qG6C7CrVylFe+HnZsVy9OS4GvtXRef40TThCQfbBE5YSWfLLgW9NZg97fy1XOR+6MdOaCncSMVu9P2zyu3/d27x1tquSBpGBZnMtr8VOA8k9LS5zmAN7As21a4SywVNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785842505; c=relaxed/simple;
	bh=bYibD6v2DbuS+EvLB/XOyr1a8lTsIx2ICJa1u8Pr3w0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IrVnfborWIqbFy7XdBZ6AeqGzkjgkmnZnBulE8kCJGhowb5vYDPn2t0tU7SiEQ6+T9rEdkJ247gagLuIUkytYShbscvr6+teZRtyHQqQxY+O1K8HrfHc3jbHDyh+gbDLARXQQQCPfHNZBdsn4JD+WX56Q3GpHHe2kp7GI8akn7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bycSqJkS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bycSqJkS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97E91F000E9;
	Tue,  4 Aug 2026 11:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785842500;
	bh=LLNxrk2c5F7qFp4GBo4hZpjycukpME2RlkFwNi87L4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bycSqJkSmbvzxROZXc5lj6QHIhNfrDcnvV8jeCcR/lKhuOmfJswb52XRoPRqtwKVX
	 lO9S001JIm3owiZgTu9sHB1upqff57daL6FBSdABg7kby541cYMXY7qRdNN/j3c/t7
	 WqVGyoEeCbYmXJ8939f+HD914c4oNaGOh13a8DGTSVYLWs/JvraDQyt6AFrHssW4L8
	 CGNi7jyqsKO50LdmhacQZXHVke4tIwv6k3hLsn23Tp25camXsYIaOk9uTwBLym/cao
	 bA+JHFEemC5uGwGCfTMYp4ifczI4yQ9Z+xSf4J5ctrPAAJ0DsiVA7/TusF804UZe4A
	 6bqmYAYJgklDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/i915/hdcp: require monotonically increasing seq_num_v
Date: Tue,  4 Aug 2026 07:21:38 -0400
Message-ID: <20260804112138.2939525-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072906-uncross-joyride-b043@gregkh>
References: <2026072906-uncross-joyride-b043@gregkh>
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
index 17a8c2e73a820..e16527e74b523 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1534,9 +1534,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
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

