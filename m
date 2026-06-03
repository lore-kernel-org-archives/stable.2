Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851437204C
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 17:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780507903; cv=pass; b=YUfMehIxeahcYARJ7XBb95QqcQPspEFm8pZPE7vCzVjvYeXQ3nszS8BdGdZejZ/4+WKVX/NMDqUu2DS2+SfyVOrDqpgm7dWtLbB0+AbS2wU42NWFiKFVGSF/eQ5gQlWtKqTIP4I25tezMq2HhPju/KQtqJZCv/T6wjjtJncJ9eg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780507903; c=relaxed/simple;
	bh=puqxbyzt7x+OQz+0JxQ19LiJhiH9dXCN5KF9CiMBNOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LUyOfUU3GIEJmBOt8Udb7985Gh/NpaVlBnkLvhMkvBfQf5YvdKIU3/NyPpZ/S+Belb/j8Z6Ipvs+FQqxohn8w/DPYDVVxnDqe5VjhrL9o1sySDvIhmT0SAVQJuwOpCNLAfMGT0z/K8ypkJG59hcxoy9gh/3sqGPVY+cTB9OBpYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGTk4N6t; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGTk4N6t"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-66077f6c438so4189291d50.2
        for <stable@vger.kernel.org>; Wed, 03 Jun 2026 10:31:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780507900; cv=none;
        d=google.com; s=arc-20240605;
        b=Kdk0ZQ5CPjoJtGeRb1xlpACN36jpuLWDNSPCmE+phS51e/Fxd+nV1aM/TBoyT/j+43
         I3fONBgpcouPewJsThQMqGJp8kFe5jTR1GEpytiMFWnitdWJuctvk9QndlzZlCazGLBV
         iDVaiCsWMn5yaRNTDvrOMd9eBxvXqeNCu0E1EopMONO11uycHf5rwCNE1k+OMBp82QYA
         Tbn2gimcf+LjwCVNfcmLwd3nV1rol6TwAZj565pg6G9m6XZ4dxH0Hn1708WKExJ8bWRL
         jgr05TwukhF+aSpsKm1RBx687swi3bVTJYKbzSi5+5dUxaQriGEp+1e9/xjM4MVg4aVu
         RFcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TbrJayTIcQHeNkq60icRC6cqZUt5TN6r4XDVtlHiGvY=;
        fh=1i3f3nc9zKsEckt3w1gYtiJb/qcKXG6hT1OZN1/C5Hw=;
        b=lasiEU8sP65lSRz4BLI0OS2YXZWuPKU1/5VEx1ci08nLYVNSxxhweMjY1BfIe/3sMQ
         ZsDXL2qIFATH2s3oRc9SVswb9unNNSj+swJtR3tWMIoCbMe/Z/526sOIo3gjj+k6FfBS
         6vG/AEDnFMSQb2FSqa4/209LDIBFC2OdUD6nIniyko9rKonvkCMECxtctkOtXF3qoskN
         AMIWSOyWeV/QdMvtCqmyPljpVN/VlhVmi3aYvvJPhspprXcowCztCM3tXG2krFmd1gG1
         kJgP1Gl9jAhtTAKhVkVza/+L1uNCwFKVB0XlTobn5TX+YEBQp0lTl4xZ6vJP57tStWgf
         CQmg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780507900; x=1781112700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TbrJayTIcQHeNkq60icRC6cqZUt5TN6r4XDVtlHiGvY=;
        b=bGTk4N6t+KWBK7Chb2cTR3u6sKfRzrwE7n5Cr/z267jzXEzhiVuQcbcmiW3A0v69JO
         hax46WedkaWkaN0fHynJ1B9/w5zYajQBk1dR+xD1MYhC0MhbD520lM/IFymk/b6gA8BT
         uby9sD0OElUbEMpDYXMsx03fE1RRf0yW4zPuFP23naOPYc+zD+ZvM35k6DtYDThLGrG6
         iCpRP5o2gWPqs93Cyeyg29rJ2n0Zy13UgnGQH4sNZIVGLI4aFb1y2WdOoN/rUsIUksRT
         Q3ZNv5csyTIogt/pBMshrbOvWSDkTqCM6IisRLA5TAkJ7TfWnbI3EeIkeWA+UmKzLM6x
         46fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780507900; x=1781112700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TbrJayTIcQHeNkq60icRC6cqZUt5TN6r4XDVtlHiGvY=;
        b=nHNzLOwo6CQdYOdzrDYmNaIE/WcZ1eLMCur2Gnte58HTKadEO/FhzPWTNlqUorgnCR
         cIndKR50QpfddwEy2J8qvSM7GZUh6AEwEUygXYnf29e/gre9NCNwBV49mukmlZc1+HVq
         U6lVH9zsyb2ID2Ut3JP29nbIydqZzsXqjNPy4VDa8hNrysYkYhGAxpAE+7XbsAvzqlOT
         A6LEnzVecVKnlttVCuXslxwIRJfoSNzD16Niaror8JUWsS0BUe1cWIFkU5t3QE4kFqzJ
         tPPgyj5ISOsuqFR58NSHBWeH1lFLEle4jjteYrvx9hv23vtSaOjMg221jbeih9q1gcbA
         3x/w==
