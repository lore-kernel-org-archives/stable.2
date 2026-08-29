Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F74397936
	for <stable@vger.kernel.org>; Sat, 29 Aug 2026 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788006063; cv=pass; b=qXuppW8W8eN0Iy9VBv04jc1JJNIbkeiHb/6VsDx+OHt8ny5EnPjOXCaKoRwc+9gaMV1xWI5skxZawHRQQH9GmzfUII7Hm4N1cVubZlaOvy+m7GQXuuwx62iroAlNhNLKk1tuwvWnAOqXEKZkiXSCGMI/HM34SVpOZjA+y7qWBWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788006063; c=relaxed/simple;
	bh=YhhiT+lMqx5HjW0/PRoXbfXIAG7+7GDtlBab+gtNpMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kAy4JBUAzYC4BORJZIneL8EhEg/4kKpzCMB7HoilXBLC2n8RuSrZSofcmOoTjBoqtG5GatCs3JRfKHdPB6zmxFja61ccKm/313GSvyIFosYwocVXPJjBPI5O0fOyVkDDnE67s+bZ1Qo+iqN1cqfyJMDV2OEvfN/4mET/IHGw9JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=HFcDzDb6; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="HFcDzDb6"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b4a9994c20so1833779e87.0
        for <stable@vger.kernel.org>; Sat, 29 Aug 2026 05:21:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788006059; cv=none;
        d=google.com; s=arc-20260327;
        b=dZgPomDf1ggCMPIbR2pLXN86ODgvS1PN6v9TFMZmsX2NL3H8IOyukuGFd1garmg2eV
         yJVfLUwfsesG+W39NAZN1vUEwp2Ey8p/STVcDPzDOOHPeNSu9oq2wwHeh9W9QGFrcJmX
         zvjFXUSyk28SVPiznW20o37jw4VWm7I/fASRcOPwyZKjq4XrttpEwHOJuD8Jw1p+Sa9/
         4B3vF2gAkuPvpn8uoMIaHD9+OmhXBATzowXJJJAj0AWOHYUHwIQ52Sz1XwAhBw7Bh9xN
         Klglfb4AhS6KAwBdZBtVIIadfwrGgA33d4UtlHTBRoiRPIh5v/1u/HjtSpBk+5NExzj2
         MKJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nE/f8PbdH5aPK+fOdkT8SOOm4R+FJIcq6dMyrpYaz8g=;
        fh=Y4EGbx8WC5AszsrvzPo1JPhC4i0vqt7e3RhbXQ2DrnA=;
        b=nvI6eoK2E00JGHmzE3vWN4cBrPKRdfwEgba/bi4OTe/uD23O4/mBHU8irqKamP6DJ/
         7K9o7LB7wF611MZQcM1621DAUrmvAyqaumOidHmJFGhWxc/OGuYllvcm1meSDBx5szj0
         U+wLrZkuquEEC+NDXJcnB4DgAFP4oManNwnC6tZcvOeG1Ou4dSefPMKhHrQ+kRHnZJkL
         /h/jxCSah+cPLardy9o/VhNFJIA3PFSs6EW0fY8Ekhlz+7QjrCDVQOWFzagoptbrHWMn
         B9sqDuleSx+EJclJasHwt0nZ7QiXxe1TemmMhB+qM8sTtWa1usKjXZQ3FW3aIbWq+ZwF
         qfLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788006059; x=1788610859; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nE/f8PbdH5aPK+fOdkT8SOOm4R+FJIcq6dMyrpYaz8g=;
        b=HFcDzDb6kRKB9Quw6R/ZsGMk2g6xONxRRL7G7ZagrcGy+LkN9nw+h/uLM4ZNMHF89I
         tMhKA+J4t0yIa2OombsSE6wxqK8xzFqfdZ1J4d25kNOfiszRZz20uL6iVVZhfwMPi5mw
         qfJwwsnO6XEwWGBm1L3GmKfQGjjL1DlLzcjx1QWFS8Qe+MUd1Zwgdwreoj1Ii7Sj4Ze3
         foymhnRv0iaJcgMc149nibCZNX5NuEcyBvm1v2nrYHyugSC/F8aByY+rzAzRdbxzxnZP
         zNR7VMmsxXmV5gPT0prLq7SK1Ya4sQz8vjoJmg7tZ/1KY0HSPSxH+z5YR2EpPWP+JSsp
         Ey4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788006059; x=1788610859;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nE/f8PbdH5aPK+fOdkT8SOOm4R+FJIcq6dMyrpYaz8g=;
        b=ajPGt60tckumOAQXmGBTA0vQKwATbh7BKYdXASRe7qVnDGAbkAMUJoql4k5qTz2wIe
         N9B8FwZuRUXBjAI4G1PrpxpPB08npFw2CX/7KQxkaBjiOJc0QPRNaIQoDBFUWZUBDerc
         oT7FNk12rmKFlKHgXwfGTmfZG6WWgT3LKsH/UJOrZM8h+/aMncpxiAQ7hjtEG+6wWdMX
         iMTxVKC4WcS0A7XffCsnh75jH5uY20PYcOT7yLDBJTuscPD/0t5TEwQsfwupyHcUS885
         SQKAJsYukrz+9CZDpmAGWQSJK/P8XCUMhqO3FahEleDpgXhk3MxNqXc+Q32AjwNWfAIb
         0sIQ==
