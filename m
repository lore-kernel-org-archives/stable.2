Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904248;
	b=ucA04SXk7jiSlAZgK4p3Z8wPlB37Lvw6hvpsDK91zu9v2gOgtQMyucVn7g4uMZwACoOi
	 MlLXSvxvvOm7B7IpGLhfKVBjEYzm6mzgDfKR41CeKiaYvuWk2ayF8ESyVgWH2S5xKJt5E
	 moDudz+mSm+m/F8Bm4njA5zoweEo6q+f2nxC+yuGEZiKPahG4aSJ8/gdvjduy4M2+dVRh
	 +vT8ISEFBKaFVhac39nPNgFTfDrIS7oUfOXzn1gfVceWpmV4prKbHu4X1MT8YmdwdbkWK
	 ux5bQiGNwE2nBwltTzAR+wjuJWf11e9DTf4Jh8Uu+gTQ51wnbIfRQiwkJGhuSEF6hag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904248;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ior9xZGWVcajWcyZgUGuA+AS6urZffsr7mS2bQv/DtQ=;
	b=44MDx4iuQDY6pOAES/wE6xWhEfXLuq5PH6UtTrEJCV6RXpdBj3H3Lpqdn35+ye4Ct/0x
	 j/u6uP0dPAhDqoKEFsDdT/I1ErCMM8U94DARAiHAofy2ETmwoAw4o8jLg119bWosEUZKA
	 hsL36YUga1L9tmdxwVR/8W9luo/59fzz34i9l+fEOXtKbJTpwv/RWHJNcG8mVjByrNE7d
	 Ozi2cH8N+jxCtz8NG/wxM/A43mw2H1QTKAfv3z7ZrBPKeaVqxek5aVb72qF7KS7SXYU/g
	 m+5DYSJ9klQipNHiSkW903g+AIHF0PHfROtb7BQmM/yoUecSXS5n5zl5sATA7pVvm1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkiQZq+B;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2219606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QkiQZq+B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D721F000C1;
	Thu,  5 Nov 2026 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904247;
	bh=Ior9xZGWVcajWcyZgUGuA+AS6urZffsr7mS2bQv/DtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QkiQZq+BXnDcM84jdtzpRB2Tt/JWCbKIolPtSwhGrieLOfkhkna6CQ5A8V9jgjkC8
	 9m3ujmKSnHM2Es8cSAQXqrpsg1eJKcI0TD1d2nEBS62f21Glz/9dfA4h1m4yRloLho
	 FTiT0AXf5hVgMtAlbl3lDI7Uvr//Jm3RvT+n4ZZOQYIPGmJlwQcRRL0B8NWe9vjASm
	 IJryag++xUz7PR+YsOwAqbnDNsHtX6vIB1FfdSbup/S6prk55sUgNF9dIub3tXjf3a
	 /c97RTEKTa4tLoaffxONFBTGVZ7ytJ7RLr34ZWf2PxFiWKzMcqFZwyd8o/2Grq9skp
	 2fvdGoAfGI+Uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Diego Oliva <diego@bynar.io>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: reject FIND data areas that run past the received response
Date: Thu,  5 Nov 2026 13:44:06 -0500
Message-ID: <20261105184240.2288252-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110455-defendant-swung-d565@gregkh>
References: <2026110455-defendant-swung-d565@gregkh>
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

From: Diego Oliva <diego@bynar.io>

[ Upstream commit 29bd6773187cb5c1bbbdf90d677c6add7d58af26 ]

CIFSFindFirst() and CIFSFindNext() take the directory entries of a
TRANS2_FIND_FIRST2 or TRANS2_FIND_NEXT2 response from DataOffset for
DataCount bytes. validate_t2() bounds DataOffset at 1024 and
ParameterCount + DataCount by the byte count, and nothing compares
DataOffset + DataCount with the number of bytes SendReceive() copied
into the buffer.

smb_init() places the request and the response in the same
cifs_request allocation and cifs_buf_get() clears only the start of
it, so a short response whose data area extends past its end has
srch_entries_start point at bytes of the request that was just sent,
or at whatever the allocation held before, and those bytes are parsed
as directory entries. cifs_readdir() and find_cifs_entry() walk the
entries with nxt_dir_entry(), which checks every entry but the first
of a response against the end of the SMB; cifs_query_path_info() and
cifs_backup_query_path_info() read the first entry with no check at
all. Those reads stay inside the allocation, but what they return is
not part of the response. The last entry, which LastNameOffset locates
relative to the data area, is bounded against the received response
by an earlier patch of this series, as is every entry that
cifs_fill_dirent() parses; the walk itself and the two query functions
are not.

