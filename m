Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4F7322DB7
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 20:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785617315; cv=pass; b=Yp4VPtzEFcX+FdwSMYf1njbphHHRy6TBgyyEquAko34WWn6Xh4N5HRFJQw4y1goB6+4JGMxvnWAc/X6i1pO4dTWEvd2O4Y875Rtn66IHXBQSGqi2dF4Minymt4vTG4i8UCH63uQuyq3xyfYlxSHyqZvwUXq9m6wmUYZHsIxA5Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785617315; c=relaxed/simple;
	bh=mBnkT6ThApqljIooYhlHy2KrG4XpgC9Us1AFdPaobNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFRF4xjNJ3CgwEnMwh8SiyQLBPi9q/ryY4hhcYkTqFzIrHmzGUpceSl0JziES/JW5goD4ETFwKPbsE41G4Rcp7adRminZQPI4sVcXVD4UwCi1gV5PoEY/pXvv/2iDQVdiSoBghgAppaYu+8qXw7BzIJbuq9hrE1pxYw0FLiMZn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B51Qao1Y; arc=pass smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B51Qao1Y"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso2865715e9.1
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 13:48:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785617312; cv=none;
        d=google.com; s=arc-20260327;
        b=b4lFbgvF2Kxvl/B/fm2bEjWyaiXZA0gxsPJQ+ELkYjbuylubxMbhQ9hRfsQzWwsl+y
         wHsPlNwvsuTNgPBLFi3nkk6T+6ALGwYR4Lp+/rMZFW5/jpLOkf0gkWj9u70Tx4c16dRx
         +ev6MB9fOYkRwMgWD1yhx9IKHSQbQKokHU2BMoVJbq84+Y3zkV6/ZXj/XPJQaTygv1Ng
         XgpPuMABmg3Lbdx86jXKRDuQfX1KKrz0Rfo6ewtOMrjPMao51W0JIFfN6m9KipbTSdGe
         N3jKRLkn7RZlTMWRAyNUiTftx3OKNdgIS5RdVG1PV5Nn6wH1Iyc5I6MXXyXGgfA0SQE6
         8VIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8C6J3xKw6R8FPOPnn4w954ZGYhiuE4HGYU/iy6pgEu8=;
        fh=vV4222IGNPjjDTwOivx+XJVnW9zmYnwuIgUwaRMj5+U=;
        b=b+gfV1G/B8FSeZAhyWD/bfofqMWS8cQevJ1P55qr+xxYDVa22FOCqbz8JWOcOD+HdQ
         Qgp2rAzNjpqhgHT+FDqryjkwjdLT8rHtHZHcwtRqqpQAr8TxzpwNkzeGMGEe254AsQSP
         v2d4rEwTNgswIySoDZCUg34/m8fw5EYNhMayYlCowYGFnKpoWykPudphZj3eRZgufrnm
         XPpmMn2vRZh6erI2l9bDJq1b0Ut8T15NOMafsVuGJZbMqTKgvmBa4Ae1EXVdxS40uzQk
         uh1HGG1B7UaNSqV+OIgUEg4FwPiwNef+zk6w7OzgRfrA0XRwFWu7GSoxSfTPD3vSBBwf
         r47Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785617312; x=1786222112; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8C6J3xKw6R8FPOPnn4w954ZGYhiuE4HGYU/iy6pgEu8=;
        b=B51Qao1YgKHjoy6NE3z60EXlzaoafaoZE6zBSCUCqr+2uohOr2Ad41H/zDiCemt7gO
         UJ9LmzMq4uUYePu6eJs3rbptnxkYZNB1xa1ONi2SkpgbFAqdGMphAUYEqZaV7+FHpQF5
         nNO3Ppk0o71Pj1penEcsWyvLIg7MgG3RdPj899aDxPXE4MnJwfx9KigXZGif6CUOCq3m
         bng85gZQPThfDRWSSDk5h6CyhaZTu5XJbhNU3rrem4045Siuint9V116qnrNd9Dz4VBs
         7W7MgoD42g0nh73iOjV1dEJgdymBz9XSmBlnbvPXP6YZFyy0TLsBk8Poi1+S7z2ijiUy
         8Ckw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785617312; x=1786222112;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8C6J3xKw6R8FPOPnn4w954ZGYhiuE4HGYU/iy6pgEu8=;
        b=p7IPoacqmg2RSF90p04x0tyM2i4mgKA1Uwbx9GJHr8dJaxOOptHzpmswOeYX1QNYeQ
         v8lrar/Lx91QZMXFOoCYyIpN82zj5u9jQeDotvkZKMDQG7WKS4RTYnq59ynGc1DFzuFj
         oQ5VYjlllyk70WTbBFIAZOnV5ziLDkS2TgeC0VEeqju6KppQ2ner0kEQ/ap5xe93v4z2
         OPlCpiyH4bOxMb90zAJRxAHbioXK0Sf9CH9mfdCi0EqxlE2lDp/7mk2CpFszjV4OROYO
         Jh2RUcm/Td2PF2aO0MTYfVVxSfQFgHGrAHBG7mxvDXzwmobt1ZOLYvcQxZZ77SQKZi5R
         Q/4A==
