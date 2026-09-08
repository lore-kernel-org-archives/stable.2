Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2AF4F797F
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862439; cv=pass; b=SeqgdNQDMAVnM/5P2cEH5Cqc793B6QsTNDcBCRuu1klL/YopKc+Cy37LfhCEEbGqrS7wHBZHc69sAucAW5lFEgAWVPRUGbLOumqJi5IuTK9lfvij5gDS7bQ6GGbzBBSddXcpSJYNKJh+QvsStrNh6HkEM8/b3KmMdkqMqFjxHmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862439; c=relaxed/simple;
	bh=kWGLXFyPHplqccz5poLz3IbI50NU/JwnfhfqrKLhw3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pe9+d3J3qi7oJN8PxaeUNrT8owtZs3q6ZARs6RPHGz/u/kPO3kzhcuxAVdEgPPTjgOdU34xdFu9EvG3gj1YS+hruV3wKq5a/8Q4ZfZEXvaZR5sVu6FUluLnyzhhIjfgftPacF8bS2ke/cMrfDg5TcRnbZpuAWwkmBv7ZlGbewzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcXma+F2; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcXma+F2"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-86309e1a213so860586b3a.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 03:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788862437; cv=none;
        d=google.com; s=arc-20260327;
        b=OTHwESZSEp1kUU9Lynd+/yca/3CQWh5TSfh6n+6Mn/6ruVwmoTS5X7FrsfZBrJAOJh
         3+BrfQooqv7IFQ1GFWmVukxxQJWQuu73gwtqqgAAiEuVVRR1IOFcwL+xP1eSK2zOvg9r
         OERvbIF2SVlrBgWEo/QrA45yqnXHkg1m0bEuKj7GEV/bdE3FMTw6PvFz+RZSygF2yOeS
         2eBI73DGW/ZhL7fA8JdUy8yldyE8kcYqbcNZH6YVtR4S7F2DGcrPQTqB0jgBksMBPdNt
         ZxWTyNgwR3biqiWaUywYlhWfEgLZyiLavmHwDi5YPb+JjaydCOVgoARZZ1XQh09EQjLf
         WaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oLrwfLp8ACywcK6OZDMAVfDPAmy/xkA/7NJ1Wh6BTDY=;
        fh=GLFCGGLBnfCbdXGBAQHmN5tsgUjJxfM8QA7wISLbywQ=;
        b=GTAQYiWlp+IPotCmSi73ukJ5+pJDd7cj0rgY5yhxajMMpOS0LVleUTeStDmYgdc+Oj
         dFT7wtEAg4L3pTQrDjLtw6czxVgD5PZ8e1W2Emse9j2vEKes+Xv9LqVXQF3505wvQPOu
         nkC68T5RqtG1w1kqFKqWRVg6plbqxjTIy3G95M+6sEUqgp3oLzV93B1Vf8wh3qG4c/Pd
         CIQvN+WYHSgpeoQUBkZmWY8/TvIuAD6+F2nmLULsK9JaBQuV4aM++VFoD0nmfM/gbs95
         SI//THQn7NGiZjDrxtbx8H/iLynms54AbtV9Tg6XdHR1VN2YhGkl7mBhOBRzNMy3ovuX
         BgDw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862437; x=1789467237; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLrwfLp8ACywcK6OZDMAVfDPAmy/xkA/7NJ1Wh6BTDY=;
        b=KcXma+F29IwmkuBQapQkmDnhdA073mi7hJKEUKUC2FKwsLT898hxV9lOHtUrk5iHui
         KkrEi7S2mQ1XYrc4rL+ceO+SUVS0XNIURjyIKZCO6/z7kOZis4jamUb2Gib0a9ltpY6a
         R87H5A3ecQj2V9fG3mg0RU8jRZrhi6+4yr4JQImMLLRR3Rk+EcGbN4vnGL3TxUmuTGYh
         ueKGLTQ39CaZ1L4AlEM6hrMpgHMeT6x6WGJWBTuwkIgU0SYqmTP+UDBXNE3L6lH+GVOC
         qd3r+GRr6A0zGtoQQUb4nhBLZKWSTVjedNUQ3EyrVqdUDVpw1a+A6xVuAocJD4Vh2ALO
         F7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862437; x=1789467237;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oLrwfLp8ACywcK6OZDMAVfDPAmy/xkA/7NJ1Wh6BTDY=;
        b=PmM5ZdKYcFKvA00XoYECP2TYLuxLPhLV/X4NE/P5G74XMBKCb0+9Pp1LR/7NmUuxYK
         V5sXGfLupS+XqI5OtDNw/tw1CaKQVk6XqsWz+IUdY+WWhpgiVtjIeR8cn9L7ZQl4w+qN
         Utf89x3bUOySEuYpJkak+JsfSKIWDqca6DF1jVjjN1HHzvPj/+QlA8P3kVvjuilC6ig+
         AjAE6ffZ0ndKzaCz6j4ME3sZsKFB01KWL64NwHTgRexW1UYDLjRVMAKm5RMJZUEcJL0u
         vd4uLKcxTceS4w8lVUfKx8eZZQMte0S2dsj0ZF8kLNjWnSGKjWc+JcK3bpgGzntEOjIL
         HcEg==
