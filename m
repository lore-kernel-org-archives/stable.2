Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793821530;
	b=W82NTrh/C3ztrp0BqjUMzThx9/h9ezC2r4WtQwme2dzkhK5npeQymYNaALkP5EvIdYYn
	 eQFzU6uuSNgdKbn3/5QkE1/nEdFQj+BDp68LFDrLuTDm9wWED7xXEwiVB7/XsAC5PKREa
	 /S5LE5FYdIUjRlri9KPXdgD6JiK4Abzcob3qvSJ1VF6Gl9NOgVg02+xaCHG8KHgc5mlGo
	 x63yqCWT3viof7HUJ9m4O5Ntn+0NvhrbKXwaSfUWqZ0IQJWJyBJhfIy3/ykN1SPS9dOcW
	 RCCPHflw4B9z4q6pwySpk4eg2h+MMUqSguyUpqNv+pbRChM2NZuhDygTdjo0TCtepHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821530;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wQi8jNUNgeFQ9EDDO5yCAHHesEk2yr7Mp6yq48w2rek=;
	b=OeqFXk5HxuS03Qhl1goHHfSzXwpRjqCZ+AnRDnD2e69QjUrNr/nlWNc2uBcfTucwDoQw
	 5sDI099QHYHxW73MFHHXmoLMhVYN0Y0useTReXqIteotLYe4AWmp+hV+9RNxBQN++va+g
	 9fYDSU1XYpj0o5ojekrCU1pziDGuBlMcrkSAy2O/KPs1k7R5H1kpVHepAVpgR+/w2YTeM
	 iu5pKVKj+Xmo0HKMN9mSN8g2M/6YrDsAWkTh1ZymHFzsbD2UBm2GtJkpFVa52IQ8mmPJx
	 2Cp4KRV04hvyyQtyu9MaDX6sWUEIO1oLi4YCNFpSeuspAmUDmT8WtqLhoQS0QS6F64g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GORudvOx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51486070A91
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 19:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GORudvOx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A95D1F000C1;
	Wed,  4 Nov 2026 19:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793821524;
	bh=wQi8jNUNgeFQ9EDDO5yCAHHesEk2yr7Mp6yq48w2rek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GORudvOxOOhbDXzSxhoKepj9yBKVM9jzbpt1c9PGbNOcd+oPwCOJ4A2Vf12DmP3uT
	 5g9IcPkEd7OV4cYw7y2wmeyuW1OvjkpZn/WE28QF2nhqbYinaG+azmsE7tjCPZcd2x
	 4tENYo9Vgk6rRdFGdOD2IIRtJNmcHG1YEo13oWvSwtQRxrLJqW+5foY519QGlZdiJe
	 9BasqugV+L7jpmVUEcFaoEXG8PX6sCL3wFOdDvTwzNW9WpHG9NPoL/lKAZcJ+5pHXr
	 GnoOy+vfhOJ30M0r7zxYumjndVqRZgukTZ1F0IXwuIGQUctIqJW0A3Rua90eRFcqf+
	 ag5400t5qNunQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] smb: client: fix warning in CIFSFindFirst()
Date: Wed,  4 Nov 2026 14:45:20 -0500
Message-ID: <20261104194436.333741-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110403-submersed-uncloak-dc0a@gregkh>
References: <2026110403-submersed-uncloak-dc0a@gregkh>
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
index 11a400663b9f2..36ed6906066ea 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4333,11 +4333,12 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
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
 
@@ -4428,63 +4429,52 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
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

