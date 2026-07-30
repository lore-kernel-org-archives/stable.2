Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266763B388A;
	Thu, 30 Jul 2026 18:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785438002; cv=none; b=lduJ8euk+F06GfMdOMFkqeQp8A3ufTTjOjB2zjw9NH73Rj7DKEdAPZoU4qlED5Kt068vdkgE/RgTct7TDH33V8QgT3m9OI3dtDAhGGQ8PqrGF9DOI3SUlut8Nhz0Y0tAf5byIVc8FNxHGQIIgeiUFD8UZ8UrOrW6F/KyTR0dcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785438002; c=relaxed/simple;
	bh=h3Ktl2+XB69kEZ45TU2aF+PA/7TcDAQ0hcYkBDm88+I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SZtIR19NF4IPs9OBdCtNO2vhFsJt/DdRfw3RAXfR/FFbe6FD9HI5eZLDGXmxgNwPsOvk24KxU9kuVgI/DQuiPLBqFxlZeHaE0/C3Oj3lzk/e1N0Q4YTlW/tXCTv8lKlPzUFwOv8o6CiT3bxgkBTguO+XnNHKI3h+LE09C5wxQqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ucLWT3Yx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ucLWT3Yx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CD71F000E9;
	Thu, 30 Jul 2026 18:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785437999;
	bh=Tayj0EGBxc9QIq60kNKxuIuBQ/P429IFHvuIK0fivRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ucLWT3YxhocSPSq7t+C8gdpLzheHCIIkdTuk0ZW8BH2O6O+kPRu28yszrGgR6XLmC
	 roV+yxv+/Zu4CGryFVUiypI5QTHuhPiZDR0AvxH7EeLM5SC6Ftd0nuEkLUQstG7+Sc
	 /pUEuwoM/UN4JhxCs+t7Wd1as2DQOkQymlP6ZhTY=
Date: Thu, 30 Jul 2026 11:59:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, Baolin
 Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <liam@infradead.org>, Nico Pache <npache@redhat.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song
 <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, Usama Arif
 <usama.arif@linux.dev>, Pankaj Raghav <p.raghav@samsung.com>, Hannes
 Reinecke <hare@suse.de>, Hugh Dickins <hughd@google.com>, Yang Shi
 <shy828301@gmail.com>, Kiryl Shutsemau <kas@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, Hengbin Zhang
 <uqbarz@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH mm-hotfixes v2 0/2] mm/huge_memory: fix huge_zero_pfn
 race
Message-Id: <20260730115958.ed8ec3db759f06cdd10feac8@linux-foundation.org>
In-Reply-To: <20260730-fix-refcounted-huge-zero-v2-0-c5d8a41b317f@kernel.org>
References: <20260730-fix-refcounted-huge-zero-v2-0-c5d8a41b317f@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 11:55:46 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

> There is a subtle race in the reference-counted huge_zero_folio
> implementation.
> 
> The fast path atomic logic fails to account for the fact that the
> shrinker (which drops the final huge_zero_refcount pin) can overwrite
> huge_zero_pfn with the ~0UL sentinel value in shrink_huge_zero_folio_scan()
> after a racing get_huge_zero_folio() installed a valid value there.
> 
> This results in huge_zero_folio being correctly set but huge_zero_pfn being
> set incorrectly and thus is_huge_zero_pfn() and consequently
> is_huge_zero_pmd() will misidentify the huge zero folio as being an
> ordinary THP folio.
> 
> This can result in the huge zero folio being split and otherwise treated
> incorrectly.
> 
> The solution to this is very subtle as there is an atomic fast path, and
> thus ordering in weakly ordered architectures has to be treated very
> carefully.
> 
> The first commit fixes the issue by introducing a spinlock around
> huge_zero_[pfn, folio, refcount] write, with careful consideration paid to
> load/store ordering in the fast path. It is placed first and kept as small
> as possible so that it can be backported on its own.
> 
> The second commit is a pure cleanup which reworks the
> CONFIG_PERSISTENT_HUGE_ZERO_FOLIO logic to better separate the persistent
> logic from the dynamically allocated one.

Thanks, updated.

And moved to mm-hotfixes.  But is it appropriate to fast-track a
tricky-looking fix to a four year old bug?

> Andrew - I know you don't like a mix of fix/cleanup, but thought it'd be
> easier to keep the 2 together as there's a dependency.

Sure.

If we were to upstream just the fix then really we should defer merging
the cleanup into any tree until a later time.  Because the cleanup
might accidentally fix a flaw in the fix.  Sending just half the series
upstream results in an untested code combination.  Unlikely, but it's
happened a small number of times and it's a risk.  Keeping both patches
together eliminates that risk.

> ---
> v2:
> - Reordered the series so the fix now comes first with the
>   CONFIG_PERSISTENT_HUGE_ZERO_FOLIO separation following it as a pure
>   cleanup as per David.
> - Fixed up wording as per David.
> - Cleaned up Cc's since dependency of fix on cleanup no longer exists.

Here's how v2 altered mm.git.  One changed line, unchangelogged!

--- a/mm/huge_memory.c~b
+++ a/mm/huge_memory.c
@@ -328,7 +328,7 @@ static unsigned long shrink_huge_zero_fo
 			return 0;
 
 		zero_folio = huge_zero_folio;
-		VM_WARN_ON_ONCE(!huge_zero_folio);
+		VM_WARN_ON_ONCE(!zero_folio);
 		WRITE_ONCE(huge_zero_folio, NULL);
 		WRITE_ONCE(huge_zero_pfn, HUGE_ZERO_UNSET_PFN);
 	}
_


Sashiko said some waffle because it still doesn't understand that
__init-time allocations are considered immortal.

A cleanup opportunity is to get into this code and formalize that
convention.  And the convention that debugfs return errors are to be
ignored.
