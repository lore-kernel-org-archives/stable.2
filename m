Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822088;
	b=ZDY6nDjpdL8zIFiFgppD1ilXRYae30fjz5zRF1WwKKdQXTv/i9j50eGjeeNctSauC+iq
	 PhKzMSks+Nr8Nnq0elTF6mTozc7flHjchFT32CKo2A1OqGHfv0rH/ip59QRcEF7Z+KNXK
	 2/pIBtppnm/e7/0MYtlr0ZV9sbqxT9fFlWJLEDZioq0DSmYIZCy5Cw7jse1my6B6DihYU
	 VEomjMK0sjGQiEDx/dMZNqn3DIUBelgdd8hYNX/DT5ZFEue5Zcs7ZMXyOphmoHKAJfp8n
	 0np4JHlWS9uONS3F8gSfBv/Tg0jrLX3vRifHAUfzj71YSAGA9P4h+LNMNm3E1aDE1Xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822088;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nBvz/CVQ1P3lZu8fJDNEgouNct7IeHHDWriP45qhkxA=;
	b=kICXyWDlw97wqbUSa9au+9fUhGXRE74f6pqyrZ2Sb8oir5HWCMtl2Cwzgjvfudjeo9fD
	 2A/A5INffc6xvOz63zbPLeH/Ivci37ng4I3LaU9Q0LXJvr8Z9ywc/rMnzuHXlBmUXowGd
	 UprQXvMpBzjbFcNeRETabhoWoOICxLneN+zm5WmmHJKVDiWKKlfBcIOwVjC9xmzRN04OB
	 fzbsy9DH/plmAwUFNTCiPE2J6bS79DfACoNaD76MEuFZfj7/1BeRiXM/cIApxjJQbl5ot
	 /ePoYkB+sqO0rwVwiHlCsK74o6ZhJThL9j36f6lxyEhi/dYwr59qWCiBHNiVlAFeJ5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKoCpQQE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978CD606BA25
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKoCpQQE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A82791F00A1A;
	Wed,  4 Nov 2026 19:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822088;
	bh=nBvz/CVQ1P3lZu8fJDNEgouNct7IeHHDWriP45qhkxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKoCpQQE3CGgjxC2unLzhcyJhgvQMIKeV5X4O3ZyI1loYLQoJ9QacvE90xI/bWbg6
	 8JrVHnZMUlUAvvVrOcHszDKdz+BB2S9XI0rq/5OYZ8MkZ5R79lWkT5s0sasO0E8Gu+
	 jsxHDAgizLvZQ3l3rF802ViDXBgnxqldaqrrcg66GCkYoxm1m1ki4fYgAjowuudE+n
	 Knd4JV1PmyKFLYOn/CTthNF2nu9s3WbZ3N5Yym5MAkxWpu4ecm13/UdWloTnKWGK6z
	 LhfkNlyE4TiePI9eLgabz/S4J95VcHcUWliNVp778QMmjwmFHKXwxrihiTLd3+3Wnc
	 kNr3YUmVNYcEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] smb: client: fix warning in CIFSFindFirst()
Date: Wed,  4 Nov 2026 14:54:44 -0500
Message-ID: <20261104195419.360475-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110404-moonrise-gnarly-7268@gregkh>
References: <2026110404-moonrise-gnarly-7268@gregkh>
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

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 032137fe136a6073dcc699ee15fa3fd05fd77f21 ]

This fixes the following warning reported by kernel test robot

  fs/smb/client/cifssmb.c:4089 CIFSFindFirst() warn: missing error
  code? 'rc'

Link: https://lore.kernel.org/all/202306170124.CtQqzf0I-lkp@intel.com/
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 59131dd72f62 ("smb: client: fix use-after-free infoleak via the readdir resume name")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 94 +++++++++++++++++++++--------------------------
 1 file changed, 42 insertions(+), 52 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 67ff1669cab2a..7712ba6d0dee7 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4441,11 +4441,12 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_FFIRST_REQ *pSMB = NULL;
 	TRANSACTION2_FFIRST_RSP *pSMBr = NULL;
 	T2_FFIRST_RSP_PARMS *parms;
-	int rc = 0;
+	struct nls_table *nls_codepage;
+	unsigned int lnoff;
+	__u16 params, byte_count;
 	int bytes_returned = 0;
 	int name_len, remap;
