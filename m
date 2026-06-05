Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A9827707
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 15:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780674486; cv=pass; b=Xb+TdQYTGqqParHUTYu7Xgz9UQ/+ZvulV0RRa9npJejKzV1y135hZJS/0/GOtDzwOHCzk/owqaD+swTKHSi+UEzBNvGNpOvQMF6Scbs88h0QzJT9GVC3lI1HZwp22XaPHc8S5suV4wMNgdjBvyzRQdtLOwKNvw4ugpvcF/7MWoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780674486; c=relaxed/simple;
	bh=IR6eT2UVdxHyciodotpVOxf0NuAYeSplYoTNsdVM5hw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSFNDi+X1EyUwidouBbb5H+6mLuNs7LOvOzb3eyTsE32fCYSHjb596oMg8z2zirHOcRRwGKYAexCJq0kD9Fc42/SNlE4+fO3H+7kvHnHygVp8Y5HSIlAw8WDqAgnW+zRFBd2+DIKeSK7T8j1RWsyuDq7PzLfERa39W2D0fByP6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PM8FS811; arc=pass smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PM8FS811"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6608c1a4215so2672332d50.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 08:48:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780674484; cv=none;
        d=google.com; s=arc-20240605;
        b=Gu7DT1zhQm1ql5iAGCwT7hXq51snnisw/2MIs9ZotGyGQNshk9S0oKMGDkMjBn3tHC
         8tNCtbJICOw68FlWEyrQJX3ol7B+NzlMxG3yxM32ayXuwFRH5E69gecj0fYBHXqQvl01
         YyMn5gcqabXz2BKTvJrcV3qmEUBuN9MPcHhnH75W+0R3O7BpI8uvpfXS3VsrkDPvZLpW
         CMju+ZnflBlh6LtSgJuD6fswbBbHs9tVfkCO94kqghyY60ws+r6ESKFjW5/jkyMeCJb9
         4Q2h7IMkfYpWFfxpO7+XpF24Wd/2auS6QxBm90qFWPBDTIQtRwMeLWU+a4kWnqeDsvrW
         bAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ms2bieqSgrrjysUKk+Fz/MYSlh7WwRNqDIjqB56+mVg=;
        fh=/YIw60XMKA4+hK6veiVSw3ov8LpWI6vnpwGMsdZBucg=;
        b=fNqdiGGtyfWCwsQmMyaHMnB8Oi1mQq0/gZjXxvqC6Tw5QY66lJuAFsJSAxfICagwqL
         mWcgDJc/QRJkQXhgaRwecr7Q8D8XUcfgRZDc3ZLbIhoLrPDE32eaE917W1usKrGzGwZc
         uPtNgGJ9deNyQsCO7hN8ssdhP1UiV1OJKFFGsVA3gYgkiWG4LsgJ2+e7O2dt8t7sR9N3
         KqIJU1bGNOnLqB0K3gx87HkFQ+9U+oYmBTGtcROsAupTOupOwUC8/Z4+yxjWip8QpgGQ
         M05ReyxNtshKn+z8Og7D/R5tf6A48BcwwjaZjO4NMLJskc3D++qTF481EyiW+51vIZFU
         haBA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780674484; x=1781279284; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ms2bieqSgrrjysUKk+Fz/MYSlh7WwRNqDIjqB56+mVg=;
        b=PM8FS811d6PlNardB8maxo7tixoYQ05IrVySuP/j9yUEUZsRZG9Kuouu3rN+6VPQ44
         nzDD7+Jx4jKEIM8LkGnSthkjkCMDFWiFBqrhcQ0p+PJcha6BOytIfy+roby1W6i1+jUi
         B2iXS7AAeCCE10GsekXg7phhKEiUXm955Tk1+B8lnWvX6yFsqkPyg70y8JAmIePhH5US
         twOoEnIFUZK+icDuA3u4xwMZgVQ6F5BGvCeE7n3Is38iHq6v5N80ONL2cQkGT8dtJdl4
         gvhtlrD1u6uzA9JBvtz7XOT5ZKrILJ1m6yXSL0iGlHT9n5rKS6pqDAj3yuYPyUzrkt8Q
         aXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780674484; x=1781279284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ms2bieqSgrrjysUKk+Fz/MYSlh7WwRNqDIjqB56+mVg=;
        b=CypZeRqHQ984XmT7NS53qFX7JH4Ww9QN3GMjRKA8ILfTX+Ebj/fhG6Dx1Yc9+vcewq
         Sd7YkYU1Zcgrdnnek0E/tfjiB+mh8C//gXY/Cc7nBmvN7k3QLELhrY9IS4Yc5aeV4oU5
         HORLEma/I+IKu6DHi2RiGuegXiVE+p8QTfLcjwHWeXGepYlY3e++aDS2Imwl+AD4YSdv
         +KPMbD4jhoqCC0iXN8LaRLSAxX+168s0uFkq0/P7Uy4/J5ClPj7wA/YM5zkru0QzbQB+
         r0fGHV5xASScjUzoPmp79s3ceotm4aRRWRZ2XdSdyaHmR40ZFGs5A8ugMsgOeapgdy+m
         +v3A==
