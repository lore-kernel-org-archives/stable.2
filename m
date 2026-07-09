Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C39A422546
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 12:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783600978; cv=pass; b=jRaJqCAZvbkJTnWJWLuOROhsuWkRU4Ea8og+J0k4RJrAMLKRPHjPiQSBd9YfEA0SbAkHtD1iHiw5wB2FpasHhIK8JCwN3SxsThSyMWaUO7KeybuKnqi4BPzEY3k7mrOJscp6uRBFSWpPFrZZ2VZMrrHNFY0OVlm8+quSgac+8kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783600978; c=relaxed/simple;
	bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OAAgqbVECdqo3LtHWFmTuDhObsOsREdtWDI1s6SUG0uZsIAIH1HAbYILW59bOjvFBgPdn9yFmNYAtM94r5RvbJlVwPF0+oj23sNw1nJSWhSGhg0c5B9kN6KUBX/T0BwJ5vTSt1DQLkkVBVRvPaLWN/Xs9FzOZbZGXe2+feA5EFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OOpesoQk; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OOpesoQk"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15c257a488so240129266b.3
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 05:42:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783600974; cv=none;
        d=google.com; s=arc-20260327;
        b=NHXUp+D9+bUicG5rpTnoW5EBon90JV7jDbFVf/8psIBOl5Jlfg0CdegK2fNAPHFgwX
         koopIwSlk22r+lkmWIB35HshtPtbZBP7HZGW+B2bjhTYm/MgexIkYYlkLDsYo87hDC/w
         ipEa6xTuqdBhVBMAPnd7sxCmYRsyvEQ4KQRZxHR1oBv+Rdz+tuR0gd4D2i/n3/PXxTkC
         VBvrrWrp9rsxPDJasozduH8oOG5IbVontTR3Jue4KTFE/otRwo3/JTKSgutDgntvbsIc
         m8wYt2tIDLrnBNEJcDoMhK/5zkdH8a6tFRDODYwz1AUBaQYlvSARXEJaSJpROIw0karO
         4rzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        fh=fQRXEMMXK9syHaI7XZpYyZ+gATnHf8+lrZZRihwJzbA=;
        b=S1dRrpmZa7ANc2t+D5dK/LZBCfTYp/aYLc7VDw1wp/5s3C+UsecSD8H80Wo7FETljU
         /4MMQSu+aIBQsio+hoqR+JC8b+CCGcRaXe7R9mj5glkq4ef4qwdRoWP09M6OBUNA9EBO
         FT4RH3t0b9Whr5evMtRRywr9Kg+vsG1wevKDJLSN9ZWsJ4vPTSVhXkKN6bKJVEChIRm6
         xn45dROl1hG7uUk4ZS00zXH5cCwKGAocMONVVQVJEiBPUccmFBMwK4oPbwdVcBDsFT1s
         YveyEaIC7BgmFM0urKyti3mJxWQv2OVA+PDiRrG5SrWIeCXGE6NDl7xWbUx3hCjVWOYC
         UDqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783600974; x=1784205774; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        b=OOpesoQkL9ODcjf8lsUxf2MPbMrsTNKyPDubu/sUok1vmvHEX5ssLfKeZRgtG/9h+E
         V6At1tPK6vV9ampmZy38/HwsMCAOVec/B+rrVruZLguWfnBAnYEdeFdYlUtQPFvuOxc1
         jAXhP6jUrfG7GBWnNElrOgEFA00mQGTNzZRKhia/FnNle6ndvgFeel9NAmMsaY+9JmTQ
         Iq8CRPA3inpi/2Axou/c4/m6UaRU5Ed4xpztgNH7iuy6kgixq9jbQ9iHIiy45bJUzf5F
         NF6e+mH8Yg57lwJjLSqCYPIdqVYzbU7O1Lvl0iFBmh5ne/J6MoBuqmAYsqrh+ZwSsxmn
         RDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783600974; x=1784205774;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lGxuTmJonByeoKZLNGDqsTWGMGeNSB8gf+bZY9/34MI=;
        b=hJfmbj7rDqe2e67XlQVyYNyTUFziNtCPx69Bn3tsHvKtt3Ivm+xb/OmBh5MKWLiY3m
         CA9uwSP2uGufselx7PWXHL0OgQ6x71JPx0XMvWCG0lepb5enTlzedx+xH/2mz+Ki9tXP
         7mmaZCodC0/0MZjv940SQuQqgEXy8Nxfhh26BlqGoGZRfq59EXU/hp6+Hc+22QpzzzZ4
         yL6/NIJvKP8CBGvD5tMmP+s4chWEuc0umpC2+PduOJj/yqclcKrWB/xXQ5DCqdG+ImsJ
         G/12i+euUiicYChiDad0WJX3BNxgyc1s8lYIaHT0pXIWQW4CEYMPa6eG6lx/nd7EpJ9c
         MO5Q==
