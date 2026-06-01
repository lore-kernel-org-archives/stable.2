Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B993BB665;
	Mon,  1 Jun 2026 14:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780324137; cv=none; b=Ov5CQhHMeQU8gorssuyrh0dO51ccep31Wg2U33btUPkm/1KnVytlOhwnXyiTT0RKGtlVt+25wVv2EaWRvQeoOqcf2R6lf6puPSwtvypJ7V/Bjg3v9h+K+fvW54RKw7egPxMf89D069QlsKzNafXmrKsVBilDkxtUpT61xUMlybY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780324137; c=relaxed/simple;
	bh=8/ca+0M4SBA42pS5FYJaE05C0A9HuumcGZpX/LoJbSY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3W1u9XaGvnL2g8wg99JuBDpaM8ka+cxVXd21cdfYYT49ARxYGhLOStNIey9V4o54JVU6QiNYDVd63gjZq8zf0B/OSg5u3li+iSoxWeu0ACTDqIJAelOKhxjv1lClEccuS4/bt4Ofi+6N/Ca9mDkk3qRvWnAj/qiSHA4peA4CIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFBQ3wnU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFBQ3wnU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6321F00893;
	Mon,  1 Jun 2026 14:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780324136;
	bh=QcytDXYzPwKDUDdHT+N4i8ojI54d4gwtkmZUP60KdkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MFBQ3wnUVZEzgVXBP7n6BLHSXSE0qD9Bm7vwoXNVZtdHWBlM9NTq0i+K9RQXuhWw9
	 mBZioXbaFvlvWuL3ExgLdSna7SwlLK2S8Qy1eI6fmf7bFYCb2kPhK2H7MGPfkRbcWk
	 R1q8n30NM6cuQZA09wD2pSFpVduh/yZgcmHrKV7JBRTpa+YrDoE/bKJ2AOHrTpFQYT
	 dFsQTkYS0tr4YjM0Ge0bCWiaErT/4amvCgJjqwaNBn6asSlXPArhxDM1uDzTAst/Pz
	 u7c9uwrYL4zA9u3HHEHZGX29EjtDsaOPQmZxaR8BcGfuodvdzymTg8ObRVJENl1as/
	 6sORXGX2T0SjA==
Date: Mon, 1 Jun 2026 17:28:45 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Lorenzo Stoakes <ljs@kernel.org>, akpm@linux-foundation.org,
	peterx@redhat.com, david@kernel.org, surenb@google.com,
	vbabka@kernel.org, Liam.Howlett@oracle.com, ziy@nvidia.com,
	corbet@lwn.net, skhan@linuxfoundation.org, seanjc@google.com,
	pbonzini@redhat.com, jthoughton@google.com, aarcange@redhat.com,
	sj@kernel.org, usama.arif@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
	kernel-team@meta.com, stable@vger.kernel.org
Subject: Re: [PATCH v5 04/18] mm: skip out-of-range bits in mk_vma_flags()
Message-ID: <ah2XHd4SQOj6iG8Y@kernel.org>
References: <20260526130509.2748441-1-kirill@shutemov.name>
 <20260526130509.2748441-5-kirill@shutemov.name>
 <ahmQvfNk7S4F0LBj@lucifer>
 <ahsVyQZ5UXhJLct2@kernel.org>
 <ah2SL2c0nMj0KBtP@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ah2SL2c0nMj0KBtP@thinkstation>

On Mon, Jun 01, 2026 at 03:08:19PM +0100, Kiryl Shutsemau wrote:
> On Sat, May 30, 2026 at 07:52:25PM +0300, Mike Rapoport wrote:
> > I have a PoC of yet another alternative:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/log/?h=uffd/vm-flags
> > 
> > The idea there is to keep a single VMA flag, VMA_UFFD_BIT/VM_UFFD and move
> > all the rest into what's now struct vm_userfaultfd_ctx.
> 
> Nice!
> 
> I assume it can go on top what I did, right?

Yes, it's already on top of a previous version of RWP.
 
> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