X-Forwarded-Encrypted: i=1; AFNElJ9wdvuAvKL45MqyZkrG8/VLtbOs9xTXcvTyj7Bsn9NvG1/ZLQmqH5fsZXaH2HHGSx7WxBvtDFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEbnqQPVlPbQsE+gmBD+DHBHiXmVnm9U0Xvqoglzr45TTfrT6U
	0Ps+sLBY+WX+CyU1UG0VXEW/v7QRSIjPnp6BdZVEZZBmchSY7/VnbAqhvT+5OvUvCIZqnzsN6Ax
	vVn1quTw/AO8T9JFVPaMuqbAETvqetp8=
X-Gm-Gg: Acq92OH7tjsHMkkKhHRJBxSRpeWDxM+dBrANRwfUnYx0fAKP3NviHkYLdDH3srXUC0t
	f9KKiQF24As2DkaIwWG7elompnWEADNYwFzQzKDmewFeutSfW6dlH2GWmWqRnapJnRHB8l7aRWF
	PsmMvxRI4TTBwT+K3IkOpx1vzbKHcUHqvxxyLVMFx/ZBkiPpiX5cTBa+1HqTiudTLWXQNKIALYX
	Sb9SysGn6el2MV5Sx5lbZtiAhwA+U3smLJ9y3Yh+IFwqVZBvwurIJgo6kR/DxpqU2N7Ul6iD0Ky
	++gGTNKCdnpdrnd2s0mLL+gxhqXRS1eaGzC2CbdIjBsTr8q0cDlqA338VqWSZeoSa9bmkaFUlfy
	dLA==
X-Received: by 2002:a05:690e:b86:b0:660:548f:cbac with SMTP id
 956f58d0204a3-6610a628509mr2389717d50.3.1780674483861; Fri, 05 Jun 2026
 08:48:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605142351.2306664-1-elver@google.com>
In-Reply-To: <20260605142351.2306664-1-elver@google.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 5 Jun 2026 11:47:49 -0400
X-Gm-Features: AVHnY4LAye_ozAu6FsiIEvB25RSlwUGq2L_dc6z7nzrI85rUTFoZaOISD3ek2dY
Message-ID: <CABBYNZKRHj0z6n9kJhOST53tpnbpS1wikgB-sjanZaYdXxNk+w@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: Fix UAF in channel timeout by
 holding conn ref
To: Marco Elver <elver@google.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, 
	stable@vger.kernel.org, Siwei Zhang <oss@fourdim.xyz>, 
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Marco,

