Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71A43DB629;
	Thu, 18 Jun 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775314; cv=none; b=tNgLPX9ua/0ztgBJFnjO7VabpMan07EgyngbiVMDETLanfUhd56mGUvMKLouZHOqhnFgdxe5k9xLnDwD9DBngB7DIFYpGVfwd8A01xz2n/HDskLTKLluap2sgWlvUoM0N2tr3lAK8p6m0BsjzdCmLQYx7Pz+cGSys5zm8bFSPNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775314; c=relaxed/simple;
	bh=zJ7sNs1B62D4n270G/YGpBK00wf5ZQUjvww5dvPiLUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDlteH/IyW++JyXX4QZ5I8u0GTHS8DCpwfm4B9UNfJ69rlUsW3vY6mAB3opMAMg4ek1S5owNpmz5MmYY7DCK0ukSCKD796iq0lPY2nMkbwO7wHOMhNk/3rodka6McYF/vYeQM+XT71JwM0mgvcioRQj9QrCjBIPnY+kJC9avO00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJVdV6Se; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJVdV6Se"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDA151F000E9;
	Thu, 18 Jun 2026 09:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781775312;
	bh=svnJRlqC7nBj8+wumxi3S0D0nQwN9ygt9ENMd/YHoEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cJVdV6SelfsuOc/iIjycuLFBI9QO16gDia1DU906oY9Ep28XwzavtBGwP1CKqO1tm
	 X/upK8GZWfXwOPQUNWjgYujhlCU/dKGy/emkNdqHKJ0XMZ7PaXR8sJYNhXj9hqI9D/
	 ZyME1MMPXDUgQ8NnAOe03iLKG9Cg+zhJI10/3snoUD1RmCI9lTpG5pnGS0aoxchhMa
	 IcyGmH8Y+MAoYLste+BY/2DzAg9b/lcDp9hdeiGXuJzGG7MwKqT6aoQcIl8VtBUKkE
	 IxY3sKC+z9AJbANQ4BbLx+Jwf24TU9dGs5cKEe3C3t7IVI88dzcgT4YAnu8JbX48AK
	 PBGH1kAftespA==
Date: Thu, 18 Jun 2026 12:35:04 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>,
	vova tokarev <vladimirelitokarev@gmail.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] userfaultfd: prevent registration of special VMAs
Message-ID: <ajO7yI541hphWRb8@kernel.org>
References: <20260617194059.2529406-1-rppt@kernel.org>
 <5a993689-f730-406d-8515-8bb6025cc851@kernel.org>
 <ajOtfdGgFQYL-T6f@kernel.org>
 <ajOvwGs5xhnfBu-k@kernel.org>
 <41ef0dce-e973-4947-b5e3-150fdb07f1a6@kernel.org>
 <ajO4sLq2UBciSgOn@kernel.org>
 <dd2ae577-9b7d-4e40-81d0-fa9fcd7e0767@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd2ae577-9b7d-4e40-81d0-fa9fcd7e0767@kernel.org>

On Thu, Jun 18, 2026 at 11:25:31AM +0200, David Hildenbrand (Arm) wrote:
> On 6/18/26 11:21, Mike Rapoport wrote:
> > On Thu, Jun 18, 2026 at 10:47:19AM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/18/26 10:43, Mike Rapoport wrote:
> >>>
> >>> Ah, hugetlb sets VM_DONTEXPAND, so it must me excluded to allow uffd with
> >>> hugetlb.
> >>
> >> It would probably be cleaner to just allow hugetlb, and then check for
> >> VM_SPECIAL if not hugetlb.
> > 
> > Cleaner in what sense?
> > Will be uglier for sure, just take a look at vma_can_userfault().
> 
> I was thinking of this:
> 
> diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
> index 180bad42fc79..8a6803618a91 100644
> --- a/mm/userfaultfd.c
> +++ b/mm/userfaultfd.c
> @@ -2029,7 +2029,10 @@ bool vma_can_userfault(struct vm_area_struct *vma,
> vm_flags_t vm_flags,
>  {
>         const struct vm_uffd_ops *ops = vma_uffd_ops(vma);
> 
> -       if (vma->vm_flags & VM_DROPPABLE)
> +       if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
> +               return false;
> +
> +       if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))
>                 return false;

In a way that's an extra check for hugetlb, but it will work.
Will respin.

>         vm_flags &= __VM_UFFD_FLAGS;
> 
> -- 
> Cheers,
> David

-- 
Sincerely yours,
Mike.
