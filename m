Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794387127;
	b=BOYEjbkkhVEen26kMPhuiEHK2OT6ORwAVQGuRSE+DzwHXwd3vvrWAGnFIIdfb4Q3SCj5
	 H4EGYsvj7NF2kGBm567J/+70wfBK1oFwGBd/GSyBz43z5rdJuh5XlUFw/lcrRUPccAecm
	 jDY7sTx/gPwNQV9QiUmr0m2bs5qYYf6jzggcjHOmPNZNfzxS7a6pU8V9AjaIZq+Xxa864
	 zLPvtxOiYYhW5EyzGSmD9alsg97s35lhqOhLvR7t5Wxq2Q81v/EkaGojHJcFMRY846c9f
	 f/YDzjqFSeNpRi2qy57sRNlb6FOF9O7V/QYpxFv9C/8qho4Jfnzgyg0RDBlM6lwQU9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794387127;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=pASdGHuVDzOPBm8DXapgWXpGyzGlrV51ZEAx+mwYgR0=;
	b=d7TDI39NDcUh9MKM1WQW1YJ7p3C9/gNezZEvvswv3CEzfymhnVDwTf4cUZ266v2AV12X
	 8hStS08tIcfOYorVVU7zGp9ZL7L7LzBN8KFr1fyfWKRo1q47MbMKrnUk76RSjEvHoowDI
	 ANhALD6zs1jUNDzYDlVU7litwCnNJw5YRJEd4r9goZkBwowsiWnhs63mFyfmBy/yRNYBR
	 hH5K3FLtCe4BV5nXCmNVzvd0w9YMfzYgvD9rlIEi3zexODcPyOSwnuQNQDYDDnJMyeA0b
	 8Isj1NvDBMBJ2AnGOCXSwQFMj2U6cj1qa2rXBkc2IB11Zqtgfv2jFqo1y38m6CN69dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=DU9CjvFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12C9606A33B;
	Wed, 11 Nov 2026 08:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=DU9CjvFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D29B1F00A0B;
	Wed, 11 Nov 2026 08:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794387127;
	bh=pASdGHuVDzOPBm8DXapgWXpGyzGlrV51ZEAx+mwYgR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DU9CjvFkdaXJNhlnKW3ETO8C/jowCZkydGBiKEgzrTQcTSYlwrtWHO0AAi/2xYeCU
	 6O0gxCLsvbOYh6luY0qaOpHBehkHo5KfCqeKtCgwAoPkumj7FOa1D0omUZaqMZHkdT
	 MN1hjUtVcSd05HQfzf3uT/Mf+uCoUviUC1XWs5LA=
Date: Wed, 11 Nov 2026 00:52:06 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
 <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
 <tim.c.chen@linux.intel.com>, <dan.liang@intel.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v7] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Message-Id: <20261111005206.53d8f99bd0ff3c9b568a1ad1@linux-foundation.org>
In-Reply-To: <20261110174513.461743-1-Vishal.Badole@amd.com>
References: <20261110174513.461743-1-Vishal.Badole@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Nov 2026 23:15:13 +0530 Vishal Badole <Vishal.Badole@amd.com> wrote:

> group_cpus_evenly() builds the managed-IRQ affinity spread used by
> multi-queue devices such as NVMe. That spread is meant to be a property
> of the static CPU topology: it walks cpu_present_mask and then
> cpu_possible_mask so every hardware queue owns a fixed set of CPUs,
> including CPUs that are offline at the time. A driver depends on that
> partition staying stable across re-computation - the CPUs a queue is
> given at probe must still describe the same queue after the device is
> later reset and its affinity recomputed.
> 
> ...
>
> Fix this by snapshotting cluster and SMT masks together under
> cpus_read_trylock() when all present CPUs are online. Latch the first
> capture attempt, permanently using CPU-order grouping if it fails, and
> propagate later allocation errors instead of switching algorithms. This
> keeps successful spreads stable across CPU offline/online cycles for an
> unchanged group count, present/possible CPU sets and NUMA topology.
> 

Thanks, I grabbed this and I'll push it into -next for testing.

It's hard to get review for group_cpus.c.  Wangyang, if you have time
please.


fwiw, I fed it into my evolving AI patch reviewbot and it liked it.  We
already have Sashiko - I'm trying to get this thing to take a broader,
design-level view using wider resources (commit history, mailing list
discussions, previous iterations, similar/related patches, related bug
reports, etc).

