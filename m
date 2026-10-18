Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914302C11EE;
	Sun, 18 Oct 2026 18:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.77.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792347859; cv=none; b=p0KvA71Dsiu+gyHSw33x0uGq4Hl6yXXuI0ODSV0W57nmimT/DRA4sw7PpZXLqwa8HmjHvQ4hWowSSO83zNTO+75CxS4pih09TDuwHRYzPJh6uH3sPDypBD+zsiTpnQY7gt8hlNFTSZ2ZMoybMwrV44cNBnpCh4iRy5gSL4xdQS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792347859; c=relaxed/simple;
	bh=MDbRZsT12MhiXzMl2uuaArchwNh0ZXojZ0UZPkdJFs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=raTtH/Gd8Q9wro20MudFvmUAVpmRy/MIMp8lx4Ov2glyiKFIHigpBF9EWrMBhMgtvjee5b/r+Bd0vgF/PDm2EdkPWBlBcUBwWRyr1XlAIpILmATHZ/QGBipzIVBmH6cIG1ciJswATCDIRHKXHTbToCV2Zs5Za5gWYkaegk9+dkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=Dk8TLWiT; dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b=FnbWpTqs; arc=none smtp.client-ip=140.77.166.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="Dk8TLWiT";
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.b="FnbWpTqs"
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 21BCBA0288;
	Sun, 18 Oct 2026 20:24:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1792347849; bh=MDbRZsT12MhiXzMl2uuaArchwNh0ZXojZ0UZPkdJFs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dk8TLWiTl/YbdCkFktEgKgV9cjcPKaGpwXXDvrc5gS77abPeevQDiyWQAMPQVkguD
	 OxQMvuP+OWsRbkhQunMcjnhPS9IEfmQyAvX0LUEJE/V79adSdFo0da4bbBXQ44Cixk
	 pPmPph86/SzEMpXbfPyaun5noNPDGXPoLdGjH/GvnQjLGInGOo4dBDepbCd2VYSAur
	 psqzToR8WyumBYPDoxU2C+CVeqRhUgwPJ+NEWdDprBBVZ/aK+2GuUWJAfXLp3U/tIX
	 zhZ0ELEuE4kY3UbNCt+obp6JW8Nf6BCeyWPSPEz37Z9r1P2LlpZu3UTK7kCJqvGQtX
	 X2IXe67NcD2YA==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1LpMSBfTdPly; Sun, 18 Oct 2026 20:24:09 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id 4558DA010A;
	Sun, 18 Oct 2026 20:24:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1792347848; bh=MDbRZsT12MhiXzMl2uuaArchwNh0ZXojZ0UZPkdJFs0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FnbWpTqscxty/OmW4A6Y2nQTspm09pWB4zrjmk8ZTc8Qb6Sv3flMCYRebWLYqlQv+
	 bdq2b4+S+EFKHB/wiT9L9/BDmUpw2v71UwZm2wyDFhVx8cuqKesSDfQjfYS8HO4UoN
	 AATxUYRxz4TdkmhJ3a8mPDd4JTsADFmIwB5EIz/gZ3wQmNJy5TkhRgQK57Qhk4TvPP
	 PfZbDP2gfq5WL+s/DP/JZr/onCrB/EI47ADQj9Utv6MVwhCWdG150Saa0LTQtkCTm0
	 pXLiEgQECOLJX0xAnYEfJgaNAZWxQZ1KL1I9g8UpuxZLaPkQoUGX62fKfkislkoMSW
	 SeDM6SMlxDFkA==
Received: from samy by end with local (Exim 4.100.1)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1xIVYF-000000024lh-1eRB;
	Sun, 18 Oct 2026 20:24:07 +0200
Date: Sun, 18 Oct 2026 20:24:07 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
	w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] speakup: Stop catch_up when the synth is not alive
Message-ID: <atUOx28JlfcIUqHH@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	chris@the-brannons.com, kirk@reisers.ca, w.d.hubbs@gmail.com,
	stable@vger.kernel.org
References: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
 <20261014071713.321914-2-xiehongyu1@kylinos.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261014071713.321914-2-xiehongyu1@kylinos.cn>
