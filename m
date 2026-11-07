Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046513;
	b=k0pqOp9dN5B8b3nXmsTP1yJNRN7u1OJeABlx7s6YtmpdZhiAv3Bu+qQsi1IwjJ1aVit1
	 pgM2bAinTznnGrCfsQvMu7Scp7HuCjOsW6u9Uo6UB8UB2rQ9rPbJCKIpV4p9bUYYUMAN6
	 acsmbe/3x3Zk/EPclYJWigAfYYXnf6M4j0RPSHB/RWcOzF/KW5WOo/NrMtIJc0drR1wYj
	 rrcfEtZ3Pc7drfhFfL2fPVmlImllgh+On/MAlEaHLEO4/fF2FVYs+l/VMAqfGRyayPrcI
	 xGIAGa+AbdH5za3utm3tJB6QEU/4oY4ShLRC9KKcM7NW/6Bc1CxFCLzeBqQ2m7MVnAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046513;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BPTCR6B9fEA9XIphPxXKTTdXkJ2k1jVg7P5wHui9DSk=;
	b=Ffw0UT+8Psh69VOmENMb73tMdDjAv7tYFUxfsUm/T9tbQgim84CHirfSIlCRMnS20D0A
	 CqbsWS5nNJgeqa/+QXEo21G/kZYXrhqul/emSumzc2Jwo1oWF4ETCm38KcrYZiXIcaRSv
	 dc/iY/6wVDmvkGjKLWKc8HUNl0SscbR0szmA0VAjScDoxdtebyBCHMLbrnRrRSttRaMdr
	 ToRXp1o/7QcwV5Yttnue68XPq1vqBakOMJ+gC8iMh06GaKxVME/MkqKPNieu3nFPot5If
	 QGRdx7UKZlFnNqROE/hBq5OINqGYPHThJkz25l9X/MY59dmiYUezX1YhzyFI4KZL/SA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhoTjxFZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F8A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bhoTjxFZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CB31F0089F;
	Sat,  7 Nov 2026 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046513;
	bh=BPTCR6B9fEA9XIphPxXKTTdXkJ2k1jVg7P5wHui9DSk=;
	h=From:To:Cc:Subject:Date;
	b=bhoTjxFZA0buvdNoe9y2EujyqriCH4b9nUGqZbLxHCuqZNwg6VdmzBwtHZQdfO90K
	 othwpYRH9tJCbu1PIkiafz1YL4NvkVXIDdZKSdblrPqUukN1RgIZRWKycRvzER9C3R
	 ew6ACrvr85ngOiMjKCDz1j4XoFsg5BrejHEtL8r4wup6SyA3jzbg/cmLbm+3NJd0Ky
	 ABF5Qfd5R+bRdkAnWChfrsk2UrPEuCzo5ktYUXBYgpGtVQRCk/Dcj+aIkTO78/Fmt+
	 tRTl98lIlIur882bGv91BWyADRBWclp4zWUBZXpiMhio1l3njKV5zYu7Y6tw/f0yu/
	 trP7h9b5icvWA==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Don't init & online empty nodes" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:11 -0500
Message-ID: <20261107051511-failed-6.18-87c6d144bc7b@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 87c6d144bc7bbed0c4573848b9c92006edca7848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051511-failed-6.18-87c6d144bc7b@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




