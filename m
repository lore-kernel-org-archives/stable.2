Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92358362157;
	Sat, 30 May 2026 16:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780159957; cv=none; b=BDZAKYzDdRd89Hp+JBvPlhXi99j6K6XLPSFPovcg3yk74c06ILOiWngWI8c6HuX1RMUMfx1L7+msWeOZCU2LBxF5zUX0MhEpt5j0nBo0zq7tWfpBV5mHExwax3c4HLVsySl06/DqZ3+Z3X3PFanIYiEW5TdDH0+4wL8Vm41iwHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780159957; c=relaxed/simple;
	bh=jvBKcpRPqMkElAvtnlHvFX3fE1zwl2ElCd+UJN1nO+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tp86fPb7ZeF9qW2sNrssyEBfDZbKMns48L3OzumMbfP/jFm5O24x9QKBAQWbeGksdeg2ogxeKHTAYpbCC9A0PkaAFG+fTIlG8LldDYX6EH1+/LDZMT7ZBjArs60srSvTqEiVBvrjRfT5GQD30W6IcTVWyLwrGqJ3HKVg1oYWuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErTE6kd7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErTE6kd7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE06F1F00893;
	Sat, 30 May 2026 16:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780159956;
	bh=8UNb1/3qGmB4zSX8MLGFUwdcMgPk4T11baGG/hOQ7Cg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ErTE6kd7JtWaVBDAoXu2s7i33/fLSNJOgv99y2jirEIh5FRREhKyHEBpPSt60wuGB
	 AF/SOzPfIvWwO0hK4X+wKLOyMMpot4HDZOhFrm7Sj/C3AKPURyGBLHLnNVflxDtTgB
	 dBfmMUVNRAHFI1XwUKnpoxRso8AxGDhPJwVh+jfDUkiaMr529dMx/JZ4Ossvp9Y3KS
	 hBplQJ73LWwxWvMO/09GaoCXEwwOdgi15VCVTwkzR5ITTHqJ8rlCkZCdIbRmYtOwM8
	 t4MJQK6U335Nd8iHwPDAoAaDYkjqoEojWMw8xzoyXjqqKTDiA1RqrlWDGy931gkTgu
	 EvuS8mB+7V7Ow==
Date: Sat, 30 May 2026 19:52:25 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, akpm@linux-foundation.org,
	peterx@redhat.com, david@kernel.org, surenb@google.com,
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com,
	corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com,
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com,
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com, "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v5 04/18] mm: skip out-of-range bits in mk_vma_flags()
Message-ID: <ahsVyQZ5UXhJLct2@kernel.org>
References: <20260526130509.2748441-1-kirill@shutemov.name>
 <20260526130509.2748441-5-kirill@shutemov.name>
 <ahmQvfNk7S4F0LBj@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahmQvfNk7S4F0LBj@lucifer>

On Fri, May 29, 2026 at 03:00:14PM +0100, Lorenzo Stoakes wrote:
> On Tue, May 26, 2026 at 02:04:52PM +0100, Kiryl Shutsemau wrote:
> > From: "Kiryl Shutsemau (Meta)" <kas@kernel.org>
> >
> > vma_flags_t is one unsigned long on 32-bit -- NUM_VMA_FLAG_BITS ==
> > BITS_PER_LONG by design, so VM_xxx-declared bits sit in the first
> > word and hit the single-long fast path. But the bit enum declares
> > some bits unconditionally above BITS_PER_LONG (VMA_UFFD_MINOR_BIT
> > == 41 today, with VM_UFFD_MINOR == VM_NONE on 32-bit so no VMA
> > actually carries the bit).
> 
> Yeah ugh.
> 
> > Passing such a bit to mk_vma_flags() goes through __set_bit(41,
> > &one_long) and writes one word past the end. The compiler folds
> > the OOB store with wraparound (1UL << (41 % 32) == bit 9) into
> > the first word. Bit 9 is already in __VMA_UFFD_FLAGS so the mask
> > happens to come out right today, but any high-numbered bit whose
> 
> That is... helpful :) but not great that this is the situation, an
> oversight, clearly! How I hate 32-bit kernels :)
> 
> > mod-BITS_PER_LONG position is otherwise unused would silently OR
> > an extra bit into the mask.
> >
> > Add VMA_NO_BIT and have DECLARE_VMA_BIT() resolve any bitnum out
> > of range to it. vma_flags_set_flag() drops negative bit values.
> > The ternary collapses at compile time, the runtime check folds
> > away when the bit is in range, and the common path is unchanged.
> 
> Hmm are you sure it does?
> 
> A key design goal was that mk_vma_flags() generates compile-time constants
> the same as if the bitmap were constructed independently.
> 
> This surely must generate code? Or at least runs a significant risk of it?

...

> A simple solution that doesn't require change to the core is to just uglify
> userfaultfd_k.h a bit with:
> 
> #ifdef HAVE_ARCH_USERFAULTFD_MINOR
> #define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT, \
> 				      VMA_UFFD_MINOR_BIT)
> #else
> #define __VMA_UFFD_FLAGS mk_vma_flags(VMA_UFFD_MISSING_BIT, VMA_UFFD_WP_BIT)
> #endif
> 
> But of course that becomes much more horrible with your changes...
> 
> Another alternative, which I used for VMA_DROPPABLE is to add something
> like this in mm.h:
> 
> #ifdef CONFIG_HAVE_ARCH_USERFAULTFD_MINOR
> #define VM_UFFD_MINOR	INIT_VM_FLAG(UFFD_MINOR)
> +define VMA_UFFD_MINOR	mk_vma_flags(VMA_UFFD_MINOR_BIT)
> #else
> #define VM_UFFD_MINOR	VM_NONE
> +define VMA_UFFD_MINOR	EMPTY_VMA_FLAGS
> #endif

I have a PoC of yet another alternative:

https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=uffd/vm-flags

The idea there is to keep a single VMA flag, VMA_UFFD_BIT/VM_UFFD and move
all the rest into what's now struct vm_userfaultfd_ctx.

-- 
Sincerely yours,
Mike.
