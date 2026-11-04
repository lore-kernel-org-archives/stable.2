Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793817272;
	b=SGPsGerRFLlDrAYXEO1CRg3CNU14wdtRrvRZ1tZQ+g0Si0TrhGYOR5cnAO9+T9mpRMtl
	 1fHI/Xm+bNA4VSzpYIxyZx3/JBQx6LcmNHaJZdCKkzmAieIHPgHpq5S6Y8juk1SRFYT2X
	 v8Hzc5m5Xp25/Zvbdc/LXgDoF92p+8GhRxr/Yr7CV5gvwTvsNITap5Z1tbpn95awPNs4z
	 iWtdq7nlf2DjJlfkgWXoOBXRPUH/mtlkzDwcThNfjzDQCE3sVNdCdlXNsp2+e9EJPXpLy
	 i3LpsDGfce3l6iMgU+4m7aa8XYgEwFZbtmT8KlBMWKMEFPcjCFIK+8CNi2En2d7vJWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793817272;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7VF3lX76D54SBS2bnTeJ/gBfYwS0F+v6q0G+9+l7Q1k=;
	b=CODULn0RmOyHkd611wpgeg7eH0BhJbUwMX5kgEUaDN/uwk3dGTlM7VNUQ6T+B2Q3WfLQ
	 n7pm+AvfwYNV0U9ehRR0L6Uf14euJqX2n42pr+So7emYd/YGGbsAhIfjfgwmAAjDOD4AH
	 WeRnGrVzsm4m7RzgCsaSHaJ7z87OsAXw8Hr8piGQmXrEM/UNiIsPw0kR2ZgPKcGfaBxl1
	 Is1AQGsOl0auSEQnl6Mc+OHmLFGP6AJtPm03ppRHhc067O8f1Hz5Gw89lIdAJVEREHk96
	 saYd6kiuo52CmPbT5BR+2/If99FrMcOn7PhPHBwr5o31hEa4fQIh2MdZVYjO7bbz3tQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Datlep+D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78592606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 18:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Datlep+D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100BE1F000C1;
	Wed,  4 Nov 2026 18:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793817272;
	bh=7VF3lX76D54SBS2bnTeJ/gBfYwS0F+v6q0G+9+l7Q1k=;
	h=Subject:To:Cc:From:Date;
	b=Datlep+D7aoVYjBS7DXehwF44hHBb5bLHs1pV6rLdW+o9nBAKBBtEEYgyNaQyfy6y
	 /miPxoVnz081N/cy1xGY6HUnXcdlHJ0y1SrC+I806Z+BJL+tx+ttYRNktepZUrPsmU
	 PLppzMndQ2trA4A8R9rJYyqv1l2ja4/iWDwEhC7M=
Subject: FAILED: patch "[PATCH] smb: client: reject short SESSION_SETUP responses" failed to apply to 6.12-stable tree
To: suruurism@gmail.com,linkinjeon@kernel.org,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 13:34:29 -0500
Message-ID: <2026110429-gallery-shale-5858@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4d8930afa3446041358a7db33e7b23a0bb9459b5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110429-gallery-shale-5858@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4d8930afa3446041358a7db33e7b23a0bb9459b5 Mon Sep 17 00:00:00 2001
From: Abdifatah Suruur <suruurism@gmail.com>
Date: Thu, 22 Oct 2026 06:53:14 +0300
Subject: [PATCH] smb: client: reject short SESSION_SETUP responses

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

diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index 5e5cf92d1eb3..5f13bd7ce73c 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -225,6 +225,22 @@ smb2_check_message(char *buf, unsigned int pdu_len, unsigned int len,
 		return 1;
 	}
 
+	/*
+	 * A SESSION_SETUP response that asks for more processing carries a
+	 * security blob and is parsed as a normal reply. Do not let the
+	 * short-error path below accept a frame that cannot hold the fixed
+	 * response fields; the minimum-PDU check later is unreachable once
+	 * the early return has accepted the frame.
+	 */
+	if (command == SMB2_SESSION_SETUP_HE &&
+	    shdr->Status == STATUS_MORE_PROCESSING_REQUIRED &&
+	    len < smb2_min_pdu_len[command]) {
+		cifs_server_dbg(VFS,
+				"%s: session setup response too short: %u < %zu\n",
+				__func__, len, smb2_min_pdu_len[command]);
+		return 1;
+	}
+
 	if (len < pdu_size) {
 		if ((len >= hdr_size)
 		    && (shdr->Status != 0)) {
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 5d892300dabf..06a6ca0dc098 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -1857,14 +1857,20 @@ SMB2_sess_auth_rawntlmssp_negotiate(struct SMB2_sess_data *sess_data)
 		goto out;
 
 	u16 boff = le16_to_cpu(rsp->SecurityBufferOffset);
+	u16 blen = le16_to_cpu(rsp->SecurityBufferLength);
 
 	if (offsetof(struct smb2_sess_setup_rsp, Buffer) != boff) {
 		cifs_dbg(VFS, "Invalid security buffer offset %d\n", boff);
 		rc = smb_EIO1(smb_eio_trace_sess_buf_off, boff);
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
 

