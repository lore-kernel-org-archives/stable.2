Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FB232FA29
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 20:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782849804; cv=pass; b=m3vG27oBWoYvcMX8BUOQm6UkWfL91eoVNX0Ageipf573TtEFoXVZLGCUxgfyrSNIvaok7VyUbebyOR0CyoD8qeKGAg52cWtanckQX6FFC4fYkBvrbfK7VALrhSe94n4RjX3xI6Qcl2VKJ4v9zKi26JEzIHzXTlln8cmh2N2N7TE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782849804; c=relaxed/simple;
	bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1UmARmu0wMMu79I+jeQNkF9OOarQscmdDVXOU+d2b3xrStUKivXpd3BNaSppnBRIMfqxK6mMQ8xc04TUYLF0Ridz5+4iQreUle4kyESnuMfelF/mlBGXKoYAtfYohqyEI2VJaSXDai7NpxFpvuf3fbOsSr3h8E4W91paMk3/dA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AbFdP2Tz; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AbFdP2Tz"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c126eb4e228so281351766b.1
        for <stable@vger.kernel.org>; Tue, 30 Jun 2026 13:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782849802; cv=none;
        d=google.com; s=arc-20260327;
        b=Ebl1jVSJhhn0FCU3IPth2tPlpFdkiMoAVU5IUd5cLZZc4089mHZ3qCXd47Uex2k7A4
         kqPAZqzb4G6n4tTXRGPqSdR/8krLTGwJXpbJ9mOnjZtIwCvn8sWs88mcVNIyjQhtlx+E
         kjgZvjfYqrKQZxRA1qAEQuuqu87p0F3h+0Xju4Ck2MMr1nWPZa2cOaMI+BczYaorFGR5
         4nkU3E38lL5/bbHXtMkOmPm3xWbzAuEPdnkR+6CCIeId3ml4LEqb6C/0t/ZGrUKi+pjp
         mmEGSpyLDm38njnIkAo+wIuxHCSD0pHi2gE2KtJRZVRbOI3nlXs8YPKRF/C32e39sfh8
         N5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        fh=bo/GYPNt+bzQAnorBgCF6aNe9f4SCE03QQPUo+2XKzU=;
        b=UVtKpm+W/5F/M3L1mg6KR/I6PQ92G5V0exg/tiW8x65hPtrhq9r4MYy76t8WxSakZZ
         9402y99TsXaDp0rydodBkykYIphuFOQTCjCHqg3YdhjWnRIbIvNa1/DIzXRpqwZCYW3S
         9m6/Vy7QFmJ+jDx0p5pQU8wA1GQxyBwUPg5fZikO2uZtgd3wxem10Xm2K2fKNFKVznOQ
         HWn8PDl81AbRkqFIUP9d90Iu1nlHDTMGo7j8NaqetV1l+9o633GAkN3OV36zwo8NLZOP
         s+65mhd13/Ot7MnrZuJeCMkizzkjrORiVd2qno2rtkqDfsCoKURDQSmx/VficewjkF47
         20nw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782849802; x=1783454602; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        b=AbFdP2TzeJDu6cHqaS9LfUCIwUEOUv3qAoQthciUEyzNb8YVH6B3NR1rGiq8FMsNtn
         OBEBbjLRZ6imyi3BHK+fIHFY+M2epyNLx7p37C2CrqETNpVwxcyWuz9y8AOsV1cLAJic
         pf/ctRjvC3FkKF1BTYxVSAvdhrc0VlGK2pU6BYkTzMvgLwfFXPEVhSRN7wcU9ORNvy5z
         /fnIqzDTrbKYSCfeXhcuIVX0UshrNwefvBu/pje6wRplZP7ChF+Aai11zfxvhy0on2Kn
         9DoC22i+hu7JPnOWrs7JndHP3T847qdjRoHFKFEg3LHKOUFAYUPsfl8Q2SqDmaGbIfvo
         Tl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782849802; x=1783454602;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6pZkn8yd0tBw8pUiMXIn3KvoMZ8dCgnbtEbHZJLb0y4=;
        b=Iep2/PJb8vQjfuexfecBu3zNpX91APAjiUuIMIlR1jxtawyCmcFCBl08g9tL4jZT/y
         vOVZLKYHCPZ2Z5igIuMJiLFlwC1NKOkXBgn8DL9QqIPQUL1JoDCkjzbb5w4jGiYG9koh
         ft3uv/+xY7+M6hQ81YtAWWezx7ZwHapG9XujQxpyS3+vk861ZVFtsXEHUR+5xi3AQaTe
         GLYDO7N3ksU85QDCnemtSmQaZjxDH7s7hg1KulFNMmkbbKfhjNITKpUmaY6CS8sMmMeQ
         KRWpbiY39JvtjDMUelbx1m7am9vXs4u66j2bxpfY5te7pSki539fCEJVYnHbaFp49KBo
         mETQ==