X-Forwarded-Encrypted: i=1; AKwUvByNuFsjpAqeoARc6H7tlFzeelCLqN4aZoo487ffUt/ZFQr+C5Addfue3duw+OOZAvxazBtAmfs=@vger.kernel.org
X-Gm-Message-State: AFuF++maWRUCrmH9UzteGFt3SPTtbfHqEJ1ARd9+yf/94fwF5DwZm52y
	BqCy7uQruOXDX9WuqGszMqytyxX8h23CDKVgjb6/GFVx0sHEIZrxJ8tPh+4NqVYq4J7KmBjRHfg
	9smTEuZU6/IjyLHTkUuptkF/TL6evuimhZlw7EKJueYo=
X-Gm-Gg: AYBFou0Cy8XN11FJztXJPMMOHFkB0jar/eJhEjd3Q6EFkCNfFYgO23vtktYsd7nNRIO
	HTUFhLtXX9d8kYHoiU8p9WwUZZz5kLuhHQlKsbeVth/rvC3qTh3HKana4itix9MNGxg1+ERohld
	Ez5znnrgmCpPsVQonXpk5AbbIq/re7/tHN5IjIBMNYXgyCyzNaqYopgUMNnneK6nLrL7xqPOODm
	pWY/FWvqq0PrmwJIjnsmKaIzpm/5pK1L4r22PnOCijThabiVxr7fySs/ARn9HW5CV50yDsOyr/J
	PsQFtjBLi62gDRpsElrjIv0YLLPqMN40dzPMtmLwsh/cVvAyE6QbyR+65O7jm+CSewlCxO8JaXD
	USo063l/MASw=
X-Received: by 2002:a05:651c:2227:b0:3a3:2127:8ef3 with SMTP id
 38308e7fff4ca-3a321279098mr394261fa.10.1788006058169; Sat, 29 Aug 2026
 05:20:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787903722.git.zihanx@nebusec.ai> <8e45ea5d0cf764267a90d959fa40f0f831aabf08.1787903722.git.zihanx@nebusec.ai>
 <apKl65BbdyWCtre7@strlen.de>
In-Reply-To: <apKl65BbdyWCtre7@strlen.de>
From: zihan xi <zihanx@nebusec.ai>
Date: Sat, 29 Aug 2026 20:20:44 +0800
X-Gm-Features: AcwNN1WiZi8R9J8wiesRuFh5zNnD6DxT-pHV8VKVtagX319I_sL7Cv1N8NzmPJ4
Message-ID: <CAANe3eT8ycDkomgpzZmni7hMrUX1fr2dE4QvQOcKCPEcw=J=2A@mail.gmail.com>
Subject: Re: [PATCH nf 1/1] netfilter: nf_dup: prevent asynchronous duplicate recursion
To: Florian Westphal <fw@strlen.de>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, coreteam@netfilter.org, 
	stable@vger.kernel.org, Vega <vega@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 29, 2026 at 5:27=E2=80=AFPM Florian Westphal <fw@strlen.de> wro=
