Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC17330317
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 05:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790573175; cv=pass; b=lbNBrIRHY/1tjAysi/hxFanstUBMXM6jwf7COElDZB5+A++5DsFf5A0Y8jkO67vZuTKZeHyUUI6j89mu8hYuvWNpEc3Slh6ycdPU9crvBHx8xE+qwncghxDTyOb0rD2pLC7XsQzJcjDwzt3aAdmaCQlsOfoKx+Ern0i0WKpoAkA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790573175; c=relaxed/simple;
	bh=ulKfwKoh5ZniJSXC97YGKCyDolFa0F2AklKeKJ+3iYI=;
	h=From:In-Reply-To:MIME-Version:Date:Message-ID:Subject:To:Cc:
	 Content-Type; b=sc+GpJmZfK+msB5J6NL23NIohTHO/PjEHTSOBeLj/Q6j+4eHSYYhJ6Nl+s1VzPtdL9HLqZJGDSMfAOnXWE6eEBZYhv/wfEzLd9/iSjhcYyb0WAjSEq67kmF5zbuRbkC8W7XkVSv1VRxcVmT6VwTnCsHcfx0JA+B64wIxQ9XzXJ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rGylari8; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rGylari8"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-52fb76ec504so20307361cf.3
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:26:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790573173; cv=none;
        d=google.com; s=arc-20260327;
        b=H4dTBFFTFHmmnNEv1Z2BNfStMDD5rXRKsT1gOD7/7Lvoenlco0IEBr6tiTqxy/Uy49
         eqKcm5K35+uOyOKoukBXGe6xehCQoU0A2chH8mB17qAp5k3H+EO2ceCS5jHungUBNn3U
         yv4gmRb5bkzBfQkKl1Te1OsYajBVp/Vv/C7I7QXMm7KKaXZWS/fN2YjoTwzdWl4QdygU
         oBErEgSL9sGPsT80Oneuq80ynqyYUhAgBuZe/L8/4ClJCDLTZNuElwlsOWnZmsvTJL9r
         HRpnJH/wAIdhBkwkWFhD4o6x5RfwbYML27qDXJLPADzRdTmiW8KZKNyV80Uq1vvnU2nf
         S/cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:in-reply-to:from
         :dkim-signature;
        bh=9uhJQMU9Md0aI6D1ejMKihBiU/dixd7kNMrT0BD86Fg=;
        fh=iCeueQVMwtYyWPbCi3zHd+lJ+16XP6ETUD/E8hP/fgc=;
        b=bETitlx7VzobLCtZ1goFxIDIkFo4RQeng92MnXVmuSc6mhTBaLQcg5q6IFnYbyd0iG
         AgINWqOvTk0/giUJBW6frqiKqOOzvl6gh8+VqRZxr1D99gm3LvsCgVCVGuGzNFzbSaLN
         JfaXSUVIsEcVNgaFOYkkptAoQ0HlaHYaHFZmj2Mcpf7cAIkMZ+Yu9k68vAHIr0xf4772
         0w76Q1bQuHblHVMGX6im+Gk4SZbgNK3yUywns9ZmNcZ3gyzxPs7wRE96kO+pC4ru5y48
         3CfQjDMNvSQ7kBApmuZZdsElwArwrR/TwOvZJBoOByYYitozjBYVwdX96I4jA2tftX00
         y7/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790573173; x=1791177973; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9uhJQMU9Md0aI6D1ejMKihBiU/dixd7kNMrT0BD86Fg=;
        b=rGylari8NB9WHgBT/7ONM8TF/2z9mTbaMDKA2DM3GQfzAK/YkLj/MyzDdpwlfb270K
         kPdfVmtBFtKobZ0xW6nn329thwv2KIL0A4tBPk14ATd2im4jGqNenAuIXvdsBB4jnTAH
         Iqks0jAUJ2oPMJOe92YtMPxhuDBOoqTQifVIOEh9ycXTr/A8f0ely+OXA6K0IREj4B5E
         M4v+m7dGmAY5kJCeIY5r4z8u3lkdANX5o+WROKFPqXvpeQVlOf/8XBdl4leQj6z+3RdS
         n7sn0k7p8LYGkrqgBqkWHH8PtwxOrLvH2bOMc6CoDZ2AYSA40gtmEUdAEKEflQMAo/Lm
         Vwiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790573173; x=1791177973;
        h=content-type:cc:to:subject:message-id:date:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9uhJQMU9Md0aI6D1ejMKihBiU/dixd7kNMrT0BD86Fg=;
        b=c8NWcXDsEAjGl1bjrFgzsP6+0dhiP0E0oso9L/aqC/UQOJQnvsGxnuA7BeAcA7p26a
         zR9AnXls98dXHBM4fOe0lYiBzMLoCYweRxOIFrHQ3FpII5v0u7qqfWvMhhfOYWlmsz6h
         Hf7Xvd+LPpU2pBxXQyxeaG814cFk5Q54xAjguxwnnsptnUpRYjt+YBXOWp+qbDAtCKCV
         9fqiwt8zSue0vU27lJgba2Pej0CfQXwNWUT64ZAaMzSzZFFWmjwL7nNLt45v2ZAbvCbM
         c7pD+GRDBwlbN8qiy+Y7FgKqSHytImSiuwYP1E5PKwOV9mmI/X5TSGHid0mqCWgMlYJt
         wH4g==
