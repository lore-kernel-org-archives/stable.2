Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4974A33FA
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213812; cv=pass; b=NIPsN0o77fO3MZYIDlQ/qJ+3xdq1dfz7nidmhaoTG9RXtQ5m9bAshlHrJBZ9hEqxG2XR6CLL+Ij0TIsPTt6u/aWJB0j+rGDW8Xem5IxR7a7AhZ7ZpXjH6XjnBeTO5SgtblGR8LZQWapiQOtj1FtqJK2XYF1VvfV2W8gcgual36s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213812; c=relaxed/simple;
	bh=3BMrnTWZwyr6lX8M+0judiPrKn45ns0kyGkanT5/PWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdinpWZhGshMrHL8P2t3zojcM5z1nNZSKoy63U0KAnYr8nn23YnFR4wTpt7CThDIepZI2sHYzidXRr78ymiD9dkfjkiY9gAN3g8WGM9sBRWrPuW/oMkEv1YdyFQ/EkYWMW2bQLTGehLJ90Uw46qJdIyHwCi4OiQlh9Es0WHthKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=kEcvYCs+; arc=pass smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="kEcvYCs+"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-822f7e70796so1838708a34.3
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 08:23:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791213810; cv=none;
        d=google.com; s=arc-20260327;
        b=rI9ppPyKhxuIQ/lBmvQ2NB0/7iilypoKHCLBQEbjtQOq3u5TLZXYvonKqwjzRlVDwv
         BKtGWhbJm2v1DVEmHQ+FtxuqIxYJr3QelJ2zycpsTsLv5zRG7mgZAWSkRUZwYSK7C2Tb
         nRLm7eIWESpOQX6JCCEB0iZHejwxjJUPkew14tOHkOMdqFYttEKtxAK9xAUN45wNbSni
         /Uox32jVdS2yMReodkI4+8g/XEUt90Eg5abYXZGW4jrJl0+5BYFkugHP1VGSNMSxb0Z7
         KS+OOe3AZkYG4mU5ZYACxRVnA25ezyuv9qUSUoi8fOs2ojfb74GF/kyEa6NJti0t7vHP
         IIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1MlekscLQcc45qbwdnWHjJzOVHRL8WZqGEQw9YVgtc0=;
        fh=220H1vB+qDs9IigrhyEtJupHB+TiNIr/9ii+3cBlfgk=;
        b=B+ouS2hwTdV/G/WC1WflaUcE2Pwo2+9gcIat1fU80ZvU6eJy+619hNeD9kOvW3hOol
         ey7QLiOZuCSJlAtqKZ8SbjaFo4VFcTdjyveqBYXhNNmuaXtdrvMrQnSZDvr/bsfn6h9w
         S38iYODLV/5xnxQ3FpJ8Q3vVmmdYVwxWQRErK4YabD7+IdndSzxSVleXreKoFAWxPavv
         l8hA96fQjA7A1339IfCW3LuHMC4RiJHEUtbzvZlEGVbYFjD32ugU9Kww3OdzhLfSmulx
         eF89cr8oXEpyF7msu2kBD+4aDODuSQRdEDncOhNoRUWcZHHHzkGq0ldcDe6wX10PatIJ
         0vEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791213810; x=1791818610; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1MlekscLQcc45qbwdnWHjJzOVHRL8WZqGEQw9YVgtc0=;
        b=kEcvYCs+yoMQ0MIrKv6Pd7uDS5T1NRSIlF7cZCieAzfe8feWF2E7+3KNrpwsBHe0KM
         BmHhsQtKBkWP81YrCed9Pg+fxUrQJwLFNFUem6XPTdqeF+Rvmlv+ZkleepsPT5HR8bJj
         UYSzfi2qZeUVvFrLrxBGfZ4xgnAvva1OU0kGuCgT5y5gh1ub8YueEBdiwmMUqcRykYmc
         G2tDkHmYSTEFgVLbR4UCTsHv5VpVpPYps13Nu7IXWwPhJAR/MUHhlobg7dK39UzYXrCD
         Wu906NwoSV1oVBUC64PW8pFJwp3uhg8Y4KHU3tilqjzLkwb8PMdiM/NINaPQxpou6bXq
         f0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213810; x=1791818610;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1MlekscLQcc45qbwdnWHjJzOVHRL8WZqGEQw9YVgtc0=;
        b=IDZ1OXS506rBBZ3mR1HV1JpzhFHh0FfCKEU+8//aXxvWKdKCa1Q9EZ+JtLoRn0WdX5
         zbBLaPUMiR6HbXSBzXtp31E/dX400+TtIzHAuQtFCYwjWq0M3TfdURU+n7z9RZ9NmpiZ
         wWCCQOViPg2XjXLutBQFRSBVqH2BEbcTcblfq/OBmkl/L4TQVmALpuy0JaJLeoMDdaWb
         2NCHoWh/lo4VEfGzXQK6IAdtdujGfSiR7ZSjiPy7iem/trW3MX5up3IfOLzWWGUG7xmQ
         p3hxssWHgVUl07bWEaqqtfTZTqe5QyP88NYMm2p+AdiZlppBCot+vJ4F0JFdqNitYjeC
         pT5A==
