Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793925986;
	b=m4/mFfp+xqLxUm4yjTErUaKNGsgYIhCSgzosRCN/jDej1nTEdROGbtijJ1u752mATRHc
	 cxGDxflaqYMpShHc2WGhO48l4nH69XTQ0gRIhqeUbwt+I2ldqK9Hd4GrPiauc8l514Lqu
	 x1oKiJRWHvu/3QxMHodGswUBwXqOC5/q74Xion4++LjIHJ8O3bvFfFiGo117DEXVkjkbq
	 ARr1KqrH8zZrTZtxdmBDXGK3Q/weoYQ19gKRRc1/vGuNtio3rReNLerbWR8+6R4tdlBAD
	 vJzigHLwQh2Rqs/TnJ6QfIsGo6+uKfQErZvSWAafiblBew0RaX1JemrX7u0hoSD7C8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793925986;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ncUcAX0L7QUoA94f8Ey2Q/b0k77d+D+tUPYUCsJq/9I=;
	b=bfI6y8yQ5zPhWTggKxFP8VLwwP9RgLvvTq1lq5WaZRGxmXd1XFrL/Qz6uvfzx6xUhGXm
	 oMnawejZfcJ9CzBCWZN7troSeCuZdGTfE0yc24NvurubBg75AsqaRj7pFF1wYN5BcEkGR
	 N0fiBli/uFePcY0FhzpXXFRAg7zWpfJXv/Br+XDc9uGX5v5r+8F+vSC9m2vgMLAYf1xTh
	 6qF/ebtP5y2xQj0T5mKUG+UMNm7F+m6feYXf/dD917VUGi45JyNdhgU02ArTBOoM2Vy5H
	 /dH85B4AhNx8a6iEV+wId5QC9UQ4UDscAIfUqjq8Q8kI+sKPYuKS2SxHy9UIMvBettg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKV8G3lA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DC8606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EKV8G3lA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B9A41F0089F;
	Fri,  6 Nov 2026 00:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793925985;
	bh=ncUcAX0L7QUoA94f8Ey2Q/b0k77d+D+tUPYUCsJq/9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EKV8G3lAVXiLyWQLkKsGee/Tx02QhljahCIFHWT0JekbV/7sPz/1wgHRsQ/s+sAmR
	 2StecOgAhVXOeCXmuTBffyCNr6r7gboU47Ti8ZqHTz63N3x5Ev1wDWkgO0LzhT5xmK
	 VjLBtmRPqcdGAyl9FOv0PSX3nZMrnADhZlOxFkwIQOQpplKz5rYIX5ixfQ0+qtCaSZ
	 Gkaf9jVjqZ1xUhhJ279JQ7/10CJx6WU1C+NiISM2pXyXCNqO6PNXIbACEyDrXrI2Ll
	 jjDrn6rWry1R2VEyNylypJ3s/KM75AJoGH1flYr7qCsCYZUrlFLZIUSmJ+p94v77Ha
	 idWRQAqnXiVdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: validate the data area in SMB2_read()
Date: Thu,  5 Nov 2026 19:46:23 -0500
Message-ID: <20261106004456.3427593-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110422-kitty-unlocking-dd52@gregkh>
References: <2026110422-kitty-unlocking-dd52@gregkh>
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
[ sashal: replaced the unavailable smb_EIO2() call with -EIO ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/smb2pdu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 2c7bcb768a64f..35e3be4933595 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4236,6 +4236,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 	struct kvec iov[1];
 	struct kvec rsp_iov;
 	unsigned int total_len;
+	u16 data_offset;
 	int flags = CIFS_LOG_ERROR;
 	struct cifs_ses *ses = io_parms->tcon->ses;
 
@@ -4292,8 +4293,28 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
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

