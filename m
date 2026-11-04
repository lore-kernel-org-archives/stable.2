Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822089;
	b=Rc38+gshlExvh/semWrnEqGfWnQ260n2iw7PrYyHo25XkeJKJNM+73Ml40m81PIe1822
	 GP9RcSV6+5uxyKtL7hgcija0FpD1vXzWIATwZl/etHd1t7AueJBCfmz2NT7F5K2zyNoef
	 p3y8dBxtw5/on7//r59rWpK/CpLkHEajcg4s8zZcqUcWdiW+UVDj3/D446DIcjtRIj5Dd
	 HIbSHuZ2grWF6puS2k+Hn3dNc1HlLAWSYAOVxdPTi9O0L0hPdDqvDaZt+xsbUjOtedoUr
	 3kK/75gauwYkYDpHYw9TlVXZtBoRzsIcaQyjtLoHBSry+WNJS6tYlWRpb0k45Lew/0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+8x5u/WQAsr/DmLNTm5CNAZNTQSL37JAEny2UX6Q5+c=;
	b=mJeRHs8cHCfTsQXnlfilcGaKjG4MVsl5OTAr2ErL+19+bpvUZp8MPf79UuAF7HKRhuIy
	 CyG1wMFHxFeGKQHrlxaYkWwf4lvnFba4fsopL10ECQW6dMAdQM5fO2Idov88BJ641d46d
	 OwSK3MQ+ZwqxnY/0GGOk2oamPcZ/MfuGVuzVmXzzel4GlNF4gRDPJH6Hi6J8KjhqMoFMf
	 PtJt3wNswnf14j0ZKM/ElTFXkOaYO4XR7sZYps//vt0ox/q/uws/ythWyPCYpjOpsEODN
	 DJIdfU1OjCJjahxEBqWYGpb1HPERKdtOHbkfTNkkNZ9aWcPthHw6mAEbZr4i4J+1JvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V75xnXYc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294E5606C5BC
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V75xnXYc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D761F00A1D;
	Wed,  4 Nov 2026 19:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793822088;
	bh=+8x5u/WQAsr/DmLNTm5CNAZNTQSL37JAEny2UX6Q5+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V75xnXYcPmKYCft6kCABHARdSNKe8jvexBS9IfN0rPZeaJYEZfBBbHxoR1CnMDHsO
	 6dDy2heEN3JiW3bW/3TeY75OvpLI7FiNunIzIxCC+gj6eXKf/pjBqr454yIIpzuDyB
	 78bT6ZTweTU+HBXLdlSeCFunK/nF2QWIurH2TjGcoeJ7tqsJj7BpXxV7fpalSuthfP
	 JyUZy47tYyeEEbn3yJ3aKvLWBPC9iD5jJT8npELaqlGpfI0rasNc+TrU1d5UokxgId
	 OjcDQD0Gv04kUtD+HtpojXXGeHD+wp6yeJX0h1vVuWtLmnPhd0CLkY5MHF+/uhGV4c
	 0a4f5FsQgHZdQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] smb: client: fix warning in CIFSFindNext()
Date: Wed,  4 Nov 2026 14:54:45 -0500
Message-ID: <20261104195419.360475-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104195419.360475-1-sashal@kernel.org>
References: <2026110404-moonrise-gnarly-7268@gregkh>
 <20261104195419.360475-1-sashal@kernel.org>
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

[ Upstream commit 215533f888dcf18f7cfbbf520bdd52e67ac6265a ]

This fixes the following warning reported by kernel test robot

  fs/smb/client/cifssmb.c:4216 CIFSFindNext() warn: missing error
  code? 'rc'

Link: https://lore.kernel.org/all/202306170124.CtQqzf0I-lkp@intel.com/
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 59131dd72f62 ("smb: client: fix use-after-free infoleak via the readdir resume name")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 111 +++++++++++++++++++++-------------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 7712ba6d0dee7..7f0839d5c6db7 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4592,11 +4592,12 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 	TRANSACTION2_FNEXT_REQ *pSMB = NULL;
 	TRANSACTION2_FNEXT_RSP *pSMBr = NULL;
 	T2_FNEXT_RSP_PARMS *parms;
-	char *response_data;
-	int rc = 0;
-	int bytes_returned;
 	unsigned int name_len;
+	unsigned int lnoff;
 	__u16 params, byte_count;
+	char *response_data;
+	int bytes_returned;
+	int rc = 0;
 
 	cifs_dbg(FYI, "In FindNext\n");
 
@@ -4641,8 +4642,8 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 		pSMB->ResumeFileName[name_len] = 0;
 		pSMB->ResumeFileName[name_len+1] = 0;
 	} else {
-		rc = -EINVAL;
-		goto FNext2_err_exit;
+		cifs_buf_release(pSMB);
+		return -EINVAL;
 	}
 	byte_count = params + 1 /* pad */ ;
 	pSMB->TotalParameterCount = cpu_to_le16(params);
