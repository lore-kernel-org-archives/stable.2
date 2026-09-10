Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C3630B521;
	Thu, 10 Sep 2026 00:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789001113; cv=none; b=cyNXAlxHsNQBqX2qwODYCQETvsMDCvsBPgm+v3MA+d+uvOFPBJ3A1a1tMCZCOpRsAYfpAgb+h+oDoHBKA6y9YKwaWXaUgA1FySFaQ51nrMX06VjwfHIENgzKLWve73eNpz7vICdD0bJTTHCzKrYStQIPwZVhHZOPvqWGjXjQoG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789001113; c=relaxed/simple;
	bh=qCWY98Jupkufjcpkcj/kWCEIJFwqw1+Dx49dq6XAq70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xl3g4Go9QTb4z5ASgv+xXjwZlDA4WAe/yk8+UR1V8kHVMETcIJ2OCjHjoNyziX4/MqzLGTy4dTUovHwO1OiZZ6l0jLS+bKbfhwyN3bQIf63NLzCSAi8nPcEiTYIq08pIa0p345s0rNBjFfws15L0WFY0XdNQLIjEINIVE0jgslM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rwvn8lU1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rwvn8lU1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F5B1F000FF;
	Thu, 10 Sep 2026 00:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789001111;
	bh=YKhohbnYDR28fX47ni3gWvr9088lQYnAliH86AdV7F4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rwvn8lU1WtEUHv4zw/3Xm5KnBQ4taOSf4DlgqrXYg/5D/mHn9fU4TnObtaL+wZbud
	 X9+s5tlQBqh0d8kJUIEyv262TqFvTXA2wu2iI5Rg+9hGwDu37iEWMMBLV5SsPO+eFW
	 oT4tHHz48jp1GQPPWQHeW/mul9JfcD/Z4VCabel3lD5oXbToUTTBE6vIz8T4kas+/t
	 jyq6VKaV5dr6oQp/Bk6bNdMW8fpeX5OBJ09MLLuDkZOOfVGn9JU5ZqIKdrkyd/dPf/
	 DsWfk6F53TWgpXPWNo/94gzXMBBbqQDmm1MXyNpoyPTlNt6JX9bKSmFEuzydsm5n2d
	 u3+rWRCel/srQ==
From: SJ Park <sj@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 6.18.y] mm/damon/sysfs: read ops_id only once in damon_sysfs_apply_inputs()
Date: Wed,  9 Sep 2026 17:45:03 -0700
Message-ID: <20260910004504.118187-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026090945-spookily-leotard-ecf3@gregkh>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 9 Sep 2026 15:01:49 +0200 Greg KH <greg@kroah.com> wrote:

> On Tue, Sep 08, 2026 at 08:28:30PM -0700, SJ Park wrote:
> > damon_sysfs_apply_inputs() reads ops_id twice.  It could race with
> > ops_id_store().  As a result, the min_region_sz could wrongly be set up.
> > Read it once.
> > 
> > The user impact is trivial.  Sane users ain't update the parameter in
> > parallel.  Even if it happens, the DAMON core layer handles the wrong
> > min_region_sz (!is_power_of_2()).  Even if somehow the race ended up
> > making a min_region_sz that is different from the user's intention but
> > still valid, only monitoring itself runs differently than expected.  No
> > critical consequences like kernel panic or memory corruption happen
> > 
> > The issue was discovered [1] by Sashiko.
> > 
> > Link: https://lore.kernel.org/20260715031002.108504-7-sj@kernel.org
> > Link: https://lore.kernel.org/20260703172417.95426-1-sj@kernel.org [1]
> > Fixes: 8d009da32f13 ("mm/damon/sysfs: set damon_ctx->min_sz_region only for paddr use case")
> > Signed-off-by: SJ Park <sj@kernel.org>
> > Cc: <stable@vger.kernel.org> # 6.18.x
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > (cherry picked from commit 5adaaa28be8a79ddd7e103b171f9d6e14e7fc26e)
> > Signed-off-by: SJ Park <sj@kernel.org>
> > ---
> >  mm/damon/sysfs.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
> > index a6c3e83a3dad5..655e4de69bee8 100644
> > --- a/mm/damon/sysfs.c
> > +++ b/mm/damon/sysfs.c
> > @@ -1432,14 +1432,16 @@ static inline bool damon_sysfs_kdamond_running(
> >  static int damon_sysfs_apply_inputs(struct damon_ctx *ctx,
> >  		struct damon_sysfs_context *sys_ctx)
> >  {
> > +	enum damon_ops_id ops_id;
> >  	int err;
> >  
> > -	err = damon_select_ops(ctx, sys_ctx->ops_id);
> > +	ops_id = READ_ONCE(sys_ctx->ops_id);
> > +	err = damon_select_ops(ctx, ops_id);
> >  	if (err)
> >  		return err;
> >  	ctx->addr_unit = sys_ctx->addr_unit;
> >  	/* addr_unit is respected by only DAMON_OPS_PADDR */
> > -	if (sys_ctx->ops_id == DAMON_OPS_PADDR)
> > +	if (ops_id == DAMON_OPS_PADDR)
> >  		ctx->min_sz_region = max(
> >  				DAMON_MIN_REGION / sys_ctx->addr_unit, 1);
> >  	err = damon_sysfs_set_attrs(ctx, sys_ctx->attrs);
> > -- 
> > 2.47.3
> > 
> > 
> 
> Does not apply :(

Seems a patch in 6.18.50..6.18.51-rc1 is causing the conflict.  I just rebased
the patch on 6.18.51-rc1 and posted as another reply [1].

[1] https://lore.kernel.org/20260910004154.115973-1-sj@kernel.org


Thanks,
SJ

[...]
