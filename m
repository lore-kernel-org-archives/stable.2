Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A205F3C07A
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 01:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785635379; cv=none; b=Ri4gzomXzPDrcCVbqUpPFahbuehiWSMSDwugT5rSkoWEVjD/dTlhpeEiTVVqUFS/4RrlXisYm2H3vjcKfJo5yGvTqDcyAn03iM7UkG1cGo6Xx2x1lZhu1C/yqy/Q7IzxlO0+SnEyyoH1O413TFvvGuqy4z2MxUR58JEaWKHEf34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785635379; c=relaxed/simple;
	bh=4ZdYULuBeshttxU0rkJCmkyTLF4QZvMyG+Y5alNaA84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QebjI/f0uXwKnUD95sAoJ/XC2zcrPVM3sKQJM4WXeR5iMslBvvRMoGqNJRRt0DtCJlCMm7k/WHttjKh2vrwxYQLOt+9arOQonTRX9et2dAk6V6XpiyQYdYfxjpnnsU3zluzdmQ8rHOJiEze+D+arE0WnOrXaM7aqPX3YhQr7Unc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvYOf9fD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvYOf9fD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE8F21F00ACF;
	Sun,  2 Aug 2026 01:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785635378;
	bh=XFSR0o9sfJMiX9JeQBOeWEzbDJo6oX1TOZvrexsoiBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nvYOf9fDNbhZ7H2xnyjNpKWRC2DPM4Izxq81WpVy5oGFZsuQgBNpIZEMhOVgpXsjT
	 l49rSYlaCY6VmSTr04mUxladO2N8PGTm/4GHIuz4F+FkP3eLNXVZkkbj3Nb+USslsB
	 roVWgIoYgbO2h0VEY+CK59BJ7dH4PMzk4oYIoREJMk2+XJuuJvUTWOJTUvQyjNV7H8
	 DE8yShmg5XHPWRcfm2ZLwL37PwrZHXPxxC5UQlyVzJgc5pZv9WfBTiiueZsIGrBwjz
	 +Ibz7FgdKWMN1B/fMnv2281BLHvXUAK3QD0GxDd6l9xsOXBL9VnrAOMmxuOjbOW4xi
	 zLyB8qDIUnzEA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/i915/hdcp: require monotonically increasing seq_num_v
Date: Sat,  1 Aug 2026 21:49:34 -0400
Message-ID: <20260802014934.510825-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802014934.510825-1-sashal@kernel.org>
References: <2026072904-unwelcome-casualty-d8bf@gregkh>
 <20260802014934.510825-1-sashal@kernel.org>
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
index 565880d3a558..a72adce51dd4 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -1742,9 +1742,10 @@ int hdcp2_authenticate_repeater_topology(struct intel_connector *connector)
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

