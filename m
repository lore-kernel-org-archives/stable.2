Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACD47A0B2
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 12:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780577125; cv=none; b=hgeARcUXpkhPwWYjjnstiMgnQj0Awq32AXE0JMBgDR6OYTNV9xrZlTtLgbz+I1x7io9MOER04jbQ+p2xDZC6KjIaOz9gfUATgtUTOaFDCDFK58IgyngaQjOIn8QEV85OFxjpHpjNGNbIKIZeQnFVBer4RuoflcfLYAjfCCi+328=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780577125; c=relaxed/simple;
	bh=ZvXAkuk7MLe0QcXbu4Nybd8XJ6cOO9jrhq2UI94xiw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=blF0TRCtiR9PkJrmubDZsGLDISzEnNriLC5ITQuj/H5leEbsvjiIwRnL9CcOMOLnWpKXbKemGDhRAmiy0SL4wHBKZP9fUoB/AF29NUdzDSjf3Fk+sA2s9aJ+dzGzbpITq4XT8ee5vBrNd4BkAQhLPrNMWli2J/RCHCu5MZi5y3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=olJ8lHLl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="olJ8lHLl"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b43e2b95so5662745e9.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780577121; x=1781181921; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gt1BCM4pflnoVuLFX2pdgCZ8sTCZUXmk7JQn92eThmw=;
        b=olJ8lHLlU5k/hPBwrpHDY0v/WPJFiV+xtmPCCrVVAdGNkNxhY76KsRjAHnEUisy5ag
         mQifm53WCwERGHpNCHNVHnYE5iCq2sRJ33GS7CeyLsw9Lck5jEA47zPmobLC05279L4m
         2wYi8BXjN7qa9SA3F4v1gBz5dV3eBhxVE2BN0Qp/kksvE+Y1XQ/udUsZRAz/OcRBxvc5
         g9lOlwGPijCQr9vQmCTHLybFiI9Nrtj/z7oQSlxHPhfv3tAt2iMMK9QPSZKr4kFaGRNb
         UZWKE7DJTpDZM1o80J1EUq0OsW1sC/U0wsB/vpJZoC8sdgIdpirF09kWrRDJyFDQeRo7
         SaaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780577121; x=1781181921;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt1BCM4pflnoVuLFX2pdgCZ8sTCZUXmk7JQn92eThmw=;
        b=ipBrHP/HGBGDWcOf7UFoL1bl+LU6T0V3p5XV/Y0insjtqbw489mXn//BOrHISn5Glc
         SpvbB+zc60N1WpGEH7GUeeiqWa53aXKb4Jba1pnImqfo8Uun6folMZz1+cWDYerSmuBw
         tfmArRvUUIr83uCFQTu5QXQEhorFK2OG61ykaq+ssEQxs7ico8L25iC4cx0BJJNIxSpT
         A+j5sKJIh/pMGS7fo4v83QPHj/6XEZUR61YzH5BwJGYdZkAyfWsXQhBx1jO+Sq4x/JO5
         vQS82ipwevXbJr845mz4jR2qMlfiYHo7+TJrEvU8/L0cYusbdK48yoFLJvbNq54240Xg
         3P/g==
X-Forwarded-Encrypted: i=1; AFNElJ+08tLmUm7tQOnNmhAJv49Tmm3/xZ/+/Rnja3QhYDuPJK73jf7qOBI7rrizp93xogDtcw9EISo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwODSwAvmZIKXhiQgDmqSKFChbtO2S+1Fkz86LHH4GrNmEYbsY9
	GBZPLxggrHrT87n8qtC5Ji7GBt2ZoE9Ixr4+1QXYeSD2O3sltnMlM/4YYJJqekISAQ==
X-Gm-Gg: Acq92OHQdsGRBNfqWtgjFMJGJDywwrslyOM2wh10vfw0hBz6cve6iiEYSbn0GzEzOtv
	sfirjq5DpKWc17Ym1UrHV3hnxP0RuhG8g6N0xH8NkKDfcyLfKZabZBF5/HeqiEBu0LdoxDMFvTF
	wu9wOXhl0JfWVSu+H09vmichRMMviWDyl2sygmyQ4q0atIyItinBI7GN7ND9FoyEsECVFQehymk
	T7ioDuG8CWjfefStfgM0AO/QuVYfweTl/srhgCwUAN20DmFcctbqSUReXX3HcKocoPIM6hxOLfc
	BxoEJgZ7YBcXO27HsFroQeXbbFEspVbIpQJyb28jAOkwCzlMRwhWUxqcJjVxzmHmqDX1n+Y2URq
	XKriysbFn/Z6/hub5DVTGbrtN3G9CMYmLCQDazcYrDXp8RlwcADcdOuK3kTyiOr5cbBHBRL6PQQ
	ohIXxnI6xzXo4UsDChtHuNYvRaM4VSxsSx5632jOWecNopsEXbDy1tg3/kqASvleSZjWoDb5g=
