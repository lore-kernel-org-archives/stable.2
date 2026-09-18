Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BF7D3B19A0
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789696074; cv=none; b=qhDjyOXIqcDWTfIclRHTYFHtAy68LmAADgVHPtIO0YbuLE1FGjWpbAmFxSFZVPuZ5MKY2N0ZtFCFDE0Yg28eGA/dGrKd3PEzuRwiExX4pmyfFBGdW9s7MtN4PKhBSk6wBZYRYjUDsubvZfgBd1VrfgO3MV0cxR4ISllMXz0ZKRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789696074; c=relaxed/simple;
	bh=bo0us6OOCsoIPB0dLXszuBqVD1dyZWkMn6r0/aJMQbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svWiezEh5DG1giOBc/9qJz5qJuU6/Rdq+2/nDfQJsTJKFmYI4RA9x57xR1aFOHJlMTcJSMkJY6rsGtjO3QDYetJkk3dS9o9xrWljeItvyrAEHIpSfaNAZHdEcwTu+q8jfwOw50mUE8ObszO0/cTCVLXsIYbWw+OSUJFbjYix9JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewEPOFJi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewEPOFJi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B52791F00893
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789696046;
	bh=uX3+BImbwHE/pofi6qjlPrbFrgViIsmcfQSKC7nhXsM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ewEPOFJiJSqT7Nt+Hn1onOzvYRxqU3L85buD4/vssymd+tTs61CZ8b26p4y5mU4vW
	 58ifLvbFPnzrSicZF/77GUZ6yx6cF951Msg2Te06W82ILZChj0k+i78BoHwV9Ttb+m
	 EVlF9/tdghVZ2Wi3cfcfoVT7hvFMRGCTWeTqxTcfkQ5nW0m1SBqTtz7V+pQq8aekal
	 goYj3KFtk938qPcLQj9NGu7rfnChFKWz7gtBWd1gU9I+dMd0C/ztp3AhT1nBn2dGiV
	 haxUAavSmrsSiMTN9UVCeuNajvhQAOpB1z5mpZb/rWRfJTjt2sHgqc+iHF507o4hVA
	 ZFz4atZVNXABg==
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so1745205a12.0
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:47:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzULwh4g13GsOY62sk/JEr2EaxHLjtE+AmGRJeBRpts2sUhQtzJL1GAl9vzAaqBuw5cEvfNJNY=@vger.kernel.org
X-Gm-Message-State: AFuF++kMZoXzTTzO/TcSeMOhI8Xsv8VNbbMv1et4nWSj0F3x4CU/bjKq
	0xctI4f6YNaVdKV+BRbqe2Eb8x13554Rhe823Xdbegzsmo69+N0a5ckF/bLuRU9r10ZbA9TIUMJ
	1HRcNMt4/eAbdEj+s88bUPgUc4vSx+Ec=
X-Received: by 2002:a17:907:3f8c:b0:c29:3909:6555 with SMTP id
 a640c23a62f3a-c29f525c3afmr503955166b.10.1789696045351; Thu, 17 Sep 2026
 18:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918003327.2539470-1-sorenson@redhat.com>
In-Reply-To: <20260918003327.2539470-1-sorenson@redhat.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 18 Sep 2026 10:47:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9UW34G21Xr6kUArCGsKUQZxz7ttkuCcdE9tVgyXNWTNA@mail.gmail.com>
X-Gm-Features: AcwNN1W6RI8juVgww_TdfbAJ5KgWMK3PXfwfGFNGRTmh06RyL3bJFupK3v3Y474
Message-ID: <CAKYAXd9UW34G21Xr6kUArCGsKUQZxz7ttkuCcdE9tVgyXNWTNA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: fix potential use-after-free with TCP_Server_Info->hostname
To: Frank Sorenson <sorenson@redhat.com>
Cc: linux-cifs@vger.kernel.org, pc@manguebit.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index dea05aeb53a1..bb30cfa156aa 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -173,9 +173,8 @@ cifs_chan_skip_or_disable(struct cifs_ses *ses,
>         unsigned int chan_index;
>
>         if (SERVER_IS_CHAN(server)) {
> -               cifs_dbg(VFS,
> -                       "server %s does not support multichannel anymore. Skip secondary channel\n",
> -                        ses->server->hostname);
> +               cifs_server_dbg(VFS,
> +                               "server does not support multichannel anymore. Skip secondary channel\n");
Since SERVER_IS_CHAN(server) means that server is a secondary channel,
Is it intentional that this now logs the secondary hostname instead of
the primary hostname?