X-Forwarded-Encrypted: i=1; AFNElJ/KmI8Iz386L0g1Rix7yRrN/My9SyB+0p2nX66uqikwYjqDpavcBzj+m2jPnnQoKfMLdYTZlvc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXEAw/aE4Zdfi3FpkbknnGgOEnd1r5/cCpgVvNiq6AqDdArRZ0
	ZPf+fm+R8T501y6zdA7CTiPReBRdofqdCDlolRZSpVQqJ7IlCvMWLBuioSGUYfoLrbXyiGMz5iM
	WIpjyR6ftXYxX2KhelshxLQc6gJTMJZY=
X-Gm-Gg: Acq92OFLQfrJKb3DdwDcrACT1kSpco3lqKGT3FfLR9YxHGBRsbPUpQGdgJCztW5iiJR
	w/z1ZrwG8APA4bP+A86vPfucNxSSmdOLgj1+cXGMjBJUK/p11mtLJi1dyvkKZDHzds7EfXQsHXs
	1Stvf0//WLEkHX9MyNb1m+vHQ7tAHsbeJDlO/aIW204jS5OhTmnChyGeD1styyaHdzucUpoXdZo
	DYkCGWPzN58GhjqWQthhthRmck+OK009aQgKMh7hAEzppn1Xoz1GFT+efFWZTSDoa46XCGUup1X
	dcfbnI3DgD/uaeV6yUSrueaPtHF8zd8JCbD6StsbNjtiUpM/y10bIgFuu84CFaWXGYaeUfhPi1Z
	qh91I
X-Received: by 2002:a53:d202:0:b0:660:5df1:f23e with SMTP id
 956f58d0204a3-660dc62f0ccmr3279826d50.64.1780507899447; Wed, 03 Jun 2026
 10:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603123111.2334409-1-elver@google.com> <CANpmjNPQCx8rynFhOUfqgagP-KBh0pJsXz6PQt6G3LomdzVJYw@mail.gmail.com>
