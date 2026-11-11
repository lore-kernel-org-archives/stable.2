Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794409951;
	b=j9DaaK8lP3ZCgX5Z8pXh6ZKlscGiv9oKVy6sCwUIfDAzRD4ShM+VfVeNahTD/+yVaDXd
	 zuehGZfwYREvBSZipaz5IcMQVGBLiNKuPkL2eFMWx4/pQp+DOC3UFVZTONXiSNQ5+/6D8
	 wYgUcoseQ+hkMJ5TEQ/iiyWG6cTwnY2u/sR0mb2BbuUVm3uzh3EQ2xPi3T80QaBKVlVkw
	 kivWuzFCd3A1BvotvJiAGlWkoGXwK1Ga75g4gJUR5dUrZ69gw5fdmx5mrtnvn10imp17z
	 WNXpeTf2Z1sQR5Mh1Zt3SF+S6dp97ltNh1XyQbHwH6kJhZl4h+mjph3dMf//ilp9yeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uQoKDciTwCMzRi5f0wmMjqqFbarvNwl/BPuvwGMIBVc=;
	b=2geaZ4t0FWiVVhR6uzC7TlYfPGeKQf8WuIiAX2yl8KpUoNQMwecukm98HhjdzMl48Bj6
	 lZFh1QQNihA0ems2ZixQnqOfyd4ZvmTw0409k+yRFWOMGrGb2HgmfvVerWMi+7FGv1Oq+
	 u1eScYz0gujIajueq87fVd2Ii4ItxQthm/8ICX/OpldHLsVCNZ1Kc7/9pzD2eLCB2XG6t
	 gMvc0WEdt5SWXknQjCWPGZAezlWhBlKriWYxrgyj6DWhk56YYU9PjFtsPx/ZbUbZiOSun
	 KzhCyuzqSFpMmcFjK1yCDpWGzFe5258i6Vnzy9hx/v9RZ/jZaVTb5CbB7ap+nP8BEFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Br4/dF0v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A260A2607
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Br4/dF0v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 066381F00A06;
	Wed, 11 Nov 2026 15:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409951;
	bh=uQoKDciTwCMzRi5f0wmMjqqFbarvNwl/BPuvwGMIBVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Br4/dF0vovYo+q/f49bU/z8IuVLnig5ZmqVNaAMgJ5aFKY+Rk7fhLAGDtFKRkOU2z
	 dtxkW36vlF0BRa3RVxptLu+c5IK6dn0u+LShKgVXoWZH2nbKX/t9t7KdVeQ5p8/8Dl
	 xEgObhhH51u6mujZ6M7GajYJ23eiF3r/1pBeuy2tlHOTp745VtauvEe6qNRs91wIye
	 0fTsF5Sz8djvw3CO0fwZlGJ+2Wvvfw6/cx8nD6MYCUiJKIJr3kKoCUBY0gmv4mkFUK
	 V8vXg2JLPiGMQYuCB28DoxvKo99jxEODhJo4ODRMKrXGb4b0ISsOaP2P9zlMiDtC13
	 SxxelIw8XcaTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] LoongArch: Don't init & online empty nodes
Date: Wed, 11 Nov 2026 10:12:29 -0500
Message-ID: <20261111151222.2591661-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111151222.2591661-1-sashal@kernel.org>
References: <20261107053948-failed-6.6-87c6d144bc7b@kernel.org>
 <20261111151222.2591661-1-sashal@kernel.org>
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
index 62b92cb7e45a4..2dc9c296f2122 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -339,6 +339,8 @@ static int __init fake_numa_init(void)
 	phys_addr_t start = memblock_start_of_DRAM();
 	phys_addr_t end = memblock_end_of_DRAM() - 1;
 
+	set_cpuid_to_node(0, 0);
+	early_numa_add_cpu(0, 0);
 	pr_info("Faking a node at [mem %pap-%pap]\n", &start, &end);
 
 	return numa_add_memblk(0, start, end + 1);
@@ -373,8 +375,10 @@ int __init init_numa_memory(void)
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

