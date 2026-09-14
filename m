Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3921233929
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 02:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352192; cv=pass; b=hFt2yFFxwqTcSNewC7H3L7t4EENeqEFVoEFcZyG8uR1PUFNKXqrAi0q06oHMnoUx+LRamq4NTz4Cdjt97qGOzSMwNc3RMxgaLTkatiPU7ryKNYAVqUTEwCSbSaMApXsJxJ5vTaqZfrM8XMje+33CKpwdOb6FEM9+kfIpxoUF+XY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352192; c=relaxed/simple;
	bh=5MdLv94iEPVs3xiNujxsMPtCysxyX09G4pIUwr0YlK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJUkjrgBUyG56s7nrIBjXVG/aBY4ZxeEL6Co2213AqchuUsT/2jbeVUIOBA0FaNRXoTshSsEt9x/3TEaoC6//RX/w9sGSeMN/xeOVihpTVgElSafik91AGgcNfIBEtZRd4p22jNqCUy+cILucbt0rewUF9wrmb3VeoMLa0kuXGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbvJYfyg; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbvJYfyg"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b7aso1759778e87.3
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 19:16:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789352189; cv=none;
        d=google.com; s=arc-20260327;
        b=MpQ6FeC9F42iCqOjmWyerYnBvfhY93kPBDfI7kXbXinr8+64E9egy6m8vSS8uIt6P+
         s4YD8EZ5JdW4MTE+J3YkXqgLkUcn37KOllrkiFfBHxgiyjDyHIYN/UhY8gbzlPLnARI0
         iHF1/HnO4TURyvLuaiTKRw3baQzTf06niCKEl6WMcE8Dv2WGyunVfS22Kh8e3vbFEAOh
         YovFzL98x40HzyKpJ0rlDc7kh6PUodnZAAiDWtxuBASJaM9GsNZVEq5pbdzn8ayKs1cW
         ATSD4DKOTVDwmHgDDy2zh+VANvtN+I7Edq3UlMnv5rnUvmZ5mLZtNYpAIuap1G4JRjra
         yyBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5yXzplmWjCBukJ3GrFEzSXQyy+tsHQh5scTlYkCUf/A=;
        fh=5rh9Oza/wOrI/MCENGas8lvirIqdjIVyOe6ay/RUisM=;
        b=RaQbIYRG+Teze4P4ajslAZHvDxC9awSRhqpsNWn4lxwGniXeW2VJrq/arG0048Z5A9
         lirxIwAp+YHGQYahfLQRWIDjnGMToFp+x4mxMRyUQP280h7UkljP6SuQ3Id8nJZvR2Oi
         v2xGzb+NqdXHVgQY5/siWGnGJHn9FVcXgKjqHnGZDybC/jDFGj7Zi4PJRwwGrTrG/+RE
         WVEZQX2/MAU+CsLw3FdAsd2vF5j+bvJzkZxc12JuHbEE5dEjJb1CLASDmjE+7QdC9YYu
         7GjOyf8fkt1q7Tem3Hg6NJz8bWd6hajSjBQuTfaWWe8F8os6OtAAqY3tB0vWUwXZQAsT
         xJig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789352189; x=1789956989; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5yXzplmWjCBukJ3GrFEzSXQyy+tsHQh5scTlYkCUf/A=;
        b=LbvJYfygCVwanjcOyH52EYjzdBnPtGqB7Y6pO0L4M2h8Dqcyg1sjGY/jJ25btxKu8G
         iTcHlAUBVf5vgzUmWWWJ39GdiD8gzCQtN/lqGzbxAbMZdrI71C5gKQYpITDE7/zJxJNz
         pCri4r4kE4O+2o2HfXUjFrjzgbWe6jCBMad3glirK2JFhvBSSECxMa4/2s56kSBhID14
         oN19JBiaxCF4g/v9HFBQwG/QW7xDnwRPMbui3HtpbsfZBGovxQlC+Tvvh/3HpceWyJZN
         Kq4q2SxyoiL9Aytxh46wyn72F88M0ZUxfc2dq1WViNIzvZfw8vxpce8rmryjxqDs78+D
         HZyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789352189; x=1789956989;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5yXzplmWjCBukJ3GrFEzSXQyy+tsHQh5scTlYkCUf/A=;
        b=ecWUDPeDFPcP5xXhhTc0AfdcfwaH1Cw2U9Axu42zMhctdRpjBabVzYIHLI0aP4MD6U
         k5IhCmkD+h9PoLa5mNPKF1fbkj7+J/6xO97SYywZIjSPn+fcOEAdPUGuJ3hYXlqa+Ti1
         g6YygbH4v0ivY/RltEvy7jTHVFjQ4XVWwEqO/6IoqWiNWBTRQmYeoCFEmbCRSL0JL1Au
         CU6SCsmmkVpJ3ahnGfnIl+5v+pAUPmmdcdMRf0fFAIiidizoi+fJYiAXoa1r5zDG9JFd
         89JZZAmJ64hvs5ND8AB5paXKBeelO+EhrTxsEyX4N3Gh63+mVDDBx/k/iJ7AacZY+Wby
         9UmA==
