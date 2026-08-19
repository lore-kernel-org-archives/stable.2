Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E53C3F75
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787129954; cv=pass; b=mirrR8a6gMIwQ4puBNxbtESGy+8Eab644pKPZC5GRHQKCLi6Pq/7ATUukaykGWzmJLBciGU6qornuNfTQ4tjdVfR02kZWZynN6i5XzD1UUWdYm75AgxdlGlC1V4qFl67nW6tQN6DABsWET+o/pOfVmuV+XHK59Tqe+aCvCa1zOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787129954; c=relaxed/simple;
	bh=POU4QgGjlkB1m401znQIYU3NrwHbaXA8RwN9Ac5rsHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s1VV6Q8JYAlvLiqFlPFfB6aiTzvEUTGyJImLY97QIS5Crhx6gVTX0jcxAizfukoeJLSU8wdnuVClsj64qyXR68E0oU4avEylruckIMnN0gRKQBaoBN6wd4WjK5XZrzLXeMDivQQbuPy0bwUb4r32iIwlt19XTgrc5EqKsRJ8jqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b=LBB61TGB; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="LBB61TGB"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a10d6f455dso118588a12.1
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 01:59:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787129950; cv=none;
        d=google.com; s=arc-20260327;
        b=n/L6z6oIohPjaISrbZ3uj+jd1W09se2hUTMnn5r8nMV0VWu9QEp+FwQpvrrKukufjW
         vIz94rWlWECXUvDwn+AV4L3tCO/Gm0NSEHgvFFTotDaXFlngys2wrKgeu/23133ErI1G
         Uet2p9eAVmSMomRxAvY5XPVyV0rD1GOIK2yIEBsZmRTcEQajQhfaD88b2wexBpPYOO89
         kHOs0yj1ar6cD3AStd4RbWX8XGo1/ALr86MIisNzUN3RptESiPm+NFAbjfj8B5bg4VKa
         gKm9FsyoID/ppr45ukfVsTc5KMxgYNP7hSj6ySoXw1tcB+A69pWK1gOwDm1vBKC4qBqk
         H0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v6LqpiNyutcjnM2YuW2WgPqXG0K1W5YBbJLrp6yBCYY=;
        fh=+Obk6ZXr+4upCi4V6/p8uUYnsYMVYk+v7/1gR2DzM9M=;
        b=D2DZ4cL86ZME23K9LWr/JfK8lXI3GJcr9jHwUjfcBGNGVt/4EW5yNpbPjctzYY+7AB
         AQUxycjbHcXDTJ8GwjME5VCIZ9hMGKIsJlQi1HVM4FYVKfDiR4CJv/a8iTpw1aKgB5l2
         vTa/sGrKURU4ps9q00tS+sXYXwuhnUiOtDeCkuF57at7cHksBHLrE1yigwVHCnU7daKm
         ELkxiuBBohCiVSycbBeNynGV/URF1peLAL3dZEbmLeYEaWvw/PY93OZtX442ATjwMbM2
         fg/oS3o6BzQhS5xnqV2a+/RMpIt7hJi19KwvJwIFW5cnfzTf1h4XGUyNj/STyfEyHyRj
         9R3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google; t=1787129950; x=1787734750; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v6LqpiNyutcjnM2YuW2WgPqXG0K1W5YBbJLrp6yBCYY=;
        b=LBB61TGBB0u0SdZeElefRiUMzWHSBMUtQlJOut1FMRwiHtBYC8JEgESBiQyxzBtY5F
         ialZb/v/Uas+u2HEXp4aAWaYhFIr5wuLKiKlQoJeWsB4bl/Y99+BSko0I43KYpirJq4W
         /fltRrW2IOtGOTN7FsNb0gp8GggKtPD7CuwkG0p8MyufZQbQrNCrf5kuwYFFlO4m1h3b
         bLuOIrzaCzKrt7WTHMVIe0HNxLQQKK1aXdWabsie9yVAwh9rjucGSpxstw5Ht9w0GcxE
         KRbfYZPiAE4dm1I5gRTTH5Dt/eMS1qAc55CfjWOYskWfEUYuRCwmeGcPFeA9TYWMbhG/
         Mpqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787129950; x=1787734750;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v6LqpiNyutcjnM2YuW2WgPqXG0K1W5YBbJLrp6yBCYY=;
        b=KbEpzjX1VmsF+sME8czFgQNWCJ4homk6MiV/Y8TILcElUJKpk+eKuMc2ZZye2vBXRV
         hHgopBqBqkRAyMR3FigqFUOv7fGF0o5qQkyFiYKc1sMNwF9mcmPeEMVB1/YJ2rCYRHZF
         3uggF7nWF5QEkpndkxJIbca51kOZNseq8+ZwZGC5pA849GzUFc9DiHXinBgYbMv1PIPy
         3i0S8A0RV0N8H6ZlkIUbMQJmPdXhid2NWAYoyGNKh/14Xj422HJAAvsuYnTe6Xa0sd3S
         7HzGpbuedU0+WlNgQzw5z1bNXvdq4XkU7ko8Ciua45v4KGlYCr+H1NffXjccpYYdMAth
         9suw==
