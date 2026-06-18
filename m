Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9362E737B
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 20:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781815831; cv=pass; b=ShhAQeJxACsIpDj01xE/Qz+VlJ8xl7anEyunJYXBnDWpSY81F0EHPjTuUo19uvKi4bAXsFqfu5+Y0fadlLaUx2mRd/wlwwXUTltlUHLErFmrs6rsG9uF99D7KufYHZa430AC5M1u/FUyw1b4I/khV+3yhVtzETuYkCbOr4EnRLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781815831; c=relaxed/simple;
	bh=N7+ML8b+QHv4xdu2zCfe8zZhdw3YE/RabD+YMSHfnCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=szrKN5bCNxi19T2SnNPftcE+GrkO8i1i91W27xR/V6kYA4lA5GJdgEpucZo7UQT5SVk2ZkdBNABS4+gLObLxES7WZyLH23MXfpyCQhP7zirJIcl+t3qB9aH/wxifFAXj4hyVNt6d1dfylsl/nrvAB1vrFNlXc881acwsDdf63Dk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mongodb.com; spf=fail smtp.mailfrom=mongodb.com; dkim=pass (1024-bit key) header.d=mongodb.com header.i=@mongodb.com header.b=EJpP9pwA; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mongodb.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=mongodb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mongodb.com header.i=@mongodb.com header.b="EJpP9pwA"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-68bfcf11050so2387727a12.0
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 13:50:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781815828; cv=none;
        d=google.com; s=arc-20240605;
        b=O7+xLbE2cjNoWSw9aqW7rCcRlNz+JdsrPQjUTphnOPEXZhDbTjldkyaN4/XT87L2CN
         wKD8rzB1MOrRLD7NY4yrSs9dJoKf89Ovf4s7TgUNzwPXmrbd5IZJKJHJ7DK3VVfyO7GA
         cCNmxmC4DEMxnH3USBtXd5roHALLJpoL7yBYPehsybmoh7+5e+O3fLdlbYc6KbHt7CFZ
         /s+jb/xvhg1fSGVrVsGZcrAZcyMc9PT5bzuG4+qtU18k3J575oQpAmzxueSGAIdaFN0f
         xav11JXtMl330yHy0O2XNABpxwylRAEF0M45DsH5rRSGWBQ4uuVUqSAxYmHASp2rEYu3
         54Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7+ML8b+QHv4xdu2zCfe8zZhdw3YE/RabD+YMSHfnCo=;
        fh=F49qhPvpuSxSz5wBw+fqBqyjDHWRdpkJ478oFBD6r7E=;
        b=ZDB+rgdSqXZvM3NQ2ilJvyLHc6P+d/SQp3PllmA0Knscv7ZfOo2EpXIMFrvEqivL2u
         3DS50oCkFqY6inkkdOYIw51vI0Vke15tikJFOHMDBaOk5XaH7N6Jko0HArpk3xwSJuh6
         2o80WUEFMkiMg4M1GbM9Dx8pA++lchzTFmhoit6x5C4JGDAmcJt9hI8hF5FqbWxiCtOZ
         4Zb6LX2v4xAzoVQKArrBLGDjswWC9VGSgetj0asyoi2vHF+HVo0AEjuS6pNC/b/Q1ktt
         KA23cBWogaZNanbNvFgVMRrXGw9O8Is91IcZlhum6LFL2pRUfbdZiYWs/ZuSvzkPT1Ar
         v2OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mongodb.com; s=google; t=1781815828; x=1782420628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7+ML8b+QHv4xdu2zCfe8zZhdw3YE/RabD+YMSHfnCo=;
        b=EJpP9pwAYu83Zh2Rb7S6dpMJee0yu5At07YRw8qcMg4QjxXDulrnCIy0C+9EeS0jM9
         d2vSnc9Qdy29T40isS+JAuYhkdIDo9DhUiw3CPA2sKxsUO3sdgSE5YokMBiy7hxtSSN9
         W4sUap7cKZ2IqMuLgpxHC6QskxhjfBs79aATs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781815828; x=1782420628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=N7+ML8b+QHv4xdu2zCfe8zZhdw3YE/RabD+YMSHfnCo=;
        b=mtfBKZkHmeYazXlkzmBoVE3J1jRX3uk7j3x8CqDeGU43x37SatK097GfLEi+S93N1v
         40TrdH124QPaZZ41423m9AWTdOWxXl1Kzhwhwlp74o2yvV7FoClCW4B5NPM9fjR8zAdi
         xP/VGHL0l5r5psXrQ9nOw217CsF6aJD5MejT6yTqWaaAgMw/m1YsP5dP73G7SlxWB45u
         2WfGQAUg8v4N7Xes9A6RLJ3sJJ2PAgTeirowfdvWrnKrCVs1xgKLPKU6y4FpDKC/qNMV
         nqTc3ACarr044Tmk3ERZ8fbbY6C2CqwKn3lEtrKv8QHGMSG4qmOKt/ZOH0XIkquGUyZz
         ISRw==
