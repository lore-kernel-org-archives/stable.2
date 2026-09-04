Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C83E14A99C1;
	Fri,  4 Sep 2026 14:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530744; cv=none; b=qi+H39Bi3pj/Ek9R3LYZby2yXB1NsFGGM9RTi2lBtRSxPqngOX9Uim3VBod5t7AL9Z+55/QsmViEZ70/bsV3PEMhupZ/h2OdsHaMh/7ROVFNn3VcIvuDL95WwwIxU6y/vMtcM/fbDBocFLdiFuYswbBzcSDPczshirdWYj+QD1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530744; c=relaxed/simple;
	bh=q7DN9QB2w5ts2Us/ZbCvRPwh3uL4fSgDguwGeUBwLCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TsRr8PpqIDnewrMx5kbiLlxxOmlNfTpFIAQ/eoC6XjaUvpxePenBluBEYBhZEItK9coU6c2PKX5d4ebMeaj3LJrVAe3bx7FHj7VBN46055XZhF9ETNM4JpKqVAMxKrN5y7D+VTmxdGqtXvzAh9OCU8rOe44cMkBjtoOoVCpst8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI2bij6/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI2bij6/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735391F00A3D;
	Fri,  4 Sep 2026 14:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530742;
	bh=cH8whGMhdnYHqnIKF2d9DpiGJu7/VAcxPYFKae9Iiys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OI2bij6/1gcvJdnYRwg/cyz3uX5kjSP1JBWwvg/oXy/cnjpoFRW38hy/3WXhp3E4o
	 gkDSe1ikvNbn5Gnnme5jcrXiUrZ3W5DnbItax3PtobpTXHHwQFIdaV/Uuf9JBIe2yR
	 Iq5xBRFb35PBpoNSsHJP5trJMLfxOxk/oov8YtbdqHIrWBii4jJH5kto7vcXuHNiDL
	 RD76wAeZ0GvM9OGlbqajgQUIs0QDpbugbIx8jb5TTRGqJkyd50ts9To+DFPI3QMRbE
	 e7vyzCcJUqcoKSNSsxRrcS2gUdWAN8TTV3omRwhjxdhpjtyUdMGM+oreQRMPQMN0VQ
	 6pXTR6o4uhmoQ==
From: SJ Park <sj@kernel.org>
To: Liew Rui Yan <aethernet65535@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2.1] mm/damon/core: fix false positive in damos_quota_is_full() when esz is zero
Date: Fri,  4 Sep 2026 07:05:35 -0700
Message-ID: <20260904140535.64833-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260904081324.3972-1-aethernet65535@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri,  4 Sep 2026 16:07:41 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:

> On Thu, 03 Sep 2026 07:05:20 -0700 SJ Park <sj@kernel.org> wrote:
> 
> > On Thu,  3 Sep 2026 20:41:48 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > 
> > > On Wed, 02 Sep 2026 17:33:50 -0700 SJ Park <sj@kernel.org> wrote:
> > > 
> > > > On Thu,  3 Sep 2026 06:31:38 +0800 Liew Rui Yan <aethernet65535@gmail.com> wrote:
> > [...]
> > > First, I would like to clarify my intention to avoid any
> > > misunderstanding.  My actual goal is to fix the semantic of the
> > > qt_exceeds statistic, rather than necessarily changing the underlying
> > > logic of damos_quota_is_full().
> > > 
> > > Currently, there is an issue with how qt_exceeds is incremented.  When
> > > the quota is set very small, qt_exceeds increases frequently.  This
> > > produces a statistical trend that looks almost identical to the
> > > continuous increments caused by the Temporal Goal being achieved.
> > > 
> > > The original intent of introducing qt_exceeds is to let users easily
> > > notice if the quota is too small.
> > > 
> > > Commit Messages [1]:
> > > 
> > >     mm/damon/schemes: account how many times quota limit has exceeded
> > > 
> > >     If the time/space quotas of a given DAMON-based operation scheme is too
> > >     small, the scheme could show unexpectedly slow progress.  However, there
> > >     is no good way to notice the case in runtime.  This commit extends the
> > >     DAMOS stat to provide how many times the quota limits exceeded so that
> > >     the users can easily notice the case and tune the scheme.
> > > 
> > > However, under the current behavior, users are forced to manually ignore
> > > or filter out the qt_exceeds increments that occur after the Temporal
> > > Goal is achieved.  This adds an unnecessary burden to the users and
> > > contradicts the core goal of making it "easy" for them to tune the
> > > scheme.
> > 
> > Still I feel the problem is unclear.  Why the users need to manually ignore or
> > filter out the increments under what situation?  Knowing specific and detailed
> > case would be helpful.  Are you or some people you know doing that and feeling
> > it is too much?  If so, what is the real use case?  For what purpose and how
> > DAMON is being used?  Why and how the ignorance of qt_exceeds is being done and
> > how painful it is?
> 
> First, I'd like to clarify that this isn't a problem encountered by a
> real user, it's just a scenario I came up with.

Thank you for clarifying this.

> 
> 1. Users sample qt_exceeds periodically (e.g., every 10 minutes).

What's the purpose of this sampling?

> 
> 2. Within this 10 minute sampling interval, the counter aggregates both
>    the real quota exhaustions and the increments caused by esz==0.
> 
> 3. When users notice a high qt_exceeds value, they eventually realize
>    (perhaps by reading the code or documentation) that it includes the
>    counts from the esz==0 state.
> 
> 4. To get the actual quota exhaustion statistics, the user is now forced
>    to perform additional testing and implement external filtering to
>    separate the esz==0 increments from the real exceeds.
> 
> Even if we explicitly state in the documentation that qt_exceeds
> includes the esz==0 counts, it still burdens the user.  The user still
> has to figure out how to filter out the esz==0 increments externally to
> get the signal they actually care about.

Users set the temporal goal.  They can know when the goal is achieved since
most of the goal metrics are already exposed to user space.  Users can also
show the current effective quotas.  I agree that can be cumbersome, but how
problematic it is?  Also, as I asked above, why they want to do this after all?

> 
> Honestly, I struggle to imagine any valid use case where a user would
> actually rely on the qt_exceeds increments caused by esz==0 to make
> decisions.
> 
> If the only purpose of qt_exceeds is to let users "easily notice" if the
> quota is too small,

I agree it could be a signal to show if the quota is too small.  But the real
purpose of qt_exceeds is, in my opinion, letting users understand how DAMOS is
internally working now.  After all, how much quota means if it is too small or
not?  That all depends on the real use case and complicated things including
their SLO etc.

If documentation is saying the purpose of qt_exceeds is to show if the quota is
too small, that is what need to be updated.

> forcing them to manually filter out the noise
> defeats that purpose.

So, I don't agree.


Thanks,
SJ

[...]
