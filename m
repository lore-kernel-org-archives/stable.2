Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D994F68C3;
	Wed, 14 Oct 2026 11:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791979103; cv=none; b=AZ/VYgLqhH9rljgLX/iMwqzjTpdxquGxqwSLlkahkv7R57Y2ImyXnQrBd5ZrSXjX/J4ea7mtRNvH2P590Gsm8amsjT+vxQNiLzEWmrrEzILQhn6PP7Mgc0gpnACQXgBlVD9+PyyqRNbSTuM+yKDndIrAKBIoM/sOgpv8YcgnbdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791979103; c=relaxed/simple;
	bh=obgUcPag99aYczZt/zoXOTqJKJ2o3uHSBqIAWhgEeVE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=SYYZmUryIx7sA+uSecWUJydMeb//AC2NMvwz2zTKcrILVD7Yzcm7ZIW+hGzLYw4kLGYvOeRi5+14pkpPI6/wkqE/8cKC/Hk+iQxjtg/HDCu+pzhCIYUW2is10RXRZgbow+YavFzbbNUU2piJtruub7tH1kocq7956nMMu8ZhpQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=XDOIZV9V; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="XDOIZV9V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Message-Id:Content-Type:MIME-Version:Subject:Date
	:From; bh=AQuWHFrsafps3vZ2+dWNxf6KEa+2dvzoz5lME1tRtAw=; b=XDOIZV9V/MlfHVaqTkk
	hz4m0yRabibao6aEX3VFluzfLMIx39vR6hEU4ncsxMQrbMryUpW6RtyJWmLRTTUiogbUe3i095/G8
	rko6UrngWRL67w47YwoJYxbvSDqS59KDaKe9RZOOYoPS6r/3DQXWDN3ygEewrDXwZj5Apd10khNR7
	eojVeVViXq+dAqGt5ls3/hNqoL2pJmipnqovwu9l8Ozm/3wdyD65wFmZCDVen22H0TUlNvY421xMo
	4fTbJIX1sx91oSjB2GMC+b8vh2fj+9NNPy+uhRAO2VISoXuZ4U3PkamljcbM2AOECv5qCKnk0MVUQ
	5kE/uMIebxmMNqw==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xGxYx-0020d1-1Z;
	Wed, 14 Oct 2026 13:57:59 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Date: Wed, 14 Oct 2026 13:57:53 +0200
Subject: [PATCH] mm/huge_memory: recheck a special PMD under the lock in
 copy_huge_pmd()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
X-B4-Tracking: v=1; b=H4sIAEBuz2oC/yWNyw6DIBAAf8XsuZsIIdr2V5rGyLIIfQgBNTbGf
 y+2x5nDzAaZk+cM12qDxIvPPowFxKkCcv04MHpTGGQtG1ELhVphTBxxyVNIKNTlrFqkED+dmwf
 u4ttgYnJMT8yRyfcvPJw2tmWrGyFJQomXhvXrb3y7/znP+sE0HTfY9y9d7WK0mgAAAA==
