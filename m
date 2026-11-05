Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902424;
	b=IWatDlCKI1OXxHBDJuehZm13KONp9W8kbvhH3XPt/4pXWNHCaTZlw7Tt4H8h49BlLl1/
	 LHyUua1OskxOh5HiutDPQgW91OZoVaghKp2CjEVK+Wq80WvWGTPLfaZLC5Z/VE0Au3I5j
	 6WwywIrT/w9SyuwQ90qfyJWe+tYSrZbTOgtg4TQV728IFmFIbsKSKqRr8QQ69jUM2VhDF
	 gxNevz7cO3JjIXyd4gKFFn73eau99LL7zZtTLmWHWQUaI3zxWqWNXHVCJhqakc3TfBwaW
	 DNRk2VXRFD/Mqv5n+jztgSHLCHNjxBiASfg1vHcalZSDogGJxNqZ2yCt+PN0kmVgm5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mR3i1W+FJLcBbkWI0MtcxdTW89H+epEruWCmxmEKjd8=;
	b=CXpLqSsmm9tV7ojw2HNFaO6TU8ovE45hoOpRivuEasxGzLoI1U/h4w9RbPAsEsUlpdQ9
	 VD2UQPuCNyd1dXb6zS8855JRpq+8rUnsrc4bGcwHmgK4KOgBNmKLdczMk/maNFxdEn3FX
	 WDSy5XtIYRx8RL5PzXtFyhtPycrz1/0/6WTqRCRriy/Q0+V1EfJK8ITgzrNzXGxXgpsoC
	 ktI4KdQhE6zZBamDviuvG0Qs07QJb/sGEKcyKFVT3iQxGGv/gMSlHcx9Fd7Xqg4//SkJt
	 eZtzpiIwinUGVUKRHpy6fP6ZC07acRerUkMOsLAFgTw7MJAp1X3i97lb6RQfp8bL+1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnodbQJM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBCD606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jnodbQJM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6871F000C1;
	Thu,  5 Nov 2026 18:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793902423;
	bh=mR3i1W+FJLcBbkWI0MtcxdTW89H+epEruWCmxmEKjd8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnodbQJMqU2l2hyvoZqihp04WF1vVvhehu/ji7hofjE2VXZn2v3a0bM0BCRIyIjiU
	 3ooeVjEFidMzgQruvT5AMYKAPXIZtx96nyIoIOEv302q+MOyx7q9ZmvH81Vk/Nag3i
	 Q6LWsD6mN0vWSkOLPSXjonoK+nsC9wR2CqW1AzY7JmVlII8eWtctBjxfD/tz1k4HNO
	 +0j2lbJxhgXKM9xJDqdgQOpTozsHdWivWnRF5QwF5QcpAsYe500kfYwYMHjSFwRqz5
	 vM/PxWGSeXuvshrD5kJosRDzSAUOKW8vzNst6ouN8euSTabgLrap+/TJaoR0xIeBDB
	 6lonCbUBOuJUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: bound POSIX lock data area by response length
Date: Thu,  5 Nov 2026 13:13:42 -0500
Message-ID: <20261105181323.2270186-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110406-dismantle-scariness-905f@gregkh>
References: <2026110406-dismantle-scariness-905f@gregkh>
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

From: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>

[ Upstream commit 8fc9af68c57156ff64769f30e831553cd03b3000 ]

CIFSSMBPosixLock() receives a TRANS2 response whose server-provided
DataOffset and DataCount are not required by validate_t2() to describe an
interval inside the response. A server can therefore make the client read a
cifs_posix_lock beyond the response buffer and return those kernel bytes
through F_GETLK.

Use smbCalcSize() to obtain the full response length after any multipart
TRANS2 reassembly, then reject data areas that extend past it before
dereferencing them.

Fixes: fc94cdb94462 ("[CIFS] Fix new POSIX Locking for setting lock_type correctly on unlock")
Reported-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Cc: stable@vger.kernel.org
Signed-off-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: Subtracted 4 from smbCalcSize() and replaced smb_EIO2() tracing with plain -EIO. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index d2a4016acf7eb..f8cfd6e5b27c8 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2056,6 +2056,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_dbg(FYI, "Send error in Posix Lock = %d\n", rc);
 	} else if (pLockData) {
 		/* lock structure can be returned on get */
+		unsigned int rsp_len;
 		__u16 data_offset;
 		__u16 data_count;
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
@@ -2066,10 +2067,16 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		}
 		data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
 		data_count  = le16_to_cpu(pSMBr->t2.DataCount);
+		rsp_len = smbCalcSize(&pSMBr->hdr) - 4;
 		if (data_count < sizeof(struct cifs_posix_lock)) {
 			rc = -EIO;
 			goto plk_err_exit;
 		}
+		if (data_offset > rsp_len ||
+		    data_count > rsp_len - data_offset) {
+			rc = -EIO;
+			goto plk_err_exit;
+		}
 		parm_data = (struct cifs_posix_lock *)
 			((char *)&pSMBr->hdr.Protocol + data_offset);
 		if (parm_data->lock_type == cpu_to_le16(CIFS_UNLCK))
-- 
2.53.0

