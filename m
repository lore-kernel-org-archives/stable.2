Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=140.77.166.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793664995;
	b=dj+j/uWI/SJ2eh2YCQnBjwThyYjkuEXQVVFGjxvug0MDbWp68ZH11E1+1WJbslv0zx01
	 9PHWN4gtWC7/qN+yDsS2AGQ7ohnHKH4MimCSOYNUsdGSaN0pqC7/OyMzkO9ctteSrhO2j
	 cNK6CLHXMMJG9ipcO/c7nUNccHzqvMqaFBaiA5m0vj43IAG9YvCkgJpYhhd33+/BGajJh
	 jxhKiUcQ1iLzSFpPCwyGDTXJqEfMSuEWG+On7zfC9+77bwNRoWQ1lLtYOiwL1I7rZ4Vd0
	 bS9DVAM502A1r7IQYA/f7RZdz5KhmKVXO2JuntKpLYzWuVXiv8hSm6H4+c/FZEauT4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793664995;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6mxkcTLzdhcSubKZ6UueTZr0v+3R978UXXFN8B9+Bjg=;
	b=Ogex1KSVyDZ9QD6tOYdyUcHOlGiOA+3HQcXFwCnhPSRLGGro8A/e2cUxBkU1HhE56I+V
	 9Sj5B+2Q2/4b2vQWxTAFxUo21XjVbVXCVgkjjWtSIdaHvalZsE2qaukpZ4t7QdyiDHWPN
	 tXS21rwM5vtVygqvtRyj/p7ErEFsCeXtQaM5MXi2bYeASO9o6YZ8i/gZXiXzIuaL44qGc
	 CH6HriJkG9IYJimVr2Xn05v+9ZZ6waD4FN5gXR/Vq3jHrWDUP+IJgCklMw5dejaM91Vr3
	 TxT+qFRQIWRLuvLjlmCEBcfiusF7PTI0Tx3cjrBnJ5qtiaQL8LDBQ+ijQkfDSznEtpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ens-lyon.org;
	spf=pass smtp.mailfrom=bounce.ens-lyon.org;
	dkim=pass header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=J+sXuOaQ;
	dkim=pass header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=J+sXuOaQ;
	arc=none smtp.remote-ip=140.77.166.138