@@ -4653,71 +4654,61 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
 			(struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	cifs_stats_inc(&tcon->stats.cifs_stats.num_fnext);
+
 	if (rc) {
+		cifs_buf_release(pSMB);
 		if (rc == -EBADF) {
 			psrch_inf->endOfSearch = true;
-			cifs_buf_release(pSMB);
 			rc = 0; /* search probably was closed at end of search*/
-		} else
+		} else {
 			cifs_dbg(FYI, "FindNext returned = %d\n", rc);
-	} else {                /* decode response */
-		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
-
-		if (rc == 0) {
-			unsigned int lnoff;
-
-			/* BB fixme add lock for file (srch_info) struct here */
-			if (pSMBr->hdr.Flags2 & SMBFLG2_UNICODE)
-				psrch_inf->unicode = true;
-			else
-				psrch_inf->unicode = false;
-			response_data = (char *) &pSMBr->hdr.Protocol +
-			       le16_to_cpu(pSMBr->t2.ParameterOffset);
-			parms = (T2_FNEXT_RSP_PARMS *)response_data;
-			response_data = (char *)&pSMBr->hdr.Protocol +
-				le16_to_cpu(pSMBr->t2.DataOffset);
-			if (psrch_inf->smallBuf)
-				cifs_small_buf_release(
-					psrch_inf->ntwrk_buf_start);
-			else
-				cifs_buf_release(psrch_inf->ntwrk_buf_start);
-			psrch_inf->srch_entries_start = response_data;
-			psrch_inf->ntwrk_buf_start = (char *)pSMB;
-			psrch_inf->smallBuf = false;
-			if (parms->EndofSearch)
-				psrch_inf->endOfSearch = true;
-			else
-				psrch_inf->endOfSearch = false;
-			psrch_inf->entries_in_buffer =
-						le16_to_cpu(parms->SearchCount);
-			psrch_inf->index_of_last_entry +=
-				psrch_inf->entries_in_buffer;
-			lnoff = le16_to_cpu(parms->LastNameOffset);
-			if (CIFSMaxBufSize < lnoff) {
-				cifs_dbg(VFS, "ignoring corrupt resume name\n");
-				psrch_inf->last_entry = NULL;
-				return rc;
-			} else
-				psrch_inf->last_entry =
-					psrch_inf->srch_entries_start + lnoff;
-
-/*  cifs_dbg(FYI, "fnxt2 entries in buf %d index_of_last %d\n",
-    psrch_inf->entries_in_buffer, psrch_inf->index_of_last_entry); */
-
-			/* BB fixme add unlock here */
 		}
+		return rc;
+	}
 
+	/* decode response */
+	rc = validate_t2((struct smb_t2_rsp *)pSMBr);
+	if (rc) {
+		cifs_buf_release(pSMB);
+		return rc;
 	}
+	/* BB fixme add lock for file (srch_info) struct here */
+	psrch_inf->unicode = !!(pSMBr->hdr.Flags2 & SMBFLG2_UNICODE);
+	response_data = (char *)&pSMBr->hdr.Protocol +
+		le16_to_cpu(pSMBr->t2.ParameterOffset);
+	parms = (T2_FNEXT_RSP_PARMS *)response_data;
+	response_data = (char *)&pSMBr->hdr.Protocol +
+		le16_to_cpu(pSMBr->t2.DataOffset);
 
-	/* BB On error, should we leave previous search buf (and count and
-	last entry fields) intact or free the previous one? */
+	if (psrch_inf->smallBuf)
+		cifs_small_buf_release(psrch_inf->ntwrk_buf_start);
+	else
+		cifs_buf_release(psrch_inf->ntwrk_buf_start);
 
-	/* Note: On -EAGAIN error only caller can retry on handle based calls
-	since file handle passed in no longer valid */
-FNext2_err_exit:
-	if (rc != 0)
-		cifs_buf_release(pSMB);
-	return rc;
+	psrch_inf->srch_entries_start = response_data;
+	psrch_inf->ntwrk_buf_start = (char *)pSMB;
+	psrch_inf->smallBuf = false;
+	psrch_inf->endOfSearch = !!parms->EndofSearch;
+	psrch_inf->entries_in_buffer = le16_to_cpu(parms->SearchCount);
+	psrch_inf->index_of_last_entry += psrch_inf->entries_in_buffer;
+	lnoff = le16_to_cpu(parms->LastNameOffset);
+	if (CIFSMaxBufSize < lnoff) {
+		cifs_dbg(VFS, "ignoring corrupt resume name\n");
+		psrch_inf->last_entry = NULL;
+	} else {
+		psrch_inf->last_entry =
+			psrch_inf->srch_entries_start + lnoff;
+	}
+	/* BB fixme add unlock here */
+
+	/*
+	 * BB: On error, should we leave previous search buf
+	 * (and count and last entry fields) intact or free the previous one?
+	 *
+	 * Note: On -EAGAIN error only caller can retry on handle based calls
+	 * since file handle passed in no longer valid.
+	 */
+	return 0;
 }
 
 int
-- 
2.53.0

