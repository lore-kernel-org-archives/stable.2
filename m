Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795662125;
	b=i4IRthkK9DHA2dvh/ek6BmRvuEJXG2sruTgKAWpHYw+IG0rngATB0CuaePXctD19aQeI
	 +KRWVlaGPLDcKqtT7KHxgv1B36G/kCzA5R1KXOWTNs36Fni8ylfWAp5/o7lOt4WTysojv
	 JKqNcKIVim1ZpnWP9A36vDTQCWxZnmUyejBp5IrG6YpAYlcHnHR2i+52ET3jee7IBZBNa
	 l2E3H9yUB4S4IafO9hO62OjmFaFryHMmzRmTYFtdkGPiD4GuTB7aNYwQkZg9NYv7QTc3N
	 VPyWbdZEH19iCwJhuZTCVqMv1+uHLo3x6n8ClJMESNgLPb3jDnk21JjphvZfuHehucw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795662125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=Trs4YD9ebzkR8KxzgQ83eqnmWNUmqxqu7WDLYndosy0=;
	b=0Bj7Y0dm+GdAp2kPs02am2Z70y5n9T/HePfx3XL+r5NRuR7fDqJj9n51M2/5BVF7r7MD
	 anDTmb4pMTSGg6OHWvTArGbNMJJpHmJ7jKnvjqXGdBWqdaHiIZgNtehmJWPZFu8voiizF
	 8i/LMMEioWAvLfH+e+vDECFpQZyRK+7Jj3De7z7KekjX2J3PyWFHP0icxtzjXYGtnCeIv
	 ovnxIeS0gEjGltv0zUaIkhAGRSIPrgrt+a4rKZXCjPZIP1t9rBNhTgDvtOl27a1pxhBEa
	 DlmZSQzDbpjC7CKtQ9/x0yJNKXWVkVeR18SQN/qDbtIUpM7VqImFkU2sw7D+CXEEwog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=luxonis.com;
	spf=pass smtp.mailfrom=luxonis.com;
	dkim=pass header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=jitGV4WQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F856606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 03:02:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F856606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=luxonis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luxonis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=luxonis.com header.i=@luxonis.com header.a=rsa-sha256 header.s=google header.b=jitGV4WQ
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b8c60e0d39so8409361a12.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795662124; cv=none;
        d=google.com; s=arc-20260327;
        b=NI6APv+R+FM1HUPo2e5zCU/re6u7Ru3qnUXnUYjsPEL8WUqEPYjuRmN8eVlSu2uFOB
         CV6t4ab9RP4/fwBi0x9ShmD0mXmYmJfpGmEBAGloEdz7tjDr7ciYcyhc1EFe8LADmoJN
         p863lKnM83R/nLLmmN/PKUveeVgy2bJ/DYmhZDQmyAoEgo1O0ngwcfpYG/lHocyDA3L9
         ngS8sPmFOERYJ2HRG4SxuAoTBAu8lSIUnRPFnmGP883cA4QpFjFe+Code8haYxl/qds9
         c783IwcJqum4b8GSQdfoguDjHaNF6Cuu0ORcoQDQT3/5+2stUNX9hUmc4FYkkj8fr0jO
         5I0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Trs4YD9ebzkR8KxzgQ83eqnmWNUmqxqu7WDLYndosy0=;
        fh=pNwRj13b3GlyDqNdQ+zJYF8N9GO0NI7r5ETJVjB9IoI=;
        b=ofDY3jas7ydlbJNkfW2KVIzqlnfgFbK16SQiRD2doalNN4n+uMjHz4SHY9ZoKYLsnt
         19nuEmNF1oO/3JKnwv9XdkYQuqzdynG8dsmU+/RhTdNjOfq2ABOgf3dIYNavDLTIwDOj
         0JJjCV6MT8xyOTmJOWgjade4Gii8T4a+z1wR/crIzgV17Z/Q3keNgSsLxgEVUNjShu9g
         5R+VYcJosOOgg3B/0VBJeMMtEZVQwR2HitXLhKICksTre9D3VotPRU/SclKWTS/rdsWu
         YRwDPU0cRNggrxCpUYykkQAs7Ef+3/ABNYCtMUdn6s/NLzOD1Nj6JooOw/e3Uo/ZwISE
         mzHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=luxonis.com; s=google; t=1795662124; x=1796266924; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Trs4YD9ebzkR8KxzgQ83eqnmWNUmqxqu7WDLYndosy0=;
        b=jitGV4WQr4FT3T9+W4HHzzJyqGPoVKzXEDZsfAX+ERHJSraxnN7DjvwPnhumYhOX8J
         NNeYVPbzCmSfzGl4hrZy0StzlIVw4AwGjFjooCnnvXzSkn/wjybfcuZVYB11k2cmEu/h
         m1QfeR51ImQPOnakDntv9BmpjFRCg1M/1O2BALGojrVcqWqy5wyUSovCKZqS31VUERGG
         BQ7D+FgbLAOkfMoTrd/rDtUFmaFppGXCHRs6kWd0Y6xpZzWZYSxAguBFt2zsGgllBq9X
         zf2VikZ/yZs3EdK82kprKDsiQuYnIKqZfvmazO9H/jh7Ss9Ibh1WYIn1hxqDS7qGJ2yE
         L35w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795662124; x=1796266924;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Trs4YD9ebzkR8KxzgQ83eqnmWNUmqxqu7WDLYndosy0=;
        b=RfJhsXSN3oq0InxmW++oIYSzEwvzp2GZ+7TJETgKvQKN8SJLXoCeiiTOO5mHXkkred
         F8ZuojjQjaJ2xI5SuyakC32b9lqIxQ+6jEN2Z82e38fXK7WAwBA05dxK5+HWznJFQLFm
         g2GFxfrLm5AWRHS0qL3KkwRrSqAqNDOdJZVxI15y/tEk3hbwEO8sSH3+CjnMJOgySG3j
         F4vBKaQPdasawRlkICWsMi3Gu0mVHqhLgdqYQnedwpuFpRpf3tPmwnwQIc03PCnyVLtc
         XK0pOnAqVwzyTCJP3rsdp/SlZDusH1Q4PU7qb8bRrC4aaVKEXoW3LPpFGXjgU2E+ZS/T
         9vVA==
