Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905431;
	b=znYIN6KuqSrLmX1MiBoQhnXaBJYNuSHjNZ7AA4pLwAffqe04r2WjAvApHimQ0POST1S3
	 FAaSxmu+LvpPJwjJh/z0IJU1WnqqU4/OHXi5UvkhxUTqn5ggg3uA/wR8+iMmApY6MavxR
	 GyoSTiikaQYEpcp3/0wzZpJh4LUui4eoiz+GMoyioA0AfJCeCAv5cgrHLcbaDcYzLB4gS
	 c07sZQHmtCyxZWm5pZ8c4b/PPmr2Oe1PrPJvBbxmQH11gFjW0H6hRcnRZd4PC/4amXvT6
	 OVC9zuMyA2V4AChtEJ3+i1tMjoZJDa7tm3NcFovZzVhVNPAxnfEJpNeJ5hZyTO1wiVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YTKbx6cV5efdjD7qHslNTjhF0CpPnT8IpYRWlG/OMUg=;
	b=nOa+EO6UeEPhTkjmWinxT3Cp7NrVToDCkmF1C9T0GaFlzwwvt9vsB8DWlF8oydbQaXcA
	 HNcI/1/2JQXtR9A/hXBnLg8Ggk0Qk2qUlyRSO/gaSVR3ZAOiD85iJqeu5+9SCJZcFUMQb
	 gGwqfBM+ogOKFsrvzJ3ue9JQjkLmlswfttzz5N7LFmOjVdizFMzj5DP4FFsW3ZCbBPVTn
	 C7cZVsHGb3OmMfrJaUpEXfKcDwggvQbYEtHzDTSSfOIVAvXhZN/+r5vi++X7WNZIH1NyW
	 ooYqTPWf6o9egXEtZ9hW3OW1daegwnBnHhnJeB1J9MU0BhBQzNJquHAAAkAkaULM8Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLWd7xT5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D01606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lLWd7xT5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75AD91F000C1;
	Thu,  5 Nov 2026 19:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905431;
	bh=YTKbx6cV5efdjD7qHslNTjhF0CpPnT8IpYRWlG/OMUg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lLWd7xT5oyRYt6ZmdR6YG5mukMP1ipSZK0jlWL1i3eBL+AN7S76Q2+zdBUWjmD+IM
	 cu7zgOx3Nor0AwXDgmus8y1i4fVamzbLeWLq2lKbSyxoLykDWuF2pPpxlD3GQ/RpsU
	 tReKrd7Ip6tKBGnZ/OBXNIwPsgo9KYqntHTLLA4zZn6TLRjeyyE8zsd8Al194xw2g8
	 MnqMikgk2OyRGWMxuQsmEG7cZW5m4r2DzOkDdfEhxM8dbcOoY0IsUZLwtVIB40hxOy
	 jloeWAFEVyVLg+c0PyZqKXxHePlCpftImP9/9a7q0HcOqEFn0rxUa5+5sfVSqQ+uA3
	 G4CMrbJQq5C8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: reject short SESSION_SETUP responses
Date: Thu,  5 Nov 2026 14:03:49 -0500
Message-ID: <20261105190313.2634432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110428-citizen-exit-e402@gregkh>
References: <2026110428-citizen-exit-e402@gregkh>
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
[ sashal: Replaced the unavailable smb2_min_pdu_len lookup with sizeof(struct smb2_sess_setup_rsp). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2misc.c | 15 +++++++++++++++
 fs/smb/client/smb2pdu.c  | 18 ++++++++++++------
 2 files changed, 27 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 34d2401c6c665..46c98d024f068 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -194,6 +194,21 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *server)
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
index 6d610f136f43e..e5efa7f02e12d 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1757,15 +1757,21 @@ SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_sess_data *sess_data)
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

