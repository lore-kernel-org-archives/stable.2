Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795173377;
	b=Z9bctU9qs/VtEaxHAz14hDXzGY2A/ILKxxufXn0REhUmD2dfa8ssjWiw2m3+pYA0jiUr
	 Yq15sshkUh5eYcNRajoxqQ0vQdDpov0hn/Mtypv/a4BTJI0/hpj6AcbeIsYwJ/lW8UsJ+
	 k4IjcE2eSP+9ovu8jeZNW+mtQ8Go97K0JKeJQdx4U8nkUP6bh9eWCYtC2ECaeaj7912ZQ
	 9Ljn0hI8mZ/SbHk5ByMyyA1wrBv4j8NVs1X4c4bkK4JDDkkyJEEIpbYlZ6Ni+6zV7jNWP
	 661gyU7a84641WLjqIrlrc2lfnRvAZ+gwZiqLuJEEb5RNPjQ1REtE326Pld/ToOkPHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173377;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pl136nzpOFQ345cNO6L/r1uz90t3NzllIlAz7VRcMtI=;
	b=LMA27b4LpHPoVE5EW4x+xZDKtf0HVHQ+/GHROJ9mdLGCyUU9mUzbSkqkCaX8itayGd51
	 KCI4VD0kp4CwVp90okjdqYncrUbuf0jkOcMSXeYEyA8x4H63ezWWFUOGLzTVoPqA8+QF+
	 xX9oZF8KGhHvI4W0pxu5053G19uwWvdpiBeIM5AblCu70SHGEPIJeemlQWol7HlGeC6kN
	 GZuDnywwZnmxsS2Y5rKCIVodUQ+S4BADEUA0loNZFZ5Kvxr6wnXY3C79pDKP2jLTQgD+u
	 nxeuWp9XlSiTC1CgaFzfZqmwW/vJOmBVrBp2EV7o9bsUmglmvUUnjmI0vEGG5kq7wyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zUySvkkH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E485C606A320;
	Fri, 20 Nov 2026 11:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zUySvkkH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9DC51F000C0;
	Fri, 20 Nov 2026 11:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795173376;
	bh=pl136nzpOFQ345cNO6L/r1uz90t3NzllIlAz7VRcMtI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=zUySvkkHhPiH3OWBBhmtbPX5N22IOKGeVTdc3jos3pj0U8ksV8GdleYy1i/sdZgnU
	 fDrPAzJJtMEYCSbG+7qnnH9VcS4tGvjl2XPwDImU+5xFNR1U7FTob/VsFWLfkuapHl
	 +YiHkeWBdYslE/3KxNS+ET0Em1HSiUoZdeijhRFc=
Date: Fri, 20 Nov 2026 12:16:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: Neill Kapron <nkapron@google.com>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] usb: gadget: f_uac1_legacy: fix copy_buf lifetime on
 queue handoff and free
Message-ID: <2026112033-gummy-backward-5436@gregkh>
References: <20261104125346.2552742-1-tristmd@gmail.com>
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
In-Reply-To: <20261104125346.2552742-1-tristmd@gmail.com>

On Wed, Nov 04, 2026 at 12:53:46PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> f_audio_free() tears down the f_audio structure without cancelling
> playback_work or releasing audio buffers.  The pending work can access
> the freed structure, and queued audio buffers leak.
> 
> Additionally, f_audio_set_alt() and f_audio_out_ep_complete() transfer
> copy_buf to play_queue without clearing audio->copy_buf.  When
> playback_work later consumes the buffer from the queue, audio->copy_buf
> becomes a stale reference.
> 
> Clear audio->copy_buf when its buffer is queued to play_queue, so the
> pointer reliably reflects ownership.  In f_audio_free(), cancel
> playback_work, drain the play_queue, and free copy_buf when it was not
> queued.  Use IS_ERR_OR_NULL for the copy_buf check because
> f_audio_buffer_alloc() returns ERR_PTR on failure and f_audio_set_alt()
> stores the result directly in audio->copy_buf.
> 
> Fixes: c6994e6f067c ("USB: gadget: add USB Audio Gadget driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> 
> Changes in v4:
> - Fix the root cause of the stale copy_buf reference: clear
>   audio->copy_buf at the two sites that transfer ownership to
>   play_queue (f_audio_out_ep_complete inside the spinlock, and
>   f_audio_set_alt alt 0) so playback_work consuming the buffer
>   can no longer leave a stale pointer (sashiko-bot)
> - Simplify f_audio_free drain: no buf == copy_buf comparison
>   needed since copy_buf is now reliably NULL when its buffer
>   is on the queue
> 
> Changes in v3:
> - Guard copy_buf free with IS_ERR_OR_NULL because
>   f_audio_buffer_alloc() returns ERR_PTR on failure (sashiko-bot)
> - Attempted to detect copy_buf during queue drain, but that
>   missed the case where playback_work already consumed it
> 
> Changes in v2:
> - Added play_queue drain and copy_buf free (sashiko-bot)
> 
>  drivers/usb/gadget/function/f_uac1_legacy.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_uac1_legacy.c b/drivers/usb/gadget/function/f_uac1_legacy.c
> index 7c8d60c7e87d1..cba7b447b09e3 100644
> --- a/drivers/usb/gadget/function/f_uac1_legacy.c
> +++ b/drivers/usb/gadget/function/f_uac1_legacy.c
> @@ -9,6 +9,7 @@
>  #include <linux/slab.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/err.h>

Are you sure this is needed?  If so, why here in the list?

>  #include <linux/device.h>
>  #include <linux/atomic.h>
>  
> @@ -338,6 +339,7 @@ static int f_audio_out_ep_complete(struct usb_ep *ep, struct usb_request *req)
>  	if (audio_buf_size - copy_buf->actual < req->actual) {
>  		spin_lock_irq(&audio->lock);
>  		list_add_tail(&copy_buf->list, &audio->play_queue);
> +		audio->copy_buf = NULL;
>  		spin_unlock_irq(&audio->lock);
>  		schedule_work(&audio->playback_work);
>  		copy_buf = f_audio_buffer_alloc(audio_buf_size);
> @@ -670,6 +672,7 @@ static int f_audio_set_alt(struct usb_function *f, unsigned intf, unsigned alt)
>  			if (copy_buf) {
>  				list_add_tail(&copy_buf->list,
>  						&audio->play_queue);
> +				audio->copy_buf = NULL;
>  				schedule_work(&audio->playback_work);
>  			}
>  		}
> @@ -942,7 +945,15 @@ static void f_audio_free(struct usb_function *f)
>  {
>  	struct f_audio *audio = func_to_audio(f);
>  	struct f_uac1_legacy_opts *opts;
> +	struct f_audio_buf *buf, *tmp;
>  
> +	cancel_work_sync(&audio->playback_work);
> +	list_for_each_entry_safe(buf, tmp, &audio->play_queue, list) {
> +		list_del(&buf->list);
> +		f_audio_buffer_free(buf);
> +	}
> +	if (!IS_ERR_OR_NULL(audio->copy_buf))

How can it be an error?  This is usually a sign something else is wrong,
right?

thanks,

greg k-h
