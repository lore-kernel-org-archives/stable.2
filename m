Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F60D3C465;
	Tue,  4 Aug 2026 00:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785802577; cv=none; b=pn3o2brX9H0G7V+ugvZuoFnQRVVS1oYwnn83NGc34gumazhOGD/bJQZVfTn/LhGz/iS3J1RiPZwDt8QzFwlzSuzU3v4ZRZvmxiOSAfZLD/bqqdiza41bbtXTvhztvpPLTie3dweh5W+u2cg6hhkp1DApsSyJyMme66vhLm9xefo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785802577; c=relaxed/simple;
	bh=ranlmv0v2cdV0eIZbH6yeN/vv0UgGU+20snSokbbl5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oOmBVvrR5s+WSFnT5NzJzSZe0dbyHKcL/fWvau+rub1YR8icIr4RJiKIqw5cj9Qfjqz0Q6emmLbFxzIsuGkOl6tYQA1nUzNqQNOSeZi6BOnCAfimKXDIThg5DJXba+x/YPxSkr9TrFXf4yisUE0iwOzosQfqNHZmhsie2mlE2Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJzNbmEe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJzNbmEe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740231F000E9;
	Tue,  4 Aug 2026 00:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785802575;
	bh=t5xgPjpI/UQDoZyAQGTHxRjzYdVNuOzHrHoSVqYbckI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UJzNbmEeeLq43qV6kBBMJr5Oo4f9CafdPlTI4dY4IOHuhaCvzOmMo04AGfR+vI41d
	 6UWGY3DV51ODYf0A6r5VzvOSqqz512s6mvR1N0FNczMyH5ls+o/eBFFYSxHyw1CzhY
	 ZJJ30SpNRT48/Q2iDAHgAPh1v/wChK+rE2g+A+9kHra/pCKN++24jE0WmwnIZaM/vf
	 ln0ae3eUYnxC+EcyoE+erjIlvZPsV/EwkViNel7l9BNRH2Mm+QWd3xd+lSJz5u7lb/
	 b9OvoWSkEP4JjePZCXC2Bg2xU+8GmRR6DSfvCsvM+NAh7QndNzCsnL3YxCHxcJK96/
	 gdwt2Q6vffbAQ==
From: SJ Park <sj@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/damon/lru_sort: error out for >10000 active_mem_bp
Date: Mon,  3 Aug 2026 17:16:05 -0700
Message-ID: <20260804001605.88417-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260803155715.08868ca7@pumpkin>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 3 Aug 2026 15:57:15 +0100 David Laight <david.laight.linux@gmail.com> wrote:

> On Mon,  3 Aug 2026 06:40:33 -0700
> SJ Park <sj@kernel.org> wrote:
[...]
> > --- a/mm/damon/lru_sort.c
> > +++ b/mm/damon/lru_sort.c
> > @@ -233,6 +233,8 @@ static int damon_lru_sort_add_quota_goals(struct damos *hot_scheme,
> >  
> >  	if (!active_mem_bp)
> >  		return 0;
> > +	if (10000 < active_mem_bp)
> 
> That is backwards...

I tend to prefer using only '<' or '<=' because it makes smaller thing comes
left.  But maybe I was overusing that here.  I think 'active_mem_bp > 10000'
should also reads well.  I will think more carefully for this, from the next
time.  Andrew already picked this up and he should be busy for next
merge window preparation.  Hence I'll not revision this for the minor change,
if you don't mind.


Thanks,
SJ

[...]
