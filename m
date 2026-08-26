Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02F738A29A
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787733517; cv=pass; b=F2OkHgsx+D2oz6KRR1SmBaORXPJ7i4XDqhqQvirr9E7CCmDBwsiT2LwbxLX3ml2hjihM+dkfL2A+zYJLCRKxStIajknOUDeP1ShBHe7pLDc7HyWB/gHjC3D6z0qErAFoyZY6uv2SDmFy7TUoUX0epp5oHa1R47iDaTCw5sWb7Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787733517; c=relaxed/simple;
	bh=24N/sCv8A+Sgxe2K/2t202PGrqGrIdKpHKk5dX/bzXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hhp1zK2i7ozpsOJ+vVVzbdTEbIDHsyztMIqP1+7O+raslSCpnOVd7zK9yZ+5i5wB74Fr2WgSiVtCSxDgcs8XUx4/bEfPl5HwkGrj3gVG+aJ0pEp4AINHCOmE5s1VXClvByHKvRgE8fTyI5j4geO9rBMFRev0v4GU+BPtmxHv61k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=nsjENCZD; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="nsjENCZD"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84f77cc7302so322040b3a.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:38:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787733515; cv=none;
        d=google.com; s=arc-20260327;
        b=arTGToThBusfYm2Vjwg9B5kn51JXrwXJ+AdZ3qrDUO6LsFibWYAvNYRIh2XJgceV8C
         6rbo07venj6Ma4PQ4Q6LASLrbHBHlItzFqJ3C2YNKbLDYEsjru+IQKEfYooM+1WRM/3g
         afDFG2UmU1QduyRowVZgqZY1qJVKo9rKM94Yn5Xyq/q3hb7XdS4drhlkQCGIOkWjRB6y
         pkWWWghNuU87UGkKoweawwDqxjHGDbQKkgYZe1I7GDg2S/do0Dz/9hVXBZOFzXkGG+4h
         dLqlJalYrcZLubxu0gu956wIf2VsVf/xKGjdeHEMJLCfapJa1YeR3M/l6zsXVxNfSkqb
         6Khw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+bJ8eYMIUXouSj69aCBQazvq1wAkww2CJKOy9ZLrqcg=;
        fh=NK43JWQEaAch+H/M/VLiIPnCGO+BhP9BbnYL6dvcg9Y=;
        b=V+ho6EX+7O39FZXmUdybVqnoP++WB8RopQBZKD7VQPfoaUSaPTXn3Owyy0mPXD4UPG
         x3/1dU0Pe7JHN+tpW5RqgIN7mOcn/+mJmwyhudrR755e5E9jyrC9B/UkBYUYrWhocK4+
         MWiqPsVB7t+9H1HqgQu7om75+t3UQH6JuDmPm5p4CYDAIf5St3Ejf9AxtNxfurC5CiRx
         zOtFhUVjkKTzCYmIhkHWlU9g8COkSqmukOa3uHYxNZYQZFYrU5emyaIdGd8xUjFS36BJ
         HcLW7DzPPKtzA5Zni/ExmBZ8ddXod9MX+N2xS/MiV3adfoL2Mir+yuPi8ZhqEbGwwAFZ
         EJdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787733515; x=1788338315; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+bJ8eYMIUXouSj69aCBQazvq1wAkww2CJKOy9ZLrqcg=;
        b=nsjENCZDYR/TAHYIhuVBk16PrdxzOYcQyPmUC2BrCY2pvfzguBlRGJZsSU1QnZ3SbO
         BcN1wjjslkavHnHM049vDPxwDwOLsd7AnxYMHt6etWY76QrBRe7L5pkFmO5kKWtKtvgS
         nUe5wA378RFMGzXiwPW6GyNWoS1I256u5ucPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787733515; x=1788338315;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+bJ8eYMIUXouSj69aCBQazvq1wAkww2CJKOy9ZLrqcg=;
        b=TarI9KRak40XT3qtA5K0YdNkN88/7W2VFspVc6tILUjg0IuvOaaDCsA33rc3GNBq21
         hf/zJSeoBqVwYhe2ZLAvK15P5GuOIF9DPaB0d+uMNALg0IAzQYLoSUTtFM5pO9eY4Jxb
         JCI/B1ykxjU7I6K7j/TwAd3iHNeTpx8lYjxqqcF5xF2UGG2yrhZX8kfVktbHkTi2IHRH
         Dw2JaFWf9V/93VRcJ+qBF+dIw1CLVQexgjQMU57BXGdyRMFTavgf7V8RZ3I5mmu7S6IJ
         7/FuYGKme6z5sIsJA5N+zARdpEjUrVxkkbGM0IRipYQDWtpNRth3aS9xwhabuyqOv2Dy
         SM5g==
X-Forwarded-Encrypted: i=1; AHgh+Rq9KLGp0e4jZqDx8oOQOUmft+K5LiFiSbA8LuWG7a8bSVfgbFKYHeUHcXlPD7YfwDEh23dF0Hc=@vger.kernel.org
X-Gm-Message-State: AFuF++l+hHPuh84PoD/3bYUAROfqtZbbW4PYdQFAjLKC0cCyTHy2EyD2
	GPyMQZjqPDb9ZVuOz8be926U8RuM+hUnxep9WHiDDRThMCjQGEJyy1ElVQT/O0kZCHfuoFmDnLz
	3lm0axWJXelUzaG2NKvAZ4Beg/nM3Fge3lzVvv+FI
