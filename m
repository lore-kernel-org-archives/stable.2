Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8907437F33A
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 04:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788496659; cv=pass; b=jua27iNMNtPoDLNbSoDWlnMt/XnFDLId+cJ0fWqOGATTyfQxQ5puhLn4yc4vi0yvQz0V1sKGvUctVbJsYqzF+Hnum6Z/CCO450kyweJh+685AZ1CzZ4Cfk+e7rPJN9eyVmEP5vbGw6HjuFb757teOhU1wG2qjeI99E9rb3U6zfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788496659; c=relaxed/simple;
	bh=ziogK+2p5VS7cxucJDDK8MNUDO9EafDxwelcqnyHrbI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebMuYi4xswcPA4jTiAv42WhfIy3ucyZUvg2AAgZ2sFkqliCvyCsjOU7gdV2xV/AKQNlXhD5qioIdzY+rVrX0a7iJ4mhZYuB55RQE+1EoXmy0Jc32lx+d/cYsfM+rgF8ULbNGm4PBha1F6QdU/Xjm3I7P3WW3I0LbtavjMCOL81M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0WqiuGn; arc=pass smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0WqiuGn"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d5862bc921so1379255ad.1
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 21:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788496658; cv=none;
        d=google.com; s=arc-20260327;
        b=mWkc9ByM5SxZyhlxFY7SHM3lRekEgKOlYGRcluT8XMt2IIOKVUpWOp+OXj2i19N+rX
         QWDgD8tY/VAbd++ZQAC8cl0h51TmhMza+v0yVbpX1qKZayo+5aLoD0o5YQ+S0KfpQfkp
         v06ZXKNFvipCCKN70MnHIMpti1KfviPris+Bf34M5BqQzEfbH0FWxXhvsECk6wcpQAlo
         nfgF0OfFT3ZsAV/ztK2WvA/3IldH7tNHgG//LtpqBTtAoDOSiVZEFdQdeYXEyf/0Cap0
         wVlUW7szz9l4KjxfN0MhaVyZ1PMIgz+Y6VZy8sw8tO2/ThhEJ4QJJwv2TS7WtS2wIkSV
         AFeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ziogK+2p5VS7cxucJDDK8MNUDO9EafDxwelcqnyHrbI=;
        fh=wEMJPKpxoONqraQI8RjExIgdNb/vHZfB8prMfCnjXkc=;
        b=c6bRfHwHRhj+B0+iW+A2QJAWiseCZgSj8B8LefXEZZr4X6ucXhyOfbGZUr1NZ8Rnre
         mIJ5ztBzaDAEdgTZkuFrOUTYAdMzGwRU9RX/XlJp62kj2srS4v++yD63iEzm22ME0+7o
         rnMSubRcprEH5bFRgoE8fNFOC+8V1dpf5F7saUZmova1O68CJ0v5PJj45jKzQUYZXOQT
         jNc5IJkYIt+iK8ERWzAfojAypSHzvGVXhGpB+i/KekzQDio+DWZmYEt/pB8G0rD1JdZO
         CLsExbb4vLtd5dZOM6fPS62Dhl5ag9KssigsnLHpKZdF11lye+e4YKXcq5c98+gNt1t0
         7aFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788496658; x=1789101458; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ziogK+2p5VS7cxucJDDK8MNUDO9EafDxwelcqnyHrbI=;
        b=F0WqiuGnxQJHv0bX8q/NE5JIyJ5vMO2JV8fvcBfXi+Jld5BUFiIVJOYqO5r5+gHWSm
         tg8wMlU7uevjhUsDyO7XcG64wJ2+Kd9sKfkQLskhvymp7xEOs21Itu/glNICOfoWMZp0
         Izpnw0UMAJyRw9XdlRvNlHpc3b5w+QtDq0FzFfdlm9zSeYM9KQ/G07/NrXi4NqN0PFO1
         NYAPPZqmmtwagByI/oV7s8vS6K0w5pGC9VhUuHVOqZzggc7WBuKw0f439GBNzq5Q0bA7
         raLU6IoUtHMQHw2eDe1MZHqljJeC0CQYfUOlyIQb7Gcxf1AfbkCsl3h1X3ddl/PqAdiM
         3qcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788496658; x=1789101458;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ziogK+2p5VS7cxucJDDK8MNUDO9EafDxwelcqnyHrbI=;
        b=fXGlqJ1+rMW57cFQFO9OXIGr1sRfuvFyQbLLoCaPZXK/dFb4UKaFC3q4b1YZYH0/Qz
         9UcavsEybUFSACtevhTs9ZbUez2Y0siod1ql1N3+bVtyYBnAsDe6VT2wCuSD5UhqmzFJ
         pyVndaqizPJ0R57AGPe+Y/sf/w06/4BWj4B2uToQLzf1yJrTX1ErZCUkEQtVlyzGpqP4
         IkrwdHPAOxEPuIwU/ZAKl7xyl12E1bktM0ooKB7ybFTHuQUz3hM9wm5bOkl9t9G40JMA
         E4JtuZVpqDDE+noo7cBOilgRmA1Sj0x3M1hDlcAcqKhE2kPf2DWFVLTUSQP8hTwkvC6i
         XszQ==
