Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794936577;
	b=nvW9szQsneSuzFnXb80uSM0RIjtSqqVV/GHW4NTJWUKSq8rWwLubPSIRPrQWbxZWqOil
	 sG56pYCIdpSsz/tFNOQ0Ary6TGYAHPUGrH5wvYJVUo6h/P/lNM0+u9IdXbrUM3CtrZszV
	 ONJXc0rVRzpd9r6cnax/YWq+OEzRe1GDKC6/LN4Dhy7u9WEPIEccStOzrjR1D5u3fst3k
	 uvLufpQx2jG/d1DJ8GRAfjSeFC3X4VniwL1vYFy10GrE3h6PUT9janIxC9O6X4miP//lF
	 h7l2c7vmdXZk8yR7HnV/xJdfr+2w35cJ5H1Bdl9kXStAAg7EWmBZeJn9uGDp05a8/PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JHWpGOTp8ITv5cctf6TSThxhxXqYa8XzuutCrYWNpkQ=;
	b=YVGs5vzTrIOsFKfS4SZS+hfv5BemXjG6QiTyAxbPzhg+DJzAtJgi9HrJ4Oep+p02cnfi
	 aZyMiXpzblQ2NFtLrXnmxq0R9HdaAQjMZ8oG7CCW6XO7VgDRP1yUXJBX+lr7l9gDWHUSE
	 W//tBOf2U3BxXYaWmjlepeCafw+dGWtisvR+ZkqKyqituoUqtLv9ju3PHPlTvwy1LS/+v
	 IwXklMuAv27fVnhQuWpJInPTwaR/N6XHXNsezvQRetjcvH3Oia3dEPKGSag0Dp8pIFeVd
	 XKFo1csMPsxjn2Pz/srJZVnS9h0BUaezBqmehs/owNcRMYOgzcUx3IEhH2E/zQPm1kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFAlhZaf;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C40606A32C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 17:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07C40606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QFAlhZaf
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-3282db206d3so211759eec.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 09:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936576; x=1795541376; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JHWpGOTp8ITv5cctf6TSThxhxXqYa8XzuutCrYWNpkQ=;
        b=QFAlhZaf6mH704TXlWZwc+wJGhbOYi3lFSuYjnaYSHXTWKToweJxWHp30TN9w8AeyP
         UyfCGfZF5sqzRXYHprcaxgpOKn6Whq8uSMgLz8hBchchgIBKoMgIVr0/yISUg0vZMj5X
         uWtA04TGPGhkylR1HxZmQGEn0Vb5tm7wKFEQkCmH8kaPQ1hRs+b4yj9sQnX2HftYGG79
         CSl7d4LctBXOdtxKePJRzN9vKaUvDAy2d+B0ROcDfzYJAeG1IwXLw9+QdiIlDgDqv8D6
         AbRfr9fhsDQRM4/HHGD88Sn5UjVIMW9yhbQzKXubit2YjbXU2dX/wmSk6TBGO+8P6HvY
         K2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936576; x=1795541376;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JHWpGOTp8ITv5cctf6TSThxhxXqYa8XzuutCrYWNpkQ=;
        b=aQy1osXM7yfCIiyEarXKQQFSShcESOZvcelOMSjzG9NId3hlgIdaKYEyxuv8nprPg9
         gFauwBafQ2AVQdMbGXXjWhdcN/FOM8+K9+dEdj6lBL2T99Rt0Carse6cQN5Vv9cOpBR3
         /jcMgd9epXNZhmBljpm1CfT9e2TMEbkHm2nVSvnJJnKBIK8BtSjB6YC2fp/M9sXR4F2O
         Gft3el9lNBbVXpOPprHVlGcCyMGVxqEda82pUbiQHyRVycsAF6uRehDErXKCNqNsUngn
         yoVX8MzRfds7okXsxR0xgwiZtlzMpBNI0ztUjiREqAC8grTLFi4T7FUD7HQa/rzrojAs
         UINQ==
X-Forwarded-Encrypted: i=1; AL+hErE6epYM4D4EIZVCmxJV/eRGSW+uu2iwxMoBgLJj5u4olIUKCnfvOrmF6SpElXST9hrQNhZRSDU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8EcI+ivgyeGf+u+Qq+NXGX2pfvte+C2cv02BoVrBMG5X5m1Wa9
	z5qSQvroFNoqRWn1bKX4j1OLPdzM6demdd1ILiXCVpzE/80X6hnFPBUFp56IxQ==