X-Forwarded-Encrypted: i=1; AKwUvBxo9DTT9SqU5kQaG7FZu4h32C3rQQp0UHg+RqVTtvQdyljUqFFm56Anr57+xxqdusa3RQeN8Pw=@vger.kernel.org
X-Gm-Message-State: AFuF++ldYfU4o6C59bmRBwxMhfVurNHSu5pW3b2q1F9Ajczq9xi9iqr0
	+kHJ0SBw1jh4KM2u4jtRsd3ULMBvMWyV3vDjZ/HjWDJr8zkBLOzjFEjYY7f1neiXEjLM2AHTuWL
	R1PNizqGEWaA8d9JMZqmHp0UBo2D926vOIdi+SqR3+A==
X-Gm-Gg: AYBFou2mQkc7TVouVePh9zYisbMnL1zCalnUtdnXnUZh88lyLgtYCfNFjuQ0MNtoLMI
	BDNv/FQbzCnig6kazTTl7VLmvHPln2xrORjpCYdkPu1yOmU91bsRG9LPxZCyqJaxRKkx1ErKBAo
	LuYBbhnXdHExwrCmwAPWzlP75Ql8UR5EVBCNR4oaPPY+RbvxMhTWxC0aUtB1Zjs96IA/yHq0omu
	pZe9ZZjQklY9MV4Q7nsHbt9AnNpXVgyzzIjPEjBwSVyTM+xfxu/3y80kwyau6qQxkOeqtTRjctR
	32oD/BfYtN5CRXOiq1LdIY1rTvDhWKSKWPaexfCiMKwNUn9hW17jXHM6XFcCS3ezVClu42FhT1H
	fzuTioCQ=
X-Received: by 2002:a4a:ee14:0:b0:6d7:69c6:5292 with SMTP id
 006d021491bc7-6df34291b3cmr7901748eaf.45.1791213809230; Mon, 05 Oct 2026
 08:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002151942.491680-1-bruno.produit@trailofbits.com> <ar_PNEIvsQMQPMLg@google.com>
In-Reply-To: <ar_PNEIvsQMQPMLg@google.com>
From: Bruno Produit <bruno.produit@trailofbits.com>
Date: Mon, 5 Oct 2026 17:23:17 +0200
X-Gm-Features: AclHuK9_-Y1kA3kFfm3uCM4nQvVKm2VIHGmvvm5x70Ipyd8j9bTevti15kTGlWY
Message-ID: <CAN3w+PPqe9C8TcU4CHjwEE3tUG8k8MXXAHRQagb8iR4ehWbLLw@mail.gmail.com>
Subject: Re: [PATCH] KVM: x86: Cancel PIT timer on failed creation
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org, 
	Kyle Zeng <kylebot@openai.com>, linux-kernel@vger.kernel.org, 
	Dominik Czarnota <dominik.czarnota@trailofbits.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes, agreed, thanks for pointing that out. I=E2=80=99ll send a new patch wi=
th
that change

On Fri, Oct 2, 2026 at 5:35=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Fri, Oct 02, 2026, Bruno Produit wrote:
> > From: Kyle Zeng <kylebot@openai.com>
> >
> > Cancel the PIT hrtimer if PIT creation fails after registering the PIO
> > device. This matches normal teardown and ensures the timer no longer
> > uses the PIT before its memory is freed.
> >
> > KVM registers the PIT's PIO device before registering the optional dumm=
y
> > speaker device.  If speaker registration fails, a vCPU can have already
> > programmed channel 0 and armed pit_state.timer through the published PI=
T
> > device. When I/O bus registration became fallible, its cleanup did not
> > cancel the timer before freeing the PIT.
> >
> > Fixes: 090b7aff2712 ("KVM: make io_bus interface more robust")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Codex:gpt-5.6-sol
> > Signed-off-by: Kyle Zeng <kylebot@openai.com>
> > Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> > ---
> >  arch/x86/kvm/i8254.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> > index 1982b0077..b7875345f 100644
> > --- a/arch/x86/kvm/i8254.c
> > +++ b/arch/x86/kvm/i8254.c
> > @@ -793,6 +793,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32=
 flags)
> >  fail_register_pit:
> >       mutex_unlock(&kvm->slots_lock);
> >       kvm_pit_set_reinject(pit, false);
> > +     hrtimer_cancel(&pit->pit_state.timer);
>
> Given that the timer can be armed if and only if the PIT was successfully=
 registered,
> wouldn't this suffice?
>
> diff --git a/arch/x86/kvm/i8254.c b/arch/x86/kvm/i8254.c
> index 1982b0077ddd..33d772c7160b 100644
> --- a/arch/x86/kvm/i8254.c
> +++ b/arch/x86/kvm/i8254.c
> @@ -790,6 +790,7 @@ struct kvm_pit *kvm_create_pit(struct kvm *kvm, u32 f=
lags)
>
>  fail_register_speaker:
>         kvm_io_bus_unregister_dev(kvm, KVM_PIO_BUS, &pit->dev);
> +       hrtimer_cancel(&pit->pit_state.timer);
>  fail_register_pit:
>         mutex_unlock(&kvm->slots_lock);
>         kvm_pit_set_reinject(pit, false);
>
>
> >       kthread_destroy_worker(pit->worker);
> >  fail_kthread:
> >       kfree(pit);
> > --
> > 2.53.0
> >
