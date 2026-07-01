Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3B940E8C2
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782907640; cv=none; b=dXdP94794Fmdqfy249pt/xgPkg1ugPmkKcWPMFoLvkJE3NNSmhRrnsyk8GInxFaAs/I4nO9JSgsdhNTYEVaE44qkO/q+92LUuOtD7H+wgDvksoIidDo1xAhUXAwZJM656M0KsIJVeek4sNda66887yCUHNdNUpfXNGSNuJwMnCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782907640; c=relaxed/simple;
	bh=wCq64Y0kRtiq6eUMljgSMSNHwXvckxrEO0Dng1ooNhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D6r8RWoYHPAxs65SbqBeR5WNvbSEfvVpe70TvVt/+9u0cUi95z5Aloz79/MzKFTcMrmBt0r/c42Xk90GdR4bo0nIICd7PpmwIFz3z2vH4K17i0FM5pP8gr8TFFmEWCGhW/c63JpNy3Wkn0/iI0G/dXQDWU1TBFku0zneH228h8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KDQHeo3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KDQHeo3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE5021F00AC4
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 12:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782907639;
	bh=oDjyJOhVV/DIa1FT4XMf4XzZgQ7suZF9JyO1C4a9jok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KDQHeo3/JqLVFoCitCzp6OVzHHxgCUuUBL2Z6ca5N0Vb8LORFgCSHBQbMDE9411s7
	 4cvdbRNJd2c/A4u/WoJOsZG/FuDcdo4cEuLGHUhbptCSwACwGROKFyrRhM6nDGwx9a
	 v+RVNKovVutgVgKb0Os9ycLKQ4savFgbyqZE0Iei3roaVj2HddVeEq6dRrjeeN+Tna
	 ITZ/Wdu4k8kRScrTTtEo0N0Gz7ulsesWzQOkUgFrPhpTXkJJnl2Z5hv+XDjmYY5yPq
	 tIq9V2Vz23Bok7Ou1rJ++ylTjgrEMaAbZv07xv3XWf2ISlqRN9pcGnIlIFJMEBUx0P
	 DnVh3EJp1Tdag==
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c126eb4e228so79667866b.1
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 05:07:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrhw7E6FkLuHv6drP1xvwDRnZTZMtCleXAFspe4baIHPLsDS2PpiFMp1jyZHj0dfqHYfdZDUFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy41Xdv03yMIEkQuHah09gDOFD9rVy/dd3FhD2is+dkioJUR4oJ
	ll36V8+sMmW8p2GWIK/znNtA+WQpdNPyPcVz2Haw3E2MpnTXaVEP8aCLp0BrvpQdyiPiOF+N/tp
	cq+N2AIRXnRKAOFGYT7W+bC49YRjd15o=
X-Received: by 2002:a17:906:6a27:b0:c12:4e0a:458a with SMTP id
 a640c23a62f3a-c12aa39aef2mr66605166b.63.1782907638561; Wed, 01 Jul 2026
 05:07:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701074233.67855-1-zenghongling@kylinos.cn>
In-Reply-To: <20260701074233.67855-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 1 Jul 2026 21:07:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9dak9xFPVt7q=WnBJ8wRD7ohUsXREJTzUFhbjL4SJq=g@mail.gmail.com>
X-Gm-Features: AVVi8Ccj17gzZptYQI0HPoZznvfuM64l2h-LUKu162Gtj2-yzQVPUp1JzPhc55k
Message-ID: <CAKYAXd9dak9xFPVt7q=WnBJ8wRD7ohUsXREJTzUFhbjL4SJq=g@mail.gmail.com>
Subject: Re: [PATCH v4] ntfs: validate error codes from untrusted disk data
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, charsyam@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 4:42=E2=80=AFPM Hongling Zeng <zenghongling@kylinos.=
cn> wrote:
>
> ntfs_lookup_ino_by_name() returns MFT references read directly from
> disk, which are untrusted data. The current code extracts error codes
> via MREF_ERR() without proper validation, allowing maliciously crafted
> NTFS images to trigger kernel panic.
>
> The MFT reference encoding uses bit 47 as an error indicator, but the
> lower 32 bits can contain arbitrary values. If a malicious image sets
> the error bit with a positive integer (e.g., 1), MREF_ERR() returns
> that positive value. Returning ERR_PTR(1) causes VFS to treat it as
> a valid dentry pointer since IS_ERR() only recognizes values in
> [-MAX_ERRNO, -1] as errors.
>
> This leads to kernel panic when walk_component() =E2=86=92 step_into()
> dereferences the bogus pointer at:
>     struct inode *inode =3D dentry->d_inode;
>
> Fix by strictly validating error codes: only accept negative values
> in the valid errno range [-MAX_ERRNO, -1]. Convert all other values
> (positive, zero, or out-of-range) to -EIO to indicate disk corruption.
>
> This prevents potential security issues and ensures proper error handling
> for corrupted or malicious NTFS filesystems.
>
> Fixes: 1e9ea7e04472d ("Revert \"fs: Remove NTFS classic\"")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
> Suggested-by: Namjae Jeon <linkinjeon@kernel.org>
Applied it to #ntfs-next.
Thanks!
