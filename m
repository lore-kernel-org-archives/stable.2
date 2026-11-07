Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050979;
	b=dqRp6ELMke1p0CZg0iLL6BAdfEIfvKrydbdjvfqM2O9G/gXFO3KZsMyoj2COq1EGWGNU
	 KswweWqcGNlml1L03Vwz4tRaue9zPoqtiasrPC9fSW3kXMWT92sgqMO+WkbRRCfXKKvHi
	 4GqnXdcBTeNPapfIB6K8d1DMdxh49KVYRNVffNmL8Lk2er06dQTomi+xR2RG3vXla8bBD
	 YmzWbRHBxP1LTza9aFjK4boSH5BjLpNptwCaf4K91slqcrtz9CrZooqlZbJS25X3Tff8/
	 kSHYNzlPvtfMb8QEcbW9KT+Ff0RM8LGyyCyX3/9I68U7X5wRonCEGoeTaoXs2U8w1qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050979;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9D3qFPhhtqSrCkiXs3hgE3pXkmxWOBxaCIWQq67YtLM=;
	b=y3OkU8LenSMzQ3VFUEROF5e31kpka5X/s8S9VXrqyUJMpCBaZB8fIkq7bPPfLbUUYFoh
	 /YmGH2VkTm2z5FGdTieAZAye5Jgb/JpQ/JPyxDOv0E4NyC2lyD/uvGjqcAqg+3XbeoeXS
	 kXSFTcHGPB/KHdBOXpqiNGukFA4FdwWaxqVMpD8guCy4uihyUmAj8aZRK5Whj4K/cpk2W
	 lghYvkmguyGbPvdWS3mGtxMxY5dDdcEkVlBTKLPfxQrWy9iX2v1UYTUA6DELW2fzU1sey
	 E5WbJ1VaH1t3IcASp8l4dYAZikxGEqXfHZ9qF5XNYgu4hS0lupo59Ysor8Wp/3Afrlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RB2tTK35;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3D2606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RB2tTK35
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 189B01F0089F;
	Sat,  7 Nov 2026 11:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050979;
	bh=9D3qFPhhtqSrCkiXs3hgE3pXkmxWOBxaCIWQq67YtLM=;
	h=From:To:Cc:Subject:Date;
	b=RB2tTK35EozJ/nj/mJXJ26puhek73pAiIhEe+ns+RmoZkbzNPok/+jFocxJlxI7We
	 X3iKoV4W4K5SpuXAXf0IpboLvoLspDxjD0E9hn4zjdNr976XgscJXiMD8AEESLxx7e
	 g/fsnVaV8ABM9uwB2aOTfglQW+yNTq8ik/bv1bxpdg23TRKTb6xtozwnXUte5FZy5C
	 3FiquxnYV2R0A0//9nyOGXhEYOJ9N628tv8Kvlka7hql35DFsvOFBqkb4LnoDus8eg
	 R4+4atIa4+Gzb88r87eXbKQsv9aV8xjTUX/VbiqFCHkSGHzWp7ttVxTLNyuSuh4vHJ
	 iagHkNAGmLXlQ==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Don't init & online empty nodes" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:29:37 -0500
Message-ID: <20261107062937-failed-5.10-87c6d144bc7b@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 87c6d144bc7bbed0c4573848b9c92006edca7848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062937-failed-5.10-87c6d144bc7b@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




