Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001803;
	b=dpymk257Gf3/BuFraNQ7VR0dNxyISuqajzCwmR6wvish8xE7gbA3mPAlR97jBeLVtnvs
	 Kb6ty1sHVzqazTwnkDleoYqHNB94nRpn3+OBoQCPNQsNhYkCnz6UrGtpqOn+4A6sDDtm+
	 qfYekT7tSOOo85zIn/PLaToVtSr0oNjJRVQ9XUK1R2QaHmFdWUMvEqfqU0kf6Ou7ifjmN
	 wGf5zj+HXakB2YB0GGNApqBOrbYrubQGSGUCcR4dQiYNTdhk7ytUnW8SZjrhAKzSZFl7x
	 TyXbeUw2mcQi/67oICOYPlXBG+AxpQJB/0gsF5PUZUV+/FF7noMxLU17cMKdESFheKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001803;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EMqO2cZtoKfLp9qFMsHlCBzuOx+vYRgZuB23ZtkC9Qc=;
	b=eBkehiwd7jvczkH02gB0lHeJSWF2FkdeGbziCAOY92xX9LegzuIzvauCY+8shhzAHGJs
	 Psr/iDYm8+jMPGd7R6x+Qsn8N5lCRy+Ta90KGERLavhZ+8D1+237dSeSyJEE88I2ttz7o
	 DLFK/vB+d1IWUtxus2SJ+Rutxqq1Iv2YrnOl5AXKD4vDVNaDj6H25zAHTx5v7C25YVR3I
	 9F/aKAaIF4bs43RDj+0JP4iDYTuX1A6gGDMrUpnXMI8Em++nLfrRIAzJmxHIMD7CpCNpe
	 U3hyZhSXaBvg/qSGipEkSFNkAQTO5HGfir0AUAh0oAunNLlF/ttEqqLLlvssVj6uQxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqsQS9QA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0846C606A326;
	Fri,  6 Nov 2026 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MqsQS9QA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D041F0089F;
	Fri,  6 Nov 2026 21:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794001802;
	bh=EMqO2cZtoKfLp9qFMsHlCBzuOx+vYRgZuB23ZtkC9Qc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MqsQS9QA0eOg0NTmgChs1E6DDJrW1Gk3bD/CJ2OzruSw0KweLNz0xihBsQttxad4F
	 WCBt6XeUvKBixnvQMozZjzHlmy/nrc278/zlG+mI3zR8U6YxFVBL2DWbD4SaGGvrSh
	 /ZcQcP8+Rm41G23qdA5+Kg0vB39YQtie2rCJhYXVzZ7sUYuKlTwV2irNaN+GWcexKI
	 sRjDPk/IhXKyUFpaCgB10mIm03TipciH1xV7NpSdrr0+cNABr7UIH6ctphM2swymEP
	 1aBuozTyoZMakuD0AIO83yignJXKoXxoTtB/aHvJPbCyXGh//m3D3S8XMdB3pJu+iv
	 EMA69G4CgdBtA==
Message-ID: <76c04c44-2ea0-414b-8fd7-514e6b182ea0@kernel.org>
Date: Fri, 6 Nov 2026 22:28:18 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/4] mm/huge_memory: copy PMDs at fork like the PTE
 path does
