Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409437;
	b=lDRJnFiCBneF5El8H8qHMnHDlmyBwT/xtOt7CfieterHbvaCYtOMbPBYDMRjmsyz8WAR
	 hhwXnK7zmm2cyn+60kV7bFZEA7ggcu3JJqWLqWlwT5A4jWGXQlxBa1weQTW+LpnjQ1SWa
	 Xl3ShipVFgMK+TA7Njl2KBSJhsr72vDfgu+xTrqYyMUonfUP5pk1PUrDjRrFH/3A8XcC1
	 eZEIk+j5+too71vfZYp0O7ccpo0pNkUtAMqjW84QTwbMTA5iwAPCObEsHPl8cXdN1ai+J
	 29eqkhQFQkD/fQHKEsbw/roRzPbrT4yDeeaxRodIbncq2cAyLrsb5YfwBJgzKBgLEaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409437;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BzgBxrSn9gIVmu/hzj3uDQL8/Ihyg9ba/sEZZeaZylg=;
	b=OYAA1aLgL/yuPdYl3XVwPBLs3wKtwUHcmmfSx+P66J5vftjasHO3255Vo5dxvuKLHTlu
	 9kOvDRl4IFqsqS4SbcuWjdMcfIEgYw1/VjW3nuej+F+4QB5Hewm9o+iQRUo7dBUytMx6q
	 +K8aCp0Gz5eQ/86WNIiKh/cirycULTkvwbnSIzbUpbucCx/084KAIiYl/TZr2wqXSjPq+
	 DnCIskTNfjjiJsx80jwUZNqB42FeU4wJUKveYg+r6aokn3cKBv//xx8r98aQQEdgC9qr9
	 uLfjUIqqp+UtPeTc4S2bvoh9FebKG1VAUEvd0iwTm+tNuJPGOf2pp5U3lfPaBeNcoDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="BgF/4y/Z";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243C606A882
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BgF/4y/Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84511F00A06;
	Wed, 11 Nov 2026 15:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409437;
	bh=BzgBxrSn9gIVmu/hzj3uDQL8/Ihyg9ba/sEZZeaZylg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BgF/4y/ZVjSVwQE6HMw3SOmP74mFtwauHc2c8I/Qz/MCZ2zWWx9eNgtjbfL1iJZHB
	 iPbn79w//+64sbqKOemmXgpdeDxwAbR0Pq5RVCLDpJdCz8S38ns4eiKnEbs8gmAQMt
	 HJxLVc1k4Zij4+u2WR1Ov7R7CmOKSLKbhZ6xhyrEmXVMr8opB6tCieYHPTAGnOAorq
	 br2KZ7r2gBK1tN8YdmZcE4tQ7owl9vw78DTi1xKhhDoaFvlV/tMeQRL0f8TWo08jm7
	 lH6AOxG8Pl9pgxPeWJ74JqCD3ke/lA4X14/5AZke/10nr56UIGCHsnDIcquH+X16Yj
	 MsH3Qj8TjykFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] LoongArch: Don't init & online empty nodes
Date: Wed, 11 Nov 2026 10:03:54 -0500
Message-ID: <20261111150341.2575597-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111150341.2575597-1-sashal@kernel.org>
References: <20261107052654-failed-6.12-87c6d144bc7b@kernel.org>
 <20261111150341.2575597-1-sashal@kernel.org>
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
index aefe9984be794..7c0ae91cb395f 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -318,6 +318,8 @@ static int __init fake_numa_init(void)
 	phys_addr_t start = memblock_start_of_DRAM();
 	phys_addr_t end = memblock_end_of_DRAM() - 1;
 
+	set_cpuid_to_node(0, 0);
+	early_numa_add_cpu(0, 0);
 	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
 
 	return numa_add_memblk(0, start, end + 1);
@@ -352,8 +354,10 @@ int __init init_numa_memory(void)
 		return -EINVAL;
 
 	for_each_node_mask(node, node_possible_map) {
-		node_mem_init(node);
-		node_set_online(node);
+		if (!cpumask_empty(&cpus_on_node[node])) {
+			node_mem_init(node);
+			node_set_online(node);
+		}
 	}
 	max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
 
-- 
2.53.0

