Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793910152;
	b=Qh9+0jf8Tjf55MPT7vSjKy/K6mCEkUXbRlPvcFBVjGOz+s68tiGB8USNMV6C3RZ4urdZ
	 nrgRY23Ocb7dl0YCo4Gj4Jjzfql7EGjnIvT+zgLJl08hnCQpzxNZi57R3IHu1YusyukgT
	 BscwKm00P2e8xH6qemz6Do0kXHFsaSB2yt4gKRn/pTVcE4gJbzTyJ6LP5dV2KzL/GQNrS
	 TRNbcAw3sEIXNIE9zmj0c7yI/W/olIYENXQ5RCFSFQcKgwCpf+mFL9dzeYHKkUeycF28p
	 IJlFsxJB0iaxVPudF4I4gd5vvC80DGhbMsWI87+Anav0p8Kl8mGRDuEOep+VLmCPwVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793910152;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=bFk2QEtX/kM6I9O99is3Ku6TmBDGSz8tiwV3uCh3900=;
	b=M+UTRt2vZh+hDrPfPF1kHHUfRdaEpxoE9iT/R+VMoHbI0tlB5GeuFnnOMAqkOm6PagGQ
	 y1Z0UJ0N1NAeniK8i/r4etnGHeLkyzjVfB3Q31mhw7DTlEGX6YQB4HAGxWYnhC2tfHWaT
	 uRZfXMZxw9DePAYCkaHTkYWW2Tavc63nJ5gpQ26qk96wIsbqLyh1I89tk895QkxDgpNHa
	 L/Sjd3lDzDFDjfdbzTPvNM0dMRxeOSgT43fyixT9u3UexqcE75qbHyu7jdpZp9weyiXR4
	 46Y5PjHjely9sc4Byk1ysDBV9rBZxutkM+oKVebjSssYqHznEetl3SW+nhJ04f7dU5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1l8gp6Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065FD606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 20:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k1l8gp6Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A551F0089F;
	Thu,  5 Nov 2026 20:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793910151;
	bh=bFk2QEtX/kM6I9O99is3Ku6TmBDGSz8tiwV3uCh3900=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k1l8gp6Y8wS2AFKPVu68+rnmponGdTGMzPD3fRIm91crKIV6UBKO1OzdTcL/ldLjf
	 Z4dLo38e/2HaDqfBIxqzu8N/NDoDdctb2gI+17Zy3IDwpEQ7JUPns8nFfJJvFgDnof
	 Y18DFoJM4aZvwW6WjCXeho5rvdJMf0s93+9l0ZbwzrLreXuKLCCwEHwEQDKTI/24gn
	 nf+fqZc0MQGmzEvuL1XIc79BUHPWG2nFSmzc/fBDaHQg98mM3iDTcyoSjtI65svHgJ
	 IYI7zAp6pv/spf8eWq9Tbc9JddtOe6Gabzagk3GnLd8/fld5WM0CXji4D8z4a4h+TW
	 WWkaDVGMwv4MA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdifatah Suruur <suruurism@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] smb: client: validate the data area in SMB2_read()
Date: Thu,  5 Nov 2026 15:22:29 -0500
Message-ID: <20261105202150.2760842-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110450-wreckage-support-bb8c@gregkh>
References: <2026110450-wreckage-support-bb8c@gregkh>
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
[ sashal: Replaced the smb_EIO2() call with -EIO because smb_eio_trace_read_bad_offset is unavailable. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 6d610f136f43e..5185f8cc8bcc8 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4839,6 +4839,7 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
 	struct kvec iov[1];
 	struct kvec rsp_iov;
 	unsigned int total_len;
+	u16 data_offset;
 	int flags = CIFS_LOG_ERROR;
 	struct cifs_ses *ses = io_parms->tcon->ses;
 
@@ -4897,8 +4898,28 @@ SMB2_read(const unsigned int xid, struct cifs_io_parms *io_parms,
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

