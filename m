Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082A3B058B
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788826; cv=none; b=Y9dmL/5kNgb6srLoy7F8q3E0erHEG4Ul+JlGdoIgeMKOjK6shyp5WJ6r0XUpBHPOoueE2HrIDo/ORd/9eew7g4PTK2qQSIr3vRqespHNdNnvRA7LIFDvsi8gQozhpGOPIhlwGrE9euwLdv9AZG/2MWvPb3ptiuSA/XBGo5b/X/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788826; c=relaxed/simple;
	bh=gfyZzp1hXc5YPPqXTzkxrCpQyBuaIHZA9IysGMj0Uw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTQ2zK787VZzmRYFHf7TgQDI9VWjqqJGLdZxX04Xo5bHOqTNbG5xnzTl5Qb4lDOzJ4Wjg8su5WmaXJAqL/oxW7V4zEAYyXG7A1CiHShLEpt8N5AvLjckuX+Wf+QgpfwGoh9/MwBX1L9YRTTJADDhXNfWGgtIm5uARqQYCYyALX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGszczxD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGszczxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE89F1F00A3F;
	Mon,  3 Aug 2026 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788823;
	bh=1Rbg8+iMNUIVGzcw0/WK2lSTaG/SJppVdhfO9VFzhI8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cGszczxDRZwU6C7MK5E/4vnt9iNgMy4QFmPQIaZEVdoOmXvPB49Xz0s6nSSs7Ig4a
	 6Mtv7WQVH0nUuE5v4jJQLzHPlEEkrpqJNJ5fqgTk1xQCCbSLOBrRdWg/5k/FsFPUJu
	 35dXfNLXk+WiU9QG/9NT6xL8+RZptrt4T5SQe8i00179RVgOxUtz540pmKjKAwxHv1
	 2ShKwwz0wtLzbfW0Wa9lzTdkVi+tezHZJctU0q/2cfD3BUQm6ePWqL/Qij8ZnZHfdQ
	 yYLfTOia161wpX1zg//vGS9oxiv5XR6aZU14+SXQ4oxbPCsnDKwuxrsnqkeszug/n/
	 2mQYktPSMqZaA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/4] drm/i915/hdcp: check streams[] bounds before overflow
Date: Mon,  3 Aug 2026 16:26:58 -0400
Message-ID: <20260803202658.1647132-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260803202658.1647132-1-sashal@kernel.org>
References: <2026072917-dugout-sufferer-eb18@gregkh>
 <20260803202658.1647132-1-sashal@kernel.org>
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
index 15b28d056687f..3812bf6f654d7 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -2326,6 +2326,9 @@ intel_hdcp_set_streams(struct intel_digital_port *dig_port,
 		if (!new_conn_state || !new_conn_state->crtc)
 			continue;
 
+		if (drm_WARN_ON(&i915->drm, data->k >= INTEL_NUM_PIPES(i915)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id =
 			intel_conn_to_vcpi(state, connector);
 		data->k++;
@@ -2336,7 +2339,7 @@ intel_hdcp_set_streams(struct intel_digital_port *dig_port,
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(&i915->drm, data->k > INTEL_NUM_PIPES(i915) || data->k == 0))
+	if (drm_WARN_ON(&i915->drm, !data->k))
 		return -EINVAL;
 
 	return 0;
-- 
2.53.0

