Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794054531;
	b=hHsyj6vMO8iug5ym2G5+6as09EjHfQrXS+eHueW4LmgAtSkP5ENeLWKSkQ0z4+sCxK3k
	 1XjhVHsOA4yj0WjdADW4YsYify6djY2DB2OQ9iX3hSaL5h21MOdjzPC+pqa3zPHRsgPcU
	 9yI72Do65lfO6XNLMCRUYV8RxWS+/Ts35iDvePxJsW5s0nD/0XpwkL4h0Mbl06w15mdUS
	 KtteYcvt/Ljyg4E9n2KvH8yLI2l5hEj14mT/M6A2PYKA51H/VOwIIzJx+jEXgj5WrtuqG
	 0hxhuy4DblwIzojf3naeoQNhJ3K/BFgyOvW/8fSzghin9kGog8ht6f3Op7MBWJin79Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794054531;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kqqhQOOhpKFm0WAAL6EVBEWg1MprAabf5CmAmHhP/z4=;
	b=wcrF65EZX9umsDPxuqJIJ/okfBc7JuoksHSaNphM5B5hFNYi5UTnFJqHlKn0m1ltvsMV
	 Jrow+U5qRifHeaoZlMffnlq9qvKG1I5FrOAZx2VELR7BtGU++h155y1gs13pOyyAXxZ6R
	 ZTEoRM5r2s3OcFRMB6qqZK3KNuIxeFTeB0Cxy6ZKjkcOy+kTSlbIRqPi3RlM/qHWZCLfQ
	 iwVoO/bG+56F/wgxqveGKSZT3tRco/6Ngg9Ay9Z7YWEHUMu5mZ6DWkUKdPOeQMa5lpMeB
	 51RzUZG8rSw84FmPiifuSKDJx2Ah2uV+f2EAeHpyNpIDJG5KRmuG78Ksf8HGOP0L2QQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YkyrqGF9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C23D606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 12:28:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C23D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YkyrqGF9
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1430eec0070so43379c88.3
        for <stable@vger.kernel.org>; Sat, 07 Nov 2026 04:28:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794054530; cv=none;
        d=google.com; s=arc-20260327;
        b=px61nZ2uIWTLwHDArSCCL+b5Wnd936SLBKmPvgaX9/u5Px0dtVPKNR/+A3aiKp6jZ+
         NUukDTj5rbqMjmPUTmzyb+u5Qcqqhzql8Xo+ohuOj6X59kS146HJ9yoz1PbnmOzLBed7
         INRSZwL0Zg9OA06UBEv5JfFFWlWCbVpmwnorKtxdD+ogGJJm/wsxRajE+5f4U7LIRpiX
         Oiaj1rlEf3C54WSmT0BEldnvFNJEyBgpTjxeL7XZyy1FclpA7uAqMhbDzJ1Jh0U/8iSK
         8HEkKkxnwcV69SAxomr9jzXVvvBZjmD1fsCD52yIDUOuqJqIXSzW5yPjr+9cpi2xjRO7
         JXqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kqqhQOOhpKFm0WAAL6EVBEWg1MprAabf5CmAmHhP/z4=;
        fh=YA3enfs5OXkPck3KYdsnVJaIi2hCprKwExFmmXNpxiM=;
        b=GPGjrYhM+jH2aQcMqtTpytBIsn7yoU3LHG1MKuv8suVsqB/Let68kkVreW31IXRh7B
         Tl1HjOVueAKilnyLj+wKLivovORL4UiqmYC6EcaI/Hxs09ByIfgzPMuGyQaI8MLWl0+1
         PxOvSy9a89t9+fEGc8uKcRndG0dw50MZ1XbZ9yzt52ef0G9hqinebU6OcGos9NlQUCOn
         biPdOkBxtoThvxluNyJVC/QmoB0hHqgwvbUFnC5vCFt1ZIEfRw8RVdWyS96R5dGIwnaR
         ErBi7pgUSZCB7ag3QQ/AygRzF0G9hlqreEK9J1W6OOOYmSdyB/H8Mur0F67f8znuFeBF
         x62A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794054530; x=1794659330; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kqqhQOOhpKFm0WAAL6EVBEWg1MprAabf5CmAmHhP/z4=;
        b=YkyrqGF9Lh3Dl06QFZWU3VMT8cfIrJ7v8pLrwuDx4BZAQryBDy0L/R8EfIwUCHuSNC
         8Liv0S7gMhrh8LLNQcuB28CaZzmH/uxS1IJrlFMVfz6QaqTT8H+Uo/HqdRDBFWqWpwUQ
         hHeOnKIPjNSLb46NigGWAaR1Fj6aHStfkmt/AiyJwW5rNk/vGjVDB9cKu2nkFaERdYrd
         r1DDjwEwVgpe0ET48kA0XDgiKVxcDOjMHggPAxDGcW+C5ypi3k0Wa2fL8l7TV8cjTcd/
         ZWu8umimv+eLIYUU9coPW3XxHWDfhi2z1qRWW/8NYEWTjS441qYkCw7PYGh4GxYAsusg
         u1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794054530; x=1794659330;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kqqhQOOhpKFm0WAAL6EVBEWg1MprAabf5CmAmHhP/z4=;
        b=ava0SGovXN5RXrQR8dpbb9Jxtd5vdqtnBYsNV4b+8YMYvNj2qorvUq645JQ9I5XBwi
         iWRzGxnzYqfyo1OL0Vmda0LrYyOUGuUeDICW6ba7O1XG2BAGQ/QTrc4sOP0PRtnmh9RM
         D0+IilZYmSbqs4OTSR1m61gwieRMrxC2m1RBSit9pi3Hs+MW87BZkjLj+Innrz0NdsfG
         shaz/L5EBbxCVabpQ0wx6ht0Lg1Yqv48cwyHZIWeLeeAa4OdrxMk6i6CaYkMCvLT4ofJ
         guaKBVpWZgmoGBYLzkZ0btRMdeovNNUE9B6Wz+sIZ6K3EmIeHeeFk9iRl8fPmbX1l6RN
         wXUA==
