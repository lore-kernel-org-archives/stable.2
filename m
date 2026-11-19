Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795121190;
	b=LIhaNNEydXVrcHv2FRrEXDXprzbr2EcQWlkMjy5cTg8C98y/1IVVhlUzpJbbf0a70KkD
	 hA8my+s6Tr9HNsAYCuud0GKWTsmyg4LRNKKumgBaCOoZ+V9nXiCA8JQ7gWVeGkD8JMDaD
	 Duh7TXcDxp/tqZwYnoJpvJEOKiXw14PJE8qmHn6gQZ6cQMVGfMiyx+l+S5+PR545ZXfen
	 Wat1U3eZwMiceWlHdd9Psy3Myplq2fr60VRycaBXo+cDXRtGfGgPXRKV+3x2uu3oRX3Vt
	 JRSmcC4YJEsCidFS8SZBP0e1aSmQrQlPov8kqTa913PL0YzIHoeSC1WYHYnDUz0hK1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795121190;
	h=Received:DKIM-Signature:Date:From:To:cc:Subject:In-Reply-To:
	 Message-ID:References:MIME-Version:Content-Type;
	bh=e8mFRyJsaJirejQOrmJc0xewue1qu6EHv9RgexxsRKo=;
	b=5kCjmYAib1kBiIv3cgdyHRLJKa1Uew+kuJ8EnCl5+qGzCkrWZVBk8GwxtbKY3X5FzFRk
	 3kyqxQ4n18q2kcRypYfu5k05DF6yL1r/+jC8E+1w+l8SfwinxvyOyDIoOJEoGcYXWFfq+
	 RD82NwH4GJJRyMbisQpH3pS0y/uiz3AzMVpckxzF6c/kN1M3p6YWBXN4jHmHVw3sqxUj/
	 2kgmY99aLEyi/pWWqvqsu9JwTvJG2hPoCo0ujHxMeuBH2OdJGIIApHR4owrCsMKQ+/DQQ
	 gwbyujOlskrKmmeq9LwdOVczltjgQU3+Sh/wC0tyCi6Sik2f2f0owPh5Yus51TkGwgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFPUXwvX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4442C606BBA1;
	Thu, 19 Nov 2026 20:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AFPUXwvX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357A81F000CA;
	Thu, 19 Nov 2026 20:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795121189;
	bh=e8mFRyJsaJirejQOrmJc0xewue1qu6EHv9RgexxsRKo=;
	h=Date:From:To:cc:Subject:In-Reply-To:References;
	b=AFPUXwvXjB2azonu32e8z64BFYHQgENX/dzF19B06M4GaFgLa0Jk/f00bx1fSLXIE
	 0sTJuR847RsJVHLmEKzKi4Ue+n2Gav5xsFqd0AILOMGL6fjbCsvDa0We6wiXjPa3sz
	 QVzOEwtQhW4SDQj7a9El9QZvu+snCtKhYMokpj8hyEPHj7hwq5liW6CA8F6F46TirQ
	 SVkSvMCs1FpkZgEjDm3GCKaaIL6Fj7BobiBgFGVLLYNoJ/Xw6V7esNJssWljRHTwni
	 +eF9eBQq1TmfwiEgwZVbHHdJJ/Xoa4jvOpRRZ2zFAD5eo+3efIZV+leI283b3S3jLb
	 HFlKt580kZZFg==
Date: Thu, 19 Nov 2026 21:46:27 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Jinmo Yang <jinmo44.yang@gmail.com>
cc: david@readahead.eu, bentiss@kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: wiimote: initialise rumble_worker once per device
In-Reply-To: <20260927153014.1395106-1-jinmo44.yang@gmail.com>
Message-ID: <q7n846r5-928n-7896-2o0p-7p99o652snno@xreary.bet>
References: <20260927153014.1395106-1-jinmo44.yang@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 28 Sep 2026, Jinmo Yang wrote:

