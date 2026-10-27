Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793112722;
	b=boc4RQmBWpuV1/aELq0res8lAKCoZcpuo/XpYkjbCMBKN30vBIU6zB0YeOP+hB2RTII3
	 oS1UvS7aSIuJfT9XBl8I1TZbeIh2Oe+6pQe1wd22XbKECmXo49mvvLyk6+NVWKChpPZU/
	 gBt50rGU+lmhATTC435uUvUNpsgzOL9nB/+iMx3LgZFAxyk425+D/TEcJ8tb8RJ4pkTMn
	 EZyTqlAK2lfaFmPK9Hpy3Nv2nz25FLmzNunW+PmIWvM4kg3eoIJRaK+KytwQMm+8g5TFw
	 wyngTBY33SBfWSEMg7CDJW/cgSHmYxaIVrR5WGIYzaHPvqRftoiDNnxF6pymHvk+SNg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FU7pIPRd0mpxW1uPh7JiRsMpomfdTBJ1PVqebYQBX/w=;
	b=D6UZLpzA5Gjx3RcmKehx5xlO56HoyCkWasmMBRjleszbr44Mk8U7iX1Z9021BPr88h3w
	 ysSe01jwR0a08vxtBQGPAIPXMMZ1/I6YrF2WJq7hExNk7Ex103AbeIezY0h+/Qu+rQgGz
	 zsfWtCZzCLVDN2BS5fjnP3LyOn2tyKp+2ZAQu/QyKP0cAueifnuMyksaO644hasILBsGU
	 iSLtxwOGwEZdRriXYc3IX7x9LwF5YSpzj3X7alVZHBI3Iz3zpzNefrEQRxc6ptdUrYowd
	 5KyhnGYMH+rLiJmZTKcXFvBceTgZL9SN7xrXng0iccb+o0JOceCMe6uobg1P8cNq0pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DqjPCs4d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D6A60A2608
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 14:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0D6A60A2608
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DqjPCs4d
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8b20a899fso27589675ad.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 07:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793112721; cv=none;
        d=google.com; s=arc-20260327;
        b=b4sz5Xa14ajtjUckwP+r36EtZHB8cVMjxDkletdYD/26ay5MPQP4p73dDPxPYGsSDj
         LlV+rNDNKvOxQ4mrlTm+YW8w5ck7Lg/E9SmY2iD/ZlCu0MLEXxTDGQ2iv661XHpdTsFM
         oNPYAtOa8AOnBP+snYAnYztEys0YtH61SUzeWci74l7zcKy+7BIWgw1jCoxa/rQSxn2/
         piIzOw1akeNh/v1e4EHbTK1peikFhHNNuLGlwlExyimVlb+b6sg1Dj1YKvssMhbNGv3I
         f8dRvTJqj+TuO+XVp64YXgl9xpWe7OzP4Wk6CT4xTcxmFdq1HGCFbFFYwxmNQY+lOzVd
         GEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FU7pIPRd0mpxW1uPh7JiRsMpomfdTBJ1PVqebYQBX/w=;
        fh=MLRURmTgZSfkyVZG/v0rk6XdWJnbg2wWZQS0Oa0Y3V0=;
        b=aXbAybXQHGvG23F/LvqtmoWCBAyCYTJ3eEvU+/zSRACex9S8omsGpmBI0ZYf7ETnTe
         YFQYGkDB19K4UG3JTK27MSHW0L1N0w5WPlWPI3V7UVL73AFzXLEzCxfMN2NFK/KjQynP
         DCc8GncWHZiXOd7Lv1dlZT7hk22RrwbrjlCET9gkPVEuzYNtgHEyZ6WRfs5++6FchIgS
         N7JpN7OdaZBPQeLvd9+NO8v4lJOxqDBXMKGkvFwMhqhmQKe4gTDCch9f1W/t2ScqCXO0
         2ZO6d+6VIYyj3sLZHqZXNECYJZTTBxRwbNwAtJP3RpjS0rE65zJ9DEbuXEViN4PUBcHw
         GbWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793112721; x=1793717521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FU7pIPRd0mpxW1uPh7JiRsMpomfdTBJ1PVqebYQBX/w=;
        b=DqjPCs4dJ32bm7zSatdTMph8eLbrIiZizD/FLI1JoVoFvAmjQIOJhUuqKpg99V5b+s
         LLS+kBx6KBM8bc6Ni0PwXyd+NTKfacgRn/deaixv/tVlbXPDlA/Ca2On1e1TR1EFh+Br
         c1UUutur0IRU2qhpeDblRoVuCg/hmdOs/bxqb0UzpgRT9X+fREQJOsdQzhUQJTS12DBb
         KXfYFt3x79maA41r7KXzXiAL5gTDPnBnp2veRyQWM9pdLidDAhrilD2g8v685KXVIbPe
         6JwcjYXy7pWwc4D3RfOYB9ronLD89y6YutbPrktosT1/XrYkEpAmBnzk9gZ1f2PkR+gI
         zRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112721; x=1793717521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FU7pIPRd0mpxW1uPh7JiRsMpomfdTBJ1PVqebYQBX/w=;
        b=wnzvi1SSsDLBhsxDzonAZubxH4kEB6feCaxhneu1nNHzdPLt6Qc0QWaM4QsGNnfYZ5
         LO6eflCge4nPZcuZkktH81DVLDzXRRtb4pWIZTZuvDJpyW+xIHu02DnNPE0nDr3os4/Y
         mpiscioi1TqSI02mFY/eo02O3+Ina/LlrDTPCIPcvyYN482opj5vpsY9Xf3dPQGTWJyX
         gQJjn2cLoSOrvOz5gSaFmKqim7ZhvhIdu7Xp3m4/ek23QFMKQTbtSc2TI95BWEVws0ZT
         ZyagMDpzE93L5b6LZILddgmROxlOOov4b2ANtZpEwCg+HuKiwvZWEEAd6+0+HZxVyzs3
         2CnQ==
