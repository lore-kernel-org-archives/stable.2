Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1501D518127
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 21:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790027872; cv=pass; b=k4wDIE31h1Uhfs0+gkUQdtMM5vTYau/8aZkb+tsToJEIuDKI5LabdfFs2B7ADSZRm365cLhcScgp/jRcR1gnyl5Ai5nTJH8uiaZVBTZn9DiOh/oDLVvnlbA7PZWI+lnoNgu2+cBbkkHWn07JyYpmnDfb37wgro0l8U+qt60kiCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790027872; c=relaxed/simple;
	bh=z/GhqHnrayzMkq4XP/AAv5bpwGxws0vq/kqMqhVEtNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OI8lAgMSsY9vm/ndLuIZUthxK34r8hQb8bfkrC2KeJxIsV4xS2e/PcGrhIlbFC6Ah2XiDex2zcdgK7X4i8h8AbRvlZK1AW/b7iclaKl4xIKluU0nCpJezRt0onFUIoP42nRj7CvGCzSdKg2595s1mZhss2SFPBE2/F3XcAF5s6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsagRWjH; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsagRWjH"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-39e6298aa19so475935a91.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 14:57:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790027868; cv=none;
        d=google.com; s=arc-20260327;
        b=r+/Woymie2twlzoCN1r1Ymjog6KL0/7H81ksgLgjekIF+9qocj8KCEOxBv8TxjbM67
         v9ggGDmAn20T78H6p5tvLT/FVgPc4COb9EyLBeOwMigUFtyQkxjnA73amFzPKsPoHzm4
         MFcS4SyLE4tOmZ+8lNE+gBF72DeD36uuhgN5oP0DLTdXTb/gNJj9p852lRG3TdRi9RRi
         Luuqzr3hzsSSeRsvE26+8e1F0ZYoiWhwVd/OwwTAm9zp3i/9g/JfaAYJqLLBYLUfoMnq
         1UubZX0a6+H+6xqlJf675CQI0fUQGv+oemuBST+3skP1JxKeJtosljub4zB/Is6RD9Co
         yqjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
        fh=iVcrc4vu5kWr++ebZ2ni+c7GyktuztQ9JGue9H9IsKk=;
        b=EG8GIRzr/h4jp3GK39ijEE2cUzu5UVlCNr/8KhLLK0G+OzXpXEfdIUAjV4wCjTihrk
         aq3xrXjUwBhlnEn1BgihqrZ0VP032rcf04xtTDUfqVsmUxraDgZSsk1+jLdEmcz0gTXf
         YygYjv4B7tY3WFg9bwrWazCp3iHPjx3MLDOI8Bv3+pT2/Vl0qMcCXcpNUT2738zQ66NA
         1Jj6epydwJGbWljcRgfthN4mmofmB9yAHHlKzAfVk5bczXGRIdcerhJKx4/doJDo/6pJ
         q9ee3YSrkaYKv+woFFYJqtRNHcXEJ06LrA9IHazq+0H+f5s9PKKGhF6lQJILwcQUtXOm
         Cvrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790027868; x=1790632668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
        b=RsagRWjH7XnJjLU/v5Zhta2QaJUJE3zowStUVKirz6SixA7y1I+ffgktVJ29JP8aza
         JSeF5+dNLFnAknn5vHBDZkX3+0zIVPxW7AMfDc8HK1yTIRDf4SkAYwkX+fxI0ht8zq3A
         8r470CQR/ZbMsHCbjkzigSZoZaCMkXudc4Q94lK1I9z9b366+arMvH1bdAwWAgs28Zp4
         iRDiCfJPo6yq96yrxxM+EEvGcmqwjj5G9SDCYrI8al5HDpA4GNqm1dwxinMZwMxTvksE
         wS0tVNcmJzwltzjf6Gv0eq+vxsiWawWTWfMt3FMAKAg5r5ATxr84hOTciY72SFcyzBGd
         5WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790027868; x=1790632668;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RwYh6OjRPIh/KNj842KS6LrZRkmlRh26aRS3vty9X+g=;
        b=PNtZBSZ6yCF5R9cAK5P6qXqtpmfBQ2FtUn1YDBKDMbC5Y5ktNunc5733siHRxhqOL+
         ga1eCil6qe1mdcoKZr9Syff/I5HRYEVyUOBYVlnm6iSF03GmEU0R1BtudJMbGWKLvUAA
         5bqULhPZCqwGhBQnToGwbYQY4CxzjRTtM4lxYr3fBpl1IU6Qjy9h+XV10KI3eXwmNkqr
         /idY0iJSibmDY7yaZsDfjVPzUfFj409onlSvnZaN6Lu1dlkvhY1taJp6FJCm283qUhrH
         FcDk61l4uzg8x855TUngYfOvyi+stNY3ogpSi67BtbkNfoHMqc3Y0D+F8Q8CagzUVh12
         DuhA==
