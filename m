Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4984E44F57A
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978362; cv=pass; b=PER2GRh1Lp2zcHP0zbP+X14N3p9RTKszT0Dmvy7MlBaj6N7PToyA98tHSD3qh5PEKhtegsdPhJ1AzOylZh0OHFU6TWVBSaRsiDAk9KMBjuKS+ar482rbaOBat/mS6GoA8M3W1dS0Boju0Ow/IU6jeGyJfPWuCZuphh4FV+9kf+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978362; c=relaxed/simple;
	bh=4zQQq5eKKjqi9TjSvjMNrXcJkXocK5JzF/OCYT9LqTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCKQgcABt/D7r0h2T0n+kRrjffjwYNjtkNOE72n3N/KVW/g7KwfuJ+IX6xeffjjjkxqOC2G0ApqqTMu9SCxeFqmMsiPRXhjFMyfBCtk3e33YC1L6aOPmL+xtLX7NH4CQ2YKTIfJAfd0LAdCbaVHf+Q0a3BSmURuSYzo+i3UXgy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HCkG9CFw; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HCkG9CFw"
Received: by mail-yx2-f42.google.com with SMTP id 00721157ae682-8961cca9193so32834057b3.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:12:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789978360; cv=none;
        d=google.com; s=arc-20260327;
        b=kAxW02fgTWoOX2ahx5vwYxApMp4sdINbKODF/Ozx9fmTo/4lKxmaplfChKZacJgXVR
         r4Bd9rHYmSl0tKBL2VxFq8ybobYSn7B6rajKSmrK95YoCpNJgv6WJtEtYoc63BZwr5qS
         4kBq1nrtNqS3N72DhwJ8BRAra9cZUlXpsU2dJPMQm3dEs+Lmp+klq4JxUMNN0cSSeVL1
         JL+ugBWBiReoFeybVjOW8Kx9Wm2bX4Zmo1CjfDgSE3IOfODItTRgznf7voXZ0T8tsRDx
         lymcNbdCFlhoc0MAQ6BSkNCzJ+jleYKvBJqllljANWLWnC0YqtUlkP+LygLBCoNoLb+3
         NqSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2iqujM79yGjztEGr/+fVKOMfP5+oEqBbOqmgpHVP6Xw=;
        fh=vMuoQmatZa5HbJPTpDUXJ/nlefPzb67Ov0nkRkPHiMs=;
        b=dc9gX8pLV0bKf/IH7bmt5jPwCeqpnvyrtTFWq0c8yN17uhIe2XEqeQhg7fztPtgQYX
         J/WKPNhuvaQNCxPXxy2K0D79goKaywAC02JFgU/OXEWwWRLmUk5iZIIMyKVfucFpFrRZ
         K2CDTMZmPoHNRYECXXa2BFkA4LnPOi10nie3bc4QfUUaxp5Y6MbQ6/3xDV7BAkuczPL2
         yC8ji2BuIxjj3hglQ3w83QgkC9BI+KBcHX2yC02TtQVSw1CjTXnR9YJvqg8pYlv+zbVL
         2kwfdpaRVG640AHhFLJgyXaskaHmlbUUZRmEmolh2edaDcbrRrLLMLrT14Z1nnW3xPCL
         ufQg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789978360; x=1790583160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2iqujM79yGjztEGr/+fVKOMfP5+oEqBbOqmgpHVP6Xw=;
        b=HCkG9CFwd8B3YTzjO9d2LghdoR6zPGkRVXBK4hwBIdSLTiccoARdEGtFAPdj96fidM
         Ey3DGL9hWnhgoRXqK5I3NbpIEtu/zeKRx9wRbl3upFdmXV+vZ/Pxcj7Xafz5D3hxUyvE
         j7Sn4yF0Z2y9garqZQaKMBHE99M8FmQFrlMzfTyxQ8pSNEPDSpOlXvZMdxIou16uh/6m
         6ER6FTT7rMW0IfDfHvOoNXIYK/mOxheFYng4Rc1A2my94ty88PcSTM7qwkZqTY57Pl5l
         LYYHplOP8LyGjiMBnwMu4njICxc5d3Iqt24qvsWGlBoGO8c24XgJmyzLTvY5QtPT+t2F
         SQNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978360; x=1790583160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2iqujM79yGjztEGr/+fVKOMfP5+oEqBbOqmgpHVP6Xw=;
        b=RsTGuBr1h36JTrTjVjiO4E9/W6Tb9/k6she2cSx/bebZlbmcynihHrcwAI+pWUws1d
         z0NKCKNX1op1TjzocTZ3xVyNiBKabmxOweGGaaAFrzqu5JTU7Bwg9KxiT/S9BdcGoixS
         QFz2oa6FCFCFM8FuM0M0lqTXoUqMd/AdrBUy9Oq1+mWvVTDgT4vziV+UmxTs/Rsaez3B
         WdCdQXyTqmBmrydS0/YEgAWhSWbk31/TlwDBkmbPphzTkJJNRQLCrDU+NzlY0WdTI6BF
         ovXRlTsYrsak0UO2EwE9/Zh7ig6N0ia2H+E+E9CQRDfPAGCz92m/1rfTSg9kZ6VZ+Wwy
         ugfA==
