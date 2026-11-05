Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793898844;
	b=OetqfhctTHnCKFjfujtv31GIV3UUrh0Ru9TdNbRoprGKqESpJeQwxytJyWrrSv12/iBP
	 ORhEUQAwTtF6yN2kLvwHiOnDKLRgHIhDu0R9b1gD3K7Qqi2dAf5YLiSVTDx+vK34KTmN/
	 HHs4R6yunfrjq9ggWRBFlbZZo2kl3AN7+ST3JJJeYoBHTHUk085XmqBalzljyrbnd8ukZ
	 W33kX8GUSynVmFhdGpk+iY7SSbuHIawNiPRNJS1eL04+UskEZVJ3fvr+wjnl/Lja7UsNF
	 HtbimG3dQ3piEYhw42q8rayy+OE5JaVM+IDIBwjL0QhxaJnHwGOSdHBBZw3AzwNyK6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793898844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mZnJs2FrhzMu55lCfGJCBqrL4/6mY7+rmeFNzwXpvhM=;
	b=LUD1ySjaqjrV6MDXon3WJ1fwN3TaV3zsz2t0JzNLul9/Z3DgExcdMBJ2DbtpTtczpc/I
	 f4g3ofuGkQFlRq+FeZRjPBPjz6bn3z1gMei5wpKVQ9mPV6up3X2U8vODvZSjVUIT3d1Fn
	 Y+1nwxg9t6V0Bta4k8CgZiqE6T83fKWpVpx1TIQirC9EF/0PJ6PWNeT9JNolxPxzQQ9XZ
	 9RsDrdHvtLByVzapkNbudmRrRuqDkIDEAeXtsifCnsHb5IGMyxpIBMuTz62lRdYZMT4QR
	 iCsPFpBywwTq+tNiDmwjzI/cZA/oKpp4BnZ9G2WNmlk0WVp+RksE3hICe9TmIj0WN0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7e7dqIT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5BC606D808
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7e7dqIT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E61D21F000C1;
	Thu,  5 Nov 2026 17:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793898844;
	bh=mZnJs2FrhzMu55lCfGJCBqrL4/6mY7+rmeFNzwXpvhM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7e7dqITnKxbR+x7MNjmmbgrtCONbtuNBP8lSOidLt9gWrqAVXDCSqD6RMaDX+pa8
	 NuZTIHp/QtnYPrfXn5TIht6o/FvvIOEa1X6kD/oAaW0g+jBV29nceqZa7DbbTMSLrq
	 gzpzJr5mFjIaKurMX/W4bQnrPse1tkUJI+3BMqGHdZU5vQ/5dt5V+reHmKJ9LHe6AV
	 ekEKM0LysdFSGCy8ZI/JLO/cPyEfr1yBlO2JR4cbNHGR1KxuSLLR5B49FWHb8Dv8Gr
	 2lXOE5QAMs6WTmUszkow1zykoCkTwnJ4yTjc8KQ7vonoBEqSUQEMofetF4FfP+/qq5
	 mubcn7p9HjNwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Metzmacher <metze@samba.org>,
	zdi-disclosures@trendmicro.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: smbdirect: fix buffer length underflow in RDMA transfers
Date: Thu,  5 Nov 2026 12:14:02 -0500
Message-ID: <20261105171318.2151915-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110437-bully-enviable-15b3@gregkh>
References: <2026110437-bully-enviable-15b3@gregkh>
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
[ sashal: Retargeted the change from smbdirect_connection_rdma_xmit() to the equivalent smb_direct_rdma_xmit() implementation. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 585617595727b..be26c2e569e57 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1388,7 +1388,6 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 		if (desc_buf_len > buf_len) {
 			desc_buf_len = buf_len;
 			desc[i].length = cpu_to_le32(desc_buf_len);
-			buf_len = 0;
 		}
 
 		credits_needed += calc_rw_credits(t, desc_buf, desc_buf_len);
-- 
2.53.0