In-Reply-To: <CANpmjNPQCx8rynFhOUfqgagP-KBh0pJsXz6PQt6G3LomdzVJYw@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 3 Jun 2026 13:31:27 -0400
X-Gm-Features: AVHnY4L4IF-RSYMwA74cD4Txa8FvJHDKQxUpN_2oSS-3ijs-kM0lYTzXrlUKXgU
Message-ID: <CABBYNZL9tH1Tc+jbc6fJ-Y1EtX+_QUk_P3ghDmdOaXY0gdqtnQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix UAF in l2cap_chan_timeout
To: Marco Elver <elver@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Wed, Jun 3, 2026 at 9:16=E2=80=AFAM Marco Elver <elver@google.com> wrote=
:
>
> On Wed, 3 Jun 2026 at 14:31, Marco Elver <elver@google.com> wrote:
> >
> > l2cap_chan_timeout() accesses chan->conn without holding a reference to
> > the connection object. If l2cap_conn_del() races and tears down the
> > connection while the timer is waiting for locks, it can result in a
> > use-after-free when the timer wakes up and attempts to acquire
> > conn->lock:
> >
> > | BUG: KASAN: slab-use-after-free in instrument_atomic_read_write inclu=
de/linux/instrumented.h:112 [inline]
> > | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire in=
clude/linux/atomic/atomic-instrumented.h:4456 [inline]
> > | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/lockin=
g/mutex.c:161 [inline]
> > | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/lockin=
g/mutex.c:318
> > | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
> > |
> > | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-20=
260601-dirty #6 PREEMPT(full)
> > | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-de=
bian-1.17.0-1 04/01/2014
> > | Workqueue: events l2cap_chan_timeout
> > | Call Trace:
> > |  <TASK>
> > |  instrument_atomic_read_write include/linux/instrumented.h:112 [inlin=
e]
> > |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrume=
nted.h:4456 [inline]
> > |  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> > |  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> > |  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
> > |  process_one_work kernel/workqueue.c:3326 [inline]
> > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > |  kthread+0x346/0x430 kernel/kthread.c:436
> > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > |  </TASK>
> > |
> > | Allocated by task 320:
> > |  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
> > |  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
> > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > |  process_one_work kernel/workqueue.c:3326 [inline]
> > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > |  kthread+0x346/0x430 kernel/kthread.c:436
> > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > |
> > | Freed by task 322:
> > |  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
> > |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
> > |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> > |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> > |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> > |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> > |  __fput+0x369/0x890 fs/file_table.c:510
> > |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> > |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> > |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
> > |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> > |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> > |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [in=
line]
> > |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:2=
30 [inline]
> > |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
> > |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> > |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > |
> > | Last potentially related work creation:
> > |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> > |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> > |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> > |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> > |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> > |  process_one_work kernel/workqueue.c:3326 [inline]
> > |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> > |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> > |  kthread+0x346/0x430 kernel/kthread.c:436
> > |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> > |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> > |
> > | The buggy address belongs to the object at ffff8881298d9400
> > |  which belongs to the cache kmalloc-512 of size 512
> > | The buggy address is located 336 bytes inside of
> > |  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)
> >
> > Fix it by holding a reference to the connection when the channel timer
> > is scheduled, and releasing it when the timer is either canceled or
> > executes to completion.
> >
> > Since l2cap_chan_del() nullifies chan->conn to disassociate the channel
> > during teardown, the timer handler might read NULL from chan->conn even
> > if it held a reference. To address this, introduce a `timer_conn` field
> > to `struct l2cap_chan` to store the connection pointer associated with
> > the active timer. The timer handler uses this field to acquire locks an=
d
> > release the connection reference, and skips channel closing operations
> > if chan->conn has already been nullified by teardown.
> >
> > Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channel=
s in cleanup_listen()")
> > Cc: <stable@vger.kernel.org>
> > Cc: Siwei Zhang <oss@fourdim.xyz>
> > Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> > Assisted-by: Gemini:gemini-3.1-pro-preview
> > Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-os=
s%40fourdim.xyz
> > Signed-off-by: Marco Elver <elver@google.com>
>
> Sigh, Sashiko points out more problems here:
> https://sashiko.dev/#/patchset/20260603123111.2334409-1-elver%40google.co=
m
>
> > Can this lockless read of chan->timer_conn cause a use-after-free or do=
uble
> > free if another thread re-arms the timer concurrently?
>
> I haven't analyzed this further yet, so consider this patch a
> bug-report-only. If anyone finds a better fix sooner, please go ahead.

I was thinking or something like the following:

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c4ccfbda9d78..dfe9318272f3 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -406,17 +406,39 @@ static void l2cap_chan_timeout(struct work_struct *wo=
rk)
 {
        struct l2cap_chan *chan =3D container_of(work, struct l2cap_chan,
                                               chan_timer.work);
-       struct l2cap_conn *conn =3D chan->conn;
+       struct l2cap_conn *conn;
        int reason;

        BT_DBG("chan %p state %s", chan, state_to_string(chan->state));

+       /* Hold a reference to the connection while we are processing this
+        * timeout, to prevent it from being freed out from under us by
+        * l2cap_conn_del().
+        */
+       conn =3D l2cap_conn_hold_unless_zero(chan->conn);
        if (!conn) {
                l2cap_chan_put(chan);
                return;
        }

        mutex_lock(&conn->lock);
+
+       /* If l2cap_chan_del() was called while waiting for conn->lock the
+        * channel shall be considered already closed and its last referenc=
e
+        * shall be released with l2cap_chan_put(chan) here.
+        *
+        * l2cap_conn_del() doesn't wait the channel's works and instead ju=
st
+        * leaves the timer reference behind which needs to be released her=
e in
+        * order to free the channel and then l2cap_conn_put() to finally f=
ree
+        * the connection.
+        */
+       if (!chan->conn) {
+               mutex_unlock(&conn->lock);
+               l2cap_chan_put(chan);
+               l2cap_conn_put(conn);
+               return;
+       }
+
        /* __set_chan_timer() calls l2cap_chan_hold(chan) while scheduling
         * this work. No need to call l2cap_chan_hold(chan) here again.
         */
@@ -438,6 +460,8 @@ static void l2cap_chan_timeout(struct work_struct *work=
)
        l2cap_chan_put(chan);

        mutex_unlock(&conn->lock);
+
+       l2cap_conn_put(conn);
 }

 struct l2cap_chan *l2cap_chan_create(void)


