Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793074940;
	b=AYWZZocGLbM2HRZLDI20zGe+OWydIYeTnkWD8bdpVL7R0vQDBnSIg6AUCuTzaF+mb7l7
	 NZJ6ipXcC4ftUaEfDMQ6i6MJ/G+H/aLn51HdRIa1RTezWAiIyNvU1fNS2te+BqHf8lvTU
	 Sv+v/jQjGzwH0a2AdkgN3UQfMzCTJ5WOuToN9yHDN+5D8w+MWQ2IOUMQV6TXASOwuoOD9
	 jt5kQ1WNgNYm8SQ7pBKWIO4+STyPkLD1PZdxcCOyw/J2x2PdXVAAn7jX88lsMv6GlyuCb
	 aGsC49KDO8OJPweNdh0IcuYN93uCxcnKNSFDBQz0lqL1+yXEHhHKqnb56UxTORrTizQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793074940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YK5LaBMFpVaVrqLIEsL57jG1VfZYq1+Fawu+FzQQ2vo=;
	b=zGBDeJk4R3VBjybAsZae3nuwGdKQHdylCOOxVWAjRPq+iCC9dnwq7ldUXKTN6DdK3ykI
	 Y/KWx5KpPRoFpqAjsM89A77QM33/pNrYwJ4UsUK9piwUlLY/AWnzp8KdCL2+Wg99eI20O
	 cQxtgEVi6iNsnTNW+QVEorSeEeBS4qiiV1nYQHuOOOWGy8mKet6imQ4A9hXKQldo8d5lI
	 8TpHINnzBNiI9PluCfX4BueAFG2STNPWUNTpNbvHzx+j36WrUhY2l08n5mSQMgNCv+riY
	 EMjVL4QAWGZx3PTjNfidN/Ie2frQZUXs8+YovlPiZidYwg3qI2S/RWG0V49uxaSTbBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GPE8+0kF;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65130606A324
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 04:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 65130606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=GPE8+0kF
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-93f22a8515eso339181385a.2
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 21:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1793074938; x=1793679738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YK5LaBMFpVaVrqLIEsL57jG1VfZYq1+Fawu+FzQQ2vo=;
        b=GPE8+0kFu72jV0ihXCtD42paUML7FqexI5dNiWXTbUjvgLoA8C2CfR6UyzdskAt9Ev
         2MV0zRW5gCY3jajbt739cG24dtp1Dz9n4MlCDA1kMT1u6p0C+PgGoUV9jiK4eg2HTw6T
         3YhOj8hvZ8xH5SP8AWZVR7Y0SRPmE5sczojI3/N/ou2x/IMa3+Hq8YSSUq2hFJzKPJkp
         VFzX7W9Ux1E7/pl+z3pitE7jUTX+z1IA92Hv1bN/rtftaqq7PknPMs9whxmef3ZoO9at
         UHcVab/32SbQkG6ZjbgjXVZQznveGCDRjaO0k+7WH9CX0MU5yFA3UQi/rjLfSpSO20JC
         nslw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793074938; x=1793679738;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YK5LaBMFpVaVrqLIEsL57jG1VfZYq1+Fawu+FzQQ2vo=;
        b=lrI3b+VJ6foBVShpwUaPuFD3+EbnDm/pKwGwYnJIEH9/8N9bil67EITMqRosDRUmlH
         ixxO/NQ8zuofpxy0S4k/+tiI9lt4Jb06PJxdBncIf17soo/13KOnvrvhwcDk+jDimL3g
         54NeQKQ1YPxtfnnEo2GJhPUmEbivzCe+i5LWywJ5Cr7iwCrWKvZK5Xty8bh874ZjpAeW
         5hyFEI0O68TikDtsYxUs74Msb26qr4vK6aNxsfHsl3kippxCA0WTPXCrgtbLR7zSffms
         SJJYJhPN1UAVCIzRUO/M0Zl+0a5RySOtB19X8wdmZxA9rKhqcR71hddJm7oR7hYXnand
         cddg==
X-Forwarded-Encrypted: i=1; AKwUvBzw1P7uyrQGPoWqdh2qGeh3rjGIvE5yCP5mNsvHanuI5fr+P3WCoHrurUSRXFxXdy62GV5Z4Wc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJlUjBZVBXdkoVspNPUv6pb/DklhdRGZp5DeiDyTKxV40OpPmEj
	d9nrSbXlTT4xYOI+JN577LshHYJtYXDqCMtM5tocw4RM0zbn4pTWtCPgdZfXizBrpvs=
