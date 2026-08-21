Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA63937BE7E
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787316872; cv=none; b=SeHRP97GtMnFly2lJv0jbt2Uq4XGG29dtg77rbfViQOyUR5kvd+jyfUDSLnvk5EXkjlnSGr94ANLyV4UJO8S0kNAr2H24rpoiK9tY3RIxRjsybudmvPZguxK22GQeqTRUJV9wM27bc7gpZoqaghHH9Y/LGTmoWAOHiG+Hx5ZHXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787316872; c=relaxed/simple;
	bh=qNsCTFLRK5782+JYZy2P6uOEWxczRHlnw36kBQhGPQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tic2J4jnD587Lhq/YQpjCy7APdY6gLkmOU4jhTLGaE+y7iC62AOnPlDwwRgxZtVmZ5jG0wWPollKQWscHPMuXW7NNBprbN6xdO1QMvMtDU8TjMiAycjE/gyVkmCe09XhP3HDyuxPx5kVGawNCeK73oOYp51paaf87BtFuQZjKPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5h7m5bH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wf6FiR0O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5h7m5bH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wf6FiR0O"
Date: Fri, 21 Aug 2026 14:54:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1787316868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5WSSUBfwh2kQE3Pdvvzrjg7SUFduwZvqkpyDzcw8ws=;
	b=I5h7m5bHbJDecwVCxrDWQnbZZYjcCx171z2LkR244LuRnRueARAi8AE0x6w29pzL6F0w7+
	j7FVHMiVuemwIWp8sx0vwOzudphnYjLw6qHWeVFBEXHuRjo75kwyZ990l7NxqsOtkYP4jI
	Blq4SazF8YIEBteI+aXMKsQ5WTtI7Ij1WYEdpSkM5qiUDZLciU0gocH7AaemMLegWN1HRn
	4Mr00GiO853QYK/G+YECIvwr3vJPShnOgU2p0vvXyOov8NRyYs1CMqMtdN/d6muIcB8vqW
	TaTwyCeWcj59jWU/2pgnFjhk37UcBHmlB55kb2mn4t2dSsEC4NYA2W3rIsUUNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1787316868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5WSSUBfwh2kQE3Pdvvzrjg7SUFduwZvqkpyDzcw8ws=;
	b=wf6FiR0Ovm0fWnRZNLqo0o6E7KV67Iqq0+ByK79Po6jntzIEws0N8EKfxeAKTgIWOmX+dt
	0PVpHCNeUn3N2lCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Maarten Lankhorst <dev@lankhorst.se>
Cc: intel-gfx@lists.freedesktop.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	Chris Wilson <chris@chris-wilson.co.uk>, stable@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Use signalers_lock to prevent starvation of
 irq_work.
Message-ID: <20260821125427.hHvCxR88@linutronix.de>
References: <20260821114508.25669-1-dev@lankhorst.se>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260821114508.25669-1-dev@lankhorst.se>

On 2026-08-21 13:45:08 [+0200], Maarten Lankhorst wrote:
> IRQ-Work (FIFO-1) will be preempted by the threaded-interrupt (FIFO-50)
> and the interrupt will poll on signaler_active while the irq-work can't
> make progress.
>=20
> Solve this by adding a global spinlock to prevent starvation and force
> completion.
>=20
> The existing RCU handling gets in the way on PREEMPT_RT, and would likely
> require conversion to raw spinlock to take them inside a
> rcu_read_lock(), so remove RCU as well.
>=20
=E2=80=A6

This looks straight forward and removes signaler_active, so look like a
win-win situation.

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

=E2=80=A6
> diff --git a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c b/drivers/gpu/dr=
m/i915/gt/intel_breadcrumbs.c
> index c10ac0ab3bfa8..0ae7759dc74a3 100644
> --- a/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> +++ b/drivers/gpu/drm/i915/gt/intel_breadcrumbs.c
> @@ -88,24 +88,25 @@ static void add_signaling_context(struct intel_breadc=
rumbs *b,
>  				  struct intel_context *ce)
>  {
>  	lockdep_assert_held(&ce->signal_lock);
> +	lockdep_assert_held(&b->signalers_lock);
> =20
> -	spin_lock(&b->signalers_lock);
> -	list_add_rcu(&ce->signal_link, &b->signalers);
> -	spin_unlock(&b->signalers_lock);
> +	if (list_empty(&ce->signals))
> +		return;

This list_empty logic here is inherited. Not sure why this list_empty is
here. But the removal has (had) the reverse check here and now gains a
check against double removal. I guess since the logic is mostly the
same, there is no need to check for double add.

> +	intel_context_get(ce);
> +	list_add(&ce->signal_link, &b->signalers);
>  }
> =20
>  static bool remove_signaling_context(struct intel_breadcrumbs *b,
>  				     struct intel_context *ce)
>  {
>  	lockdep_assert_held(&ce->signal_lock);
> +	lockdep_assert_held(&b->signalers_lock);
> =20
> -	if (!list_empty(&ce->signals))
> +	if (!list_empty(&ce->signals) || list_empty(&ce->signal_link))
>  		return false;
> =20
> -	spin_lock(&b->signalers_lock);
> -	list_del_rcu(&ce->signal_link);
> -	spin_unlock(&b->signalers_lock);
> -
> +	list_del_init(&ce->signal_link);
>  	return true;
>  }
> =20

Sebastian