X-Forwarded-Encrypted: i=1; AKwUvBxXOJCCOxivHJ351IfKFj5D1d3efgocF+W6e8aB7WVx1W5vefdPcKdp8VftUVW/Ys4oHEVhkco=@vger.kernel.org
X-Gm-Message-State: AFuF++kKPtAVcgEtsP4Vspps2eF24pqBkB9p6hSVmU9KkIgxBudEmcPY
	RYIW8jjTDGgaGaCsjBcJTxrpgnAhBfjrD4SkzdibqagACkVS4q0ZgmoU1PURlXSGvIPughSCxJM
	A+kEWb/TP04cLavKgAwOwhMLp6I7FyKM=
X-Gm-Gg: AYBFou2e1Jv49u0gEWgMRZSD74zDI1E73chjeJoSQboedMzyGEcOjRaeZ55ebA57DO0
	b+ICRUdlk/rt9BNk0BlKoSeXm0807ur5g+w74+KOovhY0+zl9KSrJnkbPaT3tXl7D39heehRdfr
	LhMVkyuvFvWJ4dQc/I3a6qMcE/S4z9rf6qL+gdg1fdVexfh0ko8klAwYIYQAouRqEqUHOqtLlZP
	5WgxIDmfgTM8UHw/Xeh/qIHEjWuUvpq6Ku7liIpOVfvJX9lLOodjLLPiBvLlGd/zPPhe3SyUiYy
	bvbEBTYGwS6rf07x6tn+RgboxEmwfCxHBMpfotVY5F3Cdj32+IQO0dBlslSMz2x4w4pPo9H9c1h
	M7Y8tJ3YG6u8tWv7QquSwoC3KFuEXQj+ZCBKwzgLcra+PCqJWsCxxKz3esFSc
X-Received: by 2002:a17:90b:2b48:b0:390:3936:8760 with SMTP id
 98e67ed59e1d1-39b25efa69amr3534777a91.0.1788496657679; Thu, 03 Sep 2026
 21:37:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANiq72kmYx5GBU7VL3z8h3bAWB=vw-TX+ptskDO0k3Ro-F450w@mail.gmail.com>
 <20260903-daily-reply-0009-re-objtool-rust-noreturn-scope-6.12-6.18@kernel.org>
In-Reply-To: <20260903-daily-reply-0009-re-objtool-rust-noreturn-scope-6.12-6.18@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Sep 2026 06:37:24 +0200
X-Gm-Features: AcwNN1X-pKp5aqDr6N2ar4rD87dEfMbGaJ9XKjWV6o6qpbD_mM-qo64AwyI1usI
Message-ID: <CANiq72==u3Q963anWC=6TH85WmDhSq_6pQXfY9_YzukLcx=DTw@mail.gmail.com>
Subject: Re: Consider cherry-picking 4 patches to 6.12.y and 6.18.y
To: Sasha Levin <sashal@kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, Stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:55=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> The first three (c18f35e49049, c431b00ca6af, 16861ca3508e) guard symbols
> from the radix-parsing code added by
> 51d9ee90ea90 ("rust: str: add radix prefixed integer parsing functions"),=
 which
> isn't on 6.12.y or 6.18.y (it landed for v6.19-rc1), so I think it would =
just
> be dead code?
>
> Did you want just the fourth one queued for 6.12.y/6.18.y, or is there a
> reason to carry the first three anyway?

I mostly did it to have a sequence without custom patches, plus it
doesn't hurt (and may help e.g. out-of-tree code or ourselves
backporting future patterns) to have the lists of patterns
synchronized with mainline.

Thanks!

Cheers,
Miguel
