Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735342;
	b=MTXnKXsP50hdo3L7R7wCk57KcofKF5GsOw2kcVbT0A6wv9peSW0Isp1kw+WvPKXnhZwD
	 6xLb69tBh5Mh/OqgPzB8OQTO7oyXbfrmLV+gPzP1Yw+JIOQQnX7iDV2GjA1WRD2Jbolv2
	 s9V1HlTMUR+cAYdb7KDpb7Vt4cP24zCeTauQv7tuRVFcJn5eBS4YUIAhMYXVDimCfwi6n
	 9GMBGOQmkYRExcgCjMddoHb+kKAFcE26JHa0r1JqcKZValO6aawRnW360xrVRA+nrxENA
	 LlFHzvlunXIRWx5zId5IZGylM5+2ChgCeDzaVLs9bPcjhbn0pF9nUeGKF1CTqe79e3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735342;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nuT9VrRFVipCnkJlP67E6HGAMPY0o6hzJ9QLOxqMj5s=;
	b=XtqKAeVqaz9trL/2vqcQzYjUtUP2OiEaiaG0fxtqUBJjuSuTBmBDkiTqneMqJR1aF/Qe
	 N8IOGpUmUxYfEBCSwjNjgKYJ9lBJENzU2qMB/hOcyz2KNAbTRWJKi0oLCN7F/1xg0YkuH
	 Wz6ILsmoS6wyz9z7BFnZST5CiF7wLBMe4kTIrc6pd/FH2OzXskFks58pukm9T5w8kXY8s
	 Au6o+mGzZXSTgFLHRd266xNwmKJwvj0QMST+Dr9WCAl2xFCvVbP4Ov2JPxkAF0iTndHiz
	 yjUYYvHYvMMVhDskDKNT48eGGvZHcS3yXvwdyLftHMId1GcLh6coNrgFLS+7dQPxKug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcuXiGqU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADA8606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcuXiGqU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2C271F00919;
	Tue,  3 Nov 2026 19:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735341;
	bh=nuT9VrRFVipCnkJlP67E6HGAMPY0o6hzJ9QLOxqMj5s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dcuXiGqUPuWs788AbzAKdctoy4aJkCgCDU2JDY9WP8ARanNX//tCi77t4T/OkbDiQ
	 8IVwS+1NlbxKPM/uKUODCbpCOo5WY/IomPmrt9KnwzFRbLRAcd/ug4j1jP2IDJD4SC
	 TlXoTOX8mn/bQ2AwQrmVFjoeGY2VQqJTkwWnL4VhZgQbmOsUo+9l4v2Cg6ZkjJ2SyQ
	 0Tul7cwhlCinM5nHBr94YdiIG2h/Rq4s4lqsLP7bRCnkTdGtrd+4bTaD9LEvy0mjSj
	 RiFr25h0TaI2dC4j7wLYGkabMh+12BCmT292k4vhGOtqRDO90V9x7W5xbWJVs1BE4D
	 DYNW+u7lrvysQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: fix out-of-bounds read when padding the final compound response
Date: Tue,  3 Nov 2026 14:48:59 -0500
Message-ID: <20261103194749.700441-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110340-sadness-alienable-ddc9@gregkh>
References: <2026110340-sadness-alienable-ddc9@gregkh>
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

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 714f27729121d59f103ca4dad7b0c2d1c125cd71 ]

Compound response handling pads the last response of a compound to an
8-byte boundary by growing the final iov and the RFC1002 length.
smb2_allocate_rsp_buf() allocates exactly response_sz. A command can
fill the response buffer to within 7 bytes of its end, for example a
QUERY_INFO whose output is bounded only by the space left. The padding
can then run past the allocation, and ksmbd_tcp_writev() reads those
bytes when it sends the response.

  BUG: KASAN: slab-out-of-bounds in _copy_from_iter+0x744/0x10e0
  Call Trace:
   _copy_from_iter+0x744/0x10e0
   tcp_sendmsg_locked+0x2290/0x3f80
   ksmbd_tcp_writev+0x10c7/0x1ab0 [ksmbd]

Allocate room for the padding when the request is a compound, as
smb2_read() and smb2_read_pipe() do for their payloads. response_sz is
unchanged, so commands still fill only up to it, and kvzalloc() zeroes
the padding.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Adjusted context to retain work->conn->vals->max_trans_size instead of vals->max_trans_size. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 793c219b9a610..8becc30fdf835 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -539,7 +539,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
-	size_t sz = small_sz;
+	size_t sz = small_sz, pad_sz = 0;
 	int cmd = le16_to_cpu(hdr->Command);
 
 	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE)
@@ -561,10 +561,17 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	}
 
 	/* allocate large response buf for chained commands */
-	if (le32_to_cpu(hdr->NextCommand) > 0)
+	if (le32_to_cpu(hdr->NextCommand) > 0) {
 		sz = large_sz;
+		/*
+		 * is_chained_smb2_message() pads the last response of a
+		 * compound to 8 bytes, which can take it past response_sz.
+		 * Leave room for the padding. kvzalloc() zeroes it.
+		 */
+		pad_sz = ALIGN(sz - sizeof(__be32), 8) - (sz - sizeof(__be32));
+	}
 
-	work->response_buf = kvzalloc(sz, KSMBD_DEFAULT_GFP);
+	work->response_buf = kvzalloc(sz + pad_sz, KSMBD_DEFAULT_GFP);
 	if (!work->response_buf)
 		return -ENOMEM;
 
-- 
2.53.0

