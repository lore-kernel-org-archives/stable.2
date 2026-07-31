Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469F63F8234
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 19:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785525945; cv=pass; b=BmzEZ6wyYVVJAqAnE+YD58+mv7Nz9cr/1sg16MIyEWwyOSJSBrgYnxwBijPYdAfOtHafuBueV6OHt0V8C0QMS7LyPcFWoiOiqYlRA5aF9/zlu1h5UoFStDK9wT6vfrVxdnuRraSf2lNUza/c7bdrY6Of8NIKkkcjutbv3O1JSA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785525945; c=relaxed/simple;
	bh=S90ycy4tRH3QBjth/kijjGG9ODJd1eKt3mDGuCPoosM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YE+ZZURYGk3RBmoDQ6IrV5vRG12tqOMxEYLq1VCEvUsYxFLcUW8TxqZPHk+CDEvBwQLnYdu8EfK2gm2KklXHeJP1COWOlFyNJdbTxdi+d9xRymibC7nsHzHqvILiMcTCi/9z5q2X7/Z/3+IU2UDewA2tatbhFhJmIis2dELuKoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=auzOVGOA; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auzOVGOA"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-81062fdeaf5so34406887b3.0
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 12:25:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785525941; cv=none;
        d=google.com; s=arc-20260327;
        b=p2x1iuJLF8jJEPYiXncdhfRJUUyscZdm1BWXN2OnDVwB6uyllPIDcHgGx1GlZn2THx
         FIY7ML0/4RQee1U2mTmLaMf8WfxuomCYPzOBU6QwkuhxuBIbgXwZSpf8+Ph8ZqICXs8F
         smyXqqSj2tyTqRBWlJvDBUFv+PLokQ45IP8pdlbmz+uA/ov3NOXaVmuSt0wxqsFLMNeW
         WXR4i6K0GXnFyIxEn+ru/Dxh2/2gTCDNKMe1NvM4nw+YFXBngBd2QpdFvfDbwpEE2jAl
         7VblxaZgbki7Njrlrc7m6qSQpLz5FdTwJ15eDdWkjju5UeNUOTUB59V541Lbkh/X5GYN
         xIkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1xyf0jo2vh/33Eaju6Dp4kAQ5RCw7As82K7kpTj1cNo=;
        fh=B2a8yX2qKtvBd41nlb5dbCGFbrAfNPrKeyfHcTgQHkc=;
        b=OtEY/Gfx2khOH1VMACQnOx1qui7UbN5LrS+A2/TZftXq4KrNfTZEP4z9ETxNKQJVhd
         YSD1UM+n9uc0fwXkaeM+Kil+kfLqCCvVDuCIiUsW6ibm4a1fOKoLBnf0MP0WhI24l2mk
         jQHZh0yglsLeMbFgSRn3G8LGaKcIVlo7WSuXuwlR7g1oP4cmkX0EjvjERN57IzIyAOMG
         T95gldJ6CUax1RVjRDXssxX7flkUA6SPSq+Z5mp/XG2eMkDBP1Jve/pwhqAovi/fxs4G
         0Q1U17NnM1+sRxmEHmtSk5s0k9+JiDB/BWyNI3kTXcuwnGTVITmkvgMNDO3Pss7IYi8X
         jM/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785525941; x=1786130741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1xyf0jo2vh/33Eaju6Dp4kAQ5RCw7As82K7kpTj1cNo=;
        b=auzOVGOA0298lQ844/qAkyKB008ya+mPcFOSXvqhrX8r56sZwTnL3GPTDf37TD601b
         gsftHkLs4W7kPRbUtCrSYztt5566NPjofTUh87ED2l+lNr6LeW3wEFjMs8CNyM2aiso5
         0s1TwxSYyKsP+rZQBfD2RT0zmUxsf91uR0rY8fRuN80tkHQgIUzeQkcCk7Kbd6g26R3m
         M5g/skEHqjwTcSRnMlD5fzR86Tsh8B5zz9dFWYRhIdAY+gRiOpBgp/gtpCbek+0aMuAO
         MhMgrsYENm0Crd571rql9ZjP1lvnCp+1fEU70I7ZPUBq7bYd2d+aPoMP61kj8YIh2mlt
         lVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785525941; x=1786130741;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1xyf0jo2vh/33Eaju6Dp4kAQ5RCw7As82K7kpTj1cNo=;
        b=fyvCDkJeOG2h9FTfa7uBLaEhAiPrWiWyQgCxEFm8Nlztmi3MJpln6hiprSukqYeNTc
         xD1UWPc4veYvt/jlDnCKGhsaP4MmDg7BmdS1wjqQUzQ3sFUEpq8HtbovrgqiUKApFPVq
         bZyPT4TZJ/ALfwconkTxQR/YMzHY7nUG3l0XErkcIr2/d+rEbFL01+IBaC2O3bKyMELZ
         AunI9k59Uxdt0W5uGSw8jckR4AfX0xEypwqu50yN8sUc+eYte3zFJUvJiScopbsGUnzi
         F3c8xolnC94aA8kMB0GBuJVWUYh9dYLTcLomf+EVgVnhqLUSjwukELnP87SK3u4VKoyn
         E/ow==
