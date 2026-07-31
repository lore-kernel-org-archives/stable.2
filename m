Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B79B3ED132
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496569; cv=none; b=D348M+mTTXV7Xn7feK33a5WtHUgr3on+yuSp5c6LAYMG5BuvtTc2cNHDpvPNLRHCiXUwShhxcuPvEc6M9X9fYy8LO1Ofgspr7ZcO/g/Pjr2tu1avSR3IwdlT9Vt9X4labLK72/BQhUZGxHBlQV8LEyWURbmN7gTWNEvrEgXAgKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496569; c=relaxed/simple;
	bh=yd3uGabJj4UkHFuNER/5om/0qltgnmcFDYFa4JmEX28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VwpyxJNF/oFNYqG39Xg/Dy2r3kWLAl2pcJqZxP4Nlivqbt0FqxkcOOj0bGTTHMv+83RYTs0OunarKOdos0HNj+9spvp9NaCOfu7ngOMKgLdo6NYj1cBmVW4lnwWCvgKRPnHTspjamwTxdAQizpaOLG1zSzNhJkOHYQp8NyjHPMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqs0Eo+J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqs0Eo+J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAF81F000E9;
	Fri, 31 Jul 2026 11:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785496567;
	bh=GLSurXN56xtV7WJ/InmG3zmyie2DTfvHQYhNLILwRSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Zqs0Eo+JVR4njmrG/0nDCW0pTb2Ig0ddXU/2U/+xW7WSWVE9NBAzc5mH6uu15eeL2
	 AcLb+MmwOPwgs5zGj3sMJcRI96fw0m9sp5VY3bEMqjSB+UAbDQCaac6UX+/Z7/IMTJ
	 D/ZQxD8YDy3pDdc4YTJ8XX4CyvZznnhVVCAbzxrBt3soVS8R8ksIq6Yb5LcVHSM4Dm
	 6uY1+BVrh+9eChslMIuv8F5ur7tPUvADZ9E0VcYfz8duD887+3UHsKR2JydEawIpj7
	 8HqG+YG8iL3NM87B02QVG+2L40RQMFKhfhAKD1r5qgmOgj5GtnsuqajkPYfF5gExep
	 SJNlCd6KzgP5A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Fri, 31 Jul 2026 07:16:05 -0400
Message-ID: <20260731111605.3643246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072939-engine-freeness-7723@gregkh>
References: <2026072939-engine-freeness-7723@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashutosh Desai <ashutoshdesai993@gmail.com>

[ Upstream commit 1a8f537f5a1eeac941f262fe73078d6b08ba83c0 ]

drm_dp_sideband_parse_remote_dpcd_read() reads num_bytes from the raw
message and then unconditionally does:

  memcpy(bytes, &raw->msg[idx], num_bytes);

without checking that idx + num_bytes <= raw->curlen. raw->msg[] is
256 bytes; if a malicious or misbehaving MST hub sets num_bytes larger
than the remaining payload, the memcpy reads past the received data
into whatever follows in raw->msg[].

drm_dp_sideband_parse_remote_i2c_read_ack() has the same flaw (noted
with a /* TODO check */ comment since the code was introduced).

Fix both functions by using a single combined check
(idx + num_bytes > curlen) before each memcpy. Since num_bytes is u8,
it is always >= 0, so this strictly subsumes the simpler idx > curlen
form and no separate step is needed.

Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
[added missing fixes tag]
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260510201733.2882224-1-ashutoshdesai993@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_mst_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_mst_topology.c b/drivers/gpu/drm/display/drm_dp_mst_topology.c
index d4a5489d010c..26fcf4333c01 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -861,7 +861,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -897,7 +897,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
 		goto fail_len;
 	repmsg->u.remote_i2c_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	/* TODO check */
+	if (idx + repmsg->u.remote_i2c_read_ack.num_bytes > raw->curlen)
+		goto fail_len;
+
 	memcpy(repmsg->u.remote_i2c_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_i2c_read_ack.num_bytes);
 	return true;
 fail_len:
-- 
2.53.0

