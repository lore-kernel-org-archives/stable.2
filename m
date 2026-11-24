Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795556326;
	b=Trlj3ss+anp/e5sk2WZm0xZTZocaxpqfhmRYFXG/O2uthJSCcsCpTZDml+jtr7yL9bor
	 uyEHJJOvFGjsnVghrTqslj/K+JJscOARgkb1VvgvmdYdn1gLIuK/aUzWr3+XfuLHPpMkY
	 i64N1UL4DQFfyt2YHHc6OsM+E7lqgpWeK0uCvkWPQAAQ60k/TQW4/4kNHimCH3dETSJ6o
	 sYOZnbD9vOXWDHURdVeMXhdtTuNpLnYZOcsqsKQCcEAjp2buuTr+311KhMQbF/KwH+6xn
	 s8rPkcNN5CD5C8QX8mwRTpjS5GDOw4uiJa7F75u63LUjbFCoUGT4+DW9dePj6pCuWzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795556326;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=AFWQM/ayVfLWcrTdIVoMV9feWq7JxicreTRydRV9/s8=;
	b=4b2cVcHBUcwaZqlDZi0J6fD1ryAX02grkiWrsSjmg/1JzrNbM8XO1FYJz4H8/85BKAE+
	 wV6TDBOETyJ0Nq0garMwS2sp/3l8JhNovNS74dKK+komn5FbBV7SIOg3Ef2itU7Qv1C40
	 xjfdu9uKmKHtobBHbCDFAgHDFJDMkm7Ur4na8YHa8FX/hAnq9rb5lLChh85YmzQjxETjw
	 NKZcS+9C5oYWKsf2a0IlfWBvRiHj/n2So6QekunR+10+jpBLLPf9PTdZmsG9kplt0eXPp
	 WKl9DM6co7QpHx96KkfcfCrSkKtoURIpw2GKIv3y+P9DN3pIoNcL/2iblq5O6Jdf2eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDCxueI8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25DB606A68F;
	Tue, 24 Nov 2026 21:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oDCxueI8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F941F000E1;
	Tue, 24 Nov 2026 21:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795556326;
	bh=AFWQM/ayVfLWcrTdIVoMV9feWq7JxicreTRydRV9/s8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=oDCxueI8fo43C72o5hrQwU9UzrMnJhUaymgEwGotgJ75Ef54xTnOoWzObgfgAIqeI
	 5Q1sb67Szyo27VAP1wP5ASceIHDRpxOfr4UjupEMiD2jqbeO+/2UFYcG372la0QH6Z
	 FrddEyIlxFbXIaBVOiH7TxLmJOjcG4Ze4vS+tuHS0r84b6szcbmsE4Wa22cuwKgDb0
	 yfPoWMdktYaUjnDB6DT6Lu+mGZodPqurWM/20WoBvurdyLOMvmXmtD6+UGMHGyGYw6
	 lyjH4M7wk+TIGgn3A5o4F8tE/Ax/9cLteX336RAUzSOrO2IrTDDV9fG0WBzEtQ2sCh
	 3KyJj1HOGa7tw==
Subject: Re: [PATCH net v4 3/4] igb: link queues to NAPIs under RTNL after
 runtime resume
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 janislacis06@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 24 Nov 2026 21:38:45 +0000
Message-ID: <179555632542.3135.3194340362837900458@kernel.org>
In-Reply-To: <20261120210134.133238-4-antonio@mandelbit.com>
References: <20261120210134.133238-4-antonio@mandelbit.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] igb_rtnl_resume_task() now calls igb_link_queue_napis(), which
  reads adapter->num_q_vectors and dereferences adapter->q_vector[i]…

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but igc has the
  same bug.

--

igb: link queues to NAPIs under RTNL after runtime resume