X-Forwarded-Encrypted: i=1; AKwUvBxKxz12VJz4oRD5fQjN6jmy5IRizlQpuUsGM43sG4MRKjJYAJ2kcV5hmyAixZtTsgW8bCeTfpI=@vger.kernel.org
X-Gm-Message-State: AFuF++lvUFks/yKDrQml7qtrpASfdLWr4tKdaoug0XugxNetNh9Me4x8
	fupOu5n9GBtUThHlx0tT95Y1syjYS6wZBhvgsrGy7fiRWysYuoEYcw/HHJ75d7EtJmMvycP0kKR
	LUVt0BFsFadMTYSrDZNnh780bVNyoCTA=
X-Gm-Gg: AYBFou2ePVHYMTm3uFVvcMLBLsZ7uDjxRbvEmlGT5zJYa6EUvjcbm3Yg88fhNhUH4wi
	xPr6ncIW1XAOE0xNXu8GGaYr6s4LfRsCuzpSXscJQC7BoMhHD/da/8z1ehIYbGzh2G1XsmXHxVQ
	zVwsBjn897Ir0BPqbFyi1laZEpfMDK8uT4M/i6BIGhwy3to3YfgAfOn3C+eQ3Kt5d/S1/31juOE
	Z09pIV0fwBq8agAvqvO03EVE5Ayb3pD1fp7ozaoU8CVfn6KbpLUdMi5cYhwHzoC6UKXD40y1sgh
	pYnJHoxOmlmLMCrDBjb9QKeUFtmmhMiCLRx7cxyNQC+T+NaVFHgA3JEtGQ==
X-Received: by 2002:a05:690e:12ce:b0:671:70d1:d6d0 with SMTP id
 956f58d0204a3-6717fdfb97amr2457382d50.66.1789978360315; Mon, 21 Sep 2026
 01:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260913120227.1559129-1-lgs201920130244@gmail.com> <UqvaHP03S_-FFGTtKijH0w@nvidia.com>
In-Reply-To: <UqvaHP03S_-FFGTtKijH0w@nvidia.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Mon, 21 Sep 2026 16:12:26 +0800
X-Gm-Features: AcwNN1XgCXWlbGX--RVpkbgMM1GXMuJYBg88G-h-KhzxE_R154h9ZeFi1-ayk2A
Message-ID: <CANUHTR9xhXwfAmk+OTBdLyUjd5CXZm=aMQuEkH3nwsxd_tQ0Og@mail.gmail.com>
Subject: Re: [PATCH] gpu: host1x: fix runtime PM reference leak on remove
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@kernel.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dmitry Osipenko <digetx@gmail.com>, Ulf Hansson <ulfh@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mikko,

Thanks for the review.

On Mon, 14 Sept 2026 at 13:39, Mikko Perttunen <mperttunen@nvidia.com> wrot=
e:
>
> On Sunday, September 13, 2026 9:02=E2=80=AFPM Guangshuo Li wrote:
> > host1x_probe() calls pm_runtime_resume_and_get() and intentionally keep=
s
> > the runtime PM usage reference for the lifetime of the driver because
> > host1x is not yet ready for dynamic runtime PM.
> >
> > The probe error path drops this reference with
> > pm_runtime_put_sync_suspend(), but the remove path only calls
> > pm_runtime_force_suspend().
> >
> > pm_runtime_force_suspend() disables runtime PM and invokes the runtime
> > suspend callback when necessary, but it does not decrement the runtime
> > PM usage counter. As a result, the reference acquired by
> > pm_runtime_resume_and_get() remains held after the driver is unbound.
> > Repeated bind and unbind cycles can therefore leave the runtime PM
> > usage counter increasingly unbalanced.
> >
> > Drop the usage reference with pm_runtime_put_sync_suspend() before
> > forcing the device into suspend during removal.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 6b6776e2ab8a ("gpu: host1x: Add initial runtime PM and OPP suppo=
rt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/gpu/host1x/dev.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
> > index d2c64728f804..bb6a1647e4db 100644
> > --- a/drivers/gpu/host1x/dev.c
> > +++ b/drivers/gpu/host1x/dev.c
> > @@ -729,6 +729,7 @@ static void host1x_remove(struct platform_device *p=
dev)
> >       host1x_unregister(host);
> >       host1x_debug_deinit(host);
> >
> > +     pm_runtime_put_sync_suspend(&pdev->dev);
> >       pm_runtime_force_suspend(&pdev->dev);
>
> After the pm_runtime_put_sync_suspend, the device should always be
> suspended, so I think we should also replace the call to
> pm_runtime_force_suspend with a pm_runtime_disable.
>
> Thank you!
> Mikko
>
> >
> >       host1x_intr_deinit(host);
> > --
> > 2.43.0
> >
> >
>
>
>
>
That makes sense.

I'll replace pm_runtime_force_suspend() with pm_runtime_disable()
after pm_runtime_put_sync_suspend() and send a v2.

Thanks,
Guangshuo
