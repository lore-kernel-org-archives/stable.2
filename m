Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB56405C33
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538156; cv=pass; b=eJNDkjb/h5Y+ZHBj3UzbjCP/5OKK4gXVJnNCHZYE75LbepnDIdVW81DHGmPMfq0RLgdcF7f4jV+JCl2nzoduegmAEn/OoIGC/3xNZjcI7MQ4inAnaGsvHFSC+rHMxMFea+J1/ZzVadwQ5mNApEB4sAgn3XEvg6hAR0No6IlpnZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538156; c=relaxed/simple;
	bh=ccFXD2g0SBG551wS62ws7fc8dZzkwjgII0jKEY0Jdf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h+Zbl9jgdm4X+FoK2BKxTx2JBGVLko4mHZOanlFMn0tX0L038u3v3Z/ugPgwocfAp+G/jkS4wl4/wB9PBGqv3cG79ynP4QCQAv43P//gxvTcv5mZI9iIFKYm99cF+FL5z8aJnP4fK18TW5g2l7sd4ZtvFMYxj+JN98VA5dU0VgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR4TCr2G; arc=pass smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR4TCr2G"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304dc707c7eso286510eec.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:42:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781538154; cv=none;
        d=google.com; s=arc-20240605;
        b=co2eZc0A0G1f1yLnpPdIWHs3ePsDObnufUgqvmJks8MxxWwK3tgdORcYyWpKSdaNEj
         MovAILeXE0cSRndyls1ReDecLExItIdIJ3mz3McNiFgk7oxVtSbnUV2/hI5Gb5Y+sxrn
         57TxjQaXR+wlwGByoSXt+chsnS5Wl1Y5h7/iKtFpFyt095NttxZOoGk5Aue5Ck7PBJW5
         ptnq9T6BzKkCnwRipOPUCH39IF73NauK5Li23a2Mo7DbQ7Hh85vko94zYBqtwDyG8W1P
         DhCupmu+ZOqGN4QPIrIPlKxUwfUEBKQmQsOfgbZqbq6vBlJUNgw2YYBzoUuUUXkC+X9Y
         IayQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
        fh=JxkOeA5FkIyYMgMZPSNOp8UuwK6Sy398WKTxgSXQF2c=;
        b=b9gI8j8exkekSqxTxbsu8NGFCPW6QVQSF8YEGralDNFLsh41boGXLoRmH9Ex3ThJA8
         9M+zmzr1Q8cy/1eMSHR4JoJl7Bh5AVm2qWyKtp0e44oEmw6agpLCP+prIDrH5JKZoMee
         aqRjYGmZEP0ksW35glwsbKb4XdcW8rRuCC7w17fmfhvX/rmoDnOt32cuF+TnxT8+/yL0
         OKRbAHCSl6KYbRvE5s3JydMa4d0LlJuN6gFd0ZAE67XxjIpC0KSRA2QYcRqzfjHCcHCC
         2/F3S6+y7SQMVDpgJjIdStcouLxTVg7sFStjzPPZzqt38B2Etot5tJFaT/fPlqDnqkWF
         7h/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781538154; x=1782142954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
        b=oR4TCr2GWwAAiSsw6OPC7ajnnQb/cDtwU+WIEWB1Axeg9agPDkHL7P2VSz4grRWcYy
         2EPdkBDv+hWil+2lO/XMsu4crAyB/DQwBIJWkNdioJ/9a/K2TgY+KU6QRyfDBgZb2EXY
         VlwWdkUnHTysJNjrfHiLA4wdbxP6ZGriGL7nSzWWLu00QfUzraTWVRwtKJmEq7KkuJmZ
         cxg/IIu9CMsOSynf06jyQ8254+37DVq6R+j4Xzb1wo/HUwLJnDYSt2TsNO1azs9o5yJ7
         K7DrmOBrv+cOGheuJxmbKzRQtQzgWNpflULmWr4uajIOo09+/xhxmh+IPI+c+Eoyr2y8
         y7sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538154; x=1782142954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HB5OTOAis4aNREHBYkXcEkOC2lkh0rrUy7H3L0anj/A=;
        b=GrBZYoBysft6WbwKLlDB/ENfegi8YF8KK8HZs8+O7DQ38w1cmXCYSrMxGnY+E7qK8d
         4PN0uqm4UuLM0HnHXl1cR1Lg88IpQ7HIyCO7g6pbnENyCeZsuV4PZzOCzM/HE0THo69P
         5y9gZZBvCHIyf16D8cpQvW7b22FRUYyoc2KB75ivDzSnKAjw5kCJfd0htgrwEBshEIi2
         2r/WipOhM1elA0rNYh9N3U2M8uxdWTvAQmJCA5A/Xm6u/K1twh8Ft1Mp9sr8WLeS1dcu
         pV6tZGycuq/QqIasImDu2riZXkljkHZx6DwyW2m4boh52RHOJoM6DZw0jB2Zvu9amR0O
         Jv6g==
