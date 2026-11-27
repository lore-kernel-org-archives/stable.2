Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795795673;
	b=rJy6Zzs9mlpxC6F2LVskmuA0PHtLpO9simzZErDTrsEl5erJHFVOfP+uj+p+8F+1ZrxH
	 IiRqCp4FX9pk5bOd/issVnp4BW5N30pn9a6Oj7187zxDf4G2FLVzlohCLehlm/YFLO5mW
	 anEoW/1Djvs6eD25meLB+d/dPhbGyumd1Us/NxYQTewbDvL0K1wU1X5rPzfCXWMtfwKvS
	 WrzmeerJRJxAdJJXGFuvTz8Ws8t3xJtCgI5RujdGWde+7aRIo3m3MZnBKg/p/06b3y7My
	 ayXgEX8JsAfwuYFpNyOpowR/K5VbWC/3JIoL67JkPlO8RxEdOZNQL0VbPwE4FzhkikQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795795673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=cmMEucFbJ3Yu451XRYkhxicVYN4uiekm3A2fjLze/r4=;
	b=rAJMAHwW7mMcHY5yMXt5892g8rF77lijdHrxpbqMtopjUlAcVfCFjicpZ4CPDhENehz1
	 zeF9qk/NNWIzTGRmC4WYka5M6jyCIL+l8KCZfkozm+UW0fBxwrOp8Fh+/VPuURB88zb49
	 fhk9bNGfjyYKCZpYqpoOG11eGK54pmmTBm146KnIu8zWoZw2YVaix4X4vSaRWdbzRMECS
	 KAMQOy3EiLHKqshZFpXFzdlDbyFABb+8VUhjZPbWF+Y01Xfa6ykzZoI+iMpIp7zE1T98v
	 uWm8UDRZ/WTko8vC1wOzQuCUDsOwFLoBkwEboRrDKIhhsnmZeZh1dDacduBQVa+CIag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=certik.com;
	spf=pass smtp.mailfrom=certik.com;
	dkim=pass header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=T8k5amUS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2650606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 16:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2650606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=certik.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=certik.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=certik.com header.i=@certik.com header.a=rsa-sha256 header.s=google header.b=T8k5amUS
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67da62357acso10898743d50.0
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 08:07:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795795672; cv=none;
        d=google.com; s=arc-20260327;
        b=mQbufHRJzARRZ0KhZLMMn4JaRx1BHnfWo+Q5OKNbgl89klEPVKRKwbM7+T4kLCU0XN
         oELKIKMCd6/FIqmKY1zSM56Kwm5SRr0wgqsPEFs6CN1Gy6SrAMC8VlOtnFWzb8jmNZeq
         Fcukxd1OwWb0H3Sx0hhm1IaPvmOl+1rgJRcNqHCp3EFPKgcEpi/oVWV42Nrw/HRhcmJG
         ypD+LnJlcyCm++sthl9UuzsQtF/99tzVdhncLWoE138nf6S8NvRz2gKW9yt4YGEchJzN
         h0w/w4QMZaqYPAAG+iKhq9SVE/oqwRPWe5WybgWfgiD6xfZG8R2eOdniE4+zZ4gL2dXB
         GgCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature;
        bh=cmMEucFbJ3Yu451XRYkhxicVYN4uiekm3A2fjLze/r4=;
        fh=jQFHF6sZb7lePkUMHOV2HGjT1sGUBL5aHicLHIgGdX0=;
        b=YvR1z+7lMlNjZmAzBkHF8fero+Ook02EBLJ95P4SDpos6jKBTK1KDeNFdqXNgwX93o
         9Kq4NcOOXcBqX3qL3PFbHzINf8mp9/l9lkjL3F0F+TSfhaBceypJ7FUpz/MUBHMlwFXN
         3eWXxYpCyOFZkbM9mu9jtocQuUpIRgQtNKb8mztEqMsNqwtSDu1gmiATz6+02C9HoTvi
         SvF0OkmtQ2CeHZ/ufLaf0DQDriE2xKb3McPWvAm7M74RS8rAb+qHMBsivgrgVi/nbvNh
         O8VrWApf41B64ITQO7shnqcnCPy5EUoG9h5+M+JjaAc1e1MZeBaae6FXxs4x7MCRog4N
         fyBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=certik.com; s=google; t=1795795672; x=1796400472; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=cmMEucFbJ3Yu451XRYkhxicVYN4uiekm3A2fjLze/r4=;
        b=T8k5amUSZeAIWKjurOF1Z3PQaQIkegtz33sFJnzQchNipcdFI7KevfngybT8RdxZay
         pRARdNqvkDOOk1mk6ZaRtq5OZMzSqB848lfyeGq1P8cQ8OAQj27RZpYhMPHzkcR+PyC/
         e0FCht7N/mhmaFjmBeMLkTlbijPhj9WuAsxbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795795672; x=1796400472;
        h=content-type:cc:to:subject:message-id:date:from:references
         :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=cmMEucFbJ3Yu451XRYkhxicVYN4uiekm3A2fjLze/r4=;
        b=TrGWIzX24DFZPhJ0ZWM4MMTY8c/DQIS708x/jTeDT5zcw90GrfHZq/swNh2yzbC+4A
         xQ4afmg9DX/VfO6Tye8C5rWBeCbCcSf0wyJ2u/Xae9UOk+GzcJnjAFn5Nm+g46HgotmR
         lu4L5m1YFktIxjudvvbVZaFM+1IZGUgHPku9R/rb3bwahmBToJwGN5bcV98asijPSVnc
         9zBfin+wl0mkovYrY2Nkdh//17yhUgThnD8FUHESj/Ze4rudx490Ij45mQNoUO0Ji57L
         1wGnb4M9y8aDVuDQkKBfjrJPudtECgoRp6UOrMJoREtst6EBPPZf8pkuIVvs+YqZ61PD
         +q/A==
