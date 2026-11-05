Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907749;
	b=Vm8iGxJvLIvtRAbtcwbXFGfKy3Iu7hkeMe/dGMDWmaJ0j9h7Af/+EaWFqkwWZKRFrvNg
	 5kGQLjqPc+q7jEWBEJX8UfiAsW5i8qTyODinfIEnTE423C9OhsXGFm40FCSBfdAyD+FOT
	 gEjdFCZO81LR0xcRdvoPK6ZHprWU/7TicOUQTFq1u9EC+ydSRZnSL95xwMuMpVxKenXPY
	 4FuLpOEWxJFMrYGlJbMpVUFmXzhZrAwgLEV0NK2uUd34l8eNSoQk2RYzBHCVilXNdEY8B
	 /khsJ1dK58aKqD2GFkxPjR6ZWY4t/JtI2bQTDcNvGXrjExiwpDkXk5jzvq4n8JkCmPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907749;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=91UEnd57FTq0Cy6nApBdUhOj9hrLnJ35AYMM9XwA3pU=;
	b=HpX5Bl1XOL/NlYfxvo2UjG28LJj6cVc1gm1EWkD0PBL0rDEoLHLwizMFMsucxlj2u2Vw
	 ue3t1Lp+jIc36VF3EEYwKVaJzqJYayw8acjkCwkjpIJmhkDggSgT+zRsvwEMT3x09/o5s
	 gwAqVS+DJXhI4Bv2eFcqRC97kkcfsXEBO5e7/7aKMuuMQvwVCFJlHPgDRAe1O0QKaJPlP
	 DMrFHjlpd4907379PHrpjpKrgWWonbjEQNRkA1zqi4ZsxAgPTZxLWgeWZF0243mZ0yPYN
	 HwsK29rB2fu1Xus+oC6HR8vj+0eILH4llJHBPnn+s6bBy6941/OW7WpeFSk5zM5ytAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aN5UOu0m;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A176077CB5
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aN5UOu0m
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8691F008A2;
	Thu,  5 Nov 2026 19:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907748;
	bh=91UEnd57FTq0Cy6nApBdUhOj9hrLnJ35AYMM9XwA3pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aN5UOu0mttz0XOfNPm2DNC/qNpgs1VZVMO2V5A3T/7r5QmrpNlCRoHUqU/ryauP7i
	 GYoPKU4GXS8WHY3D8U+mjWGe+ijE5/aFf68gxVDWCjtw5w40kqn9dNKNGMeaAMt+CS
	 mvMqWkCVSj1Lp5WoDwMHLTayHQ44mKyDwVSvf6KUL+W8n28Ehrx6VRU464iK05QqFw
	 XR+eFg5zcQrn2/GmTZ8UdTinylTdQGZ/5l2mrFVug5wZ9Zht9muwHy6kcd6LOcrYgh
	 Nm7LqJhBqW9SoMDgxSD+rYdnTTWFUSgfBFtY13NJ7FhOH6SWJRV12YP7oAEIW0Hc+g
	 m7I8+LmCjy8ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: reject short SESSION_SETUP responses
Date: Thu,  5 Nov 2026 14:42:27 -0500
Message-ID: <20261105193919.2652679-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110429-gallery-shale-5858@gregkh>
References: <2026110429-gallery-shale-5858@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdifatah Suruur <suruurism@gmail.com>

[ Upstream commit 4d8930afa3446041358a7db33e7b23a0bb9459b5 ]

smb2_check_message() accepts frames shorter than struct smb2_pdu when
the SMB2 status is non-zero, before the minimum-PDU check added by
b4694f269e66d. A 64-byte STATUS_MORE_PROCESSING_REQUIRED SESSION_SETUP
response is therefore accepted even though it cannot contain the
SecurityBufferOffset and SecurityBufferLength fields.

The parser then reads those fields from stale bytes left in the reused
receive buffer by an earlier frame. With a long stale
SecurityBufferLength, decode_ntlmssp_challenge() copies up to about
64 KB from beyond the receive object and sends the data back to the
server in the NTLMv2 AUTHENTICATE target info.

Reject short MPR SESSION_SETUP responses before the short-error path,
and validate SecurityBufferOffset + SecurityBufferLength against the
received response length before decoding the challenge.

The ordering bypass is not new: the short-error early return predates
b4694f269e66d, and the unvalidated SecurityBufferLength read predates
the 2016 raw NTLMSSP split in 166cea4dc3a4, so all supported stable
trees are affected. Reproduced on 6.6.87.2; the path is unchanged on
mainline.

Fixes: 5478f9ba9a34 ("CIFS: Add session setup/logoff capability for SMB2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2misc.c | 15 +++++++++++++++
 fs/smb/client/smb2pdu.c  | 18 ++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 23320b794b177..7be338ad755b1 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -193,6 +193,21 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
 		return 1;
 	}
 
+	/*
+	 * A SESSION_SETUP response that asks for more processing carries a
+	 * security blob and is parsed as a normal reply. Do not let the
+	 * short-error path below accept a frame that cannot hold the fixed
+	 * response fields.
+	 */
+	if (command == SMB2_SESSION_SETUP_HE &&
+	    shdr->Status == STATUS_MORE_PROCESSING_REQUIRED &&
+	    len < sizeof(struct smb2_sess_setup_rsp)) {
+		cifs_server_dbg(VFS,
+				"%s: session setup response too short: %u < %zu\n",
+				__func__, len, sizeof(struct smb2_sess_setup_rsp));
+		return 1;
+	}
+
 	if (len < pdu_size) {
 		if ((len >= hdr_size)
 		    && (shdr->Status != 0)) {
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index cb164f87f9082..28f9ea7edd4f8 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1773,15 +1773,21 @@ SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_sess_data *sess_data)
 	if (rc)
 		goto out;
 
-	if (offsetof(struct smb2_sess_setup_rsp, Buffer) !=
-			le16_to_cpu(rsp->SecurityBufferOffset)) {
-		cifs_dbg(VFS, "Invalid security buffer offset %d\n",
-			le16_to_cpu(rsp->SecurityBufferOffset));
+	u16 boff = le16_to_cpu(rsp->SecurityBufferOffset);
+	u16 blen = le16_to_cpu(rsp->SecurityBufferLength);
+
+	if (offsetof(struct smb2_sess_setup_rsp, Buffer) != boff) {
+		cifs_dbg(VFS, "Invalid security buffer offset %d\n", boff);
 		rc = -EIO;
 		goto out;
 	}
-	rc = decode_ntlmssp_challenge(rsp->Buffer,
-			le16_to_cpu(rsp->SecurityBufferLength), ses);
+	if ((u32)boff + blen > sess_data->iov[0].iov_len) {
+		cifs_dbg(VFS, "%s: invalid security buffer length: %u\n",
+			 __func__, blen);
+		rc = -EINVAL;
+		goto out;
+	}
+	rc = decode_ntlmssp_challenge(rsp->Buffer, blen, ses);
 	if (rc)
 		goto out;
 
-- 
2.53.0

