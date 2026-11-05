Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793907748;
	b=AZ2HGd4zasJO8bZjM5dFfsTRUOTKEAaJbCVjbs88XV5xxuWR6waaGWeJ6bUP7ebZ44+S
	 eZsDLU4ZcnNg9wluc0TT3OCouDKt3xAvAoU4pKsCRxhxaCD216+EYFiTbbbuPMkYkrj0M
	 X0mjrknRlCjcCInp6WHhGNwKhAOjjJtzuh5nVuLMEr8Us2+mAy42lS57gag+tbPoyA3Ig
	 bxSdRI653nCAjZCAk37pMpv0XQ6KIdr3iEhS0vTlM+v6Be/OupuFtf6x9Gz5PE3zc/16c
	 pzfqkiTRgalxlJoCbjFYKgjhxw6SSzW8ffpyr5BMFaT2HEFR/xYw4gCJ1K0mAPlztug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793907748;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Ku7KclGTtjbOYc21nkRhGsQF73gPQxfgZW2Mj8BpY8E=;
	b=lcd1Wl6c8Om/R1oxeL79QI+KqJsGw+EmWIfaqLS9MBvozDl/6sMTwD1jfYHiasJN4GR0
	 mL6b6JaiBgDShMUzKb+g5UI4cBSPCuNVSxzh9xcgxq3lqtpDSL1SvRoiIeQoNkp8zO8+G
	 jhZZNZth7WVDyPMlcp8C8aQ/Dcn9FN6RId1yJDIFcy2TBiI5s57zb+Wu3obLlecfG5dbX
	 9Ln77v6hVtKHboRlNZmM2cmlT6+rlV7TTLPiYN8HDTubNcQc/t/AC76RULvvV/Y1c4NCE
	 Xpk0y0cyxxIIuyGYNeHsIcCQajm7EhWqKgz021T6wuo0grzOswfWHlstZ4fu+WYcqeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6pM15nr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56677606F97C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i6pM15nr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E8971F0089F;
	Thu,  5 Nov 2026 19:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793907748;
	bh=Ku7KclGTtjbOYc21nkRhGsQF73gPQxfgZW2Mj8BpY8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i6pM15nr5knct3NdCGcSG9biKe0fYKNdjOYDRrnNT1THDAMZlR22hx6g/HBP9QYoA
	 I6NhgYj38VJwhI8SijEbUSJTuyfEwrgmaytHknUtJxfrJ/Sg+E37SLB2IzkdJmbTPA
	 yG0Z1L90AJ9BskUkjRvmmYjTsnj23mMgvsQz1ok7Wjo5AY1nOlSGVgaYVicdhqJfDM
	 8aC8mwXQGinZscDkIMmp5qY2w0Ckt7VcR/H8RXraBfPQJkCDQIUBQi0EPhO/BDcf4S
	 KjMY3z9lkOuLnvTTWfD9kLPWvXJcAgZkoZZ+bF8ZwyCcEkdiApxrKxgeg3bDpiCV3k
	 blxS61w0l9LXw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: validate NT transaction response layout and offsets
Date: Thu,  5 Nov 2026 14:42:26 -0500
Message-ID: <20261105193918.2652018-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110455-observing-blush-5a37@gregkh>
References: <2026110455-observing-blush-5a37@gregkh>
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

[ Upstream commit 83d0d5e0ca22233c75daf139ec0063b9d2ff1ac7 ]

validate_ntransact() assumes that the response uses the fixed 18-word NT
transaction layout. A different WordCount makes get_bcc() locate the byte
count at a different offset from pSMBr->ByteCount, allowing the subsequent
bounds checks to use inconsistent response boundaries.

The function also turns the 32-bit ParameterOffset and DataOffset fields
into pointers before checking their bounds. On a 32-bit client, a large
offset can wrap the pointer below end_of_smb and pass the one-sided pointer
comparison. The caller then dereferences the parameter pointer or copies
from the data pointer.

Require the expected WordCount before reading the byte count. Check each
offset and count against the received SMB length as integers before forming
either pointer. Use subtraction after validating the offset so that the
range checks cannot overflow.

Reported-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Fixes: 0a4b92c05ed0 ("[CIFS] Add worker function for Get ACL cifs style")
Cc: stable@vger.kernel.org
Signed-off-by: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifssmb.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 67ff1669cab2a..9af7ddd21d4f1 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -3843,9 +3843,10 @@ static int
 validate_ntransact(char *buf, char **ppparm, char **ppdata,
 		   __u32 *pparmlen, __u32 *pdatalen)
 {
-	char *end_of_smb;
 	__u32 data_count, data_offset, parm_count, parm_offset;
 	struct smb_com_ntransact_rsp *pSMBr;
+	size_t buflen;
+	char *end_buf;
 	u16 bcc;
 
 	*pdatalen = 0;
@@ -3856,37 +3857,42 @@ validate_ntransact(char *buf, char **ppparm, char **ppdata,
 
 	pSMBr = (struct smb_com_ntransact_rsp *)buf;
 
+	if (pSMBr->hdr.WordCount != 18) {
+		cifs_dbg(FYI, "invalid NT transaction WordCount %u\n",
+			 pSMBr->hdr.WordCount);
+		return -EINVAL;
+	}
+
 	bcc = get_bcc(&pSMBr->hdr);
-	end_of_smb = 2 /* sizeof byte count */ + bcc +
-			(char *)&pSMBr->ByteCount;
+	end_buf = 2 /* sizeof byte count */ + bcc + (char *)&pSMBr->ByteCount;
+	buflen = end_buf - buf;
 
 	data_offset = le32_to_cpu(pSMBr->DataOffset);
 	data_count = le32_to_cpu(pSMBr->DataCount);
 	parm_offset = le32_to_cpu(pSMBr->ParameterOffset);
 	parm_count = le32_to_cpu(pSMBr->ParameterCount);
 
-	*ppparm = (char *)&pSMBr->hdr.Protocol + parm_offset;
-	*ppdata = (char *)&pSMBr->hdr.Protocol + data_offset;
-
 	/* should we also check that parm and data areas do not overlap? */
-	if (*ppparm > end_of_smb) {
+	if (parm_offset > buflen) {
 		cifs_dbg(FYI, "parms start after end of smb\n");
 		return -EINVAL;
-	} else if (parm_count + *ppparm > end_of_smb) {
+	} else if (parm_count > buflen - parm_offset) {
 		cifs_dbg(FYI, "parm end after end of smb\n");
 		return -EINVAL;
-	} else if (*ppdata > end_of_smb) {
+	} else if (data_offset > buflen) {
 		cifs_dbg(FYI, "data starts after end of smb\n");
 		return -EINVAL;
-	} else if (data_count + *ppdata > end_of_smb) {
-		cifs_dbg(FYI, "data %p + count %d (%p) past smb end %p start %p\n",
-			 *ppdata, data_count, (data_count + *ppdata),
-			 end_of_smb, pSMBr);
+	} else if (data_count > buflen - data_offset) {
+		cifs_dbg(FYI, "data offset %u + count %u past smb length %zu\n",
+			 data_offset, data_count, buflen);
 		return -EINVAL;
 	} else if (parm_count + data_count > bcc) {
 		cifs_dbg(FYI, "parm count and data count larger than SMB\n");
 		return -EINVAL;
 	}
+
+	*ppparm = buf + parm_offset;
+	*ppdata = buf + data_offset;
 	*pdatalen = data_count;
 	*pparmlen = parm_count;
 	return 0;
-- 
2.53.0

