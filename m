Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=140.77.166.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664122;
	b=BzgdwTAE8TMIiVqeQ0z6u3P4hpVc2BhmFNnzIUBhoOHjTsWlQGJgN1rB2qPTJyZ7UCvm
	 /fHum+95d3OQRvg00d6I5oHYe1xn43mQwtnIkrg40Q6XshvHpGBl1q29p228Rthp4kFLU
	 LDsPwr3lBCP8kFu1VEfAImXDbCzswWjHFgD59TRyCr/2qNf/KfHkHOuAPkA452IMvOxQf
	 J4wQkI4mFZ5vnPKsfTvTBVzjWoppmorkNVtb/U7kThTrktaWB3eu6TtUnfiSuyBir+jdN
	 hbrOip7gJ1cwJyG9qHPaoCCjAWxCoXeN+MIC1IRoFiHDg24oLGGFD2SzypSA2N1LHGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664122;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=C/6VrPYKgsAg8inhoe4C+b1bbVJ3bIdCMRRL/NIABzU=;
	b=MReY/8Q/kMVcU8LASF+M/Z2iql5rdTcrw7VdhQR641Rbm3lrL7GWfbrPMOuFSl2c0SBI
	 bMPe9FH/ZU551T077/WV1VUorSUtreaMNXi+mj01QXrOTnP1fv//0XXBWVDodRIg4OIWx
	 ekZWRTp5bsVijVppbdtP7Ta9EVooOaESCEynnTdNcwUWgwxTr+3VvZMX5cGSlprWEUeA/
	 4Qss7NWE9ZXgEse/WLnD74dqx1HO+/Zf9jwN9himbsJB8F6EfmmTOloW3P2xWUnZvWXnc
	 H54nbYxZB2+XhsuGDAPQ2U9kEsKs5k77x1jojxvUDswK5T0+hviTtR+rECTq+ukELGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ens-lyon.org;
	spf=pass smtp.mailfrom=bounce.ens-lyon.org;
	dkim=pass header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=LEKbekM5;
	dkim=pass header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=LEKbekM5;
	arc=none smtp.remote-ip=140.77.166.138
