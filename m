Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E048032C
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 14:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582265; cv=pass; b=n+/c9Zj3jNJhyYnOTLKKr8Lgc6i2SJZzoCogaEWsq3X0e74+jjNey64MnInbuGXEvDwmM52VeFY4ZG8yzFJcTf4rgoMjZjCeaACL+xH007l18jv+B3vSPxNM1C/6+g+5arBev99nZJdzB3GqedLmkapyr/+bRriMJvT4nZWJjbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582265; c=relaxed/simple;
	bh=wypWffxnDNTSiB8taBVqAMgSLfKvk6rwhKySNic+1ss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oz4PujcSNOIoDe/hLFkkjIuFp9wOULQNTwbjV4d20OBbTtXVe/t2fBVFYSVFwgS/GA0eNTXNQv/0G8YHVEEVVxfxym5NsLc79FSKzPwt+5hp72ujuTgxAI6HdvhvhhE34Sfn9pKG76mTKsFQ/g5/HGibjRu39WNf5V8ucqupPBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yn3D08zq; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yn3D08zq"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-66043ecf6b3so889113d50.0
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 07:11:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780582260; cv=none;
        d=google.com; s=arc-20240605;
        b=LXCX9egBKmkDGQEJUx3Wvn+ICG+JeaCEZAgElTgKWM7hnIscU6NbWSTktPt7b+uq7l
         cV3ne0SKHONxSbTdwU239CsAJ7qIoyyMCAf2a7UOR+bcohZdf4XT6ID4uhr1fDd5zQSN
         wMMHWcKeH1QBqD4DDMylD+HJuK6lVkQNg9x8L+qtyZDFpb4EmkrlAsYrzlObS67lDMlg
         rtSfyFFH2vfX8zt8nddM44P2zfwIxunWAtL7UW8kA0lsqBVTZc8x5Ja7YWvw5QutN/Rx
         oyAxGQyIA1ddxXQi/Qfqe+ev6FnpZ5h0x9ebWVvTPVE8ECUysUjHBmieGXr26czuow4g
         FAZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7yHa51Mj+ewc0UTc1c2Cz+lJ0RiTZkofDwbf0p3+F6g=;
        fh=uyGAvxCr4/PCTFEoGioK7bE+8YXNp7exH0N9VE0j34U=;
        b=JeDSSoaj5Dp8CxzhM2Z+V2/p6tjv4oGry4/dDtdY2Ej3cVV+d3ypfBYgkTd7OEOdAv
         7VHUCVn3kVofrbSESiy5R9+LPKSX16g16tJWp4TWKBOPLUe3aFEjQX+HhkaYOrAKQIvj
         fvVmdtwmy3nnM/Y9xQ9Q4FoTbYrpS/WnOQjqEac5XG2o49vRblfDslXksYFuaIPnTARs
         6mNVwmqCTj4n8qWFCe2Wf+8RyLBDfKn0B6MftjfeDx6is+dgY6RDxupdjez3wb4x59xQ
         DNGbeQ+0cedzdBa7nCaCPHMA5uUVMa6XAyfJBn31XO7HlQP3Wd9iLWsVUVgcLcs0yVQg
         SbYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780582260; x=1781187060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yHa51Mj+ewc0UTc1c2Cz+lJ0RiTZkofDwbf0p3+F6g=;
        b=Yn3D08zqMLqoHDAYGPLWfzim/Ls/nIopiTW8BQ1m7Y9E0KfS9Ebu1cmu3LhV0LA2rm
         1BpMR+7rtKxn9x3yPxNUJp5tf0TuPynmsO86ZMTVVhEa7XF6Ty0Xj1Al7Ai24rdL73yf
         4eJvsIqD0BWA3v5Uavbl7QRM6sQCXejvqlV2wKDkbwzzDYwsg/ydRFT6nNJfWXH+z5/F
         c7CDlj5iMhdKyl3ZswcuF7Va1JB9eOrUmExN3bHb+198tnJ5hyrDfXE1gEE5V9evxoRm
         rvtMPja+PQ2FZn07+Sz6TXmnjf6VowyoROwHVCScHZBwk3Etn8+eIbl15x1jp5JvAfbh
         tN+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780582260; x=1781187060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7yHa51Mj+ewc0UTc1c2Cz+lJ0RiTZkofDwbf0p3+F6g=;
        b=I8JuvcS6U4TYOaavxxxMGJTrkIuZhcKycCBlXcBW+fXPS7qUfTQg2AnaaqJ/LoXIBL
         1TPjYaRZdPd3R6N8KxYYYy0zHk8NkPYZcSgA0maEBsV9Bkv087fY790L3WhasgC1Ward
         pW3c2jeJC28wQLiTMWCJc2cO3smYbs2wDc3gGfaVnqqEEjGfXaZQqKPuw2Qk7XAC7o7g
         Xt0AM2+6OjJICrWfrX15/2ZFKT+zVr4Ec1W1gxUgIrW/FqCg7pxMVgIQJLXiRwlQytR6
         Bb+tSAvQ4MjRQXfD2SrKoDEjBWCytb0HLi767HczZzvGvB1Xia5YlLufiwZUcYQOFkhr
         cFdw==
