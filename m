Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793755812;
	b=PGws9IQZiC/IBubGpirH/BI01poZHCOsDmc1WOnJyzlanno9Fy0RWYidDfRmFCHhNiyS
	 PhZrWo9klEB3t2SdTaI+r+3seeiNgkdVm7MPojuxmevfnCYFmsGcWmfGJQk1mFOiYomiV
	 NaJ6NmdIpAbG63JnFEHQVsbD1E1jv6th58/anSzxtLL3yUsibtIcV2YvlrHE0H+g9Qgvr
	 KA0yKrfSheseIShAm/E4NKOM8dgWU6sQGKoTotPNEcfqsiy8gShwPvBLuT1wywmIa7PTY
	 UK6tu3/CZbVgV5Di+FTQdJnfDJt1eemxKGGIfTnaCpysTo+nWmR9hRB7opCmdiTitnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793755812;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mq9W8+mopPoy2RYlHqt/7jeVHsml4DUHO1yiTVxZYMI=;
	b=V2n8XQ23QO4M4hG0Q9mW90a0eNpQCchZa/pWEE6/IksByE1MD1DxdoH7BRYZdMQDUvFa
	 fzXDqJeVnC9vUSUWJMJYDOELSgkmjk+i8PRN8WtmWGX/HLJmOzffudIU31a3uXgKwH+D0
	 P2/+pQXKwp8rHlRTWm5EVEIhhrfHl7RZjrpgwjBeiMv+AwXFngx/EO59fkcelNA5Rd412
	 n+MVlae8yBVAAumOIy4r9FmRDeYtNTqYSVhxlQgP/30AGx/kF+bQbo8EdyutSTPxtFWM9
	 BPzotwkEHetCJ6R9o0PCuU3gXN43fYZawsd1z3GOl6e26c3xCK1B5vDCv+fg77JO09A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3ceTOBL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D081606A32C
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 01:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3ceTOBL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2421F00919;
	Wed,  4 Nov 2026 01:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793755811;
	bh=mq9W8+mopPoy2RYlHqt/7jeVHsml4DUHO1yiTVxZYMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F3ceTOBLkEe1Xlwqi1rEGBFdVaQrBahtOYKVi9EDWkcW2QYjwrZS8fj0G7JrlafRT
	 BjgzZBbPS6XYB2FgoqeGV9+POKDHoRwPO95nNBfOMFRVnj1hW4Jn63ugJP/nuQDcgg
	 tvCkYar+LjfPhfFJzRpiwlU2gYbIyzHqINzYFEy6eRBT9youh7scymZzdOyFzy8Xia
	 pbFjmfd0K5FhtMMrGQACsP3loIar4DZJXUh5ZV4ZpmK2WVDxKwntVx0kJjERigaoa9
	 ubqFs43Q2Qc38jql/uoYPq91PM39FIcx1zK80IRNCqkiBIHUncbaC71hXinWj6gsl/
	 4fcGp5L73VO1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: fix out-of-bounds read when padding the final compound response
Date: Tue,  3 Nov 2026 20:30:09 -0500
Message-ID: <20261104012843.1953109-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110343-corporal-pang-fc06@gregkh>
References: <2026110343-corporal-pang-fc06@gregkh>
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
[ sashal: Adapted buffer allocation to use work->conn->vals->max_trans_size and GFP_KERNEL instead of the local vals pointer and KSMBD_DEFAULT_GFP. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 4c42205fe5261..68309e6f369a0 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -532,7 +532,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	struct smb2_hdr *hdr = smb_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
-	size_t sz = small_sz;
+	size_t sz = small_sz, pad_sz = 0;
 	int cmd = le16_to_cpu(hdr->Command);
 
 	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE)
@@ -554,10 +554,17 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
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

