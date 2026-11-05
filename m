Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899277;
	b=rZP/nm664Mf1Ts4s/RfTsx8/O1/9Zb2ZA9TjBMS8Ni/ULyNYsXYHWAXsVxVSd3ARTORE
	 mQIAfzMoVKl5cU/OWSaelPiMtjFFqVKgPMte2z3l4z/+bAqefcHbP7rBeuXSi9TRT4eCh
	 KpevRNHhlNfTDivXQk1sw69OwZNKI8oQ1fl9ChDMeyhtobSdesSR9pXtJv6ebAAUOwIQu
	 DmWMLcvXixDhF0slSMY6v12VCUbcD0bzIepqJBux1I7hcz+8RJyCI04hLkK52xvB/GmeK
	 zYZ30K6bqigs2/iXga8DCBG0o+4Ax0CILIeD5I4lhTFtpZSB5AZzdkQrjG/lF1fjRwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899277;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZSLmVDDKXY30pCKbP0Qz/fVPpcIl5QebUyezvhSAwwQ=;
	b=QpKoBMVzGNzrLH8WU47FNHA/qKH+Jry2OsrAy/UYRpMGrrMmwhKaT7b+rA1CTFn9Xtik
	 79dpGivs0QWdFVUCdqv7KvF0vulr1V+l12hBAxaIlPUvFiLwc3bNxk9Pw7wiUUQPQm56k
	 JX6jZ8lKMy3hclVPskf++TT7p4+DJFlO0NzCXsnyY6IUS0h+MhGTn9OPAvoZUO9JzQdMy
	 m47YK6O8r6G6MehxIXYcNtH/HlceGq8pyFy+tfcXuMrfjb5d7TqaOrGNgFpLnPuWIq+Lx
	 DUOzIWxtVe/GHQYnhncyCngMjfUKaTNRsYF/bP11en77Aw16sGsILDseQ4zZhll92DQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqtVxxQh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8D60A261B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FqtVxxQh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60971F000C1;
	Thu,  5 Nov 2026 17:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793899277;
	bh=ZSLmVDDKXY30pCKbP0Qz/fVPpcIl5QebUyezvhSAwwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FqtVxxQh5QVObcCS8ON0pA1NyR4CGffRVJzpkY5+lpHkk9LjSDioYVzS3AAcJgN8o
	 syWBiD+Wi4Pw0P/vOTHha9MK73IMI4ViodS5KOAtyqgLciZblr5E/owttcQsGMq721
	 FJdghPwKP9h8hz6wyqbrfiGd4l02qI1Yw28h/w/lIa7Bb+v/RWK1WCKoBzorO6xfUD
	 u40Wum2i9NeXY41KtnY0AwtAMdMX9P75S1WxLf42Gv6MjMdFtwnkBIjtluhrgQgxC+
	 CY2Oj+vk/FEYPONhLSZxdpiy2tgfHu56haSGTivbxD9IK68kkcWIobOJ+yvn2Y5d/2
	 kuNgf5Tu8BYXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ratnaker Gautam <ratnaker.gautam@kuleuven.be>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: bound POSIX lock data area by response length
Date: Thu,  5 Nov 2026 12:21:15 -0500
Message-ID: <20261105172108.2183463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110405-rural-consent-24d8@gregkh>
References: <2026110405-rural-consent-24d8@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifssmb.c | 8 ++++++++
 fs/smb/client/trace.h   | 1 +
 2 files changed, 9 insertions(+)

diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 6e4b845a4078c..a5c592e2562de 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2338,6 +2338,7 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		cifs_dbg(FYI, "Send error in Posix Lock = %d\n", rc);
 	} else if (pLockData) {
 		/* lock structure can be returned on get */
+		unsigned int rsp_len;
 		__u16 data_offset;
 		__u16 data_count;
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
@@ -2348,10 +2349,17 @@ CIFSSMBPosixLock(const unsigned int xid, struct cifs_tcon *tcon,
 		}
 		data_offset = le16_to_cpu(pSMBr->t2.DataOffset);
 		data_count  = le16_to_cpu(pSMBr->t2.DataCount);
+		rsp_len = smbCalcSize(&pSMBr->hdr);
 		if (data_count < sizeof(struct cifs_posix_lock)) {
 			rc = -EIO;
 			goto plk_err_exit;
 		}
+		if (data_offset > rsp_len ||
+		    data_count > rsp_len - data_offset) {
+			rc = smb_EIO2(smb_eio_trace_lock_data_area,
+				      data_offset, data_count);
+			goto plk_err_exit;
+		}
 		parm_data = (struct cifs_posix_lock *)
 			((char *)&pSMBr->hdr.Protocol + data_offset);
 		if (parm_data->lock_type == cpu_to_le16(CIFS_UNLCK))
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index a56fbacf28d14..670612d1a4497 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -42,6 +42,7 @@
 	EM(smb_eio_trace_ioctl_no_rsp,			"ioctl_no_rsp") \
 	EM(smb_eio_trace_ioctl_out_off,			"ioctl_out_off") \
 	EM(smb_eio_trace_lock_bcc_too_small,		"lock_bcc_too_small") \
+	EM(smb_eio_trace_lock_data_area,		"lock_data_area") \
 	EM(smb_eio_trace_lock_data_too_small,		"lock_data_too_small") \
 	EM(smb_eio_trace_malformed_ksid_key,		"malformed_ksid_key") \
 	EM(smb_eio_trace_malformed_sid_key,		"malformed_sid_key") \
-- 
2.53.0