X-Change-ID: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2
To: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
 Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, 
 Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org, 
 =?utf-8?q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>, 
 dri-devel@lists.freedesktop.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>, 
 stable@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=13569;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=obgUcPag99aYczZt/zoXOTqJKJ2o3uHSBqIAWhgEeVE=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBqz25HMkTtVwo963YjiCmGweeAyiFLhT9BXO1vK
 kF6dH8j7uWJAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCas9uRwAKCRBRlgpH+WFc
 Ki+oD/0ZDO42djVfzoSzty+pW8gaxR8jNvr8zvrzkPa56QcC7ZWr4/TZec0wmo8vUUYk2Hggiz8
 QFQYR6hgsE7o7Y4SpU6D/XPdbZFciPFu4m+/4cR+/AZVSWkj1YKomTAu+FZO3lTWE4vS85NGdBg
 A3jLq9dAVH3j2RyBR+nj4PGAHXaA8lxC+2+IZOU8JTAYPSvOJhfFvMEJOAp2J7eaZQH4DafwvQz
 R/xnoqPIH7MNsMS4WYa2rqpymuwU5A/xuyZ/d7s+4bEanbkwiknrITsFLoSM1NxwzsiWIKnr4gq
 XKtlMhf23fdMMN4i9NFGnr4alFXlDbpSeQHMJQWUtppTGguy4HqdPC5s4hSOVMR5sW6EuDFzwtR
 fXslgU54jX/AxGtf6URySr/PQTxrbp2UzAfy56K6o2+0oOzWu8Ww7/FafM08sEMr+zYmsUSLXU6
 Brw/x+knkhb3VCqllR3kesX2xAUgJv4RJXD446TnpIithrU3SkHv7dGdEo9BH7TthPzo0bPeOg2
 912R+CJqiQW3poOf4pF5+Yi/hsPJ8LJmQNjpdX0Dz5flkKIAEbF5uZgOwSfkoscA/mWm5vYXe9t
 dxMdny95i52JULF7i+VaajMkDbmdHRSgUsijIcBq6ouerSiceZuTO8oy6wEYF8LvjDHYCYA+KhS
 dqYa/gjAaZwyIkA==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

copy_huge_pmd() reads the source PMD without the page table lock and,
for a special PMD, installs that value in the child without reading it
again under the lock. The comment says the PMD cannot change while the
mmap lock is held for write, but unmap_mapping_range() does not take
the mmap lock: it zaps under i_mmap_rwsem and the PMD lock.

dup_mmap() links the child VMA into the file's i_mmap tree right after
the parent's VMA before copying the page tables, so a zap visits the
parent first and the child second. When the zap clears the parent PMD
after fork has read it, and passes the child before fork installs the
copy, the child keeps a mapping the zap was meant to remove.

Drivers that map special PMDs with vmf_insert_pfn_pmd() rely on that
zap. vfio-pci zaps its BARs when the device memory is disabled or the
device is reset, so that userspace gets SIGBUS instead of reaching
disabled MMIO; a stale child mapping still reaches it. drm_gem_shmem
zaps the mappings of a purged object and then truncates its shmem
pages; a stale child mapping points to the freed pages.

Read the PMD again under the lock. The zap clears the parent PMD under
the same lock, so either the recheck finds it empty, or the copy is in
place before the zap reaches the child, which then removes it. If the
PMD is no longer a present special entry, return -EAGAIN: the source
mmap and VMA write locks keep faults out, so only a zap can have
cleared it, and copy_pmd_range() then skips the empty PMD. Otherwise
copy the value read under the lock. pmd_same() would be the wrong
test: threads of the parent can still set the accessed and dirty bits,
and -EAGAIN on a present huge PMD makes copy_pmd_range() clear it as a
bad PMD.

Fixes: bc02afbd4d73 ("mm/fork: accept huge pfnmap entries")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
The window is short: the zap has to clear the parent's PMD and pass
the child's VMA between fork's lockless read and its taking the page
table locks. I have not hit it without help, but a delay in that
window makes it reproducible with vfio-pci, and the patch closes it.

Setup: v7.3-rc7, KVM guest with 4 vCPUs and no IOMMU, the guest's QXL
device bound to vfio-pci in no-IOMMU mode, BAR0 of 64 MB mapped with
PMDs. The reproducer below forks while a second thread clears
PCI_COMMAND_MEMORY through the vfio config region after a random
delay; the child waits for the write to finish and reads one byte of
each 2 MB of the BAR. A child that reads anything without SIGBUS kept
a stale mapping.

  kernel                  delay in window  forks   stale children
  7.3-rc7                 none             20900   0
  7.3-rc7                 2 ms             150     128
  7.3-rc7 + this patch    none             10600   0
  7.3-rc7 + this patch    2 ms             400     0

