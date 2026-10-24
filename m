Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792831662;
	b=k3cJw4IiVI81oCi1hDasfqf8ZRQdga9dd4CgXAhLOJmOAIRs8iZMJ37/0BWh4sucj+Bl
	 39gkj5Fi1a53efZViQ3obf5yik4Ppisd2R0q7R6RcY3B6dPyLpC9AY6P5Lc1foCnDN6HU
	 9cDyBPT4V21BIC36Q4JmvjxVuzrIs8bBksQATCJkZA5TMSTnxVy1zhxQr1T481+9db6DX
	 FJgNnspjUItb2/UC+i/qIKYiNqs3mOxrw/7UFsH7I6r6J56/atXPbxjfl3rhzSeRIHIr/
	 +oaXh/WWZJVtUPM3FbDh+aHovpKIVjUVpn5GtvCyf5ua1C5+5QAf14O42tWNixJ+NbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792831662;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8pjWJ7MxhiXzcGQKA8H10bDbnfInh/RbZKPKduHuA1U=;
	b=w+Jg6ZPryR0GzrTsR0z/Zv0OAvs5/M329uhD8cy1wEKJxbmZL8pkpxzVGU4+brxLhdlA
	 mFGubkD/NqUSYdo5DKkkI/rdFSX0RxnjNFJ/zcRePV+o71hoinCfEacZ/IOh43U3zqaUZ
	 s3TsVNny223hhnKH7APEHv25e/Tr2Zylx8p5vKucsKsdG0Spm2dIXqZO6HVxc518JvPDs
	 WNcAaUx+WYXerV4vRSu7Ri2TPsWAmvwRkVjyl7q/kLpZt8z+LK7GW2ShBLMV39s26Fe/8
	 c2lJCJfZS1xeVuB0YYCqPljR9pRAQLlq8FGTvC3mcq5dTmitPpEcXkYy9WN/5kIu93w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=FPHYZ1s4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9FC606A31A;
	Sat, 24 Oct 2026 08:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=FPHYZ1s4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BD81F01825;
	Sat, 24 Oct 2026 08:47:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1792831661;
	bh=8pjWJ7MxhiXzcGQKA8H10bDbnfInh/RbZKPKduHuA1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FPHYZ1s4QJbr4v6RAqXkTXmwMQiSPFtAjF9pjrNkcDrPPN8LyCM3RLzoLK0FsGhmr
	 w8I82K+xvP+2Vm2dhqd3gY1PrMSWZyPfDFBT4eNqfaPzlEHQisKNsBz3v2yHeM31fm
	 OO/QaLHwTgdFKycOATf+R7lUkTzWcohv6z8KaBAw=
Date: Sat, 24 Oct 2026 01:47:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
 <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
 <tim.c.chen@linux.intel.com>, <dan.liang@intel.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v4] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Message-Id: <20261024014740.3701054aa2f412748b985de2@linux-foundation.org>
In-Reply-To: <20260826171537.4167367-1-Vishal.Badole@amd.com>
References: <20260826171537.4167367-1-Vishal.Badole@amd.com>
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

On Wed, 26 Aug 2026 22:45:37 +0530 Vishal Badole <Vishal.Badole@amd.com> wrote:

> group_cpus_evenly() builds the managed-IRQ affinity spread used by
> multi-queue devices such as NVMe. That spread is meant to be a property
> of the static CPU topology: it walks cpu_present_mask and then
> cpu_possible_mask so every hardware queue owns a fixed set of CPUs,
> including CPUs that are offline at the time. A driver depends on that
> partition staying stable across re-computation - the CPUs a queue is
> given at probe must still describe the same queue after the device is
> later reset and its affinity recomputed.
> 
> On an AMD system that stability breaks across an s2idle cycle. With CPUs
> 3-11 offlined and only CPUs 0-2 left online, the machine is suspended to
> s2idle and resumed. The NVMe controller uses the simple-suspend quirk, so
> resume fully re-initialises it and recomputes the affinity spread. The
> system then hangs for roughly two minutes and stays sluggish afterwards,
> the controller only making progress through its command-timeout poll:
> 
>   nvme nvme0: I/O tag 898 (3382) QID 9 timeout, completion polled
>   nvme nvme0: I/O tag 398 (618e) QID 11 timeout, completion polled
> 
> QID 9 and QID 11 are the queues whose CPUs were offline when the spread
> was recomputed. "completion polled" means the commands did finish in
> hardware, but their interrupts were never delivered to a CPU that was
> watching the queue, so nothing reaped them until the timeout fired.
> 
> It happens because commit 89802ca36c96 ("lib/group_cpus: make group CPU
> cluster aware") derives the cluster groups from topology_cluster_cpumask(),
> which lists only the cluster siblings that are online when it is called.
> The resulting partition therefore depends on the transient online mask
> rather than on the topology alone. Recomputed on resume while the non-boot
> CPUs are still offline, it no longer matches the boot-time partition, and a
> queue is left with an affinity that does not cover the CPU it is meant to
> serve once that CPU comes back online. The dependence is on the online
> mask, not on any AMD-specific behaviour, so the same stall is reproducible
> on Intel platforms as well.
> 
> Make the cluster grouping depend on the complete cluster topology rather
> than on whichever CPUs happen to be online. Snapshot the cluster masks
> once while every present CPU is online and reuse that view for every
> later spread. Every spread then groups from the same masks, so the
> partition computed when the controller is reset matches the one computed
> at probe and each queue's IRQ still covers the CPUs it serves. If the
> snapshot was never taken, the cluster path is skipped and the plain
> present/possible spread is used.

I fed this into my evolving AI reviewbot and it had a few things to
say:


The snapshot helps when the first affinity spread is computed with all
present CPUs online, but I don't think it guarantees the invariant
claimed in the changelog.

If the first spread happens while some present CPUs are offline,
capture_cluster_snapshot() declines to run and we use plain grouping.
When those CPUs come online a later spread captures the clusters and
changes the grouping algorithm. For clusters {0,2} and {1,3}, two IRQ
groups can change from {0,1}/{2,3} to {0,2}/{1,3}.

Also, even after the snapshot, grp_spread_init_one() still consults
live topology_sibling_cpumask(). x86 CPU offlining changes these masks.
On an L2 cluster containing multiple SMT cores, assigning multiple
IRQ groups inside that cluster can therefore change across hotplug.

There's also a new failure mode: if the first snapshot allocation or
cpus_read_trylock() fails, we use plain grouping, then switch to
cluster grouping after a subsequent successful capture. I can produce
different masks this way with all CPUs remaining online.

I've verified the mask differences in reduced GCC and Clang models,
not in a kernel/NVMe reproducer. Can we make the entire assignment
independent of online sibling masks and avoid switching algorithms
after an affinity spread has already been handed to a device?
