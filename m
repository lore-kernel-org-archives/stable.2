Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291772F745C
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 19:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785527126; cv=pass; b=HJjQCQ3oNFSSlNl7o+t+EeL9KOMdBSycA8nJuXy0xT9K2aSWGdo9fQxln7eNUGt1nX6WZPUo6OBX/ToIQ9EGmlTXXbpmsz6tgZL34cscKzliJrlYkYqr22XUJ1XZzKvVOs7keJkySJafZAX5gFR49zPzls+uX7C7Qpb2Ar4CMYg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785527126; c=relaxed/simple;
	bh=cCUEjVyvXPjvenluJvof0R5NUdQ/rRfIEr0ztvApjrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smBVhqSbh58udnC8PIlDzubEht1+4h+TCbaCR5+5pVhOlAU087mIkuw5Z5cjYs8dbi8jedRBhtCFOLv8XmBG8gdZ8tP4knxR8dcA2HCecE3EjSuy1BUSFFZAPfG++33U5NYSkGnCXxWQmRZC7etLoIEQCoOveOtzjP1aKkMGXIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sFIOj6sV; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFIOj6sV"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-668005ba03cso1758044d50.2
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:45:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785527124; cv=none;
        d=google.com; s=arc-20260327;
        b=Wvl8tOqOyW2Np8HntyGDRUO8aHu1f3LLuF1VmYMlwHaUr1PIOE9BsxpgqMbTQbFE//
         kUOPNsizSS0HrKt6hC2smOnUZLSZc2mZReyPFt8FBa9C+fNieuJuz5gjZ/zuYZaobhp7
         AMahy9YuQ428KzdTZMXiybRiCSVoze9mCUaqDgFTUUjJW+wl8b6sHKCrCWlulZQa3+z7
         WT/UvzioY3CMSncubfo0PDA70mwqph0mG4zzOE9p/r+HMF4cY1/8jQ9LbMhBBO2v/HYj
         /uDKjzSBApJFql8e+5GGwT9iGRF6v+N0TIIuo7gCNI54LsXILPtJzEe29/rvBy+O/IDz
         hRqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ve9Rf+D9HJudBq0CAbi6hRU06X7OxOvTtvFT36AgLrY=;
        fh=Y5pg2OFHK1S1tsS60Z9mp4JjSQKWGkKSdp6KECMKaQ4=;
        b=LV9AIto6pCMRECURCcFoDCXT2oPbpmkc/kXtcH0McqObxYWDWKfl6mcJc5Q4lQ9e/X
         f/zEVm7ZHSe7sBpoMvS6I7hXulJH1tizg36J7h3Lvpq+U5dDvlCqploYy2GlWnzE9sWq
         e27EWV5hZb4L4MM0TYxMRAhyyDd2mAWlTuTZgb7m6t+u+9sJCXJuBtyBtG3xzD6nyAP2
         N1gYUM0KMP44tz576qskzcDD8ZDQiHtt2OVHkSP9o9o2HaFws3vtP3bKltSFpiMZkUvA
         0SemXtwSMDgrovQkfwkM0R0vUHXypbgxDBRsuYwD8OQRF1qU3f1JKQPmUKzj08/xo5gF
         x1JQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785527124; x=1786131924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ve9Rf+D9HJudBq0CAbi6hRU06X7OxOvTtvFT36AgLrY=;
        b=sFIOj6sVeNl53K1Nq+W5kTM1570NXZa7ADIHWTAk7dfx7PIQ5ixYwiMMKrbpx8slgp
         DOSQKGZz4AigQ6rWLSe8k5tnWBhk5GXmHmE5+DdEeqAJ9+u5pnFKYO/b3oXTN5opkXtA
         gpbs8k4Ab7rgToMZqs3lYFjOGfi/Cuki/Rzrs0Jf5shfoByKTUm8wmZEBazDd82Z5DwA
         a4UTWWajdfI5IfHR+Uv57YxZOIvc1yJXdQ07Tfc4IUwRFDickdWE2UhXafxt/B9z50so
         dRw5VtDoXWUDx5Ef/G2iHyswvOdlsViwMLExCsFWq+GOqBM8CPE3FKtOHtmtWiMtymDl
         ucPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785527124; x=1786131924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ve9Rf+D9HJudBq0CAbi6hRU06X7OxOvTtvFT36AgLrY=;
        b=QZmxxQ7rqFWNZy5yHUKPxrN9NOMrXzZXUmE/nekJTeSKCnJvS5IuMYcLigd2uqXBks
         NsGkRcWS0ANtSET7HwHd6EkSGEbbtYNoTpZK9o1nhga1p4IwjviSwIa4n4nKf/4WTx3l
         gL2ClTV2hVTgv2J25VXqe5PmaYAb5fMbq53DfLpx+mauKk3Ow52LkVWj+a09qXQHp5fo
         2++O2IKARmjHcM6l3ftRZeAFexaD2YvYT7xW/dVRJ9XUTy1TbwTGJ9SpUqmrYD7E8Lah
         wCbp+7rogF5FwtR0nNQojHEQuOzDZC93IzvWtu9WVSDIGKC31M1WTWuzPcm7cC0Mzn1p
         7iBg==
