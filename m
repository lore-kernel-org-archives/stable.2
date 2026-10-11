Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD931B80E
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791736772; cv=pass; b=iCvoikuSzK3/Ef5z0iPR4RiyFZzlBucUu5hava5R0hAI8ElUIAWr9XBVQBn5YmWN9Jr3lNVIEfPPozMz0JMu3SsEwS1iETZ9sp+8tRdsKV6yH5BvO1xBXfWyZVPTxVRIF+wUyw2Q2TIIB3EdRBqAxCeEB7H4tK3Jf9nThQw7eBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791736772; c=relaxed/simple;
	bh=zBtcwkC1UetxURqz8HrxesKE3ZLqea1Q818EN42uR6c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIAy58AOoXQD4a33v2mJE1kR6r1Kq99k98k6/v+QCIPRGOJmDmY30fBiDgn+TtqYDT1rElxBuUC+XfoG8yNJPuL1Myepq7dujS5RlkiR0rZGlB2Wp0/NPBRBvylqpPxJHe8d7SO5/XgOIzeDArj59QBeKCWYtiNo8IreE5Gt3rc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Faz7hsFn; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Faz7hsFn"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-3535aa147d8so62932eec.2
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 09:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791736770; cv=none;
        d=google.com; s=arc-20260327;
        b=NVEe+VWYqEgIyYgRwUhqan2AIVKAHblaC4xmQJfg5L/UybxzRxCtstDU+vgpHT/VW7
         i44OB363HXiUeb/JQTca+vjzs+McBJn0r1VZurDHOd89tew1AEtxozbrTlPz6XJ6Jhw4
         VMRRNx8NZA7KdqqkY6LvnTBFppAUpujYFBpK9yRO4IlhCjo7WfZd5ZaVQV2pOQED61aR
         tfghLwClIZyPUvyf+F1cmcQLnshepf6AZMe4AGKZPT5Ke1u4ue26LILhtXKM+tj1Osg0
         Lt1w7Y3IxMVR0FdcT9OY4ZhA+v6rQfoyoq7xT5f1qZic1DCkS01aP1Xal08EFLhpoUTe
         QCjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zBtcwkC1UetxURqz8HrxesKE3ZLqea1Q818EN42uR6c=;
        fh=mg6IvsxJurVMOg8Fb/CGcas9UYwwzioDh5WiLqFI8+Q=;
        b=OA4EPyU9hTTK1I2xnMiJSksDMdOAaKly5rkkIA9QVLiW84DcFrkTWsYB+kiyMHX6lt
         IkdEHfgjRQZaSgCA3oY4GZmm1TRz7W+qXLOrikpzlmEZBM37K6IEOFluJRnuo2jjn0nS
         pLLnJHT4A4MyKfKdmwFJHh6IWKVEXTRDsp03+f+RHl/x5qRoHIePZJKZzLHFhnwVN32l
         nqI+VUSn8omYiwiI1Z92+tT0BsJ97iBApSY2iPLNbj9GZYiupZ3WE7OPEmlqtdu/DR6H
         R94g23nbccM+fHWj26tIw3C7aOZpolwk3RlPMEMuHdgMmKfHOvhuC75AlxzFfd+l7c+9
         kVrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791736770; x=1792341570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zBtcwkC1UetxURqz8HrxesKE3ZLqea1Q818EN42uR6c=;
        b=Faz7hsFnunGBHFqvsdNz3nQC3xV8RWVEyPmMPWEqWUFm/fOEwbqslWHwSqFsom4Vnb
         FVuoLwUkLAlR11Nv4GXo5YZlhc1mHd1Vwwq+uF4Cw2XpBb50gVe1LrKDgpAqhEchOWZ/
         OCehoGQthN5aPqFr/n47yXSbgUeC1ey6JGPv7b5e4mj1154Ri75TGeqvNlDRd17IW6Vd
         lF6uCPI72Eh3T1wTkEq1vZFBm5PFOpQ2YkNv6jtKMkWWH2Utbt+3UmJzyEbLs16+CvGx
         zLfQuePWe01+IWyHa9cweBCOlgi2At1/8KQxrRC9iGZETagFEUJUvdiDq4Izln8V58qn
         JndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791736770; x=1792341570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zBtcwkC1UetxURqz8HrxesKE3ZLqea1Q818EN42uR6c=;
        b=s1Se+Vc/oxS9jqveaXqDBkuzqVk90Kvv38T0fsyhVe2v9upQrSqzOnZ/oC8wgFBeC+
         ogQ6pEIQjaJAC3PsJBGGiDBjkp4S7nz4dtMeaZXdXvskiHmRLTzZMhfYDtk7JJ27fAh+
         M9fJrWdjfMMj8bN0nSbCjEkil5E7EIke0gq6Wnwbznb22Hid9sYhu3B8kKx0jjAr2TK1
         MFH2ldFUzRarWrFbom6LBUo3yfHUGSgovYgvSYZF8N4TXk3ooHwyCMPZ7erNQ2MMaYcb
         SvixP+GeRsiaRsfck7DuxdE76Uacn/AKni+svGhtKt9d1zdXo1X0hDWYbCZmn+094Klc
         bukw==
