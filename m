Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794696686;
	b=wRzFlcW21vttZe4FaTwX1ipgCnnPenuttatQ1D47mYmzWSwjDs/c06J1EB8cevkhpuFP
	 +m6kctftj87ysB72kL12f1UUWiE464WZN9cKT/DMT+ggBgEgy7fuwhqogrFwfGEZL2rfG
	 atPF+XqhBMBqd+Gvc4bKQiI1qKb0nq1WXMPpJ9IL4+VfmlipSCBG59taI3YCAq3rOfYM4
	 A5x2XHxXX5D/+otpfdYsNnY8LlzmhWls6ekEysvC6SGP+KCqNydvwymrNrEyIxS18tP3t
	 AnNGVZYiflvQ5jlRgBkOrOzLKFCSLXgh6NzkKttyeneMUhyjzvoBs5ykT0feHnqDVqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794696686;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8I+d8kSTWHJBJJCFqS/8OkD4oU5p8mbEKtP4Uq0QdFk=;
	b=rZ2+bc9PYSMaQ4I6KtE3VyhFg+fDl47BVKZsnTMIEF2JJbV5q2PedorPHXttnWv7O0Rv
	 +NgGrFna4+vzBICmfDogwC1O6UIdw7i/B3p1z+VntleaDDxAV3gpeQipeKx/WQT3yEFVK
	 A1BqLPWp/9IRpdot7cBrQ6riXfw5K2Tl2WYz9HQZ7vfz7qt9OvNU6z7d/xeVh+9JqC2Iu
	 hf63K2VJx0MXZpYVql+pMgT2cvi+GNHOrX5aUWcy1Jw4uv8+eVJJ/gspvHSfiKBbvrvDy
	 FfLPAutc7PnhMwWERU1e9MgrwJQ7H2HcXPHfhmGGToiNen7J51/es7HDvtaDFpuExRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=hifYwju4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD23606A327;
	Sat, 14 Nov 2026 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=hifYwju4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 045071F000C4;
	Sat, 14 Nov 2026 22:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1794696686;
	bh=8I+d8kSTWHJBJJCFqS/8OkD4oU5p8mbEKtP4Uq0QdFk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hifYwju48xT3WwvLglgQ/Ta7uyydtWrd3Cbth20eg1H2dE367VN0wrtOM6FMrZd+v
	 yu0OoHBfyDqo/0QiZBqgWkzPgDIRK0ZWE408NcpvzLYTJ29/nSjy9JUa5AStVEFbI2
	 ndrBXMMt2BfV7yh9720VHZgxA6oHcZ6ZItsSiRXI=
Date: Sat, 14 Nov 2026 14:51:25 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
 <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
 <tim.c.chen@linux.intel.com>, <dan.liang@intel.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH v8] lib/group_cpus: Snapshot cluster masks to keep
 grouping hotplug invariant
Message-Id: <20261114145125.42667165f9dc7231bea477e3@linux-foundation.org>
In-Reply-To: <20261114151403.1379591-1-Vishal.Badole@amd.com>
References: <20261114151403.1379591-1-Vishal.Badole@amd.com>
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

On Sat, 14 Nov 2026 20:44:03 +0530 Vishal Badole <Vishal.Badole@amd.com> wrote:

> group_cpus_evenly() builds the managed-IRQ affinity spread used by
> multi-queue devices such as NVMe. That spread is meant to be a property
> of the static CPU topology: it walks cpu_present_mask and then
> cpu_possible_mask so every hardware queue owns a fixed set of CPUs,
> including CPUs that are offline at the time. A driver depends on that
> partition staying stable across re-computation - the CPUs a queue is
> given at probe must still describe the same queue after the device is
> later reset and its affinity recomputed.
> 
> On an AMD system that stability breaks across an s2idle cycle. CPUs 3-11
> are offlined before suspend, leaving only CPUs 0-2 online. s2idle itself
> does not offline secondary CPUs. The NVMe controller uses the
> simple-suspend quirk, so resume fully re-initialises it and recomputes the
> affinity spread while CPUs 3-11 remain offline. The system then hangs for
> roughly two minutes and stays sluggish afterwards, the controller only
> making progress through its command-timeout poll:
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
> rather than on the topology alone. Recomputed on resume while CPUs 3-11
> remain offline, it no longer matches the boot-time partition, and a
> queue is left with an affinity that does not cover the CPU it is meant to
> serve once that CPU comes back online. The dependence is on the online
> mask, not on any AMD-specific behaviour, so the same stall is reproducible
> on Intel platforms as well.
> 
> Fix this by snapshotting cluster and SMT masks together under
> cpus_read_trylock() when all present CPUs are online. Latch the first
> capture attempt, permanently using CPU-order grouping if it fails, and
> propagate later allocation errors instead of switching algorithms. This
> keeps successful spreads stable across CPU offline/online cycles for an
> unchanged group count, present/possible CPU sets and NUMA topology.

updated, thanks.

> Changes in v8:
> - Check for a snapshot before allocating the temporary cluster mask.

here's the v7->v8 delta:

 lib/group_cpus.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/lib/group_cpus.c~lib-group_cpus-snapshot-cluster-masks-to-keep-grouping-hotplug-invariant-v8
+++ a/lib/group_cpus.c
@@ -380,9 +380,6 @@ static int alloc_cluster_groups(unsigned
 	const struct cpumask **clusters;
 	struct node_groups *cluster_groups;
 
-	if (!cluster_snapshot)
-		goto no_cluster;
-
 	cpumask_copy(msk, node_cpumask);
 
 	/* Probe how many clusters in this node. */
@@ -454,6 +451,9 @@ static int __try_group_cluster_cpus(unsi
 	cpumask_var_t nmsk;
 	unsigned int i, nc;
 
+	if (!cluster_snapshot)
+		return 0;
+
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return -ENOMEM;
 
_