X-Gm-Gg: AR+sD10YrXCGcBRdr7WUSis21lbCdcoUk/x+hRhyppwAeWq11WopKq3NW71s/RPe/WZ
	oZAAT3pYhoLBDsp227ca6KLOxkuojXOC1ZyF0exlwcEavN8gKuxaEf2VRImQilgiquNbSJx/IAN
	iJFi5Ur0sdBBDVwazMs4j+866AXCuI8jNBktDnXHnTI0zaysK9fLcgHdTv/bFpEX4pnBALg3Yt5
	qjKcu2UjjxEvv42RpMGsJybBjUTDLNC5S7AoMdxXdJKCEWrLqy53E62n7bD/soPsNRR7AjzYZ8S
	d7mk5cMK4BBIOpn20IRRNb4X0v+sDnbUmbEiTT1DCqTysQ==
X-Received: by 2002:a05:6a00:1bc8:b0:845:31a6:d84d with SMTP id
 d2e1a72fcca58-85372b9f5a4mr8970724b3a.7.1787733515122; Wed, 26 Aug 2026
 01:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826025123.62758-1-ljp1205831794@gmail.com>
In-Reply-To: <20260826025123.62758-1-ljp1205831794@gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 26 Aug 2026 04:38:22 -0400
X-Gm-Features: AcwNN1U5MQQ-Foz8JLEN1r_JLP27SIQF7hWiHU5_TAQqV-_hBURXNm5Fcz97j1k
Message-ID: <CAM0EoMnuw6C0MWvBiZTNYpQfr4hWccqUjocC-acBCC7h4h5e_g@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: cls_flower: validate mask pointer after nla_next()
To: Aohan Mei <ljp1205831794@gmail.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Cong Wang <cong.wang@bytedance.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Aohan Mei <henrymei@tencent.com>, TencentOS Corvus AI <corvus@tencent.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:51=E2=80=AFPM Aohan Mei <ljp1205831794@gmail.com=
> wrote:
>
> From: Aohan Mei <henrymei@tencent.com>
>
> fl_set_enc_opt() iterates the key's nested tunnel-option attributes
> with nla_for_each_attr() while advancing a single mask pointer via
> nla_next() at the bottom of each loop, so the mask cursor is driven
> by the number of key attributes rather than by the mask's own
> attributes.  The nla_ok() added by commit c96adff956191 ("cls_flower:
> call nla_ok() before nla_next()") only validates the mask pointer
> that was just consumed; the pointer produced by nla_next() is used by
> the next iteration (fl_set_geneve_opt() and siblings) without any
> validation.
>
> The mask's nested attributes are validated with NL_VALIDATE_LIBERAL,
> which merely warns on trailing bytes that do not form a complete
> attribute.  A mask carrying one valid attribute plus 1-3 residue
> bytes (or a non-aligned attribute length making msk_depth negative)
> therefore reaches the next iteration with msk_depth !=3D 0, so neither
> the !msk_depth check in fl_set_enc_opt() nor the !depth check in the
> per-type helpers fires.  nla_type() then reads past the mask payload
> and nla_parse_nested_deprecated() iterates with an nla_len taken
> from those bytes, reading well beyond the mask attribute (KASAN:
> slab-out-of-bounds read in __nla_validate_parse from fl_change()).
>
> Validate the advanced mask pointer as well: when the mask is not
> legitimately exhausted (msk_depth !=3D 0) and the new pointer fails
> nla_ok(), reject the filter with -EINVAL.  An exactly exhausted mask
> still skips the check, preserving exact-match behaviour for the
> remaining key attributes.
>

Hi,
In the future, can you please send a reproducer, such as a simple tdc
test. We test all tc patches.
I think you can easily add a TDC test for this specific patch and it
may even be worth resending to have the tdc test included.
If the reproducer is sensitive, don't cc the liists but send it to maintain=
ers,

The patch looks sane. I was going to suggest using strict mode but
noticed the fixes commit states it intetionaly avoided strict mode
with claim it will break uapi.
One nit: the commit message says "call nla_ok() before nla_next()" in
the Fixes:  but noting that that commit moved nla_next() to the loop
bottom and added the pre-consumption nla_ok(), but the
post-advancement pointer was left unchecked. Your description is
accurate; just double check if you got the right Fixes..

cheers,
jamal
> Fixes: c96adff95619 ("cls_flower: call nla_ok() before nla_next()")
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Cc: stable@vger.kernel.org
> Assisted-by: CodeBuddy:Kimi-K3
> Signed-off-by: Aohan Mei <henrymei@tencent.com>
> ---
>  net/sched/cls_flower.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/sched/cls_flower.c b/net/sched/cls_flower.c
> index 0e275b58151c..1cefea571efd 100644
> --- a/net/sched/cls_flower.c
> +++ b/net/sched/cls_flower.c
> @@ -1703,6 +1703,11 @@ static int fl_set_enc_opt(struct nlattr **tb, stru=
ct fl_flow_key *key,
>                         return -EINVAL;
>                 }
>                 nla_opt_msk =3D nla_next(nla_opt_msk, &msk_depth);
> +
> +               if (msk_depth && !nla_ok(nla_opt_msk, msk_depth)) {
> +                       NL_SET_ERR_MSG(extack, "A mask attribute is inval=
id");
> +                       return -EINVAL;
> +               }
>         }
>
>         return 0;
> --
> 2.43.7
>
