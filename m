Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793900468;
	b=ZO85DGPu5OSrz155mgb+QFCaiFaw+LsBmJYcT7wLq5LPZoTYSCWqrCB1EPu1+z4GHmJG
	 fktPrU2mGzDr+1NY7TJLzRNyGVsqVRSLS4IUc8qnnOzUZQfWG2Ch6Fktop88RPlrpjsYJ
	 Mfsqnztuo50Aac1kldI1TMxeWdZIuwvvEPRXKTsi/MIrlPuSv1spGLfx18HVKKbywxr11
	 Hj4+lxn7XDYLLjUEW4MYnJl5bRjLCyIilJg1pp1DRIQH18eloEfay0EP/Hzh9qnA8xOxc
	 XipUzJiY/ipA585JEBbeHnGidYjMRQAauzoZKX4YbzULmA/WTXJRUToMRN2cRV4eOqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793900468;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5cHwaepW4MjyQa6Q8fqcAMUv+vuExNctllf6hUk3rVM=;
	b=ul+vJGqobZhJGZ2jorqchI2rW7sG+ZLUcbcVQJqqdH8mDHQyfa8yF/P/7ZOovLpwatrE
	 pmGl/zMvTd8J8eATc/k2viljeZ4g0G5QnuvW4XSk+pBxjPV657ivwi4qffAb7W4Tifp3v
	 JHFEuEiF3Fps8H4gbA+t8FZSVa3TAOcapuC4/PWQSzRG3CxvSri9azJ+5codYfald7l+m
	 +DSdS1Z20uIYdJ84F+X0R9RytE0EiPwrW1keXjhXnzbD0R60VDHhhyrLvknyT8ohnFDKW
	 Y+w6pOP653ndkH+4bC6lM9RnW5uPOv1DK3HzZmsXC5kyCvdqAB9EU4IfT+J1AI2U2gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWr801ps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A1606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWr801ps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFDDD1F000C1;
	Thu,  5 Nov 2026 17:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793900467;
	bh=5cHwaepW4MjyQa6Q8fqcAMUv+vuExNctllf6hUk3rVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWr801ps6MPOFdytlbOtlDJMcfR9hFOJWSRHaMUvQD3wem62bBTDzULk+KRPYh3pX
	 SbShhCgdrkv+JxQwqm+HEHKKA88B/Llm0VkOmEuli1PGRTF+Zvo8/ulqc9q/bV0y8G
	 QdwnKUiNKQkd0ZHFZaC6XAr82DFdzGwfFvQlOo/duJafpV38LuIz46FqXRGQbxmWjy
	 zynaPTM2S4Nd9iDeb0e5Vg9FGUS4ZxoREgRXZeYTyNhQjT19w18rNCxf5J6JSAj6cJ
	 USchMbaMM5h2/YJSDuVrLlGiBGXa7sKEcskiJ3KdbFnyeGyPyn3CgB7XjqMOhM6OVc
	 W/AGwNs3xrltw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: bound POSIX lock data area by response length
Date: Thu,  5 Nov 2026 12:41:05 -0500
Message-ID: <20261105174038.2191050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110405-prankster-arguably-a837@gregkh>
References: <2026110405-prankster-arguably-a837@gregkh>
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
[ sashal: Subtracted the four-byte RFC1001 prefix from smbCalcSize() and replaced unavailable smb_EIO2() tracing with -EIO. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 3795fdfebb519..b19d6fefa5e43 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2092,6 +2092,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_dbg(FYI, "Send error in Posix Lock = %d\n", rc);
 	} else if (pLockData) {
 		/* lock structure can be returned on get */
+		unsigned int rsp_len;
 		__u16 data_offset;
 		__u16 data_count;
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
@@ -2102,10 +2103,16 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
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

