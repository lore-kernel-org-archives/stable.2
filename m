Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14CA3E2AB7
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 15:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782489239; cv=pass; b=sxI5bXecAllTzSdX479jyDzoq5KHTKyZg6cQmAGHPt0Qb1z6v89OmEduf1sjyeRwu8lPZjBqG2uj6PIUnlvjwmjycZtgLvEHabw67WJbpbALVY/xM4p2eKDI1QoVrqRXDKqjkk4YH+Fnw/Cg+S0B+9TGMHrpN+yV5VmN9a1WrcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782489239; c=relaxed/simple;
	bh=mI6PSqoZZc8G+CX+UdlFEy/yy8s7E/3zxWzWl0O+Z7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=DdWwE5ksUPTGU0kY0l0fvrKyK1cPbR+QdywnY+MpmHxGVjPpNlIP9jJXxmrE7OMGWa7QmEW2Fqq0e8fVxcm/coxbQU0WvcA77mneMi+ZLmVDZfmF3aY5Nr40c7g2JEnscXtm2SKbuMbGoKyG1BuvTGnBKiyTMHV3nSlhPI5+4nI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlAGXW+z; arc=pass smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlAGXW+z"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5bd7c7ec0b2so215129e0c.1
        for <stable@vger.kernel.org>; Fri, 26 Jun 2026 08:53:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782489237; cv=none;
        d=google.com; s=arc-20260327;
        b=SDuKEizfs3K7o0P8Y5QfL+iR98TkUAkoVqCRhlLZ+hCfNJf0LtBR/JYcoV6vLX57Or
         e7EGWmMWKuiKUvGmztT4eDUfPsGVl6pm9A/qy0u0h92xPh+w+I6VgLgssbNt1dFRC/IA
         IuCcjd8IWm5SoMJ/HFI3Rxh6s41ISz5SxsyBgibHTSMB/WaihxYIpQXkvY/Alfcpa8Wr
         sRxAbxYj1Hfp97guHdirHaZxzQGe/lQdOj1tABX6FcHD2M8DPrf4dY6MsZls16a/OTLA
         xj35GjS4+8X5izf8NC6kb6QXX0iLzKfWREuzAh2V3+IPYWTyr7djze164ZXODfLeiVBS
         DJlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=i9qW95xvby9BJnQuija+QYZkZMY5tmcyevPKsxEUV+A=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=IqmAHhoZ4vU0Qt79aoSNAWqZ9lHaG4XtNZFVzk5c6+LNZVRbkvDblNrLDrw2SellSX
         IBoAJ+f+jEk4CnE+iwdz5iZRJV/O1HWVvEBMDGv8hBrTR0wRvxQK5Uuo3lqABN/Z79Zy
         pKsY3v3wN9JwvWLYolk+VAt58xFNLLfCkuSJ5UTs6Ixa7WiZOsgb29dvFr9hS2ULrNPE
         ERpDbR1AL+WgPbfyz0xhCC91wW0zCX1ET0lVW0mzUfXkJclSHx6ZRRTdivK42ezTu6Am
         TjFeYqPY8hDKxBuLoNSn7zsJNCaBlgyN4Pdrkxe5q9Q1C3KdgjO3B7eOgzamr8pbdKQZ
         U9yw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782489237; x=1783094037; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i9qW95xvby9BJnQuija+QYZkZMY5tmcyevPKsxEUV+A=;
        b=KlAGXW+zuK4JO8IKuQcHmfJlQbJllajhGibOmS3GCkVWJmzMNFH3zMv1xJra0SLGu/
         8D87fwdH61s2x7OSG0LIbTRlmfyQsiFeFhw9f6lR5Yljf2j/L+RnkmfHMJXQaDZj+vQQ
         xSTSoY0PaRiIp0b1oerFkWpkW8uwTudKqlHUlGuAiOe0RzE8us2rP9OhVOtnb2FBAQUQ
         TuL5M5Fx5EJXc5Fp48YqPeDTyIu4Kp48FdHgcPIsghhJxrYBzcAkdHc4XiXc5eZt297A
         VSxVGHYPV/x4zg4Qrcv673e4b5j2s61yZVCHnoPNfHswcZBsM0jd1r7GG5mGvImo+6kG
         wXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782489237; x=1783094037;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9qW95xvby9BJnQuija+QYZkZMY5tmcyevPKsxEUV+A=;
        b=nYeVb7nXBMIt0MPmMbjJXNmn1UZmGWlhucebXdQF2S6cps8HAILG73UAoesAZA3X4n
         j8IVwHsP/cV02Q/7DpFlT9gHMIUSTbf74qjX7K6jxXBgBLvnUZUWuYBiH7HPKv9uKa7X
         7ZUlE4YCNLOyWJe7w1IaGJ035b9ccdPGtG/zxIg+U8Wd473LQsfKzJGWR2XDGJ67CG5c
         YOQ+vpzPmgjEmQtO8yWWJSuxV5qxr9Wj2hqMo3FGBGidebk1ptkeENmgT7jYDYfmhmea
         ChtIJNLAfJ26gmy1drQLO/0PRwH0dUwqqn2erDHlV4Rx/kgv9lMcBV7EFgyJ1KrBIR3L
         nDMw==
