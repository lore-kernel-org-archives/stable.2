Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B792E7369
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496228; cv=none; b=FdJP9CtW0gqFf4rasrBmqldmTGyPCvr9EtGWE020AcEdXrLY9uw83B3gaY6iCE14rHxmcr8LgN8Zc2xTWKLo195rYV6Nm32/I8PNgfv8hce1AwIfCDueNgbMrTfKfG273jOdgLIj/wPiz9Vr8K6EKD2ZbsoS58hBc25lgpCfvaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496228; c=relaxed/simple;
	bh=QSbJjdlJSh3Mt/iBGu8HTIT6V4eRekfkPK/6mvMiN+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qdMW9Xw7clRzaxdugU+XmijQmu6f7Ri6Qnuh/c4FKXrfedN54jtmptjfGXgFWrRLIgDLpT4B0qog3RI8a+/9Gy2Jk/OwlhB8YSomw78zdhBHSzwWMfjKRV9H0W1iMnjFrdQIhMJ6aDFYfFAaAQsX5OzrtxPyStG0VzZNWeXMuzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgviwOjI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgviwOjI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4F241F00A3D;
	Fri, 31 Jul 2026 11:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785496227;
	bh=96fwWACIHUTSmJhQAKjLQWKIFk82Bic8FmUbAVI7BSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cgviwOjINadgQRMDvqyYIxol4INmF54cGKaH5DH9c4fn/1k6cYGcZ3LOnungwXQMZ
	 ojeS7eb8P5/Iq5Koi9VJEIdpSYlihMXz4hVhF1Mhy3s171r0Q7PmRQkuUpjT+pFzns
	 7yCh3t7ktSPNmgL7+5XTBlJy65xTU7S6nTPjlF6R1UOIT6QH0zo4DR8vol69WCrn4R
	 6hGlnWfib7sn8LY0PiKENbaOri5ew3B+CCZY4s3Lou0liZ8z3TDcS+QOLDUDq0jrJ1
	 0fAFYPyeHLeAzWLgGOC5fSzG+zqIJoy2hM8Uovser9F/z6BIk1x3O4P9xDQIa2hJje
	 rlkljuR1Y94BQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/dp/mst: fix buffer overflows in sideband chunk accumulation
Date: Fri, 31 Jul 2026 07:10:25 -0400
Message-ID: <20260731111025.3583242-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072935-scanner-gizzard-c917@gregkh>
References: <2026072935-scanner-gizzard-c917@gregkh>
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
index 702ab6148425..36f773a4ae10 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -778,6 +778,12 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
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
 
@@ -788,6 +794,9 @@ static bool drm_dp_sideband_append_payload(struct drm_dp_sideband_msg_rx *msg,
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

