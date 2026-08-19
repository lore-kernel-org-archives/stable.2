Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6FF2DEA98;
	Wed, 19 Aug 2026 12:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787143323; cv=none; b=rUVyXD3sH3z4fYaODkkl6P4wm5JPgziGvpc2vQQZkWOlSBdNZQpg7KTBHywQ+NWX6bKZTv7aw2nTJz1Ep4hZyaFE58sclXTrmGbhLqeb2E3GFbjCE0l5hKPKHNg2w+1uQdyQnwfOzL9+fTQmcyOQlNZb7uSMxJFsaTV/3QdTR9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787143323; c=relaxed/simple;
	bh=KIdSH0KLf9vqcHH9uvrau9MQj7uamvlXDraUJA64qZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejXBp6hoST/Qb+nOQ4K8BftPq3wK7CoDEDqeUUxdSh3Vqwv2P+kRXRimsZo3NBwMdpaUqA1DtW6Gu4CYLeIEF2jZF2SJYFoyG8GdjD5qKwVHFPPz4xmqv1FxdOL5APyv9TyugshwhBmjRnug9md+zR02D5DPhEjg8S87prZa2nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i1Qbsw7J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i1Qbsw7J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED761F000E9;
	Wed, 19 Aug 2026 12:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787143321;
	bh=VAHvaqEpr36HS76+KzuxwQLtdrY39dOvxxj7V5sLY9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i1Qbsw7JzY92FqXeCOrFqHb+gz4Spp88jUUm3SSm+zk9NQMkSOXkndySdy8O2wVdp
	 6Dkgo7Mu4OIhVkKEQR60hj8LqpiqhrKHAk8UhFcFQqNdSg1GVOtpQBC6MNi03kZBKf
	 DF/RxB5EsFJ+AoPN3xpRQF5hWJXuhGxqdUNkGXQk=
Date: Wed, 19 Aug 2026 14:41:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Rui Miguel Silva <rmfrfs@gmail.com>, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>,
	Kris Huang <huang_kris@projectara.com>,
	greybus-dev <greybus-dev@lists.linaro.org>,
	linux-staging <linux-staging@lists.linux.dev>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	stable <stable@vger.kernel.org>, Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: Re: [PATCH] staging: greybus: light: initialize channel lock before
 registration
Message-ID: <2026081928-calzone-managing-4141@gregkh>
References: <20260818142020.1989539-1-runyu.xiao@seu.edu.cn>
 <2026081801-arguable-gosling-c590@gregkh>
 <ANAASQBEK9Ye2X-O4oze*arv.3.1787142765226.Hmail.220255722@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ANAASQBEK9Ye2X-O4oze*arv.3.1787142765226.Hmail.220255722@seu.edu.cn>

On Wed, Aug 19, 2026 at 08:32:45PM +0800, Runyu Xiao wrote:
> On Tue, Aug 18, 2026 at 20:23:10 +0200, Greg Kroah-Hartman wrote:
> > How was this found and tested?
> 
> 
> Found by code inspection: gb_lights_channel_register() publishes the
> LED class device and its brightness callback before
> mutex_init(&light->channels[i].lock) runs, so a concurrent brightness
> update can take an uninitialized mutex.

What tool did this inspection?  A LLM?

> Tested by reproducing that code shape in a minimal out-of-tree module
> under QEMU (kernel 6.1.66 with CONFIG_DEBUG_MUTEXES=y and
> CONFIG_DEBUG_LOCK_ALLOC=y), since the real driver needs greybus/LED
> hardware I don't have. The module kzalloc's a channel, registers
> (publishes) it, and runs the brightness callback, which takes the
> embedded mutex:
> 
> 
>  - before the fix, mutex_init() runs after register, so the callback
>    locks the still-zeroed mutex and trips
> 
> 
>        DEBUG_LOCKS_WARN_ON(lock->magic != lock)
>        WARNING: CPU: 1 PID: 188 at kernel/locking/mutex.c:582 __mutex_lock+0x712/0xd20
> 
> 
>  - after the fix, mutex_init() runs before register and the same
>    trigger path produces no warning.

But that isn't testing anything at all.

And why 6.1.66?  That's not what new patches need to be made against, as
it's years old.

> The real driver hits this as a race (a concurrent brightness update),
> whereas the reproducer runs the callback synchronously during registration
> to make it deterministic; both leave the callback observing an
> uninitialized lock.

What "reproducer"?  Again, was this done by a LLM?  Where is the
"reproducer"?

thanks,

greg k-h