X-Forwarded-Encrypted: i=1; AHgh+RpDXmqctGYZXoVKyHOyJi/SA8uXZpuhSX7lYhmWdDzKx44R3e6Zj9dbWgJgQqVJTLVy3pVSmGE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZTwhVXl3I5Pz6RRTVli1ofh+ew+HkmgBSM+9ZQ4ZYbYLzRzBD
	pGRrb0q0oEz+y8o/4o3n200/dGWKGce+BH99d2/03caDU1oFWwAziULVTm30pOCW63xFJO3K9/M
	N6iu/roagqAgjowPyKdAhtnhmC3NszqgRT6+Gp+wlTQ==
X-Gm-Gg: AR+sD13HHakjX262Zoe2RHa4CMWoa3jEmgO8Akkgb5pnT9uzxWIyXoiXXlfMcn4PtiW
	kNRSSSvWvgR4aZTaXmSvra4uz1jvDurc36b/yPJ0kOGGAa/PWgjtcB5zEa0FKICptZ6Bm+XQ9VT
	qjJfNpsRxAuuYzEKHm8ARjIc24HK5evmPr0FLjXe9L5pSM2lIRw6UwBhBxfM0DroNeEeDTS+tSH
	D06uIfNbJhi3QSxaAiVCi06nH+gFC+Z+R5REgf92WZiA63ogC+/XCOu4ooU6OxrKsWu3iP5EItl
	h2aMWzA+OgGfBvKe8RH8E/A8eQ692hF5DVzC73SdvsS7
X-Received: by 2002:a17:907:960b:b0:c20:c5f4:e19f with SMTP id
 a640c23a62f3a-c242e36cb2dmr96307066b.4.1787129949839; Wed, 19 Aug 2026
 01:59:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260817132535.394764707@linuxfoundation.org> <20260817132539.879554007@linuxfoundation.org>
 <521b22fa-ef09-4449-909f-0120edfc4b24@oracle.com>
In-Reply-To: <521b22fa-ef09-4449-909f-0120edfc4b24@oracle.com>
From: Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date: Wed, 19 Aug 2026 10:58:57 +0200
X-Gm-Features: AcwNN1XurzPwR7awOPzLb57kAKAR4d79LccUPmimiEZT5l1Ul5JEpUvyXAsYtLM
Message-ID: <CAMGffEmqrrFN6O2oqtAZC3iTD5UJrhVK80bmJLkof28C=uAfvQ@mail.gmail.com>
Subject: Re: [PATCH 6.12 111/181] KVM: SVM: Add support to initialize SEV/SNP
 functionality in KVM
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, Sean Christopherson <seanjc@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Ashish Kalra <ashish.kalra@amd.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, liam.merwick@oracle.com, 
	Sasha Levin <sashal@kernel.org>, vegard.nossum@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Harshit,

