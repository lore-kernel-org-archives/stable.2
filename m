Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94424417D97
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786375747; cv=pass; b=OE1nVJexabOy0vbuO7Pu0hYNfUEumeDhke3EQqTp497qYPg9eRTrqawLQYozvduE/0s9P0/N+kM5fVIpkH5Gy0yD1cAQRMYbZtM48y4/obq39gZOSV77mza/D/5xshMeOfpEOtq6SRXEbEyDepmtjYQBJ0Cw3jD4uak+1ZD56u4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786375747; c=relaxed/simple;
	bh=GLzSCGvVPWKfqovMKiEvzhpXLJRI6eCsGnuPQaEc2mA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DEnEN+P3RpnjJpmFoOVPqiE7xET+3408gXDMKZnE/9wLW8Qy3sXEQqTk1N95Sn6SliL7akETlItHx7HkRtTK/bDlG2Sr9ni+Uaz/TnZHPBu6/xGTEVoSgK7QtjEFlvJjh7jubNcAdMarjVYzYN2ShHkoC8IlLhinIXY8mIIFgaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFOMDrQP; arc=pass smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFOMDrQP"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383fff6e8b6so113804a91.0
        for <stable@vger.kernel.org>; Mon, 10 Aug 2026 08:29:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786375746; cv=none;
        d=google.com; s=arc-20260327;
        b=itxMMEQkBz/OgoJfC3Kat8SBl/tHu9Cw772MvUhOc1S9DywTZzY2bWPNV8i47Xa0s8
         1sifs9qcyEli7lSKa0OuY6CR8Psw0xdpnaAm2cDT1mp1cxjvYfjabDYUZTWWIn7HEYmI
         U2rrUPJj7nJxCuGK0N5TkQ04wDmqw0ptRS3Q82RNFimQSKVCdmqThkg+t/VLPX4xwMdh
         dCax3R8qShivJhIFYA+aznUiuYSQfN+U5Uvq5d1nyqYawkbzOHLDqqCbGqp9hnSfJZdI
         eTn01z4hJ4kVwK9L60nfKMv2u+VdinvTErr0J4NNWp8XmlFQD9OnmW2Ez7xm6HsXjBR4
         1d3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
        fh=y9+ho9dpqc7wD3+0v7h8zt2+/LxS/3tE3uCEZNhddLw=;
        b=l/UbfgD5y7YlJn0rHHZuouyOFMRCOJ/1n7Q8IFm4b3fbptivO5pmOeKpzKhfNkze6f
         B1ux0jwtXs9x8G4BiUW8RRnlrVhW7WN9dkj/c3Hgg2I5noBiFgWejKaZNKmCGBIznsUG
         mDpFFjugQuHG1j8QvHcGrLBHBeWlU+nNs+KOdFw4mU03Q+0hygIz33lmBFJO5qdGTASN
         jozoE6p6HOOzMLjGrOIex7xbzvZN8fAvolXeNuhG1SFlwFPp3cMVSTThYA2T42maazdq
         +era/7jElGLhBPi6RDDKaJvbMnNFQlcYST2IBA6KVJktqJdl/SqSM6dd5veq+agldyTN
         g1AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786375746; x=1786980546; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
        b=KFOMDrQPCjnFo1D/hEIpn6e20A8K4MGCmPwpgtCCe+ZHgImVhpxq+OlYZNjcexEfgZ
         HfPDxnzuiMh4wVslKu0T1k1v7n+ED5BQurxrtC5Cz0/Dv2eI1zIPZxpDus8n8pG40pkF
         02UFJHAWtjK7TDIUiuMb5mTdz/TPILWg8JyDOouqNYiayoDJJZfUZTdTqrMJt96GTHFs
         Y7gHxKFHkqSLvrdJjOYE/0qdwQwc7zltAWzUiKdRdCl5CuJBIpDCAbLF3GYp8svgj1kA
         0D79gcOlXR2a1YklALu/WDqeKhH2jJtsoYeKgdw1Ibpt5aicpkTkfpU/hPBc6bt/5p7A
         YOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786375746; x=1786980546;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zCRGU5HCA6z/GMlHy6u0KoSXvvUh0siN5DEwo60DeHc=;
        b=TrF1hEUuKY7xXvpzSGpzI0BNtmL8f2VEc/C/PYnNHdNtBzGEat9cSZ5O4HPTy75Ayp
         pI+WOMtvrOJcTqf8Sl5dU1/cwu3ygPOQeUSjMbldGV9KTpIpbWbeK9Kpj7F1lq9fsGN8
         NNu5XWMxNNZXtHSewKB89RuanHH58loNQI/vyPlMMb/VZGwkeObd6kHHtve4TS8oAw9I
         qMKqzpD+NqLAcdq2MtuKLg6S16NHoFkKJRpxqb756S6ZZY39wBVZMNBTVh6fxBxebjpt
         j+P4CnP/SdtMkLFZxllTM+Wh1S6O7AJUoOc2pHUrt6ssCzBNsXrZ3M/2JHK3X8KbYH2e
         RkWg==
