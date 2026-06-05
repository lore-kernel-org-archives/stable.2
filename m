Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2833F7AA6
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654736; cv=none; b=E9zHebtrzpmdkW0Sv5Qg0sBuR5blHkj/MTEVq4w72glekyYKmMxFFHgudHOrypKOgFfVAqdR7UDGovnK4YoLwGlLpdjnHxQdERRa8KbeXIxRBGJVJADbsd+EzeJOJRKKkYc0S7cg3Wo4Qy+3AVk/Ryn2c64VnRq21G+1FmuKoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654736; c=relaxed/simple;
	bh=z5emEtjkgTOUhPUR15DnzS/ndMzzacFrfbRAoFNHhxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VBTJZfdrb3321sXNLSm90ANa/KrNbC9aEnfF5ikUvadMyedUVfvMp575uXFFx+sCPYa2XUASksMwAdYyzdIFjjEVOM9jY6uwuu4ia7lSBgjj5jXGzPGA3ksbsCWCaWeKbCrWF7b/6T8xtkzhIJ2YNpciJOHhGnDNGM7GM7n/I6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j/b/ph/c; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j/b/ph/c"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso18636445e9.2
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 03:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780654732; x=1781259532; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r/WgxzvYD26Ohvw+tSuhD0oujVFYbtK9F3OV/bpgDQo=;
        b=j/b/ph/cOPlAM6WOriur2bCf0Cqdxyx6wnFRLAbYUGz9/8kZq2F4i0n5fYEl19mtcs
         9lBRWcApKqrouDfcbpgAtndctOBaxQUMsYkR92i9YecbTo9hKUArfBuiWU4ehkyr1+p5
         CbyiZifI5xthRBzQ1BY3ahERD8ZE1Nqz/Y2poVjRzEcEtmHB+zcLYjgDJOGJBo5JrsPX
         CmvG9Z40QoUgpjZIGj1+U0inD9g/xSB16qf+U30t2U437NHq+uSv6wbFja4ay/7XtXij
         dfdbAi4cRmCDqAHfgEbEQJy3C65Ua6Kc7uwT2LVk1tru+sCx7g9GEDbxOwqxuSlgNhH1
         RFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780654732; x=1781259532;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r/WgxzvYD26Ohvw+tSuhD0oujVFYbtK9F3OV/bpgDQo=;
        b=H+MMwjJJU6HsqafuOHCTD0WKfC/H7g/B2f78k9gKxerxj3he4S3UriXr5O+VIjA2L5
         QvaWdvICIbQahE7ya5Q5dd/7CaW9KfFng6ve+t9aXz2mSV1cDF90Qt17mNx4/kgCRvwz
         MIo0uP/0k7JDKrnE8eIGZ8X+Lkz8ILYwL3HDaYjOhJJdgVEDwfV+AQdFGpXbrK5iRBC2
         5sHiAp4W2Gz1f4HZyBrAKpaeWNEphVYZqsSOBqASIpesyEBBB21NpMcAZHeTjcDQ6Bng
         qmsJY2j71q03sygpgVlEEB9FizQomQtrrQmSM1PMzthR/hiJz1dsx25jTa2DS+Stcj4s
         DaYg==
X-Forwarded-Encrypted: i=1; AFNElJ/hYRZKB6KC+owlCJHm//43gDv2i647vgh8W78j7PtYhBR4hoiQU8lgrIU5Gr4+QS0xp7nM1a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfwuMh7Ye5Ix5pAYrbjnsI2Hha4sKZeapT7IctP/B8glBSsagl
	hx0F435WEdwM/No2rvCniiSfUTbMoz/Mi4C8kRxHSNZEIwJ2ZYUQ47KDxNRyD26VsQ==
