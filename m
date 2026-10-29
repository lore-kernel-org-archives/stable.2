Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288805;
	b=cJaOO900qkB9hi+WS+22+7dzpKhp4ty5q4CvoG84Mfhv3JI4mCE/7k23p84kUkSQzVJL
	 nNz+LTuMp3C04hOVvBAIVMjWvWR407FEWQH2Vf4tjJ8c0P3mDiq9WEK+V5R4rY45dlYRv
	 sck2X+mTHa5I0usii+jec1bJI9aWQTZRNafo9xaT2nwXbr27E9fCyxDb/3Vrwem/d4IYV
	 CzqwQxLepYbWyeGvJzKI4JZa1cJioYkDoStDHGkzuwmpreXgrzGGGeb4yTtUMc8PsDXc0
	 HfOTJmeW2u7sxYPityIkWs0mriKN+YZtuYsnnCxDw1EWGp5jEDRDBQ0KAsSmQbGYXSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288805;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=H5ui1SwYsBqG5dQjlH/tXv7W7g93TWtSjdulTpaHSwA=;
	b=vknnGn3mY7j0XbPMe/iFYhPS8XjgCFlPhJTFQh7Ca17tzsMPhESrZ6U6gELnC1uYUQ0P
	 6f47yYwmIN6Fiy9DcF/PaZToPa07p0kt6q/m/Ax0ams50mKqjZ1lesOCH3BvazpM4Meft
	 lO1JmoHclUYU93KPxJ12mBvir1t8CdhcoEs8dPICTsuLQ5lvZb3mMAV/1OO3k90MtBh6m
	 c4DLEVsjoiwglgqTIJtLVFPBo6H383kmaopx32RWC3RwaGtKbjiZ/5npfQieie2TAkPWx
	 ywac2LVkY7V5fdy/S84I+t8D03Ygt6/UKiVNxM2e4DvKQyBmdR4lgdsSwQbxxIXqC5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRaOye5D;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85477606A31A;
	Thu, 29 Oct 2026 15:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VRaOye5D
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD93B1F01816;
	Thu, 29 Oct 2026 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793288805;
	bh=H5ui1SwYsBqG5dQjlH/tXv7W7g93TWtSjdulTpaHSwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VRaOye5DnDQ0N8qvBPQwcec4nB/GlcHez5mdDdAXYiDvmc/6eo/K9KcI3vpmLMCG9
	 n9PryeIhNCHtpJYp+E2JEEcbyqB+Z04HX1dVSbSgroJ8WBlMbzSue3W/+KC2JnkGj5
	 CYQUl1nVbc3KFdJsrx4hK1heNmGGE8cgEHmRLGgVBaGV0dMonh3r/K0jDC/W4rhZuV
	 I2pO7dQK0MzPsFBmdNUQpvbMC8eXz/2kRLsZHMalQN3KefslBG9/Lc/qifLpjmomYb
	 utpWFhwU4xHuXreKRdNekfEBUm6IN0E/+S7wXr8Gw5iW6lzNCb9vTmvtmIcFXJXlgh
	 xCl/kchQy9CPw==
Date: Thu, 29 Oct 2026 15:46:40 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: tristmd@gmail.com, david@ixit.cz, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	linville@tuxdriver.com, sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: Re: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer
 rearm
Message-ID: <20261029154640.GJ257209@horms.kernel.org>
References: <20261023195409.3532540-1-tristmd@gmail.com>
 <179308777133.3134.14547624262445573198@kernel.org>
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
In-Reply-To: <179308777133.3134.14547624262445573198@kernel.org>

