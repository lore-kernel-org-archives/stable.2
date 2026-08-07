Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DDC34751B;
	Fri,  7 Aug 2026 20:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786135123; cv=none; b=eX0LWzvhR/8U0czdSoavD8aneUFiamwuQxoGDJNR1VRhBudsFW8ltLjqWfWoFlA0sQcLiTMg86KuaVv7gD3LM+n39iYDbvkUowNTbCdBbzq3ERUdbLG0uHjOg8cqGLhYkhPEZ3gmOCZLN3bK9dVcrD5URW8u9FVCIPJFr3zY5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786135123; c=relaxed/simple;
	bh=LnQS2cf8VJdhgssIEL8Pnnh71G3MprD//oaYHNkevkg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OJrwSLp7yYXG49v92/4cfRZsv9fzXoJ2ffRkEpMkklGiogRYTVhhcp+CKPi1OEvU1Kr5cNIYZuXv3mLEiEpH2Dyf7XLgmd+yExyP2BZfzkA74jgeAqIS/FkvzthByq8BgcuWPaKTxgU+sTWdJ5ZLh17wScxQMl6VgeUXk2QVI58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=0E0fc+Yl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="0E0fc+Yl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B0931F000E9;
	Fri,  7 Aug 2026 20:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1786135121;
	bh=gdI9Rh9kOJ1DGa3Qe6c3xPmH/zYwnik4MVDgOOD7fEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=0E0fc+YlE6wwPYljOOCjLRHeETTBhMxnZIXQdPYgbcvzox10g246YI78AlU7pBokw
	 8axxgwoe+V+TneD1d4XKMtlxqdmQvxaKlYGr5Wfb/9pnPNh0D/UDt/L734HdUH6NRG
	 m4f/dFWCAZ5+prZyp2L03n+Q/5LkOlaX9SeY0WnY=
Date: Fri, 7 Aug 2026 13:38:40 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Vishal Badole <Vishal.Badole@amd.com>
Cc: <tglx@kernel.org>, <linux-kernel@vger.kernel.org>, <bp@alien8.de>,
 <wangyang.guo@intel.com>, <tianyou.li@intel.com>,
 <tim.c.chen@linux.intel.com>, <dan.liang@intel.com>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH] lib/group_cpus: Snapshot cluster masks to keep grouping
 hotplug invariant
Message-Id: <20260807133840.31a194a9cd04d4a2b6d817c1@linux-foundation.org>
In-Reply-To: <20260807073612.3711269-1-Vishal.Badole@amd.com>
References: <20260807073612.3711269-1-Vishal.Badole@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 13:06:12 +0530 Vishal Badole <Vishal.Badole@amd.com> wrote:

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

Thanks for the careful description of what is wrong.  It helps.

And things do sounds very wrong.  Could people@intel please prioritize
their review and testing of this fix?

> Make the cluster grouping depend on the complete cluster topology rather
> than on whichever CPUs happen to be online. Snapshot the cluster masks
> once while every CPU is online and reuse that view for every later spread.
> A fully-online view is the complete cluster membership, so the partition
> derived from it is identical no matter which CPUs are online when the
> controller is reset, which is exactly the invariance the callers already
> assume.
> 
> ...
>
> +	/*
> +	 * Only a fully-online view is the complete cluster membership; if any

minor: the above sentence is hard to understand.

> +	if (!data_race(cpumask_equal(cpu_possible_mask, cpu_online_mask)))

AI review suggests using cpu_present_mask here:

	https://sashiko.dev/#/patchset/20260807073612.3711269-1-Vishal.Badole@amd.com
