Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793745598;
	b=OB57VahxXWccF+UQnTXg1eKNRbYScRZgvfiDIOFf4OXdTYNzkD1oy+vmwvNIIKmtORcP
	 o/NiNl8yiaY8zh8m72Fr56lmDyz9Py4OLU1Pm0Z8w9xDkP0DCDNmEwXQB0tdy09EzdPvm
	 U7hPZQXO2n06K8kokvBUZmam1bDy3ZQxwLtsOg3X8Jlw31TApXmbOV4iGkrtSyy4wSwVo
	 vAg49vBsiXfZStKBcCjYPHfDx57VHSoX2mLuHqIXaU7vhB+YpK5P1pLmCfGD6I0HaSVwb
	 w75pDd0q6jIj5LvchATeKkqyCzUyD/21Uv11x0VFSXYP2ZKWvBAzUkW0giY0cOrHxIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793745598;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xQtCebo7YacYA/pqqCBx5V6g1CGUMugwEAbYp3/9NDg=;
	b=VVOggj+15I3MyxQCiMzQub32GDcEV26fFLNofXcWYZL5WIgyUwyyqk/pPv/oR1qKCW4T
	 xgmozrTtmX2kp+5vaoccoyPg4ax4uxrNO/GXPcMWz4YeGJBTjmVad+Xej4dUGOvValoqH
	 8dqIyYJivJ8LBh/InamHQWBV1gbDTbSMJoIiDiKFpKz8i8NrY7EwtnX2CRqW1SpsZRvEc
	 yFPItu7io4qimKGvbOb25nKQ6vokWr15l4WhZccdcsJlbgMd9zpqPT1GxNsuCW5TM0URe
	 3ikN5nCDWBlM39X3UjZD29znX420lfiy9MeB2s2+ivml7Vui+R2GVMfukjGokcO9Udg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRQzkIDl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF211606A33E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 22:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YRQzkIDl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56BE91F00919;
	Tue,  3 Nov 2026 22:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793745597;
	bh=xQtCebo7YacYA/pqqCBx5V6g1CGUMugwEAbYp3/9NDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YRQzkIDlSaFkkCW7rjW7D4jlRlyb0nPQyOcorrhEVo5P7wYpMWyuF+4rQYNybPiMJ
	 vzhbn5HO/+XyKNctLCwZ+vlEzQL+X2BiB2FeuOXnAB4bGVQPX2/cJl2venb807pBNA
	 2Bg0fBFK0s/fXhJoEEsa3DcSSGYdy0Ovg9pmrnt58HZUtIqIU3PJf1URCIbLYRbL7t
	 hLbPNJLvbC1mP/ptp+SBFSAc+D2zJENlnr0BK+6lKR4SE0fmkBDTvO2BVyD8YLjP+Q
	 X2tduogaB0J4JDg6wDT9WXYfoUPgOFAq130hkE+cBD1R40f+/8QFbBefSTf9mh6kKE
	 JFCUXlz0AS+ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ksmbd: fix out-of-bounds read when padding the final compound response
Date: Tue,  3 Nov 2026 17:39:56 -0500
Message-ID: <20261103223845.1550564-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110341-crispness-repave-e347@gregkh>
References: <2026110341-crispness-repave-e347@gregkh>
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
[ sashal: Retained direct work->conn->vals->max_trans_size access and GFP_KERNEL instead of the local vals pointer and KSMBD_DEFAULT_GFP. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aaccef2e3f3bb..258fc9aaaaa7a 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -538,7 +538,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
-	size_t sz = small_sz;
+	size_t sz = small_sz, pad_sz = 0;
 	int cmd = le16_to_cpu(hdr->Command);
 
 	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE)
@@ -560,10 +560,17 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
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
 
-	work->response_buf = kvzalloc(sz, GFP_KERNEL);
+	work->response_buf = kvzalloc(sz + pad_sz, GFP_KERNEL);
 	if (!work->response_buf)
 		return -ENOMEM;
 
-- 
2.53.0

