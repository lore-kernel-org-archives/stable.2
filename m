Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410796;
	b=P6EI/UCkktpu5xxH6TACyh2ZEbjR6rdlxlWd487213ewUVE7WxJuoQsRLDSzOv3/t5rE
	 BptL7NdzQvr8QlJt3zfQlu8l1U1OpcDTYhzIsr6QCLykbzVcrbdrVPahJk430A8IR0jJy
	 I7XOS5c+CLhxaUyYRNVm8BGy1lDRGrDMrQiRLRSZ3dAXXEDP9Nw5P8LAabeopqVcC6Vyg
	 E2ldxV56e1qLpcvUUUBdfOG1mg26PfBfu/HBO5LncNroob+Ej438a+FZ/qi71rqTlrfhn
	 U1zvDgR2yBGm+qFWaUcWisob1V0n6xjc5DoO6MXktNd972gtztDZ7D7faaqfjPVx34A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410796;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ELh4r+k/EoX5uc+YAlcCKFPvHu9PLbkA+ba/nx73PE4=;
	b=BSwoeNZYMUTryqR1XAFBK9vUTx++rkszqC3StIhfG2gUBCVY/2xOHx92uTY4S+tA/9g8
	 E8cAUr+rGci1ZZAKivanJMWFlzLAnAm6x6PqkfhZFmXwMu4qxrL5WeSX/zzm03FTdk3zz
	 GxoJvMYfdBktRP6tK6WBULkiRns2pmpNLRw4plMhR1gDHhyHeUZccyuQar9+1tSt07ysB
	 HMMtmAvmaY/MR/l3lCVWx0khn52A0azuleidMx0+bkFjriPmwGZCkBpZrRX7E6S4smIbe
	 t6X95/he+1WWJYjmIjPvCrG2rdpZuvo7b6Y4gqKYsPjKkDISOo/cTsE8JjJQTjdJ0Ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+9uwbmP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160C0606A89A
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S+9uwbmP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484111F00A07;
	Wed, 11 Nov 2026 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410795;
	bh=ELh4r+k/EoX5uc+YAlcCKFPvHu9PLbkA+ba/nx73PE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S+9uwbmPNpnm9EbMFtzh6otVEiW6C/6NFpqdIB4KyuokS0tMXAKiF/Xd5eiDNUGjP
	 X8DfexMU2XXm+Dv0TcO+BtgHWpQljhl8ICboVUgjt5LAHHwLy6/bUOJCfjzJAGuQ9o
	 n2QWry/78j4Fjf4F74UCPh9T6bqWGFec6QcEsVxHTexoz0QhYwbU9hYxoG6jQDsdW+
	 LNU3aQx6B2sqhY1Jr5deNuRKJpxR/S6lGmBPrGSdtsw92zQ/BvK+Nz3VEP9ksghCcu
	 Un5CNSOCYr+KU0oAk2eQUbPQITDDHhZHB+3/NPOqOIBzbYF1qpl0QgsCm9abb45cQf
	 DKwLu4qFUqnnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Huacai Chen <chenhuacai@loongson.cn>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] LoongArch: Don't init & online empty nodes
Date: Wed, 11 Nov 2026 10:26:34 -0500
Message-ID: <20261111152616.2629730-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055532-failed-6.1-87c6d144bc7b@kernel.org>
References: <20261107055532-failed-6.1-87c6d144bc7b@kernel.org>
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
[ sashal: Omitted the fake_numa_init() hunk because the function and its device-tree boot path are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/loongarch/kernel/numa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index f7ffce170213e..8774d216191e9 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -417,8 +417,10 @@ int __init init_numa_memory(void)
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

