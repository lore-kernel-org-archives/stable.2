Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499294;
	b=uL0u4ExMekzv3oct0LzJ2AN5+v4/DVQuwg/bsiWR8N1ecFy30H/a1XtO6UMwHw6yvI/c
	 Bun4aLlf2Rh2XJNBQMDg0h4qCDmQSXFGQycdvK9TP4S1vDCAIEWO932IwI9pfs0p07Muq
	 miPhs2Jqw2zmnKLubUe7NyWNqEJDsU49SRPAsIfqLlee5o/Etyh+0JDwwZAOppfPxg/nj
	 EmQc3fDl5mKCIIdLUo8o6vvQNGs/0YOvUGdKJBvg4xK3wPW4qpi6r9UBtl3/97/2yjpKx
	 RwpjN8U/emhYtI44cp7uv53I0Z5QBr+HGa9t3feNFBtg+eWPFSwnW+CGVCq44FdcWiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499294;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=LRZGThiFHzP97lut56bvREDESV1Qmk2kVp+avLfzOBM=;
	b=yIcTkv/iouLBugF5AL0sFT+GfcYsGKvlv/DAQjKyZQxbTcXOGGyDM9EuA6pYejQ0Xr8C
	 IUkfONJFjlC/nsgBfwdM4TEsCgmdHEp9Ue/yGWdPEKfwJuxrHzX7THHD1gcIGOPILOJVk
	 19IEEdLVU8hmB5x+/nN5C4dm571FUsS0IDjDps+Kda+m7nyoyLdddjy0Pzh7Ye6CY6fSE
	 kLHnsj8M9gyZ0IcdvQfZBUQZhnhGGJWV3ZQonQeqKoIuoGeSoVEAnGasSvYTcMq/xomTL
	 iPdoDq6jYmO0kfS5s79uCMEJgi0Oq+eYduyYOmh9Pa/qOg8Bt7ul2MVoNdXVSfnwVaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3uhWFhG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552C7606A32C
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f3uhWFhG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E88521F00A16
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 02:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793499293;
	bh=LRZGThiFHzP97lut56bvREDESV1Qmk2kVp+avLfzOBM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f3uhWFhGMaR4KVYXrT0ejlBCi2I1MoYeBHWHs1tyi22EM5v4iVDBeW+aaTVRaYAyN
	 s+Oi+kj0PFYsucC70PRkUB3Yj0oD1x0OjuoPvGGVrcLlzHY7KfxuewDlmhe4DBGbYq
	 GWhm/8WS0Az0MKJnif2hyR86D28nM7qo/oebGNzgg/98t6Ymn3RWmFO5ivj7/96Yw3
	 4jUkcNpHJLs9D800NqlPL0cqj1Eucdfw+Dk6FkiO7tP1u3Ek9b9M/tWyofM1xAkKO4
	 gqDE4JV3K4fW1S4EZUyLL+ZxeapyGXsKnr7eMZMTxSEjP3xR+jgu6QYESlno+GioH/
	 DAISOZrGiT2oA==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c2e8c710847so265624366b.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:14:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwXUosMa+sNs5eyUmIB+90o3q1Phr91G1xR32U8s9/n+BgDyc+a5IjQTwsKCPbB2i4EAED7fIw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ1O/j2kEMhcG//8M3y7dI7X4h4HCGxADGwYQ5TXG612OTtpgch
	gWeMrTOdfgxMS1dhGVNraEmfnQa2VTEo1CoFNcqQBk5DsatSIMYT8TRWlbLj4vwNLG/6H8f+KFl
	5ZQ9Czrd0fTHeUSVtoJbicd7i00Os+Ec=
X-Received: by 2002:a17:907:3e20:b0:c26:1649:47a5 with SMTP id
 a640c23a62f3a-c4ca7a9b0d6mr546901766b.27.1793499292617; Sat, 31 Oct 2026
 19:14:52 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031222823.223-1-dennylin0707@gmail.com>
In-Reply-To: <20261031222823.223-1-dennylin0707@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 1 Nov 2026 11:14:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_NYXmW5q3mu8XEqa89qanUBdPMkPND7y4Fmu1Uk4OhxQ@mail.gmail.com>
X-Gm-Features: AclHuK8EOzubb2Y8T0Qz305hPjjSLNWdRK5WoX_toeVCEh0R7XaINWPYpnkgoYk
Message-ID: <CAKYAXd_NYXmW5q3mu8XEqa89qanUBdPMkPND7y4Fmu1Uk4OhxQ@mail.gmail.com>
Subject: Re: [PATCH] exfat: preserve the 64-bit FITRIM minimum length
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 7:28=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com> =
wrote:
>
> The FITRIM minimum length is a 64-bit value, but exfat_ioctl_fitrim()
> uses max_t(unsigned int, ...) to compare it with the discard granularity.
> This truncates the requested minimum on both 32-bit and 64-bit kernels.
>
> For example, fstrim --minimum 4GiB can trim smaller free extents because
> the minimum wraps to zero before being raised to the device granularity.
>
> Use a u64 comparison to preserve the userspace value. exfat_trim_fs()
> already stores the minimum cluster count in a u64.
>
> Fixes: 654762df2ec7 ("exfat: add support ioctl and FITRIM function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Applied it to #dev.
Thanks!