X-Forwarded-Encrypted: i=1; AHgh+RqqlYHUrg8M3vdlplqz+mF9TQq51oQyc9FznYDr6bxJD08y3nDDcuVwljxQAwAFFg7XhnSeWn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaTzYpsF/R3CS3NGwHmKd5cV8PIm0c7kqBs8wLeG4aP+caJJfl
	+Ac1tKmvWJYXQAwqYGlUw9woFb4ZrsURSo4iN//32ZCIEcrs2XZwsI2l6V9OPG+AaHbhAwLD6in
	KbkQ6iIo8I/dLp5PF9ws4qdStKKGxo21tWB8eND0=
X-Gm-Gg: AR+sD12WcjrF3RxYJ7QPfyr4CySH1zL8cblRiJgdy9aJsQ+nhXbh7xZ5QFEGLhdjgg5
	S9piTdCxJoyxYGtPRLCJSvqeSkjdYAxP1VVkA6EFmyZf3fs4DXf9l1/dD0EAWPVwEUlLZB+sPgs
	+M2hX3svBEJ0FWwfU3A8119bhWz6Ek8K0Px3wbeS/YL2iwrjzQHGlpXkI92esKtdyewhu0Z13we
	W5dUqmze/a4QP/CU3VtSRhWcm2jWUkFIBzhI1KdwV2vTFCTd+R8/C4zIfLh5YOgx5a69xGsn3IO
	u8jK74mNvW5Rutu25/VyJDYuQoPAi2Sc1Q1HYzcIII+yEG/Ml2YFVe6nPcWhfjMzbyXouAFwZL9
	GyO3LraOPLacoAypoKLh7lKFeI6bi+eX0Ejk=
X-Received: by 2002:a05:690e:4403:b0:667:f3d7:eb35 with SMTP id
 956f58d0204a3-6694efe0e97mr1089162d50.6.1785527124099; Fri, 31 Jul 2026
 12:45:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730092331.2069741-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260730092331.2069741-1-nicoyip.dev@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Jul 2026 15:45:12 -0400
X-Gm-Features: AUfX_mz6mvXtIkPFddN4aW93kRtgDysqoRVhdaYPe9M0YLfqc630_fEbIBqs7bA
Message-ID: <CABBYNZKgxz4JbKv8fgTeWGEGV0P_pPmcy_YG=rLDroc_1wu==g@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_sync: Fix accept list UAF during suspend
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

