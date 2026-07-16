Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA3122D7A9
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 05:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784178505; cv=none; b=PRDr4vAugm821XbyLtcWMZ2RjpXWzdduSEusKn+rn7814u8M+fRVpPZXDG4Bf9iEQ8UQq5PyxMFdasL8fAkDFLZGAylaEblG6NIXB+xUyc7gIx5QnBVmZTVAvd1DP8jkle2SJPHMPKd+a5yBMtGk7DyoGjXZmmHI/8IFb1as9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784178505; c=relaxed/simple;
	bh=qqwraMDnpWJBgaee77fgjKJ5GopKLaxiNWGK8pmr9nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brD4oJ09loIWOFap9+rEuoZCq9qO05oICKCp9oHq3CZRR7goVAP012R/iTDgsHA5NK/QKWZ8Ws8JUQifjC8VooUydRYmLRULNkD5Wo3rKDjA8p63iRm1K/KYtNPaM7loppVpZ/5/6WbZC366P7NWFiAiKXOsApKfus0T6OGiWbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=icYUAv8m; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gO15tXJb; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="icYUAv8m";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gO15tXJb"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 1087EEC018A;
	Thu, 16 Jul 2026 01:08:21 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 16 Jul 2026 01:08:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1784178501;
	 x=1784264901; bh=SeuWKJR9gTSvkaNonQzrnUyhQ9smcQBfu88XVsmiK98=; b=
	icYUAv8mO26X3jxIHmI5PLNo/wmBLzbE+8Jvud2osqFyv2UovP2wp4RcpznAWKXy
	oE+rapbYaDKzPrUjxBKP6d++AWkxgn/k0ylEEjda7RL0llPJr9kZiy4zlvX+SlUw
	6DPjR56u15Y2z/3XDxh2SnXT8rNceATWwB7MUoHVRWkpKyA7WpQjZS6q/ctAYfEQ
	yMXIcfMUiwiLqZ3RvB1Tw7RFeHhBAANQG3AkWmJtXYUamviuDQ6Hv4kr+1pjTR+W
	pnX4A9pAGdHFPJA9ZDW7IHlCvVGD+MzkSKujzQkIULQpANfgy0abY4F/AH0DnstO
	AupJiH9DrJ55WqKzr1hzWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784178501; x=
	1784264901; bh=SeuWKJR9gTSvkaNonQzrnUyhQ9smcQBfu88XVsmiK98=; b=g
	O15tXJbhZVzPxqPLBNDJu/gbXPsF+buFroUST5nsZvq3uG6SrvLFYaEEYIoWYOla
	iS3pVpPgwAA/2uqBW3cU//3Zj8CXi7c0CunVcBSqhdYlWfRflFTjSUpDPPz5v23P
	mPsmR9GmXXUwL6HEeDAaEEd7RveX8wtyR+1u+3CgFSd/canW3RjLUjTUVZS0wiUt
	3uOIV+5naSc36kC7vUI55RTt55WQfPAN+f9FOCFpF9jhp3l9lwcHwniTR1dBzz7t
	6HleinZQKNlE9iDHFHTOZaRJtlQASQ7LlPAmSva1TYqyhXsuDEgn1HhXl2IErao8
	FMN0w1yNzkSUngdKYZ5Aw==
X-ME-Sender: <xms:Q2dYajm0Z6CvfZnux4fQADUT2oCi79SDBGirbzdeBlqJmQiRNmCg5A>
    <xme:Q2dYapH2bAnj-rJ8HLVfwPbY-Anm83xPPPtaOl0ePkCvPtOUfENH4_ETekpMng2U3
    1gDeMG7pfS__VHKZIA67oBu5a7piy8McEgOqBxjU5IocV13dQ>
