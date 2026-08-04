Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D48D30C606
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 01:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785806659; cv=none; b=IHebPLdS0xW/2JsX0Tfk/YR7FS3I1M1XCQQLXUU/r0yauE8Wqvdei/S2v4j3QYjgEnZWr9IA5Ezg4fef6e5d0BsZcgysU3EWNJgxE9f1CGzOIMQFbNVFtqNhRM+Wm44lO4ifjGpUNakJlRivhne07c1l5NEpyxkchY7Qi6TK3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785806659; c=relaxed/simple;
	bh=NitWhAF+2eue94Pi4DKhS6y2RtBbaTePGfIL0aDRvso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPMu50CnWSFiU39E7HyVNWev/o+XgWDj4xsZs2CdjFJD/zrROkjLM27LN8QnK45zv2kCHHprs1Tx44aRlfRnln/s0GWbH+Jx99JIkBLzeXSQar4zDKAbCdUN3ce5aU/Et5t9oNqnmeoWRtY9iE3GzyC28/Vi5tqDZpoqA2w1+/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nVrRExTZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nVrRExTZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531331F000E9;
	Tue,  4 Aug 2026 01:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785806658;
	bh=W7wW3XB+s5rNMWBlPt6cs0QZVkIXluLHJ96Tn5aMVyI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nVrRExTZyqJrDbb5dgmGLspQ9pZcUD7wU//r1rnjU5Q9gmI6Y41fD2FJb76Qkbit9
	 A3OhEejhGEMHBtszFOHV6SQMR9DbUtT/smc+GeFGerAS+m+Yq76EoZ2SN/d88AkWP/
	 xmdaQeTcg0rqqYtdyAsPYe6WYUSw0MW5REtmbZcvguHJ/J0QGm8Xk9p3betct4yYmH
	 Nc82ECWJNu3FjMRYeOD/slc/7w7WaHEcc1ehuUGzPFaG3izh0A7XIAWN6UUAzz5qV6
	 NH7inQ0ovzfKQaL4/mG91/juyBt4xzKHS+T9ncY3wzPzZ7cFCPX4uDm/wJx0KRRAxk
	 9Ekoot0q+xTPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/i915/hdcp: check streams[] bounds before overflow
Date: Mon,  3 Aug 2026 21:24:15 -0400
Message-ID: <20260804012415.2389735-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072917-tribute-crunchy-bb86@gregkh>
References: <2026072917-tribute-crunchy-bb86@gregkh>
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
index ebc2e32aec0bc..cc159d9261456 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -89,6 +89,9 @@ intel_hdcp_required_content_stream(struct intel_digital_port *dig_port)
 		if (!enforce_type0 && !intel_streams_type1_capable(connector))
 			enforce_type0 = true;
 
+		if (drm_WARN_ON(&i915->drm, data->k >= INTEL_NUM_PIPES(i915)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id = intel_conn_to_vcpi(connector);
 		data->k++;
 
@@ -98,7 +101,7 @@ intel_hdcp_required_content_stream(struct intel_digital_port *dig_port)
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(&i915->drm, data->k > INTEL_NUM_PIPES(i915) || data->k == 0))
+	if (drm_WARN_ON(&i915->drm, !data->k))
 		return -EINVAL;
 
 	/*
-- 
2.53.0

