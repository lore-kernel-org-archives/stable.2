Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F0A3B14B8
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173091; cv=none; b=US5DEMWFgAAhr+jCJsjvCVLE+jKDMRLCApvLW9UKfCSfPd+uxHCPCEtE/BKMX0RgzBNxMnMwgCI0OLQuzyDMxD/C6x4N1kV8fwBS8SOL32iVik9dNXUwpZfp5y4RBdbWn+K1V2w9iujWxgmdFqekgtbxrN7gFujjFC1jk763nlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173091; c=relaxed/simple;
	bh=hMYwNajdVOToDigGICeyjg9urPgriQOZ1BKYRKnTw3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZaV6krlhUOMtEJ74iPzhOcIKRDGAVYag62doZUl/a3tW8ksm8EMwnu8gmc1TEcXBwytGPV/vYK9dvXfpGpG03yjiFdbS3QDjon/etpKNi1rNf3v+8z75+X+RV04YZLTvBlTMULOMggdlUYXhisYXqWXn5yM2eEY8ucbTNkPI4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqmvRVqt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqmvRVqt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1EF41F00A3F
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 10:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173089;
	bh=hMYwNajdVOToDigGICeyjg9urPgriQOZ1BKYRKnTw3w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=LqmvRVqtlrEuAb7VvZ9LPQ2/lIJqu0AfDHnlTXEmcDOK7ETEp+kGmpU7Zv2n623ZI
	 JhCHjtp8FY7rU5J3PxoLiYXxB2cOpj9vyaCV0kLtR9DB3Ex3YzpCDoC1uYIyO5dfal
	 kYXmujpE8HRnUp3LuS3C6Roo/E/Rkr2Pw7vakIEB2IgJWzq9iL/iCCbmdMQ9VO0AKj
	 gMoviE/hyNCIOeMoVldqdlHqeS724Td0tVhaQJA7la9uA+EeXO6A9lEWJPuKtjEqsN
	 YG/ECrJrFV7Tq4l7yOyvlv/BcuyVuJL2IPa8pU0fPV5dR+0dyAvJGe0YvA7wYOWpBG
	 FjnfUfCpoKsJQ==
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c1712a04ddaso538732766b.2
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 03:44:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqVeb/WYVxRjRyeJ9qJVCONCVCIPl1giqtREYuvKlf/4PcpYt0Y/ktQtKJxYU/0nw+3+iSCYpI=@vger.kernel.org
X-Gm-Message-State: AFuF++l5o0cYdAnvRqCI6YHJ8atdYnGTxAAxti6bx6V+jN+JcRqmUmEZ
	Jovdt7y3l72Wmds+7iCUaTa5TYQmOFgkt6mZT6MUTdlQPgQTXLePBYmzLI7W7oVjIcO81cvK604
	Ya+c/K+tQYsKyJwwDKK/Q5wnDySOTclM=
X-Received: by 2002:a17:906:fe02:b0:c25:833d:383e with SMTP id
 a640c23a62f3a-c25833d3abdmr811817766b.13.1788173088497; Mon, 31 Aug 2026
 03:44:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260826055953.1372417-1-zenghongling@kylinos.cn>
In-Reply-To: <20260826055953.1372417-1-zenghongling@kylinos.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 31 Aug 2026 19:44:35 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_fCGA+3tYDxHXMDLFKW5WYYyZvyAtbD7XZmK5iLqEK5Q@mail.gmail.com>
X-Gm-Features: AcwNN1UCKFWgG29NM_PVf8JAPJy5Abepe42LBY0d_st5M3o7vMaJpgCOIwfMLRc
Message-ID: <CAKYAXd_fCGA+3tYDxHXMDLFKW5WYYyZvyAtbD7XZmK5iLqEK5Q@mail.gmail.com>
Subject: Re: [PATCH] ntfs: handle signal interruption in fallocate
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 3:00=E2=80=AFPM Hongling Zeng <zenghongling@kylinos=
.cn> wrote:
>
> The ntfs_attr_fallocate() function checks for pending signals during
> allocation loops and exits early via 'out' label. However, when a signal
> interrupts the operation with err =3D=3D 0, the function returns 0 (succe=
ss)
> instead of -EINTR.
>
> The signal_pending() checks at the allocation loops jump to 'out' without
> setting err =3D -EINTR, so the function returns success even when interru=
pted
> by a signal.
>
> Set err =3D -EINTR when jumping to the signal exit path, and only overrid=
e
> when no other error is pending. This ensures:
>
> - Allocation interrupted by signal returns -EINTR
> - Allocation that completed successfully before signal arrived returns 0
> - Other errors are preserved and not overwritten by -EINTR
>
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
Applid it to #ntfs-next.
Thanks!
