Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780D943CEF8
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 23:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788390484; cv=pass; b=dbVB9283FBHAYTlNGo0Rs7Fz92twJ63c3ovlXBBhIIW759vqtHbZRLRrW7ULnvUlgC35a5l9g7VGlhGapSDx65JN9HBxHcdN8s13NsiV9EnQ//g3eD+lOsSJrsKd6CNYl1BTeDbyRxQssV327uO74AItqhKzwgndIcILPGuwXoE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788390484; c=relaxed/simple;
	bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2ZzyPQR44WhaRkOLmjBhuhY+7YEirqbQEa+QNpPMCHSDBi2K32nS5MBRzAfIOKoBZGhVVf88Pkkh4QB5IZv3s8dNni5rAbSw/OlUNypb9LoYHcw0Khmm1KwwF0VIj10z7lVE2C4/u9YFNDA6Odg0jcEBdz6uRlAVLKCkuECEmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co; spf=pass smtp.mailfrom=x6u.co; dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b=0oF+7oTZ; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=x6u.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=x6u.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=x6u.co header.i=@x6u.co header.b="0oF+7oTZ"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1385825a12.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 16:08:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788390481; cv=none;
        d=google.com; s=arc-20260327;
        b=Ai+R9NRRcjxtCY/2CX8ol/h9vVBVz4HgQtUyaS6Mav6IEGcgAjIaWj3Tkdn1pKtUXL
         vf0+9qTlK/VV8eUgXlvHGko01KfpUY3jRC7vLbz+Bh21ZdP4++cLREfs4TFd98Vmc2GJ
         mzQLIHKjFKJEMWXP4E++gbWPu7yLLt/UAesvVTsyH46bUWwozDPdjy/2Qf43//lqstH3
         s3NQpnq5QQcjWW6F4iOi8BdwCZQ2zWRHcG98vYh8PaRk/vjBv/ppEohszI0JOWS4e+Xk
         vah0/qq5YZYjUElXhsJgp/1edm+x147NxZ2QyXDXaLJzUQOKIOF5y76g7ii2p/k1O6Ns
         pSbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
        fh=wyXAdeDisnNstLNAqfDyj9Xti7Buy6eYB251NzUW/pU=;
        b=r3BYcA28A3TgWpADcZAw8xNeAxwFShQR5KN8k+5RgelbG+9yGJEYjzZg8vuG15RdPF
         sQeJU55Gl6UN7ozKhuw5ICs+dungNZ6pR/2Fax/BLALXxk74C+sBfOj4aGWUTiFXKjwB
         Ws8JPfD/TxlATaWKxlHUhFjYM0rABmEWygv7k+/p226+si0fT9gnURP2xYmj768GZvtR
         z8e2ZuoUqp7wbS2pwp+sQ+Ne3IVa2gBWDtTMsRJbVf+K+XEGHSI8OQmWMsWwa49TOxpH
         v/ZSmgB9lMjl9e7XUhGre4KbAAat11K2xnha1emSQF4gYxEUQittZLEs9+PybKGNbQa8
         V/rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=x6u.co; s=google; t=1788390481; x=1788995281; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
        b=0oF+7oTZDJCEPJ5GxamqvPfAO34tnu0De+/xzfpPjLEoV6fqiQbBTDJNvklTqryXWz
         4DUGZ9M4It8Hr5MLPcfGlofAv1uxt7W12KHGRuAl8wX8Pa5EEEaUv4VA9tavpBLeRXu7
         LtueW1Jc617D0bc/p3XpQ0vSzEMTdXTT47OXuFFCgW1NoE4ATKQ0a2SaDx+stXMr9eJ1
         gjtJXnpxVMUpjpuMxNteucXPuTjm37hzv62t/R54a+27K3WUxPFCURihaU+/mdUDKhAa
         mRSr2owqyc4kWFBIBsgITWUTY+xT50RAWK2lezkbAUho6oUKm+nul+xFZGTQVQ4yA/C5
         375g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788390481; x=1788995281;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qTbmbR4TV31oKppyK1FzJBEXPWjFHR9x5HM244L3neo=;
        b=P455X0SAgm6FOw2UqyDxbct0XOSyJM5Kr5dMVpIXpL8K8X3Tnl/zP8EqFnWc9ZfvOY
         CaqDwUWyg7lMRtYEdGSv+6yrlqdqKZfEzZksX/R3S6Mold2+QXuJC0QvnJxwGLY7MUfz
         7/CCA1RDL2bYjxB6py7wqguiJbWgJ/Mr+/mTTrRIIp0/cAjWbo9nAkIcFLrwy+E4y+Z6
         d4rVqGB//d4Mjw16j9fWPHlH+eIu96TtEJ2vGzOiQZXdMk139ztuNqyhU3+gI7pQDwPe
         TvhZixgZ4y9QvdfgH2oFuGL1lLWT3kt/G79k/aCVMrpMena/fPaC6rqqcI0IKfRLoEvG
         l21A==
