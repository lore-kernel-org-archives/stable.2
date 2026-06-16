Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCC8447A0B0
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 17:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781630784; cv=pass; b=gV1dd9GtRAbW+bUQAN/VKd1u/3xGpbIikZ+1kluEhfdyQWxZizAZmw6UVsqLijwfnKdIZJBhu+vmr5fzjP0/8+uRQx0qfG74zwjmiKu9TztCKV7d2nogC8PUYvjrUe9AgxsUlhIP83j4Y4JPiH67jkfd+I0sT89d5bx4Hs6lokU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781630784; c=relaxed/simple;
	bh=bK60+35u5sVRCOWvP8FgSZ7dX+YgxPLpyqqeNvY8WcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kMfaVBywe1nCWNgd0oVJHA0Ho9J9VHuGhcEC7UJaA1gwipGAsXRvTzZ4TE5R8IzT9Sr7uTjQLJ4Zayp11i8Fx293YqNU7d8yn78qBXKh/WJsbhbV5yFgoH1ya17fFDtVY8+n2CKnkb2Dt2q0EBQwpdJ87bZ5WLKl9exdWseAftM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze34NRz1; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze34NRz1"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bec450b950dso697267166b.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 10:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781630781; cv=none;
        d=google.com; s=arc-20240605;
        b=LOCHPvuay8S5kvaoQrMhO2yEIvc5P26FbaqNJpZKJmbmfzOHw43fHtSAgotJhna0vB
         CXwO70TrH/JeIDKwAM12eJV6TGJ350LWeLmOwxoyT3ke68a3zl18BxT4DK6TYFlhetDT
         rfRg6v15cTVbWHZlLP7IXNkN/hU6aiFkJqvQNxvXsDqnlsGhuHBx2yrNGXMmkcvJJPJR
         EuT4uWBXCD/J3Hnns/66ue5HwOe+RthEKS1V4cqIUQlkqaJGBgQGdGTHtaKFwBHbtVvM
         a/886badiDLzrD0D5mT1eNttvu8ZYP7scK3F17dmYyPPoePDphiWa4hBdVTYQSljnmxv
         S3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bK60+35u5sVRCOWvP8FgSZ7dX+YgxPLpyqqeNvY8WcM=;
        fh=g0ByiT3NkC99NdiYlLxnO8cS0a2ugWpc/c07VbZOyKI=;
        b=YbZ3dBweu60lk2nYjT3SyNfYhzpK5xjSZKURF9PJ0L3fuAmZLnL8oIfp1xBRixs2E7
         w5Dlpy9KU0zDOId2Nb0LJWYuBqb7Fqhh1BNFRmh0YoeNGj66VO8GMypqudO+8+xHyg71
         Kdygl9yPM0/kvxWK5lyGKcl3boBopB+Xh2K6AfthDBQgWfrN+JE0GBtZ/j8DzGP2fiMa
         VqZ3uvteYXJ1MgYcosAzz4iFH9wn6op/ORY5NoF9L6SesLK3amMwbPlXNdwZpPp+g8FY
         sl8hMoG+KfjNWTWSAUvebSVmLQPg6qgJK7piJs3Bout4NoxvOpOPOKFbfYyvijTdll3Z
         mq/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781630781; x=1782235581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bK60+35u5sVRCOWvP8FgSZ7dX+YgxPLpyqqeNvY8WcM=;
        b=Ze34NRz1VnCdeaYHx8BPAtd0fPvqQ592vlKs03OTtBxOHS0p+J1BMb5ouEV0NiO3s5
         GfbqAK0jQ1do2YDUIA9X1xIEnbGbBNYAGSGSmmHWW6p+2kG1lm4lvxSBiI2P5fZMr5P5
         c0vxUVz42QRFzgaloBqwbwc4bGQlTBm6fXsYtS9PX/6SJcc1fAM+FuEchMd0JVm2uQvy
         xrDaJYPlr3AwlRS0YdDJ/MdA2xAbyCTFGDNsV3Mg0Gs4wrPuMXlHSgPiferWS/8syqFn
         x+ibd2xVgM2VyAATqPlsfr0+FaNtcwarowweFn38pQG39AsOuN/oRBJgas67jsUlKJ2Y
         KQDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781630781; x=1782235581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bK60+35u5sVRCOWvP8FgSZ7dX+YgxPLpyqqeNvY8WcM=;
        b=NcDmYkAGAFuzDWhN+PeJ9b3WVbwc+JFPMmXEvTDvar14hVITvr9oOWeMNB8gLVcNJo
         01FlOgKzbMb/ur3QEnHzx+jp4j7zsmUrDy0QLt5zHInvWln/nrvA+ZagTQrbMiXe6pCO
         Ym0C7G05Q95kYXw+vzpdoiAGnzTV8Y3nDEZs39cupPsdtp3uu2MPy7rkpLYgCy9h43Uf
         CwRLVywTVebFGDG9rCOEQbzWzsIlaKMpOEJRuXTwzZ0EaR4kFhrNe+pknYWY5Jppc8DT
         Qbx3yxxQxQLXOWaZzx0mTWEQmhdu1Q9auV98aEEwqTKnSiT4cgPGUMibhaOn+AQBE+lv
         rDdA==
