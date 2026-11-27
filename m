Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795781461;
	b=ybkiIDvlGzBzUWFDe+SV2JO4UhUIUvX2nzj39a/gyOVRWHp9zJQ78dSsIVlcPuzNcSIz
	 HmeIvJZBOC8coPqDJO5Pmocbnh5KQlFrZ4o6fRl7z1U7lh5fHghiXsSgYlCX9F1DwVSe0
	 ShoJgjxVrIwJtg9aL9hUQJ31xYGe6QDlegEJlPJQypeyk8qcphI5GXNROwlau21uRyEQP
	 iA2+8qBCU+7sJKlIMVI2wOjySV9Cm83lr5w7tCUKa07xOMa0JwnZgZaTY3Jku/a2d13X+
	 /GhVMU1rpodiyRqAk82vEc1vQwwQ7TjLpa2xr1xBG2fLCpL6TuCouybAohNdFTvb9ew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795781461;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=V2qzoUjVUqzpzoyGHn3ke9ADcsFIc+4DOftfXyKXY9Q=;
	b=REvxMGd9hVoAxZ3bKyNGlnAYouXD/tVSlIl8UlDOYb70PDEO1rKRzAruGsjdwLUVFPoA
	 ZBO47gcyiszc2IOSVhRLlQtuIhSqF0kRW+DQ3heBNdwjunB3z/KIEkxW1Ftr2p+6MhcBM
	 s+vjTcNjljB8MT0mKrkZAGhyJV5FFxzEaHxaSXZeOD0aCAKZOUBSoOSlpIrJv+1L5M/XT
	 ZUfchJQPXUc+VlTzYnvjAR/QpdSxoLEukjrBHFadpDcYiR4Lgu6HoF9uUykCCo7jt0Xn6
	 OWhjdHnntOTDUcTwa7IZyTBYC2NNZrEBZw5AjrvT6htM+VQI6CRlDmDACAc+lebaTIg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=FV8LsGLa;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923B606A324
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 12:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0923B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=FV8LsGLa
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8b503e2a87bso81780257b3.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 04:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795781460; cv=none;
        d=google.com; s=arc-20260327;
        b=BK+D6YubhWby8nLm3qllULAWKS7PvbVn+8AQ+gro7ALlHodYs0Y3SDWO4CA9+f2pAE
         9OYQzUI+PpCXK4eSmIzOj61OAlHY+jqweusiZpteYGdfUVjY85bR0DKitlnHBR5CXuFV
         r8cSEiS2Ut5QTcswQT/2xK7Nso+u/VOfywu/vi3pS5WA+EBwIa7Ac5Ad4pwgPXyKY+M+
         DouTr0gcw85KQLhyeaGC/q8kuyJpWyDa9oFEPEze0KFpF+RqRLJIlbIP5dWSG0++lsgZ
         h+SQA2h1LawIRI5gSdiS1IAfUfQRSlZDw7vKY98T48FF357vaK5SQzn1q7qi4tqsKhty
         HT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=V2qzoUjVUqzpzoyGHn3ke9ADcsFIc+4DOftfXyKXY9Q=;
        fh=jQFHF6sZb7lePkUMHOV2HGjT1sGUBL5aHicLHIgGdX0=;
        b=Aowa5n0wr/mAQFKLfruRfWh0y3MsxM4yq3HssvIqxFszHzl7U4bE3LgWlfDQfvwLvC
         Ab1Pfz7p+0nE+7QYXhTIg4+/fIpJSKVN0+O6xvmDRxWjpd927V/h2yCSHs6RCgz4uaSB
         vo8EYLiCQLey8W13+0BKZZZ+HnNMWcKumquyqN5DDufNyJFEKrKpr8G35Nk4k2Oawo6I
         WpzL8n4KYpFg+6ZXox2HDS4ovnaG11oIbcxeksthuC4nKWdDWdqkwys23vknxs6AL1rA
         HH/uXdBkgHXxSAslTV+uHJ/qRrVFLrmVgbUUkDucfH1lRedCYKDmL64qj8lp7bGneIZI
         8MUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795781460; x=1796386260; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=V2qzoUjVUqzpzoyGHn3ke9ADcsFIc+4DOftfXyKXY9Q=;
        b=FV8LsGLaMNXNDsotcFxJJNGsJsPirnu2CKrW0cZTZY+xUvADghu2VysOlupQ6p4U5w
         BwdvVoT08fTgSOEFcGXhUlm7BVYe7lS7E2aC8CfPpu6BUQhjSHQJzO9l1/jFMP4vffTP
         6vr6gWPaKLlnoUFZd0dLrC5D78z7exRtewoOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795781460; x=1796386260;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V2qzoUjVUqzpzoyGHn3ke9ADcsFIc+4DOftfXyKXY9Q=;
        b=vgGl90bIAOV6H10Cx3YD2OSd1F7XCyViFfTl1lKeUGpTelOUPm1q0SA1LsdvtEhE9M
         HcOQuYBCltdrHj3zhCxHY30S/o6WalUgm9nVSqd1gm9C/jlCul+caJOLehiTlw+Aedh9
         DmYXvJMKQrMexhG1O/fcH3zOmvLzzo3vcCeTzHqlq6D/L4XwUkd1H2BdPoGD+s3b2fRM
         j1L6jx+6NJT/xOA4NiPvPeMefDPGGo5vBCv25Z9JFYk6Cwd7Ai+odwiAMbMbr03Us6Xe
         xIzc3EPelEuTbgeMrjJgty2HIxjgjzqhQzG16DW2bVysY8SiU8nruQeXriW/jfJ3Otg+
         xSfA==
