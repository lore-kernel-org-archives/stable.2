Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793867135;
	b=AqJiR+7YMx2lHdsP9NNlKyfURLjWh+jErms2rNinkrf0bYqB9HAsB4RrghC6s5vKc3FH
	 iRWDo+ZGmzInRrFmMFWyKvA8CE/pS9r1jLEY0T8dmm2baHVHTGkeR1fgCLOq4gzJ9VQKn
	 fDeleCFyUk5i7g5jd58qeFC685ArMmtBbi2P8SW39sYkiHQ9gsarcs+lKXQS6yby+Z9VP
	 k+XHIFgmFM1LoxBEypPGTumLKMzOEe0WgBIdRAGLTbH3YtCA0siRu7i6ufaYwcWnupaRG
	 GeRZAiQd8GNivQuq0XDokgr2KbP1EBZATtsx23S6sxPDnOn6UWXF46AZVcxTR7KWyzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793867135;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MXajDzcXzw8HFrD8vEhPMO3rOmoG3zJCn9w9dmNaD30=;
	b=PITKSYpYYNLc0yz8hfTVB9Q8gdkn9A0EBke7zXJyChepH9n2+vKrxthrhF91hcS4swO9
	 iT01Ju5hRFeaFmxhiyB9vv3luD1HevIucDWW+jY710VgJa16l9vxXa/IXxe+xZmnm2AG6
	 xFJcLAWoO2xiB4new3fbSbyqIGJNuRQZUDhnmUPZLPzE41bxRQglapiIxGsmHjep6r8RE
	 hW+Q+UT2wwbnSkg9CSGC5xx3MJHnE7tW6Y/UXpKB8ao9eQBxlabSqkHML2sJBM/Pp3TrZ
	 ViGCBmDXUW+0UFyplviKUPHGu/Ara0duDEwEEno/6PfrM9Ob0Rp+GrOsdOLxeZDXLDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="cWeb/I3C";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BFA606A328
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cWeb/I3C
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB4E1F00A18
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 08:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793867134;
	bh=MXajDzcXzw8HFrD8vEhPMO3rOmoG3zJCn9w9dmNaD30=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cWeb/I3CUOf6GV6EV+or+YbPD42zxND5eYvgZmaTp1vxDwPhjrYTcTmDFXOiPPUAf
	 xnzXOLVNszc/Vv+Utbzhhj8hnvCik/aTr5MdC44PX0h6eExGOZDfHzCLvfe0XIsg7u
	 0ypBEHuzN4JlkRzZbNjrPIB5Ue1hlf4/7++sPCYwOcYz/ilel4OzvBLq95TGL12Rh8
	 f6MhWCmjO5hUEd/a/xAtgiNa/FjVZb5nb5g23/LdUpFH3lXWdOyhFU29jqEyS9BUuz
	 AAiPVPE0OQpKhxtwOlZQ2Y0BnTerZHROjRrxuGgLeEZ7EvE/Iwpl+uOMFKpD0o35Hn
	 dS3uWKT7106Kw==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5bffd1e177fso228441e87.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 00:25:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwIWc1N8Q1PznX2/tH6sYIf4z8OiGiDlE1Uf5QesHBb+W06GbVP0s8+42gHvX44+5D/H2R2g88=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Tz5ugPrNpa3aO9QCG6o8KjeTcqyHu2kV8QKpUdbuVClNzxfWS
	pMTvU7qO5WLgM0ph8PmOpoUF058XRkVtMQoNmiUDXiK20stXDF0hpOgL+gMzfS/4F3P4aAfES3r
	JdGGXCf3zFpRf1ySg+PGhhnIT+0XOptQ=
X-Received: by 2002:a05:6512:6694:20b0:5bf:d9ca:657c with SMTP id
 2adb3069b0e04-5bfd9ca65d0mr3770360e87.27.1793867133080; Thu, 05 Nov 2026
 00:25:33 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031120700.42576-1-mateusz.nowicki@posteo.net> <20261031120700.42576-2-mateusz.nowicki@posteo.net>
In-Reply-To: <20261031120700.42576-2-mateusz.nowicki@posteo.net>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 5 Nov 2026 09:25:21 +0100
X-Gmail-Original-Message-ID: <CAD++jLmJnxdJ9-X4hThz==Q8ZJScb567VwdAYebGsSqA_KJsjQ@mail.gmail.com>
X-Gm-Features: AclHuK_tVeDfi38_WWdEZ3DB94ymBMDKaW_qe7crMyvj_c5Kzm5MMFqKOFgn5mw
Message-ID: <CAD++jLmJnxdJ9-X4hThz==Q8ZJScb567VwdAYebGsSqA_KJsjQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: mmci: do not count a data CRC error as a
 complete transfer
To: Mateusz Nowicki <mateusz.nowicki@posteo.net>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-mmc@vger.kernel.org, 
	Christophe Kerello <christophe.kerello@foss.st.com>, Russell King <linux@armlinux.org.uk>, 
	Yann Gautier <yann.gautier@foss.st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 1:07=E2=80=AFPM Mateusz Nowicki
<mateusz.nowicki@posteo.net> wrote:

> With datacnt_useless (STM32 variants) success is 0 on a data error and
> a CRC error subtracts one from it. bytes_xfered becomes 0xfffffe00 and
> mmc_blk completes the whole request as successful, although the
> controller stopped at the failing block. Reads return stale data and
> writes are lost without any error.
>
> Tested on the STM32MP257F-DK eMMC in HS200 with a forced bad tuning:
> without this change 5 of 14 reads returned zeros, with it all 10 reads
> were correct.
>
> Fixes: b79220b3e0af ("mmc: mmci: add variant property to not read datacnt=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mateusz Nowicki <mateusz.nowicki@posteo.net>

Looks right but we really managed to make this code hard to
read, we should think about readability improvements.
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
