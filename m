Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0362D39890A;
	Tue, 13 Oct 2026 06:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872935; cv=none; b=WU+GOzJw8dfFxYYgZUQC2/lj5IuQOWextEIPrPLEZT/5L3/a7SYuogydkxyjKcq05g5HajKcdkAF7xUyzhyZd86jhhMcoWzMZPrNsetWhqajCR+ydq74SajhNlEZUrQcANeNEAnGL7C1HQPSxTG1BDd8c7ZL+t+B2Ko5Fj8kDZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872935; c=relaxed/simple;
	bh=r7L/wpvW6OUHmZRiByBkrxsFi6xyWpZf9I6Fbv+y7DY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FOS6rBxGRRZXr4dNMTDwVSxXOr98sq5puIJkChPn6shFYaXjx3WJdjZYCo3zxGDl/Fmy68f5DZifRAH6jw6sDdhZGWqgivIfdN9fsTVuildVIoNlL7r51LnP3WxYGECydrRHBJIfDWHgVG0e58zRnQkHdpPy2nJMA/hfZqs85ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.159])
	by gateway (Coremail) with SMTP id _____8DxOvCkz81qTz8VAA--.61815S3;
	Tue, 13 Oct 2026 14:28:52 +0800 (CST)
Received: from kernelserver (unknown [223.64.68.159])
	by front1 (Coremail) with SMTP id qMiowJDxxMyZz81qkLcrAA--.65201S2;
	Tue, 13 Oct 2026 14:28:52 +0800 (CST)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Don't init & online empty nodes
Date: Tue, 13 Oct 2026 14:28:34 +0800
Message-ID: <20261013062834.60797-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxxMyZz81qkLcrAA--.65201S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj9xXoWrZFWrtr4fCFW8KF17KF4xKrX_yoWfuFc_Gr
	1xX3y5Gr4rJayIvws0kF4fX398u3y8Ka4FkFn2kF4xAw15Jws8Jr43X3Z8Ar90gFZ3urZx
	C3yUWF93Ar4UtosvyTuYvTs0mTUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwA2z4x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
	AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7_MaUUUUU

Don't init & online empty nodes without any CPU cores (and memory), in
this way "lscpu" will not display confusing empty nodes.

Cc: stable@vger.kernel.org
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/kernel/numa.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index c96c53623715..a38fccc76087 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -244,8 +244,10 @@ int __init init_numa_memory(void)
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
2.52.0

