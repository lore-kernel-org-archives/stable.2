Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0314C1E7C23
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 03:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785641129; cv=none; b=nrBKMI59dNJq205yZEOkObRO7nP1CZeiUR7A1wCDW1iVVD5xdVYPXKr1Tx+1VjvdA4oIHaf6xVUf+Oe1LJ28GqoPj3l28xsv+cq7WeyGvwtz/agocnh0f1Qlitze6rNPPQd6/IEN94e7CFl481RUOqj9OoQ3UTtxePPH2/8faPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785641129; c=relaxed/simple;
	bh=MZ4CRjXX4JQn+wMFDN/+giJnkORF+XiIE21U0kIKmOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m72ZLEqSXATexs7mhFfhutGoQhUdFNGIyq4M0B222dT3WIrCD7mlRkxT9DrFeakCQ/4p8JSN5yMfzCEEWLJFeqGrVAaoXh3HPHHX94w+7pZqd9LAk4WCRFB/hSGXrdnxfNGnO/7Ur58Z3kwEx75cUmduguRVt5RqDr7G1jlDxCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NPDhtqrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NPDhtqrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43691F00AC4;
	Sun,  2 Aug 2026 03:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785641127;
	bh=DavFD1sEjUvf9eveP7P1IKaDncWXx4LWcQQKDq5W6sY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NPDhtqrvTsbDAeKmMY7+0r5qCjJWaNmxg2hZzpqoqTMZslJ+Dw/UCzhc/w0VgJgTk
	 YHCXD9z0pDA14NesGx72CXwx3a2tvIq7PFzRglg2Ptvfb6xhQhbaybZduNZEaUUC/l
	 wKTOsvsicsssAY9sNS8jKheK/Gh7wsT4Aa+zWA9cGKdEDf9GSt2drVjnysrHvtWF5j
	 4wyGsOIOrXGzS+d8M0LDh6bugPMwm4ovIHCh5lRUI8h5XfSz+QY1UB8P8AQCuxwvKH
	 LEHioIznALQdHR2tpOOqBrcQJArVSSLFPRfjWz/oyDEj7GiE7gUUll8TXSfv/Vrt8Y
	 1gYp/IgK8TEPg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] drm/i915/hdcp: require monotonically increasing seq_num_v
Date: Sat,  1 Aug 2026 23:25:22 -0400
Message-ID: <20260802032522.2607746-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802032522.2607746-1-sashal@kernel.org>
References: <2026072904-impaired-parking-52fc@gregkh>
 <20260802032522.2607746-1-sashal@kernel.org>
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
index aff8ebf3657a..acd0cd49480c 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1654,9 +1654,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
 		return -EINVAL;
 	}
 
-	if (seq_num_v < hdcp->seq_num_v) {
-		/* Roll over of the seq_num_v from repeater. Reauthenticate. */
-		drm_dbg_kms(display->drm, "Seq_num_v roll over.\n");
+	if (hdcp->hdcp2_encrypted && seq_num_v <= hdcp->seq_num_v) {
+		/* Reauthenticate on Seq_num_v repeat or rollover */
+		drm_dbg_kms(display->drm, "Seq_num_v %s\n",
+			    seq_num_v == hdcp->seq_num_v ? "repeat" : "rollover");
 		return -EINVAL;
 	}
 
-- 
2.53.0

