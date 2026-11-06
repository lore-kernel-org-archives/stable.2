Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793932496;
	b=dB0dsp7HnN0pdZWPR3aaep1fJqcKbOaYHAQoV4HBNAzjsjH3t1+zQiZ+yQZX5Rydrh35
	 TAixIl0C2d2TU3wQEkGgCWceE+OYOpKPPHTUx1326bj2hidHyx1bvKKIFk1sAzyXemdLn
	 XOD7WVbjVhPls66qwyZjbTPmI2+2jrA2zwK3fXDlxwHddnVJQdc53LP4qo1KpGMGVJqn8
	 0Q6LGo1KQL5PK4aoNpS9uGArb+ZxS2JirB44FSDaxOLr8/TohFg1PkMDzOXTev9Rx8e43
	 TrVkD1tv3fGo9lPtK0UWNfxGmmVIXC51l1Cob+u9wC0tKSO6TD9m9XJtaPC50vYcT9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793932496;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Kn0M/yCwcX8v1DPwR8zexDnpRkerdE1Hiw1W6jA/I20=;
	b=yTmdq86B4Q13K/IeqQFdn98+cgKekdvQA/FR+V8jCQAJ0mOiDwokCS0nv6GPF3Eo9NFr
	 bEJTOCxkENJyxOskBlFAkilXXzmAjYIgFEJnckY3gW8lb+HCu0kWGWqVtHoEqXMF1N6Gg
	 zn+L1Y6RkNG44y3hOHwsd88tQwE+uUOGI7vdPBiPTtLbMeubqhH9s/nwBCS3mdHknxYGM
	 MtDfL9wKtKamNPJdf3LXHuXFdTDhzrmpRhsPeXiQhsGXYIPEtEQAxi2Zy7EvjOaIoXZAn
	 kN8D16RXu9vOgknoNckRGAjqpaYdfu4lD25HXSXwKXvPP5dRKiL2yxivCwDRK7vpCvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfGQZgEA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B9F606A33A
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SfGQZgEA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67401F008BE;
	Fri,  6 Nov 2026 02:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793932496;
	bh=Kn0M/yCwcX8v1DPwR8zexDnpRkerdE1Hiw1W6jA/I20=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SfGQZgEAZXOTIUDa4x/mfXZbo5qYaAzOcGP3vzAEbnd/vlFVRawYFL1P5KJ5d3UAk
	 bhINz4PSCRD7SfAwT62F1GR68wb2O2y92DUMM2x3WT6rhc9c/CEP6WEdvGPDgRvKPy
	 2BVCfglEc45U/RNFtwuCsu4Xm42uH+lHNZC2qJNp3zx2Hqk8NqGHf4uol0oWJvmkwu
	 0xvNdUNqEr3QM8z1AOxGMTb+adXt5Y1vxJ2Yu0Zui4xZXOEnFwQOxG+vY6awNgmquk
	 EqHZhFTiCeeZcT8dJmMcAXlB2fUARIOapmRIgl3C8ikJwedaioFu/I4S3F/dPdACX/
	 ts6+ZWn3kGusw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] smb: client: validate the data area in SMB2_read()
Date: Thu,  5 Nov 2026 21:34:54 -0500
Message-ID: <20261106022008.3501484-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110422-santa-book-618b@gregkh>
References: <2026110422-santa-book-618b@gregkh>
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

From: Abdifatah Suruur <suruurism@gmail.com>

[ Upstream commit 2ec9cdf469dd32bcf33073aeb30c08e9356e0ca1 ]

SMB2_read() copies le32_to_cpu(rsp->DataLength) bytes from
(char *)rsp + rsp->DataOffset without checking that the range lies
within the response actually received. A READ response with
DataOffset == 0 makes smb2_get_data_area_len() zero the data length, so
smb2_check_message() accepts a frame as short as the fixed response,
while SMB2_read() still uses the server-supplied DataLength, capped only
by CIFS_MAX_MSGSIZE and the caller's length.

A malicious server can answer the synchronous read used by the
mfsymlinks (or SFU) symlink parser with an 81-byte READ response
carrying DataOffset 0 and DataLength 1067, making the client copy 1067
bytes from a 448-byte receive object (KASAN slab-out-of-bounds; up to
16 KiB in the general case).

Clamp a zero (or header-overlapping) DataOffset to read_rsp_size, as
handle_read_data() does for the asynchronous path, and reject the
response unless DataOffset + DataLength fits within rsp_iov.iov_len.
The SMB1 helper was fixed the same way in 5be5bdda5863.

Fixes: d8e050398d23 ("CIFS: Add readpage support for SMB2")
Cc: stable@vger.kernel.org
Signed-off-by: Abdifatah Suruur <suruurism@gmail.com>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: replaced smb_EIO2() with a direct rc = -EIO assignment because the tracing helper is unavailable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index a2f1d165d8862..9380cb3ea9743 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4162,6 +4162,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 	struct kvec iov[1];
 	struct kvec rsp_iov;
 	unsigned int total_len;
+	u16 data_offset;
 	int flags = CIFS_LOG_ERROR;
 	struct cifs_ses *ses = io_parms->tcon->ses;
 
@@ -4218,8 +4219,28 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 		*nbytes = 0;
 	}
 
+	data_offset = rsp->DataOffset;
+	if (data_offset < io_parms->server->vals->read_rsp_size) {
+		/*
+		 * win2k8 sometimes sends an offset of 0 when the read is beyond
+		 * the EOF.  Treat it as if the data starts just after the header,
+		 * as handle_read_data() does.
+		 */
+		cifs_dbg(FYI, "data offset %u inside read response header\n",
+			 data_offset);
+		data_offset = io_parms->server->vals->read_rsp_size;
+	}
+
+	/* The data area must lie within the response actually received */
+	if (*nbytes && (size_t)data_offset + *nbytes > rsp_iov.iov_len) {
+		cifs_dbg(FYI, "bad data offset %u length %u for response of %zu\n",
+			 data_offset, *nbytes, rsp_iov.iov_len);
+		rc = -EIO;
+		*nbytes = 0;
+	}
+
 	if (*buf) {
-		memcpy(*buf, (char *)rsp + rsp->DataOffset, *nbytes);
+		memcpy(*buf, (char *)rsp + data_offset, *nbytes);
 		free_rsp_buf(resp_buftype, rsp_iov.iov_base);
 	} else if (resp_buftype != CIFS_NO_BUFFER) {
 		*buf = rsp_iov.iov_base;
-- 
2.53.0