X-Forwarded-Encrypted: i=1; AFNElJ9tuYyH5byuh3Qp1XL7YnCbn9ZnlWo63VvIHqX17GQguA1bAXR2hprp12eVgc7AUmObAnQoCR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywMkOzdWLRDo8z1IfLKUUcvoaAkJ4cEJ81GszF0UKFpI/WXyEg
	7cOzHH8tTEns1ceAanZkXQCPVK/4Ke8YunTC/beM/IWHjDAuRW4jDapYUp3bojDhA77ELpTJQL4
	tPsItmb8IcltcnQ902kkVuinhXmebKB4=
X-Gm-Gg: Acq92OGo5FDPWAOSt8wuytTjIlvx3FKtekCQpZoJFE522e8Ky84kA6yV5CWoy/f4gwc
	Yt1dBuBZQkbYj+DNI+dNjSVyQ0tYOLhB/M6gYYK0lw/ehdfF426umToUeRwHcH0YH7/XGCwXUE9
	IRsNonMqd6G0bzLMtVCtmIH50nb1W3V0CUnHcpq5WvnulNdSG0rGUpNizju8iW4DackYImDSkIJ
	o/GiB2+SjGfoL3KvGUUV+9FAGjE5M8YYuxV3xvJlG5Qvh39SGOcUSiJ0TyAykXooCuvDKMJJZtH
	ouYiSFn4SJ8+8NIyzVixEvAdgyzrEuFrE5pB0bSDhUXOjdIUmxMyacSjip8K0REoJL08Ux2b3oG
	LBg==
X-Received: by 2002:a53:ef83:0:b0:65e:4272:2eb8 with SMTP id
 956f58d0204a3-660dc62f0a8mr5746510d50.65.1780582260125; Thu, 04 Jun 2026
 07:11:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603123111.2334409-1-elver@google.com> <CANpmjNPQCx8rynFhOUfqgagP-KBh0pJsXz6PQt6G3LomdzVJYw@mail.gmail.com>
 <CABBYNZL9tH1Tc+jbc6fJ-Y1EtX+_QUk_P3ghDmdOaXY0gdqtnQ@mail.gmail.com> <aiFzWTYs1ppHhnNS@elver.google.com>
In-Reply-To: <aiFzWTYs1ppHhnNS@elver.google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 4 Jun 2026 10:10:47 -0400
X-Gm-Features: AVHnY4Ij8uki-OEkVLkPvr2tG07yagjQEUhyfT8i2DAZ0c58nSOGhYZNdMOegQM
Message-ID: <CABBYNZLvDNPM9YXa+Whbx=+4Cgy-rp+pVVv0J0M52DsUMcQ8NQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
To: Marco Elver <elver@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Thu, Jun 4, 2026 at 8:45=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Wed, Jun 03, 2026 at 01:31PM -0400, Luiz Augusto von Dentz wrote:
> > Hi Marco,
> >
> > On Wed, Jun 3, 2026 at 9:16=E2=80=AFAM Marco Elver <elver@google.com> w=
rote:
> > >
> > > On Wed, 3 Jun 2026 at 14:31, Marco Elver <elver@google.com> wrote:
> > > >
> > > > l2cap_chan_timeout() accesses chan->conn without holding a referenc=
e to
> > > > the connection object. If l2cap_conn_del() races and tears down the
> > > > connection while the timer is waiting for locks, it can result in a
> > > > use-after-free when the timer wakes up and attempts to acquire
> > > > conn->lock:
> > > >
> > > > | BUG: KASAN: slab-use-after-free in instrument_atomic_read_write i=
nclude/linux/instrumented.h:112 [inline]
> > > > | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquir=
e include/linux/atomic/atomic-instrumented.h:4456 [inline]
> > > > | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/lo=
cking/mutex.c:161 [inline]
> > > > | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/lo=
cking/mutex.c:318
> > > > | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
> > > > |
> > > > | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-nex=
t-20260601-dirty #6 PREEMPT(full)
> > > > | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.=
0-debian-1.17.0-1 04/01/2014
> > > > | Workqueue: events l2cap_chan_timeout
> > > > | Call Trace:
> > > > |  <TASK>
> > > > |  instrument_atomic_read_write include/linux/instrumented.h:112 [i=
nline]
> > > > |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-inst=
rumented.h:4456 [inline]
> > > > |  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> > > > |  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> > > > |  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
> > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > |  </TASK>
> > > > |
> > > > | Allocated by task 320:
> > > > |  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
> > > > |  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
> > > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:37=
60
> > > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > |
> > > > | Freed by task 322:
> > > > |  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
> > > > |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
> > > > |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> > > > |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> > > > |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> > > > |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> > > > |  __fput+0x369/0x890 fs/file_table.c:510
> > > > |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> > > > |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> > > > |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:33=
7
> > > > |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> > > > |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> > > > |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207=
 [inline]
