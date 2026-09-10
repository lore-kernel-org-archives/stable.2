Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D982D2877DA;
	Thu, 10 Sep 2026 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789008435; cv=none; b=aHX4qb8JrbZ59LokwtOeTC/H9kXMTtK4wc13l25EnhG+ssKHZaSimtqccILT7bI/227h6eWEzbn4dIOdMAoah/ei9J/3bJVE80Gzo6AHIUYgnXb/msVNLvVl36u4ql8EydBoy1Aszf/qkKRdKhFrqqfVAZ1LbYiE6+cfDja95A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789008435; c=relaxed/simple;
	bh=d0dcrt7bn2rzR78vVZyWJIxQ+SHzCjONmEeWXccRBQ4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=j+HNgcsi9HwScyhYVzXlRifVtau04Gz1Qe8sJepc5SBItf93yh3uiobrbu6fTXnYt+QAOuLJnRBGV5lyWvARUMelQzg++kp3TLzmHo5zzk2ZxVR9xwxA7Qy8Seti3NnMrCyJNUcWPi3LKQsdGxAJR4ff6om22W7pPUQxyPYwnDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=GqB8NuMi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GqB8NuMi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF841F000FF;
	Thu, 10 Sep 2026 02:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789008433;
	bh=DwQIpJL6XFgYeovLrOfrrQBEuXDvt/nYNYAROMqmr4U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GqB8NuMiJIO3o52zIm9Um/v0WDyjDNDLMrzcmqdqsCMJGuke572wcg3uVfMlUl2Q7
	 7KReR5eczs3MlwumyAKo3tUFyHPQ5FI+Qtr24G4RkCYGbyy+h9XQ4DI5hFNhz4UJ9d
	 MKZe2wBRBN3bcLtW/VDIPE3RVoPHuQgVkwlD0VUU=
Date: Wed, 9 Sep 2026 19:47:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: yosry@kernel.org, chengming.zhou@linux.dev, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com,
 kernel-team@meta.com, stable@vger.kernel.org, Alexandre Ghiti
 <alex@ghiti.fr>
Subject: Re: [PATCH] mm: zswap: don't fail a large-folio swapin whose range
 is not in zswap
Message-Id: <20260909194712.706fb2e87a6e59097424c31d@linux-foundation.org>
In-Reply-To: <20260907161938.1932355-1-usama.arif@linux.dev>
References: <20260907161938.1932355-1-usama.arif@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 09:19:38 -0700 Usama Arif <usama.arif@linux.dev> wrote:

> thp_swapin_suitable_orders() and shmem_swap_alloc_folio() sample
> zswap_never_enabled() to decide whether a swapin may use a large folio.
> zswap_load() samples the same one-way static key again once the read
> reaches it.  Nothing serialises the two reads, and in between the task
> allocates and pins a high-order folio, which can sleep.
> 
> If zswap is enabled for the first time in that window, a large folio that
> was correctly permitted reaches zswap_load(), which rejects every large
> folio with -EINVAL.  swap_read_folio() treats anything other than -ENOENT
> as "zswap handled it" and skips the backing-device read, so the folio
> comes back unlocked and not uptodate: SIGBUS for an anonymous fault, -EIO
> for shmem.  The data is intact on the swap device - it was written there
> before zswap was ever enabled - and the not-uptodate folio stays in the
> swap cache, so every retry of the fault fails the same way.  With
> panic_on_warn the WARN takes the machine down rather than the task.
> 
> Scan the range instead of rejecting the folio.  The caller has pinned
> every slot before issuing the read, so zswap cannot start a store or a
> writeback into the range and the scan is stable.  If nothing in the range
> is in zswap it is all on the backing device: return -ENOENT and let
> swap_read_folio() read it.
> 
> A range that does have a slot in zswap is still refused, because zswap
> stores large folios as order-0 entries and cannot reconstruct one.  That
> stays reachable - a slot shared with another task can be stored inside
> the same window - and refusing is correct, since the alternative is
> returning the stale device copy.  Report it as -EIO rather than -EINVAL:
> the request is valid, zswap just cannot serve it.  The only caller
> distinguishes -ENOENT from everything else, so that part is a
> documentation fix.

So to hit this bug the user needs to enable zswap system-wide during a
teeny race window in the swapin code?

I suspect nobody has ever hit this and couldn't do so if they tried?

> Fixes: 242d12c98174 ("mm: support large folios swap-in for sync io devices")
> Cc: stable@vger.kernel.org


Documentation/process/stable-kernel-rules.rst, with which I agree:

Rules on what kind of patches are accepted, and which ones are not, into the
"-stable" tree:

- It or an equivalent fix must already exist in Linux mainline (upstream).
- It must be obviously correct and tested.
- It cannot be bigger than 100 lines, with context.
- It must follow the
  :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
  rules.
- It must either fix a real bug that bothers people or just add a device ID.
  To elaborate on the former:

  - It fixes a problem like an oops, a hang, data corruption, a real security
    issue, a hardware quirk, a build error (but not for things marked
    CONFIG_BROKEN), or some "oh, that's not good" issue.
  - Serious issues as reported by a user of a distribution kernel may also
    be considered if they fix a notable performance or interactivity issue.
    As these fixes are not as obvious and have a higher risk of a subtle
    regression they should only be submitted by a distribution kernel
    maintainer and include an addendum linking to a bugzilla entry if it
    exists and additional information on the user-visible impact.
  - No "This could be a problem..." type of things like a "theoretical race
    condition", unless an explanation of how the bug can be exploited is also
    provided.
  - No "trivial" fixes without benefit for users (spelling changes, whitespace
    cleanups, etc).


If this patch meets the above then its changelog needs an update!

