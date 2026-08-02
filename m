Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F97B38F945
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 08:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785660194; cv=pass; b=LWS4Ljlrh8HjQ7K5O70u+H4BojpImu0uakR0XBR6XcMK57HMXzqGN/GVBNyKiqjEBjh+RKI3UnSCWHDoozn/SfFwH3k369iPbvCoVhTI/V02oGFDaiPtg5z6Pu1ryS3T0EgbIYyIdstOumrW62tEIO88xC+17AFRxi/EOD2GIF0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785660194; c=relaxed/simple;
	bh=Tm0k65FNbDrdx1vgSHrRVtMQQzAt2fySrdQkOW+gZyU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MkZp87JYB60qBrckOtepVLzjDAtaeZcskAarXrh6sCWZ43cK7iwHLXXXsq8XLjhmEWU60oJhZ5thncL/nHmO0QixHXQdPKxdKkAkS6dmsHbKRnLi4HKFNgAtHusJXl+E/A9nlCkmZ+O01UT8uW46tMnq5H1SiynBkOkplHxAKoc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qDA6yvDw; arc=pass smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qDA6yvDw"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-ca53979f8e8so260705a12.2
        for <stable@vger.kernel.org>; Sun, 02 Aug 2026 01:43:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785660193; cv=none;
        d=google.com; s=arc-20260327;
        b=ZDpKICZmD7441YroSt+yGiQwLnLqCL+gnsGoKuhSAAiTkUt8aBx+ERdRYbgyC8X5Po
         jL8krjyQhtQgXHdpaHvV0bSUjwXOIAi3hPdL922mdk2UxCg6nbZ8BSugAtlzArktpryS
         Xrfs4Px4pB46Ps3f+JDLnCIjMCEOkTiy6jwQYNi2zasMo9bc+4BC9JU5pJuIBDylBlgV
         iPBUTEDaABG2PDASL0TsDSKaKpSrRqAdRd7GuOE2okcFXUWR2IbAp2u54Xgc3miaSlQ5
         51RPPwvjXzczKsyOzrx6qZfrj0xfeQkTNdUSJQgNd1R7fTONk1BV2OIcoPgTNW80rm16
         JQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tm0k65FNbDrdx1vgSHrRVtMQQzAt2fySrdQkOW+gZyU=;
        fh=2DvBjbUoKrRYagYIznCeRitUx9KTyFT5mFIrteXXyg8=;
        b=BbmcbzsL8dZYCSoKioHDooNXTtLlROQwlk/eFUN1unXfBcDNdsMh0WT7xT8S/zvM4K
         0MQZkqJGowV4YWhT31iMYNDbEtBngbDMpUN8mNbNjfmYVvAb3JYe0x7dgJwiXMAJGU1x
         rBjrgjSwN8x/43REScBFfT8XUlebJJSGyWeXMOy4jDQ1Dq/8o6Ml+LbyjXizYXs6tGio
         j/TkzSveUNWJIIMLGJzBwNs8mdUgOJ/QUQLdgR1TJOwIGN3MgvhVLQR96Ra9X+I8CQx5
         KcJ8cnHiR+HLpfjvSxROTFtmPalUqBB9LgUXpXji5eC0DNUHjjWu0gWTuS3ixi2L43um
         pMYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785660193; x=1786264993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tm0k65FNbDrdx1vgSHrRVtMQQzAt2fySrdQkOW+gZyU=;
        b=qDA6yvDwpCzsvqh3IiJRvHEnhU4Fv4QC/PHie5BWbxzVCOTIf5HiLo8JGJ26UuG/PG
         q6Defjq5p5kf1Z1QSrAMtA8lp3tBtoLwlDBLqJQaAOrj8qvEQE6NLr0bhwLAREBXXG+g
         qEHrgLj+oAys+Py79Y/0xdtSuu2umajSRyY1JqNghABV7EqTTbbJxZDlsbt8a1nzJisI
         51ZTBhqHlme11ma7mYu+SYXHzLBG9bsgKUF2uk6fCmy9bljGq4kvrhakzzaQJtGtnfDQ
         vnrmbNK6W/fN504Bif4WXUpUzgr8xQFQX7FZ8ucwnCLI9D6kqNT3IzaQY6pX/FDqOjQ+
         zQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785660193; x=1786264993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tm0k65FNbDrdx1vgSHrRVtMQQzAt2fySrdQkOW+gZyU=;
        b=KdJ9B/KuUVxuw1iFNxLKwyjlIDN8x1vTj54YnNLAvWihGmXPQJA3DLvQA8uBQyiult
         EHcMvmaIMfaLG2AabnGLXrG1N92/SWLeHisfyytvwHgfLfgo2tzMdApC0yHNqEfBRrvd
         bA+1+9jtJRWl9D7um04G4DjQphUbXPol8dWfIAv2SLTMXfo7MXEEHX4a+kbh+HV2K8dp
         rmlafL+T+HmZw5W+cpjHONUOFVkzCoK4hd+a4JwyQljSFeST7LwFp3jxRwhPLHY0QteW
         1y8qofogD+6EZAC8SwLd9q3C5ahT03Swx+TsK4hdCQ1qMHZu4uVlfMVWa24krHWDcLK3
         ghJA==