X-Gm-Message-State: AOJu0YwYTjaIlVnc8Dshxmh4d/BnGXw4v/eCuaEjuGE7RuYMl3G+8f+o
	1CeFeNDyqOnijFn6nezY0pc8wGXuvN0vnvO0dcI5IMvlDB/CKUzmbGi0U3i9XLZQRbxeU+9xbSB
	1zqZ232B2PxawJm+ppBawbn8FYy0JkR8=
X-Gm-Gg: AfdE7ck0DEkZYAA1ya0vBO/+0elB9A66QYL9O98DpRmNzMHTHrPI7CWnTD4ry/OV1tv
	gFPMOgrsZnaqpZm+n6UI9uty3o6WpaAZWgyMswKwZDIVkzRSr5ZQuALbcof8uleDnISu42yuYDy
	St38EiwcRyjFemMVQCt05avHZbJiXpbBkpojLY9/Bj0qB40/yOPLCkfGkn4joeLFswOxCuD/F+R
	6ZlZlEi3tfgmNvvkyXqYKBKki+LLD3n4ESl7xibTWsRyjlhCqyUqzTj6zTRQbw4xLbr9F8G6m9b
	eVBCng==
X-Received: by 2002:a17:907:782:b0:c15:b368:28ba with SMTP id
 a640c23a62f3a-c15ce1dc0f9mr300135666b.56.1783600973674; Thu, 09 Jul 2026
 05:42:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709101327.9508-1-royujjal@gmail.com> <2026070925-delay-gauntlet-bc7c@gregkh>
In-Reply-To: <2026070925-delay-gauntlet-bc7c@gregkh>
From: Ujjal Roy <royujjal@gmail.com>
Date: Thu, 9 Jul 2026 18:12:40 +0530
X-Gm-Features: AVVi8Cf_qxhMx1ZeQ3oKQ5Ke958RTxWs-_NyJm9hkmAWt83JY7oFCTeQuoLyaug
Message-ID: <CAE2MWk=mm8_bkd54Gv1mdox6rfvx85Dd3AjOCxPz0fPAfyuWYA@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to 6.1.y/6.6.y/6.12.y/6.18.y/7.0.y
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Linux Stable <stable@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, Ujjal Roy <ujjal@alumnux.com>, 
	bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 9, 2026 at 4:34=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org>=
 wrote:
>
> On Thu, Jul 09, 2026 at 10:13:27AM +0000, Ujjal Roy wrote:
> > Hi Greg,
> >
> > Please consider backporting the following bridge multicast fix series t=
o 6.1.y, 6.6.y, 6.12.y, 6.18.y and 7.0.y.
> >
> > 726fa7da2d8c ("ipv4: igmp: get rid of IGMPV3_{QQIC,MRC} and simplify ca=
lculation")
> > 12cfb4ecc471 ("ipv6: mld: rename mldv2_mrc() and add mldv2_qqi()")
> > 95bfd196f0dc ("ipv4: igmp: encode multicast exponential fields")
> > e51560f4220a ("ipv6: mld: encode multicast exponential fields")
> > 529dbe762de0 ("selftests: net: bridge: add MRC and QQIC field encoding =
tests")
>
> Why is any of this needed in older kernels?
>
> And 7.0.y is long end-of-life.
>
> And why, if this does fix issues, was it not tagged for stable to start
> with?
>
> thanks,
>
> greg k-h

I already explained this in the email thread, "Please backport bridge
multicast exponential field encoding fix series to stable kernels".