> > ---
> >  include/net/bluetooth/l2cap.h | 18 ++++++++++++++++--
> >  net/bluetooth/l2cap_core.c    | 26 +++++++++++++++-----------
> >  2 files changed, 31 insertions(+), 13 deletions(-)
> >
> > diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2ca=
p.h
> > index e0a1f2293679..83719777512e 100644
> > --- a/include/net/bluetooth/l2cap.h
> > +++ b/include/net/bluetooth/l2cap.h
> > @@ -514,6 +514,7 @@ struct l2cap_seq_list {
> >
> >  struct l2cap_chan {
> >         struct l2cap_conn       *conn;
> > +       struct l2cap_conn       *timer_conn; /* for chan_timer */
> >         struct kref     kref;
> >         atomic_t        nesting;
> >
> > @@ -835,6 +836,9 @@ static inline void l2cap_chan_unlock(struct l2cap_c=
han *chan)
> >         mutex_unlock(&chan->lock);
> >  }
> >
> > +struct l2cap_conn *l2cap_conn_get(struct l2cap_conn *conn);
> > +void l2cap_conn_put(struct l2cap_conn *conn);
> > +
> >  static inline void l2cap_set_timer(struct l2cap_chan *chan,
> >                                    struct delayed_work *work, long time=
out)
> >  {
> > @@ -843,8 +847,13 @@ static inline void l2cap_set_timer(struct l2cap_ch=
an *chan,
> >
> >         /* If delayed work cancelled do not hold(chan)
> >            since it is already done with previous set_timer */
> > -       if (!cancel_delayed_work(work))
> > +       if (!cancel_delayed_work(work)) {
> >                 l2cap_chan_hold(chan);
> > +               if (work =3D=3D &chan->chan_timer && chan->conn) {
> > +                       l2cap_conn_get(chan->conn);
> > +                       chan->timer_conn =3D chan->conn;
> > +               }
> > +       }
> >
> >         schedule_delayed_work(work, timeout);
> >  }
> > @@ -857,8 +866,13 @@ static inline bool l2cap_clear_timer(struct l2cap_=
chan *chan,
> >         /* put(chan) if delayed work cancelled otherwise it
> >            is done in delayed work function */
> >         ret =3D cancel_delayed_work(work);
> > -       if (ret)
> > +       if (ret) {
> > +               if (work =3D=3D &chan->chan_timer && chan->timer_conn) =
{
> > +                       l2cap_conn_put(chan->timer_conn);
> > +                       chan->timer_conn =3D NULL;
> > +               }
> >                 l2cap_chan_put(chan);
> > +       }
> >
> >         return ret;
> >  }
> > diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> > index c4ccfbda9d78..491b03bf6903 100644
> > --- a/net/bluetooth/l2cap_core.c
> > +++ b/net/bluetooth/l2cap_core.c
> > @@ -406,7 +406,7 @@ static void l2cap_chan_timeout(struct work_struct *=
work)
> >  {
> >         struct l2cap_chan *chan =3D container_of(work, struct l2cap_cha=
n,
> >                                                chan_timer.work);
> > -       struct l2cap_conn *conn =3D chan->conn;
> > +       struct l2cap_conn *conn =3D chan->timer_conn;
> >         int reason;
> >
> >         BT_DBG("chan %p state %s", chan, state_to_string(chan->state));
> > @@ -421,23 +421,27 @@ static void l2cap_chan_timeout(struct work_struct=
 *work)
> >          * this work. No need to call l2cap_chan_hold(chan) here again.
> >          */
> >         l2cap_chan_lock(chan);
> > +       chan->timer_conn =3D NULL;
> > +
> > +       if (chan->conn) {
> > +               if (chan->state =3D=3D BT_CONNECTED || chan->state =3D=
=3D BT_CONFIG)
> > +                       reason =3D ECONNREFUSED;
> > +               else if (chan->state =3D=3D BT_CONNECT &&
> > +                        chan->sec_level !=3D BT_SECURITY_SDP)
> > +                       reason =3D ECONNREFUSED;
> > +               else
> > +                       reason =3D ETIMEDOUT;
> >
> > -       if (chan->state =3D=3D BT_CONNECTED || chan->state =3D=3D BT_CO=
NFIG)
> > -               reason =3D ECONNREFUSED;
> > -       else if (chan->state =3D=3D BT_CONNECT &&
> > -                chan->sec_level !=3D BT_SECURITY_SDP)
> > -               reason =3D ECONNREFUSED;
> > -       else
> > -               reason =3D ETIMEDOUT;
> > -
> > -       l2cap_chan_close(chan, reason);
> > +               l2cap_chan_close(chan, reason);
> >
> > -       chan->ops->close(chan);
> > +               chan->ops->close(chan);
> > +       }
> >
> >         l2cap_chan_unlock(chan);
> >         l2cap_chan_put(chan);
> >
> >         mutex_unlock(&conn->lock);
> > +       l2cap_conn_put(conn);
> >  }
> >
> >  struct l2cap_chan *l2cap_chan_create(void)
> > --
> > 2.54.0.1013.g208068f2d8-goog
> >



--=20
Luiz Augusto von Dentz
