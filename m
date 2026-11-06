Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926177;
	b=rfarOwYMtTQNV1m61JXFz6igGiPjxcDPycCWYeQWZ5NdtkAudcGtYEmTai6QqRCPg2Ct
	 SEcgQhsifjErshMXBGWf7KPGR0WWJjSjqnCkU2poFoJTO1S8W9orjvQimBhPCR4ptoECs
	 hogfu+6ApjGdc3B+5cjGDP9I9SfzT0Kh8NW2W3ezoAKjHnQiduHlGQYnJ9mEO3jH/l/UW
	 srbmsYTYbfh3LjOBeK/WdlfLIcCZzvIy5qceiWk2FBVSnAvv8ZjVL1gLFHldDDimUoVJo
	 Qvr+i2mEPy2QqFkeQ5IS2eM8hakVDypoZka/tmQjx86mqoCvxC2iJ9Hk690o8cUBh0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926177;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=54jePDnVj9kBK3X2+ZZPS/tNJo0wkXHyvA/1b7epDOQ=;
	b=PPV2kA45nq2kx2VjhA/8Q7CO+oL2sBKl4M+fpYQ+274/JPdMiYK/7ChC4J9YxSMCH3uW
	 sbuLhDVCXbPJHeFxCUZuAn/gEXNnch19QmDgKXQTVQA1Dbk4jNMp39XQjuJFeERBVBGdB
	 ES5moF4Qg8A8Xk9ZSZl/7695cqgTWUIyzspQ4SBjDyXNajt3x+UsyVbA51tQgEQwBXVMh
	 BZp7wJI5MnwUp2V1GDODtif/4fgov0dAdQz957xyz+ZnfeRGlvnvvZVFwo+GFZUzB6oyd
	 gT+Y6tMkT4KJYHJ+60KPJp8lZOLItERcLoY/tDW1m32WJra8FoQj+2vxe8SOfJCev1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ED2GlPM/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49ABC606A331
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ED2GlPM/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A111F008A4;
	Fri,  6 Nov 2026 00:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926177;
	bh=54jePDnVj9kBK3X2+ZZPS/tNJo0wkXHyvA/1b7epDOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ED2GlPM/NCzLV1repVjWosXYd6iIniUVcUDLK67dbDTwYJ5EUQcimD2UuVWtuM/lB
	 124ghAd/nF4+WESN4w0LuRMC4aq1Z8Nr7wZ+PxlRmw/8y2iLEOVUhWz6ACM5qpb8Y4
	 zfihg6vfGMgYUvdjlEr0I1o/niX3E47UEAGB5dMowCXdtrDKCT5o3vUEpcXtQjdJIw
	 l5ochNNqhmx/iQPK51pjj+YPXvlEPsJ0NYJU71w19rYIHEz+czDfUicFnsZdoH/ype
	 A+fW8TSsQHx+/TDKUbKEaBrsDUgAv7Cm0mMd5qJnAyA/rj4kXbEwXozmjp4xKSeL15
	 /4UYnO6YZ9P3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: bound POSIX lock data area by response length
Date: Thu,  5 Nov 2026 19:49:35 -0500
Message-ID: <20261106004500.2755780-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110408-eatery-delta-feb8@gregkh>
References: <2026110408-eatery-delta-feb8@gregkh>
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
[ sashal: adjusted response validation to subtract the 4-byte header from smbCalcSize() and use plain -EIO instead of traced errors ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 67ff1669cab2a..08ae1d7d2c516 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -2592,6 +2592,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_dbg(FYI, "Send error in Posix Lock = %d\n", rc);
 	} else if (pLockData) {
 		/* lock structure can be returned on get */
+		unsigned int rsp_len;
 		__u16 data_offset;
 		__u16 data_count;
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
@@ -2602,10 +2603,16 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
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

