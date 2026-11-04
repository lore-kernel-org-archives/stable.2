Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821004;
	b=N4fX2lnhCLISp1C/kEdVjcTRRWMls/9GIn29jnf3xjE7YtlxY4wLKT/tZfG5DuUQLxKD
	 vx/1tQ8mma0ZRg0p2LyavODczQTIfk5134ZN7kGzSouyraKpfCSPS79hD5dI27QqQwULc
	 uXh+V7B06SSvmz6IfhlHgu7RCobMH5pR3xTk9dEQXlzovldp9S8Dbhql+6KLBhczzvgIg
	 TAvJLctoKliJQvsLI10Y7e83Kv4zL7XAExALm480yTrPQ4AGiDWw/hBYvZnCsg2Ugf9yY
	 B0OOHZi4/0YQ2Y/NcGe3ZZcAJFKCD3aqVeUAaFRqi96XU00/q2xaMMAQjqNBGOQP42g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821004;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DDgqq9Q/Bm6V4j3poo6cKSuwiGo9D8SzrfLgV7szOVc=;
	b=bnbUIZ4g94y1e+nYN6jWBtbswG/pf2oUwYpM+jl/fgB9E3ppOymga3gEujBwaDU6R9tJ
	 br6zt0I3aVjJFg/SL0EGRPKieyFmVpsy2dy6urZy/sntXwRa3oQw4bk4pFmjC2a7B45DA
	 pBNWwmmlZUiLzZ3WQji9uTW7sBR+8DnuJ+vMM809dSQek9m+sCJyIREbUOBnEyU2OBSxA
	 Vkp9krZYnI2vKgZgEovXWY7xL2p9w8gOwm9SdwJpjBC8L7FGvtxazSJRyYMrSvcuObD62
	 Rnjf6SMazmv9t5EHWSZJGjivxEo2T3WqYWakVoCXXQY7GyON85rz6sbT256TxIkT7YQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoSWyb+q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814666070259
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XoSWyb+q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8A81F00A15;
	Wed,  4 Nov 2026 19:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821004;
	bh=DDgqq9Q/Bm6V4j3poo6cKSuwiGo9D8SzrfLgV7szOVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XoSWyb+qJrADrwGRreFWyvmxNHq0pOAN305q/mwm9akxAcFRIECpY0QVWuNkMqmcS
	 Nj0ud05DqjxJzmkddjcBXJ7YNNUUfZ+KBUmcIvL7VEUM8tG0AMyQCBUTXGE7FCvH4Y
	 tLbRcdlAvTVe5VEOTYit/xx6JfOd+oGFFieEEON+Mv+KYvxRXjOF+KSp9f34szFyQI
	 /rnVpazSP4Z3Q0pMuSuAZM61hPoFXFyWcXw9odw9czMRoBgDtt4Su1GHzVegNh1Ag9
	 3UEpDnwj0T86pW4legy8SG5L/aI+HoCuCxMYHqnPO8yTrTSJc8nN92cXGqGakDJbQT
	 VI+hmELSOJKUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] smb: client: fix warning in CIFSFindFirst()
Date: Wed,  4 Nov 2026 14:36:40 -0500
Message-ID: <20261104155725.3917936-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110402-earlobe-scanner-01d6@gregkh>
References: <2026110402-earlobe-scanner-01d6@gregkh>
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
 fs/smb/client/cifssmb.c | 98 ++++++++++++++++++-----------------------
 1 file changed, 44 insertions(+), 54 deletions(-)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 65418d15c3a02..735d01f5e992c 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3904,11 +3904,12 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
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
 
@@ -3999,63 +4000,52 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
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
-
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
-
-			psrch_inf->last_entry = psrch_inf->srch_entries_start +
-							lnoff;
-
-			if (pnetfid)
-				*pnetfid = parms->SearchHandle;
-		} else {
-			cifs_buf_release(pSMB);
-		}
+		return rc;
+	}
+	/* decode response */
+	rc = validate_t2((struct smb_t2_rsp *)pSMBr);
+	if (rc) {
+		cifs_buf_release(pSMB);
+		return rc;
 	}
 
-	return rc;
+	psrch_inf->unicode = !!(pSMBr->hdr.Flags2 & SMBFLG2_UNICODE);
+	psrch_inf->ntwrk_buf_start = (char *)pSMBr;
+	psrch_inf->smallBuf = false;
+	psrch_inf->srch_entries_start = (char *)&pSMBr->hdr.Protocol +
+		le16_to_cpu(pSMBr->t2.DataOffset);
+
+	parms = (T2_FFIRST_RSP_PARMS *)((char *)&pSMBr->hdr.Protocol +
+					le16_to_cpu(pSMBr->t2.ParameterOffset));
+	psrch_inf->endOfSearch = !!parms->EndofSearch;
+
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
+	}
+	return 0;
 }
 
 int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
-- 
2.53.0