X-Forwarded-Encrypted: i=1; AKwUvBzpkdS4lBnUCJgNU6XCXhUZ1nXO7hPvj/DXGDKsv6eg4X6Lceykr1KLB1HlDzA53oq57KQrlUc=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUIHUtZhQTM2YsJVwU7faeItoGGKvS1JXEWYYkBZxKGH8GyyY1
	UZV24+WitWDdz6mbuxjK2HO/pqG1uJoTxvpIHt4K2eivH48K9HUOubHNChlAsT8OYarZG56T8Ua
	jdXzsCtdKWaOE2K0FrN/XkGYiYo0tDOQevP4qKjIG
X-Gm-Gg: AYBFou0vHBPI1sbQvm1MqzOK4PRjDU6J1qZxA6h+Dsw/lgRnVOkLktyg2j66aQgvn4u
	7om2SZ/KSHdJR9kU8wlVOmYL1T2NAwAXNiEoNqB5XOnfak2Uz9YoR7xYZyN9ZqvbSaV/TO+96cn
	AkqOEuvM5Clxo3C6I0qQnBsMCJBbMW+ozxa3qMz71CyE6Fn8WVn1lIApKhxD9K+PLNp7lUFPA8S
	NiP/VAUVn5DePE/82JktdX9Ic/cDTiTmHuAynaL4dYygsmVxY1bqK7X+8nw3geA7/kjUkP79hai
	0mFFL1UZHkV5GvqtCwSAXJDI8nY7PGJvH/vf8N47QJeTZmVoX8FKihLtjt8DSh5uhq363E9ThxO
	NiBlM1os+2w==
X-Received: by 2002:a05:6214:27c1:b0:90e:8dcc:4e5 with SMTP id
 6a1803df08f44-9142f919107mr186704706d6.28.1790573172597; Sun, 27 Sep 2026
 22:26:12 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Sep 2026 22:26:11 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Sep 2026 22:26:11 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <20260428113037.88766-2-enderaoelyther@gmail.com> (message from
 Zhao Li on Tue, 28 Apr 2026 19:30:38 +0800)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sun, 27 Sep 2026 22:26:11 -0700
X-Gm-Features: AclHuK8teF1_hnBMYASoAggcWTeG1bGk-jNppBGAEy7BhwDUpekXIrCo_Z7K6QQ
Message-ID: <CAEvNRgEh9_cMQmiNLXumFLt7JtFy0VNNCNB=1mY71bz9JzUxtQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix max-only subpool accounting on
 alloc_hugetlb_folio failure
To: Zhao Li <enderaoelyther@gmail.com>
Cc: akpm@linux-foundation.org, mawupeng1@huawei.com, muchun.song@linux.dev, 
	osalvador@suse.de, david@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Karl Mehltretter <kmehltretter@gmail.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Zhao Li <enderaoelyther@gmail.com> writes:

