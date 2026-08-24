Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 810423859F4
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 20:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787603084; cv=pass; b=cn8SJSR64ESN+tvS7KogcpPfnf5I5KQDrdmKkwJjeWFrIJZmm8OnkiqMEKXUC70fr/y6Y3GKEwGU81jzgjBeL1UQiXeDt1ZS9km6fvb+rO2QfE4TS1CigjhsbG7UMR0Mmro9bw5ugcfHbvdmqkHsVb5Ziz7IwwKGynKlcOkLj20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787603084; c=relaxed/simple;
	bh=MdlGQ1YGPyo6q4fQ5CsW81kcKMXd9tZzx9TSaN4B5ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOHSDnKmeSaEgsDGm0EeF/i5IafMmV7NIALLQtFn1Tt5a5zWtmbMWEtIbA5uJO3n72HTXc5rYM3zXupFfTKDKiPJIHqA+XmghrkEbXHd9FUYFs83rFJLswBvI8RWwpMg11AamGoxeePmJAA2PkBcSrgDL2ZWuDbr38eAFZouWUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUFUNoOU; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUFUNoOU"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6682259cae6so4869032d50.3
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:24:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787603081; cv=none;
        d=google.com; s=arc-20260327;
        b=i2EYN0feH8Katd9alDAIxMfP8S1oCP5zizSTcG5Ke3Qj7bBHtATzU7jHfjNXerzLjw
         zr3xF1oSvwtX19uIo4nvix90/GotS+LGkpWsnFglvNN7EdB7TPT/Mr3Z4/tBd7YbxyYz
         6lJZtdNGanbM5VzwQ7/aNfFCcSMXl5+efS1ErsfTjUXYFDwGCp/n9Y2/YXB8rPqZJEY9
         1CxcxL4UNeVAHdzBs4nxit3fPFKxrFqlfG8SmjhMzc9aSYt51C7nPjSJ8Q2FIkupBeSu
         RAa+tiPqFOVIfOK5Ndsy4Pj54beS5zntaRXb8FfI3+y76pwgm6sXtmu96ZQDfn/pA6x/
         xnpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6arJFNIEtYO1N3cE88QFjylzkIER2l/NUQl8uPQTV3E=;
        fh=RB41oR5FRL5kLh7c5kDfhjY0OXKoA5m/Tzq135vvg3Q=;
        b=aABMhPDna40dB3KgF/5hw6ESzEZ6SCBdJ5lySi1F84da2xEjYoqk+0ZCal1wM5trqY
         s6cQUubL+sAiwovW9MbMlw/B4woS6pKZ8oQ7LbBFgep4bEjD4NVth8qzLeuSXuhzOinX
         AbpwB+GiDSaJkM9cUKPZKxDpvLMecm+S5HY2NNxhSuZfej8c1Alq6L5+CublYviWn9FK
         7/mwP219v4MguvKrNSJIQz5p3EuAI8U3BgYFSxP6AyeAfUASnCV5Z3AAzKyRAdfzBMZ+
         gqb8LXo3HZ/fIwhhVfS2Zo3rVe6gunmgHBLuL7lNxWfcTHO+P4ecIx2II1kRrrxSkHVK
         mVlQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787603081; x=1788207881; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6arJFNIEtYO1N3cE88QFjylzkIER2l/NUQl8uPQTV3E=;
        b=WUFUNoOUoTfpU7+O7eDe7WeUDQvJ2HlDqU9y72dK6NuEf/OmMYLfvFPfH9OKA9+w3D
         hJ0e9DyTXe/HtOhKISUgHpvRb19tyYOtmj16Wk2UNiTBdaN564rrhgs9N9QxlEg1nSxI
         V1BaCIApkbf1qjCllWq/FJ7sx5FPdu7nxsDg7HCo7hyl5x46cLT+lDTKtwj6QBzSGtsc
         MFO3gxyIpbg+pFArcTxYyvzpGRi5VmZn5XVUz/zxfakk0nfxzYBBzOYBffs1wevDRxjO
         pSJFfoSeUFHRg1R2rouHdisugLYaJWeOB4kwRQUEb0Yp1IlzY3XmrD2vZqhahvWWgF6G
         jS/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787603081; x=1788207881;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6arJFNIEtYO1N3cE88QFjylzkIER2l/NUQl8uPQTV3E=;
        b=ZR8joF70EBY8mxBGtow2a0Tvf81310FouIZoxOAPcAJDo0b3jSqJWK73hgAVUqu0Zi
         q4vwHTP/avdJB9c4rDXK84fCWzmaZQDqWBR0ZNmLaa+b05qogwN/cLUaKkSnfWzjYikc
         Eil+8nC3jfkFYBQJHbNkSbB6jT20QX4R7/I3oH+U2f31Ny5+aPmvTIB4H5ZIflKzNBXZ
         spXhMN6Bd83kTtkccthJAQYeIDDSQBWyEpaH5Oc1vIbsKanoEDeVxF+q7vK9dWzkFvls
         ezIcPNsguCb4E8+JVOD0A3Ioqk+m0MOiJdGTO0TQ2PT9oRzaB0h4Z/c4vCAtXLoQtApj
         RLuQ==