The delay is an mdelay(2) right after pmdp_get_lockless() in the
special-PMD branch of copy_huge_pmd(), switched on by a test-only
debugfs knob. The rows without it ran on the same test kernels with
the knob at 0, except 5000 patched forks that ran on this patch alone.
The revoke started after a random delay of up to 0.2, 1 or 3 ms
(max_delay_us 200, 1000, 3000). A counter in the test-only hunk
confirmed that the forks copied the BAR as PMDs, and in the last 200
patched forks with the delay the recheck returned -EAGAIN 183 times.

panthor and mshv_vtl map special PMDs with vmf_insert_pfn_pmd() as
well.

copy_huge_pud() reads the source entry under the lock already, and
the PTE level does too, so only the PMD path needs the recheck.

Reproducer. It writes the BAR as a control and reads it with the
memory disabled, which is harmless for QXL VRAM in a guest; do not
point it at a BAR that holds device registers. Build with
"gcc -O2 -pthread -o fork_revoke fork_revoke.c", run as root with the
device bound to vfio-pci; arguments: BDF, iterations, BAR index, max
revoke delay in microseconds, e.g. "./fork_revoke 0000:00:02.0 100 0
3000".

    // SPDX-License-Identifier: GPL-2.0
    /*
     * Fork while vfio-pci revokes a BAR mapped with huge PMDs.
     *
     * The parent maps a BAR of a vfio-pci device and faults it in. A second
     * thread disables the device memory through the command register, which
     * makes vfio-pci zap all BAR mappings, while the main thread forks. Once
     * the memory is disabled, every access to the BAR must raise SIGBUS. A
     * child that can still read a BAR chunk kept a mapping the zap removed.
     *
     * usage: fork_revoke <domain:bus:dev.fn> [iterations [bar [max_delay_us]]]
     *
     * The revoke starts after a random delay of up to max_delay_us, so that it
     * lands at different points of fork.
     */
    #define _GNU_SOURCE
    #include <errno.h>
    #include <fcntl.h>
    #include <limits.h>
    #include <pthread.h>
    #include <sched.h>
    #include <setjmp.h>
    #include <signal.h>
    #include <stdint.h>
    #include <stdio.h>
    #include <stdlib.h>
    #include <string.h>
    #include <unistd.h>
    #include <sys/ioctl.h>
    #include <sys/mman.h>
    #include <sys/wait.h>
    #include <linux/pci_regs.h>
    #include <linux/vfio.h>

    #define SZ_2M	(2UL << 20)

    static int dev;
    static off_t cfg_off;
    static int go_pipe[2], done_pipe[2];
    static volatile uint32_t *shared;	/* [0]: iteration whose revoke finished */
    static unsigned long iter;
    static unsigned int max_delay_us;
    static sigjmp_buf jb;

    static void die(const char *what)
    {
    	fprintf(stderr, "%s: %s\n", what, strerror(errno));
    	exit(2);
    }

    static int device_fd(const char *bdf)
    {
    	char path[PATH_MAX], link[PATH_MAX], *group_id;
    	int container, group, noiommu;
    	ssize_t len;

    	snprintf(path, sizeof(path), "/sys/bus/pci/devices/%s/iommu_group", bdf);
    	len = readlink(path, link, sizeof(link) - 1);
    	if (len < 0)
    		die("iommu_group");
    	link[len] = 0;
    	group_id = strrchr(link, '/') + 1;
    	snprintf(path, sizeof(path), "/dev/vfio/%s", group_id);
    	noiommu = access(path, F_OK);
    	if (noiommu)
    		snprintf(path, sizeof(path), "/dev/vfio/noiommu-%s", group_id);
    	container = open("/dev/vfio/vfio", O_RDWR);
    	group = open(path, O_RDWR);
    	if (container < 0 || group < 0)
    		die(path);
    	if (ioctl(group, VFIO_GROUP_SET_CONTAINER, &container) ||
    	    ioctl(container, VFIO_SET_IOMMU,
    		  noiommu ? VFIO_NOIOMMU_IOMMU : VFIO_TYPE1v2_IOMMU))
    		die("vfio container");
    	return ioctl(group, VFIO_GROUP_GET_DEVICE_FD, bdf);
    }

    static void set_memory(int on)
    {
    	uint16_t cmd;

    	if (pread(dev, &cmd, 2, cfg_off + PCI_COMMAND) != 2)
    		die("read PCI_COMMAND");
    	cmd = on ? cmd | PCI_COMMAND_MEMORY : cmd & ~PCI_COMMAND_MEMORY;
    	if (pwrite(dev, &cmd, 2, cfg_off + PCI_COMMAND) != 2)
    		die("write PCI_COMMAND");
    }

    static void *revoker(void *arg)
    {
    	unsigned long i;

    	while (read(go_pipe[0], &i, sizeof(i)) == sizeof(i)) {
    		if (max_delay_us)
    			usleep(random() % max_delay_us);
    		set_memory(0);
    		shared[0] = i;
    		if (write(done_pipe[1], &i, sizeof(i)) != sizeof(i))
    			die("done pipe");
    	}
    	return NULL;
    }

    static void sigbus(int sig)
    {
    	siglongjmp(jb, 1);
    }

    /* Number of 2MB chunks of the BAR that can be read without SIGBUS. */
    static unsigned long readable(volatile uint8_t *bar, size_t size)
    {
    	volatile unsigned long n = 0;
    	volatile size_t off;

    	for (off = 0; off < size; off += SZ_2M) {
    		if (sigsetjmp(jb, 1))
    			continue;
    		(void)bar[off];
    		n++;
    	}
    	return n;
    }

    int main(int argc, char **argv)
    {
    	unsigned long iterations = argc > 2 ? strtoul(argv[2], NULL, 0) : 1000;
    	unsigned int index = argc > 3 ? atoi(argv[3]) : 0;
    	struct vfio_region_info cfg = { .argsz = sizeof(cfg),
    					.index = VFIO_PCI_CONFIG_REGION_INDEX };
    	struct vfio_region_info bar = { .argsz = sizeof(bar), .index = index };
    	unsigned long stale_children = 0, stale_chunks = 0, n;
    	volatile uint8_t *map;
    	pthread_t thread;
    	size_t size, off;
    	uint8_t *resv;
    	int status;
    	pid_t pid;

    	if (argc < 2) {
    		fprintf(stderr, "usage: %s <bdf> [iterations [bar [max_delay_us]]]\n",
    			argv[0]);
    		return 2;
    	}
    	max_delay_us = argc > 4 ? atoi(argv[4]) : 0;
    	signal(SIGBUS, sigbus);
    	dev = device_fd(argv[1]);
    	if (dev < 0)
    		die("device fd");
    	if (ioctl(dev, VFIO_DEVICE_GET_REGION_INFO, &cfg) ||
    	    ioctl(dev, VFIO_DEVICE_GET_REGION_INFO, &bar))
    		die("region info");
    	if (!(bar.flags & VFIO_REGION_INFO_FLAG_MMAP) || bar.size < SZ_2M) {
    		fprintf(stderr, "BAR %u: no mmap or smaller than 2MB\n", index);
    		return 2;
    	}
    	cfg_off = cfg.offset;
    	size = bar.size & ~(SZ_2M - 1);

    	/* A 2MB aligned address lets vfio-pci map the BAR with huge PMDs. */
    	resv = mmap(NULL, size + SZ_2M, PROT_NONE,
    		    MAP_PRIVATE | MAP_ANONYMOUS | MAP_NORESERVE, -1, 0);
    	if (resv == MAP_FAILED)
    		die("reserve");
    	resv = (uint8_t *)(((uintptr_t)resv + SZ_2M - 1) & ~(SZ_2M - 1));
    	map = mmap(resv, size, PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED,
    		   dev, bar.offset);
    	if (map == MAP_FAILED)
    		die("mmap BAR");
    	shared = mmap(NULL, 4096, PROT_READ | PROT_WRITE,
    		      MAP_SHARED | MAP_ANONYMOUS, -1, 0);
    	if (shared == MAP_FAILED)
    		die("shared page");

    	/* Control: without a revoke the child reads what the parent wrote. */
    	set_memory(1);
    	for (off = 0; off < size; off += SZ_2M)
    		map[off] = (uint8_t)(off / SZ_2M) ^ 0x5a;
    	pid = fork();
    	if (!pid) {
    		for (off = 0; off < size; off += SZ_2M)
    			if (map[off] != ((uint8_t)(off / SZ_2M) ^ 0x5a))
    				_exit(1);
    		_exit(0);
    	}
    	if (pid < 0 || waitpid(pid, &status, 0) != pid ||
    	    !WIFEXITED(status) || WEXITSTATUS(status)) {
    		fprintf(stderr, "control: child does not see the parent's BAR\n");
    		return 2;
    	}
    	printf("BAR %u: %zu MB, %lu iterations, revoke delay < %u us\n",
    	       index, size >> 20, iterations, max_delay_us);

    	/* Premise: with the memory disabled the BAR cannot be read. */
    	set_memory(0);
    	n = readable(map, size);
    	set_memory(1);
    	if (n) {
    		fprintf(stderr, "memory disabled, parent still reads %lu chunks\n", n);
    		return 2;
    	}

    	if (pipe(go_pipe) || pipe(done_pipe))
    		die("pipe");
    	if (pthread_create(&thread, NULL, revoker, NULL))
    		die("thread");

    	for (iter = 1; iter <= iterations; iter++) {
    		set_memory(1);
    		for (off = 0; off < size; off += SZ_2M)
    			(void)map[off];
    		if (write(go_pipe[1], &iter, sizeof(iter)) != sizeof(iter))
    			die("go pipe");
    		pid = fork();
    		if (pid < 0)
    			die("fork");
    		if (!pid) {
    			while (shared[0] != iter)
    				sched_yield();
    			n = readable(map, size);
    			_exit(n > 255 ? 255 : n);
    		}
    		if (read(done_pipe[0], &n, sizeof(n)) != sizeof(n))
    			die("done pipe");
    		if (waitpid(pid, &status, 0) != pid || !WIFEXITED(status))
    			die("child");
    		if (WEXITSTATUS(status)) {
    			stale_children++;
    			stale_chunks += WEXITSTATUS(status);
    		}
    	}
    	set_memory(1);
    	printf("children with a stale BAR mapping: %lu of %lu (%lu 2MB chunks)\n",
    	       stale_children, iterations, stale_chunks);
    	return stale_children ? 1 : 0;
    }
