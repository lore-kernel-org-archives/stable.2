Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793597718;
	b=Q2Ae8LNWAgAQ0ZMrh6aeRKDaKscS6R9pHqLnyHQT128PZ2vmYg6pFJ9CzfoKxWqMY3Ei
	 rVChVBQzRxZPgfGaXJuv5wAf9W6f1l7gFa0qqzvaUQMZ7IQhxPHJj/W2hnqqt2NbLZMFr
	 /L5vQEgSDL8VPPAYqKyYBPhWRZon47iQnRCfc4povF7rsX781Ja9SLMn0RpLZXrLmsrql
	 dkQC/Zi1dPso5J/VeGf7nt83fkSaz/gm+BvonJJB0ZH69xSi0JjefRHBideIsCXfHrjbt
	 zTzQMhbrec+96aGTGU+qQ3duRXGxolXI9pshcThMvAp5mqSjUDzyLIFzI0edG/Ff1ng==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793597718;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=W+hC4F4hAwm9joqKZ+fH9u/y7V0gzk8Wl/nmjTnVbjo=;
	b=WBXYkspCqix13+JAIZP3uimwRT9L2uPdu8cHTpURturkIvVhpo+RtzDQvxO6KDyceVnU
	 V+QGS2fZPsARbif4WkDvaX/+LwtxZdTpvEhvKz0+9kh6fqdSACwOHZiMCv8iuVyyYa891
	 5bLMU+IZAL5LaV1SqweQyDURfAdgI/4wKAlxTwpSQzBTOpBmy/PlohvYIGUGyQZFJNt69
	 79vOmpfs2ORu8AZEMArtXJpl2tXMIwGB+V+yYGpBJRfUxaGc1dSPWsgurHT38KTIpvVIm
	 2PtDtJgg72i6JwQGG9GJLH2SkPEs48vQGyrsdO6L/DpmrOtU8XFkSCvsqFj0U6SkOdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fmdyJ754;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.45
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ECA606A324
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 05:35:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78ECA606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fmdyJ754
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-194d0c31715so5158c88.0
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 21:35:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793597717; cv=none;
        d=google.com; s=arc-20260327;
        b=BdD5a422B4uQymo2b1/f2/opsSSXMzrvKN49T8/+7hiZlR83FdXqA1eKc3afzJDOXX
         s8K3PDiWAgTsEKRI+w+ITREyZpBq7r6BUft+VrYY9tR2dKo8qfS4j8QESPo3qcSTEcio
         4dhoCJtEmzfX2UrigbBO6uhqxbMtuG7jI5Mp4rBzvdU87xgbzgD1ejMhjWPtA7IRuGOm
         p4zvuxTAYJC01FAxuPMRui3/ypuse5zaFKbJPwtmHwx6Tzxd4O5Z3vibmDJt2ngW3sax
         sdi2fT6PxXB/zGGDm8Tm9tjQPpID/JYl4I46ee/6/J6vMHKiB1Wh/zDHedR8oFxVvBPD
         ymNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W+hC4F4hAwm9joqKZ+fH9u/y7V0gzk8Wl/nmjTnVbjo=;
        fh=SaqKmYOsBYP0jl5aT73UE8o6O+zWvFvPOp5cSSlKPgQ=;
        b=kPoDNtLhgAhV7Kyg/sHoLfF0zlHJIRyK25HcT5qfg2IkMCCpuvqb8LpwZ4VJkwrUAA
         UNDOiphLs725prG7wBQ2BKaVE6vAtF9jPfYM/rBXYb+u0RCT9oGxlFfBJHtdPqBDraia
         IOhPiqkH3hoE20DZ43y7KnLrFE9xM5DVurOMT1p5w6WNF2uo/s63zkiUOZPbmbXl+4rd
         ochZm1szzvQf7kX/z5By+ode/wHcz0RASbSOtE501CTqyoOysUkGJceZ1t4mBp/LWSbz
         PkEYqViWXiC5/DPnLEm1/DnHMcsT0BcvwKVyF5O5t2AVPNu20m/od8Cac8zM3hWKkkV/
         qXyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793597717; x=1794202517; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W+hC4F4hAwm9joqKZ+fH9u/y7V0gzk8Wl/nmjTnVbjo=;
        b=fmdyJ754kn8kQb08UapFFp7Y4BX2Eh1Y3Jgny5fZicf5JJJLvOzGqt9ZbZzp+NTXli
         xTayNRuW5WBMZTqtt4F1c32BOKZszQAUNojSaopbnCh3rBO12wsZk+4ZbqreGwE+n78t
         89g5lFsfXES1AYwvPdjHGZsMHkfu/b0BaWAvd3HZgJDs1xohXiI7jus3VWwhbMwtXeIx
         dFjDG4Tww9e5zkVUcSjfx3UI8r1qaKM7zk4HMWYLWVlN6omL4i+p7DlEDZg6VcMYuNs9
         eO6ARqXdNGJ9JvSw0OjJP64iSBbIPlq/Iwv0VwO1vdxvjMBWU/3wiSIpryYCyAEJJ9Px
         7GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793597717; x=1794202517;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W+hC4F4hAwm9joqKZ+fH9u/y7V0gzk8Wl/nmjTnVbjo=;
        b=oS4xoa5k1hRbkGC8Sk6XRugIgEeQf/wcLxDrSlqYXcQA9z3bKL+zU7oqMFlyUXOrbq
         7RIYPGc/5TjIVqXHOmrhW4gYTcRGivEqH5WYfOOEPFKoma0DaV/hX2BQJD0HfadDlhpn
         YwIFdQ3dx9Az136oCVdXnHr2SnFxQjbbgiHOhG6cLrSPoDkBi8foX0lNZerdDLj13IW8
         x9msHOB5qAfqIskglXuhxxirOva/1qvJFbedqecxU3/2gFdMJNRpJ3EF36lxBjDJekDc
         bHAuXrFvMWixWmc6YsU1FVsazGeftu4gt1cOOsswkdCu94mHfVwbvjr7qCBIlWPzQXlK
         GJSw==