X-Forwarded-Encrypted: i=1; AHgh+RrfQJ+xyiK4do71jjuWCDp6tCe3/GGtEX1cQTeQtdzlbfmrXPVtb8z8XFgiNnM0D0zll2dwf84=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLFOW2Sie/O1SDWw+zSf32+0Bwlo0P2cL8g3GGDs+wxj8ApbNk
	zRmGC1x6anHsIwlw+vlyMOXMVgdw4/sumrUm5bFXqogM/S8y0tJWrl5uQSLAF65hl+iDLEhw9ED
	YNx5QfK6HGGQrOVFFfLDj1Hx81l0dLSc=
X-Gm-Gg: AR+sD13cEv+qitKlToHdHIAVJ+5O7ma7hSOZbUqYqw/Kb9h4+HJU4zwWwvHNSXtjKYF
	YjaXQ1kH1/AgH2haKFjQK7jyItoL1YcIXOMwwqKE42acksC6kHhr2GZ6noBkFLiiSFX4MrXPJCs
	trGYYV/x1iducbrooVwC7qv8VfCipkVaTfVt0gWOEs/GX/hhUaz2VWD2nAyYUjN9YBSNcTvTA2s
	6wpMKsgskehJtr9W16a6M2CqPV4cdEpOz4DR6tyQ2zx79SrjAakHRlkkfzxhYZP+8Wgg0jDzQDW
	ZBvThg3dv8xzM88H5Lg7893cXpci9c2DsKFWH9ck0G8GXH0b0UJKthK9Fbx0jA2KanxLUO7rxz9
	Dy9HpyT5jOTqfHOcYYrsMdMr+ZdhRlvF29uzXuGzRm8QxjyD1iR1hEDIylVcx
X-Received: by 2002:a17:903:1450:b0:2c9:d298:6c0a with SMTP id
 d9443c01a7336-2d05246fbb8mr88691875ad.2.1785660192824; Sun, 02 Aug 2026
 01:43:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260730181717.95457-1-ojeda@kernel.org> <20260801154223.stable-0006@kernel.org>
In-Reply-To: <20260801154223.stable-0006@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Aug 2026 10:42:59 +0200
X-Gm-Features: AUfX_mwSyBPjd02vvZ_CgqaO3HBOLCgHpt8D6b_pNGvF6OI_s99b49Kz6LgVuPc
Message-ID: <CANiq72kS0Ym1r5oEYcbhUDXcZ910YERpV8m3o06ebtXay52iWQ@mail.gmail.com>
Subject: Re: [PATCH 6.18 000/675] 6.18.42-rc1 review
To: Sasha Levin <sashal@kernel.org>
Cc: gregkh@linuxfoundation.org, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, Miguel Ojeda <ojeda@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 12:13=E2=80=AFAM Sasha Levin <sashal@kernel.org> wro=
te:
>
> No, that was not intentional - part one got squashed into the part two
> backport by mistake on my end, which is also why the `lib` removal has
> no commit of its own to point at.
>
> I can revert and re-do if there's interest in that?

I guess it depends if there is some advantage/clarity by doing so for
the future for you, or maintainers, or people using the stable patches
etc. -- for me it is fine either way :)

i.e. I mostly mentioned it because it seemed odd and other issues
could be hiding, e.g. maybe a backporting script somewhere had a bug.

Cheers,
Miguel