X-Forwarded-Encrypted: i=1; AFNElJ8QB8xS+iwtcxS70t6vNgLcOkEXiYP712I0UCNBKKcTkh8b2aa2SAyXDKLjw2mkiokBACURzSM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzswmelK2wcIH3HhJ2j0YGXHq1rEI9nBiigU7Ai9nd7e0y79A//
	9aezvKg/OJupufyaVNPvNP69tIDYwuFTm11Pz7O1/hIk6xPUl6Gumhys89NbExjYSun7g6pSVwb
	SIB4qJjmTKxirMFgJsWGjdjob5nmZijg=
X-Gm-Gg: Acq92OF0VKrBgx7DjeHr4kdOLzexKow2/GX3uABNmhdEhcAEytMh0IIoYTD79TQQLJA
	1rjeEpPDJlVj05V9xgH2kF89atTp2KXKPZAqlpi6WkFVsaw6QQYr3EC4tjKgrcSJhJfsPiK9zL+
	OnareWgdDopmqzdXItxZcGGs3yJ9NXo2w8lhhzGnjJHHW28BoYXBd+qZTjWXYFVXPuYGEn+p32q
	Fp0/+AOAt4BgNnvHKKwI+pokRhKXlmedR8u7nTSBSCc4WtdW34YIFk4mRJ9YPDRdgKZ8JYoWudZ
	QzUTNLArpBFYH8TRs50q6RG9obwwh8t8T9/LNAWJaC7eZ/29PemQHC3pYXNJ0nvV82T5L6jqvsB
	Wpr74
X-Received: by 2002:a05:7022:68a0:b0:137:ef27:e297 with SMTP id
 a92af1059eb24-139724e2eaamr2051152c88.3.1781538154433; Mon, 15 Jun 2026
 08:42:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610083245.1057241-1-pavel.ondracka@gmail.com> <f0041fae-2703-480b-be9a-51a1df964a01@amd.com>
In-Reply-To: <f0041fae-2703-480b-be9a-51a1df964a01@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 15 Jun 2026 11:42:21 -0400
X-Gm-Features: AVVi8CfkqX2jHXjaMSoirH3Cv4qa5toEnvBVc9Ay0ocL4YvWUTf4hiVAjEFqETY
Message-ID: <CADnq5_MxrcO7GX+jGQbkuaF40QipnkxSq_+P1cbDmanO2K05uA@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: fix r100_copy_blit for large BOs
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Pavel_Ondra=C4=8Dka?= <pavel.ondracka@gmail.com>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	alexander.deucher@amd.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied.  Thanks!

