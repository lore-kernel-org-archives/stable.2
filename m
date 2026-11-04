Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821526;
	b=GpBjIOEkfUOLb+vw0pBtGcWcQ6im6KBUTRjUsNouLFssQeCc6CCZ/IbYZbmda1ePsSov
	 PjERdYNwCQB0lkPvlGB1Lb1gSNtGVJOdyWIgjM/dz7gOgWc033PpewegOAG4ar4ZNKQZF
	 lRsynJFggZgixEjsZ6/5miiWbH16pbLS8FOP3U1zBcY/5JwpBhtdSNv/bSWHNOQ+ls5sD
	 Tv4+CpFHiseZ6202Kea9Ckkx+AQdIuVXrdLZm8w+n0YFl2EsZ+ep05RNrMKM0ejNEsMaZ
	 OnKN2TARcB8NGzqcToejw+lip6PA1MOlRLcwDsM8AKvOR0xy9k9gXCODF3V4Ofhp/4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821526;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hbY8QaL2VTwJ2/7AK9ozPSetg80AMdMDemC7/4XZ12k=;
	b=4/zdh9i+T+0FDLhBGD+w0xE8AoetOPHqfnay74ZBaL6mXFrWYP76kW5KkF9vfl583/qb
	 9g6UhUlTWFHxX3AAzG+lDYHRYTucruSJv2Djxitzch9i1kGThEVprbF1G3CeRvAbg6tkg
	 qX92V7bjw2L1sLpiU5ONQ/RfVPmL8OYwuAzIcHsR+bfeKexlhFLqzqakTxTLL89DSdatW
	 c3ycf6SYsyocg1YoeS2hW114n1OYeyVtwfAw1F6O3jbbMVSEuG3OeBYT4VJqJrz/QPJIL
	 yMkAFtgPJJQXVlme1Gr3b95ExEecv35pc/F/YOn7t0EwUgZq8PLau58n6DXIvaqL9rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO8NTamE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF010608B6ED
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZO8NTamE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40131F0093A;
	Wed,  4 Nov 2026 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821525;
	bh=hbY8QaL2VTwJ2/7AK9ozPSetg80AMdMDemC7/4XZ12k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZO8NTamE9v7GAiU8w4ITxgessFRReun5UYrTN0PDt6n0mQussS9YvXK0lBE9elJ68
	 hJC2qY1083ap/HWevbsEZDlVxV4iBZsRXNNsUmqS0C9tSYWRIRiwc26m36XqG5j2oV
	 kK6b4+b7bJjoCXbEWDK94p20r9xBmaplRP+ksJcgHQ/YIDOGi22Mr8X+hYUi2Jsq8G
	 pOTg1bdDJ3M2yIv3qiOg0bpKXfto+RKqpB24c9IFnQMf2KSc89dxV9tCsPrzR9Az8Q
	 zwGpmW/vZD+3/U74c8si2Tlm2vpVQNULSLgc5jCvZEHJJuwkoOR/ToUlhH73L9sFR3
	 dG8XCAVjk893w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] smb: client: fix warning in CIFSFindNext()
Date: Wed,  4 Nov 2026 14:45:21 -0500
Message-ID: <20261104194436.333741-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104194436.333741-1-sashal@kernel.org>
References: <2026110403-submersed-uncloak-dc0a@gregkh>
 <20261104194436.333741-1-sashal@kernel.org>
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
index 36ed6906066ea..5b1fb3216f238 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4484,11 +4484,12 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
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
 
@@ -4533,8 +4534,8 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -4545,71 +4546,61 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
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