X-Forwarded-Encrypted: i=1; AFNElJ9WaSj/Nc/0wQw884hKeDWhgJ18nwMGcIBaUmVm68EnD7owZL4AwyAQjxCWSA1H346tAZqX7UQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiFtgOo73hTjwMiO66COSu9m69pO5fBUeFzPvQGm5A5XMMSVEq
	3qH442HCV+Ac4T9YepMN4I0PK6pxwlgrHiXDGJkq7QSjnP2q4JuoUQYi7dTQAqltq9OEV+Q9vGj
	fWF4nEKYrQvrTl5hbyOIyGAzk67JMOsQ=
X-Gm-Gg: Acq92OG7cy74CYmxwc8Tl96fkMJ9SmaFjf6fnVNdXEGw1DDeShHadAYYLZKB/CDj7tm
	HJPHPmh9re7boe2/tAKMT+i9hnTnhmkojQEhd0NohUbE8HxgguKbokHAPpqvY9j4np+TjrRhpXc
	J5H99WGMsDTjNmZ9e1VoaFwL/DNJ1SyBmLhhlmMWrECzLInHOfOiTig39m05HZbOeJcUT/eEcWz
	JYXbbpjfpzIcZTARCmdbtpP28aD4LTN320VrnD0wKrDjJ2kCN/ruUNn46WljQ/cis07b97I9Dzi
	qd4Uw0yTux8TNgpzGSFHVwlGDM0TJsDezGFJ0IfYGVn43t2FlOjf++FJjElLA0y5O11mKrcATWJ
	qccZ6uDkyqhO9xF8qKPv8bW4SkMYniRubLv1b
X-Received: by 2002:a17:907:741:b0:bfe:ed06:565f with SMTP id
 a640c23a62f3a-c05a591069amr40389766b.52.1781630780974; Tue, 16 Jun 2026
 10:26:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250322143418.216654-1-pchelkin@ispras.ru> <aisAxyXVxf4wql2u@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20260612233110.2-1-sashal@kernel.org> <ajBQPNuKCruxhkXX@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ajD3Gb-vQkGU0N6b@nidhogg.toxiclabs.cc> <ajFQPY2m2A6ltvTH@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ajFabPtI8UGfkyix@nidhogg.toxiclabs.cc>
In-Reply-To: <ajFabPtI8UGfkyix@nidhogg.toxiclabs.cc>
From: Leah Rumancik <leah.rumancik@gmail.com>
Date: Tue, 16 Jun 2026 10:26:08 -0700
X-Gm-Features: AVVi8CfS3ONFPuCMea8gmdSN-_pkFprQUMtGX9P4DftlzqFTx6aNlYFAra-1gXI
Message-ID: <CACzhbgS59uCYhjX80__+nPjEx=N8mKUsYyFS1+aRDpMA-b-VXQ@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
To: Carlos Maiolino <cem@kernel.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Sasha Levin <sashal@kernel.org>, 
	Fedor Pchelkin <pchelkin@ispras.ru>, stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	"Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Catherine Hoang <catherine.hoang@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org, 
	linux-xfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I have changed teams so I no longer work on kernel and I don't believe
my xfs maintenance work was backfilled ;(

On Tue, Jun 16, 2026 at 7:19=E2=80=AFAM Carlos Maiolino <cem@kernel.org> wr=
ote:
>
> On Tue, Jun 16, 2026 at 09:31:41AM -0400, Hamza Mahfooz wrote:
> > Cc: linux-xfs@vger.kernel.org
> >
> > On Tue, Jun 16, 2026 at 09:13:45AM +0200, Carlos Maiolino wrote:
> > > On Mon, Jun 15, 2026 at 03:19:24PM -0400, Hamza Mahfooz wrote:
> > > > Cc: Carlos Maiolino <cem@kernel.org>
> > >
> > > FWIW I don't maintain the stable trees I really don't have time for
> > > that. Darrick/Leah have been doing a best effort case for that, but
> > > again, this is mostly a best effort so we shouldn't expect them to be
> > > looking/picking up every single possible patch suggested for stable.
> > >
> >
> > Now that you mention it, the xfs-stable mailing list seems to be pretty
> > much dead (i.e. the last time fixes from it were merged into stable was
> > almost a year ago). I guess no one is really working on it anymore?
>
> IIRC Darrick started it, I personally never worked on it, but I didn't
> follow the evolution there.
>
> >
> > > >
> > > > On Fri, Jun 12, 2026 at 08:20:34PM -0400, Sasha Levin wrote:
> > > > > On Wed, Jun 11, 2026 at 02:39:03PM -0400, Hamza Mahfooz wrote:
> > > > > > Any idea what happened to this series? It resolves an issue tha=
t I've
> > > > > > hit in a production environment FWIW.
> > > > > >
> > > > > > Series is:
> > > > > >
> > > > > > Tested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > > > >
> > > > > Thanks for the nudge, and thanks Fedor for putting the backport t=
ogether.
> > > > >
> > > > > We generally don't take XFS backports without a maintainer signin=
g off on them,
> > > > > so right now we're waiting for one to do so :)
> > > > >
> > > > > --
> > > > > Thanks,
> > > > > Sasha