X-ME-Received: <xmr:Q2dYar4d298Ll7zxxBHrK496v5hq_GG39QTRWlsAc0nfFfRbIHX0dCA2yeZAJBrw9qUxd_EMzKiNq3oL_a-pBE2sUg>
X-ME-Proxy-Cause: dmFkZTEvLEHDLKycg/JDnPY0GC7LzM3bc56I1hY6MNKF+uEKQMylxjuVb5iSVsSWbmrE9+
    OrQaj+e621fCesYTOUEHZ00NJ+y5n9FiMoBkavb/55ico+7pW+mOnqiwAYrx/5zOECgZpC
    DzjgyMuYFw64J8QepMjQwPVBolRBP5ijn2YaDAdpIH2riP1b1WTkJEp7pZKXWdbDeQDzUA
    bkXMSK/aDn7uKcPorjBHPjxvuvCWG2ThhqOONDMD3oNmJwjmrZ14CJryDPqJ09c0MtJWF0
    QmGkJLzzEzqD23XhwoOkaMMKt1CHg221mq5nfaWaHYynUPaRWT9svtBinkqqCFsfMcvsah
    K4K143F+9HZeUdg3sWG5Pp4A+DbN/HBTyyJI4j7wPh0Ncw8jEcHEsEPvSfzM81lroBQo5Y
    E8ZoSAovB5QZjt96SwtforpM9qHpPlgjAN1Bcn6IQ25SA4G3kzDvlV3knErdyDpOWZFp3e
    DQkCSFWJOG75dsJNKp3TyLTDVvQUIQ/5tdj3qPKfLXLWngX1z7hwWEuPe8E6f75YRqbaY7
    JA/nf5oxI0UJVamoybn0F9ayNPtM////Th78n1PXWFE4VdiQF5Gdpc0vLk6iViYFD8nYgg
    V8JoGlu3H9KcW9Kr1f2HKxAnQRpQxZy7IDXnhgyKHUNqrbw8hmDdb7esW4yQ
X-ME-Proxy: <xmx:Q2dYahnM2-qZguEnVr7FALyRkFNW5rCZcc7Fgzg4gWbMMqY4MVqRUg>
    <xmx:RGdYagoxtZV5fbtPZZD1ekDt-M19Tyb3iyL2LxTyGtEWalJOY_SPlA>
    <xmx:RGdYags9ursJekTaWxhvGcRbgGMI3kx_bYyT528Pwd0Fhuwtm_B-RQ>
    <xmx:RGdYalE7IoWqMfc2orFgjjSVblKyTgkOmsCsQCcM2mf3lEWSDDq0zw>
    <xmx:RWdYahpGfFF2rA_i5dHn9gjdy_Vbyx4VHnKzTX9QNRYSwtbNu6lS4DNn>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Jul 2026 01:08:19 -0400 (EDT)
Date: Thu, 16 Jul 2026 07:08:13 +0200
From: Greg KH <greg@kroah.com>
To: =?iso-8859-1?Q?Jo=E3o?= Moreira Fernandes <joao.fernandes@ist.utl.pt>
Cc: Joao <joao@bckground.com>, stable@vger.kernel.org
Subject: Re: [PATCH] usbip: flush the event handler in usbip_stop_eh() to fix
 use-after-free
Message-ID: <2026071607-announcer-jingle-2d0b@gregkh>
References: <20260715112458.2143740-1-joao.fernandes@ist.utl.pt>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715112458.2143740-1-joao.fernandes@ist.utl.pt>