X-Forwarded-Encrypted: i=1; AKwUvBwwcQ8u/ioE+4FHazL/MJecWQEAqtftND/WkdDz/z2zXsQ/uS0/4FIDWwdzB6do/xRmYueDRnw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtA1tWgtVWnzdBR+znuz0IulELrwEkbu6AKI8zQWScgEXVHlKH
	NEIkwhP71Ly/ABm6LHgH1CXEWmiBDz4FcTdQRDWvCf3Dk2/xtxtWPdNdZvibtzhlohvA++wcZ0S
	hjwAz6rGIq0rUflz93kLWH3HmNr33njoEixvy3c+i
X-Gm-Gg: AYBFou1kpgbDLYGyyT4SVQtmwsekQ4nVEZlP1kGgzJ02Zqj014ak52OlyQGNuF8j6Av
	TT2d9URHs4Z2U7sAejmSfsJIUpKHU2zmmfBxlehnySjwaG4HA3O4lEZAQjTAA7UPbF5p03DRSGt
	THd6yfhv2w1Srt1CAqGoZV4OT3pdDm0YI7RgtYH3j+Qh8KmsKUb33KrENUd4d3LGwUrF/5/DPT3
	dWlbcibcMNQKYNrUIKV01tVKZ/Sy6m81Mgs6JqsSE0KYwioSAM/srvoJ0ukRWb8af93EnwCnTdX
	Ok6JM8kZNEvu9RZdY4mGL6YC0rHIDhI8GEwAytCrz50plXj/exluBAMs6QLtv/LTiH8oVQMioeZ
	4naUay1zdVIGVQVXCmGINodAVap6VMd98j3sKki+Y13ID/CC1pZixqAZ39+hqvcitTkRdEbtH7T
	pdrPxo3+R84CzKK7UW
X-Received: by 2002:a17:903:1a30:b0:2e5:467a:7a6b with SMTP id
 d9443c01a7336-2ea9c69aa27mr88146155ad.10.1793112720805; Tue, 27 Oct 2026
 07:52:00 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023204706.3112215-5-hramamurthy@google.com> <179306532917.3134.3709041101906222542@kernel.org>
