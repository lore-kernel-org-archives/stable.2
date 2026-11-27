Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795794558;
	b=IB7l6vUbuhsMfVnX6c+lSPMTJ/e9Wdp+0WlPf/zhZkCig2/4NHSu+0fCMRIzBqLKl3xX
	 FdlcSjE2OsqafUlJl1aQzdGzNXCLjPbioEOQFZ8GK05c7hGIVEuy6CKSBJuKopUkuNClC
	 zrgXXHzJicvlNv9nzJitbChxJopyyn5Q/F7gvTVaEeSP8byRimGZ9sfW7K9aK2lT3S2rg
	 SJiuOguiHWBrVcBxvp3f4cKn1zWy4tA0kMU5+YIki8/gR4wmj5p9JoR7N8jOQuCp4WVWD
	 YUisdV+FOLV3sEelqHhzJV1h7kYnxyLvUg+03UOGmBCuFRzTBrZL2r3N5D4/R9CAsGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795794558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=pm/8tep73L9V4TMW2Ch55CTSshK2JxETa/tNsbYXksY=;
	b=VROgmyb1KHKTwv6RwjMFiEQBWzsrxwXGy/3n+iSis8LgcN+hv0Oh284vqughH14DCyS6
	 MOrIjInfukgXjBNUzLTbdxlPmxS+f3bpFudrQRqu9/rroqde/J4VEcLqz4DtCpOwRMwJl
	 Vx4OQwtKxl4geMfzU3L+jl1MHjAQCibl8xVZK5Sfj3bIhhHKCfVzflhYcAGnvNgsj6xOs
	 4lNDr3Upw+4rob+8BGrocDeNJTGoeLKKnRY1AvsSMbFqjtR/Oz1mqWg55HiKDPIbCXbd+
	 0JjhJ2iEYdI2jlbawv0raGlouFRO96kwspZmhSE5cwvqkhJkB6XibDX9y2ZcKbhveJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="r7/DC2ns";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.169
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67063606A31F
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 15:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67063606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r7/DC2ns
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-55c35262674so60669101cf.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 07:49:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795794557; cv=none;
        d=google.com; s=arc-20260327;
        b=SW0/o0nt59pzaGCOP3qUHIBOESWk51YWfyEp6c5YWTMRyyN0TeOj8EmhtWwlrc/nY0
         feTevdvJiyDQDdxDOiT77hjOY1sRwQhjo9Q0VE3uCqKrU3nF8p8gIuvMvgVrh7C9Wity
         edy1qrnDmRRWh+7ivrRx067Uh5+gk5lBLqF2wtLfp7T0mSYPXMsdp+dSoNsQ4bEf0/3B
         JK8Qp3giDSguvrB9APo8w2vXtppX+2pb81ujV8FDiXtXnbwzUG+mb4/5MJ4RloHOkRbP
         9iFvkq3aLSaXAUvfb6BBf32wawIXFcKcmHwJ+dbNbgBPQlSBLmxn+3AsIynjF7VWkTSH
         1T0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pm/8tep73L9V4TMW2Ch55CTSshK2JxETa/tNsbYXksY=;
        fh=uic+RrpRzSqETJrG6DepirveWk8UDgnExhNU/zLk/K0=;
        b=qAdr6EILntA6k2GzcAmIaGNXxKjPJCBS+/0d7JDOjs2bpXsjo+oRI81fKadyoHjl/t
         sJodu5x56UUHEfUGoQf/0WEtZ8EzII5UE88t7TpQuCcj/6ghqeK9jQhLs776rBV0R7bv
         rNfyV0f9JpU0ZAvJdQgiFiBio4HkRmAvaQUdeu7nRuL1bozFZFcVCOsT7mvaySciLQiV
         X+rjxsRjbdc66FAjn0rGG5qLcKItpqv9VnQd+T06ZaRozt1b5C8DFSgxRF8J8VoqiRFF
         Ill8JqIiCRXDwBcFeofIYXGwF4bthSrc4e6Kf3r+1rsxWQ6e8reKMYPz/3WduIXSi3Gu
         FThA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795794557; x=1796399357; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pm/8tep73L9V4TMW2Ch55CTSshK2JxETa/tNsbYXksY=;
        b=r7/DC2nsFPcFfujXShUyJum92nAAXkR0SPOC0ulHRZV7FF+2KOagqIU8llcBM/1sWW
         HYzyUhkof0c/LZk5o5X3JnEQKrn3MUj5T1ypXIw/5hWZmTHABodP102dd5j1T+V2b7gP
         uU56XPDlh5ZFSTI35HOlaxOXnUIs0Bq2gQxx49Ngr/1l/H+LtZEYC7Eq+3wXVagvXjei
         zv+r/9ePDQbmXnLvvT8OhCZj4Svf+Fd/hJlVd8jNwy65xC5Jl0wbhcweHGLgF7t63Kdo
         wUNQIrBPNig40zlbv0oC2Bw+Pi3AYT+5OnLLzteFop3u7hLGUeT16D85qVO3NjtWaIph
         Fn2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795794557; x=1796399357;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pm/8tep73L9V4TMW2Ch55CTSshK2JxETa/tNsbYXksY=;
        b=RQZV/w8wn1Wrux1BDjdfkKlP0Df8nh2q4sXev6dr4zE2W4FKbgMvkMuEBLEqPYDczl
         o8Z22VFCKXsh/G+97FeICVdHs4Dr5eLSXWKSa6qwlYJpNwT6OlswCUOPA8iVm19iEZ/R
         pL+HJlEsrhdeGSf93UJxOXfcLdvv7qRcy/Sv8byo6ng0E58DPqE0sGFyomCO6ORH5mCP
         OFQ383joD6XsORXcQ+mw4/ow/7ZCbjT0Yf6RUVJ0gxY2n2sO/0UuPCpaVvUHvUEXbMF7
         UParhQpa/X1ykIMw0VkW+doDiC//gSG10tszxMI5G/2e3FJZnOjTGSoBZGJamk6GFb5U
         D0rg==