Received: from sonata.ens-lyon.org (sonata.ens-lyon.org [140.77.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A4D606A32E;
	Tue,  3 Nov 2026 00:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17A4D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce.ens-lyon.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=J+sXuOaQ;
	dkim=pass (2048-bit key) header.d=ens-lyon.org header.i=@ens-lyon.org header.a=rsa-sha256 header.s=dkim header.b=J+sXuOaQ
Received: from localhost (localhost [127.0.0.1])
	by sonata.ens-lyon.org (Postfix) with ESMTP id 33AECA1C5B;
	Tue,  3 Nov 2026 01:16:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1793664993; bh=BScFtQxVrsmgAGnjF0Ws2H5L9aXigMG3YyjEoVhyYCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+sXuOaQn/qvTDfO2JcCsslzmrK91aD99XiPEayHqHXZ/+oFTJewnD2dsKu3+cpo0
	 UHhRdMs1SG/wrhld2gifG553f/Ive4lbjDjdRcwLkfbFHH+pAgbf6/zjsbVn1nvugx
	 gIAM+bbzYIAUeQRGYQspu4UzyoLjFlbjGwITu2dfhmfl3pw9jGwwPMJASqGgFS1Hpt
	 x2ZmdQRVWUJfA82mITw61krdN5kzOq3Fj4uFYzNRKgw/CY/WUZ+UM6jpZkEWhgslpA
	 qJ3grv5GYG0hCsn7iqj5MNHCP9rGqdYCMSRMg8rCGXPgnt9g5X9T2WZCk/Oj9s+Ca6
	 qFmf024dmsAqw==
Received: from sonata.ens-lyon.org ([127.0.0.1])
	by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KfRuxrPmIW5j; Tue,  3 Nov 2026 01:16:33 +0100 (CET)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by sonata.ens-lyon.org (Postfix) with ESMTPSA id D88FFA1C35;
	Tue,  3 Nov 2026 01:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
	t=1793664993; bh=BScFtQxVrsmgAGnjF0Ws2H5L9aXigMG3YyjEoVhyYCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J+sXuOaQn/qvTDfO2JcCsslzmrK91aD99XiPEayHqHXZ/+oFTJewnD2dsKu3+cpo0
	 UHhRdMs1SG/wrhld2gifG553f/Ive4lbjDjdRcwLkfbFHH+pAgbf6/zjsbVn1nvugx
	 gIAM+bbzYIAUeQRGYQspu4UzyoLjFlbjGwITu2dfhmfl3pw9jGwwPMJASqGgFS1Hpt
	 x2ZmdQRVWUJfA82mITw61krdN5kzOq3Fj4uFYzNRKgw/CY/WUZ+UM6jpZkEWhgslpA
	 qJ3grv5GYG0hCsn7iqj5MNHCP9rGqdYCMSRMg8rCGXPgnt9g5X9T2WZCk/Oj9s+Ca6
	 qFmf024dmsAqw==
Received: from samy by end with local (Exim 4.100.1)
	(envelope-from <samuel.thibault@ens-lyon.org>)
	id 1xO2CW-000000038NE-1Ftr;
	Tue, 03 Nov 2026 01:16:32 +0100
Date: Tue, 3 Nov 2026 01:16:32 +0100
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Hongyu Xie <xiehongyu1@kylinos.cn>
Cc: speakup@linux-speakup.org, linux-kernel@vger.kernel.org,
	gregkh@linuxfoundation.org, chris@the-brannons.com, kirk@reisers.ca,
	w.d.hubbs@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH 2/4] speakup: Do not hold spk_mutex across catch_up()
Message-ID: <aukn4DETg3_Nk9_f@end>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Hongyu Xie <xiehongyu1@kylinos.cn>, speakup@linux-speakup.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	chris@the-brannons.com, kirk@reisers.ca, w.d.hubbs@gmail.com,
	stable@vger.kernel.org
References: <20261014071713.321914-1-xiehongyu1@kylinos.cn>
 <20261014071713.321914-3-xiehongyu1@kylinos.cn>
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
In-Reply-To: <20261014071713.321914-3-xiehongyu1@kylinos.cn>
Organization: I am not organized

Hello,

Hongyu Xie, le mer. 14 oct. 2026 15:17:11 +0800, a ecrit:
> speakup_thread() holds spk_mutex while calling synth->catch_up().
> Apart from the indefinite retry loops fixed by the previous patch, a
> synth that digests its buffer slowly (e.g. a real speech synthesizer
> receiving a large chunk of text) keeps the mutex held for the whole
> drain, so loading, unloading or switching any synth module blocks
> until all pending speech has been output, which may take arbitrarily
> long.
> 
> Take spk_mutex off the catch_up() call path and keep the synth alive
> for the duration of the call instead:
> 
> - speakup_thread() raises a catch-up count and releases spk_mutex
>   before calling catch_up(), re-taking it afterwards.
> 
> - synth_release() first clears synth->alive (which makes catch_up()
>   return) and wakes the thread out of its sleep, then waits for the
>   catch-up count to drop to zero before releasing the synth resources
>   (sysfs attributes, variables, tty).  The synth buffer is cleared
>   there as well, so a switch discards the text that was still pending
>   for the old synth; previously a switch would first wait for that
>   text to be output by the old synth, which is the unbounded wait
>   this patch removes.  As synth_remove() only returns after the
>   drain, a synth module cannot be unloaded while catch_up() still
>   runs, so the synth structure and its tty stay valid for the whole
>   call without any module reference counting.
> 
> The count/wait handoff between the thread and the release looks
> like this (without it, the resources could be freed while
> catch_up() still runs):
> 
>     CPU0 (speakup_thread)          CPU1 (synth_release)
>     -------------------            -------------------
>     atomic_inc(&synth_catch_up_count)
>     mutex_unlock(&spk_mutex)
>     synth->catch_up(synth)
>       /* reads synth->alive,       spin_lock(&speakup_info.spinlock)
>          synth->io_ops, the tty */  synth->alive = 0
>                                    spin_unlock(...)
>                                    wake the thread out of its sleep
>                                    wait_event(!synth_catch_up_count)
>                                    /* resources stay valid: sysfs,
>                                       vars, tty are torn down only
>                                       after the count hits zero */
>       /* returns once ->alive
>          is 0 (loop exit of the
>          previous patch) */
>     atomic_dec_and_test(...)
>       wake_up(&synth_catch_up_waitq)
>                                    sysfs_remove_group(...)
>                                    speakup_unregister_var(...)
>                                    synth->release(synth)
>                                    /* patch 4 clears synth itself
>                                       under the spinlock */
> 
> The SPEECH_KILL key handler can revive the synth at any time: it
> runs under speakup_info.spinlock (speakup_key() holds it across
> do_spkup()), and the is_alive callbacks set synth->alive back to 1
> and queue the init string again.  If that lands after
> synth_release() cleared synth->alive, an in-flight catch_up()
> draining to a stuck synth never sees ->alive cleared, and
> synth_release() blocks forever on the catch-up count:
> 
>     CPU0 (SPEECH_KILL key)         CPU1 (synth_release)
>     ----------------------         -------------------
>                                    spin_lock(&speakup_info.spinlock)
>                                    synth->alive = 0
>                                    spin_unlock(...)
>     spk_synth_is_alive_restart():
>       /* under the same spinlock
>          via speakup_key() */
>       synth->alive = 1  /* revival */
>       /* catch_up() rechecks         wait_event(!synth_catch_up_count)
>          ->alive, sees 1 again */    /* never: the revival keeps the
>                                          loop running */
> 
> Mark the synth with ->releasing under speakup_info.spinlock while it
> is being released, and have both spk_synth_is_alive_restart() and
> spk_synth_is_alive_nop() skip the revival then, so the drain always
> terminates:
> 
>     CPU0 (SPEECH_KILL key)         CPU1 (synth_release)
>     ----------------------         -------------------
>                                    spin_lock(&speakup_info.spinlock)
>                                    synth->alive = 0
>                                    synth->releasing = true
>                                    spin_unlock(...)
>     spk_synth_is_alive_restart():
>       if (synth->releasing)
>         return 0  /* no revival */  wait_event(!synth_catch_up_count)
>       /* the catch_up() loop          /* terminates: the loop
>          exits on ->alive == 0           observes ->alive == 0 */
> 
> The other wake_up_process(speakup_task) sites (spk_do_flush(),
> do_synth_init()) get the same guard: the speakup keyboard notifier is
> registered before the kthread is created, so a speakup key press or a
> sysfs write in that window would otherwise pass NULL (or the
> kthread_create() error) to wake_up_process():
> 
>     CPU0 (speakup key / sysfs)     CPU1 (module exit)
>     --------------------------     -----------------
>     spk_do_flush():
>       wake_up_process(
>         speakup_task)              speakup_exit():
>       /* speakup_task is NULL         ... kthread_stop(speakup_task)
>          before kthread_create(),        /* task_struct freed */
>          ERR_PTR after a failure */   speakup_task = NULL;
>       /* wakeup on NULL / ERR_PTR,
>          or on freed memory */
> 
> The wakeup sites take the task pointer under rcu_read_lock(), so
> the task_struct cannot be freed underneath them by a concurrent
> module exit either:
> 
>     spk_do_flush():
>       rcu_read_lock();
>       task = READ_ONCE(speakup_task);
>       if (!IS_ERR_OR_NULL(task))
>         wake_up_process(task);
>       rcu_read_unlock();
>       /* the exit path unregisters the notifiers first, and
>          atomic_notifier_chain_unregister() synchronizes with
>          the RCU readers, so by the time speakup_task is
>          cleared no wakeup site is still running */
> 
> After this change spk_mutex no longer serializes synth registration,
> unregistration and switching against speech output.
> 
> This depends on the previous patch: the catch-up drain introduced
> here assumes that catch_up() eventually returns once synth->alive has
> been cleared, including in the local catch_up() copies of the serial
> synth drivers.
> 
> Fixes: 2067fd92d75b6 ("staging/speakup: Move out of staging")
> Cc: stable@vger.kernel.org
> Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

Reviewed-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Thanks!


Samuel

> Signed-off-by: Hongyu Xie <xiehongyu1@kylinos.cn>
> ---
>  drivers/accessibility/speakup/spk_priv.h  |  3 ++
>  drivers/accessibility/speakup/spk_types.h |  1 +
>  drivers/accessibility/speakup/synth.c     | 59 +++++++++++++++++++++--
>  drivers/accessibility/speakup/thread.c    | 11 ++++-
>  4 files changed, 70 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/spk_priv.h b/drivers/accessibility/speakup/spk_priv.h
> index 9da57ead17cbe..967862cd04403 100644
> --- a/drivers/accessibility/speakup/spk_priv.h
> +++ b/drivers/accessibility/speakup/spk_priv.h
> @@ -75,6 +75,9 @@ struct spk_synth *synth_current(void);
>  
>  extern struct speakup_info_t speakup_info;
>  
> +extern atomic_t synth_catch_up_count;
> +extern wait_queue_head_t synth_catch_up_waitq;
> +
>  extern struct var_t synth_time_vars[];
>  
>  extern struct spk_io_ops spk_serial_io_ops;
> diff --git a/drivers/accessibility/speakup/spk_types.h b/drivers/accessibility/speakup/spk_types.h
> index a5762330e2495..efb931db18506 100644
> --- a/drivers/accessibility/speakup/spk_types.h
> +++ b/drivers/accessibility/speakup/spk_types.h
> @@ -200,6 +200,7 @@ struct spk_synth {
>  	unsigned char (*get_index)(struct spk_synth *synth);
>  	struct synth_indexing indexing;
>  	int alive;
> +	bool releasing;	/* set while synth_release() drains this synth */
>  	struct attribute_group attributes;
>  
>  	void *dev;
> diff --git a/drivers/accessibility/speakup/synth.c b/drivers/accessibility/speakup/synth.c
> index 6a49ff475c16a..40870949b3c6b 100644
> --- a/drivers/accessibility/speakup/synth.c
> +++ b/drivers/accessibility/speakup/synth.c
> @@ -24,6 +24,14 @@ char spk_pitch_buff[32] = "";
>  static int module_status;
>  bool spk_quiet_boot;
>  
> +/*
> + * Number of catch_up() calls currently in flight, and waitqueue used by
> + * synth_release() to wait for them to finish before tearing down the
> + * synth resources they may still be using.
> + */
> +atomic_t synth_catch_up_count = ATOMIC_INIT(0);
> +DECLARE_WAIT_QUEUE_HEAD(synth_catch_up_waitq);
> +
>  struct speakup_info_t speakup_info = {
>  	/*
>  	 * This spinlock is used to protect the entire speakup machinery, and
> @@ -154,6 +162,8 @@ EXPORT_SYMBOL_GPL(spk_synth_get_index);
>  
>  int spk_synth_is_alive_nop(struct spk_synth *synth)
>  {
> +	if (synth->releasing)
> +		return 0;
>  	synth->alive = 1;
>  	return 1;
>  }
> @@ -163,6 +173,18 @@ int spk_synth_is_alive_restart(struct spk_synth *synth)
>  {
>  	if (synth->alive)
>  		return 1;
> +	/*
> +	 * The callers run under speakup_info.spinlock (speakup_key()
> +	 * holds it across do_spkup()), which is also the lock
> +	 * synth_release() takes to clear ->alive, so checking
> +	 * ->releasing here cannot race it: a synth being released is
> +	 * not revived, or an in-flight catch_up() draining to a stuck
> +	 * synth would never see ->alive cleared and synth_release()
> +	 * would block forever on the catch-up count while holding
> +	 * spk_mutex.
> +	 */
> +	if (synth->releasing)
> +		return 0;
>  	if (synth->io_ops->wait_for_xmitr(synth) > 0) {
>  		/* restart */
>  		synth->alive = 1;
> @@ -197,6 +219,8 @@ void synth_start(void)
>  
>  void spk_do_flush(void)
>  {
> +	struct task_struct *task;
> +
>  	if (!synth)
>  		return;
>  
> @@ -209,7 +233,11 @@ void spk_do_flush(void)
>  		}
>  	}
>  	wake_up_interruptible_all(&speakup_event);
> -	wake_up_process(speakup_task);
> +	rcu_read_lock();
> +	task = READ_ONCE(speakup_task);
> +	if (!IS_ERR_OR_NULL(task))
> +		wake_up_process(task);
> +	rcu_read_unlock();
>  }
>  
>  void synth_write(const char *_buf, size_t count)
> @@ -476,13 +504,18 @@ int synth_init(char *synth_name)
>  /* called by: synth_add() */
>  static int do_synth_init(struct spk_synth *in_synth)
>  {
> +	struct task_struct *task;
>  	struct var_t *var;
> +	unsigned long flags;
>  
>  	synth_release();
>  	if (in_synth->checkval != SYNTH_CHECK)
>  		return -EINVAL;
>  	synth = in_synth;
>  	synth->alive = 0;
> +	spin_lock_irqsave(&speakup_info.spinlock, flags);
> +	synth->releasing = false;
> +	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
>  	pr_warn("synth probe\n");
>  	if (synth->probe(synth) < 0) {
>  		pr_warn("%s: device probe failed\n", in_synth->name);
> @@ -510,13 +543,17 @@ static int do_synth_init(struct spk_synth *in_synth)
>  		return -ENOMEM;
>  	synth_flags = synth->flags;
>  	wake_up_interruptible_all(&speakup_event);
> -	if (speakup_task)
> -		wake_up_process(speakup_task);
> +	rcu_read_lock();
> +	task = READ_ONCE(speakup_task);
> +	if (!IS_ERR_OR_NULL(task))
> +		wake_up_process(task);
> +	rcu_read_unlock();
>  	return 0;
>  }
>  
>  void synth_release(void)
>  {
> +	struct task_struct *task;
>  	struct var_t *var;
>  	unsigned long flags;
>  
> @@ -525,8 +562,24 @@ void synth_release(void)
>  	spin_lock_irqsave(&speakup_info.spinlock, flags);
>  	pr_info("releasing synth %s\n", synth->name);
>  	synth->alive = 0;
> +	synth->releasing = true;
>  	timer_delete(&thread_timer);
> +	synth_buffer_clear();
>  	spin_unlock_irqrestore(&speakup_info.spinlock, flags);
> +	/*
> +	 * catch_up() may still be running without spk_mutex held (it gets
> +	 * taken off the mutex by speakup_thread()).  Wake it out of its
> +	 * sleep and wait until it is done before releasing the resources
> +	 * (sysfs, variables, tty) it may be accessing.  speakup_task can
> +	 * be an ERR_PTR here, when speakup_init() failed after the
> +	 * command-line synth_init().
> +	 */
> +	rcu_read_lock();
> +	task = READ_ONCE(speakup_task);
> +	if (!IS_ERR_OR_NULL(task))
> +		wake_up_process(task);
> +	rcu_read_unlock();
> +	wait_event(synth_catch_up_waitq, !atomic_read(&synth_catch_up_count));
>  	if (synth->attributes.name)
>  		sysfs_remove_group(speakup_kobj, &synth->attributes);
>  	for (var = synth->vars; var->var_id != MAXVARS; var++)
> diff --git a/drivers/accessibility/speakup/thread.c b/drivers/accessibility/speakup/thread.c
> index 2fc75e60fbac2..5279e112248b4 100644
> --- a/drivers/accessibility/speakup/thread.c
> +++ b/drivers/accessibility/speakup/thread.c
> @@ -50,9 +50,18 @@ int speakup_thread(void *data)
>  		if (synth && synth->catch_up && synth->alive) {
>  			/*
>  			 * It is up to the callee to take the lock, so that it
> -			 * can sleep whenever it likes
> +			 * can sleep whenever it likes.  It may indeed sleep for
> +			 * a long while, e.g. while draining to a slow synth, so
> +			 * run it without spk_mutex: synth_release() waits for
> +			 * the catch-up count to drop before freeing the synth,
> +			 * hence the synth stays alive for the whole call.
>  			 */
> +			atomic_inc(&synth_catch_up_count);
> +			mutex_unlock(&spk_mutex);
>  			synth->catch_up(synth);
> +			if (atomic_dec_and_test(&synth_catch_up_count))
> +				wake_up(&synth_catch_up_waitq);
> +			mutex_lock(&spk_mutex);
>  		}
>  
>  		speakup_start_ttys();
> -- 
> 2.25.1
> 

-- 
Samuel
We are Pentium of Borg. Division is futile. You will be approximated.
(seen in someone's .signature)
