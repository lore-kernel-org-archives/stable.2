Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311ED3ACA58
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 01:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785805601; cv=none; b=Ja1Pd8QaQ2Qe4IAOQAv0yvVbh5Q5wK+Kt0X+niyn3W1n16YixCZhgxR/v/MARuEiQXdbb73gBmo87PVoUhsWhVHXDMkKtu/F3CuWq18RiWaKrucEHlfH9r1GQ84Dc6/gUY9KpKYB5zHUT/GF/+ErYdhjwWbqyNVgaOz2qy8HRkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785805601; c=relaxed/simple;
	bh=P3buKRvi6WBA25AAS5vTuSTs/yGmMPb9qTgwYu3vnH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g+chwmHeXUTIs5VGX4KtNNijiiCa/g37sROE66TGQ9O06Kr8672P6KruCX3JWEIbO1Ea+ltgVRjlWY2Va8JnTuJOoYSuFsSorJHQnQj/GcNtz2nJk0i6ISqWdSfunMA6qVO5+A9jpDRBN5jFdoguu4Ryb6VrbaYuB/krEYSW9eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9745jAL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9745jAL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18C451F000E9;
	Tue,  4 Aug 2026 01:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785805599;
	bh=evM60mehFm6oQmpMpmDxa8BQ2iFlfyNMKkLQppRc9hk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E9745jAL8eDQGSr2Yy9f1Jz1OYeAWxNynqNbvgMsASfu9JroYWwC02uckyWMMlRGL
	 fXEjwOz+yYgTnTcS8jjAXKnsa4+OM4mGl2pC1rHa8qilMK/anESMsFYvGbFLN+EGeZ
	 BM26fL1+XJrQx+HlWIsHAMGPqNBg4PI0Trl6nEU1baKoDI5bC9l3JWK05JO0XGD287
	 XXv0Sm5yqO+c7XbsH/VOLDfLo49+eH51X4/i4Lq97V6Ha0NwkR0L9+vpPUZotouboP
	 PSAfUlSlsK/rWYW4ye/+jP3vHPxrHNsAEmA3AUZvgZDcqVdyN/Y8o4S+qepB6FZgcx
	 bSph5RQRllbEQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/i915/hdcp: check streams[] bounds before overflow
Date: Mon,  3 Aug 2026 21:06:35 -0400
Message-ID: <20260804010635.2350358-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072917-oversleep-unawake-5cba@gregkh>
References: <2026072917-oversleep-unawake-5cba@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit bbb15a6b042d02e5508a02b4847e02d2579ee7bc ]

The data->streams[] overflow check is done after the buffer overflow has
already happened. Move the overflow check before the write.

Side note, emitting a warning splat with a backtrace might be overkill
here, but prefer not changing the behaviour other than not doing the
overrun.

Discovered using AI-assisted static analysis confirmed by Intel Product
Security.

Reported-by: Martin Hodo <martin.hodo@intel.com>
Fixes: e03187e12cae ("drm/i915/hdcp: MST streams support in hdcp port_data")
Cc: stable@vger.kernel.org # v5.12+
Cc: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patch.msgid.link/20260625170304.1104723-1-jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
(cherry picked from commit 9284ab3b6e776c315883ac2611283d263c9460fd)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_hdcp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_hdcp.c b/drivers/gpu/drm/i915/display/intel_hdcp.c
index 6406fd487ee52..6771983da5f14 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -98,6 +98,9 @@ intel_hdcp_required_content_stream(struct intel_digital_port *dig_port)
 		if (!enforce_type0 && !dig_port->hdcp_mst_type1_capable)
 			enforce_type0 = true;
 
+		if (drm_WARN_ON(&i915->drm, data->k >= INTEL_NUM_PIPES(i915)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id = intel_conn_to_vcpi(connector);
 		data->k++;
 
@@ -107,7 +110,7 @@ intel_hdcp_required_content_stream(struct intel_digital_port *dig_port)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(&i915->drm, data->k > INTEL_NUM_PIPES(i915) || data->k == 0))
+	if (drm_WARN_ON(&i915->drm, !data->k))
 		return -EINVAL;
 
 	/*
-- 
2.53.0

