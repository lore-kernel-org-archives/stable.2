Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793351752;
	b=DlXHTCVkCHCaAiu+PBXJtulxCXLS9U4/fhaBm5LQ0Cx7u3DyShXh3zqhJKn3Dw8BABsN
	 hJ4cl4nsHSwJT2YypOX2XBpl+OzkDgw4ETwQamOOKCSQVnhamHzjB5VZqyUosQhiCAToN
	 QTnHCPflhAgQ3Bn6nEkh3KQRfDQVdli16FLL/ZlFW9+khXPmvVkKrEF72kBRXanmxNa9b
	 3wTWlNz5kvGIgd9zKoJE3fwTrHVe59OfCrY5Y5ksZ7ZDentxcO9FFDNcta+c8Ym4UwmwD
	 MI53MFlFf7VDhIho4dboUbrj+sjeVjHzcuKpF1r1PUPzgqqHlYGZPkN0Oz+rBjKRIsQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793351752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ic0l6s4/vCSv2HTg51cnmOpg7vz5TShRFb99sP2LwP0=;
	b=p4H7kCQdX0NKPZq1Sf9x68mYBkHMggnoIRbC5pp3c3nkA1Q7yElsNLYWjiXwFowRyT02
	 L9l8P0H4IRufAn6322n+bAmkLbTvlltA9ZhgQKI6+DYtWsmDmreYjWJZlbweCcko9+YsN
	 7GifKKxmi/RTRPIuahMxGYj0UjWAuDhG0fzzu1a4/0bC/4TjQSnnUip+Q9MgBB++3KOQD
	 wXyoh9ubuiT4ZxZAbZCx+uL8Pa2GRaHzRGJNytMfBFsFOOu6iT2XWG15yX7eAHLi29Eel
	 0CWgHgUCIrTsipc88/7UWu4veS+zacAexltJR3CdrQrz+ThWq3awl+dr/iscdA5Tcuw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfLBsasI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.45
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27515606A31C
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 09:15:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27515606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qfLBsasI
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5be42ae8eb1so279816e87.2
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 02:15:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793351750; cv=none;
        d=google.com; s=arc-20260327;
        b=AN13onOeJsHcmUDsa+W5yIR48niuQ5h1GaIQgcGfAZgB3LDgwW19XbXPTJ4URNOWzA
         Y8lrPElM/ZzKkcirubpKeWhdr0JcOTUhQUhXHSijmHtfTupybCQvbNStIlS2tiGdLrsZ
         RsPFpHwduRiTJe13CDJTN2zAihKvi3M+cIto7jVMyNQiHEyeu4zTatK+Lgeww92E05wZ
         w6quz6LlbkRFV4H974XXD5DKNMzpwK/siIUEvUG31085A1SBkTRjSKm3gyYQHFgwG3jj
         XehI6Feki5/0cxtNhU624OLsDtjcOiKkdUS5RUbE24F76+bgOQhfBaACu8ZPkuj0sSJE
         sHdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ic0l6s4/vCSv2HTg51cnmOpg7vz5TShRFb99sP2LwP0=;
        fh=+mcj2rhwfY7JICXH44Az3r6URIcIFviK750oKwg0hZE=;
        b=MFSFbQrE1+djuSb7CMa5tGxU0qqetGHzdd7OnbnruD/5QKhc+RVwgIBCiMQE0GL7CN
         Djyi91VBXgy9HffF9Q8YGVrsH7X3GybDuBV8ChdnpsuymaoJqH60WmneMf/49A1pX+R5
         1xCiETwaJD/HBW1Vx511YftYgHG8eK9c8CE5YMxMuwy8KkeqXcOF+iVnkmnBPRLIG617
         +veQN0gi4sRqrbbaH7d7EhgP1DrR8NcMImnAAd1AA3a4EcFYrvC77MmgRzoWfD1druwi
         horSyh5mHGNajB9lqNt7nhg2hIRj3S/0c5WVmKtJDpLfHEpGUL9O3Lpu2vQkSHXRE3g3
         wpKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793351750; x=1793956550; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ic0l6s4/vCSv2HTg51cnmOpg7vz5TShRFb99sP2LwP0=;
        b=qfLBsasIj0ueC2Rm80cM4nkkefayvn27KbmgG9N1xFUzMEPOSqzCiMGte6z7f09SF4
         QmWsSi62JZAp1RCu0wer6f6lUJX1sJ82VugRSHYhS8MY3FDXFsBB/dBcPf5cY78sljLS
         29tbFUMSzh46Yk+v0t8EEiyT++a/3d1cuXI6gpTD/vwdTq6cONvNdeZsBWQTIt4qQPEI
         g0jTMXVQjRwnlAANKJN6lmCYJaFnWZTIOD11otdk2g0iz/rbU7Jly1s8j0J00HNX/cyS
         m4urrgVCOlPkuR9hRQpEhUNOot9aqiTcAYJL2bCL1P+kYfL3FhVAdBp+etp1DtqyniQW
         vZnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793351750; x=1793956550;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ic0l6s4/vCSv2HTg51cnmOpg7vz5TShRFb99sP2LwP0=;
        b=Ik/9T2cJNqNxCPUjwAsygH+FujXYPuuzFXPZaG4xitmBPh0chxTX9nFXov12uSTXmT
         WY2sAsILlcSz0NaMqjNVeHzU2+Mbb18RHU5+8LxrgaJ/bgJgR8DesmP7Et73GF9gDDkw
         sNv2IC1+PXmrBJiYGwR528dXvh3jz8ZRshxM/xX0tlg5kop1WX8x4ehH/hmdY0lSHAtw
         17sGo/EdL3RkdAAOfWeoZ4eh6qMjzKThM4znfH1ZDDRawwH0yFMzrIbOBubajW3TMwD4
         dWG+xTETa3sGrgyDvQK4JzpkLVSKZJ8SJe4ypH9yEbORfluimYMIgzudov3FSQjNqpor
         dSzQ==