On Thu, Jul 30, 2026 at 5:23=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> hci_update_event_filter_sync() walks hdev->accept_list while sending a
> synchronous HCI command for each remote-wakeup device.  The suspend path
> holds hdev->req_lock, but accept-list updates are serialized by hdev->loc=
k.
> Consequently, remove_device() can free the current list entry during the
> controller wait.
>
> The following interleaving causes the use-after-free:
>
>   hci_update_event_filter_sync()    remove_device()
>   fetch accept-list entry
>   hci_set_event_filter_sync()
>     wait for controller response    hci_dev_lock()
>                                     list_del()
>                                     kfree()
>                                     hci_dev_unlock()
>   read the freed list.next
>
> KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in hci_suspend_sync+0x835/0x910
>   Read of size 8 at addr ffff88810bec8440 by task kworker/0:1/10
>   Workqueue: events vhci_suspend_work
>   Call Trace:
>    hci_suspend_sync+0x835/0x910
>    hci_suspend_dev+0x182/0x450
>    process_one_work+0x661/0x1090
>    worker_thread+0x45b/0xd10
>
>   Allocated by task 86:
>    hci_bdaddr_list_add_with_flags+0x1a8/0x400
>    add_device+0x381/0x820
>    hci_sock_sendmsg+0x1033/0x1ea0
>
>   Freed by task 91:
>    kfree+0x131/0x3c0
>    remove_device+0x429/0xb70
>    hci_sock_sendmsg+0x1033/0x1ea0
>
> Snapshot the remote-wakeup addresses under hdev->lock.  Release the lock
> before sending HCI commands.  This preserves list order and avoids
> retaining an accept-list node across a controller wait.
>
> Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/bluetooth/hci_sync.c | 38 +++++++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 7 deletions(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c0b1fc293b49..540da19d1d64 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -6250,6 +6250,8 @@ static int hci_pause_discovery_sync(struct hci_dev =
*hdev)
>  static int hci_update_event_filter_sync(struct hci_dev *hdev)
>  {
>         struct bdaddr_list_with_flags *b;
> +       bdaddr_t *accept_list =3D NULL;
> +       size_t i, num_entries =3D 0;
>         u8 scan =3D SCAN_DISABLED;
>         bool scanning =3D test_bit(HCI_PSCAN, &hdev->flags);
>         int err;
> @@ -6263,26 +6265,48 @@ static int hci_update_event_filter_sync(struct hc=
i_dev *hdev)
>         if (hci_test_quirk(hdev, HCI_QUIRK_BROKEN_FILTER_CLEAR_ALL))
>                 return 0;
>
> +       hci_dev_lock(hdev);
> +
> +       list_for_each_entry(b, &hdev->accept_list, list)
> +               if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
> +                       num_entries++;


If !num_entries we can probably bail out here, or we do need to call
hci_clear_event_filter_sync? If so, perhaps that should be called
first.

> +       if (num_entries) {
> +               accept_list =3D kmalloc_array(num_entries, sizeof(*accept=
_list),
> +                                           GFP_KERNEL);
> +               if (!accept_list) {
> +                       hci_dev_unlock(hdev);
> +                       return -ENOMEM;
> +               }
> +       }
> +
> +       i =3D 0;
> +       list_for_each_entry(b, &hdev->accept_list, list)
> +               if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
> +                       bacpy(&accept_list[i++], &b->bdaddr);
> +
> +       hci_dev_unlock(hdev);

While this works, iterating twice if there are no entries is wasteful;
we should bail out or rework this.

>         /* Always clear event filter when starting */
>         hci_clear_event_filter_sync(hdev);
>
> -       list_for_each_entry(b, &hdev->accept_list, list) {
> -               if (!(b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
> -                       continue;
> -
> -               bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bda=
ddr);
> +       for (i =3D 0; i < num_entries; i++) {
> +               bt_dev_dbg(hdev, "Adding event filters for %pMR",
> +                          &accept_list[i]);
>
>                 err =3D  hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SET=
UP,
>                                                  HCI_CONN_SETUP_ALLOW_BDA=
DDR,
> -                                                &b->bdaddr,
> +                                                &accept_list[i],
>                                                  HCI_CONN_SETUP_AUTO_ON);
>                 if (err)
>                         bt_dev_err(hdev, "Failed to set event filter for =
%pMR",
> -                                  &b->bdaddr);
> +                                  &accept_list[i]);
>                 else
>                         scan =3D SCAN_PAGE;
>         }
>
> +       kfree(accept_list);
> +
>         if (scan && !scanning)
>                 hci_write_scan_enable_sync(hdev, scan);
>         else if (!scan && scanning)
> --
> 2.43.0
>


--=20
Luiz Augusto von Dentz