X-Forwarded-Encrypted: i=1; AKwUvBwIws2wKKlFhhmDdXomKkrzTmaEvjOskT1zQdWkJrpuL9S2/cB8qkieHNt9/u7k8HkaPOxQfRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYK9dLVc7OwiwjfMgmJYB0fhbkAgMHy2YJ82oNiRhC9a8DKnIkq2
	NRaSn6zHqUzUHbmqE0BS1shvNi5GUx4SSgTNL66YKwijAVh96U0GfbqAc0cDdJ9Li5pu6W+tANz
	1L17kQ2rxGRJB/F4RLcqgryLmlHoGw7E=
X-Gm-Gg: AYBFou1UiefXBs866sIpCGWFwxzlE6jmrwM3ZGFd8hPqwrNYBorGzUFYX/wC7guNhIm
	aa2wvwwrTwdsH1UPrSgiH8kmnP8vHClns6CG/iOgUH7q7/fwC0YGxlCQiMoY1EScXSn3F+p9r1A
	+xWVmux26Xo7HAddv18LWMZPvwIZwSx0XKVCELFcCu4Ra+jZhGPGfNIUYtpRTmwdXHH6HlIen+Y
	tXkcsqZDYPAAT4CANbYhehln0IXIr2yGaj5j1WbkT/zbdJLQG7vdEH7bSJPi3xjVar/FxTgn2ic
	uFskkGsYxcldab7xDz5n+FoNIqh0/NpgmLnorX5j+ObhpxAxMQ0hYd5MMvzbOlH64kXRHaci68i
	8IWE7DMhkHOJq6I0930d+YSap5dcBHsqo8X6UZ81AQmDa2lb54BWPbxdgJeZlL+EiBIyqfCF5O2
	oO0pZ+Y9bl0hq3YQFovtAwRMiUFUWLbMBtUKcI6StI6Qnc6QkloXE2
X-Received: by 2002:a05:7300:c01b:20b0:351:e21d:357d with SMTP id
 5a478bee46e88-3537dfdd089mr19829223eec.1.1791736770408; Sun, 11 Oct 2026
 09:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009140946.008206689@linuxfoundation.org> <20261011111313.27648-1-ojeda@kernel.org>
 <2026101124-rethink-craftily-cb25@gregkh> <CANiq72ndhLush3bugar1YGPnsein8min1k3_NucBxzFwCWe9Ug@mail.gmail.com>
 <2026101103-fling-stipulate-084f@gregkh>
In-Reply-To: <2026101103-fling-stipulate-084f@gregkh>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 11 Oct 2026 18:39:14 +0200
X-Gm-Features: AclHuK894KXAsXO3p-x4bVKeUE-imiIjXxXeY6DW6N_dPzUVgjRMS5Bea-wNMLs
Message-ID: <CANiq72kjJ__OnsTjmsuQZH8+U-cRDCNnRpSuHU3PwYYT07Xf0Q@mail.gmail.com>
Subject: Re: [PATCH 7.2 000/428] 7.2.10-rc1 review
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, achill@achill.org, akpm@linux-foundation.org, 
	broonie@kernel.org, conor@kernel.org, f.fainelli@gmail.com, 
	hargar@microsoft.com, jonathanh@nvidia.com, linux-kernel@vger.kernel.org, 
	linux@roeck-us.net, lkft-triage@lists.linaro.org, patches@kernelci.org, 
	patches@lists.linux.dev, pavel@nabladev.com, rwarsow@gmx.de, shuah@kernel.org, 
	sr@sladewatkins.com, stable@vger.kernel.org, sudipm.mukherjee@gmail.com, 
	torvalds@linux-foundation.org, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <christian@brauner.io>, 
	Carlos Llamas <cmllamas@google.com>, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 4:17=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> If that works, can you, or someone else, send an updated version of that
> commit for the next round of stable releases as I dropped it for this
> one.

Done (I didn't add vger).

Alice: please double-check, thanks!

Cheers,
Miguel
