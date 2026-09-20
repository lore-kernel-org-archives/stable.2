Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4848243956;
	Sun, 20 Sep 2026 12:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789908021; cv=none; b=m6/FM04hp0QfBE4aqi3+HgLZauqKfkmQeQzniFfpvtCQs75PrdSqXiTt7Hl4PQqe8UdiKXwQS9l3/kvKA4tdOd832K2tmKDBgL7vLstca2QjoQXyQzaxQf12r54QM6iPjpdk/esEtIdSr5IYxxY7E32W1XFIxEO8392l9omDGkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789908021; c=relaxed/simple;
	bh=2lZ0FNhKn7cEubtY88TaOXEdpfCwGad+8ytGFvIbZwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBsdLDN9Hr/2kYl9hJYZ+rB3Txi2ZuqdFG94wJSeYC1axj1VR9dwEM8OtCAovKmq8ggABeUpyMDwRImDDzGMZv++iOmssCB6e5GgrpHqOfWMbOQaTWNMGhWy8Gt/hGq4pekaDDdrReU5NcyTyygb3szHslRSFgyXTwDiOX7bd80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5YMptaF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5YMptaF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD8D71F000FF;
	Sun, 20 Sep 2026 12:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789908003;
	bh=peWjRymtPXmQsQX1GH6pRekwMOJX0iwDy1XFg+jsg+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L5YMptaFKqtjqb/NeHqaLdXDE4x29W47jZaXTWjpzv8Av3q54uaohccVT8h5yrkJD
	 nwsWht7XBncvpuIUYBEJFeq4HOacwNJbTaSq2qnvOephOf9USt43zi+cTCpvE3ZdQj
	 8VPxgytE5wpLkHED58YBEfBnv5P8uha5wfykYAnevijU85TlVK31KTW9SploSwvPmP
	 wwUw4JdDZl5NPYe9RfPGDyLjxSu+G78P+wDe/AjBOTqrJSFx0p0qtrm8DkfFzdmu/i
	 7aBSdawx3CEV8JSsamd4+qoQFbjgm/ZzWutE8+4APSvQpOcD+OLte6QsW86NAvOr78
	 taZhW/dIKKX2w==
From: SJ Park <sj@kernel.org>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] mm/damon/core: prevent size quota overflow in the temporal goal tuner
Date: Sun, 20 Sep 2026 05:39:58 -0700
Message-ID: <20260920123959.48279-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920122430.610257-1-donggeunyoo.kernel@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 21:24:30 +0900 Donggeun Yoo <donggeunyoo.kernel@gmail.com> wrote:

> Thank you for the detailed review.
> 
> On Sun, 20 Sep 2026 03:37:13 -0700 SJ Park <sj@kernel.org> wrote:
> > Let's break commit message lines with 72 columns limit.
> 
> Done in v3, here and in 2/3.

Don't post a new version without ensuring the discussion on the current version
is completed.  Also give time for others to chime in.  As a rule of thumbs,
ensure all questions on the thread are answered, and give at least ~1 day since
the last comment on the thread before posting a new version.

I will not review the v3.

> 
> > Why 256 MiB, not 429,496 bytes?
> 
> They are two different numbers.  429496 is where the multiply starts
> to wrap, and every size above it is wrong.  256 MiB is where the
> wrapped value lands on exactly zero: 256 MiB * 10000 is 625 * 2^32, so
> on 32-bit the product wraps around 625 times and ends at zero.

So 256 MiB means nothing special, isn't it?  Why you mention it?

> 
> > So, the way to work around is updating the size quota to smaller value,
> > correct?
> 
> Correct.  v3 says so.
> 
> > But why a sane user would set such huge number?
> 
> They would not, which is why v3 no longer argues the 64-bit case in its
> own paragraph.  The threshold is now stated once, as part of what it
> takes to reach the bug: above ULONG_MAX / 10000, which is 429496 bytes
> on 32-bit and 1844674407370955 on 64-bit.
> 
> > Because this patch Cc stable@, let's make super clear about the user
> > impact [...]
> 
> v3:
> 
>   Triggering this needs a scheme with a quota goal, the temporal goal
>   tuner, and a size quota above ULONG_MAX / 10000 -- 429496 bytes on
>   32-bit, 1844674407370955 on 64-bit -- so it is unlikely to be hit on
>   a tested setup.  Nothing is corrupted and nothing leaks.  The scheme
>   makes no progress for as long as the goal is unachieved, which is
>   easy to notice, and writing a smaller size quota restores it.

Let's put "The scheme makes no progress ..." before "so it is unlikely ...".

> 
> > > Bound the conversion, so a size quota it cannot represent falls to the
> > > ULONG_MAX the function already writes for a scheme with no size quota.
> >
> > I don't understand the above sentence.  Is the grammar correct?
> 
> You are right that it is hard to read.  The sentence was too long and
> tried to say two things at once.  v3:
> 
>   Bound the multiply.  A size quota too large to convert now takes the
>   same ULONG_MAX branch as a scheme with no size quota, so the
>   effective quota becomes ULONG_MAX / 10000 instead of a wrapped value.

Seems unnecessarily verbose.  I'd suggest keeping only the first sentence.

> 
> > > Widening esz_bp instead would reach the consist tuner [...]
> >
> > I don't quite understand above.  could you please elaborate?
> 
> Sorry, that paragraph was not clear.  It was meant to explain why I did
> not simply widen the type.
> 
> The other way to fix the overflow is to make esz_bp wider than unsigned
> long, u64 for example.  But esz_bp is not used only here.  The consist
> tuner keeps its own value in the same field, and
> damos_goal_tune_esz_bp_consist() passes it to
> damon_feed_loop_next_input(), which takes unsigned long and returns
> unsigned long.  So widening esz_bp means widening that function too,
> and the consist tuner would change for a problem it does not have.
> Bounding the multiply is one line, and only the temporal tuner is
> touched.
> 
> I dropped the paragraph in v3.  It argues against a fix nobody
> proposed, so it only makes the changelog harder to read.

Yes, let's drop it.


Thanks,
SJ

[...]
