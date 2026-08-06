Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A533EC6B6
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 20:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786047954; cv=pass; b=b9LKYwBEfe3l5m0U2viIiIRmV6BMCMQBpP9xTeA/RACzoLXZ2044cMFDrdeaz7Mt476vR285V/DuOHwq8yLwiwgoBHhPZN1aWRf16DWLDy3kBl3eIGteliTX9Coq8GDXyMjNgNFn+O+IYlsKWpiBmmEw/dRbJp3EVgGc60GqLDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786047954; c=relaxed/simple;
	bh=BTA1DdB2+UDzT0c2teJtdqw99EMg4usgWYA4pBPRgPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z3hXd7v+1w6YGf3jGbdGhMB5pbnvYi1lLLZAd5vxyRWdr5t0kbhfEb2PFCV3WdULvccJmDUkv+9gKoYjJmWYtdzgf/psO6fL/MXukoakWUoInvXjrW0LbQfB0bGnSsg02FXvfmf2IgaAQWnjHHUdVYnz9j9/xBUAk33qq2m+UvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZkmeLgLn; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZkmeLgLn"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38fe113c792so358177a91.3
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 13:25:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786047952; cv=none;
        d=google.com; s=arc-20260327;
        b=KGcRrEVewPgK3w9giYCnJVvQTcouPGbG6YjNIzmtJjkwknN53YZiHE93I3kJipurmC
         CAcGfX0rOrBEqRM8t9jyXiNawQZeWuFJUhsGNXYmV0WQFf5f9QePWQJ+MkeOwT8kxaZu
         9W6doVvySepthvTQrnoVl93ElZyeY9jGDXSjNk9q91Ff/lUElRVPu5IZQqZOKVGhbeiu
         XERx9pWHX9B8IVrEuLuDEIEftRiLo1hsHs78zCeLtJm+yCiuUR3b+bvpJYyUGQld4x8b
         FsSY3M9cscj6jX954+9QROAvBDyo/w6oCMR9EJKLBbWipbO3ZUpfc2anU2minW1hGbtF
         NGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
        fh=HUhnJDgDK7qPfa+ylcXyejV9YnFftuC3DPsqYnf9g1w=;
        b=PqonRWm0uFHGEDWi8j4dNq+eEdDx9lwaj2Q+gSLPoyZEpyhkgMHkw86zMxJnG3TiRY
         XLaCEfLilY0nz7Z/9L5X5lMaqjpo6rl9Iq+chRvmjNGBzvE7YMMwFRkrxesGqaDFdAeY
         rdV/rSQW9pxbYxUs/dyJibOjA8kesp+uN659WlRpGVJVuSvAWVmUHMm5hT6Qu2DHEkMj
         n65AA+NSZZu7tEEgeLI0e7hK5yVCQJXmqMoA3IUfTU3DI6zp96E2dxD+FUn1+PxFtmuU
         H+yWqbVa00b880beQ1PDh57AUucW/O06nxI9CrzjoPQQyqaG15FP3mYFWJLYKOv+vZpM
         hs/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786047952; x=1786652752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
        b=ZkmeLgLnzl1NH5XYPRvqrbNiVXyhu2dI8YZA2QzfcOpbXr+XadCiAF7EuKzjI7LXqI
         hXQB5pRrgtN89FGqayq7HGJUo55rFSmyYyJoZM6FEPcA48LqMzK7jAu1L2x5xmCkaoDP
         MGrvSMSY6XZfKmtQxMkFxCf8swu7QmPXx5PXcFlbyI7dnPIUYQC0jMheXsQbxvWWTs+a
         js119nrNuZAY/UDiykvR/PR4rVGKi2/5IPRqOwtVCtXhYT57VZFMdKMS9/oar6yDQ9zy
         2gHT/my0X7TCrazF4JyUidaZ11JOIVBWjPbir6tfxpKHsCV86luYsNqzOxR9D+rUIRuJ
         6lLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786047952; x=1786652752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UB/TLDxrBBY2QlfdHBPHAu0QzanH7iO9OxicGBoPGLA=;
        b=fzAhCSsJ0K80Lc3vdXfg4GsxIi/2tZMVbdFV5KCr5tfUc48R08Z/yTTU5yH4Fbz0ix
         +xwLj/8XKqRetZ9sV0/xTWRDQ1B8FT7d9ETUgmeBG1WIBe+srB1JWvHAja+h1ktU7t+t
         MiLIRdG0uN4+XdFH/pG1X4jIQQh9oUg0RgB44jGl84KD1zm4Gvyspq4WZDsJTR9vL6Z7
         mGRR6+0d4W0PrMrjjlyCjFkj5oD7HIJ1aHO/IzeD7bcdjPBqr6yYlAbtGb/YzQrlZsrT
         lGFFwlcHLa5cp9ipFsQvY/wBvizWhyIGhkW3ihTYv9VXDFd3bNJbOftxv1tadj28ur0x
         eLag==
