Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794897629;
	b=yskj9hHSZ/NPbmctfUNVBLIGaHgVZmyoJTZDKPKhdqfWrbq0TDBN3eiTzOp8t9xPnJd4
	 KWIGOVurAgmHk+Ae5BEUeGDqPCSvkI0oLNwKS7pLwakVo3YSni3Sy/flsgI08xHnKuTQb
	 csRaz6PFEacmOhJ6jNmpr71mAXJ5FhJCmkMV05TUSNEhug53ZTl9/NNHYFt6aphrOLZvI
	 Hftwfdfe3iSd+oecAo/JKcJiQZOAmqyoG0gCe3r5drFF6YUkmX3dU7GjY+MJ+DlUhmpDS
	 ueCYZfwcQrOXouW4Urb74vTK990uJs+lQi6shSY5U6OeaJSqSHzpOSdtWY6hotsTh/Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794897629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=v1qDtE1UkI1Z3ZIzAl9oangANFq3PebjU3wsoGmWws4=;
	b=y20H0C945JkTZAI+GHSvCVTpH8Y717eVG6/UWaD7kThG6T3ExS8gNbtuxkGCgUaoP0wk
	 /qS8/hz6Wv79v1nQg2elo21WN6llcatAKt4lqjqaryEkIgtM3xU57Hv2yXPSlw6+zwGND
	 TU82KivazPCNeoARJbb9w5OHnl6Y8Mhvx+GEWgu72hJeE+F9s2qfW1stfL8IuaL+7KGcS
	 QViCCtsZk4auEk+0oLKodlI1M8UW5KgVs+hFZc1jjx7tqCYCTz0AEH9pgjknSTF9SYKfX
	 anu7Jon6w4vpfJ1oSm7KIjZl+UDJN6ocak+ZdSUa5kagdM3Iq58AMW06SZcNHPiadvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIRFwOCY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA51606A31C
	for <stable@vger.kernel.org>; Tue, 17 Nov 2026 06:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FA51606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pIRFwOCY
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3adfb744fa6so5647951fa.2
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 22:40:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794897627; cv=none;
        d=google.com; s=arc-20260327;
        b=lfib8F1sDJ8FiEJKKhA2z5WcvvWsF47LUJdH5EMm8305JsDRMjRnHbgc/V+iGAxitf
         nnVcpZadGlvPxcjyUlPVKK+FpFrlLvbNAk288Yn8kkVDZU53X1tYuApbF+wu2JUAuJ/i
         AexpRYp2v+vehR/uKpAu04kYUAG8krPXUHZOqQ4xxLgHiX6O6fF6y3uLbQKCW7EYOqns
         /2RNgSjv+d4zJkgOdanS2oC1gOaeYcJXjzYJd0WbmZccrZ+vXIA3wivsJX4QNJyvdwQg
         ejaNB9uhUej0uaDfNBXtRs2EiZ4JOhMkyhA6NEKSAp0Bul8QfELh8dUoK9nzJlTEMwSq
         +9pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v1qDtE1UkI1Z3ZIzAl9oangANFq3PebjU3wsoGmWws4=;
        fh=f/DSdWj6SpE5GdXYq9Eb6+gXNva4ke2rPA/lH3XiBw0=;
        b=b1ndoiE+volWH8EjyIxXPiV6PLF9de+4Qz4YiNDUL+LJhAapaEBXwkFJgw+wZuMfQM
         +WlqpSad+IVXI69GxTT0QnvsTXFq3+YmhhlfUMJsNgf20r6r2ngl1KdUSZr0rzrVUx+h
         cB4wStWh2DGZEvIoEv+UVhMifusNCX1mSvJZiKgvfT9KlOEX3rmyTmXbZUXVL0C1W41Q
         gukZ81U+weXCrVmx9lwyl8ch/V0VEZZDK4Ibc66OWlGwhDLO6GDQ4UubHwPopYJliKBH
         +JXZJNKbkAQGpjAtoHi8ipcfwNii0lq+jQXtRBTTS8N45GE7EYbuC3vVJ+N9jm+wNd9n
         gCHg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794897627; x=1795502427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v1qDtE1UkI1Z3ZIzAl9oangANFq3PebjU3wsoGmWws4=;
        b=pIRFwOCYQRg6aJGJnOiyKnNG9c6YYSN6o85ZYYxXAIBG+nkneS57BTLS0ZMhGdx7gt
         73Pq8Jq1zMZq4BGnCGApMta46cRhvKL6hZ7GMCFL1ffulVvZGT6ZBw6pIE5aUhsdRlZL
         OEcXNdqV+A8SKlHD7NA+p4PqnharGSeqxPddVFJsiemwD+c01kHRki8Io/3Nujn4rPIk
         3N+tSkGGsatVDuNCgallXLT0T4kowy0ldDFrPVxbONr+LrPuZuo1p4IAubjb7JrpzLEc
         rlUWAI+7x0KhGGY6xxKjbvUTHCyYVjJST58F877wciel9dPplKwDTy85ZzsuvJJlA4y2
         61Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794897627; x=1795502427;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v1qDtE1UkI1Z3ZIzAl9oangANFq3PebjU3wsoGmWws4=;
        b=WmX20SHdqWlu6ktW3GtsyBflCevpb2lsPERXMoMX2CCquhzXHcDmC8o2ZvlMe2TLsJ
         IZKtr9+Arhc4UM32uHZdU1SCn4fiFScX1aulec/Kfq99+XDnSSaJZmZ8IPTWDP9jJJN0
         3l+Fbqw+3sJsjXj+bpgZDnR+kmJqdaCKW7+y9991BztCMXVYY7IWg84tCF3TGYpoDDJu
         Q6tEo6B7DisdLwZnTdENeyqz2s8TWOUubXwL5CDYv3HmA/TWUcrT4iYEQnf2iuXXqHh5
         nWIPSPorT2xNL4rLLboyX+7FLxYIQZ0buVK9irS7gAhZTrPYxrCnPetSlMjfb9KKAG6O
         DPjA==
