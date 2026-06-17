Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3544B311946
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 03:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781667682; cv=none; b=YwxrfOEiWybjJ1bHQ5H5gPMuOzMQH8pbTBIqZ3Vd/VkWlegSblIPoT6Hv1SQotLbLeMgE01ZIqBqguDUqiMDjgofqSQIM4SiS8DJkqNF8yiMyWlA5foevCeflYeSkwsJrxHSM7edO+TFeJL5B4PLb6lwQLrglsGfhXwStKGLpnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781667682; c=relaxed/simple;
	bh=ejKlcD3ojZM/P1bfToXGF2SV9BXp3bkfJzxqQ6vqRMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTPFKyY5veOFE3isV3xwT0hMaviAv4fEqVLnJiSBOnjDhvhP4iW7OIRnjnq9CeQVMAlFivEm9ZD4eWx9KsX4DGrhoYrSy6abgN4b7unfN1hYBq1/uf1P+zG6pv/E5cjlJg25HkN2Ajt8acxo4A4N1T2/Vx6QSihPAFahGEYubkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Tl9xDgmK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Tl9xDgmK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-36da8439078so4569725a91.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 20:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781667680; x=1782272480; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Gix0nvCYK1OhR2Kcuql53IhC6b91d4kE/6Woyx2T6JY=;
        b=Tl9xDgmKmasCIwxyfeEMKDiN5nHV2Ssko8Nh+INXPud4chIGoKDnKCtH9mm8R8Ler9
         qXtWDwNF46vYWsQTSzqp3Wjffk8XQKrIiXpS00ANsxqQwxKdN0xX+8rGJsvVAqDEll1M
         zYM3Uic/IRVymEVLeG/b3UBiLeB/b+OTire1A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781667680; x=1782272480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gix0nvCYK1OhR2Kcuql53IhC6b91d4kE/6Woyx2T6JY=;
        b=GXwzj9UhoVRSqf58EQ0Xl8K7Q5yjViGxDFXGuE7nqIdYiVFBklKtMwTCVv9gtk8FVt
         S00q0szV1LTu+/sO6ucD9Vc+agBk6ezhbXtkdyHAIcZ1+CbMLFnxzN0dQhFs/Mpwh2wS
         2Ng36TWXUr/51j5YDsypssPr9T5tEmzE1Ud11p2bS+2KJ/j5d+jV9oypTlq6zRnd2Usu
         TN4VLh97p2C/OgvVoOcJ70o4M7iUm6Wf2GsZWmD5vG8L/vDweYnX/p6ESGVharMiUD9p
         fVvS119ydeNQKJkBzsxA48SpxWl84hlf5YUxxbXzyJhKimRuGKvs5YcX+d0AvG3da1LM
         Z1/g==
X-Forwarded-Encrypted: i=1; AFNElJ+VhzfNBpxYW0heCuhRv3l5Enlm15ctfYOB00dxrWeRPehgIOZrNRa43h+QGteS/XTpFaKQrqc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys1NZeum14kLQPqyhS6swswupJDHvESu8rpDESfbVZ5K0GDL+r
	B5HBVjiGe9iiOiUj1a08XPbNtoJGSaU3KiSX0aOIPgO41RXJyR7mT/xLf7rVfAwEnw==
X-Gm-Gg: AfdE7ckO9nqRyHvYgY+LkyIwT/vQ6JU3TXPxc73X8mZOG9ecZsXChcmVPq4u/cMqjk4
	KqunkpNDbPqNfCk0jaw1JvDYc8sMZLBn+MiN7pNEoBBCV3GGuBZCOvbtFHrcLMA1WeTpIXS8klv
	U6X4IADFKNWf8TiOyjvEHR5YQWTXQYp/vIXePMQgY7IFgdiDM7qhIaxpZzCm8XziLHJliJrBQtP
	3nidLs8RS3cct/szVMX2BwH1H/CcKGpAYp3FcZqySyqRv4AFswqG1yKBOYdSC+ZId9exSBKeeZV
	lPQJbNCHmLDfd1lK7bkE5Z39LP2//UC9qxQ+Q/gehlXledEOvkROAJ7TH/d8hDxcPmgWzSFPZ+V
	hd6BFBQqxV0VHVfbXrUuyQn5zgM+FEAQZBweWsYziGaEwzdEFjReVyj4ZDr6MMdptRxcTfiobvR
	KXupkzv1RGZQqEAS22inky3TydIEKTURQ6zyD4kv6vvs+fMh2+PE4=