> wdata->rumble_worker is a single work_struct in struct wiimote_data, but
> two different modules called INIT_WORK() on it:
> 
>   wiimod_rumble_probe()  devtype module, once per device
>   wiimod_pro_probe()     extension module, once per extension hotplug
> 
> These have independent lifetimes.  The devtype module is loaded once by
> wiimote_modules_load() and stays until wiimote_destroy(), while the
> extension module is loaded and unloaded any number of times by
> wiimote_ext_load() / wiimote_ext_unload().  wiimote_ext_load() calls the
> extension probe with no lock and no cancel_work_sync(), and for the
> common EXT_NONE -> EXT_PRO_CONTROLLER transition the preceding
> wiimote_ext_unload() is a no-op because wiimod_ext_table[] maps both
> EXT_NONE and EXT_UNKNOWN to wiimod_dummy, which has no .remove.
> 
> So nothing stops the force-feedback path, which is still live in the
> base module, from having queued the work already:
> 
> 	/* wiimod_rumble_play() */
> 	wdata->state.cache_rumble = value;
> 	schedule_work(&wdata->rumble_worker);
> 
> INIT_WORK() on a queued work item is memory corruption.  __INIT_WORK()
> does
> 
> 	(_work)->data = (atomic_long_t) WORK_DATA_INIT();
> 	INIT_LIST_HEAD(&(_work)->entry);
> 
> which clears the pool reference and the PENDING bit, and re-points
> ->entry at itself while the item is still linked into the worker pool
> list, leaving its neighbours pointing at a node that has left the list.
> 
> Note that CONFIG_DEBUG_OBJECTS_WORK hides the impact rather than just
> reporting it: work_fixup_init() calls cancel_work_sync() for the caller,
> so a debug kernel prints a warning and then repairs the state.  That is
> the kernel stating what the driver should have done.  Production kernels
> have no such repair.
> 
> Initialise the work once in wiimote_create(), which is where the object
> that contains it is created and which already initialises
> wdata->queue.worker, wdata->init_worker and wdata->timer, and drop both
> module-level INIT_WORK() calls.  wiimote_create() runs as the first
> statement of wiimote_hid_probe(), before hid_parse() and hid_hw_start(),
> so it strictly precedes the existence of any input device and therefore
> of any path that could queue the work.
> 
> This does not affect the deadlock fix in commit f50f9aabf32d ("HID:
> wiimote: fix FF deadlock").  That fix is the offload itself - caching
> the value and deferring to a worker instead of taking state.lock inside
> the FF callback - and this patch leaves wiimod_rumble_play(),
> wiimod_rumble_worker() and state.cache_rumble untouched.  Only the
> placement of the initialisation changes.
> 
> The two halves come from different actors, and both are available on a
> stock Android phone without root.  The extension hotplug half needs only
> /dev/uhid, which is group 3011 and held by the shell.  The shell cannot
> write to an evdev node - SELinux grants it read access only - so the
> force-feedback half comes from an ordinary app calling
> InputDevice.getVibrator().vibrate(), which reaches EVIOCSFF through
> system_server; VIBRATE is a normal permission and is granted
> automatically.  A paired Bluetooth HID device can supply the hotplug
> half instead of /dev/uhid.
> 
> The ordering matters: the device has to be created without an extension
> so that the devtype resolves to a GEN10/GEN20 that includes
> WIIMOD_RUMBLE, because WIIMOTE_DEV_PRO_CONTROLLER does not, and the
> extension has to be plugged afterwards.
> 
> Measured before the change:
> 
>   Pixel 11, stock Android 17 user build, SELinux enforcing, no KASAN and
>   no DEBUG_OBJECTS at runtime, kernel 6.12.81: reboots with
>   ro.boot.bootreason=kernel_panic one to two seconds after the two paths
>   start overlapping.
> 
>     Unable to handle kernel NULL pointer dereference at virtual address
>       0000000000000008
>     CPU: 5 Comm: kworker/5:4
>     Workqueue:  wiimod_rumble_worker (events)
>     pc : process_scheduled_works+0xd4/0x810
>     Kernel panic - not syncing: Oops: Fatal exception
> 
>   The empty workqueue name in that line is itself the corruption:
>   print_worker_info() reads wq->name with copy_from_kernel_nofault() and
>   it failed, while another CPU in the same dump shows the normal form,
>   "Workqueue: events wiimote_init_worker" - the task that called
>   wiimod_pro_probe().
> 
>   x86_64 with CONFIG_KASAN_GENERIC and CONFIG_DEBUG_OBJECTS_WORK both
>   enabled, 15 s in: KASAN says nothing, because INIT_WORK() writes to a
>   valid field of a live object, and DEBUG_OBJECTS_WORK reports
> 
>     ODEBUG: init active (active state 0) object type: work_struct
>       hint: wiimod_rumble_worker+0x0/0x70
>     WARNING: lib/debugobjects.c:629 at debug_print_object
>     Workqueue: events wiimote_init_worker
>      __debug_object_init+0x1ff/0x3b0
>      __init_work+0x51/0x60
>      wiimod_pro_probe+0x28/0xba0
>      wiimote_init_worker.cold+0xb6a/0xe88
> 
> After the change the same reproducer drives 36774 extension hotplugs and
> 612156 force-feedback plays in 60 s on that x86_64 kernel with no ODEBUG,
> WARNING or KASAN output, and the rumble reports still arrive, so the
> force-feedback path is unaffected.
> 
> Fixes: f50f9aabf32d ("HID: wiimote: fix FF deadlock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinmo Yang <jinmo44.yang@gmail.com>

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