On Wed, Jul 15, 2026 at 12:24:57PM +0100, João Moreira Fernandes wrote:
> usbip_stop_eh() is used by the stub, vhci and vudc sides to wait for the
> event handler to finish with a usbip_device before the caller tears it
> down.  It waits only on the event bitmask:
> 
> 	wait_event_interruptible(ud->eh_waitq, !(ud->event & ~USBIP_EH_BYE));
> 
> but event_handler() clears those bits with unset_event() *before* its
> final dereferences of ud:
> 
> 	if (ud->event & USBIP_EH_SHUTDOWN) {
> 		ud->eh_ops.shutdown(ud);
> 		unset_event(ud, USBIP_EH_SHUTDOWN);   /* wait may now return */
> 	}
> 	...
> 	mutex_unlock(&ud->sysfs_lock);            /* still touches ud */
> 	wake_up(&ud->eh_waitq);                   /* still touches ud */
> 
> Once the last non-BYE bit is cleared the waiter can wake and the caller
> proceeds to free ud.  For the stub side, stub_disconnect() ->
> shutdown_busid() calls usbip_stop_eh() and then stub_device_free() frees
> the stub_device that embeds ud, while event_handler() is still executing
> mutex_unlock(&ud->sysfs_lock) and wake_up(&ud->eh_waitq), and may still
> mutex_lock(&ud->sysfs_lock) on a second queued event for the same ud.
> The result is a use-after-free in the usbip_event workqueue.
> 
> It is readily triggered by a reverse/exported-device teardown that
> unbinds usbip-host while the importer is still attached: the socket EOF
> queues SDEV_EVENT_ERROR_TCP (SHUTDOWN|RESET) from the stub_rx thread at
> the same moment stub_disconnect() queues SDEV_EVENT_REMOVED
> (SHUTDOWN|BYE), so the handler re-runs shutdown/reset on ud in the exact
> window where it is being freed.
> 
> Reproduced under KASAN on v6.12.95 (usbip built as vhci_hcd importer and
> usbip-host exporter on two separate VMs).  The freed object is the
> stub_device, freed by the unbind write and then read by the event
> workqueue:
> 
>   BUG: KASAN: slab-use-after-free in event_handler+0x2ba/0x3a0
>   Read of size 8 at addr ffff888005cc6058 by task kworker/u8:5/63
>   Workqueue: usbip_event event_handler
>   Call Trace:
>    event_handler+0x2ba/0x3a0
>    process_one_work+0x5c2/0xfd0
>    worker_thread+0x49d/0xb00
>    kthread+0x246/0x300
> 
>   Allocated by task 1657:
>    stub_probe+0xf0/0xb00
>    usb_probe_device+0xaa/0x2e0
>    bind_store+0xce/0x140
>    vfs_write+0x87c/0xd70
> 
>   Freed by task 1660:
>    kfree+0x1a4/0x3a0
>    stub_disconnect+0x21e/0x340
>    usb_unbind_device+0x6b/0x170
>    device_release_driver_internal+0x384/0x550
>    unbind_store+0xdb/0xf0
>    vfs_write+0x87c/0xd70
> 
> The same run produced 37 KASAN splats against the one freed object,
> reached through every place the handler still touches ud after clearing
> the event bits: mutex_lock() on ud->sysfs_lock, the eh_waitq wake
> (__wake_up_common / finish_wait / prepare_to_wait_event), and
> stub_shutdown_connection() called from event_handler().
> 
> Waiting on the event bits cannot close the window, because the handler's
> last accesses to ud are inherently after the bit is cleared.  Instead,
> flush the event work in usbip_stop_eh() so the handler has fully returned
> before the caller is allowed to free ud.  Every *_EVENT_REMOVED sets
> USBIP_EH_BYE, after which usbip_event_add() no longer queues new work for
> that ud, so flush_work() only has to wait out the in-flight run.  Guard
> the flush with usbip_in_eh() so it is skipped in the (stub reset) path
> that runs from the handler itself, and move the usbip_work declaration
> above usbip_stop_eh() so it is in scope.  None of the three usbip_stop_eh()
> callers hold ud->sysfs_lock, so flushing the worker (which takes it)
> cannot deadlock.
> 
> With the patch applied, the same KASAN reproducer runs the teardown
> suite repeatedly with zero KASAN reports.
> 
> Fixes: 363eaa3a450a ("usbip: synchronize event handler with sysfs code paths")
> Cc: stable@vger.kernel.org
> Signed-off-by: João Moreira Fernandes <joao.fernandes@ist.utl.pt>
> Assisted-by: Claude:claude-opus-4-8
> ---
>  drivers/usb/usbip/usbip_event.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
