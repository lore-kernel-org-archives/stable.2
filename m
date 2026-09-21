Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75114AB1BE;
	Mon, 21 Sep 2026 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003591; cv=none; b=K2VYVdzNqaOFehr4pfKpYlxEuili2zYXz77By5btwhuWsy5KJAkUmA8EcWUo0G+qxhmzNdTXCpcNvuQrTOEl94nMPNACjTKp1fDskd2LpZiZkiNQ8nthEs2hgfsMy2w5g7RzNObRcDbC/TVLHu8ZS+4AfXIPXlBKDYOCfT3nwso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003591; c=relaxed/simple;
	bh=0jze5GfDJDGWzXj2PkuHYblZe4RxL8wIWdbwspX06lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JqA+WXM8lwtT/dd5kb4BsMovsCFbUq+0MPCxuWTWcwb1RTt81k/tg4VoInyPKjlD6TJny1h7GXQ/D/hLl6Oi9prwBLhogFdPcroTQl259jLe0G64fOFUdnCNhNTeswfH4KouzGZYR3bJH9I/Q7BBMoGLhNLyziSjSzIqmZame9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJCEI1oO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJCEI1oO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D85E1F000FF;
	Mon, 21 Sep 2026 15:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003589;
	bh=QMTxb+mrtRH4SZa45PP2QG37d3OHVFOsk6tg8TRWT1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iJCEI1oOSZdZ4wOPsD7JtxZtw8COX3cI+qeiJBArITZKgCViGq0E5FOiAnLvsGBVI
	 ZSRYWgKerrALYWgng07D/4nnKr5lUd68rXvg5er+Q11vmS7L8pAmODUngLmS2oWM9o
	 ly6hbus0vnsWmeif2oKqQvbfy9lz2kuafLFK7k8lXwo+5Ff4zl3+RP8J08DP1P08lD
	 fKgI8Rw9diXgbHWfTPald21ls9kewQ07UZuG9t7slqWiTTxr8zFyJ38CcXce/vW1eK
	 xP8dDhXYRlVxh7H9tM12rBkXUk6fKTei6WT16owIuOJRgbPI7w59BBPle8YP5gwzaS
	 A38N6PnCXAsUQ==
Date: Mon, 21 Sep 2026 17:13:06 +0200
From: krzk@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: linusw@kernel.org, stable@vger.kernel.org, sboyd@kernel.org, 
	linux-clk@vger.kernel.org, bmasney@redhat.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mturquette@baylibre.com
Subject: Re: [PATCH] clk: versatile: clk-icst: Fix node reference leak in
 of_syscon_icst_setup()
Message-ID: <arFJgR0SKZRd-EmK@quoll>
References: <20260915070103.1733176-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915070103.1733176-1-vulab@iscas.ac.cn>


On Tue, 15 Sep 2026 07:01:03 +0000, Wentao Liang wrote:
> of_get_parent() takes a reference on the syscon parent node. The
> reference is intentionally kept on the success path, but the error paths
> return without dropping it, leaking the node reference. Release the
> reference before returning on the error paths.
> 
> Fixes: d430819d69a5 ("clk: versatile-icst: add device tree support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/clk/versatile/clk-icst.c | 4 ++++
>  1 file changed, 4 insertions(+)
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