X-Forwarded-Encrypted: i=1; AKwUvBw1AwT9SM/RHOaKFqS9d8Ai+4XNatghhd5ZcHe/g9kRJRKMn52eeE8JtZ106r4ke23xm/R5SZY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8h19whQa+fn5hOb3LPpswOafFlyseV5D1R0SNeo1V17YiHcnLQ
	LEo+AAKhsjZ7+Ti/CHnNToR2t+V1fP2pM2KLrTOt2Q8/hq4Z4gyQaI54GJZzV9Zfch5FF7NC/pB
	3BeQ7XkSxiowq7sTRbNFL8GK0014/8iA=
X-Gm-Gg: AYBFou1DQaL1KJaBUbHbi92R+vOc+1fwOv7q+YwSTdHezboYNpjjmYYo+nrAmjEZAN0
	hu38wxK8uwgfULG9jX8Y3dERumzGmMrBCklyCUM3N3FIi1r4HhugH4ecbC+VJbQEZxdg1QEWoAl
	VCrY3abN1HfmKfmlxCJtC8wmD24DqbOJM+TSzqCrjE6vKz07MKfjA0Z2Hn79wbd1YtlAsjCrBM4
	4UmLEUg6/gxYL7E167OGogh4yI5LYn5f4ulb96NaHDY0RsAQlC4aBwjIZUtVVEVtSIhb6eeT/8N
	QzcJh3BXQkDwvVbotRXK/ZhJKbi/f29oaNiAUqDP0Udc0ngBsOhpZ23PAvgynBgKrUqgk7QP6xi
	hG7sff7tFssEUswpyOWFTaVuqR9Ich38JQr0Mu8SemOUAyQuTKlSrnPV9l2QKBUqGGYApIoXRNz
	lg9+BXkNmAwfJyBQoFUhexbNfGcwUYueUZ6Dr2bM2kuR1L+Z+sNFpWu/vv/6HToL+RuPEgDtRp7
	y8AV3bPR4578EfKpW+WnY3vrNKXHIRTjNFH
X-Received: by 2002:a05:7022:4591:b0:144:fd17:3b21 with SMTP id
 a92af1059eb24-1b25d1dc9f5mr11348745c88.0.1794054530432; Sat, 07 Nov 2026
 04:28:50 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107061000-failed-5.15-6b704ec9007a@kernel.org>
In-Reply-To: <20261107061000-failed-5.15-6b704ec9007a@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 7 Nov 2026 13:28:36 +0100
X-Gm-Features: AclHuK_s88DnJ2ZOJiZWnbeOsZDWCEV-vaarF7cr5FrdKFYILKw1jNT1SAEcpLc
Message-ID: <CANiq72=WkJbn5v5gQove5zo5uKWYSYMNegmbNm-2GkhnW_-x-w@mail.gmail.com>
Subject: Re: FAILED: patch "[PATCH] objtool/rust: add one more `noreturn` Rust
 function for Rust 1.101.0" failed to apply to 5.15-stable tree
To: Sasha Levin <sashal@kernel.org>
Cc: ojeda@kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 12:10=E2=80=AFPM Sasha Levin <sashal@kernel.org> wro=
te:
>
> Cc: stable@vger.kernel.org # Needed in 6.12.y and later (Rust is pinned i=
n older LTSs).

5.15 has no Rust, so please skip it.

Cheers,
Miguel
