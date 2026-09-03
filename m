Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCCF4CA787
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 15:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788448532; cv=pass; b=uWvejntCFA4ouNeAk9zCL5cF0W0/m6/0K5rrVvdOt9GvOBQpvNslfE2cFJYGd0NTQFzkVrIzvxxbSqAhVlMTOcHj9VXM8BKyhRFNI9bfkKY1fGBeEGR9hQBxs25QRQ2lWGJANvxVtMKuLqrVV/qWXVCYUy9N8v01n3TJnO5ZxaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788448532; c=relaxed/simple;
	bh=TKkqqKfsLIufXcIpyStI2HAmbZda2xPcfgdQIz8tzUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BHgS0bO/wnujGY9gq8RazXdRdBWvNT+Yr31aDJ2P/H1AksL0u9nmbtMLV8lNRGIeSxrBGHQqqGgCE6+Ho5dNWrtEFwj3sseny3Cj/IkJNrTCpSiPAcy5vAja4cSOVicf4LcCs7f9YkFVDrFv+fmk9q8NsZ6Gej1gIXmaPg6wxdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c+eSt7FE; arc=pass smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c+eSt7FE"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b9f77e03so300213a91.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 08:15:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788448531; cv=none;
        d=google.com; s=arc-20260327;
        b=qVFpdYSyZsBVdoiiVCiNQhwAbdU/z9R/VcW++jQoQ/HQvZTOpZWW7bQyPW/9coa7Am
         HqeNe0ZAKbRulQ3enf87jhy6yg0thYg4Ydp5qLfopd0iX6Ocqmaw0DaiGwqQiwhSdvwB
         Z6Wg/24o5Namtvb6vjC+HxOwf+7wvL3BMgpRzCVIhJBUasCAHvAOXLZ6klssATuS1Aaq
         WoRHo91/NxdC4eU/hYQ7Ib343ZehGaNJs3msm8iY344G1uVig/pBhcRy6k4YS96/jauY
         PrQkpCBGLDzmCuogFwWHHcEUbBcyNIRwdFa7Y4IjI9TYl7RvDiKZvM0EsLiVR44RVpZc
         C1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TKkqqKfsLIufXcIpyStI2HAmbZda2xPcfgdQIz8tzUE=;
        fh=ZXH18aCZj7OO1l//4N7B6hPTg2oFZvRPQM/FrAh8Iac=;
        b=NAG/4d+JuSAf47Fxj88A9LOtaJ5CuzBlqmp/lkzeeraCvONy4YPMoxGNdDOohr82T+
         ISMnmY6rhQ7gp3UoVArvTkShf7cL+52L2j/2cYZDIa7tE50Z4l5hrIsgkrNWVK23vlhJ
         dT70ligceNF/NopkEz1cK5AhFxCJRwdA7gFkMmTn1smYh17ftEMBn+vmHzvFJ9dkzMZ/
         LSfebRr7x0e7Po9cltfG2cZ845xo8XlQJ7kHYj4FdfeCEaJ0JNV9M4uSGbHRDrRWUFEY
         tpH2nSMOOCThi39FWYfbvPaHvkjwkoujpcxPGyQ4pJ3HPKUViUYxULJ3aApCg4iCBOB9
         2v1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788448531; x=1789053331; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TKkqqKfsLIufXcIpyStI2HAmbZda2xPcfgdQIz8tzUE=;
        b=c+eSt7FEmp83nWo3rKpGPM8cSdtmh1Cjg/aKxjG7NWw17y4tEI/w/pnAmlQ+EZLoIq
         811tPsXvovliG6zAPAj7KktaqdUYQHZZanW77is8BLGsARyzNlKCKbayuXawPEfm0y3l
         tRTmX3GlvOZvnd05JFcjBrx4iGEyiwvbVsEZm1VvD46IHGzjX+pKaYXRK6w3m3BVL1zl
         m9atK5Dugl6aecUTOsKxov3JwF8NSOz76pR51UW/hIKLGqnb0mMcauiXwcgSoLYZUzHQ
         yR0ZwylTfW5pjffz6Qd+2DXPts2w4pNsXtWZc0UB2mzFhnE8VphEeEWd/4YQxIWURWiT
         rnfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788448531; x=1789053331;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TKkqqKfsLIufXcIpyStI2HAmbZda2xPcfgdQIz8tzUE=;
        b=H3NoymBstZ/AMEHPKfM8ALZmNh1V1lOasKb/0mahpfmMr8qrgsaDWuqmnhTRo1tGS3
         XK8EmxbMYykoF9WEsCNV+K+NMjBrbGCxCXyq+h7i8oEmpHsut8LF2YV2vJaYxL1hOxSj
         FvnusBgPad22BuCGgRLzmmlfb+KoAtL9bag0x4eVPReVfLlB5zdHhiOS6OgDtP3jkvrY
         5gguVt8ehhr9Sq7FoqU1YFmzfkgBAPkeQGWB4euRWvfDgxpAuD37xEU5cCr8NuRaKEvO
         BqnzpL0eLVxqXD27NyWuIHVmM7qyEdZJlacJj0Z2a34KHsCVqcpOjJDoOWVxs4RLgNSw
         FMXg==
