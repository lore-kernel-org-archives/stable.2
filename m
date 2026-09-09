Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A293587A2
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 05:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788931446; cv=none; b=B2XSwQKZBvfcFYsNmws/H5njwaHxzdUQakRTxH3DjZpunsCDR7Th0LchHxxaoNtg1FLYv6cSjd3lX1c6Iu0zARjysPo6UbX60b3iAgqkOxFXmsgz2olcmACf3wRupkvyKbIp7cAea4Hh4JKDtSGPSNc3vS7iQmvAmA7FL1F/LSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788931446; c=relaxed/simple;
	bh=MMOnNT/u+YL4KVfof7KYiM+VDhqc4z3D35vzW5/nj6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y9Wgv4Pxowtf+V1lInJRBAhDjZ/TztqAL8HeR3LaOrGGUhR8SnmCkhwLFc57UnRSvDV0hjIukMizqs8BWhNYnrjm4XJf3CNzBRmKdluotAeFJmbrlx4fOZvg5KjO2kymqcI4JsgCc5fL/bcide9NA9XVY06o+QXCtL8Lo76Up8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KxGlnv3G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KxGlnv3G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A9121F00A3A;
	Wed,  9 Sep 2026 05:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788931444;
	bh=lQKipnC/jEQ6qAmaExAhEILOycynmmMk5r5EPALpqvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxGlnv3GQG1N+o2INnpTquPaPf0iDGikst1klP6PMbbdp9DK0Ll7lMPT3/DpZxHYM
	 3hPdGI0iBMVAFu3yGLU0qRBmMR4bVboJP7q6dIaPJvLQHxPEJQsBuxuESYk6A49Tph
	 luXmKfJJjRUtDB0TJDoXVe6Oypw1avs97F5uzbjg81/unrWrKu9t9H6O2scmW61mKp
	 Xh1d5zLxMedGCd7OJE9KEdMMo4dGH3fRT8aXWykvnwkOP+6JQMq134sU1iF3bZYQkh
	 6YVi56UDuzWaS2CAXUm3OBl5qFT4MtyrsFrwrG4j6FpdLfGUxSlOUT2E0oUv7+Po3f
	 PmhmNaF71hmEg==
From: SJ Park <sj@kernel.org>
To: gregkh@linuxfoundation.org
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/damon/ops-common: use nr_accesses moving sum for quota" failed to apply to 6.6-stable tree
Date: Tue,  8 Sep 2026 22:23:56 -0700
Message-ID: <20260909052357.235575-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090847-trapdoor-essence-0783@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 08 Sep 2026 14:52:47 +0200 <gregkh@linuxfoundation.org> wrote:

> 
> The patch below does not apply to the 6.6-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.
[...]
> ------------------ original commit in Linus's tree ------------------
> 
> From 6c25083f7ae7e2660d766169e5b4d3e96010503f Mon Sep 17 00:00:00 2001
> From: SJ Park <sj@kernel.org>
> Date: Sun, 19 Jul 2026 09:11:33 -0700
> Subject: [PATCH] mm/damon/ops-common: use nr_accesses moving sum for quota
>  score
> 
> Since commit 42f994b71404 ("mm/damon/core: implement scheme-specific apply
> interval"), DAMOS scheme can be applied at any time.  At that time,
> nr_accesses may not be fully aggregated.  But the quota prioritization
> score is calculated using the not fully aggregated count.  As a result,
> the performance of DAMOS could be degraded.  Fix by using
> damon_nr_accesses_mvsum() instead.
> 
> The user impact of the issue is suboptimum DAMOS performance under certain
> setups.  Nonetheless, the bug was there from the beginning of the setup
> availability.  In other words, the suboptimum performance is the baseline
> of the setup and hence it didn't cause regression.  Also the extent of the
> suboptimality was not big enough to be found from users and testers.
> Still, this is a clear bug that is better to be fixed, and can be easily
> fixed.
> 
> Link: https://lore.kernel.org/20260719161136.90191-1-sj@kernel.org
> Fixes: 42f994b71404 ("mm/damon/core: implement scheme-specific apply interval")

Seems the broken commit is backported to 6.6.y even though it is not a fix,
maybe to resolve a conflict of another fix.  That should be why this patch is
tried to be applied on 6.6.y.

Though the broken commit indeed introduced the feature to DAMON API, the commit
didn't introduce any DAMON API caller that uses the feature.  Apparently commit
a2a9f68e358f ("mm/damon/sysfs-schemes: support DAMOS apply interval") has
further integrated the feature with DAMON sysfs interface, and exposed it to
users.  So technically speaking, it is the real broken commit.

And the real broken commit is not in 6.6.y.  So, this patch is not really
needed for 6.6.y.


Thanks,
SJ

[...]