X-Forwarded-Encrypted: i=1; AL+hErELVDahIWrR0k3pAaOzomDczbe5oKNaKYMWykQWODANZs8kO5gshdLLSD1bwcZbWK4Q/Z5D4Tw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8hwk0om4COk3w3u235rbl5BGoJHzAF8k7ddSWloehByW9bnr5U
	Tlaykwi0jNuh5vPq1FIdMeqDKpjOondBG2b1gTmM4VD2kpOMeubnfcp7G4CF9a9ypSvBNAfHewt
	rUW/kuJg+dklZ46h4KVUhgldWNtG+BjLFLcSOQbn/fg==
X-Gm-Gg: AZFdTZcO71YuOxQKpltX1lx8tuuE0tXz9goCdMggjN3Hwmbhan7Y+A62eeHceR12O3c
	aSy5My4WRxNnqDZpjHdvlkPWNN8ep7AERXP/XQTaWfYAsE5bfyD5jJyLXksjm15vMr53vxWoNAO
	hAYs5KaFWiLfmCSV6/Y0QyTLUvJq0fwDQ3oNCA3sAEdYc57JbJw+uC4gGcfjXKTlQ0JRxnAJXro
	LaozDa8/KmCkrx6U7q7Lpj8FrpZELgaxnwTh4JwtEDIFFSvhSPkT9hE8jK9EyYaQPQ0jyurvT4m
	YNywU7RD4FTMpau56Zvig5NppvemAMnRZ4iwKb3rmAaa0VmMp/Ln0TUVw14eOfftu1uypsGSSaJ
	bXo2OEM8arSGn9fhXPzjYH6X0HIhX5P0/IauQxtdB//JrGOrWnGVSsjA2+Ohwi9CL+DRIbs8=
X-Received: by 2002:a05:6402:210e:b0:6ba:9c98:3f4b with SMTP id
 4fb4d7f45d1cf-6ba9c9840b3mr9977001a12.27.1795662123877; Wed, 25 Nov 2026
 19:02:03 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121073652.410916-1-jure.rebernik@luxonis.com> <179559320769.3135.10021676764558133789@kernel.org>
In-Reply-To: <179559320769.3135.10021676764558133789@kernel.org>
From: Jure Rebernik <jure.rebernik@luxonis.com>
Date: Thu, 26 Nov 2026 04:01:52 +0100
X-Gm-Features: Aa3M54peN4hAIHnDOSMeix5BdpvlNnY8Qphl_DV5K2Keja8xiPJqidp04Rp5M78
Message-ID: <CAD9jT+p2nvSpNJ8TA0QCJKW-_8ZV8ceNEXRTA7e6OE42RpDkhg@mail.gmail.com>
Subject: Re: [PATCH net v2] r8169: clear RxOverflow before unmasking interrupts
To: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Sunil Goutham <sgoutham@marvell.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 25 Nov 2026 07:53:27 +0000, Sashiko wrote:
> [Severity: High]
>
> Should the RxOverflow ack depend on napi_complete_done() returning true?
[...]
> Could the ack be tied to work_done < budget and moved out of the
> napi_complete_done() condition?

Yes. I reproduced it on RTL8125B with threaded busy polling on eth0 and
the NAPI thread starved by a SCHED_FIFO task for 20 ms of every 200 ms.
With v2 no frame was received for the whole 40 s in 6 of 6 runs on
three boards, with IntrMask 0 and RxOverflow set, until busy polling
was turned off. With the clear tied to work_done < budget, about 65700
frames/s were received in 6 of 6 runs. v3 does that.

> [Severity: Low]
>
> Is this statement accurate? In this tree, parts of rtl8169_poll() come
> from the multi-queue rework:

Agreed. v3 says what changed since v7.2, where the patch was tested,
and that the changed lines behave the same on single-vector chips.

> [Severity: Low]
>
> This isn't a bug, but the comment presents this as general chip behavior.

Agreed. In v3 the comment says "At least the RTL8125B", and the
changelog says that the clear runs on all single-vector chips but was
tested only on RTL8125B.

Jure

pw-bot: cr
