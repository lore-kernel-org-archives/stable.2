Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522FB3B71DC
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785497608; cv=none; b=daIwAHKhZqmOIsNQp30QxG6RlH1j5R0ntQcqfimQaEtUwJEP+4AQBnlSe0Y5CdkGuWBsAqxtkwi9Jl0RUtAy/FlsNHX7ZL/CXKdxn3yl1eTjhRPeYAd6LDMfQEnef5kapvVh4AoXLKhqSr7R+RBeABAHcUb8l1vJBtmy/C1Dr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785497608; c=relaxed/simple;
	bh=acMVSnnBfP4/A8niwByr5PVqgzFtdNWXtvbU4R00lw0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i7EBUI142nuValzPnVv4r3E+rX/OGCBPh+nCtZHqRbLb3m6QnuryzEOCERG8ZdxvsMbh26gy0VRCe5A5M9a1X3lGP7hnGLFEGJa+W7B3fdb7w+34lJCaho6pUc9xuEQQ2BxpyRbAy6u9m14A91DNK7KBsWjJxmk0OqLTE0QE2n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSSz4Wrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSSz4Wrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 800881F000E9;
	Fri, 31 Jul 2026 11:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785497607;
	bh=K5wpzDPnaqtoZnB3ZcDmtbZDR3cL5ySfN0sVFkmEiyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iSSz4WrvijNo6W+t0nEjeA7Yu/geBzmRpqC/9TEPz9WurjuLC6IGGrEb97+f7/aMu
	 iIW3OBKOIfkbGB3vRr9emYU3q1OGAA2V/3BdEiA5ohdg1USQ9Z7gVWwI3+w41wZJEi
	 n9LZrV/hLv1bz1TiRj38CuKVxA3d0Ng87AzeHcOuXqNdRx57LAUMeXyDW4MgUJpdeU
	 2NfqPkV5LYWOtElctKNU7hCP7mW/GxC0QWtyf0cY8yQXiiC/6OcbHdOjlhPYTPe9cd
	 krwi3Urn8r3tqxb+EcaOP26V6gyeDejjfyyvoBlQG61HelrPlF9hMXWtCZBofMUQ1h
	 BgVK0WB7VRmpw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Fri, 31 Jul 2026 07:33:24 -0400
Message-ID: <20260731113324.3700825-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072940-harmonica-stage-8c21@gregkh>
References: <2026072940-harmonica-stage-8c21@gregkh>
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

