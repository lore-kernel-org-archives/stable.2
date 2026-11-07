Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049958;
	b=oJpC0AnU4VFVZRxT4S2qRQ3mSQ0+dFw6oQvTlRt4iGVkoFEH5ItVc2JN8eZE/ptloRwX
	 rSIOob/gi8twHY5qFuC/ftm3DdpNY/6T/mQq7YKIw3Mmn/mAzbOINUKfR7JHPr/2IvbhJ
	 ecJYSkf6biBMSFdH4Bege0nZE0tpVPnDe/CgPsmTp4Q65IE3PtGhTTNsHCJ9J6ir/KYh6
	 PqOqYC4VO2Z+bWUGmj4ghzrNrp74n/J2OIewW3+giDqF5+vlCu0TBK3LagHcVVzW/PAsM
	 ZCZ01Yr6pghsCOwlSjIxJAuOvMBp/KOXd5JfJ044UpURx9AklXUAZij1zlhDbkjDozg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JEOoymKoyTJj0WJ6SxOhFiAxbhmIe5lflZcyvBKybl0=;
	b=jtwnu9VWDL9AKEHNzNZaPqyzQx++bKblmKvuxOfHN9n7nrJFhV464M3OLL8HiOHdGxpW
	 YTEuIrh+bQ8EbNnrd8g2aw+UpwCWxoIFKycZo65ScZ9NfzG3/0X3vJzYECBqBzAA28CbZ
	 rhGdiNLKDU58j/d80ut9Xw5LsYEtG56eYankc/RtKt5iBKUiDP2uEar24xN2thgR27h75
	 MaUSzH+9tYemA2E+41+f/aoLjLw+hklGoNwX0YcnSMsQHs7Qyn3dXOdouM+T5hbZ2tgGf
	 /LcdBWqLIveunJ7L+2PCEjk6N+yOmiVQKoLQjxnmL+hFzHZZXcaA3brx469yTZghAVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI5ABZ2n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F4B606A332
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WI5ABZ2n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3370B1F0089F;
	Sat,  7 Nov 2026 11:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049957;
	bh=JEOoymKoyTJj0WJ6SxOhFiAxbhmIe5lflZcyvBKybl0=;
	h=From:To:Cc:Subject:Date;
	b=WI5ABZ2ng31GOQM1pBo33mhaDRb8zS5HXnXIak9kzhP8dhtXMlfxHJLNlpyMDWYvI
	 0r//AV4yi0L76pZEuSmyWycdcDjWlf5vLrFHzyM2gz3m5TZgYNzuIYnNCY/fuANjAa
	 Q+SDOqF4Jtt6vfgYGeZZhgeTs05jsbizU4Xzn0srZV+HFLZXJjAx/IgE5AufOMxf+8
	 Z+P2wLXObALPoXaw0J2GOkhsfZ8Tscv311VZKhXMrO359KBWG9ZVMrKO4hWgVugvzL
	 xSEfOFqRILzsHPQfF9eIMkFX/XoAL8HEkFBJ7ZdJSyWQfJABqkds4oDcpeBgBFbiSY
	 7wuQ8mf0+0/Mw==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Don't init & online empty nodes" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:12:35 -0500
Message-ID: <20261107061235-failed-5.15-87c6d144bc7b@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 87c6d144bc7bbed0c4573848b9c92006edca7848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061235-failed-5.15-87c6d144bc7b@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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




