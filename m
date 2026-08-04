Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2384747DF97
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863582; cv=pass; b=efO2VTm6SQPezsPZEcFzduj0ckJBkOO9Ynzv4ENF0aeA/+Ye5SFOIaiBhbCvCqmnwmAGLFh7W99RizjIW0qYvJ1TqI0pqsiICIMStJhv9cgaEqJRBOEaEsdiRlLbFQNpcqu1/cBqpEA2f7h5qW7PLMgycsFW2im1FLc9MKaWsj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863582; c=relaxed/simple;
	bh=hWOxQobg8ldW59tbLei1oLLiGpx2Ld9GYhoqx0fvAp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JlRcl51xjcvvr5x4h0f5w022ySuhp1BoOHYP3W2twhThGuX3mfWxBVBT1GpgdOeVmaGrf4vXz3/YTRWs+uCvDSo5CuWswVEAfOrJBFpywtyjpoQ7oPzzEjYGKh6aTWErgSLZkAgjlNv0gPvv9KoGyckcArH4S2d/bzaB8Z1m/O4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THY3wBMs; arc=pass smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THY3wBMs"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66899c7b57bso2656d50.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 10:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785863565; cv=none;
        d=google.com; s=arc-20260327;
        b=Lk1YHZA2QEvjVaFPPJz4Tr+PTD8etbCnYc5A4NYE/PXTHmAhS5EHECwIgFr/19mDI6
         Pk7qfWv+W92zscAGYAoI6Dlynl2EmyIzTkWPNSl6IeqZcw+Ze/M+pzTlcI2PLR6Qlrxn
         ftLicmAUzpDciAPT9DUSlsN1/pcE1JHPqfqfqo0QkFWRNIYJV2+PYEQCkr1L+XZ3sZEZ
         myKZ/7klGet9PS6oFEjvofD5xMzyS/rAo6X7oEcmOtkSvVecueDI8xcV5JZeA5Fq0iGr
         4nbqCfPBkBtpGZkWcHiZMIi0BnC2KLk5PGjhYxJ7mkM04LyNuOg+VgM+th5qba9zrvKD
         8v1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PVTkNYfzNYlAmRE06g5Qd6oywBpWBs0JAsrXYTsIpTs=;
        fh=6AuW3xRFWBYkVo3J/YWcmJ2TnOb5YpEGWDI3TXmVfU0=;
        b=rAveQtXqeegwbMxXuHgp6BYOB95TvpTEsEA74kMc7Olhp1Z77pTb2LcQ/R1X3R1VWr
         so1djAbHCUK1MmjcbNGTRvKzjEnIk7VPwM2lNwHFjhDQf/YypryMaiICUsQXgvJx2AJX
         7d4sqOFabgHTnucdAGaxP06iDy0Essq4jLfd4DFsB3x4EPQ+vwYLNQIBN1j3xGo7B5dC
         xBlcQmat3F4qMmQBvbmjxyablOniA5uTNrjYPVA8Hj6LER8FJJzJrb/CeH4s+BOCz+4E
         yyUb02KTYYswSyzwanmvjssHMbs2ziERyO9FAZfanncqZpY6MuEPNEhQAia05yaxqH4H
         X3QA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785863565; x=1786468365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PVTkNYfzNYlAmRE06g5Qd6oywBpWBs0JAsrXYTsIpTs=;
        b=THY3wBMsNEQhPOCv6mOnK3mL/k/9kNpHJ/k4QaXsWfQani8m8ijWApRK8Q1qTpxV6Q
         91JNUa8ntEEeyWV9r4cGiC1S7zPiF1L0SN3jeOCk6m6aU2XN4cJCxPsPChXQTJIuusyG
         pBLMJOZ601oGFpOy2fwLYTL5m3qBkeICBMxr9Hd5zU+/s5hZj3RCms2ILI0Sl2IStpvo
         GBIOQeZ552n95Q5USDZXiuTTwaOqbXGt4epwXCjppRZxsiereZodviiNHdRdDJTPJFFM
         MbT+29Sszx4dp7qb2kWZgr2uDHG2aAG6MLC0pvk68zCGGmztLFkPxnMP8LIkQ19j+Y6T
         9V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785863565; x=1786468365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PVTkNYfzNYlAmRE06g5Qd6oywBpWBs0JAsrXYTsIpTs=;
        b=QizwS5I7EAk92AgQPOvuyCkOeQepxkH10Dul7DMr1yYwpYVBaCAlfGBKH9PVg6IlkP
         btsCYzKfjG/tV9zVk3OoPMbgeoJsh+aXwutmycBLg6qJ1kz4+8m1T95ZsLypiwOqPT/y
         9dKObEnpqSLvHZ0e6+jBv16GS5qUHv27bqZQ9iN/Svc9oiEeletmWYLf5KshehHya4vk
         0f+Nj6kb05ziImuiRb9geNVtvHVnXvPX1yV9gAl4ysAxGwIof57P/zzcOitcvU9Tg+t4
         qTovsn6oQgfC1qFWIZOYhV/FhN2P5KN4IKJ1qVkuK74tRvBNTXKgLDf2oTJ3lo5OtCVJ
         jc2w==