> > > > |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common=
.h:230 [inline]
> > > > |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inli=
ne]
> > > > |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> > > > |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > |
> > > > | Last potentially related work creation:
> > > > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > > > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:37=
60
> > > > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > > > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > > > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > > > |  process_one_work kernel/workqueue.c:3326 [inline]
> > > > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > > > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > > > |  kthread+0x346/0x430 kernel/kthread.c:436
> > > > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > > > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > > > |
> > > > | The buggy address belongs to the object at ffff8881298d9400
> > > > |  which belongs to the cache kmalloc-512 of size 512
> > > > | The buggy address is located 336 bytes inside of
> > > > |  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)
> > > >
> > > > Fix it by holding a reference to the connection when the channel ti=
mer
> > > > is scheduled, and releasing it when the timer is either canceled or
> > > > executes to completion.
> > > >
> > > > Since l2cap_chan_del() nullifies chan->conn to disassociate the cha=
nnel
> > > > during teardown, the timer handler might read NULL from chan->conn =
even
> > > > if it held a reference. To address this, introduce a `timer_conn` f=
ield
> > > > to `struct l2cap_chan` to store the connection pointer associated w=
ith
> > > > the active timer. The timer handler uses this field to acquire lock=
s and
> > > > release the connection reference, and skips channel closing operati=
ons
> > > > if chan->conn has already been nullified by teardown.
> > > >
> > > > Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close cha=
nnels in cleanup_listen()")
> > > > Cc: <stable@vger.kernel.org>
> > > > Cc: Siwei Zhang <oss@fourdim.xyz>
> > > > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > > > Assisted-by: Gemini:gemini-3.1-pro-preview
> > > > Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-=
1-oss%40fourdim.xyz
> > > > Signed-off-by: Marco Elver <elver@google.com>
> > >
> > > Sigh, Sashiko points out more problems here:
> > > https://sashiko.dev/#/patchset/20260603123111.2334409-1-elver%40googl=
e.com
> > >
> > > > Can this lockless read of chan->timer_conn cause a use-after-free o=
r double
> > > > free if another thread re-arms the timer concurrently?
> > >
> > > I haven't analyzed this further yet, so consider this patch a
> > > bug-report-only. If anyone finds a better fix sooner, please go ahead=
.
> >
> > I was thinking or something like the following:
>
> I tested that and my repro didn't trigger the UAF here, but I still
> think it has the same fundamental issue:
>
> If the timer worker is preempted immediately after reading chan->conn
> but before entering l2cap_conn_hold_unless_zero(), l2cap_conn_del() can
> complete concurrently.
>
> When the timer worker resumes, l2cap_conn_hold_unless_zero(conn) will
> attempt to read conn->ref that has already been freed, resulting in
> another UAF.

I see. The window is very narrow but it is perhaps still triggerable
somehow. The only thing that comes to mind is that we would need to
take a reference of l2cap_conn with the likes of l2cap_set_timer then,
which means l2cap_chan_timeout needs to drop not only l2cap_chan but
also l2cap_conn when done, otherwise there will always be the risk of
l2cap_conn_del running while l2cap_chan_timeout is pending.

--=20
Luiz Augusto von Dentz
