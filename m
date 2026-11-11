Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409194;
	b=RbjhBZE24GPESR6ee5Cebsk6mMNkYI2zEkmibDVejMI2vsAcNdEzc/aKiP8Dp+kvgynY
	 FmLKRf5yRaEoS0loLM0OssycJF93/h+YW+OR3dP7RdS4ovtONez7j3vyTDcKVYlqZUTAo
	 Sxz4bCHegVlGHQZXawspU6dzx/ODt6bnysIo3oDvf+HfpUtvy67bcrbcjXzIx10F+NE+k
	 xSsnlT1GokAWIweerZydHKN7NdVkFqnq+s5KmfFotMDLV/XnqYYrTvqLOn1MXMsz3jilh
	 CQRMVfRpcqYSijitSrZ7lrF7qzUdImEVP1SYiMC1QF/8vM2c7YDQ3sGfGol8KHGpxiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409194;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0M0ayHkYiIRI2+M6alEaD34Nk21qd9l2ANtBUR7mpcE=;
	b=KaGl7r/PdzDPQM9N17Izb7OCRBjB+EBhG/Bts+90TGd3Cb2h9uONoIOfUrcixqZJWRV4
	 kLt5KGaOlirbqhTwqsiIUHeR9G0oYxLVluTbQTTPcslZcGEJNm3d4aV4fbpClGQxz1t1Q
	 OuLlvqgfVv1SuCtweSUg/j2yuopmlQ8lKBGO5YyDXNRIFv7sjHdNrt4EhqzLA6oTVmpCw
	 VjQbuy01OfUjc++va2UkzmJnfsXIsQi8mZ3WHFqaFrOuCjl9VKFwFU2GYrS+h54mPxBy/
	 omayzw+4JD6omm56/mpdeKsvwBU6ApA5BcwULwua8AY78uAFyrSnjlKRAiTed/NDJaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFNqoCpz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F96606A332
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FFNqoCpz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42711F00A06;
	Wed, 11 Nov 2026 14:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409194;
	bh=0M0ayHkYiIRI2+M6alEaD34Nk21qd9l2ANtBUR7mpcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FFNqoCpzxo01zTb6vRAIkcufXN/NWzHaj0LUqIrmp6E2aIoCIaKSHK4bMTZpH9zG2
	 gmc6px3SolEAGcPwe+1DTC9mFRaDtHAG8uwtcDb32vDr2u1w6cPuofjRwiQrozXLMB
	 M89y1kUH26C/bPaQu7RJ9vU9w2YUcfqG92QU6GXSAM7n0Q8QyCQplfxbXxK/SecsOd
	 6XRiTKj7tE+IVj7MtFxl85eVRkwIc1/lCsZo4uKI+tGvLlpFUFSW0C0LqD+a26gr9I
	 KgH7v5mw2FM2Y3PzGzBuyrhJDchDFhASehIwZ3MGyzSt8YQoZu/cbn5wYAZYulPrnI
	 YZ0KSVh6SMHAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] LoongArch: Don't init & online empty nodes
Date: Wed, 11 Nov 2026 09:59:51 -0500
Message-ID: <20261111145945.2469530-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111145945.2469530-1-sashal@kernel.org>
References: <20261107051511-failed-6.18-87c6d144bc7b@kernel.org>
 <20261111145945.2469530-1-sashal@kernel.org>
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

From: Huacai Chen <chenhuacai@loongson.cn>

[ Upstream commit 87c6d144bc7bbed0c4573848b9c92006edca7848 ]

Don't init & online empty nodes without any CPU cores (and memory), in
this way "lscpu" will not display confusing empty nodes.

Modify fake_numa_init() to make sure at least Node-0 isn't empty for the
FDT booting case.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/numa.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index c96c536237151..7dedc134ddfe0 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -216,6 +216,8 @@ static int __init fake_numa_init(void)
 	phys_addr_t start = memblock_start_of_DRAM();
 	phys_addr_t end = memblock_end_of_DRAM() - 1;
 
+	set_cpuid_to_node(0, 0);
+	early_numa_add_cpu(0, 0);
 	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
 
 	return numa_add_memblk(0, start, end + 1);
@@ -244,8 +246,10 @@ int __init init_numa_memory(void)
 		return -EINVAL;
 
 	for_each_node_mask(node, node_possible_map) {
-		node_mem_init(node);
-		node_set_online(node);
+		if (!cpumask_empty(&cpus_on_node[node])) {
+			node_mem_init(node);
+			node_set_online(node);
+		}
 	}
 	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 	max_low_pfn = min(PFN_DOWN(HIGHMEM_START), max_pfn);
-- 
2.53.0