X-Gm-Message-State: APuU4Z9gkm9TpnFm2c29lxSCmb1AhBNvtLMYAbFxuu5ovUwqZACGyIQn
	sOz6qVyBITs3dUce/cqz8FHQgxEwcRp3KHSJtU6yKWXwfdaQud59FkjNTS+1bHe2zFHWLUeVIAj
	lOv080EHoLyLus2WfwK84hjlnzpb1crJ7A5df+XWIiuezr1Zz0rPm0Ll13g==
X-Gm-Gg: AZFdTZcKFkNZ4o5Eykbq24K1wP37uFqoQw1sft+PG+FXjN3UbplidH7IwM6l1AM0Q04
	DoHaJhtLJdHkfkf9xmNejv7ANn1QtwB4fbFgE1dIn0dMg2xxkorO8s7ca02M2Ass8nPvaH4ah5m
	opPWyRZb8BqPjuuSfxUeI+apty8gwwwnEtZFf2jAmYno+arN6p3piYOJzTF4TIiQlvC4jMjLFyU
	M+IuQH17VfJWeLn0BAKwlJrYI30R5DbF4MBNl2+r37j3aQnnMeYSMcV54gzaEmxEoy2jKweX4/G
	mXS1VDVdbzS5EeHy9oSuij+X3wOcjkPAsWoNNUkv1P5oWT7sIWZRRYgpY59cLBy4NakjXbGqcGd
	tKWsRNulQSMcEljWVwnEuGPjBUV9Zv95CHIhib0CbLhviA+jikbLY89VbFVj2yPDTJ+FuOSooR3
	H/y5wtC2azi1cDgHTCwPhRbaaCJLIeUSIjc/w92uGnhdlvQdUbASegn+xamB92DAGosPJL3Qks4
	uNlOoALWDUDurZSOxzRNAvqsnSuRhsSbLPm
X-Received: by 2002:a05:690e:1287:b0:67d:b5fe:1ce1 with SMTP id
 956f58d0204a3-67df44101bfmr10920741d50.20.1795795671782; Fri, 27 Nov 2026
 08:07:51 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Fri, 27 Nov 2026 10:07:51 -0600
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <2026112710-wharf-playgroup-38ea@gregkh>
References: <CAFaZ9eogwNaXVeVhOrtz9montDVg6G8zYR8rOGdpZr26nHFO-A@mail.gmail.com>
 <2026112605-alias-passion-6781@gregkh> <CAFaZ9epm3Tcuz1Fs7wSOqECzZbwdwEYmwSxwUM72jPMZKZArvA@mail.gmail.com>
 <2026112723-jogger-splice-ce25@gregkh> <CAFaZ9eqpPdQ3fiu=gO28rJY48Jh9SqiRxdpXYtBzB5hcoGH7Nw@mail.gmail.com>
 <2026112733-gambling-twistable-dc4a@gregkh> <CAFaZ9erPPdqJq-Xpys5crfAcJ4W4MCE_O24KvciLSk+nSSny=g@mail.gmail.com>
 <2026112710-wharf-playgroup-38ea@gregkh>
From: Dickson Wu <dickson.wu@certik.com>
Date: Fri, 27 Nov 2026 10:07:51 -0600
X-Gm-Features: Aa3M54rQB1D7XB5irIHQ5KbChzFvja8fZOHovMvUAbSrX9VUK86zwr9ckCclXwQ
Message-ID: <CAFaZ9eo5BEuJvu-ue3ukoKbdKuV-zRzR9hGn11Z5Q4fOeFbL6g@mail.gmail.com>
Subject: Re: Request: security fixes for 5.10.y and 5.15.y
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Nov 27, 2026 at 01:10:25PM +0000, Greg KH wrote:
> If you can actually test the patches, for the backports you do for the
> older kernels, that would be great.
>
> > If it's more useful, I can focus on the "FAILED: patch ... failed to
> > apply" mails for 6.1.y and newer and send tested backports for those.
>
> Sure, that would be great but note that Sasha has a bot that does that
> already :)

Ah good to know about Sasha's bot, I'll check it hasn't already handled
one before sending anything. And yep, I'll test the path each backport
fixes wherever I can, not just build it

Thanks!
Dickson


On Fri, 27 Nov 2026 14:10:25 +0100, Greg KH <greg@kroah.com> wrote:
> On Fri, Nov 27, 2026 at 12:10:59PM +0000, Dickson Wu wrote:
> > On Fri, Nov 27, 2026 at 09:12:18AM +0000, Greg KH wrote:
> > > Do you actually use 6.1.y? If so, why and what is your plan to get off
> > > of that kernel to a newer one as soon as possible? Same for 6.6.y and
> > > 6.12.y? Sticking with older kernels is almost never a good idea...
> >
> > No, I don't run 6.1.y myself. I'm a security researcher, and I've been
> > looking for security fixes that made it to mainline and the newer
> > stable trees but missed the older ones downstreams still build on
> > (Debian 12 and CIP are on 6.1, for example). Totally agree people
> > should move to newer kernels, this is just for the ones that can't yet
>
> For Debian, yes, that is good, be even for there, users of that kernel
> should move forward "soon" as 6.1.y will only be alive for one more
> year.
>
> If you can actually test the patches, for the backports you do for the
> older kernels, that would be great.
>
> > If it's more useful, I can focus on the "FAILED: patch ... failed to
> > apply" mails for 6.1.y and newer and send tested backports for those.
>
> Sure, that would be great but note that Sasha has a bot that does that
> already :)
>
> thanks,
>
> greg k-h
