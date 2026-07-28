Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED3E3A6B8A;
	Tue, 28 Jul 2026 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785218513; cv=none; b=WEBUxlDMLQe+PDtregRjGQj0gcfhNR58XcL1BEbxDYTui/IalkYfSTwalK88/9di4/q0MN9R9HUZq1YPzV20Y7r8DvcakGGOVNYYYbsCENmeg+yt8x+2aOL/nBT1LfIjpbc1lcUTRzSzat+fS4A910OCwRRxWoVa166DjybHCvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785218513; c=relaxed/simple;
	bh=SzxEyo/hYfX4/AUIHToFD3ppS8fz80XoVfp4+P0Fylw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GRXt7vSjc9mUS9Gm+8GbYDcInxoneR5m7xqCkoCfq0N3ZpmxhJdwyZT31MwPxAw8TyHaTle1A82micRmxAogqGzuwe9yt7JGd6CNpI9c+Lc4meio7eknK7CIG606pK9BpgcfkdzQE77jVwhdqciYNt+gsJZGOilDVBEO9plGrP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=hHEm5IPE; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="hHEm5IPE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-ID:MIME-Version:Content-Transfer-Encoding; bh=x5Iau
	e0edy3YpK0ZIF+qvdQ8Y8pltM+AfCI526ouugQ=; b=hHEm5IPENXuyT9AMzk5xJ
	BipJc6b02PqwzT2jLRfVCKKt30fhYLqGs9c+ZrrUf9fzzeDHIGJl3A4GQiSj8jUF
	I+Ie59acw343Ae8nrd/m83Y7jsS6J89ecivsL/0Ugc8M6dssPARK9aSmHwukIQ8B
	rlvZs++KKfHFK+5ZD9AqVg=
Received: from localhost.localdomain (unknown [121.225.135.236])
	by web3 (Coremail) with SMTP id ygQGZQBHGBexRWhqwyVEAA--.33059S2;
	Tue, 28 Jul 2026 14:01:23 +0800 (CST)
From: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>,
	Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>,
	Ke Xu <xuke@tsinghua.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH net] nexthop: account nexthop allocations to memcg
Date: Tue, 28 Jul 2026 14:01:11 +0800
Message-ID: <20260728060112.30367-1-zhaoyz24@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygQGZQBHGBexRWhqwyVEAA--.33059S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy8Ww4fAry5CFyUZw4Dtwb_yoWrJFWxpF
	WrA34kJFW3Jwn5uFsYyr4j9a1akw4vkry7CF1aka40vwnxKr1rAasrta4Yvan5uFy8GF1F
	qFWqkw15t3yjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9m1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r47MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0Jj7VysUUUUU=
X-CM-SenderInfo: 52kd05r2suqzpdlo2hxwvl0wxkxdhvlgxou0/1tbiAQECAWpn2jQ2FAABsD

The nexthop creation path allocates struct nexthop, struct nh_info,
group storage, resilient bucket tables, transient notifier tables and
per-group stats without memcg accounting. As a result, a task with
CAP_NET_ADMIN can create nexthops and resilient groups whose kernel
memory is not charged to the task's memory cgroup, so memory.max does
not constrain this part of the workload.

A QEMU reproduction with Docker confirmed the problem. A container
granted CAP_NET_ADMIN and limited to memory.max=128M could repeatedly
create resilient nexthops while memory.current stayed at 589824 and host
VmallocUsed rose from 67044 kB to 231860 kB.

Fix this by charging the nexthop creation-path allocations to the
caller's memcg with GFP_KERNEL_ACCOUNT / __GFP_ACCOUNT, including the
per-group stats allocation added later. With this change, the same
workload hits memcg OOM with GFP_KERNEL_ACCOUNT in the allocation path
and host VmallocUsed stays flat at 67044 kB, so memory.max constrains
the workload again.

Fixes: ab84be7e54fc ("net: Initial nexthop code")
Fixes: f4676ea74b85 ("net: nexthop: Add nexthop group entry stats")
Cc: stable@vger.kernel.org
Reported-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Reported-by: Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>
Reported-by: Ao Wang <wangao@seu.edu.cn>
Reported-by: Xuewei Feng <fengxw06@126.com>
Reported-by: Qi Li <qli01@tsinghua.edu.cn>
Reported-by: Ke Xu <xuke@tsinghua.edu.cn>
Assisted-by: Claude-Code:GLM-5.2
Signed-off-by: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
---
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 44fe75004cac..c8685c583579 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -169,7 +169,7 @@ static int nh_notifier_res_table_info_init(struct nh_notifier_info *info,
 	info->type = NH_NOTIFIER_INFO_TYPE_RES_TABLE;
 	size = struct_size(info->nh_res_table, nhs, num_nh_buckets);
 	info->nh_res_table = __vmalloc(size, GFP_KERNEL | __GFP_ZERO |
-				       __GFP_NOWARN);
+				       __GFP_NOWARN | __GFP_ACCOUNT);
 	if (!info->nh_res_table)
 		return -ENOMEM;
 
@@ -533,7 +533,7 @@ static struct nexthop *nexthop_alloc(void)
 {
 	struct nexthop *nh;
 
-	nh = kzalloc_obj(struct nexthop);
+	nh = kzalloc_obj(struct nexthop, GFP_KERNEL_ACCOUNT);
 	if (nh) {
 		INIT_LIST_HEAD(&nh->fi_list);
 		INIT_LIST_HEAD(&nh->f6i_list);
@@ -548,7 +548,7 @@ static struct nh_group *nexthop_grp_alloc(u16 num_nh)
 {
 	struct nh_group *nhg;
 
-	nhg = kzalloc_flex(*nhg, nh_entries, num_nh);
+	nhg = kzalloc_flex(*nhg, nh_entries, num_nh, GFP_KERNEL_ACCOUNT);
 	if (nhg)
 		nhg->num_nh = num_nh;
 
@@ -565,7 +565,8 @@ nexthop_res_table_alloc(struct net *net, u32 nhg_id, struct nh_config *cfg)
 	unsigned long size;
 
 	size = struct_size(res_table, nh_buckets, num_nh_buckets);
-	res_table = __vmalloc(size, GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN);
+	res_table = __vmalloc(size, GFP_KERNEL | __GFP_ZERO | __GFP_NOWARN |
+			      __GFP_ACCOUNT);
 	if (!res_table)
 		return NULL;
 
@@ -2799,7 +2800,8 @@ static struct nexthop *nexthop_create_group(struct net *net,
 			nhg->has_v4 = true;
 
 		nhg->nh_entries[i].stats =
-			netdev_alloc_pcpu_stats(struct nh_grp_entry_stats);
+			__netdev_alloc_pcpu_stats(struct nh_grp_entry_stats,
+						  GFP_KERNEL_ACCOUNT);
 		if (!nhg->nh_entries[i].stats) {
 			err = -ENOMEM;
 			nexthop_put(nhe);
@@ -2943,7 +2945,7 @@ static struct nexthop *nexthop_create(struct net *net, struct nh_config *cfg,
 	if (!nh)
 		return ERR_PTR(-ENOMEM);
 
-	nhi = kzalloc_obj(*nhi);
+	nhi = kzalloc_obj(*nhi, GFP_KERNEL_ACCOUNT);
 	if (!nhi) {
 		kfree(nh);
 		return ERR_PTR(-ENOMEM);

--
2.47.3