X-Forwarded-Encrypted: i=1; AHgh+RoZOVPkgmBugo2RyTuaLrZS/p96Wpb9IsfQssi2twR3nyuGSaVYqSWlraAFlLOCOAlLlXzV+E4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEL8qPtEw7oMcgs1w5o8Wa7cF5JpC1/EYxK9juQpzRv4jbvWmJ
	CrClzAIQCPF3V0KQJbWvNNxdFkIsjznveZfARnlLBcEEb8zcTWzzJo39LiwbH2q2SYMoPf8/4g1
	REfIboXy2JFBk+cJoKZaLDW7Sw4kVjjE=
X-Gm-Gg: AR+sD125cVLUE7BKx8KpQRh5h7Y4bovDrP1rGLq7LaayESrCEjwIUEyqKpNu7byKYmh
	oIS6E0l8lh8C9uiJduPw57hevgWSqDDQ3UcodVKySGcW3rcmJeF81Xc3nApBcKlzBkiNuuKZsYY
	5aM5v2HtY6RIBsYSKcWVEyWouXmSTqT62lbSn/WhXd2UlbtSbbuCyAbt3YKG2EihcMZ4Eu9XM2N
	Y3H4PoVZtKnVB+Kv9NxI3yJ7MxDM9TnlkvwCfdUSSUD1rAinQAru3A0lanTR5smm2KchAaVrgUW
	TNxRJLYRqYLlS3x0Pvm8hqyi1uiD6umrRMqxS+p+PkJG1OFFwrYjogXUiy0aUeGixpiyrcBVHoL
	ZW2Wi4DTGQNTPn9HqtGZRo2prZSO5PDlE5DdNiDFKooOTcAU=
X-Received: by 2002:a05:690c:4:b0:81e:ba92:b253 with SMTP id
 00721157ae682-81fcbbd3c32mr27835567b3.4.1785525940950; Fri, 31 Jul 2026
 12:25:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260730104103.2080325-1-nicoyip.dev@gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Fri, 31 Jul 2026 15:25:29 -0400
X-Gm-Features: AUfX_mx8MIL0Vdvol_s4EExI8VXU0ClgTTiBoG80mkHApZhzKzpw4sRIz1VA3kM
Message-ID: <CABBYNZJx46usjp0_snfRQ7pvWrxPE8NZqSyqyM0rMEsoHgZnow@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: hci_conn: hold conn for LE timeout work
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@intel.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chengfeng,

