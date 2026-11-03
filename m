Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725070;
	b=HvGjUOMze7aH2a6JzzM8/5DL1AyOvfApX6GuhqIZZSLXGR2r/MFMyrCoftvq53ZlNZsc
	 isAq4RlzDfX7Mp5ZcpEZI/3CExH4Acui/bsP3PV5N8gbaq7KY0WjFwaD1vy/VLu8joncR
	 YJq3cY/jdvqvZci0QcPTxcST+MxtQN0iZj9OLapQqr8dWBJ4OHwq5PYUZnMzHM3IQYUe3
	 EcZ+bZBD5ejvKjacJ8IrHIq8jMWj817a0RXy7/2vT4WGpdg5i1rLCbUp6RhFhIJI/5COp
	 RU5d8Ne8kndGjlWE63hXCIguvujcPu4dGyfJVxKVpQo0pShqTAgNa6X4pOLDvKyrFZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725070;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ItrjoZDzo4cAyvkXxLCg9/VMNDCt/+Rq+2z6cSjiMz8=;
	b=1lbhrB5nijCxzTdsNhsaqeUuhCMcOblN7dta0gf1K3PiIofMiYjcC0yziSgdYftguRth
	 LxyzC6Z+MWMO6jqsVfXblXcHISUC9DULJ3zILBpnVr0E5dGtPxOZ/DjY5tN9zLknK1pw4
	 7JbbNiUDshYpZmhByrJr5B4ruST+QjZHobtPwNGXM1dMwctX2aeT1ZocrPrlq/jV+nfb3
	 BamLb305xQ/ZrORc1tguTczc6uAVKAJwVKed/icu5hUjHod7zwEFWt8ejv8WNdPufiSfD
	 PAiziwcq12ABer5FJBS6MaMXbzWewpgqNQBjLc26n2Rdqwsi4Ex8FEGziu3kPKLebig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3B7IPFc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DC606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3B7IPFc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0E31F00919;
	Tue,  3 Nov 2026 16:57:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793725069;
	bh=ItrjoZDzo4cAyvkXxLCg9/VMNDCt/+Rq+2z6cSjiMz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V3B7IPFccptuStWGhM6yU3L+ZSXeel+0Jn7yzCLZ3Sm9AsCw6PmcjRCz2PosRmwU2
	 vXFZTJpnemlbZL5QTMLlEp5iT8t/IdCieaIOj1cPQLsr1vH96v6+r0ifAFR6ZqNXLa
	 SvkmCecToBVwXIDtqxAnTKNbwIDlMazaZY9NHzpUIcy4UcjURsyvTKR3gjxpJBkC2m
	 Op2XTbUkbmSh3jFli2b+dJ9P0pZaA7wse42YP6ixBqOZXmA/qQuraXGr5gb8OMxRK/
	 hznqN3Y/oaGxzXIHmOFFosheMv64wKbsbjl86KI+I+EFUJEKmYtKIUCKgTr++girWq
	 Dkb8QiDj+g20w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/2] ksmbd: fix out-of-bounds read when padding the final compound response
Date: Tue,  3 Nov 2026 11:57:47 -0500
Message-ID: <20261103165719.643173-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261103165719.643173-1-sashal@kernel.org>
References: <2026110339-undesired-vagabond-3610@gregkh>
 <20261103165719.643173-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e5bbd003e3599..fa1c8f613ddd8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -876,7 +876,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	struct smb_version_values *vals = work->conn->vals;
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + vals->max_trans_size;
-	size_t sz = small_sz;
+	size_t sz = small_sz, pad_sz = 0;
 	int cmd = le16_to_cpu(hdr->Command);
 
 	if (cmd == SMB2_IOCTL_HE || cmd == SMB2_QUERY_DIRECTORY_HE)
@@ -902,10 +902,17 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
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

