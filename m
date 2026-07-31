Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2377262E
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 02:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785465653; cv=none; b=fYYyTtgBRzAC27ZN3sMA01qbSqjH13po8jt3cClB3Wl+Lf0+4MxSYcygsjtthhDhg/020reLFyooTYd/lX9O0PymRZ2PB98FpAva/i+EAe+ELby9K3Va3UOkG6n/Vw2hncdEcxMBZt/Wsa1Z3KXfedeB3lWkc+Rm1gXkNYMoVXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785465653; c=relaxed/simple;
	bh=v2oepyXPJA9tQMPpl45X3K6i/rMd9vZyblVMJGttvnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rF7Lo4qf5x+uLirjxAxg9QvcL033nn9y+y76lNCcOFatUORnnZgmdVyqYvW87Babr2Nh6KCmgE4cRiIp46LFasGbSRgjERSjyoPeng58Wh9xmnjxEBG/j+4+inVP/daZC6iYJrAY64irTX44lDovRTL2brW00ehmUL6WxnGr4wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ln90gAhW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ln90gAhW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9BD1F000E9;
	Fri, 31 Jul 2026 02:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785465652;
	bh=yXzswdmQoMgJLk6Xs41TEr0owc1uc9UPVoGvdEBxXrs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ln90gAhWuN4YJWSrm2UdcjjDRSP6api92NCoY0+liTE9dghl2LRclKiB/IUGak3hC
	 MaBUn8zhfwC9edx/nnH9a1bHrStb775pgLm7uN3d5wdogeLLpjkpUtyO5wbYBGYFI5
	 LI+sXPED86xU+7s7ulzQ4Q9VDhU51976idH1yQDOa8m8TnySiorUAV6PUlfPFypqxq
	 xlx8SbXkm244UmGG1fudg+8b5PTeSeupmrhfY/OWN560VvwdfcE0pAG1mbDVVlEjdg
	 nfTyHkGBR7HYbkVfS6z9JORVPP9h2dePoGfHnDqSnjNjCWbNguSzcaRKd3qaWSibwO
	 QiAScVpKsf4jA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/dp/mst: fix buffer overflows in sideband chunk accumulation
Date: Thu, 30 Jul 2026 22:40:50 -0400
Message-ID: <20260731024050.3338370-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072934-rotten-illicitly-c4e2@gregkh>
References: <2026072934-rotten-illicitly-c4e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ashutosh Desai <ashutoshdesai993@gmail.com>

[ Upstream commit 55bd5e685bda455b9b50c835f8c8442d52a344a3 ]

drm_dp_sideband_append_payload() has three related bugs when processing
device-provided sideband reply data:

1. Zero-length curchunk_len underflow: msg_len is a 6-bit field taken
   directly from the DP sideband header. If a device sends msg_len=0,
   curchunk_len is set to zero. The condition (curchunk_idx >= curchunk_len)
   is immediately true, and curchunk_len-1 wraps to 255 (u8 underflow).
   drm_dp_msg_data_crc4() reads 255 bytes from chunk[48], then memcpy()
   writes 255 bytes into msg[], both far out of bounds.

2. chunk[48] overflow: curchunk_len can reach 63 (6-bit field). chunk[] is
   only 48 bytes. Multi-iteration payload assembly appends 16-byte blocks
   until curchunk_idx reaches curchunk_len, writing up to 15 bytes past
   the end of chunk[] into msg[].

3. msg[256] overflow: each chunk contributes (curchunk_len-1) bytes to
   msg[]. No check ensures curlen + (curchunk_len-1) stays within msg[256],
   so the memcpy can spill into adjacent struct fields.

All three are reachable from any DP MST device that can forge sideband
reply messages on a physical connection.

Fixes: ad7f8a1f9ced ("drm/helper: add Displayport multi-stream helper (v0.6)")
Cc: <stable@vger.kernel.org> # v3.17+
Signed-off-by: Ashutosh Desai <ashutoshdesai993@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20260410041901.2438960-1-ashutoshdesai993@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 70be5719e403..6ab217348477 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -779,6 +779,12 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 {
 	u8 crc4;
 
+	/* curchunk_len must be >= 1 (min 1 CRC byte) and fit in chunk[] */
+	if (!msg->curchunk_len ||
+	    msg->curchunk_len > ARRAY_SIZE(msg->chunk) ||
+	    msg->curchunk_idx + replybuflen > ARRAY_SIZE(msg->chunk))
+		return false;
+
 	memcpy(&msg->chunk[msg->curchunk_idx], replybuf, replybuflen);
 	msg->curchunk_idx += replybuflen;
 
@@ -789,6 +795,9 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
 			print_hex_dump(KERN_DEBUG, "wrong crc",
 				       DUMP_PREFIX_NONE, 16, 1,
 				       msg->chunk,  msg->curchunk_len, false);
+		/* Guard against accumulated msg[] overflow */
+		if (msg->curlen + msg->curchunk_len - 1 > ARRAY_SIZE(msg->msg))
+			return false;
 		/* copy chunk into bigger msg */
 		memcpy(&msg->msg[msg->curlen], msg->chunk, msg->curchunk_len - 1);
 		msg->curlen += msg->curchunk_len - 1;
-- 
2.53.0