On Fri, Jun 5, 2026 at 10:23=E2=80=AFAM Marco Elver <elver@google.com> wrot=
e:
>
> l2cap_chan_timeout() runs asynchronously and accesses chan->conn. If
> the connection is torn down while the timer is running or pending,
> chan->conn can be freed, leading to a use-after-free when the timer
> worker attempts to lock conn->lock:
>
> | BUG: KASAN: slab-use-after-free in instrument_atomic_read_write include=
/linux/instrumented.h:112 [inline]
> | BUG: KASAN: slab-use-after-free in atomic_long_try_cmpxchg_acquire incl=
ude/linux/atomic/atomic-instrumented.h:4456 [inline]
> | BUG: KASAN: slab-use-after-free in __mutex_trylock_fast kernel/locking/=
mutex.c:161 [inline]
> | BUG: KASAN: slab-use-after-free in mutex_lock+0x4f/0xa0 kernel/locking/=
mutex.c:318
> | Write of size 8 at addr ffff8881298d9550 by task kworker/2:1/83
> |
> | CPU: 2 UID: 0 PID: 83 Comm: kworker/2:1 Not tainted 7.1.0-rc6-next-2026=
0601-dirty #6 PREEMPT(full)
> | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debi=
an-1.17.0-1 04/01/2014
> | Workqueue: events l2cap_chan_timeout
> | Call Trace:
> |  <TASK>
> |  instrument_atomic_read_write include/linux/instrumented.h:112 [inline]
> |  atomic_long_try_cmpxchg_acquire include/linux/atomic/atomic-instrument=
ed.h:4456 [inline]
> |  __mutex_trylock_fast kernel/locking/mutex.c:161 [inline]
> |  mutex_lock+0x4f/0xa0 kernel/locking/mutex.c:318
> |  l2cap_chan_timeout+0x5d/0x1b0 net/bluetooth/l2cap_core.c:422
> |  process_one_work kernel/workqueue.c:3326 [inline]
> |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> |  kthread+0x346/0x430 kernel/kthread.c:436
> |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> |  </TASK>
> |
> | Allocated by task 320:
> |  l2cap_conn_add+0xa7/0x820 net/bluetooth/l2cap_core.c:7075
> |  l2cap_connect_cfm+0xdb/0xd70 net/bluetooth/l2cap_core.c:7452
> |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> |  process_one_work kernel/workqueue.c:3326 [inline]
> |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> |  kthread+0x346/0x430 kernel/kthread.c:436
> |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> |
> | Freed by task 322:
> |  hci_disconn_cfm include/net/bluetooth/hci_core.h:2154 [inline]
> |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
> |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> |  __fput+0x369/0x890 fs/file_table.c:510
> |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
> |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [i
> e]
> |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:
> [inline]
> |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
> |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> |
> | Last potentially related work creation:
> |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> |  process_one_work kernel/workqueue.c:3326 [inline]
> |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> |  kthread+0x346/0x430 kernel/kthread.c:436
> |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> |  hci_conn_hash_flush+0x101/0x1f0 net/bluetooth/hci_conn.c:2736
> |  hci_dev_close_sync+0x889/0xde0 net/bluetooth/hci_sync.c:5405
> |  hci_dev_do_close net/bluetooth/hci_core.c:502 [inline]
> |  hci_unregister_dev+0x1f7/0x370 net/bluetooth/hci_core.c:2679
> |  vhci_release+0x12a/0x180 drivers/bluetooth/hci_vhci.c:690
> |  __fput+0x369/0x890 fs/file_table.c:510
> |  task_work_run+0x160/0x1d0 kernel/task_work.c:233
> |  get_signal+0xf5b/0x1120 kernel/signal.c:2810
> |  arch_do_signal_or_restart+0x4d/0x600 arch/x86/kernel/signal.c:337
> |  __exit_to_user_mode_loop kernel/entry/common.c:64 [inline]
> |  exit_to_user_mode_loop+0x85/0x510 kernel/entry/common.c:98
> |  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [i
> e]
> |  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:
> [inline]
> |  syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
> |  do_syscall_64+0x263/0x3d0 arch/x86/entry/syscall_64.c:100
> |  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> |
> | Last potentially related work creation:
> |  hci_connect_cfm include/net/bluetooth/hci_core.h:2139 [inline]
> |  hci_remote_features_evt+0x52f/0x9f0 net/bluetooth/hci_event.c:3760
> |  hci_event_func net/bluetooth/hci_event.c:7796 [inline]
> |  hci_event_packet+0x561/0xa70 net/bluetooth/hci_event.c:7847
> |  hci_rx_work+0x370/0x890 net/bluetooth/hci_core.c:4040
> |  process_one_work kernel/workqueue.c:3326 [inline]
> |  process_scheduled_works+0x7c8/0xfb0 kernel/workqueue.c:3409
> |  worker_thread+0x8a9/0xcf0 kernel/workqueue.c:3490
> |  kthread+0x346/0x430 kernel/kthread.c:436
> |  ret_from_fork+0x1a3/0x470 arch/x86/kernel/process.c:158
> |  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> |
> | The buggy address belongs to the object at ffff8881298d9400
> |  which belongs to the cache kmalloc-512 of size 512
> | The buggy address is located 336 bytes inside of
> |  freed 512-byte region [ffff8881298d9400, ffff8881298d9600)
>
> Fix it by having struct l2cap_chan hold a reference to l2cap_conn
> (conn_ref) when the channel is added to the connection, and releasing it
> in the channel destructor. This ensures the connection remains alive as
> long as the channel exists. While conn and conn_ref point to the same
> object, conn being NULL indicates it being torn down, while conn_ref's
> only purpose is to associate its lifetime with the parent channel.
>
> Fixes: 75780ca4c6a8 ("Bluetooth: L2CAP: use chan timer to close channels =
in cleanup_listen()")
> Cc: <stable@vger.kernel.org>
> Cc: Siwei Zhang <oss@fourdim.xyz>
> Cc: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Reported-by: https://sashiko.dev/#/patchset/20260521021249.3258069-1-oss%=
40fourdim.xyz
> Signed-off-by: Marco Elver <elver@google.com>
> ---
> v2:
> * Fix UAF in channel timeout by holding conn ref.
>
> v1: https://lore.kernel.org/r/20260603123111.2334409-1-elver@google.com
> ---
>  include/net/bluetooth/l2cap.h |  1 +
>  net/bluetooth/l2cap_core.c    | 15 +++++++++++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.=
h
> index e0a1f2293679..de3673149deb 100644
> --- a/include/net/bluetooth/l2cap.h
> +++ b/include/net/bluetooth/l2cap.h
> @@ -514,6 +514,7 @@ struct l2cap_seq_list {
>
>  struct l2cap_chan {
>         struct l2cap_conn       *conn;
> +       struct l2cap_conn       *conn_ref;
>         struct kref     kref;
>         atomic_t        nesting;
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index c4ccfbda9d78..7f331a31b723 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -422,6 +422,9 @@ static void l2cap_chan_timeout(struct work_struct *wo=
rk)
>          */
>         l2cap_chan_lock(chan);
>
> +       if (!chan->conn)
> +               goto unlock;
> +
>         if (chan->state =3D=3D BT_CONNECTED || chan->state =3D=3D BT_CONF=
IG)
>                 reason =3D ECONNREFUSED;
>         else if (chan->state =3D=3D BT_CONNECT &&
> @@ -434,10 +437,10 @@ static void l2cap_chan_timeout(struct work_struct *=
work)
>
>         chan->ops->close(chan);
>
> +unlock:
>         l2cap_chan_unlock(chan);
> -       l2cap_chan_put(chan);
> -
>         mutex_unlock(&conn->lock);
> +       l2cap_chan_put(chan);
>  }
>
>  struct l2cap_chan *l2cap_chan_create(void)
> @@ -490,6 +493,9 @@ static void l2cap_chan_destroy(struct kref *kref)
>         list_del(&chan->global_l);
>         write_unlock(&chan_list_lock);
>
> +       if (chan->conn_ref)
> +               l2cap_conn_put(chan->conn_ref);
> +
>         kfree(chan);
>  }
>
> @@ -594,6 +600,7 @@ void __l2cap_chan_add(struct l2cap_conn *conn, struct=
 l2cap_chan *chan)
>         conn->disc_reason =3D HCI_ERROR_REMOTE_USER_TERM;
>
>         chan->conn =3D conn;
> +       chan->conn_ref =3D l2cap_conn_get(conn);
>
>         switch (chan->chan_type) {
>         case L2CAP_CHAN_CONN_ORIENTED:
> @@ -3160,12 +3167,16 @@ static void l2cap_ack_timeout(struct work_struct =
*work)
>
>         l2cap_chan_lock(chan);
>
> +       if (!chan->conn)
> +               goto unlock;
> +
>         frames_to_ack =3D __seq_offset(chan, chan->buffer_seq,
>                                      chan->last_acked_seq);
>
>         if (frames_to_ack)
>                 l2cap_send_rr_or_rnr(chan, 0);
>
> +unlock:
>         l2cap_chan_unlock(chan);
>         l2cap_chan_put(chan);
>  }
> --
> 2.54.0.1032.g2f8565e1d1-goog

While I consider this a much cleaner approach than any the previous,
perhaps we could go one step further and stop using chan->conn as an
indiciation that l2cap_chan_del has run/detach l2cap_chan and instead
perhaps use a flag e.g. FLAG_DEL, that way we can make chan->conn be
used for reference tracking alone and don't need to introduce yet
another field for it.

--=20
Luiz Augusto von Dentz
