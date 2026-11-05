Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904296;
	b=Bz2SMaGwgd+Umx+rX3ZBVj05n1pQrfh2BgWLXVbfJWCbKfZvC1quyNWpSiuCU+NIC3X4
	 2J5HkG9ITZ53ALHlCIwaeXH6vTZoWSgUacFgoJ/BqFyFq18VdhajpCSLHcqrgZxHIR/xa
	 wusLXeJ46i95P4bjSqXCf9qiHJAWHv9qUJVE3LbAH8fcMUdhLhXpnbJjQMG6nBdZMpQZK
	 7RhLZKi3xpYtjHEocngUmA1CfWk8zAzZ4hOj7fCXmM++9FhnkeX3uSXMTYsaXOD/UKTe/
	 YoUHcXwjQ3es1D+b1YBHHLTBhpPb3/YRB6xyoayPueUeSOMLqSHQ5Zy1AXLspGa6Jrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904296;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Wn0y+rpzG/RYbacRdX6P7QnhoYr75y7u27kXM0fM0SM=;
	b=q9weScvqVRTfd2q5sp/JUbC0H/42D/h06PVyuwahUqqHiQFqh4e+mSWTBvov3z0HZ0Go
	 fIkLi8JFvFqm3Fcpqc5hZWsJqDIaRT85yfSF0SlG78KkjYL0pUazSlQP+atXn4DP5BIpI
	 +iIOd+PPrlTC382HS/nuc3rkz5x0jaFjlnY/ugmzIkb2b41pIz+UXvhdgOIZYz7YUgk4S
	 5JlcD0N8GRSijPRIp8Hqclod/mqB5l896vnqaiOiGqwgC7o8yqSrgCfraMQ7HbNUln1bn
	 WpgZS6bRLm+/nTOKOBHAf7U9lvCVCrNvihsf6OFu7rKbjjPaHBoGHRisKJ26Mgix9Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=La1EhBQl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69B6606A338
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=La1EhBQl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D68E41F00A18;
	Thu,  5 Nov 2026 18:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904295;
	bh=Wn0y+rpzG/RYbacRdX6P7QnhoYr75y7u27kXM0fM0SM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=La1EhBQlfFZu1XeaCcXc2mWpgQ5GSKaKZ4rIldZrlAyvv480Dak/Ff6bX0/FMz37u
	 ze9DT0O0pFeTTI1rqrkFgQIe1TAdw+co2srU0x4n2gp4s5M/QsbmeSBvRlU3b9Pial
	 UoRcTa37rbFW8L6iWjR8Jcf/ZObSq/mkr2py0TuuNGxkIQlWVFHzA0vknVKFc130tt
	 NLAAV5MLWFzGsOVwGOxDXfCNIJ2rfD4B/QdJnYF3d1YtpRkraaHDiGFAdLnMwAESTv
	 UPVxToQPmJSqkJapjcSTpAgOXYbwXKSwNB8QHiIWwI/5vvcPcfQUpnj2RbMHoKIUxv
	 iWPJ3g2T2bLdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: bound POSIX lock data area by response length
Date: Thu,  5 Nov 2026 13:44:53 -0500
Message-ID: <20261105184241.2313303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110407-custody-treadmill-c8a2@gregkh>
References: <2026110407-custody-treadmill-c8a2@gregkh>
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
[ sashal: subtracted 4 bytes from smbCalcSize() and replaced smb_EIO2() tracing with plain -EIO ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 499385445cfb9..6f599c6eaf4ab 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2052,6 +2052,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_dbg(FYI, "Send error in Posix Lock = %d\n", rc);
 	} else if (pLockData) {
 		/* lock structure can be returned on get */
+		unsigned int rsp_len;
 		__u16 data_offset;
 		__u16 data_count;
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
@@ -2062,10 +2063,16 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
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

