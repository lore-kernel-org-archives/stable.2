Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543340A934
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788341052; cv=pass; b=Kr83C2OUpVsxuwjxu9GxdMElYVFFWameOy7O5mdR1aOwI1I0pxZC9VtL3Nl0hksJ07vSJE/1DC69arYrEeDF3ELGLqRGgpKf5pfTWb5VyF7ua2rwwR2dRwzbtEMMprxu+AtK8oa2gdFuP8gh74LMjeMlu+p5x3nD1QCy420AnsE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788341052; c=relaxed/simple;
	bh=Ztg/iuQclPd7J/lDVuGJccxiw/xoO54Q7eyscqFYx+k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ILuoeV+qRvGDOeMn+24rGdExl61qJqs6SfkkexDDSYfDznNM/bnEN25MPXDIX0nPnp93wa/JLPU59pLej1v6GHRSJkiYdVNVvOApWKHEWP0SRFj4oRcVJzYKOycZgLLDNFf9YCvo2FbCaFv2cCvaEtb8kI6YmSYOiEYCxRY5M+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=tA93ivPS; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="tA93ivPS"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d8f265cbe6so7510205ad.0
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 02:24:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788341050; cv=none;
        d=google.com; s=arc-20260327;
        b=KhUDUAiaBMQ9Q4oX+2pZQPif1gjV5Hw2uU1IXa+sc0Ji5eB8dV61w5Rj/WPb13M+MC
         aMkG1MoRirxjBdaO/O+6dGP66hsaAz58Ere7qa7mFVqsnH73gbbhaKNs0tHZJrEuXoRL
         hmjF5FjU7m9/RIs1N5E3sXeBUY5++AiyZrS9eMXZtNAPhb0zb2Ok+7zdrw2eoOqGqiVa
         EIhROcGi7n1IYG8lUc7VXN1vlpA5P0edFy6B/bJiWKJ7+hOy6YnUemVx+pOPH1pUUFw5
         MP1Z7E6U/2nXjhoN64rFYH2O/Knu9bwRfDOKmrDkPRZ+qmPswxo/k7vwF4VLV4Ex4MZM
         dqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ytaSS9E97s/JULLyGWR20qPV51uikwUgTS3pF5XmIPU=;
        fh=aUV7O2kD5ilLQ1iCYnb2dK1vHvPRBsBF/Ko+rwdVrsM=;
        b=F2F3WsDFDJ3ABtVkcmn2FEUpZpmZ7QbxbH5xTXcYW1HixGJYGgwN1dWLtNtWxWttSM
         /vNFb4QViT8HsFTtVvxFi6jeQK6RjSuNDi8ALIbUT25u+4iMUtfipj5CJXUKxfEtaBg6
         nt6lpxjQdDF/e+9mUh/mI7g5qNIR2CuOQzxND+BYhWKJzWqUVy+E3P9xvQwfo/bd5WEv
         bTNPq8HGSc377hbJ8Y1tXXjmBuSoPUrbHEk0nfBfhK1M2fgELgwZx9eTRbRQ3gW0QZXI
         aOXO1Iyy9OZEtbOWz5haPms+WnJOdTiIv2ZWenGFybPKuKn98lrJW9Is+erDzKOW/5Qt
         swGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1788341050; x=1788945850; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ytaSS9E97s/JULLyGWR20qPV51uikwUgTS3pF5XmIPU=;
        b=tA93ivPSkpyOt+jNZM//pU3zX/HrR/P3Tt2g/ksqfdK9UTDuOXLEGaDqbX1O3WDg25
         u3YMN0pGGfVTGBG8I9q7jb++TWSAWoluy0DP8vmxhg0YR8N5W2jGPvVv0TZ+Z8lfkp+r
         ZLC14i9NKPn2PcbDDVqbVWkLbl6vRpErfBBGje5Tm4rEFF43cHBVJVkvJKRsir0CVagu
         cbGM6nPiBcxGIEIJfAPGlxkcOIkoaRXid+MskD3jBUAxc5+U3YbqgkcNz5CTAbR0gxX5
         SvCRqzwWOiBJp7am8o1qXO8LSzN6ZYUurO8USFsZFT5YGzTVLKOOpSYSKaU1n0GOP9WN
         wEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788341050; x=1788945850;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ytaSS9E97s/JULLyGWR20qPV51uikwUgTS3pF5XmIPU=;
        b=enlMzQJCiKwacsbr1sNR8RJnRLZLaa8HfLsbPMyPMWf85U5mEw2DHg4j2NqJS+Dw3L
         pNt8ZCemeg6IzfHzSBQpcmZzyKUr6Fur5fLs+1pLrn4gA4lwGf/Sy0ccS/xgDEnGBhtK
         HOFR3feYlmascoj+L2YIixS7AUcm+hbOq5pRgmC3JNQMgsM2/6pJ/UCXi3WItSvd+SDd
         MItv95/6udXntkgTiVuC9iQeeXFV6p++v19/esqHwR1RDMstDHkgdHD5xwwaPLiAL1Ku
         KTfcsJ6BzrDoesn1FniCCr4nL7y+2Cp3cyzFOFClwe6LcsqEUxZp/Lp3jVkm5XYnlds3
         ttXA==
