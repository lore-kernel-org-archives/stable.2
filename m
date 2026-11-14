Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794692074;
	b=VbtEJtj4dxmm6xdvsMRzimJYS7MORdCig/CTb6uHri73UI2XSKuW0Mjy+PcFsd/ExtG4
	 buc9cS5ffv803z/Xt8IBhiUpZZlHmv/mZGCB1ohbPFceg3UZH5KoT1GvOoUQHmGiD69Lr
	 mBQUdfHR7vBrQZuqVm9t9g5EKLC0KSqWh9JWxVe89UdtkRmT44B4oZJV33xi7pxgWYIfU
	 FnkQ26cegrKfVxS5kgtCILexX20U7aDIoopB4WxuHYIqP06qjOWgztyLXt5C3LKeGqTxW
	 2JemgrGG5F2RDH4DrgdjtV1MZSuuPSOePTPJxoR2lyp2cMZryUHnMhZqU93gJfxdrTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794692074;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yZUmp1LZoHMXuee9jh+/vX8YkL9aIIb9cqBG3xPyxH0=;
	b=2QbwYdsSAg3eBn93SkGrr+0NvnsKK5sLgHtO/09W5NvATwel8+ognCI1k3+mp6BZOOK3
	 rc91jNoBfzbQ9jPbqRbk6oMCe8eu67nzMvtVn2QstVRTe+07ibFi46NVpd7TZKyX4907N
	 cGJQfg/1wuCHvvhLCy24lb2qcfyagrGxpizO/Jg3CApMbX0eGjEq3nn+6eF+4CzRiOt8D
	 53O4k4JkS1SmUfZEzTWDK9eMoaH6fWIT2knptUoUYQngxJxPzAdAewMqCabjcAAddeOoB
	 YYYa0X70tZjN6DmzzcWbXFpkrsvBKuxACAMfF0Oo1MGapwdKjULB4vhRl5HZ3y4qBBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnnlePi2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455C7606A32D
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 21:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZnnlePi2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34D51F000C4;
	Sat, 14 Nov 2026 21:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794692073;
	bh=yZUmp1LZoHMXuee9jh+/vX8YkL9aIIb9cqBG3xPyxH0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZnnlePi2HF3tsFPPOazft/a0hDbnksZ6yotr8c4G+9EB3wWWySQv8LdgUSnr7JjFF
	 O03pQhDQKT7m2xPRDZk3IQyor0C5SHJ3HL8IttzALODiLCDIT79lFRJXEpC6Y6MWVj
	 xYRGKPlu2nIKm35BFVcTy7L2ujwaalE9qBMI6wK6QbhLU01jaF+xtcPlGW4IovQS2Q
	 kdt1VSv+BGzOmyizDB0jzLkTGIL7C9l6qluI8CNfZJHvlG93if5uCrTcScX1RsjZPG
	 awGCXuSjcomH1rLE4LM+EujsYTfrRUgpRwokFYboZsSzqRjoDN5d+wxTWK5NT7jaUY
	 kLs1EFOaPKzRQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] mm: hugetlb: move hugeltb sysctls to its own file
Date: Sat, 14 Nov 2026 16:34:29 -0500
Message-ID: <20261114213405.501279-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201650-failed-6.1-dfb190302d2b@kernel.org>
References: <20261109201650-failed-6.1-dfb190302d2b@kernel.org>
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

From: Kefeng Wang <wangkefeng.wang@huawei.com>

[ Upstream commit 962de54828c5bb100eb8de881b79ed9c8b7468c0 ]

