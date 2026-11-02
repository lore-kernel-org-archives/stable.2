Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793580870;
	b=SYiynBnAqt1xgm+/Yx7toF4iPDdhuwtLWFIx46VXB7wmqe+3b57mJN4Fpl68l9VZzRws
	 GH4BJ8rEZ7inXdSQ2yRFU//rrwLUKUrYNqLZWZeeJrhQItpSzCUW2Efs7+Wf5I+QN9BfJ
	 1LFkHfRQaqoFEeFRoA2KZSlJcR6CF6xZe6Rq9XOCf20QYs1RvWR7HATdAOPHK+ufnQRlB
	 IzM/VHLyf7+k4CY/KbAkgmunf0JXkIi4zcWYFqC7MR0mKgbDRigU4dXNmmYFbd1k1k1Fk
	 Ul0k6wY+9PAREtvrXOT9NsQoO8mczdpHl6IYn8SXXTEgcznCu32K3CR+eekFq674uJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793580870;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JVUxdkyBUb/0yjW4j0WZM9elaL3fERdIZQlAiND4ioU=;
	b=FeXVNgNb0OnDJrWOOZxBSkxyR4kH42sqZoZFSinardJsDkBlz8ekx8Hi2I0TNhWInwid
	 MTWJBjshIGVKIdEFACzXHGsYaPMpYAQJsl9kPvIjeebez4U6PvgWtRgYtcS0yFkaDmHvl
	 51LCgTjxl1+umSBeIy/4kyYQS2uI/8ng6Zc6c05gpIBuHU4fhrX8ugu+aaLfUkmyZmcWR
	 4hdmRBgs71s+yPhYwE0CuqGXZlyQ681BZ+3LFI6y2y/0be/0lWV6/fpjCc+5W1qLRqkWO
	 9Z8qQl+nPDlHiQu6nCvNfQguXWbGwaxFpJ748Rs7I/3mlCqMZYcp7rKKNfrHWFdRnVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YR3Wl4n+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2C7606A324;
	Mon,  2 Nov 2026 00:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YR3Wl4n+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59461F00919;
	Mon,  2 Nov 2026 00:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793580869;
	bh=JVUxdkyBUb/0yjW4j0WZM9elaL3fERdIZQlAiND4ioU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YR3Wl4n+WF2yP+H9lAtXZ/+o2y6y3wEHB37SptSBtopypMEzAVuBN71jlG+IvDyk+
	 k8EEayLOuBrcomGRD0vpvspyLwU/fUTnLC7I/i5e1nr0mrgFJxGZ0UVWOapqn3/xx7
	 T1zOBIa3HgFVwoOK42I7HOhUBPIrZrPa4R4/1EwUda6qRg74GoY3iwy1ZJkVL+spOg
	 lSuXu4u/M3uf1hdY7QWusxs/n49wjLu3jHoW/gSq/Zqw22j+0hfGBDRMbdR1BCwucD
	 KMPLs99xcwCXD9h09WiqOeold6neMAQfLSKbrTN8BwkQHr5E7xectVIkk8ki8W2/k4
	 jJjMi1PncMuQA==
Date: Mon, 2 Nov 2026 00:54:24 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu Zhang <yuz08559@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: fix use-after-free in
 current_trigger_store() on concurrent writers
Message-ID: <20261102005424.23c20e72@jic23-hlaptop>
In-Reply-To: <20261026100246.68005-1-yuz08559@gmail.com>
References: <20261026100246.68005-1-yuz08559@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 26 Oct 2026 20:02:46 +1000
Yu Zhang <yuz08559@gmail.com> wrote:

> current_trigger_store() holds iio_dev_opaque->mlock only around the
> INDIO_BUFFER_TRIGGERED / trig_readonly checks and then drops it. The rest
> runs unlocked: it reads the current trigger into oldtrig, acquires the new
> one by name, stores it into indio_dev->trig, and drops the old trigger's
> reference with iio_trigger_put().
> 
> sysfs does not serialize writes to the same attribute issued through
> different open file descriptors (each open has its own kernfs_open_file),
> so two threads can run current_trigger_store() on the same
> .../trigger/current_trigger concurrently. Both read the same oldtrig, both
> overwrite indio_dev->trig, and both call iio_trigger_put(oldtrig). The
> extra put drops the trigger's refcount to zero while it is still in use,
> frees it, and a concurrent writer then dereferences the freed trigger.
> 
> With two sets of writers hammering current_trigger between two software
> triggers on an iio_dummy device, KASAN reports:
> 
>   refcount_t: addition on 0; use-after-free.
>   WARNING: CPU: 3 PID: 3467 at refcount_warn_saturate+0xbb/0xe0
>    kobject_get+0xf6/0x100
>    current_trigger_store+0x15c/0x4b0
>   ...
>   BUG: KASAN: slab-use-after-free in current_trigger_store+0x168/0x4b0
>   Freed by task 3468:
>    kobject_put+0x125/0x220
>    current_trigger_store+0x2cc/0x4b0
>   Allocated by task 3454:
>    __iio_trigger_alloc+0xc7/0x100
>   ...
>   Oops: general protection fault
>    __module_get+0x27/0xd0
>    current_trigger_store+0x192/0x4b0
> 
> Hold mlock across the whole operation so that reading oldtrig, swapping
> indio_dev->trig and dropping the reference are atomic with respect to
> other writers (and to buffer enable, which the -EBUSY check guards).
> Acquiring the new trigger with iio_trigger_acquire_by_name() under mlock
> is safe: it only takes iio_trigger_list_lock, and the buffer path already
> calls iio_trigger_{attach,detach}_poll_func() with mlock held.

Sashiko correctly raises that the change means more directly
mixing goto and cleanup.h magic than before.  To make this change
we'll need to unwind that and just do mutex_lock / mutex_unlock or
figure out another scheme using a helper.
https://sashiko.dev/#/patchset/20261026100246.68005-1-yuz08559%40gmail.com

Other than that, the fix feels correct but I would like some
eyes on this one.

Jonathan

> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Yu Zhang <yuz08559@gmail.com>
> ---
>  drivers/iio/industrialio-trigger.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/industrialio-trigger.c b/drivers/iio/industrialio-trigger.c
> index 76926fe..9241cd6 100644
> --- a/drivers/iio/industrialio-trigger.c
> +++ b/drivers/iio/industrialio-trigger.c
> @@ -441,17 +441,18 @@ static ssize_t current_trigger_store(struct device *dev,
>  {
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
> -	struct iio_trigger *oldtrig = indio_dev->trig;
> +	struct iio_trigger *oldtrig;
>  	struct iio_trigger *trig;
>  	int ret;
>  
> -	scoped_guard(mutex, &iio_dev_opaque->mlock) {
> -		if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
> -			return -EBUSY;
> -		if (iio_dev_opaque->trig_readonly)
> -			return -EPERM;
> -	}
> +	guard(mutex)(&iio_dev_opaque->mlock);
> +
> +	if (iio_dev_opaque->currentmode == INDIO_BUFFER_TRIGGERED)
> +		return -EBUSY;
> +	if (iio_dev_opaque->trig_readonly)
> +		return -EPERM;
>  
> +	oldtrig = indio_dev->trig;
>  	trig = iio_trigger_acquire_by_name(buf);
>  	if (oldtrig == trig) {
>  		ret = len;