To: Konstantin Khorenko <khorenko@virtuozzo.com>,
 Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>,
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261104-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v5-0-c56d0d26f970@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/26 21:40, Konstantin Khorenko wrote:
> copy_huge_pmd() decides what to copy at fork by its own rules, apart
> from copy_present_ptes(): a lockless check for special PMDs, and a skip
> of every file THP. Following David's review of v3, this series makes it
> decide the way the PTE path does, under the page table lock, with
> vm_normal_page_pmd(). That fixes the two bugs v1-v3 were about. The
> patches:
> 
> 1. folio_dup_file_rmap_pmd() duplicated a PMD mapping as HPAGE_PMD_NR
>    PTE mappings. It had no caller until patch 2.
> 2. File THPs are copied at fork instead of being refaulted by the
>    child, as their PTEs would be.
> 3. The special-PMD read moves under the lock. That closes the race with
>    a driver zap (vfio-pci, panthor) and the missing page table deposit
>    on ppc64 hash that Sashiko found in v1.
> 4. A selftest for 1 and 2.
> 
> Stable
> ======
> 
> The race (since v6.12) and the ppc64 hash NULL deref (since v7.1) are
> fixed in patch 3, which only works on top of the copy rework in patch
> 2, and patch 2 is the first caller of the helper patch 1 fixes. So
> patches 1-3 carry Cc: stable, as David suggested on v4. They will not
> apply to 6.12 as they are, I will do the backports.
> 
> A related refcount bug in copy_huge_pud() for device DAX is fixed in
> a separate series, as it does not depend on this one:
> https://patch.msgid.link/20261021-vstor-150143-copy_huge_pud-folio-refcount-v1-0-8bd88551f9be@virtuozzo.com
> 
> Testing
> =======
> 
> v5 on v7.4-rc1, x86_64 with 4 NUMA nodes, the series with
> CONFIG_DEBUG_VM, KASAN and lockdep:
> 
> - fork_file_thp (patch 4) skips on v7.4-rc1, where fork leaves file
>   THPs to a refault, and fails in both cases without patch 1, where
>   ShmemPmdMapped drops when the child exits and the kernel reports
>   "Bad page cache";
> - with the series it passes, also under migrate_pages() of the parent
>   and under reclaim in a small memcg, where some runs skip; with other
>   processes churning PMD-mapped shmem it passes or skips, never fails;
> - cow, guard-regions, uffd-unit-tests, uffd-wp-mremap,
>   split_huge_page_test, mremap_test, soft-dirty, pagemap_ioctl,
>   migration, madv_populate, transhuge-stress and khugepaged pass as on
>   v7.4-rc1.
> 
> The runs below are from v4, on v7.3-rc7 in a KVM guest with 4 vCPUs,
> x86_64. Patches 1-3 changed since only by the device private CoW check.
> 
> Race with a driver zap. The guest's QXL device is bound to vfio-pci in
> no-IOMMU mode, BAR0 of 64 MB mapped with PMDs. The reproducer below
> forks while a second thread clears PCI_COMMAND_MEMORY through the vfio
> config region after a random delay of up to 1 ms; the child waits for
> the write to finish and reads one byte of each 2 MB of the BAR. A child
> that reads anything without SIGBUS kept a stale mapping. I have not hit
> it without help, so a test-only debugfs knob adds an mdelay(2) between
> copy_pmd_range()'s lockless pmd_is_huge() and the PMD locks:
> 
>   +-----------------------+-------+-------+----------------+
>   | kernel                | delay | forks | stale children |
>   +-----------------------+-------+-------+----------------+
>   | 7.3-rc7               | none  | 20900 | 0              |
>   | 7.3-rc7               | 2 ms  | 150   | 128            |
>   | 7.3-rc7 + this series | none  | 3000  | 0              |
>   | 7.3-rc7 + this series | 2 ms  | 400   | 0              |
>   +-----------------------+-------+-------+----------------+
> 
> ppc64 hash is not tested on hardware. On x86 a test-only hack makes
> arch_needs_pgtable_deposit() true and mremap move the table, as on
> ppc64 hash. Without the series the first child of the reproducer oopses
> at exit in pgtable_trans_huge_withdraw(); with it the reproducer and
> the mm selftests pass.
> 
> Cost
> ====
> 
> fork() now copies file THPs instead of leaving them to a refault, which
> costs fork() a reference, an rmap update and a counter per huge PMD and
> saves the child a fault per huge PMD it touches. fork() of a process
> with 4 GB of shmem THPs mapped MAP_PRIVATE and an anon_vma on the VMA,
> medians of 2000 forks:
> 
>   +-----------------------+------------+-------------------------+
>   | kernel                | fork()     | fork(), child reads all |
>   +-----------------------+------------+-------------------------+
>   | 7.3-rc7               | 86-129 us  | 2380-2620 us            |
>   | 7.3-rc7 + this series | 230-355 us | 820-930 us              |
>   +-----------------------+------------+-------------------------+
> 
> Notes
> =====
> 
> - drm_gem_shmem and mshv_vtl map special PMDs with
>   vmf_insert_pfn_pmd() as well.
> - copy_huge_pud() still differs from the PMD tail in that it does not
>   mark a shared PUD clean in the child or handle uffd bits.
> 
> Reproducer. It writes the BAR as a control and reads it with the
> memory disabled, which is harmless for QXL VRAM in a guest; do not
> point it at a BAR that holds device registers. Build with
>   gcc -O2 -pthread -o fork_revoke fork_revoke.c
> 
> run as root with the device bound to vfio-pci; arguments: BDF,
> iterations, BAR index, max revoke delay in microseconds, e.g.
>   ./fork_revoke 0000:00:02.0 100 0 3000
> 
>     // SPDX-License-Identifier: GPL-2.0
>     /*
>      * Fork while vfio-pci revokes a BAR mapped with huge PMDs.
>      *
>      * The parent maps a BAR of a vfio-pci device and faults it in. A second
>      * thread disables the device memory through the command register, which
>      * makes vfio-pci zap all BAR mappings, while the main thread forks. Once
>      * the memory is disabled, every access to the BAR must raise SIGBUS. A
>      * child that can still read a BAR chunk kept a mapping the zap removed.
>      *
>      * usage: fork_revoke <domain:bus:dev.fn> [iterations [bar [max_delay_us]]]
>      *
>      * The revoke starts after a random delay of up to max_delay_us, so that it
>      * lands at different points of fork.
>      */
>     #define _GNU_SOURCE
>     #include <errno.h>
>     #include <fcntl.h>
>     #include <limits.h>
>     #include <pthread.h>
>     #include <sched.h>
>     #include <setjmp.h>
>     #include <signal.h>
>     #include <stdint.h>
>     #include <stdio.h>
>     #include <stdlib.h>
>     #include <string.h>
>     #include <unistd.h>
>     #include <sys/ioctl.h>
>     #include <sys/mman.h>
>     #include <sys/wait.h>
>     #include <linux/pci_regs.h>
>     #include <linux/vfio.h>
> 
>     #define SZ_2M	(2UL << 20)
> 
>     static int dev;
>     static off_t cfg_off;
>     static int go_pipe[2], done_pipe[2];
>     static volatile uint32_t *shared;	/* [0]: iteration whose revoke finished */
>     static unsigned long iter;
>     static unsigned int max_delay_us;
>     static sigjmp_buf jb;
> 
>     static void die(const char *what)
>     {
>     	fprintf(stderr, "%s: %s\n", what, strerror(errno));
>     	exit(2);
>     }
> 
>     static int device_fd(const char *bdf)
>     {
>     	char path[PATH_MAX], link[PATH_MAX], *group_id;
>     	int container, group, noiommu;
>     	ssize_t len;
> 
>     	snprintf(path, sizeof(path), "/sys/bus/pci/devices/%s/iommu_group", bdf);
>     	len = readlink(path, link, sizeof(link) - 1);
>     	if (len < 0)
>     		die("iommu_group");
>     	link[len] = 0;
>     	group_id = strrchr(link, '/') + 1;
>     	snprintf(path, sizeof(path), "/dev/vfio/%s", group_id);
>     	noiommu = access(path, F_OK);
>     	if (noiommu)
>     		snprintf(path, sizeof(path), "/dev/vfio/noiommu-%s", group_id);
>     	container = open("/dev/vfio/vfio", O_RDWR);
>     	group = open(path, O_RDWR);
>     	if (container < 0 || group < 0)
>     		die(path);
>     	if (ioctl(group, VFIO_GROUP_SET_CONTAINER, &container) ||
>     	    ioctl(container, VFIO_SET_IOMMU,
>     		  noiommu ? VFIO_NOIOMMU_IOMMU : VFIO_TYPE1v2_IOMMU))
>     		die("vfio container");
>     	return ioctl(group, VFIO_GROUP_GET_DEVICE_FD, bdf);
>     }
> 
>     static void set_memory(int on)
>     {
>     	uint16_t cmd;
> 
>     	if (pread(dev, &cmd, 2, cfg_off + PCI_COMMAND) != 2)
>     		die("read PCI_COMMAND");
>     	cmd = on ? cmd | PCI_COMMAND_MEMORY : cmd & ~PCI_COMMAND_MEMORY;
>     	if (pwrite(dev, &cmd, 2, cfg_off + PCI_COMMAND) != 2)
>     		die("write PCI_COMMAND");
>     }
> 
>     static void *revoker(void *arg)
>     {
>     	unsigned long i;
> 
>     	while (read(go_pipe[0], &i, sizeof(i)) == sizeof(i)) {
>     		if (max_delay_us)
>     			usleep(random() % max_delay_us);
>     		set_memory(0);
>     		shared[0] = i;
>     		if (write(done_pipe[1], &i, sizeof(i)) != sizeof(i))
>     			die("done pipe");
>     	}
>     	return NULL;
>     }
> 
>     static void sigbus(int sig)
>     {
>     	siglongjmp(jb, 1);
>     }
> 
>     /* Number of 2MB chunks of the BAR that can be read without SIGBUS. */
>     static unsigned long readable(volatile uint8_t *bar, size_t size)
>     {
>     	volatile unsigned long n = 0;
>     	volatile size_t off;
> 
>     	for (off = 0; off < size; off += SZ_2M) {
>     		if (sigsetjmp(jb, 1))
>     			continue;
>     		(void)bar[off];
>     		n++;
>     	}
>     	return n;
>     }
> 
>     int main(int argc, char **argv)
>     {
>     	unsigned long iterations = argc > 2 ? strtoul(argv[2], NULL, 0) : 1000;
>     	unsigned int index = argc > 3 ? atoi(argv[3]) : 0;
>     	struct vfio_region_info cfg = { .argsz = sizeof(cfg),
>     					.index = VFIO_PCI_CONFIG_REGION_INDEX };
>     	struct vfio_region_info bar = { .argsz = sizeof(bar), .index = index };
>     	unsigned long stale_children = 0, stale_chunks = 0, n;
>     	volatile uint8_t *map;
>     	pthread_t thread;
>     	size_t size, off;
>     	uint8_t *resv;
>     	int status;
>     	pid_t pid;
> 
>     	if (argc < 2) {
>     		fprintf(stderr, "usage: %s <bdf> [iterations [bar [max_delay_us]]]\n",
>     			argv[0]);
>     		return 2;
>     	}
>     	max_delay_us = argc > 4 ? atoi(argv[4]) : 0;
>     	signal(SIGBUS, sigbus);
>     	dev = device_fd(argv[1]);
>     	if (dev < 0)
>     		die("device fd");
>     	if (ioctl(dev, VFIO_DEVICE_GET_REGION_INFO, &cfg) ||
>     	    ioctl(dev, VFIO_DEVICE_GET_REGION_INFO, &bar))
>     		die("region info");
>     	if (!(bar.flags & VFIO_REGION_INFO_FLAG_MMAP) || bar.size < SZ_2M) {
>     		fprintf(stderr, "BAR %u: no mmap or smaller than 2MB\n", index);
>     		return 2;
>     	}
>     	cfg_off = cfg.offset;
>     	size = bar.size & ~(SZ_2M - 1);
> 
>     	/* A 2MB aligned address lets vfio-pci map the BAR with huge PMDs. */
>     	resv = mmap(NULL, size + SZ_2M, PROT_NONE,
>     		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
>     	if (resv == MAP_FAILED)
>     		die("reserve");
>     	resv = (uint8_t *)(((uintptr_t)resv + SZ_2M - 1) & ~(SZ_2M - 1));
>     	map = mmap(resv, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED,
>     		   dev, bar.offset);
>     	if (map == MAP_FAILED)
>     		die("mmap BAR");
>     	shared = mmap(NULL, 4096, PROT_READ | PROT_WRITE,
>     		      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>     	if (shared == MAP_FAILED)
>     		die("shared page");
> 
>     	/* Control: without a revoke the child reads what the parent wrote. */
>     	set_memory(1);
>     	for (off = 0; off < size; off += SZ_2M)
>     		map[off] = (uint8_t)(off / SZ_2M) ^ 0x5a;
>     	pid = fork();
>     	if (!pid) {
>     		for (off = 0; off < size; off += SZ_2M)
>     			if (map[off] != ((uint8_t)(off / SZ_2M) ^ 0x5a))
>     				_exit(1);
>     		_exit(0);
>     	}
>     	if (pid < 0 || waitpid(pid, &status, 0) != pid ||
>     	    !WIFEXITED(status) || WEXITSTATUS(status)) {
>     		fprintf(stderr, "control: child does not see the parent's BAR\n");
>     		return 2;
>     	}
>     	printf("BAR %u: %zu MB, %lu iterations, revoke delay < %u us\n",
>     	       index, size >> 20, iterations, max_delay_us);
> 
>     	/* Premise: with the memory disabled the BAR cannot be read. */
>     	set_memory(0);
>     	n = readable(map, size);
>     	set_memory(1);
>     	if (n) {
>     		fprintf(stderr, "memory disabled, parent still reads %lu chunks\n", n);
>     		return 2;
>     	}
> 
>     	if (pipe(go_pipe) || pipe(done_pipe))
>     		die("pipe");
>     	if (pthread_create(&thread, NULL, revoker, NULL))
>     		die("thread");
> 
>     	for (iter = 1; iter <= iterations; iter++) {
>     		set_memory(1);
>     		for (off = 0; off < size; off += SZ_2M)
>     			(void)map[off];
>     		if (write(go_pipe[1], &iter, sizeof(iter)) != sizeof(iter))
>     			die("go pipe");
>     		pid = fork();
>     		if (pid < 0)
>     			die("fork");
>     		if (!pid) {
>     			while (shared[0] != iter)
>     				sched_yield();
>     			n = readable(map, size);
>     			_exit(n > 255 ? 255 : n);
>     		}
>     		if (read(done_pipe[0], &n, sizeof(n)) != sizeof(n))
>     			die("done pipe");
>     		if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status))
>     			die("child");
>     		if (WEXITSTATUS(status)) {
>     			stale_children++;
>     			stale_chunks += WEXITSTATUS(status);
>     		}
>     	}
>     	set_memory(1);
>     	printf("children with a stale BAR mapping: %lu of %lu (%lu 2MB chunks)\n",
>     	       stale_children, iterations, stale_chunks);
>     	return stale_children ? 1 : 0;
>     }
> 
> Assisted-by: LLM
> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
> ---
> Changes in v5:
> - Rebase onto v7.4-rc1.
> - Patches 1-3: Cc: stable (David, Lorenzo).
> - Patch 1: drop the list of consequences, the helper had no caller
>   (Zi Yan).
> - Patch 2: the device private write path gets the CoW check of
>   copy_nonpresent_pte() (David). Drop fuse DAX as the example of
>   VM_MIXEDMAP, it no longer sets the flag. Say on the Cc: stable line
>   that the next patch needs it.
> - Patch 4: up to three attempts, each on a fresh file. Fail only if
>   every attempt sees ShmemPmdMapped drop by exactly the parent's share,
>   pass on the first clean one, skip if none is clean: other processes
>   change the counter and reclaim or migration take PMDs from the parent
>   (Kiryl). Keep every mapping until exit: after the bug, an unmap
>   drops the counter once more, which hid the bug from the second case.
>   Use check_huge_file(), check_huge_shmem() is gone.
> - Cover: v5 test results, box tables.
> - Link to v4: https://patch.msgid.link/20261021-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v4-0-66f00b7a564c@virtuozzo.com
> 
> Changes in v4:
> - Rework after David's review: copy_huge_pmd() decides under the PTL
>   with vm_normal_page_pmd(), like copy_present_ptes(), and copies file
>   THPs (patches 2, 3). The pmd_none() recheck and the separate deposit
>   patch are gone.
> - New patch 1: fix folio_dup_file_rmap_pmd(), whose first caller is
>   patch 2.
> - New selftest, patch 4.
> - Move Assisted-by from the patches to the cover letter, after commit
>   1e035297ffdad ("docs: remove Assisted-by references").
> - Link to v3: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com
> 
> Changes in v3:
> - Patch 1: recheck the PMD with pmd_none(), as only a zap can change
>   it and a zap leaves it none (Lance Yang).
> - Link to v2: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com
> 
> Changes in v2:
> - Add patch 2, the page table deposit for ppc64 hash, reported by
>   Sashiko.
> - Patch 1: name panthor instead of drm_gem_shmem as the driver whose
>   stale child mapping reaches freed pages: drm_gem_shmem keeps the
>   pages of a purged object until the last mapping goes away.
> - Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com
> 
> ---

I will take another look and queue it once ready.

Andrew, please drop it if you already applied it. This will conflict with the
refcount overflow handling that will have to go in first.

-- 
Cheers,

David
