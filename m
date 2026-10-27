Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793064547;
	b=xpzYODrhwTdi+H5IYs2niGC67FEqYB+N2VgoRl0vlZfEK/h0djqbTJZWpjBBAkFVIGmj
	 9ZpF/g2beeAm6/jAkNXxSuC4iznQxjInydyRa1OPhqhVNsNcfnZ1/A9SWXVk/TSNwpziO
	 ZnSE/9JWqSSx29xmtXU9279sA/PUrXkzkvg51QW5xtscm20Us7JAP1tXFtsW3JDojlcKQ
	 wLLTl5raGVXtm1SrAVLJi/mUey9CX5PNzzfydFDqSSxr7xqwogDAupGXE7VMoeQNBWixe
	 pQ4swWmG58a5MWcvzbUG3jOjbdu7ZF8fOOB12J1WZ2UuOQJasw/hjNPsm9gAiMfOT3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793064547;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=M4FSiPobiKPDMcBSbXnngYDEQnQ7VynA6dCDLEbFYos=;
	b=Eq02q0qd3i9NsiyJ7WeEnl6Op3UhhLCdIEPlNdKFjPbe9UZ9ngLrmIze98ob697jVByc
	 C3WtSZS6KRREP2XMDSZ8AQ1zcqD1rIDyUQs7yqYCZITijW66PQUYRrB5P70T+DGkUIzyl
	 Kiimv2mXaC4BUtukd13j/1a03JXSv96wxVRpOVEsqFRcTl3M7oZetopZhsQ/Y/PMLh+bq
	 +Swen7Pnss9uXSa3McspD8GmnqStg9YGawvGS+cqND/rXmLUw41Bo4EzyUwg+fb5wjbqD
	 l03Rm5cNmmHAsd6Xt80fGwwtj79ruria6fyJIaMEXk26hxP02+6vKOwWuhMu8r7M/9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SV0l+GzY;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3F4606A31B;
	Tue, 27 Oct 2026 01:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1C3F4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=SV0l+GzY
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793064537; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=M4FSiPobiKPDMcBSbXnngYDEQnQ7VynA6dCDLEbFYos=;
	b=SV0l+GzYAhUQ6KGraGu0dmx5nVnTnOStQi0F5o0Hd52llTzPrJt+2OHDGvoUcxC5LhjxrzInkSI2qI2OAIDIng4g9CjuhwBUWcXEC775ZSnTfYVgi1FqgSdeFlgUq0fltxuSbIIGd9wWHn/AZSLficYk1Dflt3IWEjq4yPiP1ac=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0XDc0mdt_1793064535;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDc0mdt_1793064535 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 09:28:56 +0800
Message-ID: <7346ff85-4941-45ea-951c-322c385704f0@linux.alibaba.com>
Date: Tue, 27 Oct 2026 09:28:55 +0800
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
Subject: Re: [PATCH v2] mm: Make swapoff interruptible when unusing mms/shmem
To: Chris Down <chris@chrisdown.name>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Vineeth Pillai <vineeth@bitbyteword.org>, Hugh Dickins
 <hughd@google.com>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>,
 Youngjun Park <youngjun.park@lge.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Kelley Nielsen <kelleynnn@gmail.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <ar2YlFYjYUZ49ZA5@chrisdown.name>
 <at9kJwdGkHPsWwgG@chrisdown.name>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <at9kJwdGkHPsWwgG@chrisdown.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 10:31 PM, Chris Down wrote:
> try_to_unuse() only checks for a pending signal between mms, and
> shmem_unuse() doesn't check at all. That means that once swapoff gets to
> a process or a shmem file with a lot swapped out, nothing can interrupt
> it until every last page of it has been read back in.
> 
> Just as one example of where this can concretely show up, freezing tasks
> for suspend or hibernation has to wait for swapoff to notice the
> freezer's fake signal, and gives up after freeze_timeout_msecs (20
> seconds by default).
> 
> Here's a facetious example where one swaps out 2GiB of one process to a
> swap file on ext4, starts swapoff, and half a second later tries to
> freeze with pm_test=freezer. Writing to /sys/power/state then fails with
> EBUSY and this in dmesg:
> 
>      Freezing user space processes failed after 20.003 seconds (1 tasks refusing to freeze, wq_busy=0):
>      task:swapoff         state:D stack:0     pid:3175  tgid:3175  ppid:2955   task_flags:0x400100 flags:0x00000419
>      Call trace:
>       [...]
>       io_schedule+0x44/0x70
>       folio_wait_bit_common+0x1ec/0x3d0
>       __folio_lock+0x24/0x40
>       unuse_pte_range+0x2d0/0x348
>       unuse_vma+0x158/0x248
>       unuse_mm+0xfc/0x150
>       try_to_unuse+0x104/0x3f8
>       __do_sys_swapoff+0x220/0x5d8
>       [...]
> 
> The same goes for anything else that wants swapoff to stop, like an
> admin hitting ^C in a panic, of course.
> 
> Prior to commit b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
> try_to_unuse() was driven by find_next_to_unuse() which checks for a
> signal before every entry, so let's restore that behaviour.
> 
> Just as an example of the improvements, here's how long freezing takes
> in the same test while swapoff is happening on my computer:
> 
>                        before                  after
>      400MiB anon       8.925s                  0.028s
>      400MiB shmem      1.639s                  0.003s
>      2GiB anon         failed after 20.003s    0.011s
> 
> Fixes: b56a2d8af914 ("mm: rid swapoff of quadratic complexity")
> Cc: stable@vger.kernel.org
> Acked-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Signed-off-by: Chris Down <chris@chrisdown.name>
> ---

LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