te:
>
> Zihan Xi <zihanx@nebusec.ai> wrote:
> > nf_dup_ipv4() and nf_dup_ipv6() use current->in_nf_duplicate to keep
> > duplicated packets from being duplicated again while ip_local_out() or
> > ip6_local_out() walks netfilter hooks. The task flag is cleared as soon
> > as the output function returns.
> >
> > NFQUEUE can retain a duplicate and return from the output hook. A later
> > NF_ACCEPT verdict resumes the same skb at the following hook from the
> > verdict task, after in_nf_duplicate has been cleared. A later TEE targe=
t
> > or dup expression can then duplicate it again. With an earlier queue
> > hook and a later duplication hook, one packet can sustain an unbounded
> > packet generation loop.
> >
> > Record the duplication state in the cloned skb as well as the task. The
> > skb flag survives queuing, reinjection, and skb metadata copies, so an
> > asynchronously resumed duplicate cannot enter either IPv4 or IPv6
> > duplication helper again. Copy the flag through nf_copy() so fragments
> > retain the same state. Keep the task flag for the nested xtables jumpst=
ack.
>
> Not sure about this one.  I think this is a case of "behaves as
> intended", you get oops because you *ask* the kernel to oops.
>
> I think there are a great many other ways to OOM the kernel,
> outside of dup/TEE/nfqueue.
>
> IFF we prented that this is a real problem, then I would
> prefer to solve this in nf_dup, not involving sk_buff changes.
>
> I cannot see a sensible use case for nf_dup outside of
> physical hardware (sending packets to some external
> packet logging machine for instance).
>
> So. I think a better solution would be to either disable
> dup in user namespaces entirely, or, restore the "old" behaviour
> of passing the clone directly (no reentry) if we were configured
> from user namespace.

Hi Florian,

Thanks for the review and for outlining the two possible directions.

I take your suggestion to mean that, if we decide this is worth addressing,=
 the
fix should stay within nf_dup rather than add state to struct sk_buff. Befo=
re
deciding whether to pursue a patch, I rechecked the practical impact.

The current reproducer intentionally drives the system into OOM, and this i=
s
not a memory-corruption issue. An unprivileged trigger requires user and
network namespaces, NFQUEUE, TEE/dup support, and a userspace verdict servi=
ce.
CAP_NET_ADMIN is available in the child network namespace when user namespa=
ces
are enabled. However, vm.panic_on_oom is global and cannot be enabled by th=
e
child namespace. With the normal panic_on_oom=3D0 setting, the demonstrated=
 effect
is resource pressure and possible OOM-killer activity, rather than a direct
kernel panic. I have not demonstrated privilege escalation or a memory-safe=
ty
impact.

The crash log in the cover letter came from a separate root validation run =
with
panic_on_oom=3D1. It should not be taken as evidence that an unprivileged u=
ser can
directly panic the host.

Based on this reassessment, I do not think the original struct sk_buff guar=
d
series is justified. My current preference is therefore to withdraw that
series, unless you think a defense-in-depth change is still desirable.

If you do prefer to keep a small nf_dup-only change, I can prepare either:

1. disable IPv4/IPv6 dup in network namespaces owned by a non-initial user
   namespace; or
2. restore the historical direct ip_output()/ip6_output() path there.

The second option preserves one duplicate but bypasses the clone's LOCAL_OU=
T and
POST_ROUTING netfilter processing, so it changes observable semantics. The
first option removes dup/TEE functionality in those namespaces but avoids t=
hat
hook bypass.

Please let me know whether you prefer that I withdraw the series or prepare=
 one
of these defense-in-depth changes. I will hold off on sending a v2 of the
struct sk_buff-field patch until then.

Best regards,
Zihan Xi