On Tue, Oct 27, 2026 at 07:56:11AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 0 · Low: 0
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix is incomplete.
> 
> --
> 
> nfc: llcp: use timer_shutdown_sync to prevent timer rearm
> 
> This commit switches link_timer and sdreq_timer in local_cleanup() from
> timer_delete_sync() to timer_shutdown_sync(). The goal is to stop the
> associated work items from re-arming the timers while cancel_work_sync()
> runs, so that no deferred work runs after kfree(local).
> 
> > diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
> > index 74bf817007cf2..a098d72a15ba8 100644
> > --- a/net/nfc/llcp_core.c
> > +++ b/net/nfc/llcp_core.c
> > @@ -173,14 +173,14 @@ static struct nfc_llcp_local *nfc_llcp_local_get(struct nfc_llcp_local *local)
> >  static void local_cleanup(struct nfc_llcp_local *local)
> >  {
> >  	nfc_llcp_socket_release(local, false, ENXIO);
> > -	timer_delete_sync(&local->link_timer);
> > +	timer_shutdown_sync(&local->link_timer);
> >  	skb_queue_purge(&local->tx_queue);
> >  	cancel_work_sync(&local->tx_work);
> >  	cancel_work_sync(&local->rx_work);
> 
> [Severity: High]
> Does this fully close the use-after-free described in the commit message?
> The timers can no longer be re-armed. But tx_work, rx_work, timeout_work
> and sdreq_timeout_work still use cancel_work_sync(), and that does not
> stop them from being queued again afterwards.
> 
> tx_work is cancelled before rx_work, and nfc_llcp_rx_work() always queues
> tx_work:
> 
> net/nfc/llcp_core.c:nfc_llcp_rx_work() {
>     ...
> 	nfc_llcp_rx_skb(local, skb);
> 
> 	schedule_work(&local->tx_work);
>     ...
> }
> 
> Suppose rx_work is running when local_cleanup() reaches
> cancel_work_sync(&local->rx_work). That cancel waits for it, and in the
> meantime rx_work queues tx_work again. local_cleanup() then returns and
> local_release_work() does:
> 
> 	local_cleanup(local);
> 	kfree(local);
> 
> Can nfc_llcp_tx_work() then run on the freed local? It would touch
> local->tx_queue, call nfc_data_exchange(local->dev, ...) and call
> mod_timer(&local->link_timer). The pending tx_work work_struct inside the
> freed object would also still be linked on system_wq.
> 
> Here is one way rx_work can be running during the final cleanup:
> 
> nfc_llcp_data_received()
>     nfc_llcp_find_local()             /* takes a reference */
>                                       nfc_llcp_unregister_device()
>                                           nfc_llcp_remove_local()
>                                           local_cleanup()
>                                           nfc_llcp_local_put()
>     __nfc_llcp_recv()
>         schedule_work(&local->rx_work)    /* system_wq */
>     nfc_llcp_local_put()  /* last ref, queues release_work on llcp_wq */
> 
> After this, rx_work and release_work run at the same time on different
> workqueues.
> 
> Digital drivers can reach this. nfc_digital_unregister_device() calls
> nfc_unregister_device() before cancel_work_sync(&ddev->cmd_complete_work).
> That lets
> digital_tg_recv_dep_req()->nfc_tm_data_received()->nfc_llcp_data_received()
> overlap with LLCP teardown. nfc_tm_data_received() checks dep_link_up but
> not shutting_down.
> 
> There is a related path. nfc_llcp_tx_work() passes the raw local pointer
> to nfc_data_exchange() as the context for nfc_llcp_recv(), and it takes no
> reference:
> 
> 	ret = nfc_data_exchange(local->dev, local->target_idx,
> 				skb, nfc_llcp_recv, local);
> 
> For digital devices, this completion runs from cmd_complete_work, which is
> only cancelled after nfc_unregister_device(). A late completion goes
> through nfc_llcp_recv()->__nfc_llcp_recv(), which writes local->rx_pending
> and calls schedule_work(&local->rx_work). The local it touches may already
> have been through local_cleanup(), or may already be freed.
> 
> Would disable_work_sync() work for the LLCP work items, or at least
> disabling rx_work before tx_work? That would match what
> timer_shutdown_sync() does for the timers.

This does seem to be a legitimate concern.

-- 
pw-bot: changes-requested

