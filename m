Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794924220;
	b=Xcckiua0VXenMCTYxlzWDgFSGA/Vox8rAh0VuF4Tkx5zi20vK6bN14xHqKW6C3//eICr
	 NJ24o26Snku6SDW5nwTN/ridQ0to7gkeHvxebmTJ0N6kiBlB7AoCq++uqqEpb9WitKDU9
	 aHEirgMeeN69LpV3Dco8IcySjIUk1aMQcro+13edpUpuLIbocgrrkq/0sDzvZeP3hdeZ0
	 Q0qb3kadTz/DliR4xkp1PirJnc/ZOw437ZCjjGTzaFn8vYx6nSmdaSsK3I34nKbvObbXk
	 ZOSgil/EVBR8hWbfndavfxIhcaGhV/JAHUodMjrZY6tlY+0pGVWcIV7fUzBvrNJjXdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794924220;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ep7ekAqZFEuBLbi/Y29TSWVjYPWPHKoBWHpbvB4WggM=;
	b=BczMYk2D/A7J2BUsxG0dLOPNSqxuSMMnbIik2PEVZAeMpjbG0R0WJo99kLcWTvzND7Ji
	 EUlYz+PKjjIbHxpoOnWHDRFUf450VC0YOI85/r9CBt2M/pqAU/NgmneNFpxTSnyeoTLFd
	 i1c4cz+HENcHtkVnvqy4fYmwGGos/DydyhsTCa40ahegBi5FhmUORrHEBVDw4viR2uvd+
	 CPukJGHVEIJK9IkBUGyl4w0zNSlLFY5lD7Th2NWmbtBFePbtVDgicgRcZflmHUnptZgfE
	 58x71puMfqG1Zeg232X0q3KMGC1MDHSw9bJPeSy6N8vAXvzDtXkbGyCEm4q+QXZLwmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsDJRIxv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BFC606A339
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bsDJRIxv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620D11F000C6
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794924220;
	bh=ep7ekAqZFEuBLbi/Y29TSWVjYPWPHKoBWHpbvB4WggM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bsDJRIxvIYsfer5z2cHlqe7ukFERinuCny/wBVIPvOh7gUr0bdJHzMeD1xRnofVy2
	 spgUzFfHByz4ArkGXgQO05XEp41iNPcYiivQU1JBB7m3ZK235p47mzirzfpfn9X7U5
	 Z9I25vsSzJzKlVT0Ay36o8VL3mMxv3RYXPbgd+pcbLWWVuzL5ZeHgqYDzRZIsM/lyJ
	 pPrX6PBiQnbkkop7JcP7gNV/3aJZljhp8ZQJEumKGIkJHVvrvYM8Iw3+lktninNKk+
	 D9NkinOt9u562QVro73HMHAcR4usTdLJQ6pcRTzZOAmUEnTRAUAv2ujk26zipMKJA9
	 MrBfmbMndsoKg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so46186461fa.1
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:03:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHR8n/s37WPsQubHFEUPuGfHaouUaS5/DS9HHc408NYg8E67GAtpaxDj2DOer+VCwXiVUQEfwg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/x4Nr+U7pKgpwooAnyDhZVln12m+4PVz0/t+Ry6XYM/OmUFWAp
	tjrGMIL0ZN5wkyLYpGA4mVI1OUfOl2Tv89LCIqAB2RMxgNUgWjtf7XXRFSBEBwcMqzTWLNO2ISj
	2NMsBSs1rW2Se/g9BfY60fRRo4K3sLvY=
X-Received: by 2002:a05:6512:1591:b0:5bf:b144:fcbd with SMTP id
 2adb3069b0e04-5c17079171bmr5441932e87.42.1794924219160; Tue, 17 Nov 2026
 06:03:39 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com>
 <20261109-gpio-desc-flags-atomic-v2-1-c4c54b476628@oss.qualcomm.com>
In-Reply-To: <20261109-gpio-desc-flags-atomic-v2-1-c4c54b476628@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 17 Nov 2026 15:03:26 +0100
X-Gmail-Original-Message-ID: <CAD++jL=-tshm2Wezg76r7itfKmb81pfoZfUH18WmAQt+ZM9uVg@mail.gmail.com>
X-Gm-Features: Aa3M54oq5YddyEW92v3s6tYSNhWqafHE8PHZGaAbR7Lra9sfb-qzvBmZqbaVAEA
Message-ID: <CAD++jL=-tshm2Wezg76r7itfKmb81pfoZfUH18WmAQt+ZM9uVg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpiolib: don't overwrite the entire flags field in gpiod_get_direction()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kent Gibson <warthog618@gmail.com>, Adrian Ambrozewicz <aambrozewicz@nvidia.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:27=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

> gpiod_get_direction() snapshots desc->flags with READ_ONCE(), updates
> FLAG_IS_OUT in the local copy and writes the whole word back with
> WRITE_ONCE(). Any bit that a concurrent user sets or clears atomically in
> between - for instance: FLAG_USED_AS_IRQ from gpiochip_lock_as_irq() - is
> silently lost.
>
> Update FLAG_IS_OUT with a single atomic assign_bit() directly on
> desc->flags. The earlier READ_ONCE() snapshot is only used for the
> open-drain check and stays.
>
> Cc: stable@vger.kernel.org
> Fixes: 2559f2e09211 ("gpio: reinforce desc->flags handling")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
