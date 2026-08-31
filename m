Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA4F3FBB44
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179427; cv=none; b=g5ZGu/Prdj4++GChHFBRX9bgRmdXU8Zgpxx/+0QL/4tSA1nNdQ5PsQT2QYidUXpwQKY13Np+aG21SFb/vXic6W8L5LZHV59FriaUMlNbfmnUMTZHf1JwNAN24yVhhkBOCeX4Trs0yUmHiuWpKD22c/YOmgKhJD4hQOT/bezZsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179427; c=relaxed/simple;
	bh=pu6v/vKXFSzBGOHkpi9yehC8QJv9s7y6zhz5gCJXY+g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PUV9RjXJSPmTRPRQjK2331jbwzNtQSXOhdIJy9ZnqaqLDRuQkJNIwFvO5cPb3F4XrRBXMxE5/cnjjsz6wAS8FZzMN1c3vohDVa0eBW0ENiyPsZjcfLG4i+eYgIitunusISl6i8Fa88BuaGw+w+ewlBih1K3P6YTcRaqDBmci9zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mi+HYxxD; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mi+HYxxD"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c2055573c8cso432673866b.3
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788179424; x=1788784224; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pu6v/vKXFSzBGOHkpi9yehC8QJv9s7y6zhz5gCJXY+g=;
        b=Mi+HYxxDSoaU+B6g9M19fVBbErM+7Zupm1V8T6nK7gUpWVIeiNif2ZXuhE6xbMAxQW
         1pc28V+sqbs/ppztQXc1NG+yY3a9LjhRLlHKJriiuq6Ld7nIlTJ5maza9vszYB2+vOub
         dTOGfR3KLyrZvwBXbxjqDWfhCIoEs5F35knSA+LeTY4SrIfgVwfCxyNFU6cxGSRPMsAz
         XgjWTCt+fvqaUqhSchsDA9W0vkc5WFmJH1NasLHd9xgqC/v1id9wX/8p69NX9rbV1U0J
         8AptwbZxY0lCCBpbtAv84X/08IrIKuleQ96uKVt2kdhkPGi6QaUigX7MJhMHSrbaE8TK
         Le2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788179424; x=1788784224;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pu6v/vKXFSzBGOHkpi9yehC8QJv9s7y6zhz5gCJXY+g=;
        b=eGRGqFa7NLi9kh3oqAPvzYslrKG0OIoLDcL7SfUCKctaQOUbnboTWvDUcuC8BxSx6C
         7Y+Er6wfp/hhCjhV7ncjaehslFEBVOyKVFgUt9kM8orHo3B3ij44jCIyJhfMz6xjX9R/
         1oNLTuTQNhuXtTlXX9xLiaQWou+Zn3SA1EVUCF7jx5Iq6JyPGRnauT5+/TeYbvHjiKs+
         1CeQCyhpRyfOOFFsNf+WSMnc3LkWjTnoeGVN+XKbi1XCxcxWwVnRo+h8Kz5paKj6DDD8
         4tjrLsrmXnRdIIAvacjB3QrKNixTKMoRtretDieFDGNB5BkB2C++qa9MZ8aTVdWTmmnC
         6eDA==
X-Forwarded-Encrypted: i=1; AHgh+Ro5eUPJEl6U3Vqkaxe+mRwPbUDzwTQ4GFURyiyGRgVu5SFDBRiCzJKhClBWyX9fmvyKgt7+5ek=@vger.kernel.org
X-Gm-Message-State: AFuF++l4RRqXLF3ZOmm0moWqFq60avpUmF/HMtLSSo/S2SfwGEgn8MWz
	6wblxsmilvOvLs8LvnAFkMXd+dN58PZAfI4N806MCQBGsdytU4N2oW2URSFQXg==