---
 mm/huge_memory.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1e5d68acf62a5..fcea98f0d8865 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1965,13 +1965,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
 		src_ptl = pmd_lockptr(src_mm, src_pmd);
 		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
 		/*
-		 * No need to recheck the pmd, it can't change with write
-		 * mmap lock held here.
-		 *
-		 * Meanwhile, making sure it's not a CoW VMA with writable
-		 * mapping, otherwise it means either the anon page wrongly
-		 * applied special bit, or we made the PRIVATE mapping be
-		 * able to wrongly write to the backend MMIO.
+		 * The mmap and VMA write locks of the source keep faults
+		 * out, but unmap_mapping_range() does not take the mmap
+		 * lock and may have cleared the pmd since the lockless
+		 * read. Let copy_pmd_range() skip it then.
+		 */
+		pmd = pmdp_get(src_pmd);
+		if (unlikely(!pmd_present(pmd) || !pmd_special(pmd))) {
+			spin_unlock(src_ptl);
+			spin_unlock(dst_ptl);
+			return -EAGAIN;
+		}
+		/*
+		 * Make sure it's not a CoW VMA with writable mapping,
+		 * otherwise it means either the anon page wrongly applied
+		 * special bit, or we made the PRIVATE mapping be able to
+		 * wrongly write to the backend MMIO.
 		 */
 		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
 		goto set_pmd;

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2

Best regards,
--  
Konstantin Khorenko <khorenko@virtuozzo.com>

