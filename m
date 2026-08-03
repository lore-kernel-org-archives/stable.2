Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49345296BCD
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785763637; cv=pass; b=g3+kLTy8s9cD0P+VqRSR39RDh02R/PInucYmWvpbAobo0KkzAnQolP5K9ekHWh/QuiL0NY8uW364CIOF5LxrhoPZcixSr7I0E2zXuw1UWl1yv8W6oP9P+tkb/8P3onYf79X+9wd+RDDk9lD9RSNoiByzhFsnotAqsUGLi2HizgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785763637; c=relaxed/simple;
	bh=yRrugMgHsI3Ysmdks08s4fspaHF4RT6LYJk7+ND9R8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCLciREHIYIQjdpIKysirXHMV/zwYBCJYnkHc6m0dZKjRmsXcAuJNTpm6zOr9CBYejFSfBgJdcri+WPC4V6BhymmqMfz9GA4dS9BWf34ThvjX5a4P90CyOxOE6s7uvK9zJviVy45RSI0dA8NORy/MUMVVOopMH/Ppr5F5PsK3dE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com; spf=pass smtp.mailfrom=omnibond.com; dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b=vFiREQ53; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omnibond.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20251104.gappssmtp.com header.i=@omnibond-com.20251104.gappssmtp.com header.b="vFiREQ53"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d004f135b1so33302885ad.3
        for <stable@vger.kernel.org>; Mon, 03 Aug 2026 06:27:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785763633; cv=none;
        d=google.com; s=arc-20260327;
        b=V945BNnawn8M1YL0OZ2lUfxWFGw28wGht4Y0CJ47DVyCXg/ZuH3mxgxOnTj5r79LKF
         Ks4caQUFzRL2FMgQNgXlmuVMqIv8zuI0LN57OEqs5JG7jbG6l/4jMt/pSoFtgV6sCWNj
         LiqADfbASxN47/gQtv411dWxTOST0Xia4czSK/peM48pT3TBiwRXqtNeDPnN75upBxtO
         pzphpJzcTlXeniFqRbia9TMdh2WHTjnkba5HREqRDdXcHm0vVhsuyYNOjegJ+ziFJPcC
         lkM/OIYDURy1VzrPsntRTXUUnPwlBGP952XYY0FlTvaGa/ObTnWwQtA49skbIrzan+nl
         lF5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vzzvwGFv7hudEdfVpg1GojOUNvmywL4TKUt2c+w9br0=;
        fh=2ip4/ZBaxp6KlGf0oUoe/TK2znFDD+g4Wa4v+36NFrk=;
        b=ZPq21YikwWAwwY55C7Qk16UMz3s8RnCbGeZOivD8HsiWS9auWsSq6hQnoF0n5BjF7Y
         6w/YkM5NZslFSMZkYVsKbDNuVqqu0B90gBYGNYnmv4NaQD5b5t7vCUN6qIDnW1P9Xnng
         eBnVQK89yJZh35LAvh+U+S7iI7keoXAzwgG/0w+Wn4jaLE9JQdl0dZkCDfq8ncu1yBBU
         02uacw68GUNcsqj0tUYakwwqhz3+/L7XlWmETaFv/3n039McCpy5PYGrwP0F/FY4ujiI
         BlVQZlRRraAd//MMA8wZxDpCj5SaHTkLGnuLeD72yL0hc5iMAZ0FPe7CP1nUFlshED9Y
         DLxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20251104.gappssmtp.com; s=20251104; t=1785763633; x=1786368433; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vzzvwGFv7hudEdfVpg1GojOUNvmywL4TKUt2c+w9br0=;
        b=vFiREQ53TE9WmqWqluHRR/v9Rw+MwLkVwCrm7D9aOTer4SQMYH5UNmT1X3CizjnOAU
         AJ4s60TD7F6wEiO+5+5XNAlaM8jxbEXSMiWemdwtynO5igfFC2vFSrYUfuSS/2ou1zTO
         0fO9JAGo/t2FIUEuhyZDpa5GFgwHz2hZYbasckobrgYmh2xxZDlAmRdAY7T8AxxGHwTP
         ugHU8SOdQsAsfbtwlPzPzr91r/D2kTxmr1eHAuLR8Zw65YYsgtUuo7yXILkHGwUabjx1
         /sl0x5tlL2amNOcE3iis9n0Ok/pfIjnGGgsUkqxkf7OF14nBSoVambDrYg6gGZ2Ccy6Y
         TddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785763633; x=1786368433;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vzzvwGFv7hudEdfVpg1GojOUNvmywL4TKUt2c+w9br0=;
        b=sJNVy6gRJnpun2ESUvyLOAMMF3+gMiZn4UASC9SxbzPwoh7rSZ7j0ZCkeAGsdc9KSQ
         SCH59/Q3hTKfXbX0jvNSHmaUlB96jaBaC4OebZxJchrDVC965iy5imd79sVbMTtucVFJ
         akatV9slF8t82v2pLfs4dMwwocvNT4PNDAg5wCzJ0xfJ3G9iwdBjV3nYwKo2s/4hE66G
         jHAqqMaf2y1yeUHbVxCFiA6kBXT/vzRfmCIjZXbksX0qKakFLhsJ1M6mCYfvcmgBcJXt
         etiVPCPZC6FVvVzOo3h/M8ohJoxB1JVGSuuXn1VcA9aDcsrigvAVdMbMcUpVtLNJh7HQ
         Sa7g==