X-Gm-Gg: AYBFou1tpofSS6QJb5Qmi5fqyMPwczn0/c6jyW/6bYPhh3nU2EEqar7MTae8L2HAr0P
	9znFLR6XA2K2VlbmgR93ln/CDy8sv3nBuMQXDk+Mz/04G50PIoV0noq6erEEY6qNohlAC/GU/Xq
	T1Z/vOYs06YTvDJFLwlD33DV51PmFNGLQymMqfY9CjUZ1cmzU0eVw9Y+On3WtPDzOTHmxJGcPce
	CTivvPTd+ntZtn/Bc/HTUFnPBSH9IXAsH+06uOrBjXIaqnt3pX7Qpu1taAuqVickqqEGPGAvd6p
	y43xRXw7TGNuJ4Ph30vNSSMBVHZpZNzf+dfD82Fj+4HSMLI6qjKOpZFjDFQVx5iP699K6og8a2y
	qRry7ZqjsMILmW9eL0lmfwM5Q5ccNrYwBDzkC4IoM2KH9nnhZ6Mf2jlQh5gc777fP4xk0dMJ8Lr
	fq9sfgd3CiXY/KVr/lj5WKj5t/6AID+jBqUhs2Oqv7DxEVcofoF0RKYQJeWCH+XM958dl4ZcJHB
	7sb4o+Y6p3CZizTOZiyfxyj2lVVeD4yGE1Y76c2s8k31rwdwy6PQKjEhWcJGjWfsyYS1SxBSf93
	6uNSpHn8Ggaeu989jIVMMVeTB5SPFmZIjJ5hb7OaZ9d/3B4Uq9C5ZAsTc4aFacD5ehS0KXbogw=
	=
X-Received: by 2002:a05:7301:4d07:b0:369:21a:dcca with SMTP id 5a478bee46e88-3827f5972d9mr113314eec.10.1794936575989;
        Tue, 17 Nov 2026 09:29:35 -0800 (PST)
Received: from ubuntu ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37955f02ff0sm44163997eec.16.2026.11.17.09.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:29:34 -0800 (PST)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	WANG Xuerui <kernel@xen0n.name>,
	stable@vger.kernel.org
Subject: [PATCH] LoongArch: Online memory-only NUMA nodes
Date: Wed, 18 Nov 2026 02:29:23 +0900
Message-ID: <20261117172924.3768845-1-ekffu200098@gmail.com>
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
Content-Transfer-Encoding: 8bit

init_numa_memory() does not online a memory-only node, because it
onlines a node only if it has CPUs.

So online a node if it has any memory or CPUs.

Fixes: 87c6d144bc7b ("LoongArch: Don't init & online empty nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 arch/loongarch/kernel/numa.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/loongarch/kernel/numa.c b/arch/loongarch/kernel/numa.c
index 7dedc134ddfe..595cc15203a3 100644
--- a/arch/loongarch/kernel/numa.c
+++ b/arch/loongarch/kernel/numa.c
@@ -140,20 +140,25 @@ void numa_remove_cpu(unsigned int cpu)
 	cpumask_clear_cpu(cpu, &cpus_on_node[nid]);
 }
 
-static void __init node_mem_init(unsigned int node)
+static bool __init node_mem_init(unsigned int node)
 {
 	unsigned long start_pfn, end_pfn;
 	unsigned long node_addrspace_offset;
 
+	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
+	if (start_pfn == end_pfn)
+		return false;
+
 	node_addrspace_offset = nid_to_addrbase(node);
 	pr_info("Node%d's addrspace_offset is 0x%lx\n",
 			node, node_addrspace_offset);
 
-	get_pfn_range_for_nid(node, &start_pfn, &end_pfn);
 	pr_info("Node%d: start_pfn=0x%lx, end_pfn=0x%lx\n",
 		node, start_pfn, end_pfn);
 
 	alloc_node_data(node);
+
+	return true;
 }
 
 #ifdef CONFIG_ACPI_NUMA
@@ -246,10 +251,8 @@ int __init init_numa_memory(void)
 		return -EINVAL;
 
 	for_each_node_mask(node, node_possible_map) {
-		if (!cpumask_empty(&cpus_on_node[node])) {
-			node_mem_init(node);
+		if (node_mem_init(node) || !cpumask_empty(&cpus_on_node[node]))
 			node_set_online(node);
-		}
 	}
 	max_pfn = PFN_DOWN(memblock_end_of_DRAM());
 	max_low_pfn = min(PFN_DOWN(HIGHMEM_START), max_pfn);

base-commit: 422e532809572ba1043192bf6a0c653bc68b3140
-- 
2.53.0

