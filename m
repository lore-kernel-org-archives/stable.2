Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352914;
	b=vzcxD4l37iez6mHBbqSTe5km20FVG1hYWfHFCc85m6lojxTvp5xh5A/rAeciFhFGPhA4
	 jGVML8uo00ewptRhMJ7SzaYjMVMw4zbipbqsx5F4+OhhskD+HAyVr6Bii2f8Djd9eXOG2
	 4e6TyalVcbh4UCLwcgAGp2X+zcaacAKRhDpWDMro+dtx1FlaZPbR2Uk6wEtDqmVP4iDO3
	 faR5XKHdWWBINXQK/8u9Q+Z4YlRmLN5YR9rUXck/dB+2c2IT7djPbGKWew9+L99u15Dli
	 1zrImCDrYbGxUV3lz/C/IbD9O82sLuYTWIUOc9pk29Zs6DQkG2scnC1hraszFLwbCWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352914;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=a4DxPzJFq+Xx+85XSsmDtCfWeMHzGVT6RmNuzkGCqK0=;
	b=o8knVLg22SWKp8DP2jWjCLiaxx/7XkSIIEJq35iuNqa02qTu2m8VCHflxKz2i+rj35Ca
	 ng8gOOCMp6mYhr/5mVsc+NLqwKeiw+/OxBuw7UJIn9B6+cokQHi5lrBJ3q8YRguyqyFN6
	 DfN0rUFs1r493V+kLeWFvCqpALvKgFOiUUe8V1HKIJb+pRo7bM+baFJLSSku5UESlwhop
	 MldnX2AFhyuNZiiyeIHvk/NNrpmHm9MoF70fwkJnSLcVAMxCmclnUa0uxY2v2J4RuxApW
	 PK/FcIaiy21PDaBHeAzgAjyQTpP2lWF7EKsMdxDGQSauKzrqa0hQDxGc1MhGk3X64zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ajaNKjdF;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E08606A323;
	Fri, 30 Oct 2026 09:35:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 87E08606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ajaNKjdF
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id D9FCB20B7166; Fri, 30 Oct 2026 02:35:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9FCB20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793352900;
	bh=a4DxPzJFq+Xx+85XSsmDtCfWeMHzGVT6RmNuzkGCqK0=;
	h=From:To:Cc:Subject:Date:From;
	b=ajaNKjdFDer3GAXHkQRPDDp0vU1Y1zBVj4/NV6ni/hmVLcfMCP31SHP5r3yQnUp3E
	 BrRWxi9kM+dxbliMh8/GwSK+80jgfBtRLQmmHMrhRT2L3HdGj2Y3l8xtbZCewP1GC2
	 cDE90UPGdoh3/IpirKeDkyNGrUnwh7UdXa2Kt+fU=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	lkmlabelt@gmail.com,
	parri.andrea@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	stable@vger.kernel.org,
	Wei Liu <liuwe@microsoft.com>
Subject: [PATCH net v2] hv_netvsc: Stop PPI parsing on invalid metadata
Date: Fri, 30 Oct 2026 02:34:59 -0700
Message-ID: <20261030093459.4004663-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
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
---
Changes in v2:
* Add Cc: stable@vger.kernel.org
* Clarify how the issue was reported and confirmed in commit message.
---
 drivers/net/hyperv/rndis_filter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 9b6c44979b4e..2c30abf9faf8 100644
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

base-commit: f71ff7d406523748bfb8236830c7eaa6a308aaa1
-- 
2.34.1

