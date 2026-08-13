Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EFF184;
	Thu, 13 Aug 2026 01:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786584729; cv=none; b=El9TEnnVXdhptJwIgl6igYuO+2R6dEwn7FSN4XndkF2egE835BL7u7XzuK4rzWy38meQm1s7H229YAR+ZdaEG07DK/YEhKZHqkM33MjjuoaEJFBkidHAPzBXbSvTcvym0YqOl3u/CuoLaTjkgWx7zowXoK+jmC1RrRVoL6wn/uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786584729; c=relaxed/simple;
	bh=oYBx0XtcDKy2hdypS790p+7OmKFFW/vBarNhJ6XrSfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvvxiKUYYD783cdQs41fcZ106vh8f9xSGBlFLb44vLnyq0uQL1Yhmq/H3epSS6V7ezJ5tG5aPT8XdPQIOuuhT36egzZ+a4j4itkPXqboU8WVWPzobGikYnxp1lLL43XjPovk+uAoYJRncujSmmr9KZzstynbeg2hWoPgLGE5RC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kpvRz/Af; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kpvRz/Af"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42881F00A3A;
	Thu, 13 Aug 2026 01:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786584727;
	bh=KXGPeS+K5n9ANRKQROyif7rhZFKqbL7oazhgonaCR4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kpvRz/AfHtGn2iPU3AyVIFfiB/M69pQXYn42vtoqDoxLWckZ2QFDhBuwlgx2VBHI4
	 hEgLjvgcvMfjfLQyMG0PbKB/zXIU67HeYRgBZlN9lNLLTMt0ZmmVb8rGcrXwdI5zZW
	 wKsuwoVP1vCHBIWAfPKApU0PDMjYgajvAMsj7XHkGhVdBcSt8eupjFOoC6L2trLXce
	 Sv9YC71ocxOzRol9mdMknZXV+sN7J5/gyYTUk5YW5sK9OiWdmGHEMrpmt7zXYr3Mb1
	 zNa4lLUvUBidNOsjLLd9RnJmQ0yQjJL3aKuXVdiBLV8zKW/FLSOjvp9J8TTD+8fnyg
	 an9dq1rOzhDWg==
Date: Wed, 12 Aug 2026 18:32:03 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	stable@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] arch_numa: Avoid false positive fortify warning in
 setup_node_to_cpumask_map()
Message-ID: <20260813013203.GA3920328@ax162>
References: <20260811-arch_numa-avoid-fortify-warning-v1-1-59ce3e689f3a@kernel.org>
 <20260811224746.fdb85bcf47533e12d365b182@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811224746.fdb85bcf47533e12d365b182@linux-foundation.org>

On Tue, Aug 11, 2026 at 10:47:46PM -0700, Andrew Morton wrote:
> (cc Kees)

Thanks, should have done that originally, I cc'd him on the original
issue.

> Sashiko wants a \n there.

Thanks, will send v2 with this tomorrow.

> Lord only knows why nr_node_ids is unsigned but MAX_NUMNODES is signed.

I can change the specifier for MAX_NUMNODES to unsigned as well (even if
it is technically signed due to the signed '1' literal in its
definition) since it should never be negative, up to you.

-- 
Cheers,
Nathan
