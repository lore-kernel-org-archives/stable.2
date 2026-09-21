Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2564B95B3;
	Mon, 21 Sep 2026 15:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004762; cv=none; b=ui2SmMoZqlJjluP1RBX3qvPLPUdZbPIqEUVcfhKZNxIZr8ra1IwZmApbapt1DmrXcMSH16PySAk23d/0qJHRrLp+leTCqeyKHaSljzzjwGF1+zse0X3HgvH+5HYth79YmruLmYNG4TAUxnKjRbqIag4FBKL4HUNtAh9xWnqvpvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004762; c=relaxed/simple;
	bh=nM2xVqYS3asScHwboponjz4OLcjoZXIoT7O7rKy7AFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TxFE3Ttnv2wRvtyt7oQu0s0D21g2gjsegdFCu8P6CsYmoxGOjLYsEFTiIKAc5Y46YUm851mTWWRPKyCAXZmdN3pDirqOLx9MVCOWWIXCZJ3AYSSj6XM9BQks8uY0goaEo8B54Ap8L7h+aFOTzlRn4QI7eIloqbKxqnvdWk2hMnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCAQtkr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCAQtkr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C181F000FF;
	Mon, 21 Sep 2026 15:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790004760;
	bh=k5PH5p6LxcS9WdqENiIGHGoP6snryK3U4VHTRmcw0co=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KCAQtkr7HflGM8umhvQwQ15mU8tSwrztn5THebScowg5Ep+WF62ylzGnLDpn2nQwf
	 cKo3QHl41x7MYrVNbLX2ymi/Zm8EvSNPZ0M+T2eWeouthwiw/nSZA0VJnmeU91VMCu
	 f9CvhveCOJkviJckohtCgas1Xdu1+t9u4bNpRXQl1XFSG4zCpG41T0cxAVNM9CVIEb
	 c8S5yj6OtU6/bn/bIHzN/Wzallt1QylHR/Gz/Ob4SHZMutnEOIcyfbGO1Ic667mHTI
	 aB5OUDcGdYIrSSttjCNB8qAg3jer2g7vDrhm93FAK0AnGdAHHgnqZodJteRlEdbteK
	 1gxDSP4V97dsQ==
Date: Mon, 21 Sep 2026 17:32:37 +0200
From: krzk@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	daniel.lezcano@kernel.org, Li.Xiubo@freescale.com, tglx@kernel.org, lkml@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/timer-fsl-ftm: Fix clk reference
 leak in error paths
Message-ID: <arFOE1ve58cXFghE@quoll>
References: <20260915050258.1727196-1-vulab@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260915050258.1727196-1-vulab@iscas.ac.cn>


On Tue, 15 Sep 2026 05:02:58 +0000, Wentao Liang wrote:
> __ftm_clk_init() obtains clock references with of_clk_get_by_name() but
> never releases them on the error paths. If clk_prepare_enable() fails on
> the counter clock, the reference is leaked. The second of_clk_get_by_name()
> also overwrites the first clk pointer, so a failure to get or prepare the
> ftm clock loses the counter clock reference as well; on the get failure
> path the counter clock is left enabled and unreferenced.
> 
> Release the references on the error paths: clk_put() when prepare+enable
> fails, and clk_disable_unprepare() followed by clk_put() when aborting
> after the counter clock has been enabled. The clocks intentionally stay
> enabled on the success path, so those are left untouched.
> 
> Fixes: 2529c3a33079 ("clocksource: Add Freescale FlexTimer Module (FTM) timer support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/clocksource/timer-fsl-ftm.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
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