Organization: I am not organized

Hongyu Xie, le mer. 14 oct. 2026 15:17:10 +0800, a ecrit:
> When the synth output cannot make progress, the catch-up loop in
> _spk_do_catch_up() (and in its local copies in the serial synth
> drivers) can spin forever: nothing tells it that the synth is dead.
> This happens
> 
> - when the tty write keeps returning 0 (no room) because nothing
>   consumes the data, e.g. a serial port with no device attached that
>   keeps flow control asserted, or
> - when an I/O error deactivates the synth: synth_out() then keeps
>   returning 0 and the loop never notices that synth->alive became 0.
> 
> While speakup_thread() holds spk_mutex across the whole loop, any
> synth_add(), synth_remove() or synth_init() then blocks forever,
> which gets reported as a hung task on module unload:
> 
>  INFO: task modprobe:2999919 blocked for more than 120 seconds.
>   mutex_lock+0x54/0x68
>   synth_remove+0x28/0xb8 [speakup]
>  INFO: task modprobe:2999919 is blocked on a mutex likely owned
>   by task speakup:
>   schedule_timeout+...
>   _spk_do_catch_up+...
>   speakup_thread+...
> 
> Check synth->alive in the loops as well, so that catch_up() stops as
> soon as the synth is dead.  synth_release() writes it under
> speakup_info.spinlock, while the I/O error paths write it without the
> lock; that is fine, since the loops only need to eventually observe
> the change.
> 
> On its own this fixes the I/O error case, where the synth is already
> deactivated when the loop retries.  In the no-room case nothing
> clears synth->alive, and speakup_thread() still holds spk_mutex
> across the loop, so nothing can get in to deactivate the synth; the
> follow-up patch completes the fix by clearing synth->alive from
> synth_release() and by dropping spk_mutex from the catch_up() call.
> 
> Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
> Cc: stable@vger.kernel.org
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

Samuel

> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/accessibility/speakup/speakup_acntpc.c | 4 ++++
>  drivers/accessibility/speakup/speakup_apollo.c | 4 ++++
>  drivers/accessibility/speakup/speakup_decext.c | 4 ++++
>  drivers/accessibility/speakup/speakup_decpc.c  | 4 ++++
>  drivers/accessibility/speakup/speakup_dectlk.c | 4 ++++
>  drivers/accessibility/speakup/speakup_dtlk.c   | 4 ++++
>  drivers/accessibility/speakup/speakup_keypc.c  | 4 ++++
>  drivers/accessibility/speakup/synth.c          | 4 ++++
>  8 files changed, 32 insertions(+)
> 
> diff --git a/drivers/accessibility/speakup/speakup_acntpc.c b/drivers/accessibility/speakup/speakup_acntpc.c
> index a27e6bbf05da3..fe19ba3f00053 100644
> --- a/drivers/accessibility/speakup/speakup_acntpc.c
> +++ b/drivers/accessibility/speakup/speakup_acntpc.c
> @@ -192,6 +192,10 @@ static void do_catch_up(struct spk_synth *synth)
>  	jiff_max = jiffies + jiffy_delta_val;
>  	while (!kthread_should_stop()) {
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth->alive) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			break;
> +		}
>  		if (speakup_info.flushing) {
>  			speakup_info.flushing = 0;
>  			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> diff --git a/drivers/accessibility/speakup/speakup_apollo.c b/drivers/accessibility/speakup/speakup_apollo.c
> index d2fbb3f572219..b62696e050fc0 100644
> --- a/drivers/accessibility/speakup/speakup_apollo.c
> +++ b/drivers/accessibility/speakup/speakup_apollo.c
> @@ -157,6 +157,10 @@ static void do_catch_up(struct spk_synth *synth)
>  
>  	while (!kthread_should_stop()) {
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth->alive) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			break;
> +		}
>  		jiffy_delta_val = jiffy_delta->u.n.value;
>  		full_time_val = full_time->u.n.value;
>  		delay_time_val = delay_time->u.n.value;
> diff --git a/drivers/accessibility/speakup/speakup_decext.c b/drivers/accessibility/speakup/speakup_decext.c
> index 271bcf279bf9b..e6be5a99670bd 100644
> --- a/drivers/accessibility/speakup/speakup_decext.c
> +++ b/drivers/accessibility/speakup/speakup_decext.c
> @@ -171,6 +171,10 @@ static void do_catch_up(struct spk_synth *synth)
>  
>  	while (!kthread_should_stop()) {
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth->alive) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			break;
> +		}
>  		if (speakup_info.flushing) {
>  			speakup_info.flushing = 0;
>  			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> diff --git a/drivers/accessibility/speakup/speakup_decpc.c b/drivers/accessibility/speakup/speakup_decpc.c
> index 1bf36d1e54773..cfafd94759639 100644
> --- a/drivers/accessibility/speakup/speakup_decpc.c
> +++ b/drivers/accessibility/speakup/speakup_decpc.c
> @@ -391,6 +391,10 @@ static void do_catch_up(struct spk_synth *synth)
>  
>  	while (!kthread_should_stop()) {
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth->alive) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			break;
> +		}
>  		if (speakup_info.flushing) {
>  			speakup_info.flushing = 0;
>  			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> diff --git a/drivers/accessibility/speakup/speakup_dectlk.c b/drivers/accessibility/speakup/speakup_dectlk.c
> index 56334405d865c..d9247c53d3275 100644
> --- a/drivers/accessibility/speakup/speakup_dectlk.c
> +++ b/drivers/accessibility/speakup/speakup_dectlk.c
> @@ -246,6 +246,10 @@ static void do_catch_up(struct spk_synth *synth)
>  		spin_unlock_irqrestore(&flush_lock, flags);
>  
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth->alive) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			break;
> +		}
>  		if (speakup_info.flushing) {
>  			speakup_info.flushing = 0;
>  			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> diff --git a/drivers/accessibility/speakup/speakup_dtlk.c b/drivers/accessibility/speakup/speakup_dtlk.c
> index fa826568937bf..73cd39e781b86 100644
> --- a/drivers/accessibility/speakup/speakup_dtlk.c
> +++ b/drivers/accessibility/speakup/speakup_dtlk.c
> @@ -206,6 +206,10 @@ static void do_catch_up(struct spk_synth *synth)
>  	jiff_max = jiffies + jiffy_delta_val;
>  	while (!kthread_should_stop()) {
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth->alive) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			break;
> +		}
>  		if (speakup_info.flushing) {
>  			speakup_info.flushing = 0;
>  			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> diff --git a/drivers/accessibility/speakup/speakup_keypc.c b/drivers/accessibility/speakup/speakup_keypc.c
> index 9356f63795603..e229009107f75 100644
> --- a/drivers/accessibility/speakup/speakup_keypc.c
> +++ b/drivers/accessibility/speakup/speakup_keypc.c
> @@ -193,6 +193,10 @@ static void do_catch_up(struct spk_synth *synth)
>  	jiff_max = jiffies + jiffy_delta_val;
>  	while (!kthread_should_stop()) {
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth->alive) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			break;
> +		}
>  		if (speakup_info.flushing) {
>  			speakup_info.flushing = 0;
>  			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
> index 11cba1fd8715d..6a49ff475c16a 100644
> --- a/drivers/accessibility/speakup/synth.c
> +++ b/drivers/accessibility/speakup/synth.c
> @@ -75,6 +75,10 @@ static void _spk_do_catch_up(struct spk_synth *synth, int unicode)
>  	jiff_max = jiffies + jiffy_delta_val;
>  	while (!kthread_should_stop()) {
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth->alive) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			break;
> +		}
>  		if (speakup_info.flushing) {
>  			speakup_info.flushing = 0;
>  			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> -- 
> 2.25.1
> 

-- 
Samuel
<D> m'enfin, le 5 juillet, le mec vient visiter le labo...
* D a marque d'une croix rouge le 5 juillet sur son agenda
<y> niarc niarc niarc
<D> cet homme va souffrir
<B> c'est donc le 5 juillet qu'il meurt d'un accident de la route écrasé par un truck muni d'un pare buffle
 -+- #ens-mim - repaire de terroristes -+-
