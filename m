Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047216;
	b=PlxLeILOPO+O+mK8myhi8X/5U4ta1nsP4eR0TenMf8zDJ8aeoNdeSB9TfSDDmA1wT39H
	 U5pdcEG1dNxQsAVtsI8dEImXcsC7ZkMGa/TZwzFsuz3eXyEiYz7OJ5kfLia8zKuVLD4A5
	 A+xZgLQg1d0KvmkqdN1jGyNsOpScvfqgctFxhsY4cTtRbQIVSmtr3n62pXa1/AFIh6jsP
	 Pofr81n7vGjj3FUUi5NtW/EKucWQtF4DgLBmc4QZmh3+/A/nPWfaNfAmlOc/N2J8Z+VMd
	 7a6orzlD7MV2WXHbsfv9T6hIIYC4018nS92SRv96/s4TS9Kdo8qQ9V7+O//V8yQnMSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047216;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CPPuUWnwcuOZxRuXmexpOZ5qEiWADGPqaCReiNVLo4k=;
	b=mY5LFzWKVhGw4WAMKDbhH5z/RinWlvsV4HCQ2K8slFLF+wTvxTjIbDadayeaiVO9vbEL
	 7UjnGaFtPEBm4hQVRvZ3XwG8TsJix75AyyH2iqB1hUDrPtWvQF2zRsqGZmcSKowkj3je3
	 VSX4zT3nhf9sONMTWXBVUlvtDBE8evllv8XvNg/ZT317wwH+FsOpbRw1mu5YXpftku5q2
	 UAL/ItDoU4qo6nHF5GD+6nEdq8fUEZ+huz+sgp1QFfYOMPMRtBIUAu/q4oGszSPwh7tkr
	 3mhG95AofieIWjyzGBITNVESAjuKCKNr3/a6NCjnMY2LnAed0NYgH2Ujvl6S0Q/UZiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfJfqxLG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF5A606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XfJfqxLG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C8D1F0089F;
	Sat,  7 Nov 2026 10:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047216;
	bh=CPPuUWnwcuOZxRuXmexpOZ5qEiWADGPqaCReiNVLo4k=;
	h=From:To:Cc:Subject:Date;
	b=XfJfqxLG9Kp9fGkqyTx5vFjWJpBgNdNNz9giiKx3eOyHifBR+rqdrAzzAyUrG1+DF
	 cVWrEaKa1mKpm/t9rLrKrQAeFUw3eo4ui8TF6/+QsWKxE7Ji0nf97De9FtzJ9YMQoZ
	 ldUz/puygCJpt5OkEBuEUbNCiwqNfwN4KoXcMlZaGi7d+BJpGeJM/mP2T2xDeArmbM
	 nKNOGC9AePU3SoTI8wzdHPhl6pWh9q1VsVOytjA+uaroLPdX1wKN+bXCiFAzTxeqWT
	 WNc7JiNdSvXGn56jVv6AW8PMS3O4I32JMQNAa23VQiOgTZYVcgKRQKNPT7vRjZor6a
	 /CM74AP2kj3Dg==
From: Sasha Levin <sashal@kernel.org>
To: chenhuacai@kernel.org,
	chenhuacai@loongson.cn
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] LoongArch: Don't init & online empty nodes" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:26:54 -0500
Message-ID: <20261107052654-failed-6.12-87c6d144bc7b@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 87c6d144bc7bbed0c4573848b9c92006edca7848
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052654-failed-6.12-87c6d144bc7b@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