X-Forwarded-Encrypted: i=1; AL+hErGLgZsgjXSVIp4h9jFcRswN9x7d1sZ3chlQNN1dZCZjPwArbFhWX+g7UdEy3gDNVIJ86KjA74E=@vger.kernel.org
X-Gm-Message-State: APuU4Z9pmAs9rgFAsCFHBGkHG21YEghgQiaWwLvdqBr9oaB1+EHdSanx
	FvHUMTUGWla/9OFGnj2pcHmXksfd85kBXU+7U6iZMYUiz2xBkuz+yLiP3KN6TdFvH78eIGyTLvv
	V7jYtUlvAfhS2Do6NcAMe4ffB5ljFlkQ=
X-Gm-Gg: AYBFou1sDzqrVaKJTI6kWjNuHNNsBTV7uC/KEQ6VN/kV18pvVXlIWt+dNAIQvCm5SUE
	gssGj8xSTzfIhB9w15heqrUZbYMLl5fSxwsdpIgZzngzVWfe9feIWIXnINs9G+tc8qI3dEAIZub
	tS2E36RtrSMnyHbDYqWpI3IdySsbNA3rtT2CQztZLnBZOqD4NYghRs8Jbs2M9hOCrCfaoY97dv7
	nGChROU0vIo29cRkk9NOfzGDV/MpyKSwDWYt2aRTlUElrjhCpYoCxiwHEmOnmjQ6VNzrycJqT3q
	AnYD5ulI4VbkOV36Nb+RynHaeNSttI4h063ihzCFmQ9tT3bg/C/LSvB0cF/te3pLgT5+Fu15Wns
	a86Lpd4RxrXg50lAR9GxMyu8b8rbId6UTujroD892d84nxclLDU2TiIxtvUOboLgHneZ9oz3Srg
	hwc/9VzWxW8KMV4BVrv7D/aeYXgUrbYBo6DjdaASsWkyNehzcB+BrV6WVzMbPnt6PsIOuA2diR2
	JXIQtLD8jgv/tjZX5g5SlGFFjodZYlsb7nWo7lgrMDn+b9Y1yB/N+8Ur/Voasv4iL/3EkqR1A==
X-Received: by 2002:a05:6512:3d0f:b0:5bf:e6a1:3115 with SMTP id
 2adb3069b0e04-5c170771fabmr5745484e87.2.1794897627214; Mon, 16 Nov 2026
 22:40:27 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CANiq72mnB8cMmaMWaC-7pJj29JqqumBOSygnM9zA+8eHikm1Kg@mail.gmail.com>
 <20261114132156.49243-1-marawanzein222@gmail.com>
In-Reply-To: <20261114132156.49243-1-marawanzein222@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 17 Nov 2026 07:40:14 +0100
X-Gm-Features: Aa3M54oHxETgvJbOaBj3UfHn1YJEXV_kuITRJF35qSCPKbs92-uDgz2TS-kt2rE
Message-ID: <CANiq72knPfBVzEA3kiHOWXuDo0QAUh0mWQnWR6og0hqYwK2PNQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: kernel: fix lifetime of copy_from_iter_raw
To: Marwan Mohamed Zein <marawanzein222@gmail.com>
Cc: ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, boqun@kernel.org, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	dakr@kernel.org, daniel.almeida@collabora.com, tamir@kernel.org, 
	acourbot@nvidia.com, work@onurozkan.dev, spidermana <xuyiwen14@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 14, 2026 at 2:22=E2=80=AFPM Marwan Mohamed Zein
<marawanzein222@gmail.com> wrote:
>
> The returned slice is derived from `out`, but lifetime elision
> ties it to `self` because this is a method. Explicitly bind the
> return lifetime to `out` so the returned slice cannot outlive
> its backing buffer.
>
> Fixes: 06cb58b310ea ("rust: iov: add iov_iter abstractions for ITER_SOURC=
E")
> Cc: stable@vger.kernel.org
> Reported-by: spidermana <xuyiwen14@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1265
> Signed-off-by: Marwan Mohamed Zein <marawanzein222@gmail.com>

Applied to `rust-fixes` -- tags still welcome for a day or so!

[ Reworded title. - Miguel ]

Cheers,
Miguel
