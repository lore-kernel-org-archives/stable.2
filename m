Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4148130E0EC
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658149; cv=pass; b=nKKzVB6a6Tauy79iYQMlBL2c9DJdHO4qimraEmCCQdJg+I2hVHYaY6TzhrQ1dz2OI3pvSTlYqi8bOmfY1guge/vMNIfVszck4aA92GpvGo28B/uClPin+e7bwWAFsTiu4iM56pz0ycxpTme2Y8Rg2xghpu1ROF+5x4AT9obm4wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658149; c=relaxed/simple;
	bh=my64/1IBEIL43GuC3wT1kWWVvvLkggDAhttkWSBbVOM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B3Xlko1oypyk4BUHoHx9BygJV5x7nrQ6qUcmhLXXzvv4C2xyGPCYwUi7P5XlGjjQv3Uo3u+1NQ3fc8tbHbGepEPBV/ZDfjyNZLKESGSX47X6fzonfcd4VlADj1h7cXxLyH3Ag87qwfNt4pwzBa+KGZhlVD7FDHynZQ2JL1vt/6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epEirlnR; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epEirlnR"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304e86ecebfso81963eec.0
        for <stable@vger.kernel.org>; Fri, 05 Jun 2026 04:15:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780658147; cv=none;
        d=google.com; s=arc-20240605;
        b=knvIWSuRq/gop+2NHRhvsnh/s7S/zPN1qqH8f5rZG9W5Lrq30o5pIqRQlQCKhdy2FK
         H3xDt5rpziqoi+HXXR94JNkHw7KHuiSTcO57N5YZ726Kl6F3TMWxSVb5BpKuTq71TJtI
         V1nyvfDi2PXygGEgrCs2vRZ2OH5lCEVj/qPoJ2+OK94HbHyRXfR8N4nLeUN9NJRlgWxi
         sFa7Y2j/i1CcvsHdDjTWvqyihXDiv9WduQ9OggfoCYcVLmXwXShL/Eksr/48gZLQsrBd
         kH5lpk/nSyz4nIJaoxvHJfkhPy4keGgOE1JBPNaT7V5Y0zNQHnhbVi09ajfh6nRyaGwl
         SxAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=my64/1IBEIL43GuC3wT1kWWVvvLkggDAhttkWSBbVOM=;
        fh=gGBvqSkViMEbtulEt1/d27sAEES9lbQdZHjRE3CgUiE=;
        b=h+6aAMiKIUxCqLQPmqK4qokaIpR8zcnkX6wQ4tSfBBSAjOdzQfUHZNTDQnMy/MDPYv
         C0vNfRkYRTc5XcWza6g/zQ+xmD5F+a9NdY87c3g94w9weYRjo0KZAtSKuDj+mBgIkZh1
         n1gG4ClO2pDdETxALbRnHegwhbTzD+WBQgPn88dw6xLdUyXFUlHhkGYR/XXlaYraMsD7
         QZ6K6jk1Lgo+18eEblMLhsXRGvYCYY7Aq53I3z40Z7ujf8E//phIIjmKjHSFgswrMRUw
         mSRAbg3K14lfG+4kgi/TcYRFmoB0jXViLz4XWN+4N9ik7bYUu+Wl+z0MQhOhE2Ya9AGP
         lRIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780658147; x=1781262947; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=my64/1IBEIL43GuC3wT1kWWVvvLkggDAhttkWSBbVOM=;
        b=epEirlnRZot4ImqvNbrFaFW1b3l7g1/0FNHU8xDv9t0M9Dg+h+ef6ETySayjrCDpyk
         seD6HyhA3cKQ6It0b1Fd6Ybnscvt1/6dAF75/7w8ItPnFj+TpN616hy+G2bCq5RGtRWd
         C3OP9/Uis3tl++HjE1BsBEI5OVj8gPXjMnUx8/bpLHnGMsuyOxgyDScNj8DVT2fVYh9E
         GdrjtDpnXjZAD1N100tDw8GKXUiOZDgU5YuaCeB8mKURkJdzCeFTEuwSrlWlx6WeZOLk
         Dnfoov9aVYG+GKiHLLLeMU+jjRZoA0aY/1zdwQZIIadgi6/L+MXiD9PpiDyedMaHAcJQ
         akSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780658147; x=1781262947;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=my64/1IBEIL43GuC3wT1kWWVvvLkggDAhttkWSBbVOM=;
        b=ZDcX7QQ7Q/cM619QfGu1icU5h1MB/xZe1N/XLokJHC4+Z2CfOy4tlFrpJuxgZGovOi
         nyjo3fBV++/qr/r38YAnGHz9OOZJIXvsleVWFJlEGMq3ddXdQg9Wn50hSXaDT70EtrO9
         j7nFG2Rzs3/TIGzMX1J+O9/3Uuy2u96+G9KceeUPc79eEKQI/dYV8uWgfrFsW4wsQx11
         QDp4DjtIX+iGpgBPSz88l1sZJtEcki7KYDKYDiwRTe81fm/sigEilXH6UWw7+J0cztsB
         XA2fizoOkoNhDkYEwCJuHdKQmK61ZUIXtlTyykTR/V1zw9PAXXCi/JWevBjDILOFzG0O
         LyhQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Koc8WrnR9N1Tzq8QDBCjk51z91W/GAyqqAHrG8cdWBo7PueRkc9f/zAg6+JftMSOCljEaRdY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq23bC4n4gtXnHbUB0vmA2wHhSRiaVXmHCAvDjcyh143YS1C/y
	TxUxzQwmu6qer12V7zCUIMNsKdwiaHYab71zoLvCsGS245zSRw4NJi2Q2taXceDzvmJAJH3mPoh
	vdvQarrM3Mq70F5cqy1gV0xyksoMCPek=