In-Reply-To: <179306532917.3134.3709041101906222542@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 27 Oct 2026 22:51:48 +0800
X-Gm-Features: AclHuK_CgLe0wYbEvzhKP5oLFw9n_XNsuU2Vaq53lhDlTw36CwDa4KLyFY57Fxk
Message-ID: <CAHwYsip9e1H4+g2FS-t_TBGkG+f4E0w+kc4r0Ni6ODnA57cpCQ@mail.gmail.com>
Subject: Re: [PATCH net v3 4/4] gve: Fix link flap after ethtool ops
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, willemb@google.com, 
	przemyslaw.kitszel@intel.com, nktgrg@google.com, maolson@google.com, 
	jacob.e.keller@intel.com, pkaligineedi@google.com, yangchun@google.com, 
	patricion@google.com, awogbemila@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:42=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Synchronous link-status update in gve_queues_start() races
>   with gve_service_task(); the carrier can be left in the wrong state.
>
> --
>
> gve: Fix link flap after ethtool ops
>
> gve_queues_start() now calls gve_turnup_and_check_status() directly
> instead of queueing the service task, so the carrier state is updated
> before the call returns to userspace. This avoids the transient carrier
> drop after ethtool reconfiguration that was breaking the
> drivers/net/ping.py selftest.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 52c152a986eb7..e2a016f4430a8 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -1486,8 +1515,7 @@ static int gve_queues_start(struct gve_priv *priv=
,
> >                         round_jiffies(jiffies +
> >                               msecs_to_jiffies(priv->stats_report_timer=
_period)));
> >
> > -     gve_turnup(priv);
> > -     queue_work(priv->gve_wq, &priv->service_task);
> > +     gve_turnup_and_check_status(priv);
>
> [Severity: Medium]
> Can this race with gve_service_task() and leave the carrier in the wrong
> state?
>
> Before this change, gve_queues_start() sent its link update through
> service_task. A work item never runs concurrently with itself, so these
> updates were serialized.
>
> gve_queues_start() is reached from ndo_open, from gve_adjust_config(),
> and from gve_reset()->gve_recover()->gve_open(). It holds rtnl and the
> netdev instance lock, and it now runs the same sequence as
> gve_service_task().
>
> gve_service_task() is queued from gve_mgmnt_intr() and holds neither
> lock:
>
> gve_service_task() {
>     ...
>         gve_handle_reset(priv);
>         ops->report_link_status(priv);
>         gve_handle_link_status(priv);
> }
>
> gve_adminq_report_link_status() reads the register and writes the
> cached value in two separate steps:
>
>         status =3D ioread32be(&priv->reg_bar0->device_status);
>         WRITE_ONCE(priv->link_up,
>                    !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status));
>
> Here is one possible interleaving:
>
> gve_queues_start()                  gve_service_task()
>   ioread32be() -> link down
>                                     (device link up, mgmt irq)
>                                     ioread32be() -> link up
>                                     WRITE_ONCE(link_up, true)
>                                     netif_carrier_on()
>   WRITE_ONCE(link_up, false)
>   netif_carrier_off()
>
> At the end the carrier is off while the device link is up. The service
> task run triggered by the interrupt has already finished, so nothing
> checks the link again until the device raises another status interrupt.
>
> gve_handle_link_status() has a similar window, because its check and
> its action are not done under a lock:
>
>         link_up =3D READ_ONCE(priv->link_up);
>         if (link_up =3D=3D netif_carrier_ok(priv->dev))
>                 return;
>
>         if (link_up) {
>                 netdev_info(priv->dev, "Device link is up.\n");
>                 netif_carrier_on(priv->dev);
>
> Suppose gve_queues_start() reads link_up =3D=3D true with the carrier off=
,
> and is then delayed in netdev_info(). In that time gve_service_task()
> can write link_up =3D false, see that it matches netif_carrier_ok(), and
> return. gve_queues_start() then calls netif_carrier_on() while the link
> is down.
>
> gve_set_xdp() and the per-queue start path already use the same
> pattern without a lock. This patch also brings it to the common
> gve_queues_start() path, which used to be serialized through the
> service task.
>
> Should gve_turnup_and_check_status() and gve_service_task() be
> serialized against each other here?

Yes, this needs to be serialized. All other callers of
gve_handle_link_status() already run under the netdev instance lock,
so in v4 we will take netdev_lock() around the link status update in
gve_service_task() as well.
>
> >       priv->interface_up_cnt++;
> >       return 0;
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023204706.3112215-1-hramamurthy%40google.com

Regards,
Pin-yen
