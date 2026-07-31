Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F5D3E51D4
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496207; cv=none; b=fAGAHYaWfI/1R5mKIuKs4YHcpxQEPRqMuC8lFTxFAQfnce0r9jjUX6UNPCCgh1Zdqy0ynJwT5f7j125x2E98U4AI4yFFEDn4UOLvZ6zXf7N7a3FvpBdqOHoPAwApDag+Og7ZD+lhJEVzvkNVi0YyzQ9opnZZc25dX5SbwDJMEJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496207; c=relaxed/simple;
	bh=6Kd1WYba92PZni4NkyjW3srAnsuiVCh/5BnRFI6QHg0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ATarRHp9zFUtu0B0sgMyP0xdbSHLJbFLgMrWjOr3JwwLDLLDGYapEMIK2EoBSbPO2LFvIsMNgZB40xGR/TLR7M+aF9gMa9SKtu3C+2pxGLYKYhAbPIdM+gKppy/aY7mbC35HdNa5NHZbLmhcxaAdV9HXbjjXaqIVeaNArL8uNhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRQGK9aH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRQGK9aH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79BD61F000E9;
	Fri, 31 Jul 2026 11:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785496205;
	bh=FWTeoKfm4WDMHjqrjsWjh+HXMK97G0xP7470EdnU9Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DRQGK9aHBrY/nmlaLXrvrAQgnO37kSzMdmCyq5S2UnpEMVV0tnmCJPLfnuKDvWawz
	 aotCfUUOR8XsT98yc3piAvcxAC6z4VgHfrCC+s4SgWDlzJspIte/gZLaa3wjjMglwP
	 aarqAcJCMa87PSCQy7lpRvGNGkrlcy6t8Ebgjm/TeVn3jlqOLm074lIsU4s2LutC5m
	 SbFCa9seVSAPDXA3CXB8KdvP59rP99WYPF/hsOhts/3/Kt2CrO0Z1xCy4G5j4FBGQG
	 Dn6lqtFtd8DdmVabiabf0PCc5F8wrivDhQqo2EU5KIKZve2UJpwPdAuf/GQ0FdLt5j
	 wMrzeJId/+yow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ashutosh Desai <ashutoshdesai993@gmail.com>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/dp/mst: fix OOB reads in remote DPCD/I2C sideband reply parsers
Date: Fri, 31 Jul 2026 07:10:03 -0400
Message-ID: <20260731111003.3571684-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072939-sphinx-pug-e869@gregkh>
References: <2026072939-sphinx-pug-e869@gregkh>
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
index 997f2489f00f..566be1fa6867 100644
--- a/drivers/gpu/drm/display/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/display/drm_dp_mst_topology.c
@@ -862,7 +862,7 @@ static bool drm_dp_sideband_parse_remote_dpcd_read(struct drm_dp_sideband_msg_rx
 		goto fail_len;
 	repmsg->u.remote_dpcd_read_ack.num_bytes = raw->msg[idx];
 	idx++;
-	if (idx > raw->curlen)
+	if (idx + repmsg->u.remote_dpcd_read_ack.num_bytes > raw->curlen)
 		goto fail_len;
 
 	memcpy(repmsg->u.remote_dpcd_read_ack.bytes, &raw->msg[idx], repmsg->u.remote_dpcd_read_ack.num_bytes);
@@ -898,7 +898,9 @@ static bool drm_dp_sideband_parse_remote_i2c_read_ack(struct drm_dp_sideband_msg
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

