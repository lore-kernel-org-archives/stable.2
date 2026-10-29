Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793261706;
	b=wAy12uh/9YToWrKPc1rWapSwKh6LXv6bdtyfjiYDWrhyJcEKupVOCHyf9YVp44K9Tjo3
	 jr0Vev/vDil5MQBen6GGocPBs0TgJ5iG7rrRC7730BajZgyL1p7zytxfzsHZD6KplxyTN
	 dfgvP2YUBeJwISDZcu86bT1XFYlHWoo9/Cm8VyUKNFzOE4m2wa8meNM0xhKNWDDUlEvtc
	 AvjqpZLEY5Rhq8oyvxLBtE8nZTr1UUaxsWuvKMm92pewQmPTPcR2DAU1My+efwElOwk3/
	 FfqJxZy/fM6aWwQ2BKc3+f49KK89q2WqlruIEVZk/L36WJabQ+EFKOvoDumr1G7sBJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793261706;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=yYObwNH+TIVb9QisRlkuqPGqCJm2+m3teBi+a2YdMCI=;
	b=sIooNWNvGHwUSY36P8elabisiez+3zlNeR2+yFc1QtXVOTg90gOwLjt+Jc9SEm8qKPlx
	 GVBGv1TujAdKzUsZgt6QIYVhkO1dQbg2Cpx5BArEUGYswOJng3HMvU9mehhlCoGyDrWz7
	 zO04jPHcQFzMY9BYpDhwmvtsm1GgzWA2PN11D8TKodclR8eco7CL5INX2nzR9fCuu9t6H
	 jpuFtKL13j43mgOqvQvpK4bngBw/o6Izna5DlcI4somsaeeKwFRPa7RMDo/NprwNzFZOc
	 oT7iI00IFdnmZeXRrAZqha/Tgnh64wjcXn1Vd0r3lEtbmIIho42tSDTPM7RJf6PZeeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6uS1VxD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11AB606A324
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d6uS1VxD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75201F031E1
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 08:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793261705;
	bh=yYObwNH+TIVb9QisRlkuqPGqCJm2+m3teBi+a2YdMCI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=d6uS1VxDtAE1nEpXR8bojG0FSljbs5S1DQb2K9ykGc8AzU+v3S/HEFCHUgHHZ6c0N
	 Q9fo4LWKfh43Ue3TYpDFAGnzYkFnpHRMN5ZMlJqagosj4eFu/NxGbRlDTNC4PXUT2q
	 3EXmcMscL964xIxFdPcvVituqSegsDWE8ABxCWZmJaR3+vG0YiTaHnIpTr1+0w34zq
	 Pm0ONZ6Nl7gSCcX/WZ/PDJFWyrwLS+vcjSbfxbt6+jg1ulevmrDN+QCtNWAYoQZmpS
	 hkwQQqbMpNZnzee0MEOTDm+eJaCOs009VAgQNGO1Ceb0bYYK4TJzWnYKWufV7kc7vy
	 T4qrbnEeryS2A==
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c315869241fso283544166b.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 01:15:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxsoPtTztL7Y5GiUYsbJWdFO43mPz8wK8pCWqdbhCNeGSfCCz+Pi12LKmesnTj31LIPEh8bzWI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeLVji/iGK3x2/T9MbykXWeg+JOQQpNWHVJv6sMkF3gL/gcV9e
	FDuu12HB0Vk3wRt3N7sVibd2LmX1GUNWgRRokYCUkv80LYpNTY46hm+PDbmiTvPR4WWfh/aN++m
	IVQlyvn69K+yC6VL+9s7esBVpF+9G/nw=
X-Received: by 2002:a17:907:961a:b0:c40:f89f:d91d with SMTP id
 a640c23a62f3a-c49bdf75773mr380842666b.28.1793261704270; Thu, 29 Oct 2026
 01:15:04 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028203324.6073-1-dennylin0707@gmail.com>
In-Reply-To: <20261028203324.6073-1-dennylin0707@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 29 Oct 2026 17:14:51 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_vqP+FK1NDqyqzEbkz9x1O191GNa_JOOHCSFuk7S39Gg@mail.gmail.com>
X-Gm-Features: AclHuK-1y0mLW6FP8qa5uYUDpH3JuwsT0W3xlLQLJRFbzwZl1qeYTJdQVXSzFko
Message-ID: <CAKYAXd_vqP+FK1NDqyqzEbkz9x1O191GNa_JOOHCSFuk7S39Gg@mail.gmail.com>
Subject: Re: [PATCH] exfat: fix parent link count when replacing a sibling directory
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, exfat@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 5:33=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> exfat_rename() adjusts parent link counts only when a directory moves
> between different parents. Replacing an existing empty directory in the
> same parent also removes one subdirectory, but leaves the parent's
> link count unchanged. For example, renaming one of two sibling
> directories over the other leaves the parent with four links instead
> of three.
>
> Also adjust the parent count when a target inode exists in the directory
> rename case. Keep same-parent renames without replacement and the
> existing cross-parent accounting unchanged.
>
> Fixes: 5f2aa075070c ("exfat: add inode operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
Applied it to #dev.
Thanks!