X-Forwarded-Encrypted: i=1; AHgh+RokK2FVUwDhvKLRn9KpUKCb9VaoA3EM6I4fgbNl4L92+P2SlgwxxKIDs37uK5y0Na2ggImvYfk=@vger.kernel.org
X-Gm-Message-State: AFuF++le+W7Jjv+l7/BcMDaMvBi1fkmY37bzN3jMx6J7ogAHkuLkIM48
	fB83u0LxEV6BPjmFun+hFkVGkkEnk6+kx6i4XPWVkVN6wNZPy9SeZuWplgsTx3GE0kKOOo9gG7s
	/8s6XopcJioyEIefJMfomFfDJI2gyt6w=
X-Gm-Gg: AR+sD103CSdz5RfDiCKvAWIKil7PAZzvf4HxDTdUrNK4vHB02LVrk0wD8SFv+jNmfp5
	zJXACgxSJm3J2jnJDDYjp+fAQLHbWh/w1SNbEiNQmOtnsyvcKUGgp6SRJWIofN6vLJKoYYXbQEB
	IlW0MlEqNpMsB2MDGtmqKPEOI69F2aiY2lWigpYbGvJ155Anhc/y+kjwl9B48nRlHC0j1rMwiJz
	dgmO0wN64mbOClstHX3LF78dN63KJdzQx7vuC1blFz3nscSdOQVwgF0iLE1rUTJKkyezgUNzoTO
	8T/vR+DffA9aXomOFLC+sA3n4nJmUVqre9tjKTZZHehpDT9Oms2221eT2aiMZvcaMnSvFaU49QW
	bmZhjAbDggHK/RJ+ZBNKvYkiTF/cZ7CGbl+reIV8KLQ==
X-Received: by 2002:a05:690e:4514:10b0:66c:c7f7:a074 with SMTP id
 956f58d0204a3-66cf21346dfmr5071579d50.1.1787603081472; Mon, 24 Aug 2026
 13:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822164341.3750491-1-nicoyip.dev@gmail.com>
 <178759021163.3014491.6954824460297136867.git-patchwork-notify@kernel.org> <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi>
In-Reply-To: <5e76a95e934e451e7006db28827c2d64af5a88be.camel@iki.fi>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 24 Aug 2026 16:24:30 -0400
X-Gm-Features: AcwNN1XI0fwmwELQrp0LxTgNN5-Hwkf5JRdkao3DMgkKEJh4yKK7TGLZ-xyNW8Q
Message-ID: <CABBYNZJotKc4k55jEEweD6aP6XEhYyKAgk4BamV5vfp8HHi0Tw@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: RFCOMM: serialize security confirmation handling
To: Pauli Virtanen <pav@iki.fi>
Cc: patchwork-bot+bluetooth@kernel.org, Chengfeng Ye <nicoyip.dev@gmail.com>, 
	marcel@holtmann.org, kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pauli,

On Mon, Aug 24, 2026 at 3:38=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi,
>
> ma, 2026-08-24 kello 16:50 +0000, patchwork-bot+bluetooth@kernel.org
> kirjoitti:
> > Hello:
> >
> > This patch was applied to bluetooth/bluetooth-next.git (master)
> > by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:
> >
> > On Sun, 23 Aug 2026 00:43:41 +0800 you wrote:
> > > rfcomm_security_cfm() looks up a session on session_list and then wal=
ks
> > > its DLC list without holding rfcomm_mutex. Since RFCOMM session teard=
own
> > > uses rfcomm_mutex, krfcommd can close and free the same session and D=
LCs
> > > concurrently:
> > >
> > >   hci_rx_work                    krfcommd
> > >
> > > [...]
> >
> > Here is the summary with links:
> >   - Bluetooth: RFCOMM: serialize security confirmation handling
> >     https://git.kernel.org/bluetooth/bluetooth-next/c/40c621391de9
> >
> > You are awesome, thank you!
>
> I'm a bit too late now, but Sashiko report had some valid concerns
> about lock ordering in this one:
> https://sashiko.dev/#/patchset/20260822164341.3750491-1-nicoyip.dev%40gma=
il.com
>
> Running both BlueZ l2cap-tester and rfcomm-tester (so lockdep sees more
> paths) in same boot you get lockdep splat.