X-Forwarded-Encrypted: i=1; AKwUvBwn/R6OJ2m8SEcxepy0WmUO0jW4xkewGyOLKCuWIxaJ3bsQ4uECzij1Q0vMpAE1cO+luCyOm74=@vger.kernel.org
X-Gm-Message-State: AFuF++kEsaOZKKI1RlOaDjNGItFe3ToNmpBsNefaD7Hvdl1gGPDWpk6r
	JXpMBs/Z4/nA3DujLIft9ZbrsPk8YWVgXx84BAc9lB2qScxLuQv0mjzQUor3Hl3qtwNOL4GvQkR
	2Lt0tNLlVaP5kdH9+nOCcdy1S1P4dO10=
X-Gm-Gg: AYBFou0/kmOcG7SU8q44jYvbuAZEanZ0d0CLE09sePU3TrOmM2qlmeFudyTzu2TtpaQ
	JckOII6EpBYpm9Q2Zz+8zhQseiQK3OMbkh8StoCu+mGDh1DAQxf008eWZYBTHJw7sOxhApPggD7
	8HeKbgH3FpjW07deRPrXZP1hJdf+YfencXjTH5RW4wwSXE40kkglFUn+rQOAdmiUHpGor/LR8l+
	Im1PKRw6hH0dhz5BwO32ytFfoxkw1sL41Col2+Hy+pDkjs+mQKlppy2FPYdtiqgaPRJeIP5tf1e
	2yoLaA2RRYsd532T11t3gXXGJxkV+Ac2MP4X/E1F8mSMVLyPGBtu6co0xXBB4k20p4OgKqBRBbT
	AjAz/E71W4tXccDzLeIq5vOD5qh9QGoBMAidh/b6cck9Cdyvhi3xxuYaG2d874zRv8W0=
X-Received: by 2002:a05:6a21:b97:b0:3da:15a9:a18e with SMTP id
 adf61e73a8af0-3da3a0cc429mr41624097637.23.1788862437122; Tue, 08 Sep 2026
 03:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc> <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
In-Reply-To: <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 8 Sep 2026 17:13:45 +0700
X-Gm-Features: AcwNN1VMBv-YMtUDD27KP8tWOFfyKDv8HAQFtZgWktZVu5_za_i0rbJmn6ycjPA
Message-ID: <CAABR9nG49YgFejWRAkJrCcXF8p03A=HwWhbetmoHSjk_L3h9Gg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
To: Shengzhuo Wei <me@cherr.cc>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Simon Horman <horms@kernel.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -861,6 +865,12 @@ void fec_ptp_stop(struct platform_device *pdev)
>
>         cancel_delayed_work_sync(&fep->time_keep);
>         hrtimer_cancel(&fep->perout_timer);
> +
> +       if (fep->pps_irq >= 0) {
> +               devm_free_irq(&pdev->dev, fep->pps_irq, ndev);
> +               fep->pps_irq = -1;
> +       }
> +

I noticed that fec_ptp_stop(pdev) is called only from the failed_init
error path in fec_probe():

failed_init:
fec_ptp_stop(pdev);
failed_reset:
...
failed_ioremap:
free_netdev(ndev);

There are several other error paths below failed_init that eventually
reach free_netdev(ndev) without calling fec_ptp_stop().

Since fec_ptp_stop() is currently responsible for calling
devm_free_irq(&pdev->dev, fep->pps_irq, ndev),
could this result in a use-after-free if the PPS IRQ has already been
registered and one of these lower error paths is taken?

Would it make more sense to handle the PPS IRQ cleanup separately on
these error paths, or,
use a devm-based approach so that the IRQ lifetime is managed automatically?