This moves all hugetlb sysctls to its own file, also kill an
useless hugetlb_treat_movable_handler() defination.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Stable-dep-of: dfb190302d2b ("mm/hugetlb: fix mremap move length truncation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/hugetlb.h |  8 -------
 kernel/sysctl.c         | 32 --------------------------
 mm/hugetlb.c            | 51 ++++++++++++++++++++++++++++++++++++++---
 3 files changed, 48 insertions(+), 43 deletions(-)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index aa089e58bc41f..a9f175cda955c 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -137,14 +137,6 @@ void hugepage_put_subpool(struct hugepage_subpool *spool);
 
 void hugetlb_dup_vma_private(struct vm_area_struct *vma);
 void clear_vma_resv_huge_pages(struct vm_area_struct *vma);
-int hugetlb_sysctl_handler(struct ctl_table *, int, void *, size_t *, loff_t *);
-int hugetlb_overcommit_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int hugetlb_treat_movable_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-int hugetlb_mempolicy_sysctl_handler(struct ctl_table *, int, void *, size_t *,
-		loff_t *);
-
 int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			     struct vm_area_struct *new_vma,
 			     unsigned long old_addr, unsigned long new_addr,
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 5dd6fd4b48c81..e1a964ef48617 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2162,38 +2162,6 @@ static struct ctl_table vm_table[] = {
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
 	},
-#endif
-#ifdef CONFIG_HUGETLB_PAGE
-	{
-		.procname	= "nr_hugepages",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= hugetlb_sysctl_handler,
-	},
-#ifdef CONFIG_NUMA
-	{
-		.procname       = "nr_hugepages_mempolicy",
-		.data           = NULL,
-		.maxlen         = sizeof(unsigned long),
-		.mode           = 0644,
-		.proc_handler   = &hugetlb_mempolicy_sysctl_handler,
-	},
-#endif
-	 {
-		.procname	= "hugetlb_shm_group",
-		.data		= &sysctl_hugetlb_shm_group,
-		.maxlen		= sizeof(gid_t),
-		.mode		= 0644,
-		.proc_handler	= proc_dointvec,
-	 },
-	{
-		.procname	= "nr_overcommit_hugepages",
-		.data		= NULL,
-		.maxlen		= sizeof(unsigned long),
-		.mode		= 0644,
-		.proc_handler	= hugetlb_overcommit_handler,
-	},
 #endif
 	{
 		.procname	= "lowmem_reserve_ratio",
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9660566a1ba4b..459116c744a5a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -4270,6 +4270,12 @@ static void __init hugetlb_sysfs_init(void)
 	hugetlb_register_all_nodes();
 }
 
+#ifdef CONFIG_SYSCTL
+static void hugetlb_sysctl_init(void);
+#else
+static inline void hugetlb_sysctl_init(void) { }
+#endif
+
 static int __init hugetlb_init(void)
 {
 	int i;
@@ -4325,6 +4331,7 @@ static int __init hugetlb_init(void)
 
 	hugetlb_sysfs_init();
 	hugetlb_cgroup_file_init();
+	hugetlb_sysctl_init();
 
 #ifdef CONFIG_SMP
 	num_fault_mutexes = roundup_pow_of_two(8 * num_possible_cpus());
@@ -4656,7 +4663,7 @@ static int hugetlb_sysctl_handler_common(bool obey_mempolicy,
 	return ret;
 }
 
-int hugetlb_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 
@@ -4665,7 +4672,7 @@ int hugetlb_sysctl_handler(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_NUMA
-int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
+static int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
 			  void *buffer, size_t *length, loff_t *ppos)
 {
 	return hugetlb_sysctl_handler_common(true, table, write,
@@ -4673,7 +4680,7 @@ int hugetlb_mempolicy_sysctl_handler(struct ctl_table *table, int write,
 }
 #endif /* CONFIG_NUMA */
 
-int hugetlb_overcommit_handler(struct ctl_table *table, int write,
+static int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 		void *buffer, size_t *length, loff_t *ppos)
 {
 	struct hstate *h = &default_hstate;
@@ -4702,6 +4709,44 @@ int hugetlb_overcommit_handler(struct ctl_table *table, int write,
 	return ret;
 }
 
+static struct ctl_table hugetlb_table[] = {
+	{
+		.procname	= "nr_hugepages",
+		.data		= NULL,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= hugetlb_sysctl_handler,
+	},
+#ifdef CONFIG_NUMA
+	{
+		.procname       = "nr_hugepages_mempolicy",
+		.data           = NULL,
+		.maxlen         = sizeof(unsigned long),
+		.mode           = 0644,
+		.proc_handler   = &hugetlb_mempolicy_sysctl_handler,
+	},
+#endif
+	{
+		.procname	= "hugetlb_shm_group",
+		.data		= &sysctl_hugetlb_shm_group,
+		.maxlen		= sizeof(gid_t),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec,
+	},
+	{
+		.procname	= "nr_overcommit_hugepages",
+		.data		= NULL,
+		.maxlen		= sizeof(unsigned long),
+		.mode		= 0644,
+		.proc_handler	= hugetlb_overcommit_handler,
+	},
+	{ }
+};
+
+static void hugetlb_sysctl_init(void)
+{
+	register_sysctl_init("vm", hugetlb_table);
+}
 #endif /* CONFIG_SYSCTL */
 
 void hugetlb_report_meminfo(struct seq_file *m)
-- 
2.53.0

