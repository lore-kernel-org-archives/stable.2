Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDA6274670;
	Mon,  7 Sep 2026 11:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782117; cv=none; b=txo37QoDLUZFEiiEOvpYvjR7eRUC0Z8rSA9PqJDsIOGcGyBGpTAB7qHhNsk6c+QaOMWyKXCCK7HoRFeIwEJgYGfE09IyAJTu/EjbcmOgzX2I4pwpPN1srKAacqrV0Z/UpqJMN7uCzKmiXoo16AAuqyPP6FNUozFbgli5NP9r5pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782117; c=relaxed/simple;
	bh=G+HNeQkoIlDnAIYVRXbnAQvsMP69lYgGx08HJ+MQy1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcnpRCrZSpSwV9KIb9kKzPxR/P/85eb4yDqYahWagsM5JrkaTolDRbSqCUplt7/CvJJuPkVx7i+NU3BikJWTS7JlplFCKRENAjE29TadRy0zN2VlKEY5ZY6/U0CMnCpJFD4jOtusdMaUMxETb24HOVsO+juVnMTHtup5DBNi1t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrvKaDch; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrvKaDch"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788782115; x=1820318115;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=G+HNeQkoIlDnAIYVRXbnAQvsMP69lYgGx08HJ+MQy1c=;
  b=LrvKaDchHkNstlnHc2EWWu1kCc1zgKzo+z/2/xmhy3utS7GHFD0U6evf
   I8IiihKUjcfwl6Euh6wuA1Ujok5Hi39ljv3vWDCIXU+0JVzWiQUxJRnjZ
   SEtVnlPsFIvYgnYv04dWDN9xSeGKuxrRCW1bLbdnaBGZBbgtcXRWcmE4c
   RfbxDXQ86qMoB8g458PHAjJVNEp2VvAh5TJ0v0gyJYAqJCrvtsqsEa6Tx
   Tvo3QbG2cR4R1q6arBaMjsgw36+algZFQfZics1jrRf4LO4LuxErfgpW2
   nPFccDX1BQGa+ygblYGqAF6aHjE6LI/GnaSQcdg5zmo811ZI7tnY2zU1X
   A==;
X-CSE-ConnectionGUID: wpDfAgHMTVudvTO9xx36sQ==
X-CSE-MsgGUID: QaAr6u3ORTGfhzHMhKfZ9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11898"; a="100705789"
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="100705789"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2026 04:55:14 -0700
X-CSE-ConnectionGUID: CtBrWxBpQDSoi9kwFZPYkg==
X-CSE-MsgGUID: oWhmXMNSS5mCN7xd6KEn7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,267,1779174000"; 
   d="scan'208";a="266351404"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa006.fm.intel.com with ESMTP; 07 Sep 2026 04:55:12 -0700
Received: by black.igk.intel.com (Postfix, from userid 1008)
	id B6F2699; Mon, 07 Sep 2026 13:55:10 +0200 (CEST)
Date: Mon, 7 Sep 2026 13:55:10 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: =?iso-8859-1?Q?Iv=E1n?= Ezequiel Rodriguez <ivanrwcm25@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Fan Wu <fanwu01@zju.edu.cn>, Wei Huang <huangwei@kylinos.cn>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: acpi: fix use-after-free on driver
 removal
Message-ID: <ap6mHnPJKKJFapsO@black.igk.intel.com>
References: <20260903030356.58597-1-ivanrwcm25@gmail.com>
 <20260903232121.271776-1-ivanrwcm25@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260903232121.271776-1-ivanrwcm25@gmail.com>

