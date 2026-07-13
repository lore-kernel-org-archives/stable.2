Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B333DE425;
	Mon, 13 Jul 2026 09:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783933699; cv=none; b=lV5FFdBhX58YwTg31hlzMr1Vo+NeLK3N4X7hlweS0ymR60m2SFnYbtZrgTZ6Vr025vUGzo69Iilc74bqB5YxRw56bglwF0bh6BjqKcLEr80hB6DF/3HIs7xMEtO8hZOBK2AFMkMLmLJ+DlXgSe7o1SvppXigPbHGFpCfp2kSiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783933699; c=relaxed/simple;
	bh=H2AUnpcM7vGdfeo0oaTmK0c1rHLcYnkUgNEUg+kogJc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PKostjkqETBIb5FLFZv4+K0wEduLIKPqwTQJgfskbWZBJaep5hq0nKDSVggmV9WFbgQd1gfFovxKQ9qVFKJTpaYeiIFppiyJb6wNowbWSp8Bfc2qouoAUcbkQx3HBpLN5sqVQEB/ZXK175RrXv33gxCPVdFijueAF2hUT6xw6MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mmtA9XGg; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mmtA9XGg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783933696; x=1815469696;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2AUnpcM7vGdfeo0oaTmK0c1rHLcYnkUgNEUg+kogJc=;
  b=mmtA9XGgdeKJoZf1F20bRczPeOUvG0bE+eNJKQ+O3xv8TlxnTnRRNdZo
   dUKDGxayi034/likg4UG0BCHt3VoKf6jSB3DmzWR+HikLnHXTpFX6CeyO
   DJxrwUJGA+37lB8uNOKi3riHjoNYukGiddZ/zJk7GnW6UzHNsPzK9/u6A
   dlmyQzt0nhWQ1ZWxcykdPBAp9A8yIT5KFzQK2DpVIqAm9iSXt2klUaCgt
   eybXGXQh7+q7ytG2rPz0Wd2LrlE5mJOz5yPiEDJecr3AJWVDd0dD6eLt1
   gEgLZD89YJHhN7/M7mpE/cvuU49FE7KXrAMAxO/47JqVOiK5VPgSpj0zl
   g==;
X-CSE-ConnectionGUID: ZipU0zqkTs+QQikjHcz9gg==
X-CSE-MsgGUID: ZkELZ/uUTIGeiwmwsirrjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="83653595"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="83653595"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 02:08:15 -0700
X-CSE-ConnectionGUID: Vhk4qVlcT5q8FvzEWKTcQw==
X-CSE-MsgGUID: AJT3mAscTIKWsN4TKaW++w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="255571404"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa007.jf.intel.com with ESMTP; 13 Jul 2026 02:08:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id D6C1E95; Mon, 13 Jul 2026 11:08:10 +0200 (CEST)
Date: Mon, 13 Jul 2026 12:08:09 +0300
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Andrei Kuchynski <akuchynski@chromium.org>
Cc: Jameson Thies <jthies@google.com>, Benson Leung <bleung@chromium.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
	Pooja Katiyar <pooja.katiyar@intel.com>,
	Johan Hovold <johan@kernel.org>,
	Hsin-Te Yuan <yuanhsinte@chromium.org>,
	Myrrh Periwinkle <myrrhperiwinkle@qtmlabs.xyz>,
	Linyu Yuan <quic_linyyuan@quicinc.com>,
	Jack Pham <quic_jackp@quicinc.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usb: typec: ucsi: Fix race condition and ordering in
 port unregistration
Message-ID: <alSq-cD0_fdhA3tU@kuha>
References: <20260707141736.1635698-1-akuchynski@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707141736.1635698-1-akuchynski@chromium.org>