X-Forwarded-Encrypted: i=1; AHgh+RrxEl98y5orrSCfEqokuftwoAMB/jzehhRzLucAOxxS6qR6D0/+ZJZSyRPTiZBe/W74kIBixEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMdJ3Z063KlGXDQ59oI+FEK5LazsHgYbw70UmmWuJqQ2asdC+6
	agrgUY27zw2df+LCzy+acH8synxhXa5kFsRP+RAG+5anW2PTavklXIjQzr1mLcF23pi+MyGE8QM
	H/h9x8lDoKEy/mRjzU/Qe0uzvzNv2XdQ=
X-Gm-Gg: AR+sD108YeJU9qKijA4mS2m/an7YHj3S5ScAPtUzjaJnAIrgzgEPwjkAQ+b9uNocFlx
	9+7iFfksCkHbhft7++S5I2OfeZ/WJQA4naNlDGnDO1s0t9HsS+9jcKOA4EmIfnd5NV5ldazqhQ/
	Syz0g97pVdvwYNiz1CoXdTCQlV8UyU9oxRluvua0t6xfESos+d9/basPE2XPn8mJRMzbALzsF28
	ioUG4zAbjq1QQnuCcG3vLraYxQyqpIIRUe8rpfY6Ms73k4JbdRMz2jwNh6XxH4vG1WqRMcjrFM0
	m3x6bksBqU6UcW+uBBEQjhPLTJWjHyphcplfuy7LxY68/EwZGWpGiuiO1x0r8rCcMupCEAscVRU
	10dTjI5g8uso7lnyLgoSZRH6NKpFl3gI+nIg=
X-Received: by 2002:a53:a44e:0:b0:667:f20a:4cc8 with SMTP id
 956f58d0204a3-6699ad93aaamr117346d50.51.1785863564366; Tue, 04 Aug 2026
 10:12:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801145430.3560911-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260801145430.3560911-1-nicoyip.dev@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Tue, 4 Aug 2026 13:12:33 -0400
X-Gm-Features: AUfX_mwH7csUONkr6gK5pGwtK6jAUjfdx0TUm4TbZ6bng-ZzDdlQ0byFFuui6_Q
Message-ID: <CABBYNZLH_cZ_4Q+9zEOzJ78tXuVAgRk9QAP8hFyPHTqdOeUYzw@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: hci_sync: wait for directed advertising completion
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

