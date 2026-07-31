Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CC94457A4
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512984; cv=none; b=fHmqswVMLsu3C/X1lAXV33VSVFoiLzvHV3NNXfXqFuT6nBjpVSa9k9JQMc/O3wPPeXmkH5CG6SKD4mC+ML75yEgDaC+DNi0PboNrN2R5Z2hXM+9pQyoAmSntQA/EjMSQXQQlHEDsv5oCjdWyKdfpl2QuWuLo8A+u1Za6fNYiTIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512984; c=relaxed/simple;
	bh=H4BdWbGA3RWrFfuGbTJYfRbqynPPSmYhYsjE9f/bJm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeET92e24muzQuDDOvSuFk6YvkODj+BH42q8N4bN+W1BGZcEAfzKpqc0lJTQYoZiEq40O+JDMJrVsmR/UgpfKm8zkEIGx1eTGu5hZJUHQk5ScII5UzgS+GnULOttZx5ekRd5mkQ3YbgYO+iVjXucN+2pVDPZ+YHUHGe7Lr+udnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfU+nD/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfU+nD/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF701F000E9;
	Fri, 31 Jul 2026 15:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512983;
	bh=f4/y1vLYrd2mfMSEi6gWLlnqcbGcmhOY+anaH7N8l2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cfU+nD/gQagTGjaAF1mVUgOmP52+RYEi1pMUtFWkp81NMCWoaGWKfPVQdS2TmaWol
	 v0PipSzbSfISZ6JRyH11Mh+l0C0RS76vUPZjOhaZh9ChtMgccQ6pFal5d7amoG49Ha
	 FhmcLg0CjrwIa993rQc8JxWNZrkYAnPZHc7+NMXRXnSRacwzmXgBSjp0sf6GulTFGC
	 TMs57bpXbZIq1Vs7vbWmHbtG0yFiRn8XaLVQZkU+/TJ/08xEmALg8/zL0dCOa/es7f
	 0nDpQ+L3EN19ajqHx2Bk3qqWmZhlwYuewUC03h0D9Ci2ZYxWAQR/pmuNe9lkgFFzWW
	 vJnthOmzV6HUA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Fri, 31 Jul 2026 11:49:41 -0400
Message-ID: <20260731154941.601533-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072940-amino-awaken-61dc@gregkh>
References: <2026072940-amino-awaken-61dc@gregkh>
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
 drivers/gpu/drm/drm_dp_mst_topology.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 702ab6148425..32fa058e5f5d 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -859,7 +859,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -895,7 +895,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
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

