Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667022;
	b=FaqxVIIkjcFrzJmnh7enuWHlKrcHq4+EnsFedo5AWRqMgtIX/OtPNvT+D0mLAzDpCm0/
	 /EJD0DCcndlRLHE4vYt91EozikJOinZa55+yZSuodblDTQ2rcPHOIFTO5nmBWOkaX401D
	 WKgHjy3Qyx11dkPQ888k4LY40fEByTuh52CHXDAeR6Zck/eva2gQxAAH5dVF1zFu2K04L
	 FwHXNr4ZI1Fi+L4CHm4IqYdTnS3KmBc2KxkrgHEVRDv2Km0uW2/fmIfsnOWkk36NSLqpw
	 5qcNn9f1q3xF6LP6ZHdQtMYAjlBrEP2aVflArQregky5MUjSF7ihtRKCEjtzxNOxmZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667022;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5PSU/YLixyVQOCVPgEdTrN5ZlsKLMng3hkgCE8VYYPM=;
	b=mJaokjZ2HkPZJ45GliPYv17D4tH75ReSpngTbtmF0CQh0wy6Yjcu1XVrPUWGsfMY8adF
	 Rh+gqg9PYPQQmNTxM/ez0xuARx2Wji3P8QfEHp7yEaMpIYeVeZ4K2CMF6yYUQ/Zhfp6Dw
	 CZgGIO+taOfT/NVP+lLzljM+BRsNcXkpfWuLXuSXa5RCtPjcrV5cGKfuAHAal9lTvq4u9
	 yvVq+Ki2aSv+pU4bIhy/WEYV6ZOkvMUNfze2x/H4LqYWIZiFKs4+EsAYvqLwq/c0j9o4I
	 p6KagDDKVTZgiWGKB8cIpJQ55rWFRJbDlo/onTbVXrbZRJkKvWN46Fe+W/JOO3uW6sQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On16Pyxj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BE606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=On16Pyxj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971D81F000C0;
	Thu, 26 Nov 2026 04:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667021;
	bh=5PSU/YLixyVQOCVPgEdTrN5ZlsKLMng3hkgCE8VYYPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=On16PyxjtJl59wZ0sCuHdCnhPhRT6armbz3SaiIdAM1ZWb+q21B+t/qhkWg2aNNn0
	 aC2a77M6pKXdbAGQKGI8yT2TGt7qRGeFMbX9gfrrtYKHCD2TD8KEjsEHyEBAAn0iFy
	 2xs9iGGx2qzxmRgSfJBFUJY1JvBGDgGUitkBdo7mnTsurzSk4HfqfdR7w9F6YZ/3O7
	 33vkxNoK4UiLohAJX3y/LDM00OLGRCsjtDkQqiKLJFydgVYQDlqYpZy6vBDxmlKmrL
	 CaJe2j/ydf8s8EJq7bC5skqNLzjPfmEdG0QRfny/tPxsGR9LmX5l/q1IXbIgNdDc0t
	 draQIq+JmwkEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: liuyong <pkfxxxing@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] smb: client: validate descriptor headers before query result allocation
Date: Wed, 25 Nov 2026 23:23:36 -0500
Message-ID: <20261126042229.1926905-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126042229.1926905-1-sashal@kernel.org>
References: <2026112506-zipfile-subpanel-c0d3@gregkh>
 <20261126042229.1926905-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsacl.h | 14 --------------
 fs/smb/client/smb2pdu.c | 11 ++++++++++-
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index 31b51a8fc2561..ebc1b7c08c6ad 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -93,18 +93,4 @@ struct owner_group_sids {
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
-#define MIN_SEC_DESC_LEN  (sizeof(struct smb_ntsd) + (2 * MIN_SID_LEN))
-
 #endif /* _CIFSACL_H */
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index e6ce1d8528cb5..0dae54d2c4d56 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3931,6 +3931,14 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -4002,7 +4010,8 @@ SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
 
 	return query_info(xid, tcon, persistent_fid, volatile_fid,
 			  0, SMB2_O_INFO_SECURITY, extra_info,
-			  SMB2_MAX_BUFFER_SIZE, MIN_SEC_DESC_LEN, data, plen);
+			  SMB2_MAX_BUFFER_SIZE, sizeof(struct smb_ntsd),
+			  data, plen);
 }
 
 int
-- 
2.53.0

