Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39134395AFA
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 07:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786086280; cv=none; b=nAGrfDRh/5NUm0GPB3/moqVkYORLtgYQBWOyosTzAzoVgUeXYoa1aazYcAs/hsMcJvDBCXdE7ZoVVxVOndAcgimOGp+t8H16xg6KALCo272XQJGROVUcMIDUH4Pb1k9NTjK39gIXw+XYvQRjOu5nlx0BK3kTgnMBuAlKwycW24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786086280; c=relaxed/simple;
	bh=yp3DcnSzMzAME5DOlWQebCmiTigsOCelERO525YTTYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+MpJvvJBjyry2c/oWLHQcLBoCWOjBjXj72PPoDaFxK7HNhXcIgpgSNweBBzBYfjNeVdxuOf+WOyFBsJ12lnoin12IVUpCTxWNrkIBUosni9RJ3dGDMSP0CdnR3SEfjEWyjvpAznlzjR05kNRtKv+rpmaGP/XpjGQv21Sn/jdMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UezLM5Ch; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UezLM5Ch"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE60D1F000E9;
	Fri,  7 Aug 2026 07:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786086274;
	bh=Ik7JUoi/i7BkukvJnP9Jbz5M5xZ0snZSGsm0+Mukigs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UezLM5ChX4MM32Is7Hj0PFsxCp2k8pIAQm+f5MCpVcaGb/H8J7s7ohEFIJpWrDMYQ
	 +bsUQpp3WG+tERJW7W/v4hQxKz3T5fDZcyeMSUnLuCnZiviv9NvQMYBdYLviGKf9WJ
	 n1Xaj3WGruisHWtrSSDjVnE/+YtJL5H/GbuogedTyW7AcGKVjroIpmDKOk+eXLfwzD
	 73Txxjpt5cr5aGFr4YoRsB/5/F7mIGwqsnIZL0Mz7ghAN7cO2mGTIz8epvt4//xvCY
	 ZFJeHlzNfMonBrGQo/YrHn1CpICRUWaXuZrRHNdp0xhg/phmPsUGcUIqEKnJOjq9hR
	 zCSJA8sHdZRSg==
Date: Fri, 7 Aug 2026 10:04:26 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, vova tokarev <vladimirelitokarev@gmail.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Oleg Nesterov <oleg@redhat.com>, Peter Xu <peterx@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] userfaultfd: prevent registration of special VMAs
Message-ID: <anWDehFtjeTTV_AM@kernel.org>
References: <2026072906-estranged-sinless-b8ff@gregkh>
 <20260807033459.1725973-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807033459.1725973-1-sashal@kernel.org>

On Thu, Aug 06, 2026 at 11:34:59PM -0400, Sasha Levin wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> [ Upstream commit 3c58f641e813c3c71039f8fd4d4e2a3aab713288 ]
> 
> Vova Tokarev says:
> 
>   userfaultfd allows registration on shadow stack VMAs.  With userfaultfd
>   access, you can register on the shadow stack, discard a page ... and
>   inject a page with chosen return addresses via UFFDIO_COPY.
> 
> Update vma_can_userfault() to reject VM_SHADOW_STACK.
> 
> While on it, also reject VM_SPECIAL so that if a driver would implement
> vm_uffd_ops, it wouldn't be possible to register special VMAs with
> userfaultfd.
> 
> Since VM_SPECIAL includes VM_DONTEXPAND which is set but hugetlb, exclude
> hugetlb VMAs from the check for VM_SPECIAL.
> 
> Link: https://lore.kernel.org/20260618095017.2553004-1-rppt@kernel.org
> Fixes: 54007f818206 ("mm: Introduce VM_SHADOW_STACK for shadow stack memory")
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reported-by: vova tokarev <vladimirelitokarev@gmail.com>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
> Cc: Al Viro <viro@zeniv.linux.org.uk>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Linus Torvalds <torvalds@linuxfoundation.org>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/linux/userfaultfd_k.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
> index c0e716aec26aa..796a380664bd8 100644
> --- a/include/linux/userfaultfd_k.h
> +++ b/include/linux/userfaultfd_k.h
> @@ -214,7 +214,10 @@ static inline bool vma_can_userfault(struct vm_area_struct *vma,
>  {
>  	vm_flags &= __VM_UFFD_FLAGS;
>  
> -	if (vma->vm_flags & VM_DROPPABLE)
> +	if (vma->vm_flags & (VM_DROPPABLE | VM_SHADOW_STACK))
> +		return false;
> +
> +	if (!is_vm_hugetlb_page(vma) && (vma->vm_flags & VM_SPECIAL))

Yeah, that's the right place :)

Thanks!

>  		return false;
>  
>  	if ((vm_flags & VM_UFFD_MINOR) &&
> -- 
> 2.53.0
> 

-- 
Sincerely yours,
Mike.