X-Received: by 2002:a05:600c:8b48:b0:48f:d612:3c59 with SMTP id 5b1f17b1804b1-490b5ea6ddbmr131122095e9.9.1780577120514;
        Thu, 04 Jun 2026 05:45:20 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:2834:9:108e:a0d3:fede:9c88])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm26439752f8f.29.2026.06.04.05.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 05:45:19 -0700 (PDT)
Date: Thu, 4 Jun 2026 14:45:13 +0200
From: Marco Elver <elver@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
Message-ID: <aiFzWTYs1ppHhnNS@elver.google.com>
References: <20260603123111.2334409-1-elver@google.com>
 <CANpmjNPQCx8rynFhOUfqgagP-KBh0pJsXz6PQt6G3LomdzVJYw@mail.gmail.com>
 <CABBYNZL9tH1Tc+jbc6fJ-Y1EtX+_QUk_P3ghDmdOaXY0gdqtnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABBYNZL9tH1Tc+jbc6fJ-Y1EtX+_QUk_P3ghDmdOaXY0gdqtnQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Wed, Jun 03, 2026 at 01:31PM -0400, Luiz Augusto von Dentz wrote:
> Hi Marco,
> 
> On Wed, Jun 3, 2026 at 9:16 AM Marco Elver <elver@google.com> wrote:
> >
> > On Wed, 3 Jun 2026 at 14:31, Marco Elver <elver@google.com> wrote:
> > >
> > > l2cap_chan_timeout() accesses chan->conn without holding a reference to
> > > the connection object. If l2cap_conn_del() races and tears down the
> > > connection while the timer is waiting for locks, it can result in a
> > > use-after-free when the timer wakes up and attempts to acquire
> > > conn->lock:
> > >
> > > | BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> > > | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
> > > | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> > > | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> > > | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
> > > |
> > > | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20260601-dirty #6 PREEMPT(full)
> > > | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
> > > | Workqueue: events l2cap_chan_timeout
> > > | Call Trace:
> > > |  <TASK>
> > > |  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> > > |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrumented.h:4456 [inline]
> > > |  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> > > |  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> > > |  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
> > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > |  </TASK>
> > > |
> > > | Allocated by task 320:
> > > |  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
> > > |  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
> > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > |
> > > | Freed by task 322:
> > > |  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
> > > |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
> > > |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> > > |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> > > |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> > > |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> > > |  __fput+0x369/0x890 fs/file_table.c:510
> > > |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> > > |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> > > |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
> > > |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> > > |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> > > |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
> > > |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
> > > |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
> > > |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> > > |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > |
> > > | Last potentially related work creation:
> > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > |
> > > | The buggy address belongs to the object at ffff8881298d9400
> > > |  which belongs to the cache kmalloc-512 of size 512
> > > | The buggy address is located 336 bytes inside of
> > > |  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)
> > >
> > > Fix it by holding a reference to the connection when the channel timer
> > > is scheduled, and releasing it when the timer is either canceled or
> > > executes to completion.
> > >
> > > Since l2cap_chan_del() nullifies chan->conn to disassociate the channel
> > > during teardown, the timer handler might read NULL from chan->conn even
> > > if it held a reference. To address this, introduce a `timer_conn` field
> > > to `struct l2cap_chan` to store the connection pointer associated with
> > > the active timer. The timer handler uses this field to acquire locks and
> > > release the connection reference, and skips channel closing operations
> > > if chan->conn has already been nullified by teardown.
> > >
> > > Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()")
> > > Cc: <stable@vger.kernel.org>
> > > Cc: Siwei Zhang <oss@fourdim.xyz>
> > > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%40fourdim.xyz
> > > Signed-off-by: Marco Elver <elver@google.com>
> >
> > Sigh, Sashiko points out more problems here:
> > https://sashiko.dev/#/patchset/20260603123111.2334409-1-elver%40google.com
> >
> > > Can this lockless read of chan->timer_conn cause a use-after-free or double
> > > free if another thread re-arms the timer concurrently?
> >
> > I haven't analyzed this further yet, so consider this patch a
> > bug-report-only. If anyone finds a better fix sooner, please go ahead.
> 
> I was thinking or something like the following:

I tested that and my repro didn't trigger the UAF here, but I still
think it has the same fundamental issue:

If the timer worker is preempted immediately after reading chan->conn
but before entering l2cap_conn_hold_unless_zero(), l2cap_conn_del() can
complete concurrently.

When the timer worker resumes, l2cap_conn_hold_unless_zero(conn) will
attempt to read conn->ref that has already been freed, resulting in
another UAF.