On Thu, Jul 30, 2026 at 6:41=E2=80=AFAM Chengfeng Ye <nicoyip.dev@gmail.com=
> wrote:
>
> le_conn_timeout is embedded in struct hci_conn, but queuing the work
> does not hold a reference to the connection. hci_conn_del() uses
> cancel_delayed_work() because synchronous cancellation would deadlock
> when le_conn_timeout() itself calls hci_conn_del() while holding
> hdev->lock.
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
> The callback then dereferences the released connection. KASAN reported:
>
>   BUG: KASAN: slab-use-after-free in hci_conn_failed+0x232/0x250
>   Read of size 8 at addr ffff8881180e8e20 by task kworker/u33:1/111
>   Workqueue: hci0 le_conn_timeout
>   Call Trace:
>     hci_conn_failed+0x232/0x250
>     le_conn_timeout+0x23e/0x2c0
>     process_one_work+0x61b/0xf50
>     worker_thread+0x45b/0xd10
>
>   Allocated by task 115:
>     __hci_conn_add+0x1758/0x1b90
>     hci_connect_le+0x523/0x780
>     l2cap_chan_connect+0xfca/0x1bd0
>     l2cap_sock_connect+0x310/0x530
>
>   Freed by task 110:
>     kfree+0x149/0x330
>     device_release+0xc8/0x240
>     kobject_put+0x14d/0x280
>     hci_conn_del+0x561/0xe70
>     hci_abort_conn_sync+0x3e3/0x800
>
> Take a connection device reference before queuing le_conn_timeout. Drop
> it when the callback finishes, when queuing fails, or when cancellation
> removes a pending instance. If cancellation races an executing callback,
> the callback retains the reference until its final access, avoiding the
> use-after-free without waiting under hdev->lock.
>
> Fixes: 980ffc0a2cec ("Bluetooth: Fix LE connection timeout deadlock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> ---
>  net/bluetooth/hci_conn.c  |  8 ++++++--
>  net/bluetooth/hci_event.c | 25 ++++++++++++++++---------
>  2 files changed, 22 insertions(+), 11 deletions(-)
>
> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
> index 1966cd153d97..501a2dd2543b 100644
> --- a/net/bluetooth/hci_conn.c
> +++ b/net/bluetooth/hci_conn.c
> @@ -723,10 +723,13 @@ static void le_conn_timeout(struct work_struct *wor=
k)
>                 hci_dev_lock(hdev);
>                 hci_conn_failed(conn, HCI_ERROR_ADVERTISING_TIMEOUT);
>                 hci_dev_unlock(hdev);
> -               return;
> +               goto done;
>         }
>
>         hci_abort_conn(conn, HCI_ERROR_REMOTE_USER_TERM);
> +
> +done:
> +       hci_conn_put(conn);
>  }
>
>  struct iso_list_data {
> @@ -1267,7 +1270,8 @@ void hci_conn_del(struct hci_conn *conn)
>                         hdev->acl_cnt +=3D conn->sent;
>                 break;
>         case LE_LINK:
> -               cancel_delayed_work(&conn->le_conn_timeout);
> +               if (cancel_delayed_work(&conn->le_conn_timeout))
> +                       hci_conn_put(conn);
>
>                 if (hdev->le_pkts) {
>                         if (!hci_conn_num(hdev, LE_LINK) ||
> diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
> index 741d658e9630..e1e6b5092ce8 100644
> --- a/net/bluetooth/hci_event.c
> +++ b/net/bluetooth/hci_event.c
> @@ -1566,10 +1566,13 @@ static u8 hci_cc_le_set_adv_enable(struct hci_dev=
 *hdev, void *data,
>                 hci_dev_set_flag(hdev, HCI_LE_ADV);
>
>                 conn =3D hci_lookup_le_connect(hdev);
> -               if (conn)
> -                       queue_delayed_work(hdev->workqueue,
> -                                          &conn->le_conn_timeout,
> -                                          conn->conn_timeout);
> +               if (conn) {
> +                       hci_conn_get(conn);
> +                       if (!queue_delayed_work(hdev->workqueue,
> +                                               &conn->le_conn_timeout,
> +                                               conn->conn_timeout))
> +                               hci_conn_put(conn);
> +               }
>         } else {
>                 hci_dev_clear_flag(hdev, HCI_LE_ADV);
>         }
> @@ -1614,10 +1617,13 @@ static u8 hci_cc_le_set_ext_adv_enable(struct hci=
_dev *hdev, void *data,
>                         hci_dev_set_flag(hdev, HCI_LE_ADV_0);
>
>                 conn =3D hci_lookup_le_connect(hdev);
> -               if (conn)
> -                       queue_delayed_work(hdev->workqueue,
> -                                          &conn->le_conn_timeout,
> -                                          conn->conn_timeout);
> +               if (conn) {
> +                       hci_conn_get(conn);
> +                       if (!queue_delayed_work(hdev->workqueue,
> +                                               &conn->le_conn_timeout,
> +                                               conn->conn_timeout))
> +                               hci_conn_put(conn);
> +               }
>         } else {
>                 if (cp->num_of_sets) {
>                         if (adv)
> @@ -5771,7 +5777,8 @@ static void le_conn_complete_evt(struct hci_dev *hd=
ev, u8 status,
>                         }
>                 }
>         } else {
> -               cancel_delayed_work(&conn->le_conn_timeout);
> +               if (cancel_delayed_work(&conn->le_conn_timeout))
> +                       hci_conn_put(conn);
>         }
>
>         /* The HCI_LE_Connection_Complete event is only sent once per con=
nection.
> --
> 2.43.0

We might be better off removing the le_conn_timeout completely and
just make hci_le_create_conn_sync -> hci_le_directed_advertising_sync
wait on the connection complete directly rather then using yet another
work that can then race against the likes of hci_conn_del.

--=20
Luiz Augusto von Dentz
