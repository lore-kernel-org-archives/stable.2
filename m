Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291AD3DC4D3
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 13:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785851742; cv=pass; b=pYsiilGPHmYNQj2Hba0KLI2d6i6C9+9CnYChBrg7hd3IFXZkczPa51j28zms905N9h4t9r6vgsdv1yrJf5dJ0SNK81n1Q5mB6hfSiqt1U8mDRq1rmSmCaSi8zh04nr/arLV6YPsDuFcTRStE4SYY2+ecOFM4c7Rl6Q4aK/RdyXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785851742; c=relaxed/simple;
	bh=HDUm59yYe2fE0m3pYKR/0WdYy2OIMCPhbSHIT3YZtmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cJcq6nrsjdKA9BwonSHYfmJX5yaVbZs7v2ypgii2HHTgm0j7rQDevtULCg0uQkwQWAB2w8FrdkPDb2UM0G/LLxkbL1Mcko3MnkZtgvBH3C0LtQq4rbtocVVb6yyXWpnfyl5L0hsNt7+jkvrXmfxZwzqQgywORJ5K1yfL//wLPiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pffSzX4C; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pffSzX4C"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c1670dad7a8so646484766b.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 06:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785851739; cv=none;
        d=google.com; s=arc-20260327;
        b=rjAET5gRnh4+DW5oeemUne7VWJNM24Lpyt3GOiER4NL2Y3dVX5wy5pI6seXYf2NOJz
         FCalNahV072PK+z9ICjK9dnT5oJ3fnoJuYyv/0+fUVC8w0YqgOxcAxZEoTW01H64v4zA
         FoBvfOp/14Un8/2Yw7vpns3YnOrQQqgMr2FlB9uaa7qU4aCNcNmwDOL58O9f23AyG8Hz
         nuJSrgJqYbqUP3hhI7nqIHCDmxecZUAhDmUmEwxH8F3PPAJAgFjbnSoqe+Mii1FbE6P/
         MtbpTIGNjVo6kooblvE+Y4bMDmkkhOscIVW1H234CHRj7N5EqoQX0N+eqQzFHIfZr33u
         TNpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HDUm59yYe2fE0m3pYKR/0WdYy2OIMCPhbSHIT3YZtmc=;
        fh=cYLkVBSd6elZrYTe0V0uNM4vaeb6QMDdZ9aMufZ9E2g=;
        b=N3ORWAKhyEMwJPowjbNrVDlapCxkkEeeXQJ2NfLUE+Aspd3sA5YoFtukbNRculyQjf
         p/0K8kl33NI/JMLfVvnnJKUlhqcyu8eHRbe3nNte7tUV4v+fYaxhwx3vVN+qiqKd0MLK
         jo7dCyM+tgH/oO0vTHaENoHAr0PELe5qwtS8vHTNOApDXIJ+da4msm73LFlR5Oh6pw3e
         wNZ/vpTTBwBgO/2Uti1+SqsUUtKQpllzg2T4eo9xRvyNYGa7oG8HTeue4xqGkZNPBHj0
         SAbUK7mde3ltHAWSQN9T5f/chGJQbpfUZ68Y//bGSflGvTSz1El34Vn2X/V8lhrpO25D
         mnLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785851739; x=1786456539; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HDUm59yYe2fE0m3pYKR/0WdYy2OIMCPhbSHIT3YZtmc=;
        b=pffSzX4CsLCjJtBzio4AZ3Sc/xFnuxXVjGeR+ljF4EdMFEmMoxg8uexFlyuT7R9QYh
         2qShPsSREunpK9tdaxopOpS0wTIQO4EAclCGYYDj6tHmqV7BZoEOUL17sewM2z6PceWA
         t9qUG6HHuwDxv3Wu8s8HzOYJF22D+NBvbDDe3viQ6pdGAwvuqOVhy2MoG5+NA26dnIku
         gve6cCbgyOpJe2nACfiEUvg/gai7gvxs/rmLD8DZTcqL2mlpeZI+097todcpEoNMywCr
         CgztBSXwAXdns+ZtOyvmwr+Iuz68AWNKW8q5EUJdJWaC+/p5pRaLyG4KovmMOcYeSIeO
         wCnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785851739; x=1786456539;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HDUm59yYe2fE0m3pYKR/0WdYy2OIMCPhbSHIT3YZtmc=;
        b=NQHvMYjIhxujc1i8QDbVXvf5VzTC0iavIcDbZwtZL9mB5ArY+ew3UNCbGCt5zmIVQN
         WXl+jPHe9yK1nwXZLj3+5wHHmHJt6jy8rroOWDHfC+PqD6iAdBEKf+3orQQshO6yNqJr
         l4dMHMQ721FbKOBbdQ25HyDavglDKXk2iLIYPVjCNtSOVTLFicfBOkZSwYw4uGEPFYwV
         LxGmfd3T8R2UfdBSsSSvNvlbAx5Rk/P5RceHKv3wtrZu6eYqsh3eAJ6PDPs+N/8UQz99
         lO3AQzZ6aOWmTTUPnYIDW+gPJ0pyJkpcjWZb7p3zMcd94JkulpCfj0+3av8gV0vdlHje
         8KBQ==