On Thu, Sep 03, 2026 at 08:21:21PM -0300, Iván Ezequiel Rodriguez wrote:
> ucsi_acpi_remove() destroys the UCSI instance before removing the ACPI
> notify handler:
> 
> 	ucsi_unregister(ua->ucsi);
> 	ucsi_destroy(ua->ucsi);
> 
> 	acpi_remove_notify_handler(...);
> 
> ucsi_acpi_notify() dereferences ua->ucsi, so a notify arriving after
> ucsi_destroy() uses freed memory:
> 
>   CPU0					CPU1
>   ----					----
>   ucsi_acpi_remove()
>     ucsi_unregister()
>     ucsi_destroy()
>       kfree(ucsi)
> 					ucsi_acpi_notify()
> 					  ua->ucsi->ops->read_cci()   <-- UAF
> 
> Simply removing the handler before ucsi_unregister() is not correct
> either. ucsi_unregister() drains work that needs the notify path to make
> progress: ucsi_handle_connector_change() issues GET_CONNECTOR_STATUS and
> ucsi_unregister_port() drains and destroys con->wq, and those commands
> block in wait_for_completion_timeout() on ucsi->complete for up to
> UCSI_TIMEOUT_MS. That completion is signalled only from
> ucsi_notify_common(), i.e. from the notify handler. Tearing the handler
> down first would leave cancel_work_sync() and destroy_workqueue()
> waiting the full timeout for a completion that can no longer arrive.
> 
> Moving the removal between ucsi_unregister() and ucsi_destroy() is not
> sufficient on its own: at that point the connector array has already
> been freed, so a late notify reaching ucsi_connector_change() would
> queue work on a freed connector.
> 
> Teardown therefore needs two properties at the same time: no new
> connector changes once connectors start going away, but the notify path
> still available for command and acknowledge completions until that work
> has been drained. Whether the PPM actually produces those completions is
> a firmware matter; what changes here is that the path able to deliver
> them is no longer torn down first.
> 
> Introduce a quiescing state, local to the ACPI backend, that provides
> both. ucsi_acpi_remove() sets ua->quiescing under ua->notify_lock before
> calling ucsi_unregister(); ucsi_acpi_notify() takes the same lock and,
> when quiescing, reduces the CCI to the bits that ucsi_notify_common()
> consumes for completions. ucsi_notify_common() looks at exactly
> UCSI_CCI_BUSY, the connector number, UCSI_CCI_ACK_COMPLETE and
> UCSI_CCI_COMMAND_COMPLETE; keeping the first and the last two preserves
> the completion and bogus-data behaviour unchanged, while clearing the
> connector number makes ucsi_connector_change() unreachable. The CCI that
> the command path inspects is unaffected, because
> ucsi_sync_control_common() re-reads it from the interface after the
> completion.
> 
> The resulting order is:
> 
>   mutex_lock(&ua->notify_lock);
>   ua->quiescing = true;			-- no new connector work
>   mutex_unlock(&ua->notify_lock);
> 
>   ucsi_unregister();			-- drains work, notify path still
> 					   available for completions
> 
>   acpi_remove_notify_handler();		-- unlinks, then flushes
> 					   kacpi_notify_wq
> 
>   ucsi_destroy();			-- no notify can be in flight
> 
> which gives the following happens-before chain:
> 
> - A notify that acquires notify_lock before ucsi_acpi_remove() runs to
>   completion while remove() waits on the lock, so any schedule_work() it
>   performs happens before ucsi_unregister() starts cancelling.
> - A notify that acquires notify_lock after remove() released it observes
>   quiescing == true, so it cannot reach ucsi_connector_change() and
>   cannot touch ucsi->connector.
> - acpi_remove_notify_handler() unlinks the handler and then calls
>   acpi_os_wait_events_complete(), which flushes kacpi_notify_wq, so a
>   notify already dispatched on another CPU has returned before
>   ucsi_destroy() frees the instance.
> 
> notify_lock is never held across ucsi_unregister() or
> acpi_remove_notify_handler(); holding it there would deadlock against
> the notify work those calls wait for. It is only ever taken as a leaf:
> ucsi_notify_common() and ucsi_connector_change() take no locks, so it
> cannot invert against ucsi->ppm_lock or con->lock, which the drained
> work holds while waiting for the completion. The handler runs from
> kacpi_notify_wq via acpi_os_execute(OSL_NOTIFY_HANDLER, ...), i.e. in
> process context, so sleeping on the mutex is allowed.
> 
> The probe error path already removes the handler before ucsi_destroy()
> and is left unchanged.
> 
> Fixes: f56de278e8ec ("usb: typec: ucsi: acpi: Move to the new API")
> Cc: stable@vger.kernel.org
> Reported-by: Fan Wu <fanwu01@zju.edu.cn>
> Link: https://lore.kernel.org/all/20260718021142.3146566-1-fanwu01@zju.edu.cn/
> Signed-off-by: Iván Ezequiel Rodriguez <ivanrwcm25@gmail.com>

