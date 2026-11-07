Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047990;
	b=ocVeYgZr80Mr9rFVxwkVkYeP0lroEJMojmSQCfIIwO4TicZH+pLCyCNQUYt4jyc7kfWj
	 mIMoaGTzrX8kV9RI8vZ9zz0qWc7AO6vi5usunTExv3IBKRCkuTGA5VatiKZWbhI3OauBY
	 m2n0yH2+knOv79VQYcfotU9E83V4HdG/tlbgTU1/zLaPHnQOys1EfAUHqoEPfxOfptsT1
	 LZlcwu2iZvIErPCx21ylj8IjziKLX92qplbIp79bQEAj4k8yQkFsHgMrnV/HUiyvcfZn8
	 08S/JZDQ0uphKa926fgvy7UVwEJ+Ox2RF9DGBkjcBmthY/CFQIWIK6/CoftGRWjdBLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047990;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=RFHuuDCmFI+bhV8AiiWkY39mica837+Pp+A6Lgxdv14=;
	b=iIaseq1igEzY+QfMLwb/y7ziRoehVB8OzhovGTDj8FDyy/ZYwy6ZT1yyhk7wMBS8AvN2
	 KSH+MwvN9Q/GYgIFXx4w2k8oNxnbX+VIucgNGgtSrH1NY5bYuMWlvutRFXVt8hAw2pt5C
	 Ofzgd0N6fCj/4OHcy+i5MuhxB/Y2ASKVwa+Ug4v51vjBGXr+7D01Yh8nkA4r7RJUczAbe
	 PioIB3rzC7iqNpy+5th6zcvx6tnOIhdKcqJePjYWlAs+wPiJ0oD3k5rWpCU4TrRZDAkY3
	 BERX0sZk+p76dVd8Bgb1fRd8eaaiP2kvYbSbKo3XdeEdks00hYRDZq/0dZp2JuWg1QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgIVU2Lc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC8606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lgIVU2Lc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F03551F0089F;
	Sat,  7 Nov 2026 10:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047990;
	bh=RFHuuDCmFI+bhV8AiiWkY39mica837+Pp+A6Lgxdv14=;
	h=From:To:Cc:Subject:Date;
	b=lgIVU2LcHc/rOs+KGVFNt2xR5ekufap9LyumB2wDE3FUEJ6o4XlVRQ1bKRcpmAogG
	 spFvxnseQJkmp4/2ktxTBW6uSszJbqBthAYdFmWhvxdt63wMNBh+ARByKumpcyk+0f
	 bMUgRRnIXGWVHKz0NVC+cqoqpr4ajFQN0W7z4MYFq4g3l7pWTIQ53Tgev1cDvwjFyT
	 TtHe+mEkB2dU7INsuPPMDK+YMLzTLeqWYtwLi0WUfAcFyMkQnR213VD4z/a3wOlux0
	 gLSYjxHUfn/C763P6oCY+JAMGYHcGadVhP0mvoZuaTlikgcvwtlP5/3HwiMFarAKKk
	 2ayqWlycI1dIA==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Don't init & online empty nodes" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:48 -0500
Message-ID: <20261107053948-failed-6.6-87c6d144bc7b@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 87c6d144bc7bbed0c4573848b9c92006edca7848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053948-failed-6.6-87c6d144bc7b@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




