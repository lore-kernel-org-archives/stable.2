Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793211499;
	b=43i2TD30TcvuKRpPVPnkKq+3WsIq1K2/zd3wxQ9vsgktqlebWhJpEwH1CLfcEHllTmxT
	 Ah55LpeLIKbcBj9Tx9CppCmBcJkTg1YZRM0AncdcDqlRISuFdKKUHGywoTpPPAvNQQHF3
	 rh1K5wniesF/LTmgFRwUFTeEfZRO292rfFlgudlSp5wfbClUWjmirjZm5WUBGNLHIWuBS
	 2/WdyECPtYZIvI6gXSFeTjEZiQetdkk5quk6f0NTexo3pr1PL3jsd1ynhutPYtFmDoxK4
	 Y2xSpCkLA+tVP4aao2IX39kokSS6Kx3G1k6v5rmEFSDNYjnfDpSsGyUEp0p9NbMEY8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793211499;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0oiry0ZaDpBozgKs3Yn0AN+r5C81GF5EHZ1wjFVYL/k=;
	b=n+FpbPQHuiorCVy5Wh9dJTepjCK0rYYyh63r/W2ijIaoMUL2thW94aa4vaFP+p6uBee6
	 0rfa/ujkKi+4gbsego1ns6i4gEbH9iDDMqJDvvUMk9KrhVdcTlKZFdUf7p+RzQ7JodmlE
	 nWMrcEBCk6SD76MlehYX+Waf40zpus1D+sbO6E/8PoWWENIH1dbnx4PvN/kQfvkJ6c+3K
	 MM7g6RNf+5kmZr6uHQcZkupR05uEdSumHDsgAV4VVELVGXIXvlKQeVgaxeCs4sev3q3dH
	 vsD1spidUziqh9m9ouJ+TLXJBISRH7EA5pzc4rbb4Gj7J7fUPznL/hi44BXS723yZrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gU0j6S5l;
	arc=none smtp.remote-ip=91.218.175.123
Received: from mta0.migadu.com (out-123.mta0.migadu.com [91.218.175.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7985606A31E
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 18:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7985606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gU0j6S5l
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FzSLDoLL3l9c7gMzSXMHTUPkCis4CHxPNrJyJmMFlpk=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793211490; v=1; x=1793816290;
 b=gU0j6S5lCSGrqFK3BVUBPVUpoJjMru/bTOQUq6k4s8hYE7pyHyjgIVQVNpixe8IGEYsHiSTo
 Sa9tQgmS5tlXViRJaa2x65+OMlfI5V623xi1qnOcoJVUKz1oQgC6LPcveWygQ0GXNgY6TXjxYXu
 B7nX71X6/VXlzdJeHTaUT5fQ=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5ad5a2eaaa496885;
	Wed, 28 Oct 2026 18:18:10 +0000
X-Mizu-Trace-ID: 5ad5a2eaaa496885
X-Migadu-Flow: FLOW_OUT
Date: Wed, 28 Oct 2026 11:18:08 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Yingjie Wang <x-professor@outlook.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, 
	Manfred Spraul <manfred@colorfullife.com>, Alexey Gladkov <legion@kernel.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Vasily Averin <vasily.averin@linux.dev>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>, 
	Michal Hocko <mhocko@suse.com>, Alejandro Colomar <alx@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>, 
	"linux-man@vger.kernel.org" <linux-man@vger.kernel.org>, 
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] ipc/sem: account enlarged sops arrays to memcg
Message-ID: <auI8CyIxjbLEMeEZ@linux.dev>
References: <cover.1793207025.git.x-professor@outlook.com>
 <565d855cbd81e0f49018da21df00ff0308f646b1.1793207025.git.x-professor@outlook.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <565d855cbd81e0f49018da21df00ff0308f646b1.1793207025.git.x-professor@outlook.com>

On Wed, Oct 28, 2026 at 05:03:57PM +0000, Yingjie Wang wrote:
> Commit 6a4746ba0619 ("ipc: remove memcg accounting for sops objects in
> do_semtimedop()") removed accounting based on the assumption that sops
> arrays would remain small, describing a maximum cost of two pages.
> 
> SEMOPM is a UAPI default that can be changed when rebuilding the kernel.
> It must not also define the accounting policy, since changing that default
> would enlarge the unaccounted range.
> 
> Keep the historical small-array range unaccounted with a fixed internal
> threshold of 1000 operations, and use GFP_KERNEL_ACCOUNT when the actual
> nsops exceeds it. Requests within that range retain the existing allocation
> behavior, while larger user-controlled arrays are charged to the caller's
> memory cgroup.
> 
> Commit 50ec499b9a43 ("sysctl: allow change system v ipc sysctls inside ipc
> namespace") later made the per-namespace limit tunable by IPC namespace
> owners without capabilities in the initial user namespace.
> 
> Link: https://lore.kernel.org/r/20261016152609.2528805-1-x-professor@outlook.com
> Fixes: 6a4746ba0619 ("ipc: remove memcg accounting for sops objects in do_semtimedop()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yingjie Wang <x-professor@outlook.com>
> ---
>  ipc/sem.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/ipc/sem.c b/ipc/sem.c
> index 5ec41de7e85b2..a8c9807175520 100644
> --- a/ipc/sem.c
> +++ b/ipc/sem.c
> @@ -176,6 +176,7 @@ static int sysvipc_sem_proc_show(struct seq_file *s, void *it);
>  
>  #define SEMMSL_FAST	256 /* 512 bytes on stack */
>  #define SEMOPM_FAST	64  /* ~ 372 bytes on stack */
> +#define SEMOPM_NOACCOUNT	1000 /* ~ 2 pages for struct sembuf */
>  
>  /*
>   * Switching from the mode suitable for simple ops
> @@ -2234,7 +2235,10 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
>  		return -EINVAL;
>  
>  	if (nsops > SEMOPM_FAST) {
> -		sops = kvmalloc_objs(*sops, nsops);
> +		gfp_t gfp = nsops > SEMOPM_NOACCOUNT ?

Instead of making this conditional, can you just GFP_KERNEL_ACCOUNT
unconditionally and benchmark it. The kmem accounting has changed a lot since
that patch. If the performance impact is fine then we should just use
GFP_KERNEL_ACCOUNT.