X-Forwarded-Encrypted: i=1; AKwUvBwgpIw0aZDxbJ+LoLYqhZ+/E0cJL0W1AlWuux5iIXUs/VFofS96ywTr97FsgJC9Tsudcu502Ag=@vger.kernel.org
X-Gm-Message-State: AFuF++mWa+m0dthjclJxoRrfWO29CLpr4ynOjQCHRsqEBLHSxUWPixnx
	1wxhXfCY1C2tarD87KN+8wiILYC1M/iA/WfF797Bi6XUGuJpEl7RmsmsCBy7v8Ij+PLlDiegM8V
	kiAzqb2KZclPjscasiTRpI+zQPxWVXGo=
X-Gm-Gg: AYBFou2IaTBjeB2rJzwshY2Fi+cysPNRMqcjALysGdvQ3YQpBprfK+9/gQmk330BM8n
	xCtkse6ORK252i9Mqf9l3wVcZgadxUzKvHyytCOVii6BMdChqordklOtCweuLTf6tdBjoihc1in
	ybnUA6KXOGmHlslj1ZHD+IQaNT5XsOsGeY/Y1IKwzSyJiHKp3kjk/GvMfOJdIfxajiMW86qIM5a
	xKPzJhEZJkduad0nkINN8MELpAu+ULhsvXdpzzFcFaGhdgAdK1U1r5z8+KtLKxuOkRnHQvGQX3+
	1ymYT1YV9z570Ht/b8Rhg7GwncFgDsw5YcHJROtHujQXnB+nPOgfMcpzDeGvqpkZhILmfXRqdgo
	0J4lOUKjKcFoTAISGtyC9bo6k
X-Received: by 2002:a05:6512:124c:b0:5b5:e092:c3ee with SMTP id
 2adb3069b0e04-5b8ae67d26cmr161163e87.1.1789352188506; Sun, 13 Sep 2026
 19:16:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com> <20260913190707.413136686f78887287764f0a@linux-foundation.org>
In-Reply-To: <20260913190707.413136686f78887287764f0a@linux-foundation.org>
From: Matt Turner <mattst88@gmail.com>
Date: Sun, 13 Sep 2026 22:16:16 -0400
X-Gm-Features: AcwNN1Xf8e1ajVkMm3ueVyiMktER8R-UYl1cGQHz_MkdxJ2eIL-j1FsuK6s3yJY
Message-ID: <CAEdQ38HY2wYptnqo_yF=GX9PsY7akUVB2z64HbErATOF=R5vKg@mail.gmail.com>
Subject: Re: [PATCH] lib/decompress_bunzip2: fix off-by-one in run-length
 bounds check
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alain Knaff <alain@knaff.lu>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:07=E2=80=AFPM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Sat, 12 Sep 2026 14:17:35 -0400 Matt Turner <mattst88@gmail.com> wrote=
:
>
> > The run-length path rejects a block when dbufCount+t equals dbufSize,
> > but the loop that follows writes exactly t bytes starting at dbufCount,
> > so a block that fills the buffer exactly is legal. bzip2 allows it too:
> > its decompressor bounds a block at 100000 * blockSize100k and checks
> > that limit per byte appended. Use > instead of >=3D.
> >
> > bzip2's encoder stops filling a block 19 bytes early, so nothing it
> > produces ever reaches the limit and the bug stays hidden. Compressors
> > that use the full block size do reach it: an lbzip2 -9 image whose bloc=
k
> > ends on a run fails to decode, and a self-extracting kernel built that
> > way does not boot.
> >
> > This code came from busybox, which fixed the same line in 2013 in commi=
t
> > 932e233a491b ("bunzip2: fix off-by-one check").
>
> Thanks.
>
> > Fixes: bc22c17e12c1 ("bzip2/lzma: library support for gzip, bzip2 and l=
zma decompression")
> > Cc: stable@vger.kernel.org
>
> Why is a backport proposed?  Hopefully because downstream users need
> this change, but the changelog doesn't tell anyone the reasons why.

I ran into this because my system uses lbzip2 as /bin/bzip2 -- a
common thing on Gentoo I believe. As far as I can tell, anyone using
lbzip2 as their system bzip2 would run into this and it's only because
it's very uncommon these days to compress a kernel with bzip2 that no
one has noticed. I only noticed because I was adding support for
various compression formats on alpha.

No strong preference for a backport from me. Just thought it would be desir=
able.