X-Received: by 2002:a17:90b:5107:b0:36a:a16b:5f65 with SMTP id 98e67ed59e1d1-37c9372863cmr2233719a91.11.1781667680584;
        Tue, 16 Jun 2026 20:41:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:a0b:fabb:5b62:b85b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521d8e7bsm4513705a91.5.2026.06.16.20.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 20:41:20 -0700 (PDT)
Date: Wed, 17 Jun 2026 12:41:15 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Sean Wang <sean.wang@kernel.org>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Mark-yw Chen <mark-yw.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Tomasz Figa <tfiga@chromium.org>, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Subject: Re: [PATCH v2 3/3] Bluetooth: btmtksdio: call cancel_work_sync()
 outside of host lock scope
Message-ID: <ajIWAC9b_l6Id_6A@google.com>
References: <20260616111224.152140-1-senozhatsky@chromium.org>
 <20260616111224.152140-4-senozhatsky@chromium.org>
 <CAGp9LzqT4knwk9hONu43cGDr005Phs3xw6T+YexXa3X6JEBOpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGp9LzqT4knwk9hONu43cGDr005Phs3xw6T+YexXa3X6JEBOpA@mail.gmail.com>

On (26/06/16 19:56), Sean Wang wrote:
> The patch looks good to me. Inspired by your patch,
> do you think should we add another patch to keep txrx_work out of the
> reset window by rejecting TX during reset,
> ignoring reset-time interrupts, and making queued workers exit early?

I honestly don't know, it's hard for to me judge as I'm not all that
familiar with the code.  To make things more complex, I don't think we
see any crashes on reset path.  My personal preference maybe would be
to keep things the way they are?

> Some code like:
> 
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -567,6 +567,8 @@ static void btmtksdio_txrx_work(struct work_struct *work)
>         pm_runtime_get_sync(bdev->dev);
> 
>         sdio_claim_host(bdev->func);
> +       if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
> +               goto out;

A nit: I think you can test_bit() outside of host lock scope.
Other than that I'm afraid I cannot be of much help here.

>         /* Disable interrupt */
>         sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
> @@ -628,6 +630,7 @@ static void btmtksdio_txrx_work(struct work_struct *work)
>             !test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
>                 sdio_writel(bdev->func, C_INT_EN_SET, MTK_REG_CHLPCR, NULL);
> 
> +out:
>         sdio_release_host(bdev->func);
> 
>         pm_runtime_put_autosuspend(bdev->dev);
> @@ -646,6 +649,9 @@ static void btmtksdio_interrupt(struct sdio_func *func)
>         /* Disable interrupt */
>         sdio_writel(bdev->func, C_INT_EN_CLR, MTK_REG_CHLPCR, NULL);
> 
> +       if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
> +               return;
> +
>         schedule_work(&bdev->txrx_work);
>  }
> 
> @@ -1250,6 +1256,9 @@ static int btmtksdio_send_frame(struct hci_dev
> *hdev, struct sk_buff *skb)
>  {
>         struct btmtksdio_dev *bdev = hci_get_drvdata(hdev);
> 
> +       if (test_bit(BTMTKSDIO_HW_RESET_ACTIVE, &bdev->tx_state))
> +               return -EBUSY;
> +
>         switch (hci_skb_pkt_type(skb)) {
>         case HCI_COMMAND_PKT:
>                 hdev->stat.cmd_tx++;