X-Forwarded-Encrypted: i=1; AHgh+Rq1aG0G0yjm0eWiXfVPzzHUhM8nMqGuwfoB2np93BU4gkHruhHB3L1/g3t7gCyg2qgRON3Sg1c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7hTZtTD9kYaO6E9ZcqE8lFoXfQPw+JxuRj0cvlVRRBmDbuJwh
	5mf6BkvkcIaBBgMLaHOoJGsgSYo5HcqUlqcGUIYkIulIy/O0Zmf/hISeg8p1LUI0Zd0NxBgIJUZ
	/I98qwrnuwWYXRZ1yPzUJbiyZn/w5EJY=
X-Gm-Gg: AR+sD13mNVsdYj4nEMmFCywZKXMJKLsRwrT5X8EaFRqWMlKpHulg9z6oVOA5/AKur9I
	M0Pfl6hzO+3AHdyTRYzlVFutZYLxpqMxTRPfWIP1SRTixEjhfGgHjXWua6D7kl+Iru89mFinKf0
	qcohXAVfaTCsXEZ0x/qhby/ea28gns7NtWizPP+i4GBAaum4mfTts/QWxl363DyoVO+UYsdS/dE
	b0Jr/yOH5Fmol6tmX+cIG9xLda4/13gBqpnjehfQZp5R3pMhSu/kMJHK8TzePOBg2zhTtmRMwCG
	PIss7dBeF5WX0dclxQyAZFMs+Nut8K+S3Qfqj+rVOHc9HtTYgS3Ued5VI2Hqf/RvRJRiZ5u80kV
	HEKeoAuYiuQlwWrCGjI/tC5gX99cRZEA=
X-Received: by 2002:a17:90b:3a81:b0:381:28e0:6248 with SMTP id
 98e67ed59e1d1-3903c510c3cmr11918552a91.1.1786047952031; Thu, 06 Aug 2026
 13:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-amdgpu-fixes-v1-0-ce247012d4da@outlook.com>
 <20260806-amdgpu-fixes-v1-1-ce247012d4da@outlook.com> <75a5fe30-4ae4-450b-8053-2a4633c5115f@amd.com>
In-Reply-To: <75a5fe30-4ae4-450b-8053-2a4633c5115f@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Aug 2026 16:25:40 -0400
X-Gm-Features: AUfX_mwniMh7P5P2yqjjnyFH_x3k9YJsgfjH2jDtORPTDpSehrDugpH-kLVXCOM
Message-ID: <CADnq5_O3FeOFFmdR0tQx6cATN9PRmS43Q+4+HZTSXnb5HVUqvA@mail.gmail.com>
Subject: Re: [PATCH 1/3] drm/amdgpu: disallow multiple FENCE chunks in one submit
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: moonafterrain@outlook.com, Alex Deucher <alexander.deucher@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Jammy Zhou <Jammy.Zhou@amd.com>, 
	Madhav Chauhan <madhav.chauhan@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Thu, Aug 6, 2026 at 8:03=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 8/6/26 06:45, Junrui Luo via B4 Relay wrote:
> > amdgpu_cs_pass1() dispatches on chunk_id once per chunk without
> > rejecting repeated ids. p->uf_bo is a single-slot field, so a
> > submission carrying two AMDGPU_CHUNK_ID_FENCE chunks runs
> > amdgpu_cs_p1_user_fence() twice, and the second run overwrites
> > p->uf_bo with a freshly referenced BO without dropping the reference
> > taken by the first.
> >
> > amdgpu_cs_parser_fini() only unrefs the final p->uf_bo, so every FENCE
> > chunk but the last leaks a BO reference. The leaked BO outlives handle
> > close and process exit.
> >
> > Reject duplicate FENCE chunks the same way commit fec5f8e8c6bc
> > ("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit") did
> > for p->bo_list.
> >
> > Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> > Assisted-by: Claude:claude-opus-5
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks,
> Christian.
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index 5445f75741b5..9c514cb01096 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -228,6 +228,10 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser=
 *p,
> >                         if (size < sizeof(struct drm_amdgpu_cs_chunk_fe=
nce))
> >                                 goto free_partial_kdata;
> >
> > +                       /* Only a single user fence is allowed to simpl=
ify handling. */
> > +                       if (p->uf_bo)
> > +                               goto free_partial_kdata;
> > +
> >                         ret =3D amdgpu_cs_p1_user_fence(p, p->chunks[i]=
.kdata,
> >                                                       &uf_offset);
> >                         if (ret)
> >
> > --
> > 2.51.2
> >
> >
>
