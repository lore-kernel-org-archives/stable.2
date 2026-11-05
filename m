Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909763;
	b=ateWJZYE0UlTWM4DK5GKF84Mgiro32QuNfIxtsAtOciw04MYC0M4PnQluQhJU85aonvv
	 ZqimRaz3FpATlyfZoTz1uJxKZan3pDU4k/EFhG4Hul/6kphl3bQRD6iLsqY1Ngw5i0p39
	 9petEvfe0Yksj5nIGASLBjYT0PHWP7j7eEaiwlqhGp7NwKpZtIZ7IYXuC9PXNYfF/4P6Z
	 TlJtHdrTl5RoNvDgZ39Xv4HaRdEWdivdyn4i6AVJAlEJa45/RaLyW2ydfpvwR/PQpK5yg
	 hrMxtTbHxzXBFYipt0JZrWRJoSGVBUZmuR2kprK4mNPhr7BcJZxzfsFOXbX/nurN9vA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909763;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8+GcNtd/Hc4ZgoL1JUBrrUkmhTioKc2whz8y2R0XOIA=;
	b=ShYHeN6EiAk3hUyOeaag9aCkmCblnh/+Nw35LVAEn3tBJMrYpaY5XUOVC1QOjGrXWdl1
	 i0MlLYUfo8FAW60hGb686iCa7mxJ1zYSJt8fqvPShRAJWgF0h7MP01nLoJ7HplG28iLMi
	 ubVBNpz4YImgIj7eKEXuteg46MOIPwx2t87EL//PsBUC9dGo49KO6nW1WD507yXqwvx0O
	 EsdHf85SFgQSr2aKg5qe+UTYMlOhK6VawQpNyE70r5vByhw5NWUPi+8A0B1+TZmhioz1P
	 qzXocmsVpLAFOi0KKP3EMLR6TC5KKCxxHe1l/6r2ko87nA+Q6eNKglKYPZHy+wnS/iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NpGn+8Yj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC0606A331
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 20:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NpGn+8Yj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5561F0089F;
	Thu,  5 Nov 2026 20:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793909762;
	bh=8+GcNtd/Hc4ZgoL1JUBrrUkmhTioKc2whz8y2R0XOIA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NpGn+8Yj7slRPPXkXffxvx2KmbhOi6KPTPWR1+ejMLGhXFtRNGLUy3kmw96uji0UX
	 +xE4J6G/DsKw7AZT3O/eAs0kr+OrdYZ966CfoY/W1Zm3bk+HTtVYHxEJ7UBIZPwjrT
	 HE0/DNsOHdgg+/OMl/gmgRKlmJ6OrkUWZqY2J4R0CiHwQI6wKxIQQYRI0Q1qi5h0J+
	 H8N4hUmwgm132CE1RXLmOhRszDoiOs8eduJjb/UH5yn0uzDuTlfl6enVQq27YfsFQ1
	 UX6i7079YYC7v65YpK1xHV14eHaPVXF0qpJakYQ1bFhhuHZT1YsdMTSmhXJ0xZaPiK
	 QzJnuZ32bzDQQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Diego Oliva <diego@bynar.io>,
	David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: reject FIND data areas that run past the received response
Date: Thu,  5 Nov 2026 15:16:00 -0500
Message-ID: <20261105201446.2682075-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110457-pulsate-oil-dbd1@gregkh>
References: <2026110457-pulsate-oil-dbd1@gregkh>
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
[ sashal: adjusted declaration context because the in_len variable is absent in CIFSFindFirst() and CIFSFindNext() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d2a4016acf7eb..09a3924a5b76b 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3968,8 +3968,9 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -4088,11 +4089,19 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -4125,8 +4134,9 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -4209,13 +4219,22 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
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

