Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9606E53D0C7;
	Wed, 14 Oct 2026 14:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.117.225.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988979; cv=none; b=lNycb1U//l0zgCXpvXCazQMjuURN4F6ZFnbWNM6gQaopiHsPe1nXYxJdM3IZhr+qD5Nhhvm3m2cteLOe0M1hHLUTjFlPCaz73UzRlbSfef09jC+TrXNPtr+DOgMhX2Si4n1K0sJ/cH+ic/OyIjC95MVMhsvf8nOaTXoLI8Rn1Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988979; c=relaxed/simple;
	bh=+RqzOK3/QqQOg1EY/Bo3MknmkU1tht2xWnZTAlV1tUY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iyNkXlAYiKXhRDHZv46bVLEy+A3qXjXlTPf8By+UoJRJP+DTyJRrJvjDSalrOV6igxYjFHW6cChO0GmnnJ5YrSh/GgmMX1fcIStDwZbRQRBwncUlRWk73Mq32MP9pj2nknSOe/7McdX5swmOg6EEodlQhmLrN+b7Q9tq9oouJKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=iDcev7wC; arc=none smtp.client-ip=130.117.225.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="iDcev7wC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Message-Id:Date:Subject
	:From; bh=sYtW+VE4ZIn8TTTh5BivteRD5oYs9WNeRvx7SQ+Utbk=; b=iDcev7wCfcKKbLwaOK4
	7Zg9XC368hf+cQzBOLfoT770NptNgOhRiiYfFi3BuTUlLTDOrsSSsoH1o0mLTWv2fzvobIWgqZfuR
	OILGEXDT7x+pOd7OMLOsZY5YrBwdcQ0yavsJP9YGj1KNz/2DtWIFCIbcXaLh3IrPHpClqOOO5bTvi
	Jm7gTcNSVODoiCI4DClTV0RwihJBMSV8mwN5b3e6keS/74lfdSt6r2Un/fxFm6OXY0+2PcJvxnPfe
	lBqY2nLp8u5z6HMA9oznCuYQz1856rz6SDesKKk6UA0TauKdeg8WxBkvH0TDUB2ZnCvemAHzAFZbR
	WgRkis0PTVUpfhQ==;
Received: from ch-demo-asa.virtuozzo.com ([130.117.225.8] helo=f0.sw.ru)
	by relay.virtuozzo.com with esmtp (Exim 4.96)
	(envelope-from <khorenko@virtuozzo.com>)
	id 1xH089-005A8J-31;
	Wed, 14 Oct 2026 16:42:30 +0200
From: Konstantin Khorenko <khorenko@virtuozzo.com>
Subject: [PATCH v2 0/2] mm/huge_memory: fix the copy of special PMDs at
 fork