-	__u16 params, byte_count;
-	struct nls_table *nls_codepage;
+	int rc = 0;
 
 	cifs_dbg(FYI, "In FindFirst for %s\n", searchName);
 
@@ -4536,63 +4537,52 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_ffirst);
 
-	if (rc) {/* BB add logic to retry regular search if Unix search
-			rejected unexpectedly by server */
-		/* BB Add code to handle unsupported level rc */
+	if (rc) {
+		/*
+		 * BB: add logic to retry regular search if Unix search rejected
+		 * unexpectedly by server.
+		 */
+		/* BB: add code to handle unsupported level rc */
 		cifs_dbg(FYI, "Error in FindFirst = %d\n", rc);
-
 		cifs_buf_release(pSMB);
-
-		/* BB eventually could optimize out free and realloc of buf */
-		/*    for this case */
+		/*
+		 * BB: eventually could optimize out free and realloc of buf for
+		 * this case.
+		 */
 		if (rc == -EAGAIN)
 			goto findFirstRetry;
-	} else { /* decode response */
-		/* BB remember to free buffer if error BB */
-		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
-		if (rc == 0) {
-			unsigned int lnoff;
-
-			if (pSMBr->hdr.Flags2 & SMBFLG2_UNICODE)
-				psrch_inf->unicode = true;
-			else
-				psrch_inf->unicode = false;
-
-			psrch_inf->ntwrk_buf_start = (char *)pSMBr;
-			psrch_inf->smallBuf = false;
-			psrch_inf->srch_entries_start =
-				(char *) &pSMBr->hdr.Protocol +
-					le16_to_cpu(pSMBr->t2.DataOffset);
-			parms = (T2_FFIRST_RSP_PARMS *)((char *) &pSMBr->hdr.Protocol +
-			       le16_to_cpu(pSMBr->t2.ParameterOffset));
-
-			if (parms->EndofSearch)
-				psrch_inf->endOfSearch = true;
-			else
-				psrch_inf->endOfSearch = false;
+		return rc;
+	}
+	/* decode response */
+	rc = validate_t2((struct smb_t2_rsp *)pSMBr);
+	if (rc) {
+		cifs_buf_release(pSMB);
+		return rc;
+	}
 
-			psrch_inf->entries_in_buffer =
-					le16_to_cpu(parms->SearchCount);
-			psrch_inf->index_of_last_entry = 2 /* skip . and .. */ +
-				psrch_inf->entries_in_buffer;
-			lnoff = le16_to_cpu(parms->LastNameOffset);
-			if (CIFSMaxBufSize < lnoff) {
-				cifs_dbg(VFS, "ignoring corrupt resume name\n");
-				psrch_inf->last_entry = NULL;
-				return rc;
-			}
+	psrch_inf->unicode = !!(pSMBr->hdr.Flags2 & SMBFLG2_UNICODE);
+	psrch_inf->ntwrk_buf_start = (char *)pSMBr;
+	psrch_inf->smallBuf = false;
+	psrch_inf->srch_entries_start = (char *)&pSMBr->hdr.Protocol +
+		le16_to_cpu(pSMBr->t2.DataOffset);
 
-			psrch_inf->last_entry = psrch_inf->srch_entries_start +
-							lnoff;
+	parms = (T2_FFIRST_RSP_PARMS *)((char *)&pSMBr->hdr.Protocol +
+					le16_to_cpu(pSMBr->t2.ParameterOffset));
+	psrch_inf->endOfSearch = !!parms->EndofSearch;
 
-			if (pnetfid)
-				*pnetfid = parms->SearchHandle;
-		} else {
-			cifs_buf_release(pSMB);
-		}
+	psrch_inf->entries_in_buffer = le16_to_cpu(parms->SearchCount);
+	psrch_inf->index_of_last_entry = 2 /* skip . and .. */ +
+		psrch_inf->entries_in_buffer;
+	lnoff = le16_to_cpu(parms->LastNameOffset);
+	if (CIFSMaxBufSize < lnoff) {
+		cifs_dbg(VFS, "ignoring corrupt resume name\n");
+		psrch_inf->last_entry = NULL;
+	} else {
+		psrch_inf->last_entry = psrch_inf->srch_entries_start + lnoff;
+		if (pnetfid)
+			*pnetfid = parms->SearchHandle;
 	}
-
-	return rc;
+	return 0;
 }
 
 int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
-- 
2.53.0

