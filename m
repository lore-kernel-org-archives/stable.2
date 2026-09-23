Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCED3AB460;
	Wed, 23 Sep 2026 05:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143184; cv=none; b=RJHbOkLiBPsel8s2vjEVHuNslGDjv7KLqg6hMYpMnLV23A7mjisvhxuQ99sL4r4nBA4vGreW1CvDOcPBExwQU8lHnPj1O5wMofabRVU9Qs0LoMm+Ve3htoGd+IRfV3PO0ww6XjU5BYPuVfrT0lel0d/RptUkEfJYX7b/E0wcndY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143184; c=relaxed/simple;
	bh=2eMbm2UpcoovuzB4FRbd8fUnal4vcF7lk8+nHVbuGcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H45ih8ckqhI/aN0T3KA8+gN+qUM4qBPNubRQq0HsURQKJ9ETQ4icEfx6IxSApSdi5znAB1LDWVQH7BgVX+APv4LFJEu9nr/XjTN4qJQxEuR1TyDXMeAvNR/Kz4JhVvifYrlDy1aineQ6UaaUHlm1p1xoMQUmk8RQumDmPgyTqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8VgSOXe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8VgSOXe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB1E21F000FF;
	Wed, 23 Sep 2026 05:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790143183;
	bh=T0q+UNTS7TEJdRtDKrLfE/EvgmECHCAwTbTZ2Ttusqc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h8VgSOXe4RBqqrmytkAtjUaYqpFZB31iG18EYsKuzTkeYHceZmdu1gDbB9HrOqDlJ
	 uFvavOa8tcq5OzbHDrc5SnPNB5Q/MWDsCtjjDliUFCs6f9dtytrKzPMHJXp/jj9Vaw
	 G/Y9OjeXbYQ6DKa82i2CCcwLx+79TmTO1D+d1bdOn605DffZKS/Y1jvfqkJm2D0PiN
	 i0XHJXfBg5bR8fDO6CnT0FCgMVNTeieOiZnYpQBS9FFylEFTIZMtO/Wvgq6GnQMxWi
	 PSDa0eKT3ycmB/EGiQ9Mwl/i8y6Yd8yl+ugUEoNDnwvPsAZegiIULIwVcS3jBheejI
	 l9fUoogPcOIkQ==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Tue, 22 Sep 2026 22:59:38 -0700
Message-ID: <20260923055939.3495-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923002600.1825448-2-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 23 Sep 2026 09:25:58 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> damos_goal_tune_esz_bp_temporal() converts the scheme's size quota
> into basis points with "quota->esz_bp = quota->sz * 10000", both
> unsigned long, and damos_set_effective_quota() divides the result
> back by 10000.  quotas/bytes is unbounded; bytes_store() hands it to
> kstrtoul() as is.
> 
> On 32-bit the product wraps for any size quota above ULONG_MAX /
> 10000, that is 429496 bytes.  A wrapped product below 10000 divides
> to a zero effective quota: 429497 gives 0.  damos_quota_is_full() is
> then true on the first test of every charge window.  Other wrapped
> values are wrong without being zero: 500000 gives 70503.
> 
> Triggering this needs a scheme with a quota goal, the temporal goal
> tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
> 32-bit, 1844674407370955 on 64-bit.  The scheme then makes no
> progress for as long as the goal is unachieved, which is easy to
> notice, and writing a smaller size quota restores it.  Nothing is
> corrupted and nothing leaks.  This is unlikely to be hit on a tested
> setup.
> 
> addr_unit does not cover this.  It only scales the numbers a paddr
> context writes to quotas/bytes, so a large enough scaled value wraps
> just the same, and vaddr and fvaddr contexts take raw byte values.
> 
> Bound the multiply.

Looks good to me, thank you for finding and fixing this!

> 
> Fixes: af738a6a00c1 ("mm/damon/core: introduce DAMOS_QUOTA_GOAL_TUNER_TEMPORAL")
> Cc: <stable@vger.kernel.org> # 7.1.x
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: SJ Park <sj@kernel.org>


Thanks,
SJ

[...]