X-Forwarded-Encrypted: i=1; AHgh+Rpv0sGg/KUA+9Vy9owIwYBaRRoB3M+EWVlD+Y+2zceHfFW+5otl8FW6FLUoIgikXmbVSLPZZpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywo7Wb9sW3QTq3anqf2UAgvQq+R/IAHn4uj+1dQtWePH9Mr4WUh
	EEuicgmMuTHEPY14zWWWOhkKAdze2LNbVAWiVC81aIu9dsw32tTWlEW8Q8RYLMhPACXmynA/pbt
	8aBPMY7ltXXgb9AfhW+fhmssNphTEZeA=
X-Gm-Gg: AR+sD11fg+M7PwCdcsjgW8odP/mk5l4pPolk0KAuHvxqTkca6Yev6HR7qBAdszKeVIp
	TzOvBe0G20siSLg1RBydLRA82/L0bPIZajeTo1/aAJwKrMRFJfByqXfHNhDHSp61/e73GRryDj4
	pRQiDU9EG2AjNYqoTwR+u32zs25zQNsbXLSFMsQmbAiHyPF5qkPcHu0TAipJJPGGgvcg8J+LGYe
	3JYpJao2EJhVDRnF99m/H+d4Ei3DUiTKRYiWEEFVvWMPHZ3DaR23sb1at7XBpK7S68PL2tLMhsH
	UTirisNHDvo2yFM5tVdvALZOUbmM3+yBvbGucAgI79LSfy/QFBEg+05DQdXgZKnNM9KVRe1eUeW
	Er6h6lw773Y+V2tzPrdu1kd+eij+9Z78RJwIbSPCLS6RqexQRJGz0SFBSR17UnxdsnmvQGtZvZW
	OiLzdu74VHKAz0j2tN+b5b
X-Received: by 2002:a05:600c:4e8c:b0:492:3e69:a86f with SMTP id
 5b1f17b1804b1-4980c66c82dmr61216715e9.1.1785617312375; Sat, 01 Aug 2026
 13:48:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731003925.2728977-1-ebiggers@kernel.org> <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com>
 <20260801171549.GB3567@quark> <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>
 <DKDSGKU7WKI2.3UV1GEZW2VZWY@gmail.com> <20260801201830.GA9537@quark>
In-Reply-To: <20260801201830.GA9537@quark>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 1 Aug 2026 22:47:55 +0200
X-Gm-Features: AUfX_mzLIMowetDUO0vAuf8KJJkY3h7UzUQoep8RdQws3hVuyYMF4336u1MQHcg
Message-ID: <CAP01T74A0umBf_2hCuAygvUFBocjrDogxnu1_U+RkKBw8ictfw@mail.gmail.com>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Aug 2026 at 22:18, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Sat, Aug 01, 2026 at 07:38:08PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Sat Aug 1, 2026 at 7:35 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > > On Sat Aug 1, 2026 at 7:15 PM CEST, Eric Biggers wrote:
> > >> On Sat, Aug 01, 2026 at 06:52:45PM +0200, Kumar Kartikeya Dwivedi wrote:
> > >>> > Also correctly handle sizes over INT_MAX, which previously caused an
> > >>> > integer overflow and crash.  __bpf_dynptr_size() returns a u64.
> > >>> >
> > >>>
> > >>> I guess this occurs when using file dynptrs? Otherwise the size is capped to
> > >>> DYNPTR_SIZE_MASK.
> > >>
> > >> Yes, though it looks like __bpf_dynptr_data_rw() excludes file dynptrs.
> > >> So this particular issue might be unreachable.  Still seems like a good
> > >> idea to match the u64 type that __bpf_dynptr_size() returns though.
> > >>
> > >
> > > I don't see this in patchwork, so you might have to resend this with [PATCH
> > > bpf-next] subject again to trigger CI if you want this to go through bpf tree.
> > >
> >
> > Sorry, [PATCH bpf], rather.
>
> Sure I can do that.
>
> Would it be okay to also make this function return -EOVERFLOW if
> out_digest_sz is too small, similar to FS_IOC_MEASURE_VERITY, instead of
> silently truncating?  The silent truncation is a footgun.

Yeah, I think it makes sense. I will also ping Song to ack this on
Monday (or your new version).
Thanks

>
> - Eric
