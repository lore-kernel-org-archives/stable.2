Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AD2331ED7;
	Wed,  9 Sep 2026 09:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945460; cv=none; b=hVXpCiCNlJ1JSi6zK+AvOxGlooj1WcPT/bsQ/eN/wcOOR6Qw+xa6iu+eq8Rp7CzStnzFdM+WvKeZ7OPoEX8Gws9R0Q9KNTXa88SheVJ753MHBHpdVFXz9biDngc2sxfAYF2Fhl0JPdm42eDOn2r66M0+RSPjb7webxvMaMEyYXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945460; c=relaxed/simple;
	bh=fdat5G0UKfo0865WfoyMWaKXr1CyLEBx4K/hS4yL7pI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jE6JfXIlrTnUnzV5gpL3IXBPLThB45bs3y/3hP3IdSQ1xVJlAHuWvf3dexfvYZuk08qMBvLDl2tUaht0bPn/KFAVpQwlPH/Lq4lLoJyo9vJ82pa7NUHV5KHTUaz7DxhS2pTiYDGWoJ1XxCQr4qJU/tGqBe/OQ5EX51jw5Nf4AR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOqVPZsV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOqVPZsV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62C781F00A3A;
	Wed,  9 Sep 2026 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945458;
	bh=rn74IMaN/HWP1QctutB5rG3DczPHZb1e58WwrVMGWrI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gOqVPZsVM/oS17LtXDP3P5+968btKsf0w4WSKIK1JpVB20efKuiY9NivPwpwOfBDx
	 gIfMeaUOFFo5OPaWJh+ftOkfWvCWw/XgAa+lv1nGzGtN+o7FRBCkuWSpBYjjDcIzjT
	 lvJPUAEj4JWDemFxvdj0AEsvUqtMKSP2jmDUwG2D+mApsFQSWnuz+L9Tz7n/V6Xo+P
	 S67BRERqZks4sYy5KjGWgiRCCUxe2zIbLkMgU19zT/4xr3pnrwExoSu00yAeseQldR
	 nwb1OjC62mnmic3bNLpuwasXlPuqFRq+YIqhF1VXM+JwcnEImUJR7FPBmchAblN/g3
	 80ZsJ/2eRaBMQ==
Date: Wed, 9 Sep 2026 11:17:35 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	"Cc: Hyunwoo Kim" <imv4bel@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>, Ingo Molnar <mingo@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>, stable@vger.kernel.org
Subject: Re: [patch V2 1/8] signal: Prevent exec() race
Message-ID: <aqEkL15HuEzl34nz@pavilion.home>
References: <20260905181551.738186850@kernel.org>
 <20260905185839.667208455@kernel.org>
 <ap6urw5aAxrKO3Ck@localhost.localdomain>
 <87ik4h2icz.ffs@fw13>
 <ap8bUiYYwQT1nVg5@pavilion.home>
 <875x0g3de3.ffs@fw13>
 <ap_gOSWtPNjwWS1e@localhost.localdomain>
 <aqCiXo-h1F5jsp_N@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqCiXo-h1F5jsp_N@redhat.com>

Le Wed, Sep 09, 2026 at 02:03:42AM +0200, Oleg Nesterov a écrit :
> On 09/08, Frederic Weisbecker wrote:
> >
> > Old leader                           Exec'ing New leader     CPU 2
> > -----                                -----                   -----
> >
> > WRITE q->next = q
> > WRITE q->prev = q
> 
> Damn ;) I am shy to suggest this again, but if we have _any_
> concerns about the races with list_del_init()...
> 
> The lockless flush_sigqueue_list() doesn't need to it, right?
> So perhaps something like below (on top of this series) to avoid
> the (potential) race explicitly?
> 
> Most probably this change is wrong. And in any case we can do better.
> Just to explain what I mean.
> 
> In short, I mean that exit_signals() -> flush path can do
> __sigqueue_free(q) without list_del_init(&q->list).
> 
> Yes! I agree in advance that if this change can fix something,
> then it fixes the symptom.
> 
> But at the same time, why does flush_sigqueue_list(head) need
> list_del_init() before __sigqueue_free() ? AFAICS only to make
> list_empty(head) == true. This looks confusing to me.
> 
> Oh, I am sure I missed something again ;)
> 
> Oleg.
> ---
> 
> diff --git a/kernel/signal.c b/kernel/signal.c
> index f93d8f77ec1a..32c344ee4769 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -457,14 +457,19 @@ static void __sigqueue_free(struct sigqueue *q)
>  	kmem_cache_free(sigqueue_cachep, q);
>  }
>  
> -static void flush_sigqueue_list(struct list_head *head)
> +static void __flush_sigqueue_list(struct list_head *head)
>  {
>  	struct sigqueue *q, *tmp;
>  
> -	list_for_each_entry_safe(q, tmp, head, list) {
> -		list_del_init(&q->list);
> +	list_for_each_entry_safe(q, tmp, head, list)
>  		__sigqueue_free(q);
> -	}
> +}

I must confess that leaves me an uncomfortable taste :-)

What do you think about Peter's solution?

Thanks.

-- 
Frederic Weisbecker
SUSE Labs
