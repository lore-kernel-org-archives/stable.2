Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620088;
	b=K322t7LnO3ITHYgnTgxtaedwUuxXDSU53epDcIphkQQ9vUVXDRa+ZbTkuVEN19uzzWzV
	 sXXLB/3dXs4/epkQqEPuu50RDXe9XOXBDtb4c2pogLTl1m77igpaL1F0618qYQEYuR2gY
	 9zMpAYBkmHmKa1jExhYcv1ZUD/0ObYyjcDPIR6pLAZWQSq5jFNbxjAkQ2tcw5VgsONfM9
	 F+6dCx+ye/Vrs6EBr9EFNbk2gQbCFzsd/XnskcW9ANfqEIUqFZaGaFTknP9lrYwC0aEkZ
	 HpbN06O13uM+XBqiglkiqd/yWSZF4ygVICVDfy4uAPUqkadtp4/+AHPVJISLXfbyUBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620088;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZB67s8Y7GKkWSKYiIsyMrZLLJuokDvAjjhx3SyY3v3M=;
	b=ooAEbmfjexPQBEy3mV/qC+NFho7uHDjd2B6Z1/k/DQx8D9GkCNrVFICMI+G0F5J6C/hm
	 7z8N5rKaGtsO9rqgMMKQ1zzxuZvncFBvSXCmmNQX9DaT6tDB2IZCO94lQ550+5Fp67NsL
	 02Jc2I7cOvs/VBX/RxbTNiWy/9agoBGBEoZozV8kGoEGUGo/U5CvRW8893z51739cO7vh
	 zUErsLO9SmUXUiw8S/Pec6Zjfl6UodBVEzv6a7J5qIN/DNcaQycgyFC9DupBmTIHlGM09
	 lAkIPX2qe3XM5FsnDYKjvd/7xbWO8NutyXNrUiw+OEv/ERAiD/TGqSFCTkX4hTCxTTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bZ/oZVhx";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7FB6606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bZ/oZVhx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741DD1F000CA;
	Wed, 25 Nov 2026 15:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620088;
	bh=ZB67s8Y7GKkWSKYiIsyMrZLLJuokDvAjjhx3SyY3v3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bZ/oZVhxPmYCUEte+vyotZAHb7XCHvc7M8fG/Ioaf0BGk1ks0xy2VjEPQfPrnrY3h
	 p17J6MEUlVDTczYbgM4gCXyGvuTn/Vu1NmWsRpt9F0VSkMY6hhXHn3/W1pL40RYkqq
	 6QtTdt6yPqGrpeqtyzzv5xecRfEgY1x9/WE2b+FcN3BO5tPmnpNf7bH0w7r3Jjlw9d
	 2+LIJ/VLOjOduTSW9dlgUMCviauafIoldUd2TYLumtRx9LPIKk+sW30cR2nibWJ6HZ
	 FlMfbDlaDc1z2qV+wRYhoXU0DDBrLExWUuLHM8PxgjdL2/cwB3VWDnYFu42hVbvS/y
	 j3xxjF7lj+upQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] xprtrdma: Clean up synopsis of frwr_mr_unmap()
Date: Wed, 25 Nov 2026 10:21:23 -0500
Message-ID: <20261125152042.30755-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125152042.30755-1-sashal@kernel.org>
References: <2026112558-goofball-gear-57c8@gregkh>
 <20261125152042.30755-1-sashal@kernel.org>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 9d53378c2c145991fb5bc986c82eb9030212c2ea ]

Commit 7a03aeb66c41 ("xprtrdma: Micro-optimize MR DMA-unmapping")
removed the last use of the @r_xprt parameter in this function, but
neglected to remove the parameter itself.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Stable-dep-of: 1fa415883c37 ("xprtrdma: serialize unmap_sync with xprt_disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index dfd8007540c7c..89f51b7a311cf 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -58,7 +58,7 @@ static void frwr_cid_init(struct rpcrdma_ep *ep,
 	cid->ci_completion_id = mr->mr_ibmr->res.id;
 }
 
-static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
+static void frwr_mr_unmap(struct rpcrdma_mr *mr)
 {
 	if (mr->mr_device) {
 		trace_xprtrdma_mr_unmap(mr);
@@ -77,7 +77,7 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 {
 	int rc;
 
-	frwr_mr_unmap(mr->mr_xprt, mr);
+	frwr_mr_unmap(mr);
 
 	rc = ib_dereg_mr(mr->mr_ibmr);
 	if (rc)
@@ -88,7 +88,7 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 
 static void frwr_mr_put(struct rpcrdma_mr *mr)
 {
-	frwr_mr_unmap(mr->mr_xprt, mr);
+	frwr_mr_unmap(mr);
 
 	/* The MR is returned to the req's MR free list instead
 	 * of to the xprt's MR free list. No spinlock is needed.
-- 
2.53.0

