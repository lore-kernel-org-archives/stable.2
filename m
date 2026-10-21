Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543962;
	b=C6BuZa+fE8YZkjZN6VPA7/yrpRAEdS4fmpQjVXumTvp2rlMkrxAda6uX6UraLgWwSTlt
	 TJipCdXDPv0wulls65XqN3SfB6wgV2QNAqaP2TG9wBfkfZuSGWNNdLrJsmIz3GZMTpNKo
	 IS619RY7vEFGrklJJ5/8Nm9+vro45FsTT5TvrO6YKnGAwp6+L8Fb3f/iX5q+IsGkUY42Y
	 viwGm8AvDWnntUPVySS+dZ2jBI7zwNjPa5Rw62UzDaCveUlXWcLnR9+C7KZXgy7Vof6O7
	 pBo5/Eql2J/h8006oT8GVGW3wl4n9bQpzxboFdtLzeOnPpKeNHnRjmHgxRl/qCpegZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543962;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qb7Js6jWEBpRBnpheoU8QyOWSaJyuXRnZgnX25ZrCeE=;
	b=knWxu/EjYkvW7Tna5ZEoLYRLERK+JCaeLG0BsyStAA0M9tamG58f/KpofCHxrktvOIVg
	 jKXuB/r3ZYxyoPxgMP6SvdJlnX7/62TiKHBpFg+5ohEOz9gC0BvRZDUrl91Fh53Azd7YS
	 dsmxZIu9hZAkLunuegEKrBDImkgqGm0MmSfz0LPa3+sP5z2EykNsDpfgkcD1TvLWPPIEG
	 fHQQbZLmCCQat/O1yWp2BzaxwV+zkR2/ylNGvdSf8PUsqUdTwZb48xNUSZBuDmlPtlzp7
	 hbCr5dMAag9witoFJ0aEGcsNr/6RBWsEZAD+Q48H+xfCn3wLhrWB42ybn4uuhQ2bRZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8rASglm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4371606A319;
	Wed, 21 Oct 2026 00:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C8rASglm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2DE1F000C9;
	Wed, 21 Oct 2026 00:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543961;
	bh=qb7Js6jWEBpRBnpheoU8QyOWSaJyuXRnZgnX25ZrCeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C8rASglmwgB/cfgmQpR3BhfADDtX2fNF7GWL6In14mCOE+7W/rqFn5M3uhVDLpxJr
	 6S28YT++pE4ykJTY0DVVUSv1WsetHBeFietptrPkMiJZtpk8SzuRmmvEdQEt5yYoKN
	 uBYX9dN2xveE/0IHIFcPHw9up4OccSABaDGN64neWWm2VvzKYZkiTVgPmgghjnzENW
	 ayrOjrG8ZuyxMLPv/KMvx+OCmp9stf8zU2s5OUr3MjUoVLguMvTUW52jxYcckGHHgN
	 FrJOrAztHPAb9fz2Gryaa2n9u9k2udQ+58y8Yflb2Kvnp4Z7Eiq3l9jM1125SgNBP7
	 BO2ISMCwFpdAw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH] mm/damon/sysfs-schemes: hold damon_sysfs_lock in target_value_store()
Date: Tue, 20 Oct 2026 17:52:33 -0700
Message-ID: <20261021005234.94107-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261020144726.88978-1-sj@kernel.org>
References: 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 20 Oct 2026 07:47:25 -0700 SJ Park <sj@kernel.org> wrote:

> Remove a race condition under certain use cases that can trigger
> divide-by-zero.
> 
> damon_sysfs_add_quota_score() setup damos quota goal as user configured
> and pass to the core layer.  Because it could have a race with
> damos_sysfs_quota_goals_rm_dirs(), which destructs the files that carry
> user configuration, both are called under damon_sysfs_lock protection.
> 
> The damos quota goal setup disallows zero target_value parameter because
> it can be used as a denominator later in the core layer function,
> damos_quota_score().  Otherwise, divide-by-zero can happen.

This is no more true due to another patch [1].  The patch added the zero
target_value case in the core layer central validation pass.  But it forgot
removing the redundant check in sysfs.

> 
> For the zero value check and final assignment,
> damon_sysfs_add_quota_score() reads damos_sysfs_quota_goal->target_value
> twice.  And user can update damos_sysfs_quota_goal->target_value via
> target_value_store(), which doesn't hold damon_sysfs_lock.  As a result,
> a time-of-check-to time-of-use (toctou) race can happen.  If the user
> sets the value to zero between the zero value check and final
> target_value assignment, zero target_value is passed to the core layer
> and results in divide-by-zero.

So toctou race exists, but it cannot result in divide-by-zero.

> 
> Fix by holding damon_sysfs_lock in target_value_store() while saving the
> value.  The read side, damon_sysfs_add_quota_score(), is already called
> while holding the same mutex lock, so it avoids the race.
> 
> Users could reproduce the race by writing zero to the target_value sysfs
> file while DAMON is starting, or online parameters update is ongoing.
> The issue will only rarely happen in the real use cases.  It requires
> sysfs write permission.  The race window is short.  Sane users wouldn't
> write zero target_value.  Especially, they wouldn't do that while DAMON
> enablement and/or online parameters update is ongoing.  That said, the
> probability is not zero, and the consequence (divide-by-zero) is quite
> bad.
> 
> Closes: https://sashiko.dev/#/bug/linux-7f814c9a-986f-4103-a55a-ef9537dcf62b

Maybe Sashiko found the issue before the other patch [1] is applied.


> Fixes: 8b549a4fd3c5 ("mm/damon/sysfs-schemes: commit damos quota goals user input to DAMOS")
> Cc: <stable@vger.kernel.org> # 6.8.x

So this patch is unnecessary for the mainline.  But still need to be added to
older kernels.  Backporting the mainline fix [1] would be one simple way.  The
backporting would be not that straightforward because the core layer parameters
validation was introduced on 7.3 via commit b90408ef1163 ("mm/damon/core:
safely validate src on damon_commit_ctx()").  Hopefully doable.  I will take
time to do backports for relavant LTS and stable kernels.

[1] https://lore.kernel.org/20260903010722.94244-2-sj@kernel.org


Thanks,
SJ

[...]
