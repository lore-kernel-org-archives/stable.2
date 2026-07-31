Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5B33C1414
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785498519; cv=none; b=crhzMID3+0y0ATC2Dj6pSEu6lz32heO+0DTKBnDekvbIf7ng0a3ppLQV3CpJgtSIK4xtLxwc/fslYHA/hnUN2FbkEJLhSwYObEbS73VkI7iYQAqjz46jSIcDyehFwLJkzuYH9m2lJfSH4i+iDe6s3T/GfXW12CLrypLxkynXOZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785498519; c=relaxed/simple;
	bh=acMVSnnBfP4/A8niwByr5PVqgzFtdNWXtvbU4R00lw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MczJUAU0KKUAmhpQfOzLc+qTgn5wifYLtMZcldXsBTvp4hTvlAXeboXnovdU6ttxQTfQB5NQIx6RsS5LTY+WLmZodU3NTvF5saoD2nDhZODF17Pdpt9akR9XEPv1o4D/P3GLgo1ZY0AB39dsHUSSNYsYOoXoyKdmCR+5BP3v2zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b29EEG0v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b29EEG0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7401F000E9;
	Fri, 31 Jul 2026 11:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785498518;
	bh=K5wpzDPnaqtoZnB3ZcDmtbZDR3cL5ySfN0sVFkmEiyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b29EEG0v7Bqx58HTk90V2yE9tzGTP0Su6Go2pepQczysT3Zw9S9VEGg2x56wzOljt
	 lAiLa0/W5i8SGVdHbq78wmmfcoJvYxj2XgBeRzmu24Fn9fpA+QEdTiXKumVq+aoc6R
	 nu2PU9BPQ98a62+PMIwQWWmz8LS9wurD5GbVRC9DJGQr+ZDIC+tiheYTErZD+yJ9CF
	 OsQO9EgTYEK8J5GOSo4a+IFvDibRBgT3L4S2VmXDm9hkiRIQbpxsCC5ge6t45E8iIv
	 +FDRICAZJxVD7OWqPugD5pZwVH3nJza7SxXSwe+8H/UHq0GC7cpn4LIAAvIwVTXf7H
	 hs0+F8nVqICGA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Fri, 31 Jul 2026 07:48:35 -0400
Message-ID: <20260731114835.3778089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072924-unrest-sleeve-b8a7@gregkh>
References: <2026072924-unrest-sleeve-b8a7@gregkh>
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
index 70be5719e403..35604c8aeb27 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
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