Tue, Jul 07, 2026 at 02:17:36PM +0000, Andrei Kuchynski kirjoitti:
> A synchronization issue exists during port unregistration where pending
> partner work items can race against workqueue destruction, leading to
> use-after-free conditions:
> 
>   cros_ec_ucsi cros_ec_ucsi.3.auto: error -ETIMEDOUT: PPM init failed
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   RIP: 0010:__queue_work+0x83/0x4a0
>   Call Trace:
>     <IRQ>
>     __cfi_delayed_work_timer_fn+0x10/0x10
>     run_timer_softirq+0x3b6/0xbd0
>     sched_clock_cpu+0xc/0x110
>     irq_exit_rcu+0x18d/0x330
>     fred_sysvec_apic_timer_interrupt+0x5e/0x80
> 
> Fix this by ensuring strict ordering and proper serialization during
> teardown:
> 
> 1. Move ucsi_unregister_partner() to the beginning of the teardown
> sequence and protect it under the connector mutex lock.
> 2. Ensure all pending partner tasks are explicitly flushed and finished
> before the workqueue is destroyed.
> 3. Switch from mod_delayed_work() to a cancel_delayed_work() and
> queue_delayed_work() sequence. This guarantees that items currently marked
> as pending won't be scheduled an additional time, preventing a double
> release of resources which leads to the following crash:
> 
>   Oops: general protection fault, probably for non-canonical address
>     0xdead000000000122: 0000 [#1] SMP NOPTI
>   Workqueue: cros_ec_ucsi.3.auto-con2 ucsi_poll_worker
>   RIP: 0010:ucsi_poll_worker+0x65/0x1e0
>   Call Trace:
>   <TASK>
>     process_scheduled_works+0x218/0x6d0
>     worker_thread+0x188/0x3f0
>     __cfi_worker_thread+0x10/0x10
>     kthread+0x226/0x2a0
> 
> To ensure these rules are applied identically across both the normal
> teardown and the ucsi_init() error paths, consolidate the cleanup logic
> into a new helper, ucsi_unregister_port().
> 
> Cc: stable@vger.kernel.org
> Fixes: b9aa02ca39a4 ("usb: typec: ucsi: Add polling mechanism for partner tasks like alt mode checking")
> Fixes: b13abcb7ddd8 ("usb: typec: ucsi: Fix NULL pointer access")
> Fixes: fac4b8633fd6 ("usb: ucsi: Ensure connector delayed work items are flushed")
> Signed-off-by: Andrei Kuchynski <akuchynski@chromium.org>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/ucsi/ucsi.c | 82 +++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
> index 92166a3725b16..d9668ed7c80ea 100644
> --- a/drivers/usb/typec/ucsi/ucsi.c
> +++ b/drivers/usb/typec/ucsi/ucsi.c
> @@ -1845,6 +1845,42 @@ static int ucsi_register_port(struct ucsi *ucsi, struct ucsi_connector *con)
>  	return ret;
>  }
>  
> +static void ucsi_unregister_port(struct ucsi_connector *con)
> +{
> +	struct ucsi_work *uwork;
> +
> +	if (con->wq) {
> +		mutex_lock(&con->lock);
> +		ucsi_unregister_partner(con);
> +		/*
> +		 * queue delayed items immediately so they can execute
> +		 * and free themselves before the wq is destroyed
> +		 */
> +		list_for_each_entry(uwork, &con->partner_tasks, node) {
> +			if (cancel_delayed_work(&uwork->work))
> +				queue_delayed_work(con->wq, &uwork->work, 0);
> +		}
> +		mutex_unlock(&con->lock);
> +
> +		destroy_workqueue(con->wq);
> +		con->wq = NULL;
> +	} else {
> +		ucsi_unregister_partner(con);
> +	}
> +
> +	ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> +	ucsi_unregister_port_psy(con);
> +
> +	usb_power_delivery_unregister_capabilities(con->port_sink_caps);
> +	con->port_sink_caps = NULL;
> +	usb_power_delivery_unregister_capabilities(con->port_source_caps);
> +	con->port_source_caps = NULL;
> +	usb_power_delivery_unregister(con->pd);
> +	con->pd = NULL;
> +	typec_unregister_port(con->port);
> +	con->port = NULL;
> +}
> +
>  static u64 ucsi_get_supported_notifications(struct ucsi *ucsi)
>  {
>  	u16 features = ucsi->cap.features;
> @@ -1971,22 +2007,8 @@ static int ucsi_init(struct ucsi *ucsi)
>  	for (i = 0; i < ucsi->cap.num_connectors; i++)
>  		lockdep_unregister_key(&connector[i].lock_key);
>  
> -	for (con = connector; con->port; con++) {
> -		if (con->wq)
> -			destroy_workqueue(con->wq);
> -		ucsi_unregister_partner(con);
> -		ucsi_unregister_altmodes(con, UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(con);
> -
> -		usb_power_delivery_unregister_capabilities(con->port_sink_caps);
> -		con->port_sink_caps = NULL;
> -		usb_power_delivery_unregister_capabilities(con->port_source_caps);
> -		con->port_source_caps = NULL;
> -		usb_power_delivery_unregister(con->pd);
> -		con->pd = NULL;
> -		typec_unregister_port(con->port);
> -		con->port = NULL;
> -	}
> +	for (con = connector; con->port; con++)
> +		ucsi_unregister_port(con);
>  	kfree(connector);
>  err_reset:
>  	memset(&ucsi->cap, 0, sizeof(ucsi->cap));
> @@ -2194,33 +2216,7 @@ void ucsi_unregister(struct ucsi *ucsi)
>  
>  	for (i = 0; i < ucsi->cap.num_connectors; i++) {
>  		cancel_work_sync(&ucsi->connector[i].work);
> -
> -		if (ucsi->connector[i].wq) {
> -			struct ucsi_work *uwork;
> -
> -			mutex_lock(&ucsi->connector[i].lock);
> -			/*
> -			 * queue delayed items immediately so they can execute
> -			 * and free themselves before the wq is destroyed
> -			 */
> -			list_for_each_entry(uwork, &ucsi->connector[i].partner_tasks, node)
> -				mod_delayed_work(ucsi->connector[i].wq, &uwork->work, 0);
> -			mutex_unlock(&ucsi->connector[i].lock);
> -			destroy_workqueue(ucsi->connector[i].wq);
> -		}
> -
> -		ucsi_unregister_partner(&ucsi->connector[i]);
> -		ucsi_unregister_altmodes(&ucsi->connector[i],
> -					 UCSI_RECIPIENT_CON);
> -		ucsi_unregister_port_psy(&ucsi->connector[i]);
> -
> -		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_sink_caps);
> -		ucsi->connector[i].port_sink_caps = NULL;
> -		usb_power_delivery_unregister_capabilities(ucsi->connector[i].port_source_caps);
> -		ucsi->connector[i].port_source_caps = NULL;
> -		usb_power_delivery_unregister(ucsi->connector[i].pd);
> -		ucsi->connector[i].pd = NULL;
> -		typec_unregister_port(ucsi->connector[i].port);
> +		ucsi_unregister_port(&ucsi->connector[i]);
>  		lockdep_unregister_key(&ucsi->connector[i].lock_key);
>  	}
>  
> -- 
> 2.55.0.rc2.803.g1fd1e6609c-goog

-- 
heikki
