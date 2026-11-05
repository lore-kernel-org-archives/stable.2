Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793908247;
	b=ChLFqhPAVNncFXDb0b0Eo2padw+gZ70BRW9GiAhFd3f40G3prCr7yVa9/rD9Fxfqgohh
	 7ApFsXzopEWn6q42EydaSKbLdmpJbbDZdyQZ7TgNE2/o1k80x1atT65rTQLRC0H/DBRPk
	 6KFkJ85AlROY4Ul7fU/wmkV9eCplu2dm3hjwC4PTNAnos8smjYvk0zGC3Eqkh6uaoQEce
	 IaIkwvvoFdwSbFvoG1Ohhj2u6sBZ59pO+Iy6OrrCqorCCdD+oShYODp3LD0ucBBVrSDoy
	 o6Jee+NsA9OahhT7DVePf51GuzMpauHjCKp3k8Aww00SGEWISFrJf+3WEJPiKJQtxFA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793908247;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x2mOngy/wHu0RAYPptPdRBYJfKSrAjAwA4JrgGQjXtk=;
	b=NYzxqitDVgCn7qch+NPew/MeYi2+UmOTlP8MralE2ZssO8y/YrmBtUReObRJUOFQG2uV
	 Z+dsEdFjo945r5Dn/4rjamN9tqZ+SThyfyKX16iT+1JlhKp8125+u5AnRkxmjtE8rQPwH
	 F9TbzCU4HxA/JvZtaugJ4UnsyBhfl+ivKpS5J7vwWfns1Bopu1BvRo1OXbsCiO8a2YVZS
	 T6t7bYssZyAKeEwpp/+S3tt3eMN9k/8t3mI8/vPpbTUiG05wIakGHV5siRAs9xRh9C6OD
	 ueGIc+jCSD9T57/2I+JELmkIrQiH9yn+KwD/prIGka+MGq1uUfqBhEwOMvd86L8X73Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGF6fKoE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD20606B9C5
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 19:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGF6fKoE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560951F0089F;
	Thu,  5 Nov 2026 19:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793908246;
	bh=x2mOngy/wHu0RAYPptPdRBYJfKSrAjAwA4JrgGQjXtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LGF6fKoEkQBFx7Hr4j9gTsglJ6ZCxh7iG9NBTQxEGU/OrMUvn0E+9hjSuDE2nANqt
	 Lx6Y/QXsFqSpFLDp5Sufk/6kZtAC/3+9uhztlGQDwr+JhK4ed/Ii5IbttcdF39zfkZ
	 He917A4KTxsCCfjMsYLvs6FxwEjeAUX8q48lz69QnO09+YnkkVRsGLLtMykI8ojCGF
	 RmTwSyXKu6H6wH3FGgUUUBOkeoGJtVFoe6STyU7DHA9B8KmdYEe6qxDcw8CW0TPCO+
	 G/wyrGixtZdmLnih+ozLQ6jsuBcXzwHs9mNMWKiISaXhbtO7QLbWe0Wbew0YNchTtJ
	 RAp091JxgEH0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Metzmacher <metze@samba.org>,
	zdi-disclosures@trendmicro.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: smbdirect: fix buffer length underflow in RDMA transfers
Date: Thu,  5 Nov 2026 14:50:45 -0500
Message-ID: <20261105195032.2620645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110439-qualify-confiding-f593@gregkh>
References: <2026110439-qualify-confiding-f593@gregkh>
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

From: Stefan Metzmacher <metze@samba.org>

[ Upstream commit 7193241a49c958782ba4b8df06da3734d1e317d2 ]

When a remote buffer descriptor is larger than the remaining local
buffer, smbdirect_connection_rdma_xmit() clamps its length and sets
buf_len to zero. The common accounting code then subtracts the clamped
length from buf_len, causing it to underflow. If another descriptor
follows, the loop processes it with a wrapped remaining length and
includes memory beyond the local buffer in the RDMA transfer.

A client can trigger an out-of-bounds kernel write with an SMB WRITE
request, or an out-of-bounds kernel read with an SMB READ request, by
supplying multiple RDMA buffer descriptors with an oversized descriptor
before the last one.

Remove the premature assignment to buf_len. Subtracting the clamped length
already consumes the remaining buffer, so the next iteration stops and
only descriptors within the local buffer are used to build work requests.

Fixes: e628bf939aaf ("ksmbd: reduce descriptor size if remaining bytes is less than request size")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-33549
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Applied the change to smb_direct_rdma_xmit() instead of smbdirect_connection_rdma_xmit(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 6ea73fe6de6c5..9986e191e7019 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1361,7 +1361,6 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 		if (desc_buf_len > buf_len) {
 			desc_buf_len = buf_len;
 			desc[i].length = cpu_to_le32(desc_buf_len);
-			buf_len = 0;
 		}
 
 		credits_needed += calc_rw_credits(t, desc_buf, desc_buf_len);
-- 
2.53.0