I didn't know about this trick, so I wonder if we should do something
about it. Testing with just rfcomm-tester should show this, or perhaps
we need to change the CI to run all tests under the same test-runner
instance so lockdep learns about all the code paths.

> Not immediately clear that a real deadlock could be triggered, but
> lockdep thinks the ordering is now inconsistent.
>
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 7.2.0-rc6-01463-gfe3897b4ab57 #994 Not tainted
> ------------------------------------------------------
> rfcomm-tester/364 is trying to acquire lock:
> ffff8880027d40b0 (&hdev->lock){+.+.}-{4:4}, at: l2cap_chan_connect (net/b=
luetooth/l2cap_core.c:7271)
>
> but task is already holding lock:
> ffffffff99499f58 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_open (net/blu=
etooth/rfcomm/core.c:426)
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (rfcomm_mutex){+.+.}-{4:4}:
> __mutex_lock (kernel/locking/mutex.c:646)
> rfcomm_security_cfm (net/bluetooth/rfcomm/core.c:2222)
> hci_auth_complete_evt (./include/net/bluetooth/hci_core.h:2246 net/blueto=
oth/hci_event.c:3554)
> hci_event_packet (net/bluetooth/hci_event.c:7887)
> hci_rx_work (net/bluetooth/hci_core.c:4041)
> process_scheduled_works (kernel/workqueue.c:3322)
> worker_thread (kernel/workqueue.c:3486)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
> -> #1 (hci_cb_list_lock){+.+.}-{4:4}:
> __mutex_lock (kernel/locking/mutex.c:646)
> hci_remote_ext_features_evt (./include/net/bluetooth/hci_core.h:2207 net/=
bluetooth/hci_event.c:5030)
> hci_event_packet (net/bluetooth/hci_event.c:7887)
> hci_rx_work (net/bluetooth/hci_core.c:4041)
> process_scheduled_works (kernel/workqueue.c:3322)
> worker_thread (kernel/workqueue.c:3486)
> kthread (kernel/kthread.c:436)
> ret_from_fork (arch/x86/kernel/process.c:158)
> ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
>
> -> #0 (&hdev->lock){+.+.}-{4:4}:
> __lock_acquire (kernel/locking/lockdep.c:3165)
> lock_acquire (kernel/locking/lockdep.c:5868)
> __mutex_lock (kernel/locking/mutex.c:646)
> l2cap_chan_connect (net/bluetooth/l2cap_core.c:7271)
> l2cap_sock_connect (net/bluetooth/l2cap_sock.c:255)
> kernel_connect (net/socket.c:3726)

Interesting, I though the kernel_connect would actually behave as a
syscall and use it own thread so it wouldn't result into
l2cap_chan_connect, in that case it is probably useless to use it in
place of l2cap_chan_connect directly, so we may take the opportunity
and clean this up.

> rfcomm_dlc_open (net/bluetooth/rfcomm/core.c:808)
> rfcomm_sock_connect (net/bluetooth/rfcomm/sock.c:421)
> __sys_connect (net/socket.c:2135)
> __x64_sys_connect (net/socket.c:2160 net/socket.c:2157 net/socket.c:2157)
> do_syscall_64 (arch/x86/entry/syscall_64.c:63)
> entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
> other info that might help us debug this:
>
> Chain exists of:
> &hdev->lock --> hci_cb_list_lock --> rfcomm_mutex
>
> Possible unsafe locking scenario:
>
> CPU0                    CPU1
> ----                    ----
> lock(rfcomm_mutex);
>                         lock(hci_cb_list_lock);
>                         lock(rfcomm_mutex);
> lock(&hdev->lock);
>
> *** DEADLOCK ***
>
> 1 lock held by rfcomm-tester/364:
> #0: ffffffff99499f58 (rfcomm_mutex){+.+.}-{4:4}, at: rfcomm_dlc_open (net=
/bluetooth/rfcomm/core.c:426)