: The bug is a mismatch between two inputs to IRQ grouping. 
: group_cpus_evenly() assigns groups across present and possible CPUs,
: but the live cluster and SMT masks change as CPUs go offline.  When
: NVMe reallocates its IRQs with CPUs 311 offline, the same queue count
: can therefore produce a different CPU partition from the one
: established at probe.
: 
: The patch makes that partition stable.  On the first grouping call, it
: either copies both masks while all present CPUs are online, or
: permanently selects CPU-order grouping.  The failure path uses
: cpumask_of(cpu) rather than a live SMT mask, so it cannot change its
: answer on a later call.  The mutex and release/acquire publication
: protect the one-time decision; the captured masks remain allocated for
: the kernels lifetime.
: 
: V7s specific change is sound: a positive ncluster means cluster
: grouping succeeded, zero selects CPU-order grouping, and a negative
: allocation error unwinds.  The caller adds nv->ngroups once on either
: successful path.  I found no remaining ownership, cleanup, or
: arithmetic defect in those changes.
: 
: The tradeoff is explicit: if the first capture occurs with an offline
: CPU, under hotplug-lock contention, or during allocation failure,
: cluster-aware grouping is lost for that boot.  The stability claim also
: assumes unchanged group count, present/possible CPU sets, and NUMA
: topology; CPU hot-add is outside it.


And I fed it into my evolving LLM-driven live kernel testing setup. 
Everything passed.  This thing is still being beaten into shape - the
test planning isn't as nasty as I've told it to be, because it's
annoyingly lazy and disobedient and forgetful.  It's a work in
progress.

But I think it gave the patch a pretty good workout anyway, wdyt?


: Patch "lib/group_cpus: snapshot cluster masks to keep grouping hotplug invariant"
: Link: https://lore.kernel.org/20261110174513.461743-1-Vishal.Badole@amd.com
: Tested-by: Andrew Morton <akpm@linux-foundation.org>
: 
: I tested v7 against the same tree with this one patch reversed. Both
: kernels had the same configuration and booted a Debian guest with 12
: vCPUs (one socket, six cores, SMT2, one virtual NUMA node). The host
: was a 64-core, SMT2 Threadripper PRO 3995WX with one NUMA node. The
: kernel was 7.4.0-rc1-g99b6d17012de, with CPU hotplug, NVMe, KASAN and
: lock checking enabled. QEMU 8.2.2 supplied an eight-I/O-queue NVMe
: device and a separate root disk.
: 
: Both kernels initially returned the same eight group_cpus_evenly(8)
: masks. I offlined CPUs 3-11 while the present and possible masks stayed
: at 0-11. All eight baseline groups changed, while all eight v7 groups
: remained unchanged. For example, baseline group 0 moved from CPUs 2-3
: to 0-1; v7 group 0 stayed at 2-3. Reonline restored the original masks.
: The guest exposed six two-CPU cluster masks and SMT sibling pairs.
: 
: I reset NVMe while CPUs 3-11 were offline. The controller retained
: nine queues (one admin and eight I/O) in both kernels. All eight I/O
: queue managed IRQ masks changed across the baseline reset; none changed
: with v7. Effective IRQ affinity moved onto online CPUs as expected.
: After bringing the CPUs back, direct I/O from CPU 8 succeeded and the
: 8 MiB readback SHA-256 matched on both kernels. There were no NVMe
: command timeouts or kernel warnings in these guest runs.
: 
: For the fallback path, I booted v7 with only CPUs 0,2,4 online.
: Because some CPUs were offline during the first grouping call, v7 did
: not create a topology snapshot. It used the same CPU-order groups for
: that call and every later call, even after the other CPUs came online.
: Stack-filtered slab injection in a separate v7 build failed two
: distinct outer and three distinct inner grouping allocations. Each
: call returned NULL; a subsequent normal call returned the original
: eight groups without a warning.
: 
: A separate diagnostic build used a temporary boot-selectable hook to
: force failure of the first snapshot array, sibling array, a per-CPU
: mask after earlier allocations, and the trylock-failure cleanup
: branch. A no-failure control captured a non-null snapshot. In every
: forced-failure case, v7 selected CPU-order grouping for the rest of
: the boot. Its snapshot pointer stayed NULL, the groups remained the
: same through CPU hotplug, and there was no KASAN or lock warning. The
: trylock branch was forced by the hook; actual contention on the CPU
: hotplug lock was not reproduced. QEMU did not reproduce the physical
: controller's s2idle simple-suspend quirk or its reported two-minute
: timeout. The A/B tests reproduced the changing affinity-map mechanism,
: not that hardware stall.