Received: from sonata.ens-lyon.org (domu-toccata.ens-lyon.fr [140.77.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33879606A324;
	Tue,  3 Nov 2026 00:02:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 33879606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=LEKbekM5;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=LEKbekM5
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id AE904A1C1B;
	Tue,  3 Nov 2026 01:01:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1793664112; bh=FR9BdfIPet+wsXALxuOljIqmtFwuv+RXJsRp/4Tpa9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEKbekM5QNyvjUbtdp9E9h5FgB3hdZ311L+wyOb9UgOOUFUpPAfDOjMka+tOrkLfe
	 1g1lPe5xZRyRRjyWW5kCptbKTJSHqelB1AdinKMrzHtDLiUCBnGL1qgmuQh2gQjJrx
	 fO+I+2Pr4CSTudqFPFcmdxos773PfnPE7df649Nkt+b1L0nWEdHE0SdKRyoArmK05z
	 sbrvcwkGnvLUIyeEUY60Er4WLKUipf7DwqDw1hU3QMZhXGMVbOR4cdfMg8Kz+2qtLc
	 /rv4IcYAIzo4qkqOMZXpMj8nWdLMly1d7IOSxpc837XKS8/7389riWJ+6owW07YNbb
	 KwHgIqkpQoZYg==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uKtHNLXw5Yo0; Tue,  3 Nov 2026 01:01:52 +0100 (CET)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id BF566A19CF;
	Tue,  3 Nov 2026 01:01:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1793664112; bh=FR9BdfIPet+wsXALxuOljIqmtFwuv+RXJsRp/4Tpa9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LEKbekM5QNyvjUbtdp9E9h5FgB3hdZ311L+wyOb9UgOOUFUpPAfDOjMka+tOrkLfe
	 1g1lPe5xZRyRRjyWW5kCptbKTJSHqelB1AdinKMrzHtDLiUCBnGL1qgmuQh2gQjJrx
	 fO+I+2Pr4CSTudqFPFcmdxos773PfnPE7df649Nkt+b1L0nWEdHE0SdKRyoArmK05z
	 sbrvcwkGnvLUIyeEUY60Er4WLKUipf7DwqDw1hU3QMZhXGMVbOR4cdfMg8Kz+2qtLc
	 /rv4IcYAIzo4qkqOMZXpMj8nWdLMly1d7IOSxpc837XKS8/7389riWJ+6owW07YNbb
	 KwHgIqkpQoZYg==
Received: from samy by end with local (Exim 4.100.1)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1xO1yI-000000037Vj-3zIo;
	Tue, 03 Nov 2026 01:01:50 +0100
Date: Tue, 3 Nov 2026 01:01:50 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
	w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] speakup: Serialize synth clearing against locked
 readers
Message-ID: <aukkbqLJLzjGy9e8@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	chris@the-brannons.com, kirk@reisers.ca, w.d.hubbs@gmail.com,
	stable@vger.kernel.org
References: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
 <20261014071713.321914-5-xiehongyu1@kylinos.cn>
 <atUgm3nwEQrJibxn@end>
 <179363263139.43100.8043437977710970575@kylinos.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179363263139.43100.8043437977710970575@kylinos.cn>
Organization: I am not organized

Hello,

Hongyu Xie, le lun. 02 nov. 2026 23:17:11 +0800, a ecrit:
> speakup_key() validates the global synth pointer before taking
> speakup_info.spinlock, but do_spkup() and its handlers run inside
> that lock and dereference synth: speech_kill() calls
> synth->is_alive(), and the flush path reaches synth_start()
> reading synth->alive.  synth_release() clears synth under
> spk_mutex, which does not serialize against the key path, so a
> speakup key pressed while the synth is being removed can pass the
> unlocked check and oops on the stale pointer:
> 
>     CPU0 (speakup key)             CPU1 (rmmod -> synth_release)
>     ------------------             ----------------------------
>     speakup_key():
>       if (!synth)                  mutex_lock(&spk_mutex)
>         return 0  /* passes */     synth_release():
>     spin_lock(&speakup_info.         synth->alive = 0   (spinlock)
>         spinlock)                   ... drain in-flight catch_up() ...
>                                     synth->release(synth)
>     do_spkup():
>       speech_kill():
>         synth->is_alive()
>         /* dereferences a synth whose release() has
>            already torn down its I/O */
> 
> Closing this window needs both sides of the race:
> 
> - Recheck synth at do_spkup() entry, inside the lock, so the whole
>   handler table runs only while a synth is still registered.
>   speakup_con_write() and speakup_con_update() used to gate on synth
>   before their trylock; they now recheck it after acquiring the lock
>   instead, so these readers no longer validate outside the critical
>   section that dereferences.
> 
> - Clear synth under speakup_info.spinlock in synth_release() and
>   in the do_synth_init() probe-failure path, so a clear can never
>   land between a locked reader's check and its dereference.
> 
> With the check and the clear under the same lock they are
> mutually exclusive for these paths, instead of merely close
> together:
> 
>     CPU0 (speakup key)             CPU1 (rmmod -> synth_release)
>     ------------------             ----------------------------
>     spin_lock(&speakup_info.       ... drain in-flight catch_up() ...
>         spinlock)                  spin_lock(&speakup_info.spinlock)
>     do_spkup():                    synth = NULL
>       if (!synth)                  spin_unlock(...)
>         return  /* in-lock recheck */
>       speech_kill():
>         synth->is_alive()  /* cannot interleave with a clear */
> 
> The console notifier paths had the same window between the
> pre-trylock check and the in-lock use:
> 
>     CPU0 (vt notifier)             CPU1 (rmmod -> synth_release)
>     ------------------             ----------------------------
>     speakup_con_write():
>       if (!synth)                  (the clear lands between
>         return  /* pre-trylock */    the pre-trylock check
>     spin_trylock(&speakup_info.      and the in-lock use)
>         spinlock)
>     ... uses synth ...  /* stale */
> 
> and now recheck synth after the trylock, in the lock, exactly
> like do_spkup().
> 
> The remaining locked readers had the same window between an
> unlocked check and the in-lock dereference, and gain the same
> recheck:
> 
> - do_handle_shift() and do_handle_spec() used to gate on synth
>   before taking speakup_info.spinlock and dereference it via
>   synth_printf() inside the lock.
> - speakup_key()'s special-handler dispatch dereferences synth
>   inside the lock speakup_key() holds (handle_goto(),
>   edit_bits(), the help handler).
> - synth_direct_store() used to validate synth before the lock
>   while its synth_write() call runs inside it.
> - the /dev/synth and /dev/synthu write paths used to validate
>   synth once before their copy_from_user() loop while every round
>   calls synth_write() (or synth_buffer_add() plus
>   synth_start()) inside the lock.
> 
> With these rechecks the check and the clear are mutually
> exclusive for every reader that dereferences synth inside
> speakup_info.spinlock, and the unlocked synth checks that used
> to gate these paths are dropped: they only duplicate the in-lock
> recheck, with a window a clear can still slip through.  An empty
> write to /dev/synth or /dev/synthu with no synth loaded now
> returns 0 instead of -ENODEV, which is harmless.
> 
> The speakup thread keeps its existing fence: synth_release()
> drains the catch-up count before clearing.
> 
> Two sites of this shape remain, preexisting.  The cursor_done()
> timer callback dereferences synth inside the lock with no synth
> check at all, and closing it needs the cursor_timer lifetime
> handled against synth teardown, which is beyond this series.
> The serial read buffer handler (synth_readbuf_handler()) also
> dereferences synth inside the lock with no synth check.  It
> cannot run in this tree: the only registration chain goes
> through spk_serial_synth_probe(), which has no callers, and
> any registration from outside the tree is still serialized by
> the free_irq() in the serial synth release path, which runs
> before the in-lock clear.
> 
> Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
> Suggested-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> Cc: stable@vger.kernel.org
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!

Samuel

> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
> Changes in v2: per Samuel's review, drop the now-duplicate unlocked
> synth checks on all the paths this patch rechecks inside
> speakup_info.spinlock:
> 
> - speakup_file_write() and speakup_file_writeu() in devsynth.c
> - synth_direct_store() in kobjects.c
> - do_handle_shift() and do_handle_spec(), which now only test
>   up_flag and spk_killed before taking the lock
> - speakup_con_write() and speakup_con_update(), which now only test
>   their other preconditions before the trylock
> - speakup_key(), whose pre-lock entry check is gone; the in-lock
>   recheck returns the same 0 via the existing "goto out"
> 
> The only behavior difference I could find from dropping them is that
> an empty write to /dev/synth or /dev/synthu with no synth loaded now
> returns 0 instead of -ENODEV, which should be harmless.
> 
> Also exercised the in-lock recheck at runtime: with the whole series
> applied in a QEMU boot test, a write through a stale /dev/synth fd
> kept open across the synth removal returns -ENODEV.
> 
>  drivers/accessibility/speakup/devsynth.c | 13 ++++++----
>  drivers/accessibility/speakup/kobjects.c |  8 +++---
>  drivers/accessibility/speakup/main.c     | 31 ++++++++++++++++++------
>  drivers/accessibility/speakup/synth.c    |  4 +++
>  4 files changed, 41 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/devsynth.c b/drivers/accessibility/speakup/devsynth.c
> index e3d909bd0480..5a32d3bbf7b8 100644
> --- a/drivers/accessibility/speakup/devsynth.c
> +++ b/drivers/accessibility/speakup/devsynth.c
> @@ -20,8 +20,6 @@ static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
>  	unsigned long flags;
>  	u_char buf[256];
>  
> -	if (!synth)
> -		return -ENODEV;
>  	while (count > 0) {
>  		bytes = min(count, sizeof(buf));
>  		if (copy_from_user(buf, ptr, bytes))
> @@ -29,6 +27,10 @@ static ssize_t speakup_file_write(struct file *fp, const char __user *buffer,
>  		count -= bytes;
>  		ptr += bytes;
>  		spin_lock_irqsave(&speakup_info.spinlock, flags);
> +		if (!synth) {
> +			spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +			return -ENODEV;
> +		}
>  		synth_write(buf, bytes);
>  		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>  	}
> @@ -47,9 +49,6 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
>  	u16 ubuf[256];
>  	size_t in, out;
>  
> -	if (!synth)
> -		return -ENODEV;
> -
>  	want = 1;
>  	while (count >= want) {
>  		/* Copy some UTF-8 piece from userland */
> @@ -84,6 +83,10 @@ static ssize_t speakup_file_writeu(struct file *fp, const char __user *buffer,
>  		/* And speak this up */
>  		if (out) {
>  			spin_lock_irqsave(&speakup_info.spinlock, flags);
> +			if (!synth) {
> +				spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +				return -ENODEV;
> +			}
>  			for (in = 0; in < out; in++)
>  				synth_buffer_add(ubuf[in]);
>  			synth_start();
> diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
> index e1860f8d9d42..45a8e9fbd8de 100644
> --- a/drivers/accessibility/speakup/kobjects.c
> +++ b/drivers/accessibility/speakup/kobjects.c
> @@ -416,9 +416,6 @@ static ssize_t synth_direct_store(struct kobject *kobj,
>  	char *unescaped;
>  	unsigned long flags;
>  
> -	if (!synth)
> -		return -EPERM;
> -
>  	unescaped = kstrdup(buf, GFP_KERNEL);
>  	if (!unescaped)
>  		return -ENOMEM;
> @@ -426,6 +423,11 @@ static ssize_t synth_direct_store(struct kobject *kobj,
>  	string_unescape_any_inplace(unescaped);
>  
>  	spin_lock_irqsave(&speakup_info.spinlock, flags);
> +	if (!synth) {
> +		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +		kfree(unescaped);
> +		return -EPERM;
> +	}
>  	synth_write(unescaped, strlen(unescaped));
>  	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>  
> diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
> index e9b7c2761f6f..60be4d4df363 100644
> --- a/drivers/accessibility/speakup/main.c
> +++ b/drivers/accessibility/speakup/main.c
> @@ -1166,9 +1166,13 @@ static void do_handle_shift(struct vc_data *vc, u_char value, char up_flag)
>  {
>  	unsigned long flags;
>  
> -	if (!synth || up_flag || spk_killed)
> +	if (up_flag || spk_killed)
>  		return;
>  	spin_lock_irqsave(&speakup_info.spinlock, flags);
> +	if (!synth) {
> +		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +		return;
> +	}
>  	if (cursor_track == read_all_mode) {
>  		switch (value) {
>  		case KVAL(K_SHIFT):
> @@ -1763,11 +1767,15 @@ static void speakup_con_write(struct vc_data *vc, u16 *str, int len)
>  {
>  	unsigned long flags;
>  
> -	if ((vc->vc_num != fg_console) || spk_shut_up || !synth)
> +	if ((vc->vc_num != fg_console) || spk_shut_up)
>  		return;
>  	if (!spin_trylock_irqsave(&speakup_info.spinlock, flags))
>  		/* Speakup output, discard */
>  		return;
> +	if (!synth) {
> +		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +		return;
> +	}
>  	if (spk_bell_pos && spk_keydown && (vc->state.x == spk_bell_pos - 1))
>  		bleep(3);
>  	if ((is_cursor) || (cursor_track == read_all_mode)) {
> @@ -1792,11 +1800,15 @@ static void speakup_con_update(struct vc_data *vc)
>  {
>  	unsigned long flags;
>  
> -	if (!speakup_console[vc->vc_num] || spk_parked || !synth)
> +	if (!speakup_console[vc->vc_num] || spk_parked)
>  		return;
>  	if (!spin_trylock_irqsave(&speakup_info.spinlock, flags))
>  		/* Speakup output, discard */
>  		return;
> +	if (!synth) {
> +		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +		return;
> +	}
>  	speakup_date(vc);
>  	if (vc->vc_mode == KD_GRAPHICS && !spk_paused && spk_str_pause[0]) {
>  		synth_printf("%s", spk_str_pause);
> @@ -1811,9 +1823,13 @@ static void do_handle_spec(struct vc_data *vc, u_char value, char up_flag)
>  	int on_off = 2;
>  	char *label;
>  
> -	if (!synth || up_flag || spk_killed)
> +	if (up_flag || spk_killed)
>  		return;
>  	spin_lock_irqsave(&speakup_info.spinlock, flags);
> +	if (!synth) {
> +		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +		return;
> +	}
>  	spk_shut_up &= 0xfe;
>  	if (spk_no_intr)
>  		spk_do_flush();
> @@ -2087,6 +2103,8 @@ static spkup_hand spkup_handler[] = {
>  
>  static void do_spkup(struct vc_data *vc, u_char value)
>  {
> +	if (!synth)
> +		return;
>  	if (spk_killed && value != SPEECH_KILL)
>  		return;
>  	spk_keydown = 0;
> @@ -2115,10 +2133,9 @@ speakup_key(struct vc_data *vc, int shift_state, int keycode, u16 keysym,
>  	u_char shift_info, offset;
>  	int ret = 0;
>  
> -	if (!synth)
> -		return 0;
> -
>  	spin_lock_irqsave(&speakup_info.spinlock, flags);
> +	if (!synth)
> +		goto out;
>  	tty = vc->port.tty;
>  	if (type >= 0xf0)
>  		type -= 0xf0;
> diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
> index 1af80eb116af..aef482f8b14e 100644
> --- a/drivers/accessibility/speakup/synth.c
> +++ b/drivers/accessibility/speakup/synth.c
> @@ -519,7 +519,9 @@ static int do_synth_init(struct spk_synth *in_synth)
>  	pr_warn("synth probe\n");
>  	if (synth->probe(synth) < 0) {
>  		pr_warn("%s: device probe failed\n", in_synth->name);
> +		spin_lock_irqsave(&speakup_info.spinlock, flags);
>  		synth = NULL;
> +		spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>  		return -ENODEV;
>  	}
>  	synth_time_vars[0].u.n.value =
> @@ -585,7 +587,9 @@ void synth_release(void)
>  	for (var = synth->vars; var->var_id != MAXVARS; var++)
>  		speakup_unregister_var(var->var_id);
>  	synth->release(synth);
> +	spin_lock_irqsave(&speakup_info.spinlock, flags);
>  	synth = NULL;
> +	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>  }
>  
>  /* called by: all_driver_init() */
> -- 
> 2.32.0
> 

-- 
Samuel
 Les roots ne sont plus ce qu'ils étaient...Maintenant il sont dioxinés,
 c'est de la m... ! Avant on les élevaient avec du bon unix mais ça été
 remplacé par des farines industrielles nouvelles technologies (NT).
 -+- JdK in NPC : Exigez un root élevé sous la mère ! -+-