X-Forwarded-Encrypted: i=1; AHgh+RqlI9YxQOQJLHbKiXC3V8yLlvj1b5W1dwx3VWTfQpv8k/AKqfB25L7OXM6K8lF0LMZSlU7h+jI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzpQMyXItLVAD4NLif8osftfKoVtLw7Itwo0jmvtymMh2kI2q
	XP4CAVGwttG2RvIrYWajIgnxSpf9QB0QEAZSqf5IR4gHDe8O96amTMDthR1nXVJdJjIVcAJhph6
	og05ntt7hllGR0GWUfcn4/wo/wmBVxA==
X-Gm-Gg: AR+sD13AmmRlsTd6eC2BGnlv68pcb4zpyJtu6Wv+wx1zJS8KSXjszifvdVasx9xuZ4y
	4JvLkL83VYzRHrIzNhLIqXPR1ypV88gKoHuq3xXC6JxSXSNOE4uV37/xLgWwPXhJ4c1QzvFhxmp
	0c+/23cgS7n69NnwTBRgArvLOJZZZpYtm5Mkme20ewkKmBheKBCo/WZcVADgUe63S1xumsSUE/Z
	Yb10WP4H03J8QOrB3hP1KqVIsBwOx9+BYiGdskU2IIuqu9k5/y5rMMB5ICFSrHYB3f7XtU3c7U7
	oRaPZF7nehmjl5y0TBRtM9QLlWjD8tE/vgZD2gCpAJebod2E3Nx2M6O3dO9udTdcTOEdD+CRWQ5
	MrSR++434zKoImiWCo2RZZQ2RdS1lj+Yx3HJ2Xk/eWFdvNif55yo32CiLIzOVsMWPqA==
X-Received: by 2002:a17:907:ea8c:b0:c12:a469:c with SMTP id
 a640c23a62f3a-c1fe81672d1mr1321489066b.9.1785851738996; Tue, 04 Aug 2026
 06:55:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731161809.45066-1-mhun512@gmail.com> <908e828b-1fbc-4a44-8718-f0e7459b6ed1@kernel.org>
 <2026080347-diaper-uncloak-ced0@gregkh>
In-Reply-To: <2026080347-diaper-uncloak-ced0@gregkh>
From: Myeonghun Pak <mhun512@gmail.com>
Date: Tue, 4 Aug 2026 22:55:25 +0900
X-Gm-Features: AUfX_mzg4abd6aDeysWOgkJNMFUfwJAoCyKRecMOH-c1Blp-df2LuW5ELpjcFCU
Message-ID: <CAGEsz8E7iZZOUXZz+Ga1f+F2yYXxALh4XQQAHQ_rn4O5effVWA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tty: moxa: unwind tty driver if PCI registration fails
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-serial@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ijae Kim <ae878000@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jiri and Greg,

Thanks for the review. I agree that removing the whole MOXA driver is
the better direction, which supersedes this patch. Please drop/ignore
this patch.

Best regards,
Myeonghun

2026=EB=85=84 8=EC=9B=94 3=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:41, Gr=
eg Kroah-Hartman <gregkh@linuxfoundation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=
=EC=84=B1:
>
> On Mon, Aug 03, 2026 at 08:06:58AM +0200, Jiri Slaby wrote:
> > On 31. 07. 26, 18:18, Myeonghun Pak wrote:
> > > moxa_init() registers the tty driver before registering the PCI drive=
r.
> > > If pci_register_driver() fails, module initialization returns without
> > > unregistering the tty driver or dropping its reference. moxa_exit() i=
s
> > > not called after a failed module initialization.
> > >
> > > Unregister the tty driver and drop its reference before returning the
> > > PCI registration error.
> > I think, we should remove the whole driver instead:
> > https://lore.kernel.org/all/2da84e36-7ac6-407d-8e08-edca82f4cbce@kernel=
.org/
>
> I agree, I'll submit a patch to just drop it.
>
> thanks,
>
> greg k-h