X-Gm-Message-State: AOJu0YyBGxrY2ITzAM3GSt59ZTV6K8sBB03TmYHiBffbExCp1Auz+RvA
	sWkF+DckDiK1Vf80rix+lXOS0W/e7ajRZRe+/LyA9mXGY7Y1T+f1PcIHO4D1NTLjSimeSy6pmQs
	4cqqiZttaZgUTauyp1NeE+uFZC8ez2kbOUxXs07020w==
X-Gm-Gg: AfdE7clFqR9I3IYn9cMOrl+z1WMDoXe4e7pbwKd/s+24ZJXAzEmlZbliAKeLbtTif9S
	jZtJarR8xKWzx+g2pERDw/4svDVgUGPfyuZTLbW8oxWbJVamyDOD4QB0mSz+Ih7slFcUOmcuDwX
	bhtd7h7aug/IpwMDiE1PLtYSyi3F0qvw5g0xaqTTSIlGZnMVKehVhKRYrAbs9q7W0T6Wwuc6bU7
	KL375jrUuHWffW2JVFPLxXL7ST3E6JXQFfshs1T+wwYrr/zcQUAMO+nwoOmiJJ9AwAXTRIVYDOo
	f+CRhd3mdfm63t4=
X-Received: by 2002:a17:906:6207:b0:bfb:1853:c34c with SMTP id
 a640c23a62f3a-c097b389874mr40144266b.14.1781815827926; Thu, 18 Jun 2026
 13:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618151426.308099-1-mark.rutland@arm.com>
In-Reply-To: <20260618151426.308099-1-mark.rutland@arm.com>
From: Mathias Stearn <mathias@mongodb.com>
Date: Thu, 18 Jun 2026 22:50:00 +0200
X-Gm-Features: AVVi8CensPWmx9w1RaQWAU0DXlTxh-QWmcYKTBcAjsiIIZ-rezr9iAxfVStsHb4
Message-ID: <CAHnCjA3HBwt-rtgmyfanu9wA0eNc3oQqHemPOwUVfp9kotuEwg@mail.gmail.com>
Subject: Re: [PATCH 7.0] arm64/entry: Fix arm64-specific rseq brokenness
To: Mark Rutland <mark.rutland@arm.com>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 5:14=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
> Mathias Stearn reports that since v6.19, there are two big issues
> affecting rseq:
> [...]
> The other rseq fixes made it into v7.1 and were all backported to v7.0.y
> as of v7.0.10. We forgot to CC stable, so this patch was missed.
>
> This isn't needed for earlier stable trees.

What about 6.19 itself, or is that not a stable tree? AFAIK it isn't a
priority for us (MongoDB) like 7.0 is, but I felt like mentioning it
for completeness, since rseq is quite broken on arm64 with 6.19 today.
