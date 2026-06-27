Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48FD4227EA4;
	Sat, 27 Jun 2026 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782581200; cv=none; b=W04g9EQzlcLajJJBZw18f0SRxp/pzOv+c18nBWZWJzBqpW6SJeyzYMrtYZbkdbIbKOF/mNlddyQYFEU1vzBe70ecSZoOk7zZ00xbgn+1+CKF6dk5H1tfiAxT15xn5DMFi/oLfmH1YqINVfAsKzarKwsPWJ7TOYiBHzReTzGGUKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782581200; c=relaxed/simple;
	bh=qX6NZ+okwh2mZnH7WQDx5tvtSGr+dLkueoTmpTwKr2k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hdmpsCNw3jXRsrn361IyrVSpWXeCmCwd6cMsWCv/LIipidI6o4n/4ZwZLw9lX+UWWrUpPe06VUyvJyDsmTes4Fu7x2rObWU7/MJskg77ZcU/XlAEhuq0x7T+BnD7XAGPa1HZDzvCVhW71ZeJg/CgTZ10qpq0OHWilC3B0j/8u5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qmc6DOAw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qmc6DOAw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E7D1F000E9;
	Sat, 27 Jun 2026 17:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782581198;
	bh=FQEZdzMR4S9EJURSnXOi0A7QXVE9gI14e3OGLriAsys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Qmc6DOAwKXcAP+pOtkC6rejUGyAHxjO/U5tybrHEyTyFKTp/3VjGhisml9GONUBhi
	 emVNvUHwnVMSMfFdCRgYE8hWnnt8EYcJvfjfll5iFqw97elZpbMJIvcFvmoUF+T6Nu
	 jNBi3Xpqv6fgwcTryQZ47RXt6hbbVWEAYReckGFTfyhOzFmy8/NrWM/yoqsJw1rqYU
	 YeadqQfyZnrcsrlRp6Y9Yejto0hw9Y4nGfoimiAVXW+PQj+LAoA4yYOmy5lwwynmJD
	 HSKqqg0MWiEYBeOAvxHpAomZGuvRX7AB5XqMMkwH7pPdij3KwDvM7M/fGH5jiVCdqN
	 acnSntl1VPKug==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yang Yingliang <yangyingliang@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] mm/damon/core: validate ranges in damon_set_regions()
Date: Sat, 27 Jun 2026 10:26:31 -0700
Message-ID: <20260627172631.3923-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260627170057.1867-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, 27 Jun 2026 10:00:56 -0700 SeongJae Park <sj@kernel.org> wrote:

> DAMON core logic assumes zero length regions don't exist.  However, a
> few DAMON API callers including DAMON_SYSFS, DAMON_RECLAIM and
> DAMON_LRU_SORT allow users to set empty monitoring target regions.  This
> could result in WARN_ONCE() on CONFIG_DAMON_DEBUG_SANITY enabled kernel,
> and divide-by-zero from damon_merge_two_regions().
> 
> For example, the WANR_ONCE() can be triggered like below.
> 
>     # grep DAMON_DEBUG_SANITY /boot/config-$(uname -r)
>     # CONFIG_DAMON_DEBUG_SANITY=y
>     # damo start
>     # cd /sys/kernel/mm/damon/admin/kdamonds/0
>     # echo 0 > contexts/0/targets/0/regions/0/start
>     # echo 0 > contexts/0/targets/0/regions/0/end
>     # echo commit > state
>     # dmesg
>     [....]
>     [   73.705780] ------------[ cut here ]------------
>     [   73.707552] start 0 >= end 0
>     [   73.708452] WARNING: mm/damon/core.c:359 at damon_new_region+0x6e/0x80, CPU#1: kdamond.0/758
>     [...]
> 
> Disallow empty region user inputs by updating the validation logic.

The above description is wrong, since this is not updating an existing
validation but adding a new validation.

> 
> Fixes: 43b0536cb471 ("mm/damon: introduce DAMON-based Reclamation (DAMON_RECLAIM)")
> Cc: <stable@vger.kernel.org> # 5.16.x
> Signed-off-by: SeongJae Park <sj@kernel.org>
> ---
>  mm/damon/core.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index 7e4b9affc5b06..b3100d7fa5596 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -358,6 +358,11 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
>  	unsigned int i;
>  	int err;
>  
> +	for (i = 0; i < nr_ranges; i++) {
> +		if (ranges[i].start >= ranges[i].end)
> +			return -EINVAL;
> +	}
> +

Sashiko found [1] this is not complete, since eventually this function uses
aligned addresses.  I will address that in the next revision by doing the
validation with the aligned addresses.

[1] https://lore.kernel.org/20260627172406.3794-1-sj@kernel.org


Thanks,
SJ

[...]
