Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A8127AC45;
	Sun, 16 Aug 2026 09:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786874348; cv=none; b=RQmBRlMBXSg+nNM+vvaZKqd9N6bHX2pakusife3cjWIOxec5OYFL614N7Xly7y0PqSIYFAG3Xyzw8XZiE6HPTiOW69PiZheVoQbBNobZyZolSWFnq08Y/MbSiIVvYnlqlDckH6TE5DiTfgNehne9yqbhuxbaT5IjW+ZACn8DWFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786874348; c=relaxed/simple;
	bh=I4oA4rC4p6+EW7yylqHhE+dpZlePPOKqfevq51PblRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFQCm/qvN6ih3BbgZNiDYY2fXFz+sgD/isbi/ZbNVu/X7gUxHv6jJr2eWbFUqukCqTgD8nRHCGY+6ancjHoadMSpNFbEnKn5mX6F9fjTHbtQ/oR49KRNa2vwIRVLaEiljGQApYPzLNIwFVfhCo6JT6i5qU2MJXKgw1q2i5JGt2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8Kj/UNg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8Kj/UNg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6D31F000E9;
	Sun, 16 Aug 2026 09:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786874347;
	bh=NTYJAsVDkO7YIxBVl0sfyICvDw21eBl55uq6tMu+icE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Y8Kj/UNgRL/skfMARhgY4keWAMhwtZeZa9GTiEpwT7TsDVKb52rE3IlBql5jX7br+
	 crgRNKTt/d/EEr6h+SMDtPodg09wi6BcmELkdZ8pF0AVnc5JDXHqIdk2PTBPt1nGfH
	 PID7IZlTaKnSQkSuz4Anro+841WvPyI7+Kd5T/+NLUQgQwG9tpVhgbgfyZatvtJhw8
	 qitPPHYaSRfs2arUlT3nj1wFT3uH0+n9pERnI8GGdpfCsFuwKFezDJxBUIRU8I7M+B
	 /tLBDWhjnUjZ11fe6oZ9gHXuRFWY5ABu1b2kq+T6MangVqAIMg/qw4Rz7845h+RKvU
	 QwxpsqNjYyKgg==
Date: Sun, 16 Aug 2026 12:59:00 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] arch_numa: Avoid false positive fortify warning in
 setup_node_to_cpumask_map()
Message-ID: <aoGJ5KL9cMl1E7iV@kernel.org>
References: <20260813-arch_numa-avoid-fortify-warning-v2-1-093ad97a78df@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813-arch_numa-avoid-fortify-warning-v2-1-093ad97a78df@kernel.org>

On Thu, Aug 13, 2026 at 08:12:55PM -0700, Nathan Chancellor wrote:
> When building ARCH=riscv using clang with CONFIG_FORTIFY_SOURCE and
> CONFIG_UBSAN_BOUNDS enabled, CONFIG_NR_CPUS > 64, and the default value
> of 2 for CONFIG_NODES_SHIFT, there is a compiletime warning from the
> fortify routines.
> 
> In this configuration, MAX_NUMNODES is 4. clang unrolls the for loop in
> setup_node_to_cpumask_map() past this, which triggers the fortify check
> when accessing node_to_cpumask_map on the theoretical fifth loop
> iteration because it would be an out of bounds write.
> 
> Make it clear to clang that nr_node_ids is bounded by MAX_NUMNODES due
> to the logic in setup_nr_node_ids() by early returning in
> setup_node_to_cpumask_map() should that condition be violated.
> 
> Cc: stable@vger.kernel.org # all applicable
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2174
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

> ---
>  mm/arch_numa.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)

-- 
Sincerely yours,
Mike.
