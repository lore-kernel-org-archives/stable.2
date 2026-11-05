Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793904191;
	b=eod/XIfx6Sj9sLEhwhgsuEyvB7dGKGINByJpp90SZuUM/sRLin043RZwp79W6GLNMvRI
	 lFJXOqxvJZTjoG575qx8aC6PanOn6nM6jh6Kk5fSCdn4taXEyRuciHr2conlNe/oJVz3F
	 XgREDaA2y01k7HuhsmElumz7QeMBo+L4995VfGadsLt+bfDAYjq+3IBkG2A5xVgKLESLq
	 bCe0QKcHfa10GB4+R6rqCObt9LRyuL6iH0qMpsCwhFwY9oKQiQP2AN/+PvprKzuGCM7W0
	 AHooaqKDdrUKlSL4qSwlsFoQZ/uV8y9nBYR+MwZdVL7EII4fa3BJIV1bsKCLK5u51Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793904191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1dXwLRfzFdtjreiqQITo2GOItonoXpD1SE3jqxsvQvc=;
	b=xQVOX188Q3QUq/RBZVC8FzK4+UCWjz8ZOYHTj540clIj3Kl4YXsZNdkvS/hu17JIVaWn
	 mCgaxVMjGXLQJL53I2xWsqeUeD6pVyRLmhu/oItzokm9Lpnm0yE9YRpZvdwyPnU9Jn6n6
	 cDt9mgEs2xX7QLNR0j3VsklD2V7IMPivC/hP3fI3s1bPREtWIKGjehN4AY65t/w/12iwl
	 OkOyuPQWtshusMHbNaYsRcO8EHM5nzK2G70C603HUqSDklrli4JtqataAiWx5IDzp9lCL
	 5AzD+cSFGH3hJfGRVv0/mOVrzFaW5uB7ouk4wSWGyw/kFZEfVtvFzUmLe91KLakFGjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGdND7CM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B953606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BGdND7CM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 880501F000C1;
	Thu,  5 Nov 2026 18:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904191;
	bh=1dXwLRfzFdtjreiqQITo2GOItonoXpD1SE3jqxsvQvc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BGdND7CMPSi4Phu1CyXKuS96mQ5SV1qPG3wzsdXBAWy/cZR/PsVY1hVKpwsUr0pqo
	 9Py5ysl11K2mQosPDI5ydkRvPS4AapfV4HxdeOKhQ86yHIs3MJEVcGZMhdDpkUzV/A
	 4NNoebmFdi3EViDnGGaI69cjtJQPZxXumxiJr4adT3rgSvcmqf9XOXZGNn1lbwvYK7
	 YddXv0sAQjW1pB10XToqfUEwg7yl4gy3i1RvpmLmG2vbAO/IoO9anoBsbeGa41LQWg
	 yb3RUVKc8rWFr28hLoduC8spfLp7S3BrRRAo0rdTeiVu5CwV2FkjU5thLSBavF6EHm
	 AfFSME+bXa62g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stefan Metzmacher <metze@samba.org>,
	zdi-disclosures@trendmicro.com,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: smbdirect: fix buffer length underflow in RDMA transfers
Date: Thu,  5 Nov 2026 13:43:08 -0500
Message-ID: <20261105184238.2260180-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110438-macaw-walmart-26ac@gregkh>
References: <2026110438-macaw-walmart-26ac@gregkh>
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
[ sashal: adjusted context for smb_direct_rdma_xmit() using calc_rw_credits() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/transport_rdma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index bcf0631ce10a6..cc9409bb5404c 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -1378,7 +1378,6 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 		if (desc_buf_len > buf_len) {
 			desc_buf_len = buf_len;
 			desc[i].length = cpu_to_le32(desc_buf_len);
-			buf_len = 0;
 		}
 
 		credits_needed += calc_rw_credits(t, desc_buf, desc_buf_len);
-- 
2.53.0