On Wed, Jun 10, 2026 at 5:24=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 6/10/26 10:32, Pavel Ondra=C4=8Dka wrote:
> >
> > r100_copy_blit() copies BOs as 1024-pixel-wide ARGB8888 blits, so one
> > GPU page becomes one blit row. Large copies are split into chunks of at
> > most 8191 rows.
> >
> > The kernel register header names the packet coordinate dwords SRC_Y_X
> > and DST_Y_X. In the BITBLT_MULTI description in
> > R5xx_Acceleration_v1.5.pdf docs, these correspond to [SRC_X1 | SRC_Y1]
> > and [DST_X1 | DST_Y1], which are signed 13-bit coordinates in the
> > -8192..8191 range. The old code kept SRC/DST_PITCH_OFFSET at the BO bas=
e
> > and used SRC_Y_X/DST_Y_X as the chunk address, so large BO moves could
> > exceed that coordinate range.
> >
> > Compute per-chunk SRC/DST_PITCH_OFFSET bases and emit zero source and
> > destination coordinates. r100_copy_blit() already packs
> > SRC/DST_PITCH_OFFSET as pitch plus base offset, so large chunk addresse=
s
> > belong there rather than in the coordinate fields.
> >
> > This fixes Prison Architect corruption with 4096x4096 mipped textures
> > after they are evicted to GTT under memory pressure on RV530.
>
> Wow, impressive piece of work.
>
> > Closes: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/6716
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pavel Ondra=C4=8Dka <pavel.ondracka@gmail.com>
>
> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> Thanks a lot for digging into this,
> Christian.
>
> > ---
> >  drivers/gpu/drm/radeon/r100.c | 13 +++++++++----
> >  1 file changed, 9 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/radeon/r100.c b/drivers/gpu/drm/radeon/r10=
0.c
> > index 3ac1a79b6f13..533215d6e9cb 100644
> > --- a/drivers/gpu/drm/radeon/r100.c
> > +++ b/drivers/gpu/drm/radeon/r100.c
> > @@ -906,6 +906,7 @@ struct radeon_fence *r100_copy_blit(struct radeon_d=
evice *rdev,
> >  {
> >         struct radeon_ring *ring =3D &rdev->ring[RADEON_RING_TYPE_GFX_I=
NDEX];
> >         struct radeon_fence *fence;
> > +       uint64_t cur_src_offset, cur_dst_offset;
> >         uint32_t cur_pages;
> >         uint32_t stride_bytes =3D RADEON_GPU_PAGE_SIZE;
> >         uint32_t pitch;
> > @@ -934,6 +935,10 @@ struct radeon_fence *r100_copy_blit(struct radeon_=
device *rdev,
> >                         cur_pages =3D 8191;
> >                 }
> >                 num_gpu_pages -=3D cur_pages;
> > +               cur_src_offset =3D src_offset +
> > +                       (uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
> > +               cur_dst_offset =3D dst_offset +
> > +                       (uint64_t)num_gpu_pages * RADEON_GPU_PAGE_SIZE;
> >
> >                 /* pages are in Y direction - height
> >                    page width in X direction - width */
> > @@ -950,13 +955,13 @@ struct radeon_fence *r100_copy_blit(struct radeon=
_device *rdev,
> >                                   RADEON_DP_SRC_SOURCE_MEMORY |
> >                                   RADEON_GMC_CLR_CMP_CNTL_DIS |
> >                                   RADEON_GMC_WR_MSK_DIS);
> > -               radeon_ring_write(ring, (pitch << 22) | (src_offset >> =
10));
> > -               radeon_ring_write(ring, (pitch << 22) | (dst_offset >> =
10));
> > +               radeon_ring_write(ring, (pitch << 22) | (cur_src_offset=
 >> 10));
> > +               radeon_ring_write(ring, (pitch << 22) | (cur_dst_offset=
 >> 10));
> >                 radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
> >                 radeon_ring_write(ring, 0);
> >                 radeon_ring_write(ring, (0x1fff) | (0x1fff << 16));
> > -               radeon_ring_write(ring, num_gpu_pages);
> > -               radeon_ring_write(ring, num_gpu_pages);
> > +               radeon_ring_write(ring, 0);
> > +               radeon_ring_write(ring, 0);
> >                 radeon_ring_write(ring, cur_pages | (stride_pixels << 1=
6));
> >         }
> >         radeon_ring_write(ring, PACKET0(RADEON_DSTCACHE_CTLSTAT, 0));
> > --
> > 2.52.0
> >
>