X-Forwarded-Encrypted: i=1; AKwUvBwR5R66mqzRo17vvYVV9z5JlXeqLLmgPAqGe5iLOZpD1tVnvQ3il4CAPJe3b/NZgLFJX2RmWyY=@vger.kernel.org
X-Gm-Message-State: AFuF++kcT8EMYtrHGq7Rh0rJ7sQlf3W5Pxw1YyeV8iN07syqFRVhWwb8
	fOL1W6pzx7UJF29TvEf/RqCvv/Am0pK9fPsbvAQD8PXP5A20ht+s3PscK6V4thC+1J4XXEDdGUD
	+9E94aaQzO6WzUUQBbBqDI5R0U0XiQdeHeh78EW7ssg==
X-Gm-Gg: AR+sD12HpntxYjck6QsSizqVH21nbaDrkXx/sDKV9dfNzRwoz9e1J2DAeXX7bs/R9If
	QtcRfW0hzPBwNpAOR//ZTugM8uxnDbxP++HH2iqVqkfq5JLou1mme6e0FfJa6abRA+Lu2BTihNN
	2jkrqozXbACWOwhBew0oARE1EF0hfmRFYCN3vhTCjb57Ip+vzqfIXdnDvfsgbziq18bty7i5Hxe
	9MjY8vNHgsKB/m4WHcbjgeUllslqvKEGj2rjjPEoATc6w9RDnR0Ab64cFyXM3kOX/qU7rhS+1GV
	FcSyBVEB9gS6iwQTsbSsd3DmLr4ftj0MnSBuTf44PK5C38+DmwC1HbK2z74qoHxckUmkTAMBrZE
	rmQ==
X-Received: by 2002:a17:902:f682:b0:2ca:f21a:a6c5 with SMTP id
 d9443c01a7336-2daec5ad6d8mr40455475ad.1.1788341050320; Wed, 02 Sep 2026
 02:24:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260901-rk3576-otp-cpuid-mac-v1-0-ea9135270fc2@flipper.net>
 <20260901-rk3576-otp-cpuid-mac-v1-1-ea9135270fc2@flipper.net> <87ecfc81e9.fsf@bootlin.com>
In-Reply-To: <87ecfc81e9.fsf@bootlin.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Wed, 2 Sep 2026 13:24:00 +0400
X-Gm-Features: AcwNN1Vwt1UNue4ueZiVCGXuJAETKqvfhojim__xlQfGqQYcvUB9rCpZaBk-bcY
Message-ID: <CAKTNdwH5S3MxgR=5s2LXPquCFRXE-61LTTsZoHP9+YmXo_P4Ag@mail.gmail.com>
Subject: Re: [PATCH 1/4] nvmem: rockchip-otp: Serialize reads
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Michael Walle <michael@walle.cc>, 
	Finley Xiao <finley.xiao@rock-chips.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 1:10=E2=80=AFPM Miquel Raynal <miquel.raynal@bootlin=
.com> wrote:
>
> On 01/09/2026 at 19:33:11 +04, Alexey Charkov <alchark@flipper.net> wrote=
:
>
> > The OTP controller is driven through a single set of registers holding =
a
> > state machine which has to be stepped through for every word read, yet
> > nothing keeps two readers out of each other's way. Concurrent reads
> > interleave, and the outcome is either a reader bailing out:
> >
> >   rockchip-otp 2a580000.otp: timeout during read setup
> >
> > or, worse, one of them silently taking delivery of the other's data.
> >
> > Reading two cells in parallel from userspace on RK3576 reproduces both
> > within 150 iterations - 53 read errors and 9 corrupted results, the lat=
ter
> > either losing their first word or, in one case, ending in the two bytes
> > which belong to the other reader's cell - whereas the same reads issued
> > sequentially never fail. Concurrency is not hypothetical here, as six
> > thermal sensors source their trim values from the OTP and reach the dri=
ver
> > straight from asynchronous driver probing.
> >
> > Guard the read path with a mutex. Reads are the only way into the hardw=
are,
> > as the driver registers no write callback, and they always run in proce=
ss
> > context, so a plain mutex spanning the whole clock-enable, read,
> > clock-disable sequence is enough.
> >
> > Fixes: 755864feb729 ("nvmem: add Rockchip OTP driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Alexey Charkov <alchark@flipper.net>
>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks for your review Miquel!

Sashiko complained about mixing a scope-based guard into a function
with goto-based error handling, so I am replacing the guard(mutex)
with explicit lock and unlock calls for v2. There won't be any
semantic change though, so if you don't mind I'd like to carry your
tag into the v2 version.

Best regards,
Alexey
