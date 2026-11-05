Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793905414;
	b=DRzlFuqMCCWfJOq38QZf+rFKsHNq4RO/ecfZbgKzYZjDha0SmxvTlJYX6ff/iBloLr9G
	 EKcFZwUKpktlhySBcl5oDuc0L7cL+VY3/FLE+6g1xMlDl3HZGRvXP41DLIif73CW0tUft
	 A1x2/BzHHzqPMqD/VInK0pwzy7plIC9QzHyBduM5w9/xAfAjnLEJOR6RnBYMvP3rzWDT6
	 6ulNpDlYtA7VCUSYYVB/+boT3L6EC7kOfb5J9rLBl3FG5TAzaiDAoHbbxf6kW3XWRJETb
	 yusnKAukCKZUrpWj4QjIKLCW8F48xxpvUtFX+FSDXVniMaeIlQCVbqs2D5NP2GkKUGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793905414;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kax+ozCzx4ZmXMhWSxfp14A5JBqAgAH2noBaBA1ZoOY=;
	b=DPffmMtE3zEayTmu88njjxRMjQrbaeLZ33WzpslY3LvqXeUinaWjQvTGY1gWeafMglgA
	 zrhKKohZrfB1BwYFs/9vVN31c1NryDz4GQO0boqdqby3b40EsZAQSgKay/k98Fduf+yHi
	 AlxhvhNnry+1LGICLHOjXDwm0ew7VK35Fg0pm/gCzznFM/Nxnn5pujQ3FH+csMCMQQ8/f
	 H5p25s7YHeRnHVnAfe+EVXiWtQTt7Ia0UmO1rGopVNdqG0dDdHM1mVa7Jh6My6s+myg0t
	 0Mwi97SAcw83nRO/ff/LtT/2vFwrnHCMHatKTUxH4QNxX9tZyP5NDEECoU/OspLSXkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Njn7OAiE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2787606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Njn7OAiE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3961F00919;
	Thu,  5 Nov 2026 19:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793905413;
	bh=Kax+ozCzx4ZmXMhWSxfp14A5JBqAgAH2noBaBA1ZoOY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Njn7OAiEysKymBoGBlhDGLp2VEsBnpLJOP1lyD0XCVtrtlEH26ulq7nga4qnDZXyU
	 e+avkxaMSGlmr3nwa7dqmMUp9MyZxizCqVhrQt3TMzjPaRQAMqEKTXmyh63Foc7w2c
	 2oqRbY8bZ0gLztiyjE0pF8JHCSP48qUhCGhu0PnETPz6omMmQBJm7JWP3qhQeNeRcK
	 HmmlahG0NImaEUxX5WMKIS0JPIxm9PQAKDONCIotsyNEKs2TlcOcLcP/zdUQKIeeVQ
	 kcMhp+fMMEZs5D6gvozgmRv+slq8pY9zzwRViKveB5EegWlsS5Y/AdMvQfLLZ9yn3O
	 CT0TL3/8ofroQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: validate NT transaction response layout and offsets
Date: Thu,  5 Nov 2026 14:03:31 -0500
Message-ID: <20261105185731.2641233-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110454-brigade-bankbook-1cb4@gregkh>
References: <2026110454-brigade-bankbook-1cb4@gregkh>
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
index 11a400663b9f2..290aa04d89151 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -3735,9 +3735,10 @@ static int
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
@@ -3748,37 +3749,42 @@ validate_ntransact(char *buf, char **ppparm, char **ppdata,
 
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