X-Gm-Gg: AYBFou2npxD46K2TbC+R7dy1MJBdYGty1ZWv2FBg47EUZlkijbnoW6ea5Uiu/1WOG5/
	nynQH9Gs0UMRqbweSuN0huN56btZkccV1piLDt0og3MmWTzW5kBK4Jm8aD7NP6yqCdVGq4xhgL8
	h9cAe47Mr5865LvhVAUhQ8Doeh1P95mTnYhk10Rp9kvR9S5wX4PenokkkvLj9WFBeZB1tYSMi++
	YHSlNxwMtyyQDh8gi941NfQmvVX3aFJ2dHY5OzLKMy7a2r10deYY6z7xGMWXAGqhEB3YNztwchT
	OhPaS+nJPmao5jKiXjsHgGv4WU8i9pMl3YMMBFMflyCGuvPymGIxSBhwrxVxRjHpz2I7djgsG9f
	2l1n0QsD2lNok6PZPYM3VfK2lwVBpm7RHcyDl6v7jlUzsL2uRdCLM40wD40XsZd2zKZnaIPT3Cg
	lk7P+bu4Rb0f0WcGoMUJNLPDNxc0DKgryZ3+b35rIgBSAEK+yptRPmzzuYxuuxoA+HWNVnW2LKW
	W0PtG3tuUH3h2vtTzRE5gPwQGP0GREmEuk6F96IywXMU+zrTH8CQ4A+QpFXa650EF6IerhVump4
	StpEI0svJlyewynMvHcmuv65rfPSvS5xgnnCvihxxA==
