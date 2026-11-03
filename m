Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793728665;
	b=FdVs4pX3nJmu2Hc+pbUCtsSjGdVRYFmhD3E3/Jmc6qXsV3kQ/L/M5RIRPsi5uWI6HBpG
	 o73i2d2Fo/or//EW8f/qRacwrwMiPeszep7Ngo4RArS+O8zp9wjoNxbRYF0lgrI7ffYLu
	 VvZRNWNDIup6w+5QKxfY/OoabT9OAxSsrauv9qc55jHMkeIPN9z99+3a81qPY0MSl492i
	 KVtssF/TgM3wosLtfza5y0Z8tAUvKJtovi1Eafc0BnVIunkscTVIQENigZf0ZmbIw8w8d
	 jToR8oJ1gu67vQt47E5fbL/PTvQQIw2LULEkw5ppPxfPHF8REJUoPXmrJ4GFXuS5z7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728665;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=8gprV7xy1a71HLe2DJEJ0Eloi4n12O+LyzqN8PR9KuU=;
	b=UsvUUb7i1oWFtdbXJt+i5iReaoo4/5BXJVPGhZ22MiKrWDgA9ukndYd7dOJO4PBoPgg6
	 CxBj3o+F1CQQRXAWYrZGdxGiguA7N0K7gEjzDJkzZnB5RnzGIwd/kHwGubYXf3defIe0T
	 pX7nLqXKt/Q8d6NWEkSuBBrGEno4zmChlNSPt1iym+EsbqiURenDoCH9Fx1IhSzh4TXgE
	 FWAFYpTU+tpP/TUWdrCGgGj+kzarjsahh9e63lnsiPGfOE7V8StzRKm6OEpzEzPdObsal
	 C9mK+U7l4wfDp21frlLfxu2F/1lAu7WJcRNopn7pICwtCAFtFfM4/Ei9PL3lny74w9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mNNpBSfW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 768D1606A328
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 17:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 768D1606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mNNpBSfW
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a206f0b95bso675e9.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 09:57:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793728664; cv=none;
        d=google.com; s=arc-20260327;
        b=hyKVlJ2e7OvkzKuJ2cNKslDsVSKPbB0EZDO5tNiMZKUcjCTCokxAsJEZRwNZzBEt6U
         Bq7DB3q3cVQbb1xASzQvZQNwGLz3qTsFrkZ3244Y3+rM8Fw1CeT0tJNhh9hgNg0Mfqsl
         4xLTUBAAvQIYuYft0Y1VG6Oea04KsLpfKhXy6ok/GiCyp4KiYRqxjHqW8luYqqn0h/Bo
         qGt283L2fmiomC1IGfJu3oktbD4pFrlWSRf+/mdO/eVpGzGP4o3133jLYO1UqSRaTqS0
         N5P/P1x+UcWo8X+CgdMek/b9/DuCHgIvOHhE3884MPfV3mV9AlQFxNZ5moneWU7jhdi3
         MXQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8gprV7xy1a71HLe2DJEJ0Eloi4n12O+LyzqN8PR9KuU=;
        fh=bPm59hpnxLsQmMW45htq7LQeYomY7st/3+Mhh2Nax58=;
        b=bE9egJz8NlpxnIZhGqdRkVmgdCX9Jf6qYmm8D+uFBhmgYkkqd+GlXkAclRaMSYKO5D
         KIxnzdM5nqmzlrfRSBafuuB4ro2an2T9S7uUSzAH/EKhQEAGEKigUx86bZWPf+rXP0a4
         tjuBXAQtJrJ+EE+gSQIHq8rruQPhO+oeD8ONQEl2aHiBve6O5ZlGrtaUsWtBUzXSwayl
         PqApiBaPtKcwvuFrjPkCrKm1gvFEBI/CeOSoyHB2SpQWk4a6rNJnY1hZoNwplmmYyJd3
         TL+yrMVInqvUw6xm6zvmi+Sxju/m9SIwowYhrVoGOgbcZI11dSEZJqaWrLlonH8E1Yd1
         Wv3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793728664; x=1794333464; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8gprV7xy1a71HLe2DJEJ0Eloi4n12O+LyzqN8PR9KuU=;
        b=mNNpBSfW7U3oHqA/ynhmqeNxcf7VD5INJCcvqium3opsSQ6PpJHHG0HuQo6RrCGPRQ
         eOPXJN/3o/36RWKzCXa+DvnnzN0JteLWM44hbndWrNgNK+8Dq2ekmEEUoiS3qqWHRVBU
         AFM/SqwmHpALS8gQ108CebFr4blxw6ZjKVgDjh2F5bIvOshH0xMna3G15UGZYtJTpHE5
         c7eRZYr6+KDC6Te+/Bl1ijRdhQnNTBvF5JrK2tYBOaQELzEVRqyyEu8DRbT4mFfzFnh7
         IoyCQiGSL/6f/q/Eou0a7spJplQi+5xYxnh26wXm7ZE6QGeZWNE0btafYvSNrmOsadut
         0hjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793728664; x=1794333464;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8gprV7xy1a71HLe2DJEJ0Eloi4n12O+LyzqN8PR9KuU=;
        b=dTe9KnVy2JxvGSNASdTy2v2AJd7oFns6onn/FQCRMyo51mmEjiqQ94RxOVHr9VMo5a
         OxeWhFosHOdjOOo8C+KBKOOH3abwrtFf8gDEULbngcjM/gBpbOqsPlzuEX4y4WEPHWWu
         zcFF39jIZkX9c2P66BYZedBSZg36frKesIPVQs67Er17/zgNiLtIDzgU/Fw9MACbGy0x
         J22BtA/NZ/hFV01zvj89xhR4jJ/1H30BXw8WScRMJStDfmyuqQRHajs1IWFjC/CUnPJ5
         M9gZr8dIGbJY3YxUgdiHIE/poag5w+ytTYdLjzI9ExQK9p825aQ7cAbL4NkhP2CGvQAT
         aM5w==