X-Forwarded-Encrypted: i=1; AHgh+RqdrGJoxv3H6YgH74snWo/mVMs5xTnndt36cp/Z9hqvUM6rE7R/eE/E0sUFgmYJdTffipiKbl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOgMUb3wygSPwJPt9qlyXMd2MKnrfTCuPWwrT4CdnBo4fJPGK
	4WoQRoiCWh1wbxmM7BXY7ZaFJTS+AUQcuKuiA4iQN+EupKsOwl9BjKQVPVrmGyCvD4ON3FShZDJ
	R7AF2oYZioOZsVpZ8L3CJWH6tbi3Sh3s=
X-Gm-Gg: AfdE7cm3+Hz7ZlKZHYIVVkrNjJDwzUvcKh6q3DJpY6WYigGS4PryMUypeAVEEZQ5pqk
	QQk3lyqmEHeFrkiRtsqLw7wZeBTUbdy18ryDaFTVpuemF6rUBLVqrKA+SBUpadrZF9BkR3oXXwJ
	PWyJxH9B1Hb/K6ewZxugGabN30GI0sArG/N6zydUPbu75xCKbrKrHhNIskFVtOn4BAkEiG3K0TW
	VsCXsluOlDC9KfNlP5KygJAkboG4QMl7KB8FvvMyC5HqQp/u1xgoiCi4+Ux5SE3XdyzSEU=
X-Received: by 2002:a17:907:720f:b0:c12:3219:ba1e with SMTP id
 a640c23a62f3a-c1297f04180mr105626766b.42.1782849801564; Tue, 30 Jun 2026
 13:03:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org> <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
In-Reply-To: <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
From: Ujjal Roy <royujjal@gmail.com>
Date: Wed, 1 Jul 2026 01:33:07 +0530
X-Gm-Features: AVVi8CfDECdiCgzhQlx3_wZFTGHCy6ydmcO-9SWK6-jb6Fc7WwdQO42bD5DVouM
Message-ID: <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com>
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
To: Sasha Levin <sashal@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel <idosch@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>, 
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>, stable@vger.kernel.org, 
	Greg KH <greg@kroah.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Ujjal Roy <ujjal@alumnux.com>, bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>, 
	Kernel <linux-kernel@vger.kernel.org>, linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 8:20=E2=80=AFPM Ujjal Roy <royujjal@gmail.com> wrot=
e:
>
> On Thu, Jun 25, 2026 at 4:12=E2=80=AFPM Sasha Levin <sashal@kernel.org> w=
rote:
> >
> > > Please backport the 5-patch bridge multicast exponential field
> > > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > > e51560f4220a, 529dbe762de0) to the stable kernels.
> >
> > I tried, but it doesn't apply to 7.1. Could you provide a backport plea=
se?
> >
> > --
> > Thanks,
> > Sasha
>
> I will create patches on top of 7.1. But tell me what about all other
> stable releases? I have to create patches to all stables and how to
> share the patches to you? Via this email or any other process? I am a
> fresh on backporting my changes to all stables.

I have prepared the patches for stable releases mentioned in kernel.org.

And I am waiting for your response so that I can send you the patchset.