X-Forwarded-Encrypted: i=1; AKwUvByTa2AdIzeAjkTtkE2f36UTxLj+8sygfbkDSiXq+y8K+SQilsKII6TeY7uRrfCOsw+mnERnfec=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ+eogFLxqA7DCrWo2daHR0/bfcok2d5M/UFvAulMXQulTDZX89
	bWaO97MuDPE06oZYCHylyrL/GMMhixPEIrJY9LcyOqHhbeEh9ZnYtoq/bu9z8+U3yoqvIDiDFv1
	XEbi4KzI0AK8iiUyzjyWWoY51Q+ABGLWWNo94Epfc
X-Gm-Gg: AYBFou3W/dNsIwdVs5j8ZwRHoub09euqdTIdE9VhStAY+fLCThGpr//OFLKJtmZb/Ho
	xDjgjxT9rY8tD1rFvpyOCxSl/3TaGirUWqN2N4Knu3/aOScsPdKP04SJulN/GagrBPSwd4UO6JT
	fSI2ptx7U/t5jGCGsmwoi3iV68w9kuxEF/YP1r2HC8t57P0vLy0qOf/Jn8s6NNRvGYggYSmtn8r
	VqtN8sCPtnsWtOTsvFIk5dFJGCY2d5osiCNTiUpqYb2NupK7lXOwI6DCYfDBuNdcVZBtRIMud44
	iWyfU29WCPvwtt1Sjfo8Mo4fe6LKWz46Q70YK9Rmnl76qceNNp4GPT+eBvfzjNlX7ZqjUnmdZ4k
	w5bJ104sdoc7UCyy6GCl3yJqlDfPRgrkXV/KzJSBf6+fX1lYcoxPZTA4KU0mBfFuOcs7KGYo=
X-Received: by 2002:a05:7022:7f0a:b0:149:8916:defc with SMTP id
 a92af1059eb24-1a9546390a4mr1658978c88.0.1793597716672; Sun, 01 Nov 2026
 21:35:16 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101075145.698399-1-sgzhang@google.com> <audwphXNeZhVItS0@google.com>
In-Reply-To: <audwphXNeZhVItS0@google.com>
From: Ray Zhang <sgzhang@google.com>
Date: Sun, 1 Nov 2026 21:35:05 -0800
X-Gm-Features: AclHuK9nicuZoXvOoxzdD_K3_bDawbdxZQ3_9KfsA-zXkExzJY5UTfRe7i8Lwvw
Message-ID: <CAPqVEODgo=mr+3viog+bY1XOKHLcrEVhs4CtZ-SiSYT4Hh+gjg@mail.gmail.com>
Subject: Re: [PATCH net] net: count last skb of each sk_backlog pass in __release_sock()
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Decotigny <decot@google.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 9:15=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
> On Sun, 01 Nov 2026 00:51:45 -0700, Ray Zhang wrote:
> > Running 500 concurrent TCPv6 streams (neper "tcp_stream -6 -T 1 -F 500"=
)
> > on a 2-core Cortex-A53 (CONFIG_PREEMPT_NONE=3Dy, HZ=3D1000, LATENCY_WAR=
N)
>
> I guess you tested it on 6.18, but note that CONFIG_PREEMPT_NONE
> is no longer selectable on arm64 since 7dadeaa6e851.

Right, we hit and tested this on 6.18 -- thanks for pointing out
7dadeaa6e851 and for the review!

On mainline, cond_resched() in __release_sock() still applies to
!ARCH_HAS_PREEMPT_LAZY configs (e.g. CONFIG_PREEMPT_VOLUNTARY on
32-bit arm/mips/sparc, or CONFIG_PREEMPT_NONE with ARCH_NO_PREEMPT),
and landing it in net lets 6.18.y stable backport it cleanly.