SMB1 is not negotiated by default; reaching this code requires an
explicit vers=1.0 mount.

Reject a response whose data area extends past the received length,
with the -EINVAL that validate_t2() returns for the other malformed
transaction responses. cifs_query_path_info() and
cifs_backup_query_path_info() still read a whole entry from a data
area that may be smaller than one; that is not changed here.

A conforming server is not affected. The data block of a transaction
response is part of the SMB, so DataOffset + DataCount cannot exceed
the smbCalcSize() bytes that SendReceive() copies; coalesce_t2()
appends each secondary response to the data area and adds its length
to both DataCount and the byte count, which keeps that relation.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Bynario AI
Signed-off-by: Diego Oliva <diego@bynar.io>
Reviewed-by: David Howells <dhowells@redhat.com>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Adjusted declaration context in CIFSFindFirst() and CIFSFindNext() to account for the missing in_len variable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6e4b845a4078c..ca3ee6837daa0 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -4317,8 +4317,9 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 /* level 257 SMB_ */
 	TRANSACTION2_FFIRST_REQ *pSMB = NULL;
 	TRANSACTION2_FFIRST_RSP *pSMBr = NULL;
-	T2_FFIRST_RSP_PARMS *parms;
+	unsigned int data_off, data_count;
 	struct nls_table *nls_codepage;
+	T2_FFIRST_RSP_PARMS *parms;
 	unsigned int lnoff;
 	__u16 params, byte_count;
 	int bytes_returned = 0;
@@ -4437,11 +4438,19 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 	}
 
+	data_off = le16_to_cpu(pSMBr->t2.DataOffset);
+	data_count = le16_to_cpu(pSMBr->t2.DataCount);
+	if (data_off + data_count > (unsigned int)bytes_returned) {
+		cifs_dbg(VFS, "%s: data area offset %u count %u past response length %d\n",
+			 __func__, data_off, data_count, bytes_returned);
+		cifs_buf_release(pSMB);
+		return -EINVAL;
+	}
+
 	psrch_inf->unicode = !!(pSMBr->hdr.Flags2 & SMBFLG2_UNICODE);
 	psrch_inf->ntwrk_buf_start = (char *)pSMBr;
 	psrch_inf->smallBuf = false;
-	psrch_inf->srch_entries_start = (char *)&pSMBr->hdr.Protocol +
-		le16_to_cpu(pSMBr->t2.DataOffset);
+	psrch_inf->srch_entries_start = (char *)&pSMBr->hdr.Protocol + data_off;
 
 	parms = (T2_FFIRST_RSP_PARMS *)((char *)&pSMBr->hdr.Protocol +
 					le16_to_cpu(pSMBr->t2.ParameterOffset));
@@ -4474,8 +4483,9 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	TRANSACTION2_FNEXT_REQ *pSMB = NULL;
 	TRANSACTION2_FNEXT_RSP *pSMBr = NULL;
-	T2_FNEXT_RSP_PARMS *parms;
+	unsigned int data_off, data_count;
 	unsigned int name_len;
+	T2_FNEXT_RSP_PARMS *parms;
 	unsigned int lnoff;
 	__u16 params, byte_count;
 	char *response_data;
@@ -4558,13 +4568,22 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_buf_release(pSMB);
 		return rc;
 	}
+
+	data_off = le16_to_cpu(pSMBr->t2.DataOffset);
+	data_count = le16_to_cpu(pSMBr->t2.DataCount);
+	if (data_off + data_count > (unsigned int)bytes_returned) {
+		cifs_dbg(VFS, "%s: data area offset %u count %u past response length %d\n",
+			 __func__, data_off, data_count, bytes_returned);
+		cifs_buf_release(pSMB);
+		return -EINVAL;
+	}
+
 	/* BB fixme add lock for file (srch_info) struct here */
 	psrch_inf->unicode = !!(pSMBr->hdr.Flags2 & SMBFLG2_UNICODE);
 	response_data = (char *)&pSMBr->hdr.Protocol +
 		le16_to_cpu(pSMBr->t2.ParameterOffset);
 	parms = (T2_FNEXT_RSP_PARMS *)response_data;
-	response_data = (char *)&pSMBr->hdr.Protocol +
-		le16_to_cpu(pSMBr->t2.DataOffset);
+	response_data = (char *)&pSMBr->hdr.Protocol + data_off;
 
 	if (psrch_inf->smallBuf)
 		cifs_small_buf_release(psrch_inf->ntwrk_buf_start);
-- 
2.53.0

