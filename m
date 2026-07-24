Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47F537F32B;
	Fri, 24 Jul 2026 05:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872471; cv=none; b=iQLC5hH9iIWvDfC4PE1BZfZohkX9Y2TyT+8yNL/ngQ0zyLmyr2WHW8a3IFNvgAH91+dzGHEsoYe5Dpda61PFSe5gHeinlEuMaORYZ4BLkZI8ipsF05CET8/eds4nmSI0VL8vEvh+0NKydVjzOSyPQCB26TjOwL7Dk2Qi/rd0bhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872471; c=relaxed/simple;
	bh=LPYwC01VzAGAxGC8dGSGMPScwD+/qSXOlE1H5kdh9r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uUv4tVky89I9hAFlV0jPRDGB33Bs6qZ7HItsGXHDz7eTZiIO8JJj2vSYK49hwMrUbB3eVyIs3FyhKpZxIaSe50wpOR1HvalrD4ibc3FR6wbMM1rkcVqD6BraDhl11dLIrH9vHd2t8cWazIBAcEs2bKuliiBvwYBomV9KdybeJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SfEUHqyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SfEUHqyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAADA1F000E9;
	Fri, 24 Jul 2026 05:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784872470;
	bh=VBMQgbMTSrqTLzDjzCwBq+FnKfV23VeZf/0j4U2aHHw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SfEUHqyKwOfrAq7S45VLB9lfVlhrS+4XaeFEc9tURvV35fCdz2UOMcapkGTG1AxFp
	 a5cMGp698MkuWKO72ilf8KRuBFvos9OghRvpaGqu8S5f6L7WCIh57MENsrzlTgVDYN
	 MrDVjtSgLAvdAafJ1Nd3tOM2RDXEqGxIULRw4TN0=
Date: Fri, 24 Jul 2026 07:54:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 1/2] lib/ucs2_string.c: fix out-of-bounds read in
 ucs2_strnlen()
Message-ID: <2026072454-riverside-nuzzle-39e2@gregkh>
References: <20260723-fix-ucs2_strnlen-v2-0-9ea94e32a358@kernel.org>
 <20260723-fix-ucs2_strnlen-v2-1-9ea94e32a358@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723-fix-ucs2_strnlen-v2-1-9ea94e32a358@kernel.org>

On Thu, Jul 23, 2026 at 09:40:31PM +0200, Vincent Mailhol wrote:
> ucs2_strnlen() checks the current character before checking whether the
> caller-provided maximum length has been reached. If the input is not
> NUL-terminated within that bound, the loop can read one ucs2_char_t past
> the limit.
> 
> Test the length before dereferencing to prevent an off-by-one
> out-of-bounds read.

That's fine, but doing that read doesn't actually "hurt" anything,
right?  So this shouldn't be needed in stable kernels.  Or am I missing
something?

thanks,

greg k-h