> alloc_hugetlb_folio() calls hugepage_subpool_get_pages() when map_chg
> is set.  For a subpool with max_hpages != -1, that bumps used_hpages
> regardless of whether it returns gbl_chg = 0 (rsv slot consumed) or
> gbl_chg > 0 (used_hpages slot only).  If the allocation later fails
> before a folio is returned, the unwind must undo the used_hpages
> bump.  The old cleanup only ran for !gbl_chg, leaking used_hpages on
> the gbl_chg > 0 path.
>
> For gbl_chg > 0 on max-only subpools (max_hpages != -1, min_hpages
> == -1), hugepage_subpool_get_pages() took only a speculative
> used_hpages slot.  Drop that slot directly under spool->lock.  In
> that configuration hugepage_subpool_put_pages() cannot restore
> rsv_hpages, so the direct decrement is the exact inverse and is
> race-free against concurrent puts.  This matches the used_hpages-only
> part of hugetlb_reserve_pages()'s out_put_pages cleanup, but
> restricts it to the max-only case where no rsv_hpages restoration is
> possible.
>
> Mounts with min_hpages != -1 are left unchanged for now.  v2's
> approach (hugepage_subpool_put_pages() + h->resv_huge_pages++ to
> back a restored rsv_hpages slot) double-counts global backing under
> concurrent free_huge_folio() and creates phantom reservations under
> concurrent hugetlb_unreserve_pages().  Safe cleanup of that quadrant
> needs a coordinated fix across multiple call sites.
>
> Reproduced on size=20M hugetlbfs with the faulting task in a hugetlb
> cgroup whose limit is exceeded.  Vanilla leaks 6/8 hugepages of
> subpool quota; this patch leaks 0/8.  Verified under QEMU.
>
> Fixes: a833a693a490 ("mm: hugetlb: fix incorrect fallback for subpool")
> Cc: stable@vger.kernel.org # v6.15+
> Signed-off-by: Zhao Li <enderaoelyther@gmail.com>
> ---
> Changes in v3:
> - Replace v2's hugepage_subpool_put_pages() + h->resv_huge_pages++ on
>   the gbl_chg > 0 branch with a direct used_hpages-- under spool->lock.
> - Restrict the cleanup to (max_hpages != -1, min_hpages == -1) where
>   the direct decrement is the exact inverse of the speculative bump.
>
> Changes in v2:
> - Skip the gbl_chg > 0 cleanup when max_hpages is unset.
> - Add hugepage_subpool_put_pages() + h->resv_huge_pages++ on the
>   gbl_chg > 0 branch.
>
>  mm/hugetlb.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index f24bf49be047e..cfdeaf6394c5b 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3025,13 +3025,24 @@ struct folio *alloc_hugetlb_folio(struct vm_area_struct *vma,
>  		hugetlb_cgroup_uncharge_cgroup_rsvd(idx, pages_per_huge_page(h),
>  						    h_cg);
>  out_subpool_put:
> -	/*
> -	 * put page to subpool iff the quota of subpool's rsv_hpages is used
> -	 * during hugepage_subpool_get_pages.
> -	 */
> -	if (map_chg && !gbl_chg) {
> -		gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> -		hugetlb_acct_memory(h, -gbl_reserve);
> +	if (map_chg) {
> +		if (!gbl_chg) {
> +			/* Full inverse when subpool_get_pages() consumed rsv_hpages. */
> +			gbl_reserve = hugepage_subpool_put_pages(spool, 1);
> +			hugetlb_acct_memory(h, -gbl_reserve);
> +		} else if (gbl_chg > 0 && spool && spool->min_hpages == -1 &&
> +			   spool->max_hpages != -1) {
> +			unsigned long flags;
> +
> +			/*
> +			 * For max-only subpools, subpool_get_pages() took only a
> +			 * speculative used_hpages slot. Drop that slot directly.
> +			 */
> +			spin_lock_irqsave(&spool->lock, flags);
> +			if (spool->used_hpages > 0)
> +				spool->used_hpages--;
> +			unlock_or_release_subpool(spool, flags);
> +		}
>  	}
>
>
> --
> 2.50.1 (Apple Git-155)

This fixes out_subpool_put in alloc_hugetlb_folio() on a mount that
specifies max_size only, and does not introduce any further bugs AFAICT.

Tested-by: Ackerley Tng <ackerleytng@google.com>

Further details at [1].

[1] https://lore.kernel.org/all/CAEvNRgHQLifmcD1NO6cd7EVcCiQb6gJgNUo4HkFhZAvzuwMq0w@mail.gmail.com/
