Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794999913;
	b=q36GgwxBMfvj+kOo+3QwwTT5T6qLNXrhPBWhOLuD4Q9W+w0rKxAyGGLcC31FhQZSBAsf
	 I85cONxsFqFWjW2rtaDUcUq7NI94awKJugCkTqlT4FXPlhb+PEPGelPd7oAaXn+iq1jDg
	 VN+MDtziH22zrgMRubuZWyEifzxtbSDNK4xygYpu/sw+FR8+Y1EYKzg4SQa3i1OCwhIwv
	 5k3YRyZHalRVDk5CFNXRlAOTtWkRwc+219Fvk185me83OZXE0zTQ0imUW0RFlRs+nUSa2
	 63+hfpVgkcYL0Dyf4msKzSb/gGl8su9WteykbTc3jIfs2CV3G7hT0Y28nN/u3HS+APg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794999913;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wkNqj/Ri/DMG3jz7yivagroyPuLoigFqxoANJ+MiNn8=;
	b=Qvggp+WxX5qHerk4Fob8xE+6LTb7FdNz8YF3UQ7NBFxCbPS6BkJu1BCIf5DDwF6UtGT5
	 GpqEFjtlOpXwOtNRrnhT0FqQIYeTVvNOHFDWppmgFks16RvdPF/4tiUv25dSHO05XR0+b
	 VW5o8zH/lgdXOKonWXGPofx7+4D/UMpGSUJVUi48WhPYUfJsgxkd9fIqijIiPXipaPYdH
	 fPdW1JvuaRWmN0Vtf9xhCazu4kSTaUB5uHMDyP9M3R51Mxh6ZMwTQ7Fe4kBx9gtv3q21q
	 2SXzBFJQDlS1vHMMndxlpK4UlJ4Pd1ApzJaHKHPJgOWiVwrteqhSi8S97T7rMuIIMKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="A/0s5lGD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F842606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A/0s5lGD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC181F000C6
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 11:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794999913;
	bh=wkNqj/Ri/DMG3jz7yivagroyPuLoigFqxoANJ+MiNn8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=A/0s5lGD3drPiYEQ+MclkPga66UkhVReitMXeEUP4eCvJDQvJb5tiOJA9IuXO8ZlE
	 zUWmyaAcuYrt3ZTcId5b3AgG2K4HB6RYJto+HbhBGOubpzVC9guNVB60kg7wnri7et
	 QuRfmWaLmZVovt8gMT82EWCC/nHevSfzB2FU+pgvgRFRa0tyPkTaSKrUbg/pRtQHHC
	 k+BYSR1q0aGPKz2JO86BuiIx820aALcgVCk5q2FgT8kqRRdjZuT72ZfPGSitzsw6WB
	 VpQm8SUjNDI6CheO0nweOT7qUph+tKyL/Wvsqyz0vYxsyuZBkO86iqOCAqty16ftwI
	 nkZJo4E6Ap48Q==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4b0348a4c79so539547fac.0
        for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:05:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFcgJ9Ciqt7QFbrVm8Bw9UsH74BroUY3hRGm0BONK3ca6EbCFzoF6i972ZbujuS1dY1dSpoUiE=@vger.kernel.org
X-Gm-Message-State: APuU4Z8TkcV28tIYwy563qKKa7iuk6EZE7x38D8g1fiEs0LhVzsEYqDb
	TPS7qDUVBIzUezV7hbTDQxeTZT4v7w/cp1rbKM9QSaCvPdJiwzgxF+p9dlqJ9qfUxabS8bU0Q/a
	0i9g9tCq6tP8VkmQL1+BIQ8fygloz95Q=
X-Received: by 2002:a05:6871:a1e3:b0:47b:7709:5568 with SMTP id
 586e51a60fabf-4b75fb23c32mr1749736fac.10.1794999912304; Wed, 18 Nov 2026
 03:05:12 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118083811.1721010-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261118083811.1721010-1-bsdhenrymartin@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 18 Nov 2026 12:05:01 +0100
X-Gmail-Original-Message-ID: <CAL4Wiir7GS+-0tSH6D49f+xZv6njk+sbc-_E45_qnqgHe6V4TQ@mail.gmail.com>
X-Gm-Features: AclHuK8EU7ooUYtzQK1pnm1__Qtfk6vzERe7RCmUjC-TOgvb6EadwPUWX31HIog
Message-ID: <CAL4Wiir7GS+-0tSH6D49f+xZv6njk+sbc-_E45_qnqgHe6V4TQ@mail.gmail.com>
Subject: Re: [PATCH] nfc: llcp: walk the accept queue under the socket lock
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: David Heidelberg <david@ixit.cz>, "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 18 nov. 2026 =C3=A0 09:38, Henry Martin <bsdhenrymartin@gmail.com> =
a =C3=A9crit :
>
> llcp_accept_poll() walks parent->accept_queue and reads each child's
> sk_state without holding the socket lock.  nfc_llcp_accept_dequeue()
> unlinks closed children and drops their creation reference under that
> lock, and the last sock_put() frees the child.
>
> A poll() racing with accept() therefore reads a freed child:
>
>   BUG: KASAN: slab-use-after-free in llcp_sock_poll+0x440/0x4e0
>   Read of size 1 at addr ffff888112387812 by task poc.bin/528
>   Allocated by task 198:
>    nfc_llcp_sock_alloc
>    nfc_llcp_rx_skb
>   Freed by task 529:
>    __sk_destruct
>    nfc_llcp_accept_dequeue
>
> Take the listener lock around the accept queue walk.
>
> This issue was discovered by Tencent CodeBuddy Security.
>
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  net/nfc/llcp_sock.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>

Next time, please specify the target tree in the subject ([PATCH net]).

Reviewed-by: Eric Dumazet <edumazet@kernel.org>

Also, make sure to wait a least 24 hours between versions (
Documentation/process/maintainer-netdev.rst )
