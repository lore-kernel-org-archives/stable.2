Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A661F4D37AF;
	Wed, 30 Sep 2026 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779611; cv=none; b=G9oRD3vnyPuM0M+zMK4Q20pqZlMnQkMSTRDEPDJVfV4MNuG2bXIF0gwp20rz/m9iV+rQP9uT6W9LxmlDROsBPPq7iWU+CiQ2mcLAIqBdsAWDKrx29J58m/SQ8uB4LtFv3xVXGKmW+vHVmpL9Voz93QRkyEhByYO0+LBz3EhM13A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779611; c=relaxed/simple;
	bh=kswHw5PlOavyVu9sX+2FIjeHQkd820wCPvgYvViGwes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V26LbtDTfT0lub5zO0qHlMyK9icJSlojo5UGHFZ+6FVObIz1qBtq2RzKiYZ7gToMo8KSEAs/XU/0g5+K0gxDAcvH6L+a9GzhixOWVgYB8TJlNx4tWZ0cJuyah2cNfm1Sw8nzBR0UxQxPCOVwsGTtx1BQkXXtlaBNwnyjXvWajfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=N1oIkx1x; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="N1oIkx1x"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=W6lyQbGYfBeE4NhAuV65BFxWnXPhigQq31NuyU6nxwM=; b=N1oIkx1xqgX+NjJxrbXO8UCC1c
	3NeFzhhIO1kARo2pJV/T99XhlimvmfIIfOqqQQlBFP7ZmdM/s10NRQPCxDoDE/IUC1/lRYhSP4pld
	w1K8gOrcxvmFwoIYtFEqrYSTYfun2+wnFPsrtnZ6EIi8d0I/T0z/18RGOaIrGjZKRhA1mkrXPurbW
	VCHbpwsDeJl9NBUdgN80/NmSU4Y9LLlXg7CrQH8Q/bSq5DJVRwKHk5hj6NysZLmPsfKhwsNPSOnXC
	0YtEFYAfY4uE4hTYeN3rejddQ4Xz/kqzLNFYsWDSJEEWsTdvoI+tlIUGLYQMGrx2ZclTzIHYfyqCn
	WfaUKSLA==;
Received: from [151.115.150.205] (port=44742 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1xBvZu-00000005QLT-1FW6;
	Wed, 30 Sep 2026 16:46:35 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	netdev@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>,
	stable@vger.kernel.org
Subject: [PATCH ipsec 7/7] xfrm: leave the sequence counter unchanged on ESN overflow
Date: Wed, 30 Sep 2026 14:45:24 +0000
Message-ID: <20260930144523.435271-9-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20260930144523.435271-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

When the 64-bit ESN counter overflows, xfrm_replay_overflow_offload_esn()
rejects the packet and rolls back the stored counter. It decrements
replay_esn->oseq even though only the local oseq has advanced, which
can later induce a reuse of the last sequence number and the
corresponding AES-GCM nonce. Both IPv4 and IPv6 are affected, yet,
processing about 2^64 packets under a single key is required to
trigger this bug, which is highly unlikely in regular use cases.

Leave the stored low word unchanged on overflow. The high word still
needs to be restored because it was already incremented.

Fixes: d7dbefc45cf5 ("xfrm: Add xfrm_replay_overflow functions for offloading")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/xfrm/xfrm_replay.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index dbdf8a39dffe..12457d97c819 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -721,7 +721,6 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
 				xo->seq.hi = oseq_hi;
 			}
 			if (replay_esn->oseq_hi == 0) {
-				replay_esn->oseq--;
 				replay_esn->oseq_hi--;
 				xfrm_audit_state_replay_overflow(x, skb);
 				err = -EOVERFLOW;
-- 
2.47.3

