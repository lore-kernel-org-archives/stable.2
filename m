Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D9551DB07
	for <stable@vger.kernel.org>; Thu, 15 Oct 2026 16:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082188; cv=pass; b=JFlzcQfXoLSzVSEbej1/dHdq5nYFT6qtC/5+5A7iYN6Qnup75IiD0+U27v4FAtY6AFhymNm3+HHZ7PFG22CPiFkrYUOp9Q+7lpGgkaC1UiLnYvQ2f3jPsMqfytlpGttLlhHfPK6N5MhDvNXbIuYIbTNY2GOwQMxVsNH2d2m/czE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082188; c=relaxed/simple;
	bh=Q1Hbn8A5ixxsCYzm5kvN36Nd0MTAUla5jdeLPZM2QAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0UOFFyDOUqsJefvD5LSAOPexrJTxM+NV0ePY5XV11L+WbQ6xgcyfy1/z5QC4PZNA47JldoBLXE8DCFiY3Pr1x8Tsa2FijOrA7HE4bXG/Y+836hao2MkZE8+73pk3xBSP4auqK00qkGHQua+X2QMjk51s0OplNMMyi8YB7AyQ1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=hCxO0nuA; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="hCxO0nuA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49d05d51553so15475605e9.2
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 09:36:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792082175; cv=none;
        d=google.com; s=arc-20260327;
        b=TIGL04EmNH9d2/jfB0Id3VmySKO46HyPII2WeCD9S3CW6ujbweiPUIBY7i0WxkwCMt
         TdDZlgd1DsnunzC3WvxSU5v9Xbg7f4fQKkir69vyWcSo9QP0amJ3Et0Yqco2v2g2RSW2
         Y9B0qQJ7XpLvyxH3TIzia5SwF6j0cOrmCi7JUKJgz3vUa0ITYRFCE6EEbcY/HIvqDNB7
         1sBZVG6aWoYCkX5g8pqIsyKyAHdfHQslJrAd9PphLJcWZGNUQbbzCa1C+OmBYmN0qbij
         kXxnZTTozOV4pkXGTFFSJrFh1Mp9ZTqNF7tkbEz4uKwoi3huBQau7JdfnqeV572HX8Qg
         1pbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YZTsnGl93T9ATaDuHMEnI+XuoV61t91q+RIl87Urhds=;
        fh=nVZrHCrCGhgNWUPmnZ1d5m+BFTZuc3NW5fNRq5W5wug=;
        b=jIfMjwqKdsdkkWfNYo61EZxN0NKOwNPw+SzKlCxl8w7HG95KuPqPHXlPsJGvo5+Tcy
         mQfxXlv3+2tkirHaLg0q0cJRUusj9yLK58rlx2H+B/Qad1zIu4YUHEOcyFuQ9ytsM5nZ
         zCgYN1k8oaSkHgNxPCQmXFsZFi6sGp+6f1qrpoJHgNTmL7BIg7LS1itEQRxyw7Nj2sRd
         D/uCDCs3VxEYkDhkiDuEeK87ki0DeClGnV6OQ3CednPDkfin99w4MfWt9ihViB29rPC/
         ZTj9CkVLi7rkMOgMdbi4Yw413AlRy0YPLTaYPGdvYg88eNcSBeAKI+t5E8XQD0UKmsD7
         IWbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792082175; x=1792686975; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YZTsnGl93T9ATaDuHMEnI+XuoV61t91q+RIl87Urhds=;
        b=hCxO0nuA/h9+fXdy7YdWXZk1zj3kB89t+5VcPf2MOgn4vcnWUsKOE5CF9/vTsm9BTr
         y2OcY2vEGENhuXym0537aFsxbJU/rv6KUx3uTq4Pyo2t6IPK8JKvVEqsO8p072fQ6OXY
         kX9rCRYmfUmMWvR039MNitzhRxXwoxT5xcrzlcMK/52kwDTuAgxzpjEks8j8cCn0QHon
         5kfRAKrtmRkC2XjBP5c758wTP2gsskKTDfL/ZDTr3h05lCES/Zpkal13guzd6j8otd6M
         2HCMXD3vA8ynBFX7/mzb9z3Lc9b3WZPbnYLh14uRg3y6dkKLENCyWqO9sp/Goo+VEdgU
         sdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792082175; x=1792686975;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YZTsnGl93T9ATaDuHMEnI+XuoV61t91q+RIl87Urhds=;
        b=Frontrcn0gSvgQwOdrFA4V2hrGNvegVY5UQcXa45Ln5pEjIExQTRSJeVYn+5g6At7E
         faKnW8HE+Wml8kVfwBC7/qlEbirN5p3E2SrtmiojiUxp4Hk7xT5cwskFOW/wrlpEWTvI
         6fS5qUv0IEGaikN+EK6Hm464ghHtw+0W5pupqxtRX7ApPPWUQNyAkktgKN6cjMzv1XNW
         eebI+sFpcEnegLsd9A4HmGU4HddRaMPc2WdC38OxHJvdVPJPOZ4LyUMm1O4NdzMEmRY1
         Bkmc3jLrV/HHLimtzjSCjLxKMhQS4KX6xVer7FNnajT5i+3cZE3BakmYo0fVxIMO9dUU
         MJww==