X-Gm-Message-State: AFuF++kBbyPhj5beWxkUPz0hRg2Z8jPuerJgK1mjya6uPWZ/THf5nko9
	WhTKk4U6s+2HbpQ8XQV/hNjFvXY0wqPf0MgxD7+S/ruJ8fFTTdIib8QnAXOAG3vsy7msPz8Gjve
	Jp2sEYKOqsCdB0mV0qe/IXA2NgR9wLZ0Z4PtC
X-Gm-Gg: AYBFou1TSn0zfLaKQKYAPei/ab/qjGEcChEPT5AL8ONWl+Kc0gEXTK9lfWBYGzZqEle
	LkR2Bsu+mWjMLWeDKwJNOAtUkS4Rf+kYc5u/376bgGpasStWKdXY84tgTh9Y87SsZh4oVD64/1+
	baV/VNU+YRAG1CNUrlN2Vi6K2YJW5WACuScqgCucPlQd3BOQWE/Fcq7yxvjP9km4m59EEPJxDH0
	QBO6ldgAhk9ggviRV89Y5+nMEoMSuLglsFiK5DOAPx0wQYHpO9N+05imo1sUHlSzXng2fvaIMfg
	sg+62/KUFktNRQAEIThgPDbzsTnqN6wC190+1MeUCglTD31D88pwmuN9GkALh2LK4BYWEy9n24z
	SbHHxzQ4fV2jVwSmkPp3CVJUgiGnv2gOhQEhSOQ4GlYgpt7cRsIfOmn53UNMn
X-Received: by 2002:a17:90b:4c05:b0:396:463e:2eeb with SMTP id
 98e67ed59e1d1-39aedc2cf4fmr12232692a91.0.1788448530545; Thu, 03 Sep 2026
 08:15:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090302-mumbo-scorebook-4564@gregkh> <20260903133614.760808-1-sashal@kernel.org>
 <20260903133614.760808-2-sashal@kernel.org>
In-Reply-To: <20260903133614.760808-2-sashal@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 3 Sep 2026 17:15:17 +0200
X-Gm-Features: AcwNN1VA7iUDcSbq0xofbKDfPizy63wLefei0z9gQSsn4C9TE-raUvyGl3pOkIc
Message-ID: <CANiq72=AvCa-VCYW0_nhx-TLDNRv7hLh28O=o7dFt4wPoT3XwQ@mail.gmail.com>
Subject: Re: [PATCH 6.18.y 2/3] rust: rust_is_available: remove warning for
 `bindgen` < 0.69.5 && libclang >= 19.1
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Tamir Duberstein <tamird@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:36=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> From: Miguel Ojeda <ojeda@kernel.org>
>
> [ Upstream commit ae64324ad5c1fdefe479d77ecee975bc6b37467b ]
>
> It is not possible anymore to fall into the issue that this warning was
> alerting about given the `bindgen` version bump.
>
> Thus simplify by removing the machinery behind it, including tests.
>
> Reviewed-by: Tamir Duberstein <tamird@kernel.org>
> Link: https://patch.msgid.link/20260405235309.418950-20-ojeda@kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Stable-dep-of: dc01dfb37b34 ("rust: rust_is_available: warn for `bindgen`=
 < 0.72.1 && libclang >=3D 22")
> Signed-off-by: Sasha Levin <sashal@kernel.org>

No, this should not be backported -- `bindgen` 0.69 is supported in 6.18.y.

Cheers,
Miguel