X-Gm-Gg: Acq92OFvteK+Vv9FykTM0HO3BIXGARoJhy+94CiUMKno/jSbEYRJRea9dxLHEogKK8K
	0/o/lYgQabPScRUSnbEWt4YRSx3QqzX9P94SVACC6RD+WHH/hOjOTUIXmF4oyh4EMCvxt+I7Fsf
	5TlVtmdkjxbBYlcdk3WKLdPxl5NduCMWR1DsZ+9Jg/Yv4ZmaNe/y2rl0G+kpAkDTgaeroVSsQP9
	3C2IGyD8Ns+NMvYBEb4ftfPljHMdQP4EFG2z56plZAL2VtddtKIsD/jkI3Jl97oSP+1axD9xNGf
	yyLjs0q1hWXaC8VV8ahp46mINHCs51sZZV5zMAHDHPiQ6ooLYfi0tsKsC4WFFGfJt5lpj1EPlzg
	W3/O32xwKfIYmWD+ouOMlD33Mv021/q8WUA==
X-Received: by 2002:a05:7300:134a:b0:304:4f23:4823 with SMTP id
 5a478bee46e88-3077b326a5dmr659325eec.7.1780658147377; Fri, 05 Jun 2026
 04:15:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605041134.38290-1-ytan089@ucr.edu> <20260605071104.135675-1-work@onurozkan.dev>
 <DJ0YRJ6MHAU7.WVR4P2MQ4HIX@garyguo.net> <20260605091632.313084-1-work@onurozkan.dev>
 <DJ10CJ31GS5I.1ZD6WPPWGZTQN@garyguo.net>
In-Reply-To: <DJ10CJ31GS5I.1ZD6WPPWGZTQN@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 5 Jun 2026 13:15:32 +0200
X-Gm-Features: AVVi8CfJonDrVd3vGam6duBD_2L2EfxY_kIzLcohD_P9GEpMXFyOnCWv175rJqk
Message-ID: <CANiq72nE9H34DzEthWmRSmDxgaDW+XLLbrA=T6ywy=hB5FAMrg@mail.gmail.com>
Subject: Re: [PATCH] rust: firmware: return empty slice for zero-size firmware
To: Gary Guo <gary@garyguo.net>
Cc: =?UTF-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
	Yuan Tan <ytan089@ucr.edu>, ojeda@kernel.org, boqun@kernel.org, 
	rust-for-linux@vger.kernel.org, zhiyunq@cs.ucr.edu, ardalan@uci.edu, 
	pgovind2@uci.edu, dzueck@uci.edu, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 11:28=E2=80=AFAM Gary Guo <gary@garyguo.net> wrote:
>
> Oh right. Arguably the wrong error code, but it does prevent the path fro=
m being
> hit. xz decompression always grow at least 1 page and thus won't hit NULL=
 case
> as well.
>
> So indeed under no paths we will have a sucessful `request_firmware` with
> `buffer` is NULL.

If we are not expecting it in practice, then at least a
`debug_assert!` would be nice, or perhaps even making it an invariant?

Cheers,
Miguel
