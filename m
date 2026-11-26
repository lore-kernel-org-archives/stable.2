Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795667417;
	b=v695eap1ekcwahYkXUYBIH+/a92EVETyx+LS0nPuYfOU3hFa/38+nG9eT0F+0lj1zDyJ
	 o4pmNrYb0X0aI0gF9ZQ3GjJk7rzbnlkzm/pEsTbRX75ImwkosM2qFXWMIbIvVRRskEdIc
	 IZWx3R1r9aufxRLaj8O3WFriAphefojYW9UYPxURJzEkJlXQWoSts7B6ilaRxpRI5cunP
	 BXYHTu1JZwSWsq5lJ2eZKwUnzLx5Lr8FHir3j+lwNxpUbR0jOBalq6lVYfGgCxbvwJ0R/
	 V/fvWWykyxlXg5lYiyOkmj2pmbXxhTzRyvIAYX1ShZzPj8uFszpoeH94vmWNrAhKvHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795667417;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mUVgaqMBQQn7sf5WQTn9YyJy4wtcBbObLeZH7AK9ylA=;
	b=cuLuwAVpm18SIx9rC8pRHb7gEJYGUaGhmBYbdxYOOY61tc1NnBrf80SXsA7gduyxczKE
	 sLawydBy4O7kJrqIzIFLMfI8wrIzW7s1nSA0lBR2vnevyIVS7Uw58Gg3pk0mA9hKJtTAQ
	 spgkDBBnXMUwmyYatuY4XWeeoH/sAHvaD0X8gzJ8BVHsVpc/zTsPZSslE8TsqpjLPd6hZ
	 eh8GDdVgEYJ/B7jPPgMKEqXi8tbzf8d3G+WgODyBI0wSaDf88ixCqglmaHzr0sZOeCmwc
	 zTkJwi/WB71+anbYqfXPJbxVGFUM+vODn4YpeBfxwyT7C2MrhmRjkELPU66F1xclTKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XkV/z2P3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB9606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XkV/z2P3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F61F000C4;
	Thu, 26 Nov 2026 04:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795667417;
	bh=mUVgaqMBQQn7sf5WQTn9YyJy4wtcBbObLeZH7AK9ylA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XkV/z2P3JLIPyCYev8KeQI8eLP786Lm2DARBq0lnxCYHgosF+k/ilLvIli0vdFbt7
	 Kzub4eashl45ltbEt28GcXtPVyhlnaJeve9SmfdLC4hR91RRerZ00vmNl7FPgNTODq
	 K3mptSXJeql1Si+ynf0a8HUMIaClwxebW7lk+bjGUmZWchGH17bKNCG45nXl3Aw7m7
	 V9Gp/Y99ILrZmcnz1Kz3PBXq2gRVo3/yB7fVosxuIKRGlMYtYEfly0GL1No2fQfzSA
	 WTm0jXJX3lRmh4n5cpp38yDe1dlTDJpG9suIaQWl5pvVKhYTXYNF3TTV73YDPi1cuH
	 pSbp2dhv7absQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: liuyong <pkfxxxing@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] smb: client: validate descriptor headers before query result allocation
Date: Wed, 25 Nov 2026 23:30:14 -0500
Message-ID: <20261126042943.1964790-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126042943.1964790-1-sashal@kernel.org>
References: <2026112507-depraved-reappear-7196@gregkh>
 <20261126042943.1964790-1-sashal@kernel.org>
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
index 6844bdfcc9b1b..bd61c10ec0f28 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3927,6 +3927,14 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -3998,7 +4006,8 @@ SMB2_query_acl(const unsigned int xid, struct cifs_tcon *tcon,
 
 	return query_info(xid, tcon, persistent_fid, volatile_fid,
 			  0, SMB2_O_INFO_SECURITY, extra_info,
-			  SMB2_MAX_BUFFER_SIZE, MIN_SEC_DESC_LEN, data, plen);
+			  SMB2_MAX_BUFFER_SIZE, sizeof(struct smb_ntsd),
+			  data, plen);
 }
 
 int
-- 
2.53.0

