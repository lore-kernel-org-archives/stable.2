Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85BE403E96
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788815; cv=none; b=D3UU6tsmMeT56QR1JTzSF/1qNvMKiQ+yUYeVUjzJxYdZAjlFZYU59cLWk/128nLB/idnGYdCNeE0ryY9R8qQNc4IFMSgIok5zKGkvzxPnyJAE7P6FKLWT8/a+RsGBLJYakB2NPHmiz6am1dxrd3bFTuRmQkHoJIGT/XNsC6VoXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788815; c=relaxed/simple;
	bh=Fpx+fKG4rEpAScnN5RCVpSBybPjwLd3pkY14Ssu9vDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqoV6lSshVVX8ndPct7OEehn/97xmNjEiXiCVQuyre1g0Ko/71klwY1zdUD84qif8jwbU9DUIq0ALMZs+GiEaXioawMDL2kMsetcD8lsBj1bQHv0qkcotawmCgRXUHuEGGOqmAHBJSsJcjUJj806km6IWN5iHKrJgeuvEm69rAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SVoyfbji; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SVoyfbji"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD01F00A3A;
	Mon,  3 Aug 2026 20:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788813;
	bh=XZoC6mFf4OLn2cTnrUue7ff2UphLRY0fb4AcbvevE5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SVoyfbjiwAc5FuYuyY6DWZcEI0SGgP0LTRJPxcevVF9x6MF97U0x4ot8F9IYBgpBz
	 BQ39Oey/E71klda0nMu733yk6aLU3Km1vrTLBpjqal3JOKdTwGQ6M6VoHe5B6+wSbn
	 IeKZVaqyPmUZDDnR3uhyhBOg6Lm4hYByi2RJaS1z+3eneRXwqflyhS3ARvN/7MTQq7
	 B1SG5jTIb1oL/Ee2R3mkhEI7F2qrCuQb1I12FOayHQnLXy2O6/fghTiY/7+WZoQd52
	 gCpRRgjOWhMcKkDolE0V0epLWlNJbesRG6flU5KF+QgT9jeXaJ6CoZ/oipn50VXP0A
	 BOu+qjqhHlwQA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/i915/hdcp: require monotonically increasing seq_num_v
Date: Mon,  3 Aug 2026 16:26:50 -0400
Message-ID: <20260803202650.1646505-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803202650.1646505-1-sashal@kernel.org>
References: <2026072905-sanitary-gills-9e05@gregkh>
 <20260803202650.1646505-1-sashal@kernel.org>
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
index f9cdd4db9eb14..f3b384ff0ace5 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1677,9 +1677,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
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

