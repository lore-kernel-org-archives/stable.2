Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619831;
	b=GkMCIlHpH8Ne4kbXx5q+a7chmbOdqWTlcf4feQPcpGHrFFWktNqIPL53YyhShx47aE3u
	 DW3oNEr1rck7nPFy5MEhMQZ0DRFpbBbr1+Ix3gO8lkgv2E9avdPdtBpzDeL7DCA0KX7eZ
	 JnQ5lCLr0WW/kYgalGP9+GfpImSJWnlg0WkZMA5UqHf62RIeAe5Wx+wKVMWY2gMcNHcvV
	 E/xrxmgMuI48wy5kR5MkaV+ps/AquvrcFxUeseBKJblfzqsOqL3iTIln992xctIydttHZ
	 sduB87BdsWlU4MvyxLP3fedUU3zvS29sX9Eiw1JIzkuMQ51LTd5MpxIk8QvfFMIr+7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619831;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WRWSlTfct1vF6AGODQ0oncAqleqIAcVZtmm+qaRqAJo=;
	b=1L+NWWDn3ku3cY0CAKj8EByb9lQZAqWjjFEZ55GhFNQxrhmdZjMsT6DUSt2UABFkeFl8
	 0ZGGtKvBKVPnoKeaRbsQ/DibpZbgRUEd3TLKvui6KQPITYr08NpyNG/HQFm5OIErvtIKT
	 3r9qLow5/m/HUh6yOgK6srePtMFhHzrz2AKh/p1FaXoIb5d8SHwK6n4+DW47YO4127IrT
	 z/xGrxaxeT1Igerts9Hz2OvrzqBhemhUhGB86TGT/cjPV6JqE7+/4HQS/X3a9qhL7EEF2
	 GLUPnZq4215ut4Fj8dvb2uTEn0xDfUA83jIxvqweGIkQS3ciAXa6qP4SGl9cLN/2jGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N/zyJUHW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA592606A698
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/zyJUHW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D8561F000F0;
	Wed, 25 Nov 2026 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619831;
	bh=WRWSlTfct1vF6AGODQ0oncAqleqIAcVZtmm+qaRqAJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/zyJUHWNLWszs1D7WOcr8l79bDwKLJgC9S5LnpAmdL66ZtCMaegDjk4j34qT2a8G
	 VYLEIN9zQ/qi/fvFH8M9W4t21x8tpBK9CjUZfmzra8T5dPmd5nLwvj1R+jK29sYhu+
	 astKL5duprRxzCa/qDE3FyeF4Xa9I8B00sGUKWIrtVIIPFTAsVSB8NlShorJ50ie1h
	 5pXKtfNmEIoLvPmngq2HT0TW97SG2a+DkMB44Av008UEf4DltQQZ3l//E1LMivDhLP
	 ZON6T9+gpjIm55WYlx4nHhUbCSCsfcoiX8mOOkMYGjwkYjsh4/N48HEUVArwl4jMEW
	 xHMQcLLOxUmFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Simon Horman <horms@kernel.org>,
	Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] hv_netvsc: Stop PPI parsing on invalid metadata
Date: Wed, 25 Nov 2026 10:17:07 -0500
Message-ID: <20261125151652.51395-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125151652.51395-1-sashal@kernel.org>
References: <2026112517-devotion-snack-1302@gregkh>
 <20261125151652.51395-1-sashal@kernel.org>
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

From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>

[ Upstream commit 19a227903e65c7a9c179156485660a4e017575fe ]

rndis_get_ppi() uses continue when a per-packet information entry has an
invalid size or offset, or cannot hold the requested metadata. However,
the remaining length and entry pointer are only updated at the bottom
of the loop. Each error path therefore retries the same invalid entry
indefinitely, repeatedly logging the error and preventing receive
processing from completing.

Return NULL on these validation failures instead of continuing. This
terminates the lookup when malformed metadata is encountered while
preserving the existing behavior for valid entries.

The issue was reported through an internal bug-tracking system and
confirmed by manual code inspection. The pre-fix hang has not been
reproduced locally.

Fixes: 44144185951a ("hv_netvsc: Add validation for untrusted Hyper-V values")
Cc: stable@vger.kernel.org
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
Reviewed-by: Wei Liu <liuwe@microsoft.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/rndis_filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index b26a354e1462f..bdf8eb4df4199 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -401,12 +401,12 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
 		/* Validate ppi_offset and ppi_size */
 		if (ppi->size > len) {
 			netdev_err(ndev, "Invalid ppi size: %u\n", ppi->size);
-			continue;
+			return NULL;
 		}
 
 		if (ppi->ppi_offset >= ppi->size) {
 			netdev_err(ndev, "Invalid ppi_offset: %u\n", ppi->ppi_offset);
-			continue;
+			return NULL;
 		}
 
 		if (ppi->type == type && ppi->internal == internal) {
@@ -414,7 +414,7 @@ static inline void *rndis_get_ppi(struct net_device *ndev,
 			if (ppi->size - ppi->ppi_offset < ppi_size) {
 				netdev_err(ndev, "Invalid ppi: size %u ppi_offset %u\n",
 					   ppi->size, ppi->ppi_offset);
-				continue;
+				return NULL;
 			}
 			return (void *)((ulong)ppi + ppi->ppi_offset);
 		}
-- 
2.53.0

