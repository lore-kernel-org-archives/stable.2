Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048935;
	b=l7BTU2pxFwpeQeazB5VAC8i+gdlSFqy5fDVJbQ2an0bPch1cPi5H8UWDIfIrOHqqTLqB
	 oRfRpXzC1VoPPVH6cDDhk1Wb8baSRP6nRxezlb4dRvh78GH01C2ss1G+aEfkkrc/SSXb9
	 DolnzPVdl/fL8mEqT1RJFhn0WHa+mcaG/EdtY8aQ7EwA/XWH7seF+fiKDKrFdiVE4UXJD
	 TxhgZ31VSBbwI8F3KqvWPclrBDRkWeIKf2PHRCASzhkwNBAjHdrmIA/u6aPRK38n8eev3
	 nXIriSPlD1jGKHVN0lnWdYX8E33aWT0FYznSaKA1veuheKNWD3D+xUF4/s/M5EtFtOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048935;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EsM3WgAwZWXtXQm9gDCm0vosQHYKGVIJNl8vkleq6lI=;
	b=5aT5rh73lx25WTXZWqUIqI6+zloOU7djJDiiQ9f0VMFXUXyzwXi9JYYXlxAysGW6yivG
	 9Qs1n7o/u1QeIQwIS3t5vcaxhz+ICwD+SuwFh8PJYDT3d+5BbXN7B3K5hTfFNoh8Fq8nL
	 ZBwaBX6M0vahIRPngqWRcE/89zt3xK8g3Mt+v0GxdunGU/+SKBLPDwaCkD5DvsZe4YeC/
	 UiCPD2nkmThPzAjixITn6q3V7UCYzCT+hdRBQGJeC7JmOlKx4RSps51aWn2I705hfpwuI
	 /gbLx0BCL6OuLbaQaXhjjS8Ub7fdDqNSvhji8BO6U4TtKoCEin5+x0FFtKbWMCT8mPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJtCg17D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE6B606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VJtCg17D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46BF31F0089F;
	Sat,  7 Nov 2026 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048934;
	bh=EsM3WgAwZWXtXQm9gDCm0vosQHYKGVIJNl8vkleq6lI=;
	h=From:To:Cc:Subject:Date;
	b=VJtCg17D5ZTuKBeBPC3s5/v+za+mc9DgDVXYiFatvTcNkUlEdsmd0QamKv7MHbYLG
	 qTPRvNGsoUxxdPyMPNqzI40pW1KYIEibqexyp2/GZT/GAgum7qr+U14FBHm+IkWgvN
	 2ailPrLRqkIhZT2Rl0cF5f0MJ3efV4igTWc1EQMSKFSK/o8+os3ZsTKrXGJHwQb/52
	 6P+OcdG9FFiVljjvjtLagd8aW80aDnkuriatZGElw85I9ErPbuw/A/7M4ac4DUXKYO
	 0mKC+kCVSUfRTac/5tpGSZxRDNJUxbB0D2U9wW5Lj3f6iCdt8zty9BLYLcDTmLfH3i
	 uo2dd6zCjoTuA==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Don't init & online empty nodes" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:55:32 -0500
Message-ID: <20261107055532-failed-6.1-87c6d144bc7b@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 87c6d144bc7bbed0c4573848b9c92006edca7848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055532-failed-6.1-87c6d144bc7b@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 87c6d144bc7bbed0c4573848b9c92006edca7848 Mon Sep 17 00:00:00 2001
From: Huacai Chen <chenhuacai@loongson.cn>
Date: Tue, 27 Oct 2026 22:51:23 +0800
Subject: [PATCH] LoongArch: Don't init & online empty nodes

Don't init & online empty nodes without any CPU cores (and memory), in
this way "lscpu" will not display confusing empty nodes.

Modify fake_numa_init() to make sure at least Node-0 isn't empty for the
FDT booting case.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
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




