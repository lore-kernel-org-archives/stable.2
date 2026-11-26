Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667966;
	b=Qvr2/SIdr/ITzYHFuzdtxTqTXbNatp/cgFiyeqjWmrN1JFhdgyJONl7rfhwot+JuOh86
	 P3j7hjb6CovWWg4tXNflXEZGRYUE72ARkEcjgJDylw18/a6xpIz4msQKGvN7I7moPHxEx
	 mawLpGDrCf92MatsVzytmhb7hf8mq3k0Cj2SJLWrBRRStPc6tM5azKycAWdFiXWt1wu9B
	 wx1SvSqNEcdz+Cz/wguyxagGXFV1p6YNCmwyoYSRygqojpMVmnxjruNk7Gev3FXK+6uBe
	 zuKiZWkCml4lYg0gWdn2G0WGADpNWI8t687/xoLhk8MioKIzmWoRw7Ssl552K6NFiow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667966;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=SNcykCamj3yeW0AjRx9ghD8U363jzMiO9XRYflIPf2U=;
	b=WnNUkdIxgyzEAYSawxXMEoRZVzjV03PNEFyZDiwjY/XSF9IxQLc1p96udv7crEalqaY2
	 RzoyYeT8XfUBv0QLquJD058lUY1cUf+lJRAFlqDth1+QjpNbxpSVwtv4xOCx5FxOGNFNz
	 z0cp6ovmVcXgjlp22n9OJIPk71uI+lH9P86CR5S5IF//l1FtzlNNkIVWlPW8C17CEPLXE
	 sMBvIOF83EXrEcZxvz8x1Wa2/vdtRQQXQsyRL2DJTmBfqdGngsSOVozkQdFQH7P7bOcjo
	 BjAawjmS++hyM8xuhd89KAVeiqgjgWyzRV59D+aBQVMXzpAijZLdvcwxfl+MMtKUNlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnNiuB11;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48E8606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XnNiuB11
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 723FC1F000C4;
	Thu, 26 Nov 2026 04:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667966;
	bh=SNcykCamj3yeW0AjRx9ghD8U363jzMiO9XRYflIPf2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XnNiuB11xi1TS48Qu+O92frRqIw81z8kw6Z1tRIlT2SHgOUwB3eMRLx02d8b2Seo3
	 MA9k3FbGfmyKIDOBDz1FOjr4aemLVxHGdUrOMjGxEN/IJJX1n7YU/ViKGxIX8DT5UD
	 iixowIEJw9i+/69ymfO0z+rgRw3QWKnLWYBIrifANhQ+QOv4CV4b8ao8hFjrE9ArH/
	 6dcFWefn47r1gD3gkmNCCD2bKoRrn6XvwymfBK5z3y2sgVNppPsUEH+DeHzXjmZYrE
	 rtizID6IZ5C7YdtGMc/OgheowtfJvVw45kqZt0E+q88Czs7R5p1GM+h8wCXhucVPvW
	 ysOQOS65AeVmw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: liuyong <pkfxxxing@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: validate descriptor headers before query result allocation
Date: Wed, 25 Nov 2026 23:39:24 -0500
Message-ID: <20261126043830.1988633-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112507-oxidation-disperser-b8d1@gregkh>
References: <2026112507-oxidation-disperser-b8d1@gregkh>
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

From: liuyong <pkfxxxing@gmail.com>

[ Upstream commit ffb59029c0d52bf76fdd2678f5d6fd13e26220dd ]

query_info() uses the server's returned length instead of the caller's
minimum when a dynamic result is requested. A zero-length ACL response
can therefore return ZERO_SIZE_PTR to id_mode_to_cifs_acl(), whose
ownership-change path reads dacloffset before checking the header size.
A KASAN-enabled test shows a read at address 0x20 and a kernel Oops.

Validate the returned range and the caller's minimum before allocating
the dynamic result. Keep the reported length zero if validation fails.

Use the security descriptor header size as the minimum in SMB2_query_acl().
DACL-only and SACL-only xattr queries do not require owner and group SIDs,
so enforcing MIN_SEC_DESC_LEN would reject short descriptors that these
queries could previously return. The rewrite paths validate the required
owner/group SIDs and DACL separately before using their contents.

These issues were discovered and fixed by Qihoo 360's Tulongfeng
multi-agent system.

Fixes: 9ee2afe5207b ("cifs: prevent copying past input buffer boundaries")
Cc: stable@vger.kernel.org
Signed-off-by: liuyong <pkfxxxing@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Replaced struct smb_ntsd with struct cifs_ntsd in the min-length check and macro removal, since this tree predates the rename. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.h | 14 --------------
 fs/smb/client/smb2pdu.c | 11 ++++++++++-
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index ccbfc754bd3c7..fa6bc6d2709f3 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -182,18 +182,4 @@ struct owner_group_sids {
 	struct owner_sid group;
 } __packed;
 
-/*
- * Minimum security identifier can be one for system defined Users
- * and Groups such as NULL SID and World or Built-in accounts such
- * as Administrator and Guest and consists of
- * Revision + Num (Sub)Auths + Authority + Domain (one Subauthority)
- */
-#define MIN_SID_LEN  (1 + 1 + 6 + 4) /* in bytes */
-
-/*
- * Minimum security descriptor can be one without any SACL and DACL and can
- * consist of revision, type, and two sids of minimum size for owner and group
- */
-#define MIN_SEC_DESC_LEN  (sizeof(struct cifs_ntsd) + (2 * MIN_SID_LEN))
-
 #endif /* _CIFSACL_H */
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 82052c5a0ea43..521a67a21b3e0 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3769,6 +3769,14 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 				ses->Suid, info_class, (__u32)info_type);
 
 	if (dlen) {
+		rc = smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
+				       le32_to_cpu(rsp->OutputBufferLength),
+				       &rsp_iov, min_len);
+		if (rc) {
+			*dlen = 0;
+			goto qinf_exit;
+		}
+
 		*dlen = le32_to_cpu(rsp->OutputBufferLength);
 		if (!*data) {
 			*data = kmalloc(*dlen, GFP_KERNEL);
@@ -3837,7 +3845,8 @@ SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
 
 	return query_info(xid, tcon, persistent_fid, volatile_fid,
 			  0, SMB2_O_INFO_SECURITY, additional_info,
-			  SMB2_MAX_BUFFER_SIZE, MIN_SEC_DESC_LEN, data, plen);
+			  SMB2_MAX_BUFFER_SIZE, sizeof(struct cifs_ntsd),
+			  data, plen);
 }
 
 int
-- 
2.53.0

