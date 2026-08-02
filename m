Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C774197A7D
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 02:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785638003; cv=none; b=lC/Utd6g8FjhqUvT4i/HO8WGWEEEzbJlQn6XrEPcLU4JfjH8COtpAqz2UEKO/F+mCoZGAaqq1EWtxG9uzo+/WS/14is+3qVbbxevh4QdKoeVFfzGzXGvII+nLSvbR2tt8JsTvzpqR6pSy2VJFBUy+VBLuOkOeEfvQdKZIV4F6LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785638003; c=relaxed/simple;
	bh=ZOngqvVkYqAm+5CZu955dwbQHj+0qSDkdR74uWkpBk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJ87XlupezMif20M5dnrNsjKWt1ojCTvGGR39w+S4xVot8ccDnvXkNb5csC7E1m2mIYQJw1w62t78B97a1cimNmbEOmS6QTwmLwxfNKSrbONf8xPUbkf9mvAzfVwHyuIWc5OsXEd/nN4glTloXrz6lh9ZXJqb5Ep5xcpQnoQiEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TrIoCSqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TrIoCSqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 793A51F00ACA;
	Sun,  2 Aug 2026 02:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785638002;
	bh=eYQAMdMHnWLxjCWEZQ8RQfy58aqSyh5ihjfS41P7KUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TrIoCSqrDN8/s2ES4pdWfCp46BW2IDHiD4C9INp3gydhgh6GdqSGpf7trLpVNXTJM
	 RiQVfZxUw7SnJ94LnbYMxVxz89P9seqI5roPDHQ89Cx6v6Z40QKTB67ZNjMfZVR+8p
	 C2PDsDNkjoUcsl3gZoMHsA+W4NmuaSktzkPKJIjXmaOZqyEjiNsykRFCsGO+icxRx3
	 u9w3MijR/efjtnE1zJn1/KPQh0Rvmp5k2YGpKO7B72A5Me637UMBaUXGLnblwVzM85
	 NDCHOrG2tNgoCeqhToxy4CkcaU/EUygI7Sk5pGt9jfwF6hBF3Grfml7jljiZmvue+a
	 gZo3PdCaaHKGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Martin Hodo <martin.hodo@intel.com>,
	Anshuman Gupta <anshuman.gupta@intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] drm/i915/hdcp: check streams[] bounds before overflow
Date: Sat,  1 Aug 2026 22:33:17 -0400
Message-ID: <20260802023317.1298318-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260802023317.1298318-1-sashal@kernel.org>
References: <2026072916-pelican-detract-661d@gregkh>
 <20260802023317.1298318-1-sashal@kernel.org>
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
index 8dff524933a5..e390875cb53e 100644
--- a/drivers/gpu/drm/i915/display/intel_hdcp.c
+++ b/drivers/gpu/drm/i915/display/intel_hdcp.c
@@ -129,6 +129,9 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 		if (!new_conn_state || !new_conn_state->crtc)
 			continue;
 
+		if (drm_WARN_ON(display->drm, data->k >= INTEL_NUM_PIPES(display)))
+			return -EINVAL;
+
 		data->streams[data->k].stream_id =
 			intel_conn_to_vcpi(state, connector);
 		data->k++;
@@ -139,7 +142,7 @@ intel_hdcp_required_content_stream(struct intel_atomic_state *state,
 	}
 	drm_connector_list_iter_end(&conn_iter);
 
-	if (drm_WARN_ON(display->drm, data->k > INTEL_NUM_PIPES(display) || data->k == 0))
+	if (drm_WARN_ON(display->drm, !data->k))
 		return -EINVAL;
 
 	/*
-- 
2.53.0