X-Forwarded-Encrypted: i=1; AKwUvBwZe2uvtWRj5jUMSeWOb98bciiKwfq0njxZFX9zv+4i6KyLNvINbhvCnf1eFB3eby4NS9nkU/g=@vger.kernel.org
X-Gm-Message-State: AFuF++kt6hEAzx6vp9l4kXAZ7VmAnSrOQmpdPTo1/yRjDWNeGB+NYLO9
	lY0y1FQffmFS3QUi+UfXWiHP3jf8KriIypzEQ2SVImOqmlMxKxcNDQhUIBSdgBHVmmXRW0K7G0+
	sUIyNIclMnIyF8qQNlDGbRnXcs5HsDTmWd8eZP/M8/ug=
X-Gm-Gg: AYBFou22rniCczVeM4sGfrc/ITNCzzr33eg/mVeTQWqdYgHdDaWFML48qXTpPKWjgmp
	3+Mrz68Ea6cjXeylaZtQKPf9iB3Q8jlgYa4uDNM9RKx6hYQxMEOPqIPTvBDdAsKJ/2EHCovVa1u
	gOVXLgKGIujD0xVnfiK7D3IRVpzqBOme/K4qnmFs/oJ0sayN51TpEcYWf8vFNoDNKszTYFlW61E
	cdukALyYZTlqyeAyWPh4HoyIqvHg39pS5gz521/Z90SP9HxxoVAJA3qftSOPydoEXzvSFU08oRD
	E1ZnNbentrjKnmYKIvmIFt0af3de4/Xb7nzsLeVeU49DMuML9kLQTbBhDzMegKrfjqN+1RkdAQ=
	=
X-Received: by 2002:a17:90b:3e8d:b0:396:4cbf:45bc with SMTP id
 98e67ed59e1d1-39aee153e79mr9644253a91.16.1788390481503; Wed, 02 Sep 2026
 16:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901170849.4052816-1-dhu@x6u.co> <20260901170849.4052816-3-dhu@x6u.co>
 <20260902120832.GB2890729@ziepe.ca>
In-Reply-To: <20260902120832.GB2890729@ziepe.ca>
From: David Hu <dhu@x6u.co>
Date: Wed, 2 Sep 2026 19:07:50 -0400
X-Gm-Features: AcwNN1UWr9DtGOkBk_AsJGV3X93dnPOEvrR1ndZaMb2yMaRxX36LCdah5a513PI
Message-ID: <CABdL-LTO5OKkDmtXpiLury=2n6q6Rcm42_qqz8U+JkEu=v886Q@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] dma-buf: Split sgl by largest page-aligned chunk
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: sumit.semwal@linaro.org, christian.koenig@amd.com, alex@shazbot.org, 
	ankita@nvidia.com, chriscli@google.com, david.laight.linux@gmail.com, 
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, jmoroni@google.com, 
	kevin.tian@intel.com, kpberry@google.com, leon@kernel.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, nicolinc@nvidia.com, praan@google.com, 
	sashiko-bot@kernel.org, stable@vger.kernel.org, viursachi@google.com, 
	xuehaohu@google.com, Leon Romanovsky <leonro@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 8:08=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Tue, Sep 01, 2026 at 05:08:49PM +0000, David Hu wrote:
> > From: David Hu <xuehaohu@google.com>
> >
> > Currently, `fill_sg_entry()` splits the scatterlist using `UINT_MAX`.
> > This creates a non-page-aligned DMA length (`0xFFFFFFFF`) for the
> > first entry, resulting in non-page-aligned DMA addresses for all
> > subsequent entries.
>
> This patch is fine, but pedenatically a scatterlist's entry limit
> should be bounded to dma_get_max_seg_size(), though I don't think it
> helps this. Operating scatterlists at the size limits has proven
> problematic in a number of places already...
>
> > In addition, a non-page-aligned sgl length will trigger an edge case
> > in `ib_umem_find_best_pgsz()`. In case of a discontinuity in later
> > buffers, we will have a `va` with lowest bit set to 1. That will lead
> > to `ib_umem_find_best_pgsz()` always return 0, and break the promise
> > to find best page size for the mapping on the NIC side.
>
> That's an IB side bug, the newer logic that joins adjacent SGLs should
> have avoided it?

Hi Jason,

Thank you for the review. I think you are right on both counts.
Regarding the IB side, the new SGL joining logic in
`ib_umem_find_best_pgsz()` indeed avoids the issue. `mask |=3D va` is
skipped for artifically split, contiguous SGLs. Since Christian has
already pulled v8 into drm-misc-next, I won't spin a v9 to avoid
creating unnecessary noise on the list. If you prefer a followup,
please let me know.

Thanks again for catching the IB logic detail!

Regards,
David
