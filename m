Received: from mta0.migadu.com (out-92.mta0.migadu.com [91.218.175.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC1A3B6343
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035117; cv=none; b=D2uMrkawkpAIO24Fm3fAan8BBaWajl4U0vLCb+nN/CH/pi3kgBsZqWrAuqPgtSChvLpVaJ7/mhz0vNz3PTJYU00l38L8NN8WAKPogxWLAJCQvR7M3wptJZ0kwxYng6absoM98QvCosI5Jw0k7GMwXLqejlPhf5dl905oWCHmJ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035117; c=relaxed/simple;
	bh=+YiOtMV9LtHLD/hVdNynO6GNFamQnmcFiMsxau6m56I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDWWU6xWogrJttwgqOty18/Ml9f1DLcFf8e1qQ+c7YS/M7ZbTxJS3e16BNfr1TBIVQBwvJpktvwUlSnD1g6dJLhA9hqJvDwl0WHl/6lWRk7LM9tNztySjEu5SKk8QIvExhZEbHSnEexzoPlq+XzzTKHCQxzU0Zd8w2VE7b60G+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bvG1tSfP; arc=none smtp.client-ip=91.218.175.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bvG1tSfP"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+YiOtMV9LtHLD/hVdNynO6GNFamQnmcFiMsxau6m56I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789035112; v=1; x=1789639912;
 b=bvG1tSfPqXZ/HsMTLiJbbg+qVuiO+f6K+Z6kWsto6B1gKoiLFjB0LxF2pOb2Bym3KHGQk0Pl
 d8sl+ZW0d8T0x5P7G9EmAiQVdKE+aJtQYIRfiOccOvbkPQkdQC9NBBzrXrtwbLO3uK9xZRtM6P6
 b55gx6oZJmYcpbrhlcLyXHxg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 20c1762f2feea230;
	Thu, 10 Sep 2026 10:11:52 +0000
X-Mizu-Trace-ID: 20c1762f2feea230
X-Migadu-Flow: FLOW_OUT
Message-ID: <7975ef1f-8d2d-4be3-b206-7c6326bed2db@linux.dev>
Date: Thu, 10 Sep 2026 11:11:50 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: zswap: don't fail a large-folio swapin whose range is
 not in zswap
To: Andrew Morton <akpm@linux-foundation.org>
Cc: yosry@kernel.org, chengming.zhou@linux.dev, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
 kernel-team@meta.com, stable@vger.kernel.org, Alexandre Ghiti <alex@ghiti.fr>
References: <20260907161938.1932355-1-usama.arif@linux.dev>
 <20260909194712.706fb2e87a6e59097424c31d@linux-foundation.org>
Content-Language: en-US
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <20260909194712.706fb2e87a6e59097424c31d@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/09/2026 03:47, Andrew Morton wrote:
> On Mon,  7 Sep 2026 09:19:38 -0700 Usama Arif <usama.arif@linux.dev> wrote:
> 
>> thp_swapin_suitable_orders() and shmem_swap_alloc_folio() sample
>> zswap_never_enabled() to decide whether a swapin may use a large folio.
>> zswap_load() samples the same one-way static key again once the read
>> reaches it.  Nothing serialises the two reads, and in between the task
>> allocates and pins a high-order folio, which can sleep.
>>
>> If zswap is enabled for the first time in that window, a large folio that
>> was correctly permitted reaches zswap_load(), which rejects every large
>> folio with -EINVAL.  swap_read_folio() treats anything other than -ENOENT
>> as "zswap handled it" and skips the backing-device read, so the folio
>> comes back unlocked and not uptodate: SIGBUS for an anonymous fault, -EIO
>> for shmem.  The data is intact on the swap device - it was written there
>> before zswap was ever enabled - and the not-uptodate folio stays in the
>> swap cache, so every retry of the fault fails the same way.  With
>> panic_on_warn the WARN takes the machine down rather than the task.
>>
>> Scan the range instead of rejecting the folio.  The caller has pinned
>> every slot before issuing the read, so zswap cannot start a store or a
>> writeback into the range and the scan is stable.  If nothing in the range
>> is in zswap it is all on the backing device: return -ENOENT and let
>> swap_read_folio() read it.
>>
>> A range that does have a slot in zswap is still refused, because zswap
>> stores large folios as order-0 entries and cannot reconstruct one.  That
>> stays reachable - a slot shared with another task can be stored inside
>> the same window - and refusing is correct, since the alternative is
>> returning the stale device copy.  Report it as -EIO rather than -EINVAL:
>> the request is valid, zswap just cannot serve it.  The only caller
>> distinguishes -ENOENT from everything else, so that part is a
>> documentation fix.
> 
> So to hit this bug the user needs to enable zswap system-wide during a
> teeny race window in the swapin code?
> 
> I suspect nobody has ever hit this and couldn't do so if they tried?


Yes, I think it would be very very difficult to hit this.

It was part of my PMD swap series, where its actually needed for the feature.

I think we can drop cc:stable, unless you think its needed Yosry?
> 
>> Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io devices")
>> Cc: stable@vger.kernel.org
> 
> 
> Documentation/process/stable-kernel-rules.rst, with which I agree:
> 
> Rules on what kind of patches are accepted, and which ones are not, into the
> "-stable" tree:
> 
> - It or an equivalent fix must already exist in Linux mainline (upstream).
> - It must be obviously correct and tested.
> - It cannot be bigger than 100 lines, with context.
> - It must follow the
>   :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
>   rules.
> - It must either fix a real bug that bothers people or just add a device ID.
>   To elaborate on the former:
> 
>   - It fixes a problem like an oops, a hang, data corruption, a real security
>     issue, a hardware quirk, a build error (but not for things marked
>     CONFIG_BROKEN), or some "oh, that's not good" issue.
>   - Serious issues as reported by a user of a distribution kernel may also
>     be considered if they fix a notable performance or interactivity issue.
>     As these fixes are not as obvious and have a higher risk of a subtle
>     regression they should only be submitted by a distribution kernel
>     maintainer and include an addendum linking to a bugzilla entry if it
>     exists and additional information on the user-visible impact.
>   - No "This could be a problem..." type of things like a "theoretical race
>     condition", unless an explanation of how the bug can be exploited is also
>     provided.
>   - No "trivial" fixes without benefit for users (spelling changes, whitespace
>     cleanups, etc).
> 
> 
> If this patch meets the above then its changelog needs an update!