X-Forwarded-Encrypted: i=1; AKwUvBxG7+x3w86/KhiCkkkWeHh2E5KxVwMYrJ1pRxWeraCGvbrrCWONNtUnLJE5i8Vd/NPO7pfzcEE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ5ycdLXBJd1zF20cLcdDGiD04PwAktTkYnawdDKtHxoCb4f9P/
	CkNxhTm+49ONbpqKjO3w9rPN1UKttGVX33Mii0/6sdQiXliwiQBMC42tXw0VWJObJfyHzo97Kpa
	YLnROVgEXGsfLKt/u/P4eGqeYf3NWKqM=
X-Gm-Gg: AYBFou0VuzuGDygb+aZX4gQqYsfWqsNBoWp9Kr6/7mDoA7QA3//7JqZ4nrYsJXhNQfF
	JMJPxF6xWQA551ZZvqQmVE3o6r4Pfg3vGe+tXwg/ysGXS6ALMkA9OrYyoOpdP288nhcP+390vRi
	Q9WOooxE8PEdKINjHhStssBqjgfetTCqQ470lMxNshRc66qAPvTR4aXiWD1nnRnt9Jw0UXJciuG
	4MU3hC9p6hwwtdZfy1zuMVdkhJYKymZhED+fAUimWvpfxGNY50edA9i3junhDv8uDIUg+Vwf+UN
	dzDWwva2cd6SXE7A4nAJ6XTdGRY1cBGlhEAPfnQzBKKWlS+aETYkJLQssLoIhhSdcSFKz9F9gmK
	IYbtgEFrWrPQK7EByou+OhnJ2BQaqUrqQHdM97d4FfVu9rcbOKo8pQ54jL9f5QhF0nRtqW4M2g6
	/u53FyEv3y0+f7uOWIOa2HuJSyLUExu8MkO4kmKkxQlKTinNGLNWQ=
X-Received: by 2002:a05:6512:15a8:b0:5bf:a352:9c25 with SMTP id
 2adb3069b0e04-5bfd95200c1mr558923e87.5.1793351749887; Fri, 30 Oct 2026
 02:15:49 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030023248.78802-1-testwrzwrz@gmail.com> <20261030023248.78802-2-testwrzwrz@gmail.com>
 <CAL+tcoDUGqk-KfMBqdG4RBURHQc=9J+Ce7B7CZZWRN5yN7pRrw@mail.gmail.com> <20261030084017.16202-1-testwrzwrz@gmail.com>
In-Reply-To: <20261030084017.16202-1-testwrzwrz@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Fri, 30 Oct 2026 17:15:11 +0800
X-Gm-Features: AclHuK_tqEbHK_O2Qvnq3pma3G6-PFR5lcMFBxShPN1h2GTemzUuLTxLrhij11k
Message-ID: <CAL+tcoBThTe7299eVU=tsUdi392dS9cioXX5RA5AKRsYAGbdVg@mail.gmail.com>
Subject: Re: [PATCH net v4 1/2] xsk: defer software checksum until the skb is complete
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, stable@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 4:40=E2=80=AFPM Rongzheng Wang <testwrzwrz@gmail.co=
m> wrote:
>
> Hi Jason,
>
> Thanks for the review. This was a timing race, not intentional: your v3
> reply (the Reviewed-by plus the else-branch nit) arrived at 10:30, while
> v4 was sent at 10:32 and had already been prepared without it. I should
> have checked the thread before sending.
>
> I'll send a v5 as a new thread with the unnecessary else removed, exactly
> as you suggested, and your Reviewed-by carried on patch 1. Patch 2 is
> unchanged.

Thanks.

Since I'm not that familiar with the selftest, I would not comment on
that one. I believe Maciej and Bjorn will give their opinions, so I
highly recommend you to wait for their feedback on the selftest patch
:)

Thanks,
Jason