X-Gm-Message-State: AOJu0Yww/y8RzEQ57h+fTTxqpRFw7WsCUgnFCgKeU/8Oq+HKhKrDMvG3
	TSi95jq/t+36MezeKGsMyebYtTr3dNtA7fsxy3pxsI7GhYzojbbe9M4frtDUc+h+Fc14uie3/ec
	WUGNSwn4ycpGhPAq8zUrO8VRlb3JVgkX+9MEI
X-Gm-Gg: AfdE7clH5AG5lXsg1IsJ6d4iAebo+jmGzF0DvajC3eJKhualU0shoYzMOZwbxzmrw7N
	i37W46xjlUCAydx4iqMMFqPHKSA+RAVwskMsUqJ6K6/9nGbeaOymHuAMb91fxAWc0hCZoKgBOx1
	Vdbk6iYS4aZv5kz99VXlhcPCF4J9iodIbG0I5byNEmtt5CwoZJyxUX9kJQOxRfiM9+6lqSGzqvW
	I8e1y0kxUFPmFTgkHIQthM/l+L14Iek+z6RnHOK3mjOMY90b7V2LFXQYfF9qoz8waoDB3bwZA==
X-Received: by 2002:a05:6102:424a:b0:62f:406b:1baf with SMTP id
 ada2fe7eead31-73633af71c9mr695400137.20.1782489236733; Fri, 26 Jun 2026
 08:53:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260620011956.37181-1-honza.klos@gmail.com>
In-Reply-To: <20260620011956.37181-1-honza.klos@gmail.com>
From: Jan Klos <honza.klos@gmail.com>
Date: Fri, 26 Jun 2026 17:53:44 +0200
X-Gm-Features: AVVi8Cdx0afEriOnm7EoZYihHBp-13OcE-Nb7aUdwrWB9vQtXcbLMi5yh1Y3UQI
Message-ID: <CAMm4rXLpwdyL87gTGJB-4TNDfc+d3YHYOdwqdOx-Mf3PQ2-rQQ@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: realtek: Clear MDIO_AN_10GBT_CTRL_ADV10G bit
To: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

now thinking of it, I think this should make it into stable - RTL8127
is supported since 6.16, so I think it should go into 6.18, 7.0 & 7.1.

The mainline commit is 510a283f4d12367a3f811f382a2c89202954bbd1 .

Regards,

Jan Klos

On Sat, 20 Jun 2026 at 03:21, Jan Klos <honza.klos@gmail.com> wrote:
>
> On RTL8127A connected to a link partner that advertises 10000baseT
> speed cannot be changed to anything other than 10000baseT as 10GbE
> is always advertised regardless of any setting. Fix this by
> clearing MDIO_AN_10GBT_CTRL_ADV10G bit in rtl822x_config_aneg()'s
> call to phy_modify_mmd_changed().
>
> Fixes: 83d962316128 ("net: phy: realtek: add RTL8127-internal PHY")
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Jan Klos <honza.klos@gmail.com>
> ---
> v2: Patch formalities (rebase, tree name, tags, ccs)
>
>  drivers/net/phy/realtek/realtek_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 27268811f564..b65d0f5fa1a0 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -1802,7 +1802,8 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
>                 ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
>                                              RTL_MDIO_AN_10GBT_CTRL,
>                                              MDIO_AN_10GBT_CTRL_ADV2_5G |
> -                                            MDIO_AN_10GBT_CTRL_ADV5G, adv);
> +                                            MDIO_AN_10GBT_CTRL_ADV5G |
> +                                            MDIO_AN_10GBT_CTRL_ADV10G, adv);
>                 if (ret < 0)
>                         return ret;
>         }
> --
> 2.54.0
>
