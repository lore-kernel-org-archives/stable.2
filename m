Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2832A4B2055;
	Mon, 21 Sep 2026 15:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003583; cv=none; b=igfY67So8N76v2sXEMvdk1E1psPKNLDzagFSDjVVQAWFahl57s1nuclFaU/cDcz07/XvI1h5RTexZxY9+uHKMSHlm2meZaPcGhSLN1lhZv7kGp0yGNwr+x3VhACftzJPLDpyFgUvCW7Nh4KYTUADu9PGFQLPem7nbUeDJQUUZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003583; c=relaxed/simple;
	bh=JyC5SKc0mVJdeKRxQYzsllkALh44u8NaJMlLOF/8bqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUb1s+V4t+zzKWI+cJrxZKURC6ZMqv29pZ0DBIt+GMY8oCIFn8NYWhcOuHyphV2w6NHZWrshz4DKMntY180Fn2i8h4fSBz2gN+54JdHDIXPSIL6URDkaZj0ZKr4zyOnsWGJGtuf2l9Dngl48LbOWg0CasglS4IJ5SZWfVNNgcj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mObJGkpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mObJGkpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC621F000FF;
	Mon, 21 Sep 2026 15:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003581;
	bh=dtteNIKoELjmMfexOABlmRFX07/QVUtrWRSjMp41NtA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=mObJGkpnxOSj67aBaUoHpyjEbC3nNkC/fmmjvGfrWhyU+Z9ZNcdscVeWHLuIdIcjL
	 AIGd7b7Uo2hiOPy95zTqBCclgW9/ojaacxKhxjl87R3/OecMEH8OhyCBiO6eGOdo5E
	 gFXv6yi0QySimQFtlvGlgyXZdlX3Xz/AubQ+MdIIgB8Efskju3AD2rt9MzqvgtKsI6
	 ZkWWpGvaQ9XhRy1QYNYKeFjtIogFo5VdL/XAZuHiqPyeuxo+mJCDY4hvjic292r6rV
	 gxwCCuI4+8PtEz5qnhQFJAXkTTyCDLhtbN2bjTj87uW/khPwma++HlpRzqrzkCe22C
	 T+XJJn9fZYVIw==
Date: Mon, 21 Sep 2026 17:12:58 +0200
From: krzk@kernel.org
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: stable@vger.kernel.org, Maciej Sosnowski <maciej.sosnowski@intel.com>, 
	Dan Williams <djbw@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dca: fix provider device memory leak on domain
 allocation failure
Message-ID: <arFJeRFJdL-fwRmk@quoll>
References: <20260919175925.3739806-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260919175925.3739806-1-lgs201920130244@gmail.com>


On Sun, 20 Sep 2026 01:59:24 +0800, Guangshuo Li wrote:
> register_dca_provider() calls dca_sysfs_add_provider() before looking up
> or allocating the DCA domain. A successful dca_sysfs_add_provider()
> allocates an IDR entry and creates the dca%d class device.
> 
> If no domain exists and dca_allocate_domain() fails, the function
> returns -ENODEV without calling dca_sysfs_remove_provider(). The class
> device therefore remains registered and the IDR entry remains
> allocated. The caller may subsequently free the dca_provider, leaving
> the IDR entry pointing to freed memory.
> 
> Since the class device is never unregistered, its device reference is
> not dropped and device_create_release() is never reached, leaking the
> struct device allocation.
> 
> Call dca_sysfs_remove_provider() before returning when domain allocation
> fails. This unregisters the class device and removes the corresponding
> IDR entry.
> 
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
> 
> Fixes: 1a5aeeecd550 ("dca: registering requesters in multiple dca domains")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/dca/dca-core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



