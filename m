Received: from va-1-115.ptr.blmpb.com (va-1-115.ptr.blmpb.com [209.127.230.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9773D7A01
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 06:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791958628; cv=none; b=SEgHGyFtQijA61K9RG9rfwwcH1wAgGUcwUjVfWD3QNlJ7lkFogHu351z9P7N3U11WIyRxaCuusaw2u5HUgtwg+z1EnR1v/kCnO1Q6R/vAjCTLFqbDSj/ylIoCazCtj58oDmxg2pqJGxJesOzcavzd83ywyBkamju3dcxhRJRPiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791958628; c=relaxed/simple;
	bh=2wkkvCwsLPYNSBI1dLhT02mZ9ZH6l0gecfapIU7q4Z8=;
	h=From:To:Date:Message-Id:Content-Type:Cc:Mime-Version:References:
	 Subject:In-Reply-To; b=t/O4PhqaST7d0qb2xIkQEfq3rQU5ueGKpC3kSt5bmkt9M3MUY0wPkaR+EDfif8lts7AJZCMNGlP2aiU3V+BmbapnFpGzvy5ki/6qodRVcYyhOKjVrYM6gqWsHN7pvMyPVuPOSzPLG4D/SO1wmP5eRjImliz5/3KBvv7au7hG+EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=EU2qgfXX; arc=none smtp.client-ip=209.127.230.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EU2qgfXX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791958621; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=XUTyn0Rq67njZaj55ehmyaxuhFuRO8R3sEs8oQB0l2k=;
 b=EU2qgfXX0wf5f0pu4zP9tupA6E/sHVifia7MxsYY11jEgYynNYMGwko+u4trx7ByIZnSOP
 pVhtc5weRGd7ZAKIoOgC/hCeYGDEUFmT4Sv/rkszmEL9yvlNODPTLqUg4MCNUAw69nDBn5
 OpMnhK1wVxHhcS33UV0oMjlZ5igBt0TNefEEoPm+M8FnaJ1aT6KFKEeN8Uv/64Lny9yCId
 +qqcWbx8aiCFlDddTMyjf2o+swqecx2rr2zUSY7JiyhCqZcpjydJZkLoskWh1QYpveS3z7
 qxCHkWYe08w3xPcBkGdpqFG/wq54bD97so2gZrMPa5y27YK40iqaoyuvbuH2SA==
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
To: "Dev Jain" <dev.jain@arm.com>, <catalin.marinas@arm.com>, 
	<will@kernel.org>
Date: Wed, 14 Oct 2026 14:16:33 +0800
Message-Id: <24f01ac6-4935-4702-b6e8-52beff5feea0@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <ryan.roberts@arm.com>, <baolin.wang@linux.alibaba.com>, 
	<lance.yang@linux.dev>, <mark.rutland@arm.com>, 
	<akpm@linux-foundation.org>, <david@kernel.org>, <ljs@kernel.org>, 
	<liam@infradead.org>, <vbabka@kernel.org>, <rppt@kernel.org>, 
	<surenb@google.com>, <mhocko@suse.com>, 
	<linux-arm-kernel@lists.infradead.org>, <linux-mm@kvack.org>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20261013093600.54995-1-zhaogongyi@bytedance.com> <6a10b61f-5c4f-4d04-9742-97a358147c39@arm.com>
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid PTEs
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26acf1e5b+4fb24c+vger.kernel.org+zhaogongyi@bytedance.com>
In-Reply-To: <6a10b61f-5c4f-4d04-9742-97a358147c39@arm.com>
User-Agent: Mozilla Thunderbird

On 2026/10/13 18:13, Dev Jain wrote:
> 
> 
> Thanks, could you please give the code of the reproducer. That will
> save us some time.
> 
> 

Hi Dev,

Sure, sorry for not including it in the first mail.

The standalone reproducer I used is below. It assumes an arm64 kernel 
with CONFIG_ARM64_CONTPTE=y and a CONT_PTE_SIZE anonymous mTHP order 
available. When run as root, it tries to enable THP and the matching 
mTHP order through sysfs. These sysfs writes are best-effort; if the 
matching order is not available or cannot be enabled, the reproducer
may not hit the issue.

On a 4K-page kernel, CONT_PTE_SIZE is 64KB.

Compile and run:

       gcc -O2 -Wall contpte_guard_repro.c -o contpte_guard_repro
       ./contpte_guard_repro 100

On my unfixed KASAN kernel with panic_on_warn=1, the first iteration hit
the bad swap entry / swap_put_entries_direct() warning. With this patch,
100 iterations completed without warnings.

Here is the reproducer:

   #define _GNU_SOURCE
   #include <errno.h>
   #include <fcntl.h>
   #include <stdio.h>
   #include <stdlib.h>
   #include <string.h>
   #include <sys/mman.h>
   #include <unistd.h>

   #ifndef MADV_HUGEPAGE
   #define MADV_HUGEPAGE 14
   #endif
   #ifndef MADV_POPULATE_WRITE
   #define MADV_POPULATE_WRITE 23
   #endif
   #ifndef MADV_GUARD_INSTALL
   #define MADV_GUARD_INSTALL 102
   #endif
   #ifndef MADV_GUARD_REMOVE
   #define MADV_GUARD_REMOVE 103
   #endif

   static void write_file(const char *path, const char *val)
   {
       int fd = open(path, O_WRONLY | O_CLOEXEC);

       if (fd < 0)
           return;
       (void)write(fd, val, strlen(val));
       close(fd);
   }

   static void write_clear_refs(void)
   {
       int fd = open("/proc/self/clear_refs", O_WRONLY | O_CLOEXEC);

       if (fd < 0) {
           perror("open clear_refs");
           exit(1);
       }
       if (write(fd, "1", 1) != 1) {
           perror("write clear_refs");
           exit(1);
       }
       close(fd);
   }

   static unsigned long contpte_size(unsigned long page_size)
   {
       if (page_size == 4096)
           return 64 * 1024;
       if (page_size == 16384 || page_size == 65536)
           return 2 * 1024 * 1024;

       fprintf(stderr, "unsupported page size %lu\n", page_size);
       exit(1);
   }

   static void enable_mthp(unsigned long size)
   {
       char path[256];

       write_file("/sys/kernel/mm/transparent_hugepage/enabled", 
"always\n");
       write_file("/sys/kernel/mm/transparent_hugepage/defrag", "always\n");

       snprintf(path, sizeof(path),
            "/sys/kernel/mm/transparent_hugepage/hugepages-%lukB/enabled",
            size / 1024);
       write_file(path, "always\n");
   }

   static void touch_range(char *p, unsigned long len, unsigned long 
page_size)
   {
       for (unsigned long off = 0; off < len; off += page_size)
           p[off] = (char)off;
   }

   int main(int argc, char **argv)
   {
       const int loops = argc > 1 ? atoi(argv[1]) : 1;
       const unsigned long page_size = sysconf(_SC_PAGESIZE);
       const unsigned long csize = contpte_size(page_size);
       const unsigned long nr_pages = 2 * csize / page_size;
       const unsigned long len = nr_pages * page_size;
       const unsigned long map_len = len + csize;
       const unsigned long guard_idx = csize / page_size - 3;

       enable_mthp(csize);

       for (int i = 0; i < loops; i++) {
           char *map, *p;

           map = mmap(NULL, map_len, PROT_READ | PROT_WRITE,
                  MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
           if (map == MAP_FAILED) {
               perror("mmap");
               return 1;
           }

           p = (char *)(((unsigned long)map + csize - 1) & ~(csize - 1));

           if (madvise(p, len, MADV_HUGEPAGE))
               perror("madvise MADV_HUGEPAGE");
           if (madvise(p, len, MADV_POPULATE_WRITE))
               perror("madvise MADV_POPULATE_WRITE");

           touch_range(p, len, page_size);

           if (mprotect(p, len, PROT_NONE)) {
               perror("mprotect PROT_NONE");
               return 1;
           }
           if (madvise(p + guard_idx * page_size, page_size,
                   MADV_GUARD_INSTALL)) {
               perror("madvise MADV_GUARD_INSTALL");
               return 1;
           }

           write_clear_refs();

           if (munmap(map, map_len)) {
               perror("munmap");
               return 1;
           }
       }

       return 0;
   }


Thanks,
Zhao