X-Gm-Message-State: APuU4Z+lekIxGl9hbuFPVV4Fds5+RPp911HLZ/h2stpeRuE89haRBtDB
	LaypkQphYD1DwQDnXSmL8NXMRRlJUsYn5chbJQ4rv+n8OEsVgltyXjG8HOKpJIGpibzqLCRr3gB
	5KU6E7dePIh8urcZ2nWk/hieBW8kLcFzMQI1fMbzNN8OatSIqGLJT7Nd8BQ==
X-Gm-Gg: AZFdTZfb8itB6r+OM8BmyNvbWFLzkENa0HJaNScq9bnwXdYNFhyBiwCGiF8MuXVOmWa
	OWlWoJAM50aPTMP040AsvQzPhC4X449vqmTK/+HEqj03r19w537vs2/CjdsrGE/Unr976peRK1S
	jGG5j2NB1DiaZWNAcDkgxjtJ+jWLAJg+rvfLrIqB0MBP0G/ROKO0XKLmQVfquy/usldDeCGM2tO
	/6XMWb0PuuZ0nnLjIo6MOZkOm6YSKIL1CAA8zO4rgPc7HJAAtP0jQRNYr96iGvimWRKCngc8gtb
	FRehv8pEgiUMyKe3TMZl9JVmJOqjBLP7gNxoPlwD2JVgDT4Tp5mcuLdL7x5nfg6AD7xOk1YEl8s
	r739hpfKjz8DkolC6Aw1eXgyYWE/7g499uKARh/vvwgdffZLWES6u/u0YNopQ36Q6xBdY6C9wcX
	o7uWYJWfwaj+89JwTOIJsBHe1Z7LYu+IeDSsmZqsoxjw6Sebt+Bu0Wejt4BlSBXPfbUfkbcYw0N
	zmVZ/GdOooWMHfcoV5CuuuQQ98pJiiYj4MFhA==
X-Received: by 2002:a05:690e:5d1:b0:67d:bdcc:4236 with SMTP id
 956f58d0204a3-67df449a6a6mr7050574d50.75.1795781459909; Fri, 27 Nov 2026
 04:10:59 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 27 Nov 2026 12:10:59 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2026112733-gambling-twistable-dc4a@gregkh>
References: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
 <2026112605-alias-passion-6781@gregkh> <CAFaZ9epm3Tcuz1Fs7wSOqECzZbwdwEYmwSxwUM72jPMZKZArvA@mail.gmail.com>
 <2026112723-jogger-splice-ce25@gregkh> <CAFaZ9eqpPdQ3fiu=gO28rJY48Jh9SqiRxdpXYtBzB5hcoGH7Nw@mail.gmail.com>
 <2026112733-gambling-twistable-dc4a@gregkh>
From: Dickson Wu <dickson.wu@certik.com>
Date: Fri, 27 Nov 2026 12:10:59 +0000
X-Gm-Features: Aa3M54qaTkkD5EzqfmRqYsUuvse6m8MIzbYh2ql68DMvdruHAKaAXipyaZG2YoM
Message-ID: <CAFaZ9erPPdqJq-Xpys5crfAcJ4W4MCE_O24KvciLSk+nSSny=g@mail.gmail.com>
Subject: Re: Request: security fixes for 5.10.y and 5.15.y
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 27, 2026 at 09:12:18AM +0000, Greg KH wrote:
> Do you actually use 6.1.y? If so, why and what is your plan to get off
> of that kernel to a newer one as soon as possible? Same for 6.6.y and
> 6.12.y? Sticking with older kernels is almost never a good idea...

No, I don't run 6.1.y myself. I'm a security researcher, and I've been
looking for security fixes that made it to mainline and the newer
stable trees but missed the older ones downstreams still build on
(Debian 12 and CIP are on 6.1, for example). Totally agree people
should move to newer kernels, this is just for the ones that can't yet

If it's more useful, I can focus on the "FAILED: patch ... failed to
apply" mails for 6.1.y and newer and send tested backports for those.

Best,
Dickson


On Fri, 27 Nov 2026 10:12:18 +0100, Greg KH <greg@kroah.com> wrote:
> On Fri, Nov 27, 2026 at 02:50:16AM -0600, Dickson Wu wrote:
> > On Fri, Nov 27, 2026 at 08:05:12AM +0000, Greg KH wrote:
> > > Thanks, but as both of these are going end-of-life in a few days, and
> > > the final -rc releases have been sent out for them, they are not going
> > > to get merged. Anyone still running these kernels should move on to
> > > newer ones now.
> >
> > Ah got it, thanks for the heads-up. I'll stop sending for 5.10.y and
> > 5.15.y and stick to 6.1.y and newer
>
> Do you actually use 6.1.y?  If so, why and what is your plan to get off
> of that kernel to a newer one as soon as possible?  Same for 6.6.y and
> 6.12.y?  Sticking with older kernels is almost never a good idea...
>
> thanks,
>
> greg k-h