X-Received: by 2002:a05:620a:4549:b0:93e:f4f4:346 with SMTP id af79cd13be357-940ef8ef6e5mr1336003385a.39.1793074938389;
        Mon, 26 Oct 2026 21:22:18 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F.lan (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c47bd01cdsm91139676d6.7.2026.10.26.21.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 21:22:17 -0700 (PDT)
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	kernel-team@meta.com,
	akpm@linux-foundation.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	brendan.jackman@linux.dev,
	hannes@cmpxchg.org,
	ziy@nvidia.com,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	david@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	rppt@kernel.org,
	osalvador@suse.de,
	muchun.song@linux.dev,
	iamjoonsoo.kim@lge.com,
	anshuman.khandual@arm.com,
	stable@vger.kernel.org
Subject: [PATCH 2/6] mm/page_owner: hold off memory offline while a page is read
Date: Tue, 27 Oct 2026 00:22:00 -0400
Message-ID: <20261027042204.3741307-3-gourry@gourry.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027042204.3741307-1-gourry@gourry.net>
References: <20261027042204.3741307-1-gourry@gourry.net>
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

Reading /sys/kernel/debug/page_owner while memory is removed can oops.
read_page_owner() checks a pfn with pfn_valid(), and print_page_owner()
can sleep in kmalloc() before it reads the struct page:

  CPU 1 (read page_owner)             CPU 2 (remove the memory block)
  pfn_valid(pfn)
  page = pfn_to_page(pfn)
  page_ext_get()
  page_ext_put()
  print_page_owner()
    kmalloc()
                                      offline_pages()
                                        remove_pfn_range_from_zone()
                                      arch_remove_memory()
                                        frees the vmemmap
    get_pageblock_migratetype(page)

  BUG: unable to handle page fault for address: ffd4000006000000
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  Oops: Oops: 0000 [#1] SMP KASAN
  RIP: 0010:__get_pfnblock_flags_mask+0x3e/0x2b0
  Call Trace:
   <TASK>
   get_pfnblock_migratetype+0xf/0x20
   read_page_owner+0x629/0xf00
   full_proxy_read+0x102/0x190
   vfs_read+0x153/0xcd0
   ksys_read+0xe4/0x1b0
   do_syscall_64+0xbd/0x630
   entry_SYSCALL_64_after_hwframe+0x4b/0x53

Offline alone faults the same way on DEBUG_VM kernels.  The page_ext is
safe; offline_page_ext() frees it after an RCU grace period.

Check the pfn with pfn_to_online_page() inside a pfn_walk read section,
which offline waits for, and move kmalloc() and copy_to_user() out of
it, since offline waits with the hotplug locks held.  A full read of
page_owner in a 5G guest takes 1.36 s before and 1.34 s after.

With a kprobe sleeping the reader on a DIMM pfn across an offline or a
removal, base faults in 3 of 3 runs of each and this patch in none.

Fixes: 48c96a368579 ("mm/page_owner: keep track of page owners")
Cc: stable@vger.kernel.org
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
---
 mm/page_owner.c | 45 ++++++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index cfc31c92d7657..d2c0b831fcd3b 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -13,6 +13,7 @@
 #include <linux/memcontrol.h>
 #include <linux/sched/clock.h>
 
+#include "internal.h"
 #include "page_alloc.h"
 
 /*
@@ -600,20 +601,14 @@ static inline int print_page_owner_memcg(char *kbuf, size_t count, int ret,
 #endif
 
 static ssize_t
-print_page_owner(char __user *buf, size_t count, unsigned long pfn,
+print_page_owner(char *kbuf, size_t count, unsigned long pfn,
 		struct page *page, struct page_owner *page_owner,
 		depot_stack_handle_t handle,
 		struct page_owner_filter_state *state)
 {
 	int ret, pageblock_mt, page_mt;
-	char *kbuf;
 	enum page_owner_print_mode print_mode;
 
-	count = min_t(size_t, count, PAGE_SIZE);
-	kbuf = kmalloc(count, GFP_KERNEL);
-	if (!kbuf)
-		return -ENOMEM;
-
 	print_mode = state->print_mode;
 
 	ret = scnprintf(kbuf, count,
@@ -637,14 +632,14 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 	if (print_mode != PAGE_OWNER_PRINT_HANDLE) {
 		ret += stack_depot_snprint(handle, kbuf + ret, count - ret, 0);
 		if (ret >= count)
-			goto err;
+			return -ENOMEM;
 	}
 
 	if (print_mode != PAGE_OWNER_PRINT_STACK) {
 		ret += scnprintf(kbuf + ret, count - ret, "handle: %u\n",
 				 handle);
 		if (ret >= count)
-			goto err;
+			return -ENOMEM;
 	}
 
 	if (page_owner->last_migrate_reason != MR_NEVER) {
@@ -657,17 +652,9 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 
 	ret += snprintf(kbuf + ret, count - ret, "\n");
 	if (ret >= count)
-		goto err;
-
-	if (copy_to_user(buf, kbuf, ret))
-		ret = -EFAULT;
+		return -ENOMEM;
 
-	kfree(kbuf);
 	return ret;
-
-err:
-	kfree(kbuf);
-	return -ENOMEM;
 }
 
 void __dump_page_owner(const struct page *page)
@@ -734,10 +721,17 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	struct page_owner *page_owner;
 	depot_stack_handle_t handle;
 	struct page_owner_filter_state *state = file->private_data;
+	ssize_t ret = 0;
+	char *kbuf;
 
 	if (!static_branch_unlikely(&page_owner_inited))
 		return -EINVAL;
 
+	count = min_t(size_t, count, PAGE_SIZE);
+	kbuf = kmalloc(count, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
 	page = NULL;
 	if (*ppos == 0)
 		pfn = min_low_pfn;
@@ -766,7 +760,12 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 			continue;
 		}
 
-		page = pfn_to_page(pfn);
+		/* Offline waits for us before it poisons the memmap */
+		guard(pfn_walk)();
+		page = pfn_to_online_page(pfn);
+		if (!page)
+			continue;
+
 		if (skip_buddy_pages(&pfn, page))
 			continue;
 
@@ -825,14 +824,18 @@ read_page_owner(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 		page_owner_tmp = *page_owner;
 		page_ext_put(page_ext);
-		return print_page_owner(buf, count, pfn, page,
+		ret = print_page_owner(kbuf, count, pfn, page,
 				&page_owner_tmp, handle, state);
+		break;
 ext_put_continue:
 		page_ext_put(page_ext);
 		cond_resched();
 	}
 
-	return 0;
+	if (ret > 0 && copy_to_user(buf, kbuf, ret))
+		ret = -EFAULT;
+	kfree(kbuf);
+	return ret;
 }
 
 static loff_t lseek_page_owner(struct file *file, loff_t offset, int orig)
-- 
2.53.0-Meta

