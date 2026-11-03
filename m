Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793750309;
	b=3hv4k2Wal3JGFrBybHcB1M/sCI1w7VR5nXCldh56ha2FRr8B5oQ9BqeUDPoWnvW/dQga
	 XvbTKjULSLF8fIupVUTIpaYs+/hFdBeBvpYCyvz2ht3I0mMuJ09YWZQ/NqoEWzKmJdfLp
	 hcdlqOcPW1JYK8x9ruJVpClBnefeF+uEd2n66CcSKJpgp2KdEX+uiTXK9C3nFVFWEMjBH
	 EhVos+l4cvwmwrM3sb5Md/Pj+w1jsW9D218WgYUa6hhZWsppzeWopZiMMVcXK+2i8rQ6R
	 UG6S+4w1/bLIsK7xw+TbPeOqpVQ+xsFkfAlSXO4H7GedYV/QvGWZsV7SB6bcFQS2BWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793750309;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vzmXPzb1v6u76ej5GDjGqG61iOjw23NI+ksx/l99jeQ=;
	b=LubrdkLbAb+gktACcgcYbwPX+U5/H87atMlIoUTzZ36FN6ttGwHhF5/SwHnh8jwBVEi6
	 n5kmi3BjBqvdAjxP8If6egQL1Ad2YSuH7eCRzeJQIrlaBxdtKB7tpnWZUyK2/5C8/lSzj
	 sEOUlS7VWRwzrMGInIYUJ7x6StbFARWQitp0UNHN+8AXE826/uODP+X/PGgw3YEyw5b0d
	 eeC0T+ger03L70bWM8srROMneA/H7Zu566hT1wpRLp2ESUo0DqOHLoDXCwJFuP1REnrpX
	 mw13QHchIduIm1o8BeBggJO2VKJ4YLNC7+ZEc/8BeY9UKHG3isjzhAiqZeDgk8gZzJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNhw4cmQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005AF606A31B
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 23:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNhw4cmQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1209C1F00A16;
	Tue,  3 Nov 2026 23:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793750308;
	bh=vzmXPzb1v6u76ej5GDjGqG61iOjw23NI+ksx/l99jeQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZNhw4cmQvJrs4muutQKmvl7mvEUsKr/akFF+nakLfeRVIagpBFMlnlZWvhqpCYH/X
	 P6+5mBdr7HxGOkCcqdh94i852mmRf9g44T4EpGIpFBDX9RtIxWezCGhmO7KsThYD18
	 6n5+DVf7kXK1urRDIuOcG19bffeKpiIZnugHBymsNYSgM/n3cx55yac+Y1x5kaX/fJ
	 zEU8/BA/cyXHbHimcvV0j8NEsp1FvmGZW81uumBz+FA9jxeHSZlBTfHKWHSR8ekduK
	 KgRHkFcI3ItNZSRkeOZt6e5C8tVQlkBsr1z/9ENGcvzb4zEjLVNQ4Y5wzj26vlfHYZ
	 hcGaZ6bPTWzvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] ksmbd: fix out-of-bounds read when padding the final compound response
Date: Tue,  3 Nov 2026 18:58:26 -0500
Message-ID: <20261103235755.1655208-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110342-confident-smother-a9f1@gregkh>
References: <2026110342-confident-smother-a9f1@gregkh>
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
[ sashal: used GFP_KERNEL instead of KSMBD_DEFAULT_GFP in the response buffer allocation ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8d2f5e4e9ae3b..08fdf38537fd5 100644
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