X-Forwarded-Encrypted: i=1; AHgh+Rr76jlc92f/l6UHwM3F0JYSeGVqpNvrTDE5Q6rG68KmcWwwhZKOKEom+fHdzL7bI/x+og6e9Xc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF8ndtKjy41ZdUWOfQ1AQrvW6OxOXCMNTHuLaYU1biHQWgJAHs
	5QL6m1Ox7dwij3WFceoqvrCg9zCzYbxu9d46PPYw9CwZ9cpAITvLaq8M2sI+po2jfBMKT3eg+KE
	+u1NlPiOmgvduS6VIbcGwtDLHMaXnnEuiy0uQ+gvL
X-Gm-Gg: AR+sD12kHB/k+d1lbD/z1YyXY8F0J1fBOh3MTrDdedHQsSgggxgwN8h4NNps/+t7V9L
	GiHpzFezIwDLbByDN3cdJKyv/bpFs422pFNS2Zg7sskOG8l/7WguP+uwOuXXTu60TaveMkD6ABx
	esAeAeJD34RXtPldKsvndq04LmvmkEv6jtW3Ri6T/pxmjgfygPX0ce58sWYQjarw+/KeYRHM5sq
	xwzNGvpgBZFaAS6na9cbOD9qh/AoJPd0jr2GDFqLQknPWMlVoYdJx8fNYY8Kbtk/Kd8EnR5P8tQ
	7OqBDQCoTWZw1csjb5JTsD7m8uhlTWL2NG1UrmzkKA/U+hJRH8eOMSOQ
X-Received: by 2002:a17:903:1b46:b0:2c7:f4bd:91b5 with SMTP id
 d9443c01a7336-2d052088a93mr87479995ad.0.1785763633017; Mon, 03 Aug 2026
 06:27:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803010802.2415942-1-gyf161023@gmail.com>
In-Reply-To: <20260803010802.2415942-1-gyf161023@gmail.com>
From: Mike Marshall <hubcap@omnibond.com>
Date: Mon, 3 Aug 2026 09:27:01 -0400
X-Gm-Features: AUfX_myZUl6YDyRNTNVNZ8rld0EwyjS2SVtXFEG_J0QgV2WgUPu5vr0-rOZHdHw
Message-ID: <CAOg9mSRcniPqCcOP6nERXaADzRtAToMS_YVt7c8WgLiKuJ95NQ@mail.gmail.com>
Subject: Re: [PATCH] orangefs: fix double-free of trailer_buf on readdir copy failure
To: Yifei Gao <gyf161023@gmail.com>
Cc: devel@lists.orangefs.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Mike Marshall <hubcap@omnibond.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks! I'll add that to my linux-next...

-Mike

On Sun, Aug 2, 2026 at 9:08=E2=80=AFPM Yifei Gao <gyf161023@gmail.com> wrot=
e:
>
> On a readdir downcall, orangefs_devreq_write_iter() frees
> op->downcall.trailer_buf with vfree() when copy_from_iter_full() fails,
> but does not clear the pointer before goto Efault. The waiter in
> do_readdir() is then woken with a negative status and frees the same
> pointer again on its r < 0 path, causing a deterministic double-free.
> A client holding /dev/pvfs2-req triggers it by sending a readdir
> downcall whose declared trailer_size exceeds the bytes it supplies.
>
> Clear the pointer after freeing so the readdir-side vfree() becomes a
> no-op.
>
> Fixes: 382f4581e67f ("orangefs: rewrite readdir to fix several bugs")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Yifei Gao <gyf161023@gmail.com>
> ---
>  fs/orangefs/devorangefs-req.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/orangefs/devorangefs-req.c b/fs/orangefs/devorangefs-req.=
c
> index 33ee8cb32f83..e5c60da7e677 100644
> --- a/fs/orangefs/devorangefs-req.c
> +++ b/fs/orangefs/devorangefs-req.c
> @@ -474,6 +474,7 @@ static ssize_t orangefs_devreq_write_iter(struct kioc=
b *iocb,
>                                  op->downcall.trailer_size, iter)) {
>                 gossip_err("%s: failed to copy trailer.\n", __func__);
>                 vfree(op->downcall.trailer_buf);
> +               op->downcall.trailer_buf =3D NULL;
>                 goto Efault;
>         }
>
> --
> 2.43.0
>
