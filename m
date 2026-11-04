Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821005;
	b=1w7wO8maRlR2rWuEJkS0ox5zUFJ4e+RgXZ5mIrFoygqZvU6LB8dmdbfwBym+1zrtRgQ+
	 C772g37ta10tGjfcdYYZtoQbKnjiFq9yS2JQHn/iH6uxkLxqVaTVOhXGeT1MsodA9rDHj
	 quDkdxKNRTBdeWRDO/Qs3+tIUkmBcGSeh/XFOY5IInoy0ak4gzAdUKGkrtXzYV9aKhyRO
	 AooUnVnQCB6jf5nBt3Pb3xd3taLjvUqZjnkJ9/792qGx6izUiYZt2iS3LNi3+7x2Qw4A0
	 6tlqePxks+3UDKC+5MTXK3fmyynyIUpWnzH48bTIk0q7we/mhHmjxYSM6fHEhHNop7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821005;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=REk4apHRzdkfU82jN6zMuepW8FzWA+oIN227Glqb35E=;
	b=EbQd3MS3ZvQ4YHhGn/LXDo/smlpmllFIm8S5Tc87WbQumPSX4CBxK+dEF46JgAUdKUt6
	 dZ2S6wxnw3Q9bvwmGgTj7AYrQke9A6YgNwicNVZ4IL9vVTW5XP+uIPb+2KO2LpLeqLD0r
	 B5or+vB3IDoJAZjIpLkNFWFWGDyUkRtDdrvLnUTMSnXR1O5Qj64ZTLvB+vp33c3LCLz58
	 9yjspjcgRwAY2CHfiV9ss3Lbri6+VVEhT/JLrzlJ1ZBmJxxabVVQM2pVhFG4B2p2QqGX8
	 KnffOAwLeV1RJiPdoyBPpJF+dw4wvmr6P8GpLuZ7SBVBtpE6DnlWSqim0BVGfhf4SLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNQPIHcF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F286070262
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gNQPIHcF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA7D1F00A02;
	Wed,  4 Nov 2026 19:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821005;
	bh=REk4apHRzdkfU82jN6zMuepW8FzWA+oIN227Glqb35E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gNQPIHcF02JXfhmDNxnOE+GP8ZejtgfBrmipdXDBYmCwQLPivGKdsHjE2Pc9dVaTP
	 asbyFN4qbf9oZForArEy8suU3I76EMrKSCd4IzUmekIMsJyWw2JD8Z7IF2PcuX9Dv3
	 xwwkJhrg+a8c7MbHaaGKDjxB/doxEig3MLtzsfx+JzY0UqkCSKV1badVuMETlA9SN7
	 vlhmC6gCdBG3jbo7pTyErvE0/UCgCqm6vYLIbJrqisonuVCrX/9PBeWClZz2CDkkEX
	 OjG7T82T/AaTr3/HxDj4ECtQUQL3G4OcEAmDCF1WJ3pfrM3HAp5GEaKN2hiwRHkgyo
	 IKo4Wyh/iz44w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] smb: client: fix warning in CIFSFindNext()
Date: Wed,  4 Nov 2026 14:36:41 -0500
Message-ID: <20261104155725.3917936-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104155725.3917936-1-sashal@kernel.org>
References: <2026110402-earlobe-scanner-01d6@gregkh>
 <20261104155725.3917936-1-sashal@kernel.org>
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
 fs/smb/client/cifssmb.c | 111 ++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 60 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 735d01f5e992c..0c06b79f540b2 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -4055,11 +4055,12 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
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
 
@@ -4104,8 +4105,8 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
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
@@ -4116,71 +4117,61 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
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

