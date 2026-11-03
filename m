Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793741890;
	b=QHqk2CBOfx+/ZR/rnO14xp/6gtpmBgkoM68toH0UnRaMorc9V3PeHZzvj1Tj5DOKT5B4
	 mQcEy24HgO4VAEFCACNfWLezSZI51Sc1rWZ7vdbvxHrFczmffFgGDIagF1hm5OKX2vvvi
	 F0c6usuvikrUoI+cz/K10sBeyLiZpId1WeHc2LTCWsMsfBj9phcOcgqoSXDrk2ph1dl3d
	 5HK5cLYKP/GreP9O6SHLVxQYRUpLx4Dg3gpAZtJ/bh33C1vRlziS0bpw0V1gGk3wdJo/m
	 wDL3/BXUIelz7WmHVE1C+kfwre9bqHyWmVq3wQf3O6ycn8DbkLvicvMVi7XwTnS8Ogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793741890;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oYIJsebjShjBXy6Kx5XS26nofQrnq/P970yM8c0wOsA=;
	b=RdAWl8Wdt10banhxVTdcoCwRiy2afG7Hs6rMZ7MrmozVH1EIEWEWtrMR1MvsoweKxUXv
	 t+h25UmrfyE67QNg9T6dffyPA6VYStLfNqg3ffThMYHC7tkevBblbyktUvH694QfLwILO
	 RvapgVUr8/KZbS0G127xEWibHquNCrR9GHDwjQZIKGoJujGWKGcqGnPuvmpKXkAfFfpVe
	 o71bRS2JMTyrgpBbsNdodAWfsMrjhCKVl6HI5L9C1baQjyHE+OZTmIRYSjd5fBTRsR+9c
	 Yg3Ss3EbM9n2jkaLYB9P4j31WMHH9eeA0XgBvCJBwWVUkbbdUY/yetlPUBOcNa4nNeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQTNaa1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E010606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 21:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jQTNaa1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 396381F00A1A;
	Tue,  3 Nov 2026 21:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793741889;
	bh=oYIJsebjShjBXy6Kx5XS26nofQrnq/P970yM8c0wOsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jQTNaa1Oovfu+lZf1I5Gu3fVFGB3X5C5nWqVcgfIQBP+hbg1ikQyYdKfUB9iom1QB
	 WfSxN3Rp/aaEzGpt3W9PHVYtEbNHvd896JkETq1wk03Zp05kx9ep7XypYEdm+Yng5x
	 J06OVsg0/fZTnpaF023wVXrIXggn41LJRdl1ANdaNJcFRrqgQj2NLFDLay6d2AiS6x
	 TKHqK7tSzud5ZYRXhrDQ3wW5aiy7d7veVZxmzzvDAqHAPzJwapyoGfZsg9v8lZ9Xam
	 AuJ2GqdSpuGVkoDmYHnv7QkRVNVY3YBr71ILF0jE9/W3nYCYJxvlKEnsiGOhi7aFiI
	 /OFpdUIuKTATw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: fix out-of-bounds read when padding the final compound response
Date: Tue,  3 Nov 2026 16:38:08 -0500
Message-ID: <20261103213707.1423702-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110341-map-tattered-4d64@gregkh>
References: <2026110341-map-tattered-4d64@gregkh>
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
[ sashal: adjusted context for direct work->conn->vals access instead of a local vals variable ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 5f752434be3cf..9a98c306f68a3 100644
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
 
-	work->response_buf = kvzalloc(sz, KSMBD_DEFAULT_GFP);
+	work->response_buf = kvzalloc(sz + pad_sz, KSMBD_DEFAULT_GFP);
 	if (!work->response_buf)
 		return -ENOMEM;
 
-- 
2.53.0

