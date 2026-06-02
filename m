Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5902433B6FB
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 06:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780381412; cv=pass; b=nivR+AU0nTN6WDdlCE+JuyZkpkJGSI58Z6v9XAjDX6ivHxhHZAMq0hHc92/E6ESULfQd9W2LyV0Y3p7myWL/9PsrLBqbW5Jez25cREykbtGKr7ShEiKVtdFI/kxixScTStybgD6XnjCmpHxGVvQwN/l4gnTXNDF7xV8z66hKaJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780381412; c=relaxed/simple;
	bh=bHbWohJPBF9CHwsWq93xd0EknGGk7dN/OkRGS8+4yhU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4ulqlCf8y/h7Y5o9qisb2cmBDCn3mVJGs9LCHaGz0Cx3zkUu47RqtdkLOTAbtzh3JYdlUVarz/1bbXljmbBUi9EzfuwPlxjs53Cvg+D9MhE8raYS2C/Hw3e+UbUT9Rp/YvDqM7mCmXbv6y4GDZW0ygIrgjnylFMt1Rko1pqKzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YwV8BqG0; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YwV8BqG0"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4903f7a90d1so98192315e9.2
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 23:23:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780381410; cv=none;
        d=google.com; s=arc-20240605;
        b=H3ZvxTx+C0zi9Rp8uii6cHQ+/S1OjAGYw3kgyjC6T8yY11zJwdWfwnnfd+Kvk1zzai
         U4cgZMwIXCSNdO5INOz+D3UzYqHBxtlJyDMxVW7dsdWjoGpLI68TFgIoAEm3cSdehwcf
         okqXDT01z529VSBEyHdbVB5sCgnOIps8BLm76yugeJuxZEOVLxjkcVTVfrMwjBv1/AKm
         cLTwYhQULj1OiOraWhl136Qp8xwyIV63Qtdt1nvc4gOMyWaA6b7LSBkKDUF8V6AT1ORm
         BXu+S0juAAFvVD+sfJ6Xz3mKQ1z2IPTC2NINpcNYlmNITjGvhnIdI6+LOlOmHlLLlh/q
         irZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bHbWohJPBF9CHwsWq93xd0EknGGk7dN/OkRGS8+4yhU=;
        fh=cA+WwP0kLXCUoBRGi3gjYFUOMmLKz1ic7h0g3G4mJgQ=;
        b=XzNGkjvmxo5wxe+NINDlY4CeiKJ8eL5GlMwoU+kjkdBIqk3TfQJZwO1YtenKnjnehe
         vQe55J3b7gInYMf6vguPDVrmWM25h/qplSzByR3GcfGsQoaBb+F02ySRPInwu1AOAWNF
         SX6y1bbVMd+7WlGyI8qe7l1sLZgqfz+mfQwMMbC3MGu+qQkGc7kR92cK3emhMQ7z0e0m
         gK3v2EMcvt9aXMXT+/+MaXyeVIw69XIX/LjXK+XMZOI/YBFMm0cez1cEdvns/hjXmbSg
         N18SJ90eqi3eYtrR6O7UYp8FJVptL8ujkjq1eIAKCkV2PxAlFJSZrZiPROdVyA52zoq/
         uNBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780381410; x=1780986210; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bHbWohJPBF9CHwsWq93xd0EknGGk7dN/OkRGS8+4yhU=;
        b=YwV8BqG0EOkI7v3fATcIFQS3dUlpA99MAPW4bat1PnQTcYNpdeMlZdKM6Lf4RzaSlu
         0VAfTi/qIiRRvcK6Rq7RzUySUPhAbG59uS7oY/KfvZfmrxxQRRkiAJS6Le5SfkoUxjcP
         PGoPVaEactBylBghfr1A2lIln1YQrBOpLym1O7wNoDjRXglaclol1ggcyyOan3SLnI3/
         gLeuMLzTnLLQhSxXI75X4TSZHIxVjq1ygQHfptpSSeOw27wKf4RaEbMPi7yVfQPsrNSb
         YdbrWjEYlPXoWulvVY+O7sGeEUYts7YByHe84gsbU65BQdPQzMnojwC7lDJ9bZJRZkzL
         7Ifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780381410; x=1780986210;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bHbWohJPBF9CHwsWq93xd0EknGGk7dN/OkRGS8+4yhU=;
        b=JteOPPm2ENONuzbOy9HGSyaDvThrEzk75FVusfHuml4D+QN0z9+IByEiIiBYg+jhmM
         GmXjTTtGmNgveFdgnN8zCo33GJEbv25LSjQtvYtPF1VINRVWbEWLzsK1D4rshWziczly
         sYgO6F9/o//AW3qh0YdAypCGSVinxNzKwu2V1qb3eEp5cUDm5NwRW1TwqONcPOyGbAxm
         J/fOAqB1gd4LStyGJZ7x4nzUUHKakm8AEjRL1rpu85UZy1QsxsxtTSTIUOzegygKBpiE
         eq+lhc3+O3kev0XtGKiSh2aBwv70PWKkODglKJuNytARuxz3pIQB/83VV3snQPnJp9Ek
         j1gA==