X-Forwarded-Encrypted: i=1; AKwUvBzEjc+oTshDVGZGksF6LBow09BhMVbyi3T4o+wUSIfBGMAlX/volRKz2O1pqPLyZ7VCMTMN37Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z99ecAClGke2//TNft7crkaIxfx1Ppvz4e2qE7TDvPIqITXTPVw
	d3UoXfWhplLiflN1YvcdFaVIG2lsPQAzvaNMWkS5CLIpvRPHzXMH6OfthHV8jjv1+5EpSWZnVLn
	zHuenmpdvK0zoytOUma9XD4nFpmr2CzQ8vM8rtuGc
X-Gm-Gg: AYBFou2xKb+kMnLx8gzsOSHdj6mcxkbNXCtDsUTdN9cJ0FK0FaX+rQILF188LBVe6D3
	1SfFndpaZlrN/kRUfQWWtZumJuB60ZvHorpzjSZDs3QotF+A8cyNr5dqahTXr5qo2NEn8q4qTi/
	nyxg1enWJheyQrBYcIJxktQUWAYT1wzYqASzVXtbn2wV0eJ8VO1g3S8cETvBJb3UQzNYhb/IMbu
	80mi1ry8qRmbHA++hIwtXEtRgrS+6HqaK1C3dkR5vbfBS4oVqI/MFAfRNsxwvOIPZNHHSvZq/gX
	++Fl2xjX1I9a0I1PpdNlwYo13uHA1we3vHdlVDWlm3eWsOvgLb5PgXzwjPMtMov8F+H62FiKck+
	Amq26VPPN7bbnN8Se83fqcpJWD+yAGwQTZjabiniMyWK07kF3K7C1+xKTkMyk+0aP8hzvSVmN4e
	5xcj6/tcn+ECqomZULENdE
X-Received: by 2002:a7b:ce01:0:b0:4a1:d75a:8b4 with SMTP id
 5b1f17b1804b1-4b2e3c650b1mr815155e9.12.1793728663404; Tue, 03 Nov 2026
 09:57:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102234813.1069156-1-wvw@google.com> <8f1ccb65-e4a2-450b-944c-9883ff12bc37@sirena.org.uk>
In-Reply-To: <8f1ccb65-e4a2-450b-944c-9883ff12bc37@sirena.org.uk>
From: Wei Wang <wvw@google.com>
Date: Tue, 3 Nov 2026 09:57:31 -0800
X-Gm-Features: AclHuK8vz5vkqxj17UdSeFCslNabswTrlQCvg-mwh5UYxKg3Wjf31NJ5q0jNNus
Message-ID: <CAGXk5yr4LqdguVMBeXP=pkraY7rbQWMePWs0Dq4tbGE-dCLe=A@mail.gmail.com>
Subject: Re: [PATCH] arm64: suspend: Save and restore TPIDR2_EL0 across CPU suspend
To: Mark Brown <broonie@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	wei.vince.wang@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 5:56=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Mon, Nov 02, 2026 at 11:48:13PM +0000, Wei Wang wrote:
>
> > On systems with FEAT_SME, TPIDR2_EL0 is part of userspace thread state:
> > the AAPCS64 SME ABI uses it as the ZA lazy-save pointer, and the kernel
> > context-switches it eagerly in tls_thread_switch(). While a task is
> > running, the live register is the only copy of its value.
>
> Thanks for catching this:
>
> Reviewed-by: Mark Brown <broonie@kernel.org>
>

Thanks!

> but I think we're missing some other registers, I made the same mistake
> for GCS with GCSPR_EL0 and GCSCRE0_EL1 and I'm not seeing where POR_EL0
> is handled either but possibly it's somewhere I didn't spot.  I can look
> into those incrementally once this gets applied (or if you do a v2 and
> roll them in that'd also be great!).

I think you're right. As far as I can see, these are only switched in
process.c and nothing touches them
in the suspend path. Unfortunately the hardware I am testing doesn't
implement GCS or POE per cpuinfo,
so I couldn't test changes there. I'd rather keep this one minimal for
stable and leave those as a follow-up.