X-Forwarded-Encrypted: i=1; AHgh+RotU5aBj7/khi1IRrIbIOntxNpqafdu0hQ9cdzloGZ/xj53L2cBx2DRWmbwjUedhAAV4rSgfB0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz08aJTOCeK36yhXFref4J0dJFcqfoFEMLavf7AbC49Ym4GdLQr
	tZLQpiErOEkAA7ynhpnc+1jttmiPUkc7PM+T7j0wYXaCSW2u0nOBybnKD0w4IFqWWq4efnt5iQk
	o8jbI18eqDiXok2xqWqy6PU34/OeZDQoFuQ==
X-Gm-Gg: AR+sD11EYyv/OGVF09UInMn3vCntHn7d+VNDwmMlkHYffNovtp0ohAWyPw94dpoG1jz
	8kjaP1xAJh649C6l01Bg+iDhfg8D6fd5QtPBVki9XF4cFAS2MMNUqZxjslMIYr+na1qYjRq+pb2
	7bcXkersOEyRapOpoyJgi2/afjdqKz2QOw4188cTlZO4ym5yAQY6v74M0f1hV+jOQjnhh5QVskz
	7DOgwFfMMkxlOCXal1pB50Zlx/7QiLeAMu+GdvdOQgUA3M8FeXGtG0mtJNGxFcfiFZISUJAustA
	jDs7SSssTGWBILf3t498gvYGtNSJoMlM0F2E2iFYHQegu4+T6/4YKBuhYUC6IYthDAwbEqBS1HR
	2CHCdXFAdr25+GyJPN56IG+RV0pl6Chk=
X-Received: by 2002:a17:90a:ec8c:b0:38e:549:9e04 with SMTP id
 98e67ed59e1d1-3903c5c101bmr32377324a91.1.1786375745798; Mon, 10 Aug 2026
 08:29:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808135942.2880971-1-lgs201920130244@gmail.com>
In-Reply-To: <20260808135942.2880971-1-lgs201920130244@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 10 Aug 2026 11:28:53 -0400
X-Gm-Features: AUfX_mzxEVWjyMA91yyuAHYgB82GBMnbuh99tfXeZl3LTUv9kt3twL5mx0BLoL0
Message-ID: <CADnq5_MTp9ZJw6f0Pu52kS-sP4xrntBj4kBvZtkbmcd1LC6ewA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix autosuspend cleanup during teardown
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Sat, Aug 8, 2026 at 10:20=E2=80=AFAM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> radeon_driver_load_kms() calls pm_runtime_use_autosuspend() for PX
> devices, but radeon_driver_unload_kms() does not call the matching
> pm_runtime_dont_use_autosuspend() during teardown.
>
> If the autosuspend delay is set to a negative value while autosuspend
> is enabled, the runtime PM core increments usage_count to prevent
> runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> during teardown, this reference is not dropped.
>
> The documentation for pm_runtime_use_autosuspend() also notes that it
> is important to undo it with pm_runtime_dont_use_autosuspend() at
> driver exit time, unless runtime PM was initially enabled with
> devm_pm_runtime_enable().
>
> Add the missing pm_runtime_dont_use_autosuspend() call to the driver
> unload path.
>
> This issue was found by manual code inspection.
>
> Fixes: 10ebc0bc0934 ("drm/radeon: add runtime PM support (v2)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpu/drm/radeon/radeon_kms.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon=
/radeon_kms.c
> index dc43fd790a9c..4a99c09f4164 100644
> --- a/drivers/gpu/drm/radeon/radeon_kms.c
> +++ b/drivers/gpu/drm/radeon/radeon_kms.c
> @@ -71,6 +71,7 @@ void radeon_driver_unload_kms(struct drm_device *dev)
>         if (radeon_is_px(dev)) {
>                 pm_runtime_get_sync(dev->dev);
>                 pm_runtime_forbid(dev->dev);
> +               pm_runtime_dont_use_autosuspend(dev->dev);
>         }
>
>         radeon_acpi_fini(rdev);
> --
> 2.43.0
>