X-Forwarded-Encrypted: i=1; AKwUvBz9cZs7bFediwlvMBbwqf8gm6EEBVBy8+w4/Zw8bqsXsMChlNxwkiv9snAwZb9yucWikBaoCJM=@vger.kernel.org
X-Gm-Message-State: AFuF++nYRJLL682g/Nnd+K5CKXqj7U0rcNJ8zdoslCUDmSDJeKAd274z
	owfmzfQNqZqkORHUZMIS60ATpEKVxVXvm0npEQ4aDlM64ktIDaClnAbj8RDEHuhqUOjf3NyhmpD
	1Q8H/mI8GAo05awGo4YHRUpu/WwcH2D4=
X-Gm-Gg: AYBFou0F6n8V9tffXWRJWzbn3oyil0OQJW2XWGNEhc469o/4v8SC5OLL3eAbx7AieYr
	3Xr8eYE6sgjFXv7nq2EKpnA9zQnvXzjV4Qs7sIjdK3QsXtUIb/ED8NqoiYLVrqEhcyEg3+13k2H
	qQLDNdJNpKWkpeFmTQGVPgI7fslvG4d1zkrF1jzIhD/Az1KlUBlnDtCm0i8xd2tSJoXWz1pihiL
	eRrUNe1ByHzkbI0ETllRGxnZ4K21K3R93TP4cwNZ8uKr6qm2YKvAarv+3k1T2gB6Gf9Wp228bEg
	Pyzd58t2iAcSj3DvCuT8pNJQghSXtMp8f1EaZjlRArOWxUoWDNdc1jU/avDHuiZtuM4IG8jhM/3
	DhEbwASkpagD5A89UVEChmMDLzoEeypQuHBqtCK+gyA==
X-Received: by 2002:a17:90b:50c6:b0:39d:e1f2:3400 with SMTP id
 98e67ed59e1d1-39e599ff59cmr21734363a91.5.1790027868375; Mon, 21 Sep 2026
 14:57:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919165511.3687822-1-lgs201920130244@gmail.com> <b483d12d-f34a-4740-929b-28423d9c9b17@amd.com>
In-Reply-To: <b483d12d-f34a-4740-929b-28423d9c9b17@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 21 Sep 2026 17:57:35 -0400
X-Gm-Features: AcwNN1UohLrK7gSjDi2UGC9O6aoP5YtKGJPc1vCQfKTwGIeZ-NrCeJY0S5T4r_c
Message-ID: <CADnq5_MSwTURavbU8ryixhPdsUfgBf64brJpALhkCeLq12BhXg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix IP instance memory leak on kobject add failure
To: "Lazar, Lijo" <lijo.lazar@amd.com>
Cc: Guangshuo Li <lgs201920130244@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, 
	Mario Limonciello <mario.limonciello@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, 
	Tim Huang <tim.huang@amd.com>, Luben Tuikov <luben.tuikov@amd.com>, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Mon, Sep 21, 2026 at 1:16=E2=80=AFAM Lazar, Lijo <lijo.lazar@amd.com> wr=
ote:
>
>
>
> On 19-Sep-26 10:25 PM, Guangshuo Li wrote:
> > amdgpu_discovery_sysfs_ips() allocates ip_hw_instance with
> > kzalloc_flex() and initializes its embedded kobject before calling
> > kobject_add().
> >
> > If kobject_add() fails, the return value is ignored and execution
> > continues without dropping the initial kobject reference. The failed
> > kobject is not retained in the kset list, so the normal sysfs teardown
> > path cannot find it. As a result, ip_hw_instance_release() is never
> > called and the ip_hw_instance allocation is leaked.
> >
> > Call kobject_put() when kobject_add() fails so the initial reference is
> > dropped and ip_hw_instance_release() can free the allocation. Keep the
> > existing best-effort sysfs behavior by continuing with the remaining IP
> > entries after the failed registration.
> >
> > The issue was identified by a static analysis tool I developed and
> > confirmed by manual review.
> >
> > Fixes: a6c40b178092 ("drm/amdgpu: Show IP discovery in sysfs")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 2 ++
> >   1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_discovery.c
> > index a404d8aa13ee..4b1ad1c0a10b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> > @@ -1314,6 +1314,8 @@ static int amdgpu_discovery_sysfs_ips(struct amdg=
pu_device *adev,
> >                       ip_hw_instance->kobj.kset =3D &ip_hw_id->hw_id_ks=
et;
> >                       res =3D kobject_add(&ip_hw_instance->kobj, NULL,
> >                                         "%d", ip_hw_instance->num_insta=
nce);
> > +                     if (res)
> > +                             kobject_put(&ip_hw_instance->kobj);
>
> Adding a message that this instance got skipped also will help.
>
> Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
>
> Thanks,
> Lijo
>
> >   next_ip:
> >                       if (reg_base_64)
> >                               ip_offset +=3D struct_size(ip, base_addre=
ss_64,
>
