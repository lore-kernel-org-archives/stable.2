Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669F647885C
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789071; cv=none; b=On2SBoEsMYvpnHREbzRzCKQXf4jkFEvU+AL3laEDyTqC7aChWDasUcAbzATKU0BHdYdDhPObvIXy46SC7s7uCit9UeKcMEqChitluoixEFh5rgiwOkVxrBWUqG5WOc6wHe9lMxoKY6vbvv24Zzpctu+ASCU1HmoPNK6Tg/GMx5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789071; c=relaxed/simple;
	bh=H3IjaBVbPgQc4DacTLepcVxwgLjZbKjJ4XgwW67M2V4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SaHKYcC2pB2rLtld40S5tyl7t0ejR/HOd+CEtD9zZY2vj6Yy8I/bnBkN+jnE9zwp/OdGIx5oodmh04NRi4FX5vp6NQa8LBqGElmuxtSMS8KYgmC2sOI4JPeh/OL0tvpfOhnGG4D4o6h8384kzUF49ZNHpaeqzUfSjdeSGJ84mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZIDyGRa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZIDyGRa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA2CD1F00A3D;
	Mon,  7 Sep 2026 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788789070;
	bh=za7jL6algkUylfMS/L7ovCw1j4s35KOhPLwti6Ct1PQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KZIDyGRa4ICy78I178C+m9RRiHiMtRNpRKd7144DTdHx2F85RzvxaYqJeHlZH7qbz
	 tM/DmUH2GiWZ1DiAHV8JqelXULzWzZwhIduQwjzx0RLk/ZingakQMC4/0UtWPEFABE
	 Y+Qm93yJV+nBlh6rIBh6PhDeGRHkmm07iCaLQpg8xer1P9AQ4gV5eLpArBzQND3SSe
	 OHQdEUaGWnQQCT/M+MqEX4K9wMlVJRvHvrhIf3xKn1rsdtf6XY91VpOk15DYMHblwp
	 3JI/hDNALVlJV3co8KSkeT/3ioVVkwFPlzOyPs+9lSi7ZKhrjGJod1PY003nllN8hM
	 7tWQJdQGzRsZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Sorenson <sorenson@redhat.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] smb: client: fix use-before-check of ReparseDataLength in reparse_buf_ptr()
Date: Mon,  7 Sep 2026 09:51:07 -0400
Message-ID: <20260907135107.3103249-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907135107.3103249-1-sashal@kernel.org>
References: <2026090314-shower-guileless-2d4c@gregkh>
 <20260907135107.3103249-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Sorenson <sorenson@redhat.com>

[ Upstream commit 05f78e6cf34ea3a285053bd5999e08e8ac298bd5 ]

reparse_buf_ptr() reads buf->ReparseDataLength before checking that
count covers the full fixed header:

    buf = (struct reparse_data_buffer *)((u8 *)io + off);
    len = sizeof(*buf);                          /* 8 bytes */
    rdlen = le16_to_cpu(buf->ReparseDataLength); /* offset 4, 2 bytes */

    if (count < len || count < rdlen + len)      /* check comes after */

struct reparse_data_buffer has ReparseDataLength at offset 4.  If a
server returns OutputCount < 6, the read at offset 4-5 reaches past
the end of the received data.  The off+count bounds against iov_len
were already validated, but that does not protect against count being
smaller than sizeof(*buf).

Split the check: verify count >= sizeof(*buf) before reading
ReparseDataLength, then verify count covers the data region.

Fixes: a158bb66b137 ("smb: client: optimise reparse point querying")
Cc: stable@vger.kernel.org
Signed-off-by: Frank Sorenson <sorenson@redhat.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 927c9c800604f..37ad67c417f2f 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -55,9 +55,11 @@ static struct reparse_data_buffer *reparse_buf_ptr(struct kvec *iov)
 
 	buf = (struct reparse_data_buffer *)((u8 *)io + off);
 	len = sizeof(*buf);
-	rdlen = le16_to_cpu(buf->ReparseDataLength);
+	if (count < len)
+		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_rdlen, count, 0));
 
-	if (count < len || count < rdlen + len)
+	rdlen = le16_to_cpu(buf->ReparseDataLength);
+	if (count < rdlen + len)
 		return ERR_PTR(smb_EIO2(smb_eio_trace_reparse_rdlen, count, rdlen));
 	return buf;
 }
-- 
2.53.0