X-Forwarded-Encrypted: i=1; AKwUvBwAuiKfcePzPI7pue4/XROP2Zfn0LPDXJHWyrImELw6EgY/xdW5Eto5FL78RdDg7Mi1+knAapQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKm0X6vWwJnVBilJhsW7U38Co3njiiVlS8w4J+5YLwlPu+BqDi0
	ptt86bAqLiBY3VBcK1VjhiPOVoZK7/tO/VxDVWvZu1g8bJWvDs6kxwQWTH6C2hjdLE/9QPP7GdF
	pr7zMutmGP142pmUn9VSqyG6NBVPiRwOpUmrKp0Ytjo14QfKQAN7ccfzoke7Z
X-Gm-Gg: AYBFou0+0ER40MHNDlUBy/HeiMh89qjF/iqLy6hfpY0UfKeTJcfNiqpXFmbMyUlp2UM
	WT4aKHdS3T11s3O4Q5FVWrBCCxxWOFBwiMzVKhRZqxJ0yI/XNlk6NYFc6/qvGRPltcZFBiEcShf
	QRy38Sm1nho+FRWAwWqd6sqNTgNdb9r/HrQ5davdcKUpDQWqGXV3rKmxzUPSlN4L/y+xl10q3Bw
	R0J7SM6zcr5buODp/czbhTzYz130QEkTp8xoMf7K7Hq0DOavg4vfC1qRjKUrWCkqEln9IL2+dfw
	/ldTusM0Q1+pqetce8R4QH967yPWtBo2z7xadT1SKCE6PHN31x7jHhZWHTYRbQBgPa+Dkg7evds
	E8hCg7AC2bwxupT/B4ujQePMuHMowePrl6WOG3h5bLF+B7A==
X-Received: by 2002:a05:600c:3144:b0:4a0:2423:946 with SMTP id
 5b1f17b1804b1-4a18e48d362mr391589485e9.15.1792082175349; Thu, 15 Oct 2026
 09:36:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261014190815.23455-1-artem@trailofbits.com> <atBnuPOa68f21L6C@debian>
 <2026101501-willed-gracious-cc62@gregkh>
In-Reply-To: <2026101501-willed-gracious-cc62@gregkh>
From: Artem Dinaburg <artem@trailofbits.com>
Date: Thu, 15 Oct 2026 12:35:37 -0400
X-Gm-Features: AclHuK8y_jc3VDzcJv00TFRcnHd-VT4h5bEOUBoAM87IHLQfMWP-617JGGgKnqY
Message-ID: <CAP3zxaDs7Te1utQu4Pi8j5fSkJx1PbxCS1N0jXqjcO8x6jQ6zQ@mail.gmail.com>
Subject: Re: [6.12.y] Please apply one upstream fix
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>, stable@vger.kernel.org, dlemoal@kernel.org, 
	kwilczynski@kernel.org, kishon@kernel.org, frank.li@kernel.org, 
	bhelgaas@google.com, sashal@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mani and Greg,

You're right, sorry. We haven't hit this and don't have the hardware.

I was preparing a 6.6.y backport of 934e9d137d93 ("PCI: endpoint:
pci-epf-test: Fix double free that causes kernel to oops").

I had planned to send this commit ahead of it, but upon further inspection
that is unnecessary because 6.12.y already carries the double-free
fix without it.

Please drop this request. I apologize for my mistake.

Thanks,
Artem Dinaburg

On Thu, Oct 15, 2026 at 5:55=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Oct 15, 2026 at 11:13:42AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Oct 14, 2026 at 03:08:15PM -0400, Artem Dinaburg wrote:
> > > Hi,
> > >
> > > Please consider applying the following upstream commit to 6.12.y. It
> > > applies cleanly to 6.12.112 and is already in 6.18.y and 7.2.y.
> > >
> >
> > Please explain why you want this commit to be backported to stable kern=
els.
>
> Yeah, this is odd, it's a test function?  Artem, how are you hitting
> this and why is it needed in older kernels?  Can't you just update to a
> newer one if you have this hardware and want to test the endpoint
> hardware?
>
> thanks,
>
> greg k-h