On Sat, Aug 1, 2026 at 10:54=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> le_conn_timeout is embedded in struct hci_conn, but queuing the work does
> not hold a reference to the connection.  hci_conn_del() uses
> cancel_delayed_work() because synchronous cancellation would deadlock whe=
n
> le_conn_timeout() itself calls hci_conn_del() while holding hdev->lock.
>
> This leaves the following interleaving possible:
>
>   CPU 0                               CPU 1
>   le_conn_timeout()
>                                       hci_conn_del()
>                                         cancel_delayed_work() =3D false
>                                         hci_conn_cleanup()
>                                           put_device()
>                                             kfree(conn)
>   hci_conn_failed(conn, ...)
>
> The callback then dereferences the released connection.  KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in hci_conn_failed+0x232/0x250
>   Read of size 8 at addr ffff8881180e8e20 by task kworker/u33:1/111
>   Workqueue: hci0 le_conn_timeout
>   Call Trace:
>    hci_conn_failed+0x232/0x250
>    le_conn_timeout+0x23e/0x2c0
>    process_one_work+0x61b/0xf50
>    worker_thread+0x45b/0xd10
>
> Remove le_conn_timeout instead of adding another connection reference.
> Have the legacy and extended directed-advertising enable commands wait fo=
r
> the appropriate LE Connection Complete event in hci_le_create_conn_sync()=
.
> The command-sync entry already holds a connection reference until its
> completion callback returns.
>
> Mark directed advertising as an in-flight connection attempt so teardown
> can cancel the wait.  Disable advertising synchronously when that wait
> fails, and preserve HCI_ERROR_ADVERTISING_TIMEOUT for a software timeout.
> There is then no delayed callback that can race with connection deletion.
>
> Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-ni=
coyip.dev@gmail.com/
> Suggested-by: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
> Changes in v2:
> - Remove le_conn_timeout instead of adding references around delayed work=
.
> - Wait for LE Connection Complete from both directed-advertising enable p=
aths.
> - Make the wait cancellable and disable advertising after a failed wait.
>
> Link: https://lore.kernel.org/linux-bluetooth/20260730104103.2080325-1-ni=
coyip.dev@gmail.com/ [v1]
>
>  include/net/bluetooth/hci_core.h |  1 -
>  net/bluetooth/hci_conn.c         | 45 --------------------------------
>  net/bluetooth/hci_event.c        | 25 ++----------------
>  net/bluetooth/hci_sync.c         | 42 ++++++++++++++++++++---------
>  4 files changed, 32 insertions(+), 81 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci=
_core.h
> index 3df59849dcbe..937c9ba1e6b7 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -761,7 +761,6 @@ struct hci_conn {
>         struct delayed_work disc_work;
>         struct delayed_work auto_accept_work;
>         struct delayed_work idle_work;
> -       struct delayed_work le_conn_timeout;
>
>         struct device   dev;
>         struct dentry   *debugfs;
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index b1f911fd4ad6..74bf0686f428 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -687,48 +687,6 @@ static void hci_conn_auto_accept(struct work_struct =
*work)
>                      &conn->dst);
>  }
>
> -static void le_disable_advertising(struct hci_dev *hdev)
> -{
> -       if (ext_adv_capable(hdev)) {
> -               struct hci_cp_le_set_ext_adv_enable cp;
> -
> -               cp.enable =3D 0x00;
> -               cp.num_of_sets =3D 0x00;
> -
> -               hci_send_cmd(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE, sizeof(c=
p),
> -                            &cp);
> -       } else {
> -               u8 enable =3D 0x00;
> -               hci_send_cmd(hdev, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enabl=
e),
> -                            &enable);
> -       }
> -}
> -
> -static void le_conn_timeout(struct work_struct *work)
> -{
> -       struct hci_conn *conn =3D container_of(work, struct hci_conn,
> -                                            le_conn_timeout.work);
> -       struct hci_dev *hdev =3D conn->hdev;
> -
> -       BT_DBG("");
> -
> -       /* We could end up here due to having done directed advertising,
> -        * so clean up the state if necessary. This should however only
> -        * happen with broken hardware or if low duty cycle was used
> -        * (which doesn't have a timeout of its own).
> -        */
> -       if (conn->role =3D=3D HCI_ROLE_SLAVE) {
> -               /* Disable LE Advertising */
> -               le_disable_advertising(hdev);
> -               hci_dev_lock(hdev);
> -               hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
> -               hci_dev_unlock(hdev);
> -               return;
> -       }
> -
> -       hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> -}
> -
>  struct iso_list_data {
>         union {
>                 u8  cig;
> @@ -1121,7 +1079,6 @@ static struct hci_conn *__hci_conn_add(struct hci_d=
ev *hdev, int type,
>         INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
>         INIT_DELAYED_WORK(&conn->auto_accept_work, hci_conn_auto_accept);
>         INIT_DELAYED_WORK(&conn->idle_work, hci_conn_idle);
> -       INIT_DELAYED_WORK(&conn->le_conn_timeout, le_conn_timeout);
>
>         spin_lock_init(&conn->proto_lock);
>
> @@ -1269,8 +1226,6 @@ void hci_conn_del(struct hci_conn *conn)
>                         hdev->acl_cnt +=3D conn->sent;
>                 break;
>         case LE_LINK:
> -               cancel_delayed_work(&conn->le_conn_timeout);
> -
>                 if (hdev->le_pkts) {
>                         if (!hci_conn_num(hdev, LE_LINK) ||
>                             hdev->le_cnt + conn->sent > hdev->le_pkts)
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 741d658e9630..b6b279b5a103 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1557,22 +1557,10 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev=
 *hdev, void *data,
>
>         hci_dev_lock(hdev);
>
> -       /* If we're doing connection initiation as peripheral. Set a
> -        * timeout in case something goes wrong.
> -        */
> -       if (*sent) {
> -               struct hci_conn *conn;
> -
> +       if (*sent)
>                 hci_dev_set_flag(hdev, HCI_LE_ADV);
> -
> -               conn =3D hci_lookup_le_connect(hdev);
> -               if (conn)
> -                       queue_delayed_work(hdev->workqueue,
> -                                          &conn->le_conn_timeout,
> -                                          conn->conn_timeout);
> -       } else {
> +       else
>                 hci_dev_clear_flag(hdev, HCI_LE_ADV);
> -       }
>
>         hci_dev_unlock(hdev);
>
> @@ -1604,8 +1592,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_d=
ev *hdev, void *data,
>                 adv =3D hci_find_adv_instance(hdev, set->handle);
>
>         if (cp->enable) {
> -               struct hci_conn *conn;
> -
>                 hci_dev_set_flag(hdev, HCI_LE_ADV);
>
>                 if (adv)
> @@ -1613,11 +1599,6 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci_=
dev *hdev, void *data,
>                 else if (!set->handle)
>                         hci_dev_set_flag(hdev, HCI_LE_ADV_0);
>
> -               conn =3D hci_lookup_le_connect(hdev);
> -               if (conn)
> -                       queue_delayed_work(hdev->workqueue,
> -                                          &conn->le_conn_timeout,
> -                                          conn->conn_timeout);
>         } else {
>                 if (cp->num_of_sets) {
>                         if (adv)
> @@ -5770,8 +5751,6 @@ static void le_conn_complete_evt(struct hci_dev *hd=
ev, u8 status,
>                                                           &conn->init_add=
r_type);
>                         }
>                 }
> -       } else {
> -               cancel_delayed_work(&conn->le_conn_timeout);
>         }
>
>         /* The HCI_LE_Connection_Complete event is only sent once per con=
nection.
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index c8d14128c363..714bb1d55926 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1616,7 +1616,9 @@ int hci_update_scan_rsp_data_sync(struct hci_dev *h=
dev, u8 instance)
>         return __hci_set_scan_rsp_data_sync(hdev, instance);
>  }
>
> -int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
> +static int hci_enable_ext_advertising_sync_ev(struct hci_dev *hdev,
> +                                             u8 instance, u8 event,
> +                                             u32 timeout)
>  {
>         struct hci_cp_le_set_ext_adv_enable *cp;
>         struct hci_cp_ext_adv_set *set;
> @@ -1656,10 +1658,16 @@ int hci_enable_ext_advertising_sync(struct hci_de=
v *hdev, u8 instance)
>                 set->duration =3D cpu_to_le16(duration / 10);
>         }
>
> -       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_EXT_ADV_ENABLE,
> -                                    sizeof(*cp) +
> -                                    sizeof(*set) * cp->num_of_sets,
> -                                    data, HCI_CMD_TIMEOUT);
> +       return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_EXT_ADV_ENABL=
E,
> +                                       sizeof(*cp) +
> +                                       sizeof(*set) * cp->num_of_sets,
> +                                       data, event, timeout, NULL);
> +}
> +
> +int hci_enable_ext_advertising_sync(struct hci_dev *hdev, u8 instance)
> +{
> +       return hci_enable_ext_advertising_sync_ev(hdev, instance, 0,
> +                                                 HCI_CMD_TIMEOUT);
>  }
>
>  int hci_start_ext_adv_sync(struct hci_dev *hdev, u8 instance)
> @@ -6605,7 +6613,11 @@ static int hci_le_ext_directed_advertising_sync(st=
ruct hci_dev *hdev,
>                         return err;
>         }
>
> -       return hci_enable_ext_advertising_sync(hdev, 0x00);
> +       return hci_enable_ext_advertising_sync_ev(hdev, 0x00,
> +                               use_enhanced_conn_complete(hdev) ?
> +                               HCI_EV_LE_ENHANCED_CONN_COMPLETE :
> +                               HCI_EV_LE_CONN_COMPLETE,
> +                               conn->conn_timeout);
>  }
>
>  static int hci_le_directed_advertising_sync(struct hci_dev *hdev,
> @@ -6656,8 +6668,12 @@ static int hci_le_directed_advertising_sync(struct=
 hci_dev *hdev,
>
>         enable =3D 0x01;
>
> -       return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> -                                    sizeof(enable), &enable, HCI_CMD_TIM=
EOUT);
> +       return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_SET_ADV_ENABLE,
> +                                       sizeof(enable), &enable,
> +                                       use_enhanced_conn_complete(hdev) =
?
> +                                       HCI_EV_LE_ENHANCED_CONN_COMPLETE =
:
> +                                       HCI_EV_LE_CONN_COMPLETE,
> +                                       conn->conn_timeout, NULL);
>  }
>
>  static void set_ext_conn_params(struct hci_conn *conn,
> @@ -6761,6 +6777,7 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>                 /* Pause advertising while doing directed advertising. */
>                 hci_pause_advertising_sync(hdev);
>
> +               set_bit(HCI_CONN_CREATE, &conn->flags);
>                 err =3D hci_le_directed_advertising_sync(hdev, conn);
>                 goto done;
>         }
> @@ -6847,7 +6864,9 @@ static int hci_le_create_conn_sync(struct hci_dev *=
hdev, void *data)
>  done:
>         clear_bit(HCI_CONN_CREATE, &conn->flags);
>
> -       if (err =3D=3D -ETIMEDOUT)
> +       if (err && conn->role =3D=3D HCI_ROLE_SLAVE)
> +               hci_disable_advertising_sync(hdev);
> +       else if (err =3D=3D -ETIMEDOUT)
>                 hci_le_connect_cancel_sync(hdev, conn, 0x00);
>
>         /* Re-enable advertising after the connection attempt is finished=
. */
> @@ -7184,9 +7203,8 @@ static void create_le_conn_complete(struct hci_dev =
*hdev, void *data, int err)
>         if (conn !=3D hci_lookup_le_connect(hdev))
>                 goto unlock;
>
> -       /* Flush to make sure we send create conn cancel command if neede=
d */
> -       flush_delayed_work(&conn->le_conn_timeout);
> -       hci_conn_failed(conn, bt_status(err));
> +       hci_conn_failed(conn, conn->role =3D=3D HCI_ROLE_SLAVE && err =3D=
=3D -ETIMEDOUT ?
> +                        HCI_ERROR_ADVERTISING_TIMEOUT : bt_status(err));
>
>  unlock:
>         hci_dev_unlock(hdev);
> --
> 2.43.0

Looks like there is a problem when the command generates a command
complete it bypass the custom event matching, so we will need to fix
that first:

https://sashiko.dev/#/patchset/20260801145430.3560911-1-nicoyip.dev%40gmail=
.com

--=20
Luiz Augusto von Dentz