You could have used guard(mutex) in ucsi_acpi_notify(), but that's
not a huge problem.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> 
> Notes:
>     Hi Heikki, Greg,
>     
>     v2 is a rewrite rather than an incremental fixup. v1 moved
>     acpi_remove_notify_handler() ahead of the teardown, and that ordering is
>     wrong for the reason Fan Wu had already documented in [1]: the work that
>     ucsi_unregister() drains can be waiting for a completion that only the
>     notify path delivers. This version keeps the handler installed across
>     ucsi_unregister() and adds an ACPI-local quiescing state instead.
>     
>     Wei Huang asked on v1 whether acpi_remove_notify_handler() waits for a
>     callback that already entered on another CPU. It does: for
>     ACPI_DEVICE_NOTIFY it calls acpi_os_wait_events_complete() after
>     unlinking the handler (drivers/acpi/acpica/evxface.c), that flushes
>     kacpi_notify_wq (drivers/acpi/osl.c), and device-notify dispatch runs on
>     that same workqueue through acpi_os_execute(OSL_NOTIFY_HANDLER, ...).
>     So the raw call is already the barrier, and acpi_dev_remove_notify_handler()
>     would only add a second flush. Chasing that question is what surfaced the
>     harder half of the problem, which is what this version is about.
>     
>     On [1]: that patch kept the handler installed across ucsi_unregister()
>     for exactly the right reason, and this version preserves that property.
>     What it did not cover is the window you described in that thread, where a
>     notify arriving after ucsi_unregister() has freed the connectors still
>     reaches ucsi_connector_change(). You also asked to keep the solution
>     inside ucsi_acpi.c rather than redesigning the core, which is what this
>     does.
>     
>     Changes since v1:
>     - Do not remove the notify handler before ucsi_unregister().
>     - Add the quiescing state, so connector changes stop while the notify
>       path stays available for completions.
>     - Drop the ucsi.c changes from v1 (ntfy = 0, connector = NULL, cap = 0).
>       I could not show they were needed for the other backends, and they do
>       not belong in the same patch as the ACPI lifetime fix.
>     - Correct the Fixes: tag. v1 pointed at 8243edf44152, which added the
>       driver; the current ordering came from f56de278e8ec.
>     - Credit Fan Wu, who reported the underlying use-after-free first.
>     - Use mutex_init() rather than devm_mutex_init(), which only appeared in
>       4cd47222e435 (2024) and would be a needlessly modern dependency for a
>       fix tagged for stable from a 2019 commit.
>     
>     Testing
>     
>     I have no machine that exercises the UCSI ACPI path, so this was tested
>     with a software PPM backend that drives the real UCSI core
>     (ucsi_create/ucsi_register/ucsi_unregister/ucsi_destroy/
>     ucsi_notify_common) and reproduces the ACPI notify protocol, including
>     the deferral to a percpu workqueue. All three candidate teardown
>     orderings were run against it: the one from v1, the one from [1] and the
>     one in this patch. v7.3-rc2, KASAN + lockdep + PROVE_LOCKING +
>     DEBUG_MUTEXES, QEMU, oops=panic.
>     
>     Each case below parks a connector work in wait_for_completion_timeout()
>     before teardown starts, and asserts that precondition rather than
>     assuming it.
>     
>       teardown ordering                     result
>       ------------------------------------  ----------------------------
>       quiesce, unregister, unlink (this)    148 ms, clean, with a late
>                                             connector notify fired after
>                                             ucsi_unregister() returned
>       unlink, unregister (v1)               10595 ms stall
>       unregister, unlink (as in [1]), a     KASAN slab-use-after-free in
>       connector notify landing in the       queue_work_on(), then a GP
>       window                                fault in the kworker that
>                                             picked up the freed work
>       nothing in flight (this)              146 ms, clean
>     
>     Repeated with the teardown starting while ucsi_init_work() is still
>     running, so that cancel_delayed_work_sync(&ucsi->work) has to drain an
>     init command parked on the completion: this patch takes 2299 ms and
>     completes cleanly, of which 1500 ms is the injected command delay, while
>     the v1 ordering stalls for 10089 ms and the init gives up with
>     -ETIMEDOUT.
>     
>     Two deterministic checks of the properties the patch claims:
>     
>     - CCI mask. A single CCI carrying both connector 1 and COMMAND_COMPLETE
>       (0x80000002) is delivered while quiescing: the completion is signalled
>       and EVENT_PENDING stays clear, i.e. ucsi_connector_change() is not
>       reached. The same CCI with quiescing off sets EVENT_PENDING, so the
>       check is sensitive to the path it claims to block.
>     
>     - notify_lock as a barrier. A notify that has entered the handler is
>       held inside it for 1200 ms; the store of quiescing in the teardown
>       path blocks for 1215 ms behind it. This is what makes "a notify that
>       started before teardown finishes its schedule_work() before
>       ucsi_unregister() begins cancelling" an ordering guarantee rather
>       than a likelihood.
>     
>     Soak: 1000 teardown cycles with four threads hammering the notify path
>     concurrently with the quiesce sequence, repeated at 1, 2, 4 and 8 vCPUs,
>     so 4000 teardowns in total. No stall, no KASAN report and no lockdep
>     splat in any configuration. A separate KCSAN build ran 200 of those
>     cycles at 4 vCPUs with no data race reported in any UCSI path.
>     
>     What this does not cover: no real ACPI hardware, so the ACPICA drain
>     described above is established by reading evxface.c and osl.c rather
>     than by execution; and the LG gram quirk path is untouched and
>     unexercised.
>     
>     The harness is not part of this patch. I can post it separately if it
>     is useful.
>     
>     [1] https://lore.kernel.org/all/20260718021142.3146566-1-fanwu01@zju.edu.cn/
> 
>  drivers/usb/typec/ucsi/ucsi_acpi.c | 53 ++++++++++++++++++++++++++++--
>  1 file changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
> index 18286d3e9cc5..61bba7625d17 100644
> --- a/drivers/usb/typec/ucsi/ucsi_acpi.c
> +++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
> @@ -24,6 +24,15 @@ struct ucsi_acpi {
>  	bool check_bogus_event;
>  	guid_t guid;
>  	u64 cmd;
> +	/*
> +	 * notify_lock serialises ucsi_acpi_notify() against the start of
> +	 * teardown, so that @quiescing is observed by every notify that has
> +	 * not yet run. It must not be held across ucsi_unregister(), whose
> +	 * drained work may depend on the notify path, nor across
> +	 * acpi_remove_notify_handler(), which flushes notify work.
> +	 */
> +	struct mutex notify_lock;
> +	bool quiescing;
>  };
>  
>  static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
> @@ -179,11 +188,31 @@ static void ucsi_acpi_notify(acpi_handle handle, u32 event, void *data)
>  	u32 cci;
>  	int ret;
>  
> +	mutex_lock(&ua->notify_lock);
> +
>  	ret = ua->ucsi->ops->read_cci(ua->ucsi, &cci);
>  	if (ret)
> -		return;
> +		goto out_unlock;
> +
> +	/*
> +	 * Once teardown has started the connectors are being unregistered and
> +	 * freed, so a connector change must not be reported any more. Command
> +	 * and acknowledge completions must still be able to reach the core:
> +	 * ucsi_unregister() drains connector and partner work that can be
> +	 * blocked in wait_for_completion_timeout() on ucsi->complete, and that
> +	 * completion is only signalled from here. Keep exactly the bits that
> +	 * ucsi_notify_common() needs for that, which drops the connector
> +	 * number and with it the path to ucsi_connector_change(). The busy
> +	 * indicator is kept so that bogus CCI data is still ignored.
> +	 */
> +	if (ua->quiescing)
> +		cci &= UCSI_CCI_BUSY | UCSI_CCI_ACK_COMPLETE |
> +		       UCSI_CCI_COMMAND_COMPLETE;
>  
>  	ucsi_notify_common(ua->ucsi, cci);
> +
> +out_unlock:
> +	mutex_unlock(&ua->notify_lock);
>  }
>  
>  static int ucsi_acpi_probe(struct platform_device *pdev)
> @@ -219,6 +248,8 @@ static int ucsi_acpi_probe(struct platform_device *pdev)
>  
>  	ua->dev = &pdev->dev;
>  
> +	mutex_init(&ua->notify_lock);
> +
>  	id = dmi_first_match(ucsi_acpi_quirks);
>  	if (id)
>  		ops = id->driver_data;
> @@ -256,11 +287,29 @@ static void ucsi_acpi_remove(struct platform_device *pdev)
>  {
>  	struct ucsi_acpi *ua = platform_get_drvdata(pdev);
>  
> +	/*
> +	 * Stop reporting connector changes, but keep the notify handler
> +	 * installed so that the work ucsi_unregister() drains can still be
> +	 * reached by the command completions it may be waiting for. Any notify
> +	 * that already passed this point runs to completion first, so no
> +	 * connector work can be queued once ucsi_unregister() starts.
> +	 */
> +	mutex_lock(&ua->notify_lock);
> +	ua->quiescing = true;
> +	mutex_unlock(&ua->notify_lock);
> +
>  	ucsi_unregister(ua->ucsi);
> -	ucsi_destroy(ua->ucsi);
>  
> +	/*
> +	 * Now that no work is left to serve, drop the handler. This unlinks it
> +	 * and then calls acpi_os_wait_events_complete(), which flushes
> +	 * kacpi_notify_wq, so a notify running on another CPU has returned
> +	 * before ucsi_destroy() frees the instance that it dereferences.
> +	 */
>  	acpi_remove_notify_handler(ACPI_HANDLE(&pdev->dev), ACPI_DEVICE_NOTIFY,
>  				   ucsi_acpi_notify);
> +
> +	ucsi_destroy(ua->ucsi);
>  }
>  
>  static int ucsi_acpi_suspend(struct device *dev)
> -- 
> 2.43.0

-- 
heikki