X-Gm-Gg: AR+sD12NG02d6jx703MghAFpWcfFnA4FuerC6QQLnjA4iOBitzENaKtwamVdIMySRq0
	DOiRr4VZxZQkX+ZSZyFO8suxfTzzCtiYLpvj3Gi3cqpMM6JZTHtHv9EhcegwwHMlOVFBJIfMl1X
	jDEbo5xnuqLOHhMPi0md7Z0gPYSYnUBqsXFf4ZdZg5vIaqFEQgTqOZObGS87G3wvSe1E3WA8FRI
	wOJGxfwKX8pMEjelLMOt0lp1ITaH06lQuzzNRThkDOFUxCINy0lJ4LFNqMOfe7fOdlV827414xR
	9YnDkF9uQsSfo1dhqhFzIV06Rjb6DGOK8CWkxRKH3JkG2a3bM7LgiNkXNLIPQ8qfcAOxCqDSIXc
	Vs8esfHeI/7+kuFftUDbv/HNazFuxpqEbU44Ji0ebyTR2dSSZlBc45Tg3zd9J+BKsgJVfgynfJU
	6n2NOwdsT8ufsIBplRSLPiUFkLKnZVM9SLVe8Nyfu8YCSazCk5YQYj3aTUVAnvzp0+KGXtT5191
	FqSJClT622LmTt7gw1H6WyypiLc42XFR4X/
X-Received: by 2002:a17:906:7947:b0:c25:4ba1:5953 with SMTP id a640c23a62f3a-c255702dfb5mr1707153566b.11.1788179423981;
        Mon, 31 Aug 2026 05:30:23 -0700 (PDT)
Received: from timur-hyperion.localnet (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c25895beeb8sm225045566b.31.2026.08.31.05.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 05:30:23 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
 stable@vger.kernel.org
Subject:
 Re: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM clear-on-release
Date: Mon, 31 Aug 2026 14:30:20 +0200
Message-ID: <UJ9MXKXkSh6txd43wHcgSg@gmail.com>
In-Reply-To: <03347904-e0ee-42ef-a40a-478309a2ba33@amd.com>
References:
 <20260828044734.135460-1-Arunpravin.PaneerSelvam@amd.com>
 <voa7PnOgTa6oSIPH4Hu9jQ@gmail.com>
 <03347904-e0ee-42ef-a40a-478309a2ba33@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, August 31, 2026 2:13:47=E2=80=AFPM Central European Summer Time =
Christian=20
K=C3=B6nig wrote:
> On 8/31/26 13:39, Timur Krist=C3=B3f wrote:
> > On 2026. augusztus 28., p=C3=A9ntek 6:47:34 k=C3=B6z=C3=A9p-eur=C3=B3pa=
i ny=C3=A1ri id=C5=91 Arunpravin
> >=20
> > Paneer Selvam wrote:
> >> Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reac=
hes
> >> via its direct MC address without programming a GART window, yet the w=
ipe
> >> still forces a VMID 0 flush.
> >=20
> > Makes sense.
> > We don't need the VM flush when we are not changing the page tables.
> >=20
> > I agree with the patch, just would like to ask a few questions to better
> >=20
> > understand the underlying problem:
> >> On GFX11 (e.g. Navi33) that spurious SDMA
> >> flush can wedge the engine
> >=20
> > What is happening when the SDMA engine is wedged?
>=20
> As far as Arun has investigate the UTCL1 request queue (which is part of =
the
> memory interface of the SDMA) is in a deadlock, but we haven't quite
> figured out why yet.

> > Can it be recovered by an
> > SDMA queue reset?
>=20
> Most likely no. The UTCL1 is the translation and memory request queue
> between SDMA and the core memory hub. To reset that one you need to reset
> both ends and the core memory hub usually needs a full ASIC reset for tha=
t.

I see. That's very unfortunate.

> > Is it just a hang, or can it cause other issues such as page faults?
>=20
> Good question we honestly don't know at this point. The HW guys need to f=
ind
> the root cause first.

> >> only flush when a GART window is actually used.
> >=20
> > Does that mean that there is still a risk of the wedge when the GART
> > windows are used?
>=20
> Yes, and that is actually not limited to the GART windows. It looks like
> every time we map something into any VM it can happen that the SDMA crash=
es
> when there are concurrent operations ongoing.

Would it help to set
adev->vm_manager.concurrent_flush =3D false
until the problem is figured out?
Or can the crash also happen when the VM is not concurrently flushed?

By the way, is this the same issue as the Navi 1 sdma_invalidation_workarou=
nd=20
or is that completely different?

> It's just that the GART flushes triggered by the SDMA made that scenario
> much more likely than anything else.
> > Can you remind me when/why we need the GART windows exactly?
>=20
> Basically every time we want to copy something from system memory to VRAM
> with the kernel.

Understood. Thanks for explaining!

Best regards,
Timur


>=20
> >> Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
> >> Cc: stable@vger.kernel.org
> >> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >> Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.c=
om>
> >=20
> > Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> >=20