X-Forwarded-Encrypted: i=1; AFNElJ+KGwkS5XV7zctag9k4DLBoZt63pAzFYCs27KSgqgrdYR5g1wPLwNmX4Kr4F/hcpcIBh4BDlXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq8DlxFlb7BDQzWlMSBfWnIKDqaPp2kdKLmnvddyEyGO/gW6kW
	zJWwIpLfl+9d61bIsUE8s8NnDKPoNkPxmmHrKa382G79c0vvB7KOfzVvf24xK++qPnZJPZpMWKz
	GmEiiTMewvDDAF5+iE9dqUelKbcyPNRUbQuSL
X-Gm-Gg: Acq92OEzb3GZIRn7/rKQNPz6MqGEsFFbuYBoPakqL1Q+zlgIbAa3+rCL14QooT1ItF7
	1/VOwF9fYVyWrnUxfSWYJgXcYu0eWHklYtP5YDjZU+nuPQ5G7VRpeAj8E5Pa5MBbaf6ewBLDg5H
	0y0IV6Aub/0kjD/Tnc8tJKwLXzdKyvHz6msgi1kIXlIxTqOmc+PYtUzT4VRo2lW37SKbk9Xg9PC
	cuMz9ECk2FW1yXlqw6WxCPqrhmyFDvWHKfe5Kt6gomUdZALs3GihF0iTQe4/JbYeINTWoA8sCIL
	mywXiBllGqsRLCA0Kw==
X-Received: by 2002:a05:600c:6592:b0:490:a1dc:e542 with SMTP id
 5b1f17b1804b1-490a2904ab0mr275922295e9.6.1780381409619; Mon, 01 Jun 2026
 23:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601034148.1272080-1-maoyixie.tju@gmail.com> <CABAhCOQ7Sd2G4ZVwNUK7i6cF7v=CwhcYosvYAgopb=32aNimZQ@mail.gmail.com>
In-Reply-To: <CABAhCOQ7Sd2G4ZVwNUK7i6cF7v=CwhcYosvYAgopb=32aNimZQ@mail.gmail.com>
From: Maoyi Xie <maoyixie.tju@gmail.com>
Date: Tue, 2 Jun 2026 14:23:18 +0800
X-Gm-Features: AVHnY4J_sOxDZYbF_hzxFAN6WDTC4_Z74hTDLDHSLVwE5BKSjGzP4QlCsca9gCc
Message-ID: <CAHPEe=H_7Cbz2-QQt4fTM-tAUNnRnm4wxRZ+TRXHkz9Tdqkerg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: require CAP_NET_ADMIN in the device netns for
 tunnel changelink
To: Xiao Liang <shaw.leon@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Nikolaos Gkarlis <nickgarlis@gmail.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Xiao,

On Tue, Jun 2, 2026 at 10:10 AM Xiao Liang <shaw.leon@gmail.com> wrote:
> Should modifying params that don't affect tunnel lookup (e.g. GRE_CSUM
> and GRE_SEQ) require CAP_NET_ADMIN in link netns?

ip_tunnel_update() unlinks and relinks the tunnel in the creation
netns hash unconditionally, even for a CSUM or SEQ only change, and
ip6gre_changelink() does the same. So every changelink writes that
hash, not only the ones that change the endpoints. That is why the
check sits at the entry, and it matches the ioctl side in 8b484efd5cb4.

You are right that a CSUM or SEQ only change relinks into the same
bucket and has no lookup effect. I can narrow the check to the params
that move the bucket if you prefer, though that means diffing old and
new params in each changelink. I lean towards the entry check for
consistency, but happy to go either way.

Thanks,
Maoyi