On Wed, Aug 19, 2026 at 9:12=E2=80=AFAM Harshit Mogalapalli
<harshit.m.mogalapalli@oracle.com> wrote:
>
> Hi Jack, Greg, Sasha,
>
>
> On 17/08/26 7:03 pm, Greg Kroah-Hartman wrote:
> > 6.12-stable review patch.  If anyone has any objections, please let me =
know.
> >
> > ------------------
> >
> > From: Ashish Kalra <ashish.kalra@amd.com>
> >
> > commit 6f1d5a3513c2370bbd6115dd430906bc2f4bdc53 upstream.
> >
> > Move platform initialization of SEV/SNP from CCP driver probe time to
> > KVM module load time so that KVM can do SEV/SNP platform initialization
> > explicitly if it actually wants to use SEV/SNP functionality.
> >
> > Add support for KVM to explicitly call into the CCP driver at load time
> > to initialize SEV/SNP. If required, this behavior can be altered with K=
VM
> > module parameters to not do SEV/SNP platform initialization at module l=
oad
> > time. Additionally, a corresponding SEV/SNP platform shutdown is invoke=
d
> > during KVM module unload time.
> >
> > Continue to support SEV deferred initialization as the user may have th=
e
> > file containing SEV persistent data for SEV INIT_EX available only late=
r
> > after module load/init.
> >
> > Suggested-by: Sean Christopherson <seanjc@google.com>
> > Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> > Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> > ---
> >   arch/x86/kvm/svm/sev.c | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
> > index 6cec696461da2..bd0344bacaf1e 100644
> > --- a/arch/x86/kvm/svm/sev.c
> > +++ b/arch/x86/kvm/svm/sev.c
> > @@ -2972,6 +2972,7 @@ void __init sev_set_cpu_caps(void)
> >   void __init sev_hardware_setup(void)
> >   {
> >       unsigned int eax, ebx, ecx, edx, sev_asid_count, sev_es_asid_coun=
t;
> > +     struct sev_platform_init_args init_args =3D {0};
> >       bool sev_snp_supported =3D false;
> >       bool sev_es_supported =3D false;
> >       bool sev_supported =3D false;
> > @@ -3088,6 +3089,15 @@ void __init sev_hardware_setup(void)
> >       sev_supported_vmsa_features =3D 0;
> >       if (sev_es_debug_swap_enabled)
> >               sev_supported_vmsa_features |=3D SVM_SEV_FEAT_DEBUG_SWAP;
> > +
> > +     if (!sev_enabled)
> > +             return;
> > +
> > +     /*
> > +      * Do both SNP and SEV initialization at KVM module load.
> > +      */
> > +     init_args.probe =3D true;
> > +     sev_platform_init(&init_args);
> >   }
> >
>
> I ran an AI-assisted backport review and checked the finding against
> 6.12.y. The backport appears to be missing the ordering used upstream
> when kvm_amd is built-in.
>
> Upstream ensures that the PSP driver is ready before KVM continues:
>
>         if (IS_BUILTIN(CONFIG_KVM_AMD) && sev_module_init())
>                 goto out;
>
> It also initializes the SNP RMP table from AMD IOMMU initialization:
>
>         if (snp_rmptable_init())
>                 goto disable_snp;
>
> 6.12.y has no sev_module_init() call and still initializes the RMP table
> through a later initcall:
>
>         device_initcall(snp_rmptable_init);
>
> The backport can therefore reach:
>
>         init_args.probe =3D true;
>         sev_platform_init(&init_args);
>
> before the PSP device exists. The call returns -ENODEV and its result is
> ignored. KVM can then enable SVM before SNP/RMP setup has completed.
> Since bb1c84647025 removed probe-time platform initialization, this can
> leave encrypted guests unable to start.
>
That looks like the case, we only use kvm as module, didn't hit the issue.
> The relevant upstream commits are:
>
> 435b344a7042 ("crypto: ccp: Add external API interface for PSP module
> initialization")
> 44e70718df4f ("KVM: SVM: Ensure PSP module is initialized if KVM module
> is built-in")
> 409f45387c93 ("x86/sev: Fix broken SNP support with KVM module built-in")
>
>
> https://lore.kernel.org/stable/cover.1739226950.git.ashish.kalra@amd.com/
>
>
> Could the KVM maintainers confirm whether 6.12.y needs this full series
> ? Probably could be done after this cycle, but still noting it here.
+1
>
> thanks,
> Harshit
Thanks!
> >   void sev_hardware_unsetup(void)
> > @@ -3103,6 +3113,8 @@ void sev_hardware_unsetup(void)
> >
> >       misc_cg_set_capacity(MISC_CG_RES_SEV, 0);
> >       misc_cg_set_capacity(MISC_CG_RES_SEV_ES, 0);
> > +
> > +     sev_platform_shutdown();
> >   }
> >
> >   int sev_cpu_init(struct svm_cpu_data *sd)
>
