Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 172D33112AB
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513650; cv=none; b=GV4Cs1M/vFSQtV8zAQiv2i8lM6HyNJGKRFM/vKXNCWa4FdovLe1/MbvjbTdNh3Q6ftaVTeyGOPccYnkQv359G3l8bA/7LHOyrIowrY3pkRadFyPP3nol6RKfertZqGF5j0/9wA0nVYtJpYocez1yVJMLWVa6NYnKPyA8EnyLbI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513650; c=relaxed/simple;
	bh=H4BdWbGA3RWrFfuGbTJYfRbqynPPSmYhYsjE9f/bJm0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJPHnWE/X8iqUNnAU00Avlb4DRUtlclThl+FBlruBs8y7VI/g4J4m5DJK4RcZgvLX71riOCNdLMbcXuP/wdUm+Eg0qPvN32RVmmW37da+BhvzHqbamwtXe8LTz/dm/yCoghZfCvNzCCSD4RcVBHdKhfjNU+yJkpimoV1iFsvvzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tm8J0MSN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tm8J0MSN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455401F00AC4;
	Fri, 31 Jul 2026 16:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513648;
	bh=f4/y1vLYrd2mfMSEi6gWLlnqcbGcmhOY+anaH7N8l2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tm8J0MSNAzrmkNWMWMNQ3OPeDqU2OeTVmThqSfOXW1Ghm+RAIOXKgNmnJsWKmQ8mB
	 B3D6fXT3kFXGg+t1M3pfPfOa3btOhv1MUWUXinZPljaHx2C9Me9K8AbU+WBAc2PDpW
	 BXmK10VtZnFOcK0z3ZeYN7YLDacYqDYS0AR8oZV2pgUskLSwZhu1NWF3q9ZXsXMmCK
	 hlPLRbxEaePhcqLtsJT2N8B9VcVoJ2JRkQIY90xTNgYPABfIdgLatVxX7wZj8AzcCi
	 OuSKydtd2GFXqVjY2+U2Tm23oElS77iKkzz2Kxjnnj0TaU0wNNgR4Do0MQUGqkmrSB
	 bHxxArb2R4fMg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Fri, 31 Jul 2026 12:00:46 -0400
Message-ID: <20260731160046.647386-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072924-dexterous-hypnotic-2767@gregkh>
References: <2026072924-dexterous-hypnotic-2767@gregkh>
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

