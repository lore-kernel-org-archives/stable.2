Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36287285417;
	Mon,  1 Jun 2026 09:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780306659; cv=none; b=E2wUD7FsNR39966H1/7DgMifBl+I8EsnVEWhcInBjqlvBQDU3de8hLzsdpZVHnfNNcRgDAzrXFadBX4JJf8yUBzjMWQ1aXRH8Bkt4o0Eq/DhqpWhs00qQ9G6upoqu7CGlbeFV+kMl4GXkWDgvQroZYDETt0VvdYSAfDIbN9LV1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780306659; c=relaxed/simple;
	bh=9eE/88fQSqXK3PWBhQXJt59pjMmydVz4iFC/+YtdLa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B23/PMkmUcpc7yUOdCxQ5E7PJ74Lz7u55rBP41mrYdQqLIP18xfvQgu0seABKRjEvU75ZTrZDjT7PFRMx6YK699jKckpP35AuzvrvRw06d7oyW35mR4M7ZybehvyLdXvL7s/fpbSteOy4q3EBgYE1YUf2YxAJqj/4+hVMA1wI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1PJZNWT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1PJZNWT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2F01F00893;
	Mon,  1 Jun 2026 09:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780306658;
	bh=AzbXwY67i7orrJSYLIcDP2MIfpMzq9fPfuSJU14oS7I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c1PJZNWT6Jhrtsti0/iLRUjmX2p41TJJfRVGF/3HNXBQB7PyKa2x9bRmyaeFYhkph
	 S/XYHC6xhKx56Ya51Xak5ZkdEYl7w6jJ5CHtlZipgiVBNEdAMNHH/iRIH0rE/rdUWu
	 0NcYKv9W6ljVMkX338Av9+n5cEDMlkvl9EyHcrfG4IQCWXZKImq9ht9DNl8Bv5zvtM
	 ATehWylJaNN+9d/XXQwwW29cYaUrS+pOaBG4dYswLQ5k9wG0aOJ57MhEFaYf6nU2l8
	 SGi6xk/XJwSfllo85W6VmcGnxePA0rHGqKLm46uy+j9fAJrU+3ZTv7yeI+eHKuE7At
	 N4eY0MFKY1p+w==
Date: Mon, 1 Jun 2026 10:37:30 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, rppt@kernel.org, peterx@redhat.com, 
	david@kernel.org, surenb@google.com, vbabka@kernel.org, Liam.Howlett@oracle.com, 
	ziy@nvidia.com, corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com, 
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com, sj@kernel.org, 
	usama.arif@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 04/18] mm: skip out-of-range bits in mk_vma_flags()
Message-ID: <ah1Sxn5VHLF6jlcU@lucifer>
References: <20260526130509.2748441-1-kirill@shutemov.name>
 <20260526130509.2748441-5-kirill@shutemov.name>
 <ahmQvfNk7S4F0LBj@lucifer>
 <ahmoH9v6_DA2i_zn@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahmoH9v6_DA2i_zn@thinkstation>

On Fri, May 29, 2026 at 05:09:56PM +0100, Kiryl Shutsemau wrote:
> On Fri, May 29, 2026 at 03:00:14PM +0100, Lorenzo Stoakes wrote:
> > > Add VMA_NO_BIT and have DECLARE_VMA_BIT() resolve any bitnum out
> > > of range to it. vma_flags_set_flag() drops negative bit values.
> > > The ternary collapses at compile time, the runtime check folds
> > > away when the bit is in range, and the common path is unchanged.
> >
> > Hmm are you sure it does?
>
> You were right - I measured it (gcc 15.2, clang 21.1.8, -O2). The
> DECLARE_VMA_BIT() ternary is fine, but the "if (bit < 0)" guard does not
> reliably fold: with it, clang stops folding __VMA_UFFD_FLAGS to a constant
> and gcc keeps a rolled loop; without it, both fold.
>
> So I've dropped VMA_NO_BIT and gone with your config-gated-mask approach
> instead: mk_vma_flags_from_masks() plus VMA_UFFD_{MISSING,WP,MINOR,RWP}
> masks that collapse to EMPTY_VMA_FLAGS when unavailable, so no out-of-range
> bit ever reaches mk_vma_flags(). __VMA_UFFD_FLAGS now folds to a single
> constant on both compilers, 32- and 64-bit. Added your Suggested-by.
>
> I also took your "use the new API" hint and added a prep patch converting
> the existing userfaultfd_*() helpers to vma_test_any_mask() (Suggested-by
> you as well). One deviation: vma_test(vma, VMA_UFFD_RWP_BIT) is itself an
> out-of-bounds *read* on 32-bit (test_bit(43, &one_long)), so the helpers
> use vma_test_any_mask() with the masks rather than the bit.
>
> > Either way, I think we should break out any fix like this from the series.
>
> Agreed - the OOB fix and the other pre-existing fixes will go as a separate
> series with the RWP work rebased on top.

Ack on all and thanks! :)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

Cheers, Lorenzo