X-Gm-Gg: Acq92OGpIGxjTUTsV3NC6OaSusX7Imiiokb+JSHz0gmktn8B5Xf9/2OmORf5gOC+FuD
	bijeot8d9ukQxdj4Kew0qG7DGbXnMfzCUuf9KUaG8DceOnntGR5PH+pLHaUpX8TqrTQ1DYXmaWf
	3oit9fiVy8/R/3lFI1KU0rnZ63pB0Nqso1rV1AZlJ9enGzbFw79FlwL5QZyQYMbd34/7I/YdSbM
	pFoDRa7JjvCZMRcQ20GRcqJ9Fn7JNSYV6s4VSN4Ufl8dBtrvCyEvl2/HhZC+6PYSk2y972z//wq
	pjEXm0dKzZExjmxpdvcTToQLnVQ6LxzWhLC/5IfxE6ryjbbxQcCCYjIsOXblRZqMf83ZMpv9ADz
	0S8NCyfbfvrcw7uFRv2o6ZhAElIMl80WCJ6mhQ1ix7NsBuwYcvGBZ+RMiSvaNuhM+JALOkJTliJ
	4ThVbat2ZQloCM6UnDqkS3Wbhery7Lucz5CK2FBWCukNtEmFXdelIHOiyJbsqz47Ck2MCTB7M=
X-Received: by 2002:a05:600c:828f:b0:490:b3fe:9732 with SMTP id 5b1f17b1804b1-490c25dd6aamr39838975e9.16.1780654731809;
        Fri, 05 Jun 2026 03:18:51 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:108e:a0d3:fede:9c88])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d30eeasm34945495e9.1.2026.06.05.03.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 03:18:49 -0700 (PDT)
Date: Fri, 5 Jun 2026 12:18:42 +0200
From: Marco Elver <elver@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
Message-ID: <aiKigutVmlbOuXGy@elver.google.com>
References: <20260603123111.2334409-1-elver@google.com>
 <CANpmjNPQCx8rynFhOUfqgagP-KBh0pJsXz6PQt6G3LomdzVJYw@mail.gmail.com>
 <CABBYNZL9tH1Tc+jbc6fJ-Y1EtX+_QUk_P3ghDmdOaXY0gdqtnQ@mail.gmail.com>
 <aiFzWTYs1ppHhnNS@elver.google.com>
 <CABBYNZLvDNPM9YXa+Whbx=+4Cgy-rp+pVVv0J0M52DsUMcQ8NQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZLvDNPM9YXa+Whbx=+4Cgy-rp+pVVv0J0M52DsUMcQ8NQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Jun 04, 2026 at 10:10AM -0400, Luiz Augusto von Dentz wrote:
