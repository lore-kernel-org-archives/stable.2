Received: from pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.34.181.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647A399365;
	Fri, 21 Aug 2026 22:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.34.181.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352180; cv=none; b=RIECXKbyjN8GtKTDLvygQ+va1MOYxkyuJ7/xv5xY5glDAnX69ToPe3mvnwkmq0mbVhbYFfakaIyQQCL0uS4xdBAqYAJKUsM5XM8PzrR49MFmI6VpjWM6xFfPNJOWEyjqaPkg1fCmgXzElX+awrNm4RHlKxzI3XNwbgnTjQGp9fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352180; c=relaxed/simple;
	bh=rz5tuiwpBSVybDXFbMXoSSLqKucfR95bC0ZNq4sWIio=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B8bR+wrJtCDIyl+eTB8TCFPho9KDPBtgi+wvrKpTQJzQmuTHxkVjg19wS6Jnq7vT45hVjL/lN7e6yGWJurNNmGtj0/ydDyf2PYSuQW0UakmfVsa/KdRDAnd2esxpQpsW0P9oItUVsgNy6cITQzLTiIdJbTTxsc9amjgtBXNWfhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=Q7lAmcAT; arc=none smtp.client-ip=52.34.181.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="Q7lAmcAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1787352178; x=1818888178;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eZIELaPND3+NIQ5JpGZbhV7Zuc+v2N+xW2Wi9488Iy4=;
  b=Q7lAmcAT+pOtT1BRIDBAaDGy1cFLYgfCqhuzbZ5gOCZkwCB/8u40OFdZ
   buaLSxMXKomj+Uu1iEYUjq6sFLGwMnM6RdXT0Ten1aouKpAXY5QKK739u
   moPnxX9KoFrbslQOUf4ANy0p5auNtu5MTrYHjeFBS+epolgFc/I4HUeU7
   SJSi8dapcqBKKyb/KdF5mFy894Yh56UinE7MzjwgULfWHYJQQ11NmqHXZ
   wyoFzv4MW6Xa/84EPwhG9kKTNeArfOcCzfosf2eB73JW2WNzprsmHJFKy
   bjFkvFjSEK9fh/69vN474ngcFyVMYhqPv3FAcB/lXCJ0hCIYOcZPENPz6
   g==;
X-CSE-ConnectionGUID: 31z3Y1RkQdqqe2WP0wNHdg==
X-CSE-MsgGUID: +kNGP3hdTlCvBEm8CeEQMw==
X-IronPort-AV: E=Sophos;i="6.25,236,1779148800"; 
   d="scan'208";a="26617080"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-007.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 22:42:56 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.178:5771]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.152:2525] with esmtp (Farcaster)
 id e9b2baaa-2df1-4b8d-b3e6-4485a46533b3; Fri, 21 Aug 2026 22:42:55 +0000 (UTC)
X-Farcaster-Flow-ID: e9b2baaa-2df1-4b8d-b3e6-4485a46533b3
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.45;
 Fri, 21 Aug 2026 22:42:55 +0000
Received: from ip-10-253-83-51.amazon.com (172.19.99.218) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.46;
 Fri, 21 Aug 2026 22:42:54 +0000
From: Alexander Graf <graf@amazon.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy
	<robin.murphy@arm.com>, Feng Tang <feng.tang@linux.alibaba.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] dma-contiguous: fix truncation of numa_cma / cma_pernuma sizes >= 2G
Date: Fri, 21 Aug 2026 22:42:52 +0000
Message-ID: <20260821224252.70640-1-graf@amazon.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWB003.ant.amazon.com (10.13.139.172) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

numa_cma=0:4G reserves nothing at all. dma_numa_cma_reserve() copies the
requested size into a local int before handing it to
cma_declare_contiguous_nid(), so 0x100000000 truncates to zero and the
loop skips the node silently. Both parameters are documented in
kernel-parameters.txt as nn[MG], so that is the syntax the documentation
invites.

Which bits survive decides what a request turns into: 4G, 8G and 16G
reserve nothing, 2G, 3G and 6G sign-extend into a size the allocator
rejects with a warning, and 5G quietly reserves 1G.

It reaches further than those parameters. On a CMA_SIZE_PERNUMA kernel
with no per-node parameter, dma_numa_cma_reserve() takes the per-node
size from the default area, so a plain cma=4G on a multi-node machine
feeds that size through the same local and loses every per-node area.

numa_cma_size[] and pernuma_size_bytes are both phys_addr_t, so use it
for the local too, and give early_numa_cma() separate variables for the
node id and the size while in there.

Fixes: d5cae2261b86 ("dma-contiguous: simplify numa cma area handling")
Cc: stable@vger.kernel.org
Assisted-by: Kiro:claude-opus-5
Signed-off-by: Alexander Graf <graf@amazon.com>
---
 kernel/dma/contiguous.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index f754079a287d..66093460584e 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -140,21 +140,22 @@ static bool numa_cma_configured __initdata;
 static int __init early_numa_cma(char *p)
 {
 	int nid, count = 0;
-	unsigned long tmp;
+	unsigned long node;
+	phys_addr_t size;
 	char *s = p;
 
 	while (*s) {
-		if (sscanf(s, "%lu%n", &tmp, &count) != 1)
+		if (sscanf(s, "%lu%n", &node, &count) != 1)
 			break;
 
 		if (s[count] == ':') {
-			if (tmp >= MAX_NUMNODES)
+			if (node >= MAX_NUMNODES)
 				break;
-			nid = array_index_nospec(tmp, MAX_NUMNODES);
+			nid = array_index_nospec(node, MAX_NUMNODES);
 
 			s += count + 1;
-			tmp = memparse(s, &s);
-			numa_cma_size[nid] = tmp;
+			size = memparse(s, &s);
+			numa_cma_size[nid] = size;
 
 			if (*s == ',')
 				s++;
@@ -207,9 +208,10 @@ static void __init dma_numa_cma_reserve(void)
 		pernuma_size_bytes = cma_get_size(dma_contiguous_default_area);
 
 	for_each_node(nid) {
-		int size, ret;
+		phys_addr_t size;
 		char name[CMA_MAX_NAME];
 		struct cma **cma;
+		int ret;
 
 		if (!node_online(nid)) {
 			if (pernuma_size_bytes || numa_cma_size[nid])

base-commit: 26260251022fbc2f248a3d747a9b2b961b18d2d8
-- 
2.47.1