This patch stops __igb_open() from calling netif_queue_set_napi() when
RTNL isn't held, which is the case on runtime resume. The queues are
linked to their NAPIs from igb_rtnl_resume_task() instead, and that work
item uses an __IGB_DOWN check under RTNL to decide the q_vectors are valid.

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 6b299a1429a8e..4617aba5759d2 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4125,8 +4125,18 @@ static int igb_sw_init(struct igb_adapter *adapter)
>  	return 0;
>  }
>  
> +static void igb_link_queue_napis(struct igb_adapter *adapter)
> +{
> +	int i;
> +
> +	for (i = 0; i < adapter->num_q_vectors; i++)
> +		igb_set_queue_napi(adapter, i, &adapter->q_vector[i]->napi);
> +}
> +
>  /* Some settings need RTNL, which isn't held when resuming from runtime
> - * suspend: apply them from here instead, if the device is still up.
> + * suspend: apply them from here instead, if the device is still up. The
> + * q_vectors are only freed while __IGB_DOWN is set, which is cleared once
> + * they are allocated again, so checking it under RTNL is safe.
>   */
>  static void igb_rtnl_resume_task(struct work_struct *work)
>  {
> @@ -4141,6 +4151,7 @@ static void igb_rtnl_resume_task(struct work_struct *work)
>  					      adapter->num_rx_queues))
>  			netdev_err(adapter->netdev,
>  				   "error setting real queue count\n");
> +		igb_link_queue_napis(adapter);
>  	}
>  	rtnl_unlock();
>  }

[Severity: Medium]

Is checking __IGB_DOWN under RTNL enough to make the q_vector accesses in
igb_link_queue_napis() safe? The free paths all hold RTNL, but on runtime
resume the publish side does not:

igb_runtime_resume()
  __igb_resume(dev, rpm=true)
    igb_init_interrupt_scheme()   /* stores num_q_vectors, q_vector[i] */
    __igb_open(netdev, true, false)
      clear_bit(__IGB_DOWN, &adapter->state);
    schedule_work(&adapter->rtnl_resume_task);

None of this runs under RTNL, and clear_bit() has no release ordering.

Also, nothing cancels or flushes rtnl_resume_task on runtime suspend.
__igb_shutdown() frees the q_vectors under RTNL, but the only
cancel_work_sync(&adapter->rtnl_resume_task) is in igb_remove().

That means a work instance queued by one runtime resume could still be
pending, or waiting on rtnl_lock(), when the next runtime suspend runs
after the autosuspend delay. It could then still be waiting when the next
RTNL-less runtime resume runs.

Once the work gets RTNL, its loads of num_q_vectors and q_vector[i] are
ordered after the relaxed test_bit() only by a control dependency. A
control dependency doesn't order load->load on arm64 or POWER.

Could the work then see __IGB_DOWN clear and the new num_q_vectors, but a
stale NULL or freed q_vector[i]? If so, it would oops in
igb_set_queue_napi() when it reads q_vector->rx.ring.

This seems unlikely in practice, since the q_vector stores happen well
before clear_bit(). Still, would either of these make the claim in the
comment hold?

- A cancel_work_sync(&adapter->rtnl_resume_task) in the runtime suspend
  path before rtnl_lock().
- An smp_mb__before_atomic() before clear_bit(), paired with
  test_bit_acquire() in igb_rtnl_resume_task().

[ ... ]

> @@ -4219,7 +4230,8 @@ static int __igb_open(struct net_device *netdev, bool resuming,
>  	for (i = 0; i < adapter->num_q_vectors; i++) {
>  		napi = &adapter->q_vector[i]->napi;
>  		napi_enable(napi);
> -		igb_set_queue_napi(adapter, i, napi);
> +		if (rtnl_held)
> +			igb_set_queue_napi(adapter, i, napi);
>  	}

[Severity: Medium]

This isn't a bug introduced by this patch, but igc appears to have the
same problem. igc_runtime_resume() calls __igc_resume(dev, true), which
only takes RTNL when !rpm:

drivers/net/ethernet/intel/igc/igc_main.c:__igc_resume() {
    ...
	if (netif_running(netdev)) {
		if (!rpm)
			rtnl_lock();
		err = __igc_open(netdev, true);
    ...
}

__igc_open() still links the queues unconditionally:

	for (i = 0; i < adapter->num_q_vectors; i++) {
		napi = &adapter->q_vector[i]->napi;
		napi_enable(napi);
		igc_set_queue_napi(adapter, i, napi);
	}

Wouldn't igc_set_queue_napi()->netif_queue_set_napi() trigger the same
"RTNL: assertion failed" splat on every runtime resume while the interface
is up?

The note about igc is below the --- line, so it won't be in the commit
log. Is a separate igc fix still planned?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120210134.133238-1-antonio%40mandelbit.com