> Hi Marco,
> 
> On Thu, Jun 4, 2026 at 8:45 AM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, Jun 03, 2026 at 01:31PM -0400, Luiz Augusto von Dentz wrote:
> > > Hi Marco,
> > >
> > > On Wed, Jun 3, 2026 at 9:16 AM Marco Elver <elver@google.com> wrote:
> > > >
> > > > On Wed, 3 Jun 2026 at 14:31, Marco Elver <elver@google.com> wrote:
> > > > >
> > > > > l2cap_chan_timeout() accesses chan->conn without holding a reference to
> > > > > the connection object. If l2cap_conn_del() races and tears down the
> > > > > connection while the timer is waiting for locks, it can result in a
> > > > > use-after-free when the timer wakes up and attempts to acquire
> > > > > conn->lock:
> > > > >
> > > > > | BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> > > > > | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
> > > > > | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> > > > > | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> > > > > | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
> > > > > |
> > > > > | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)
> > > > > | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > > > > | Workqueue: events l2cap_chan_timeout
> > > > > | Call Trace:
> > > > > |  <TASK>
> > > > > |  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> > > > > |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
> > > > > |  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> > > > > |  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> > > > > |  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
> > > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > > |  </TASK>
> > > > > |
> > > > > | Allocated by task 320:
> > > > > |  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
> > > > > |  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
> > > > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > > > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> > > > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > > |
> > > > > | Freed by task 322:
> > > > > |  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
> > > > > |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
> > > > > |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> > > > > |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> > > > > |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> > > > > |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> > > > > |  __fput+0x369/0x890 fs/file_table.c:510
> > > > > |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> > > > > |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> > > > > |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
> > > > > |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> > > > > |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> > > > > |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
> > > > > |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
> > > > > |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
> > > > > |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> > > > > |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > |
> > > > > | Last potentially related work creation:
> > > > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > > > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> > > > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > > |
> > > > > | The buggy address belongs to the object at ffff8881298d9400
> > > > > |  which belongs to the cache kmalloc-512 of size 512
> > > > > | The buggy address is located 336 bytes inside of
> > > > > |  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)
> > > > >
> > > > > Fix it by holding a reference to the connection when the channel timer
> > > > > is scheduled, and releasing it when the timer is either canceled or
> > > > > executes to completion.
> > > > >
> > > > > Since l2cap_chan_del() nullifies chan->conn to disassociate the channel
> > > > > during teardown, the timer handler might read NULL from chan->conn even
> > > > > if it held a reference. To address this, introduce a `timer_conn` field
> > > > > to `struct l2cap_chan` to store the connection pointer associated with
> > > > > the active timer. The timer handler uses this field to acquire locks and
> > > > > release the connection reference, and skips channel closing operations
> > > > > if chan->conn has already been nullified by teardown.
> > > > >
> > > > > Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
> > > > > Cc: <stable@vger.kernel.org>
> > > > > Cc: Siwei Zhang <oss@fourdim.xyz>
> > > > > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > > > Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
> > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > >
> > > > Sigh, Sashiko points out more problems here:
> > > > https://sashiko.dev/#/patchset/20260603123111.2334409-1-elver%40google.com
> > > >
> > > > > Can this lockless read of chan->timer_conn cause a use-after-free or double
> > > > > free if another thread re-arms the timer concurrently?
> > > >
> > > > I haven't analyzed this further yet, so consider this patch a
> > > > bug-report-only. If anyone finds a better fix sooner, please go ahead.
> > >
> > > I was thinking or something like the following:
> >
> > I tested that and my repro didn't trigger the UAF here, but I still
> > think it has the same fundamental issue:
> >
> > If the timer worker is preempted immediately after reading chan->conn
> > but before entering l2cap_conn_hold_unless_zero(), l2cap_conn_del() can
> > complete concurrently.
> >
> > When the timer worker resumes, l2cap_conn_hold_unless_zero(conn) will
> > attempt to read conn->ref that has already been freed, resulting in
> > another UAF.
> 
> I see. The window is very narrow but it is perhaps still triggerable
> somehow. The only thing that comes to mind is that we would need to
> take a reference of l2cap_conn with the likes of l2cap_set_timer then,
> which means l2cap_chan_timeout needs to drop not only l2cap_chan but
> also l2cap_conn when done, otherwise there will always be the risk of
> l2cap_conn_del running while l2cap_chan_timeout is pending.

What if we tie conn's lifetime to chan? I see that 'conn' being
NULL/non-NULL is also used as a presence/not-present marker, but we
could add an explicit conn_ref?

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Wed, 3 Jun 2026 18:24:56 +0200
Subject: [PATCH] Bluetooth: L2CAP: Fix UAF in channel timeout by holding conn
 ref

l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
the connection is torn down while the timer is running or pending,
chan->conn can be freed, leading to a use-after-free when the timer
worker attempts to lock conn->lock:

| BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
| BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
| BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
| BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
| Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
|
| CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)
| Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
| Workqueue: events l2cap_chan_timeout
| Call Trace:
|  <TASK>
|  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
|  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
|  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
|  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
|  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
|  </TASK>
|
| Allocated by task 320:
|  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
|  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
|  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
|  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
|  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
|  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
|  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
|
| Freed by task 322:
|  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
|  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
|  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
|  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
|  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
|  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
|  __fput+0x369/0x890 fs/file_table.c:510
|  task_work_run+0x160/0x1d0 kernel/task_work.c:233
|  get_signal+0xf5b/0x1120 kernel/signal.c:2810
|  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
|  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
|  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
|  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [i
e]
|  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:
[inline]
|  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
|  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
|  entry_SYSCALL_64_after_hwframe+0x77/0x7f
|
| Last potentially related work creation:
|  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
|  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
|  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
|  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
|  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
|  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
|  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
|  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
|  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
|  __fput+0x369/0x890 fs/file_table.c:510
|  task_work_run+0x160/0x1d0 kernel/task_work.c:233
|  get_signal+0xf5b/0x1120 kernel/signal.c:2810
|  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
|  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
|  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
|  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [i
e]
|  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:
[inline]
|  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
|  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
|  entry_SYSCALL_64_after_hwframe+0x77/0x7f
|
| Last potentially related work creation:
|  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
|  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
|  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
|  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
|  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
|  process_one_work kernel/workqueue.c:3326 [inline]
|  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
|  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
|  kthread+0x346/0x430 kernel/kthread.c:436
|  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
|  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
|
| The buggy address belongs to the object at ffff8881298d9400
|  which belongs to the cache kmalloc-512 of size 512
| The buggy address is located 336 bytes inside of
|  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)

Fix it by having struct l2cap_chan hold a reference to l2cap_conn
(conn_ref) when the channel is added to the connection, and releasing it
in the channel destructor. This ensures the connection remains alive as
long as the channel exists. While conn and conn_ref point to the same
object, conn being NULL indicates it being torn down, while conn_ref's
only purpose is to associate its lifetime with the parent channel.

Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channe
ls in cleanup_listen()")
Cc: <stable@vger.kernel.org>
Cc: Siwei Zhang <oss@fourdim.xyz>
Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Assisted-by: Gemini:gemini-3.1-pro-preview
Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-o
ss%40fourdim.xyz
Signed-off-by: Marco Elver <elver@google.com>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 15 +++++++++++++--
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index e0a1f2293679..de3673149deb 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -514,6 +514,7 @@ struct l2cap_seq_list {
 
 struct l2cap_chan {
 	struct l2cap_conn	*conn;
+	struct l2cap_conn	*conn_ref;
 	struct kref	kref;
 	atomic_t	nesting;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..7f331a31b723 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -422,6 +422,9 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	 */
 	l2cap_chan_lock(chan);
 
+	if (!chan->conn)
+		goto unlock;
+
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (chan->state == BT_CONNECT &&
@@ -434,10 +437,10 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	chan->ops->close(chan);
 
+unlock:
 	l2cap_chan_unlock(chan);
-	l2cap_chan_put(chan);
-
 	mutex_unlock(&conn->lock);
+	l2cap_chan_put(chan);
 }
 
 struct l2cap_chan *l2cap_chan_create(void)
@@ -490,6 +493,9 @@ static void l2cap_chan_destroy(struct kref *kref)
 	list_del(&chan->global_l);
 	write_unlock(&chan_list_lock);
 
+	if (chan->conn_ref)
+		l2cap_conn_put(chan->conn_ref);
+
 	kfree(chan);
 }
 
@@ -594,6 +600,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 	conn->disc_reason = HCI_ERROR_REMOTE_USER_TERM;
 
 	chan->conn = conn;
+	chan->conn_ref = l2cap_conn_get(conn);
 
 	switch (chan->chan_type) {
 	case L2CAP_CHAN_CONN_ORIENTED:
@@ -3160,12 +3167,16 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 	l2cap_chan_lock(chan);
 
+	if (!chan->conn)
+		goto unlock;
+
 	frames_to_ack = __seq_offset(chan, chan->buffer_seq,
 				     chan->last_acked_seq);
 
 	if (frames_to_ack)
 		l2cap_send_rr_or_rnr(chan, 0);
 
+unlock:
 	l2cap_chan_unlock(chan);
 	l2cap_chan_put(chan);
 }
-- 
2.54.0.1032.g2f8565e1d1-goog