Date: Wed, 14 Oct 2026 16:42:20 +0200
Message-Id: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM2Uz2oC/6WOQQ6CMBREr0K69htaEdSV9zCE0M8HqkKbFhqBc
 HcpHsHlm0zmzcIcWUWO3aKFWfLKKd1vIA4Rw7bsGwJVbcxELFIe8wRkAsaSAe8GbYEn10uSAWo
 zFe3YUGG6CixhS/gCZwhV+YaQyarOqJYpFyjYNr5t1Oqzix/5j90on4RDsIVGq4Jh2p95Hnp/n
 /AcOFRCnDGNJZ54evfKDqOeZ31E3bF8XdcvxO1r0hIBAAA=
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
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, Konstantin Khorenko <khorenko@virtuozzo.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12065;
 i=khorenko@virtuozzo.com; h=from:subject:message-id;
 bh=+RqzOK3/QqQOg1EY/Bo3MknmkU1tht2xWnZTAlV1tUY=;
 b=owEBbQKS/ZANAwAKAVGWCkf5YVwqAcsmYgBqz5TTf5aWAdhEPC6suWP9TdI9LEouFUr7QFe04
 yn80tWK9/6JAjMEAAEKAB0WIQRWD23IPcXT0GO9CCxRlgpH+WFcKgUCas+U0wAKCRBRlgpH+WFc
 KtbND/0eJ0yNE4DVC932JBecBmc2sviqNkexcmQKztNoFqgwswg//07fc6XPvO9X9Plsg7nrCB0
 pBfpXgyVG1WqEuNxNjE47SWWsAlDes1hUOdYvax0h9HoebMRPoyCQ9ut0P8s9vc0Hi879ErigEn
 S1P1XYykov+sMqzJ7VfpMx3ThuyDs1X3WPq28s1Wy365DX5XseOlhgtJQwziboAufP+0lbGPLsm
 gdzr583a/9vEWwwj/huIUF5uPRTHn3BJAd8f1Ee5WPzM496Qdh7mWQL+LkaWDroPM3wzM+YwGuA
 +psP+oC7RG3xFBIHjL0RQUN2MtfECfcSnnOqRcpvF2pKi+dstDPYCbGuY/AuLazzUMhoCmZmM0i
 NiAdTtGHplRKJosvY+gY5mkxNkGFNmjMU+A5Dq/IR1UK9n5iOoB1/eb+QUDZBjLMP5KILJa3U0h
 Mhq+cofZJmvZBG5R256YIuGMo/GsVffkUKk9fmtLHvUlOrMwtXuWtcF5cOITTjd/28qThWOCsWH
 bsMlmQ1pKfiQHUBbpXf0yUh1nAmWGcyaAeh3bZxagxSr7UkyN4TzNT2N7VVRkcsgiZae+OX0JpT
 eEHXarQhoOuMf2dssoHL2ayaa8zCJTNwj8VtuL7iXMA4x+2B1RTgts6qZVRfvotnKYxuzmWfRyb
 qHxZ8tkBf2Z/Sxg==
X-Developer-Key: i=khorenko@virtuozzo.com; a=openpgp;
 fpr=560F6DC83DC5D3D063BD082C51960A47F9615C2A

Two fixes for the special-PMD branch that commit bc02afbd4d73
("mm/fork: accept huge pfnmap entries") added to copy_huge_pmd():

1. The child gets a PMD value read without the lock, so it can keep a
   huge PFN mapping that its driver has just zapped.
2. The child gets no deposited page table, which ppc64 in hash mode
   dereferences on the first fault and on the zap. That is reachable
   since commit d1503aa9ab805 ("powerpc/64s: Add support for huge
   pfnmaps") enabled special PMDs on ppc64. Sashiko found it in the
   review of v1.

Patch 2 goes on top of the -EAGAIN path that patch 1 adds.

It is not tested on ppc64. On x86 it was exercised with a test-only
hack that makes special PMDs carry a deposited table, as ppc64 hash
does for every huge PMD: insert_pmd(), the zap and the split deposit
and withdraw it.

Without patch 2, the first child of the reproducer oopses at exit in
pgtable_trans_huge_withdraw(). With it, 3400 forks gave no oops and no
non-zero pgtables_bytes at mm teardown; the recheck returned -EAGAIN
864 times, each freeing the table it had allocated.

Patch 1
=======

The window is short: the zap has to clear the parent's PMD and pass
the child's VMA between fork's lockless read and its taking the source
PMD lock. I have not hit it without help, but a delay in that
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

drm_gem_shmem and mshv_vtl map special PMDs with vmf_insert_pfn_pmd()
as well.

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

Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
---
Changes in v2:
- Add patch 2, the page table deposit for ppc64 hash, reported by
  Sashiko.
- Patch 1: name panthor instead of drm_gem_shmem as the driver whose
  stale child mapping reaches freed pages: drm_gem_shmem keeps the
  pages of a purged object until the last mapping goes away.
- Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com

---
Konstantin Khorenko (2):
      mm/huge_memory: recheck a special PMD under the lock in copy_huge_pmd()
      mm/huge_memory: deposit a page table for a special PMD copied by fork

 mm/huge_memory.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)
---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2

Best regards,
--  
Konstantin Khorenko <khorenko@virtuozzo.com>

