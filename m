Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173427;
	b=ip/u/1t/ttUMpeAjktBTXOocdJbW89BOpGD3A4lHKTya4JDin5Z0T7JrtvoDEKDGQOym
	 l1osCZtl1u+ES+Sm7DeqySzxOThjGWC8yQYCB5QnrRhixM1BnrwhIW2zfdiJF8Xqrm4CK
	 Fu4xw8wed3KZR9KH9+gotEXv35Vd+5tvMv+Cxdlvgr9ZfDUaUt5eN1ZJGm+IPeDiwqHuA
	 NuZLNKQ6jasYbTVS/WRclQKEp/hEGWpNNEOyIhKOqZfLm3Py/RU32A4uqQoeYTW2Z3Lit
	 qaNHYJTgS4rBtILn9+bou6l83Szm7ZK/erMnpEb+Lc3oPIx9V10GdUFABHxs7MLS+sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173427;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=0999ZaCZmYA+OxLPmF5b7ind69CMoRNbQsCUySadYrM=;
	b=Lmm0KpFpeCEs/sJpmWCMfPApFf10/zlxkS4p0FMbn1GNnWaTizt+yFShYlcV6CmgAoMi
	 yQMtL17Sm+zU9Pa5POWYhD/CoYSwmiQAZoh8qOMn0zpo5666GLRu+bP/hZEqHNEVz1X+E
	 A2nY6b6yKr3L2KDIPaxRVjKzplezEa4FGH4og01ij+cZRqo3Tfh1qTaP0zmEA7q9zf/hT
	 GhLf7ortJjXtUbUupeeBzMGcdV6skTHep/j7qGp9Q/0LT6LUa71Kr4yLnRw6qdEMuiowl
	 V0Am7H8YsYAs1iBfxODRuMFJ59/wNVMvXxZaZbWzomhx1HKN/2UzU0GFnCl7zFK+o+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KFAO1G7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E31E2606A334;
	Fri, 20 Nov 2026 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=KFAO1G7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD1311F000C6;
	Fri, 20 Nov 2026 11:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795173426;
	bh=0999ZaCZmYA+OxLPmF5b7ind69CMoRNbQsCUySadYrM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KFAO1G7jwXpbbaBXH/KzG9t8x3LOnmvzf2S0xrgoacg46Y9QxMIQTsK8PQchrPWRn
	 POjiYAoYCimrKRzRQKI84C92p+8e9tIvX55YJFhVrXhOPIaJJm+MrMVrFhMpLPM55G
	 Oeu5ntk/Dpzng3cf4l7XkbN6c2cRxx0Rj3JLIgjs=
Date: Fri, 20 Nov 2026 12:17:03 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: hyunjungg <hj351016@gmail.com>
Cc: Neill Kapron <nkapron@google.com>,
	Ruslan Bilovol <ruslan.bilovol@gmail.com>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: f_uac1_legacy: disable OUT ep and drain
 work on teardown
Message-ID: <2026112044-darling-stained-ab13@gregkh>
References: <20261108133532.532633-1-hj351016@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261108133532.532633-1-hj351016@gmail.com>

On Sun, Nov 08, 2026 at 10:35:32PM +0900, hyunjungg wrote:
> From: Hyunjung Ko <hj351016@gmail.com>
> 
> f_uac1_legacy enables the OUT endpoint in f_audio_set_alt() and queues
> usb_requests whose completion handler f_audio_complete() dereferences the
> f_audio (req->context) and audio->out_ep, and which schedules
> audio->playback_work. However f_audio_disable() is empty and nothing
> disables the endpoint or drains the work on teardown, so:
> 
>  - f_audio_complete() can run after kfree(audio) (the UDC gives back
>    pending requests on the still-enabled endpoint during unbind), using
>    freed memory -- a use-after-free; and
>  - a playback_work still pending runs f_audio_playback_work() against the
>    freed f_audio -- a second use-after-free.
> 
> Disable the OUT endpoint in f_audio_disable(): the UDC then gives back the
> outstanding requests, so f_audio_complete() stops touching @audio and no
> new playback_work is queued. f_audio_disable() runs in atomic context
> (reset_config() holds cdev->lock), and usb_ep_disable() is safe there.
> 
> Drain the work from f_audio_free() instead, where sleeping is allowed:
> cancel_work_sync(&audio->playback_work) before gaudio_cleanup() tears down
> audio->card (which f_audio_playback_work() -> u_audio_playback()
> dereferences) and before kfree(audio). The endpoint is already disabled by
> the time f_audio_disable() has run, so the work cannot be re-queued and
> cancel_work_sync() is sufficient.
> 
> Found by static analysis and an automated reviewer; the playback_work
> use-after-free was reproduced with KASAN under dummy_hcd (slab-use-after-
> free in u_audio_playback() from f_audio_playback_work() after
> f_audio_free(); a delay was added to the streaming path to make the
> schedule-vs-free race deterministic). The out_ep/f_audio_complete
> use-after-free is established by code inspection.
> 
> Fixes: c6994e6f067c ("USB: gadget: add USB Audio Gadget driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
> ---
> v3: Fix the v2 regressions found in review:
>     - Do NOT cancel_work_sync() in f_audio_disable(): that callback runs in
>       atomic context (reset_config() under cdev->lock), so the sleeping
>       cancel would be a sleep-in-atomic. Only usb_ep_disable() (atomic-safe)
>       stays in f_audio_disable(); the work is drained from f_audio_free().
>     - Drop the play_queue/copy_buf drain added in v2: audio->copy_buf can
>       alias a buffer already on play_queue (f_audio_set_alt altset 0 queues
>       it without clearing the pointer) and can hold ERR_PTR(-ENOMEM), so
>       freeing it there double-freed / dereferenced an error pointer. That
>       buffer-leak + copy_buf aliasing is a separate pre-existing issue and
>       is left for a dedicated fix.
>     - Correct the Fixes: tag to the original driver commit c6994e6f067c.
> 
> v2: https://lore.kernel.org/linux-usb/20261108122645.421721-1-hj351016@gmail.com/
>  drivers/usb/gadget/function/f_uac1_legacy.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
> index 7c8d60c..c07f323 100644
> --- a/drivers/usb/gadget/function/f_uac1_legacy.c
> +++ b/drivers/usb/gadget/function/f_uac1_legacy.c
> @@ -697,7 +697,17 @@ static int f_audio_get_alt(struct usb_function *f, unsigned intf)
>  
>  static void f_audio_disable(struct usb_function *f)
>  {
> -	return;
> +	struct f_audio *audio = func_to_audio(f);
> +
> +	/*
> +	 * Disable the OUT endpoint: the UDC gives back any outstanding
> +	 * usb_requests, so f_audio_complete() stops dereferencing @audio and
> +	 * no further playback_work is queued. This callback runs in atomic
> +	 * context (reset_config() holds cdev->lock), so it must not sleep;
> +	 * the work is drained from f_audio_free() instead.
> +	 */

Why is this comment needed?

LLMs love to write comments, be sensible instead.

thanks,

greg k-h