X-Forwarded-Encrypted: i=1; AL+hErFAeb7xA8CW29dsqKxmHJqs7RlO1XK6ZC3keeT0mPZNa+pu8qIwmMqPYBF9dIGueRnB4jpx1ms=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1X9B1+Q463kecRTYybcGcIq/rNjs1VxrEZYhqmQtDbY4GH97s
	DyK9RUx78KQJaBshIA+PVQ5Se6wM5Qnl60KFQM+4OYHA4wNQOnYHvs7xXJ/ci3drQiC+g562+sU
	1D8pzjeXARIgKLc2tjfM1dH0/qT0ilf8=
X-Gm-Gg: AZFdTZd+/8/lOXMSMtO4eJj4uXbRo70jDCjhsThTLMcEs76JsMlCsqyrbtpteeP9FNa
	Hw75xWl1yI4wA2qMqskigt+AmSqGqV9Ev0wUtpBh7cJJut7ypuUIGRq9VHHzyqjYk1gz0/JjiHG
	TEjz1dOohs4+9WFozWfoDOIon5wFAmdJlL7BW01j7/Qtb4ABDm4p1Hi7KLk+nEatJg52X7im+VP
	rA4to6hz7IH/L2uJy039UBdEDjnfyxe+BIYljIZT9y2/Etzccq/IdkUQp+SxGj6i1zML9L0p5iv
	nn/+VE4ql6K1lvLsMImCN2M8yL+euIIxnuOdWKJLnHqz8XLrmXPXDP9nrjcxMKb2mRMSwKszDnI
	cvZ16asFnv2NLb6Tu/WLly5d6LIq0g760+srdgVP62gmYYFeUvDTNAprskEnv37X0DwDO3v4IBR
	d1aFZhzhMH7OX/L2PCmKg07loQg5PNf8FQZ9PHu0VSVza/VVSH9T4nkqsFK+sETJ4Bj8wPSYS7F
	Mj4mB0sB5eFDfZP0MskWluZ+gMx3pHX6g==
X-Received: by 2002:ac8:5754:0:b0:535:a5fa:edff with SMTP id
 d75a77b69052e-55d76a59807mr476389711cf.63.1795794557235; Fri, 27 Nov 2026
 07:49:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126031506.165973-1-kaynak.oguzhan0@gmail.com> <awkzEjrVEz2jB1Ma@z790sl>
In-Reply-To: <awkzEjrVEz2jB1Ma@z790sl>
From: =?UTF-8?Q?O=C4=9Fuzhan_Kaynak?= <kaynak.oguzhan0@gmail.com>
Date: Fri, 27 Nov 2026 18:49:05 +0300
X-Gm-Features: Aa3M54oG8qNSkma9SYEe5bEWuLV762AYfcjKVO9GWl8LUMyf097tEckGvgVUriY
Message-ID: <CAAKAQ7KpM5hT-Q0mdJr-0VnHy1DeFBoODjYM-FCoXiS+5DW+cA@mail.gmail.com>
Subject: Re: [PATCH] ntb: ntb_tool: accept hexadecimal addresses in
 peer_mw_trans again
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, regressions@lists.linux.dev, 
	yangqixiao <yangqixiao@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Koichiro Den <den@valinux.co.jp>, 27 Kas 2026 Cum, 11:01 tarihinde =C5=9Fun=
u yazd=C4=B1:
>
> On Thu, Nov 26, 2026 at 06:15:06AM +0300, Oguzhan KAYNAK wrote:
> > -     n =3D sscanf(buf, "%llu:%zu", &addr, &wsize);
> > +     n =3D sscanf(buf, "%lli:%zu", &addr, &wsize);
>
> Just to clarify, do we have any rule about negative values for the addres=
s part,
> like in "-1:4096"? 21fbdc4d0b1e mentions "-1" as a possible input for the=
 size
> part, but doesn't mention it for the address part. (For either part, "-1"=
 is
> really odd, but that's not the point.) As you mention, your patch starts
> accepting it for the address part again. Perhaps we should keep rejecting=
 it
> there?
>
> If so, to cover the cases broguht up so far, perhaps it would be an optio=
n to
> split the input at ":" with strsep() and use kstrtou64() with base 0 for =
the
> address?

Good point, thanks. A negative address was rejected before my patch,
so it should stay that way. v2 does what you suggested: strsep() at ':'
and kstrtou64() with base 0 for the address. I did not carry your
Reviewed-by over, since the code changed.

v2: https://lore.kernel.org/all/20261127154157.3541-1-kaynak.oguzhan0@gmail=
.com/

Oguzhan
