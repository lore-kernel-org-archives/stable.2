Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E33ABD9D
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781882969; cv=pass; b=KEcRd4g2coaj5RNiG+Y6rYhhghXxI0ZnlUM4+LaM/ZjvxYVOjtvjPtLHR1Kgsu3fxI2IhEzKVu8jCDP34kz5seuDY+9oid5krEQmldQw17lt18ls/2Di4R7ozKtI83h4WG0u7Bdp/2vGl2/aHt7ubyUu5dv+pc/FLIuLVyCRzLY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781882969; c=relaxed/simple;
	bh=TbLxyaDOtwX8lHN9/56pnNOqdgfU2UehfvSBMDPX2PE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WtT2utagXSVFb8eoACEIGrfxQNiphMPVrsK7IpiWZSIlOERYd3U0gDAy4FDRf9Ff1NBy7hfwsHK0rv40gc6fZMuS9Rl7E2DAkbp8xapFHKso8LUlUyanv4a9WIldHKrI6qrtvwkye+5UIFGYbQSL3Iw9v/ilpckrEnGGawQiz34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pPynJzpX; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pPynJzpX"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c07ea058c0cso337403266b.2
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 08:29:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781882966; cv=none;
        d=google.com; s=arc-20240605;
        b=M1BJDc2mymHVVb/nIWptiTJnBQg8YJoXXcKjNw20yLorQG1qtgqKm/X8nR2raJcFU8
         iawNgtqxZxadYfxoHTkmnYncJC+d6Tvht2yg0NAYSFA3TCKFKPKZRQmMERTynIBbHwz+
         Y7DiZkbz6zHwP9DRNRbO22Ju1TZSWMDLQAqYHtbQKXzMDtgSnSClXaqJ1FaqMAMy0Xk9
         sJqpQ5ofKeqVLIyHHlOmHG2go+2VbvMZi/41zUsDBXA0mKXXfKRLssdGyj1QERCbiiPr
         R9/WDs5rFoOI++7PqVv0D2kWaLUDzqJq9YvCVaKQWff91yoH5MqzYT3c/V/2GvXKb54y
         mSIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dULTLRE6f8vtBip1INjm35ttJ1pitKtvcCZ3p4j8QbM=;
        fh=d4LiDOcwqCVXOs198vNcn9GaPQ7eYsHBIcjVDNxLLcE=;
        b=gY+yyJMhzgKEMWXl0vtSn8YhSW3X+ax+5OZPM5ANs+DnaOIeBTmzaGywGQFkjw3Hj9
         pHHpUafWlxoT6FhoZXBbZMbYFyI/ltDFPwJqhLIJMtNSDRxtbhSqeqt9X8SAqgAxVIlQ
         /N/hVPpozeNB61iE8UIpEURorAoYJ7HedCHFxf0z+b4NGJBuVG4wMQkpuGFPeHxsJn0k
         itxnm4L0R622rL8d/tqrYOI2KK7pO6tqy45E3g0wuJcYdJFk+DhJ8vq8Oi61K3wc3HA2
         Y6QkwDBmGPXKy+omxQEjIBigalfpLrmM4KGnrzU5Z7CmlDy55dPGoeWEc1xODdH29V+S
         t5Kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781882966; x=1782487766; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dULTLRE6f8vtBip1INjm35ttJ1pitKtvcCZ3p4j8QbM=;
        b=pPynJzpXianUUqVKrr/uMSJ/MgAzzQ4Ud4lTVVeQJZ2ESuT9N/h2sG/mnUKKP3Vf+Q
         M+41AFKtr4621MOrforToeKi+VUajlpe5yfF4BzUFwvcA+93PPmwDen6PIkxiUwLxahQ
         031SKoNre2q65ubOVK4P90gQrnFgGbAsLk95FpsqmVqRzWFRZHxYZYa5TuPsM6uO9StI
         MIrzpLbrEsbDPkG1TvNUKrwehxTdhXR9oqGl+m4w5hy0vuX66h7l1Udl26PQO9B8m8s2
         zGb89JuT8s+jO4X5NWoGX8EnCxc8WnoTNsm0/IxO6NeEmg7KTcKVts8vk5XcBajd5HIF
         IhRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781882966; x=1782487766;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dULTLRE6f8vtBip1INjm35ttJ1pitKtvcCZ3p4j8QbM=;
        b=VgbS2IRILxUDtRPN52yjVzsoH2GOOyevzPzR8YjyUztYGQjk+OznUdYcuc5lLmsJfz
         jaR5lwLt/nNsakFPPjdThNy0Yj6SYR2p9BO5ojF+qTGYJ3lQ+4C7xveGVfH/IbtVOA7k
         hCiM5eb8OZ7LIcaL113cLrHjhrbSQpHWOaEz05mKmVNbyY1j5WCSXeLzpa5togx7/YsD
         lu6xGB1IDtp78tTE5JPbFLhkS2ZDyNNmG0tc9Sn2pQr4a6X2i43Y8Q2u84prudVnHhKz
         My9KVRY4HcCSURHEAE0CHKYbM0Gj4Mhs9gyqsg5hAG7CLzHjyz+gQTM7b95TDTP/ovoQ
         OHzA==
X-Gm-Message-State: AOJu0YzlWEpqiR1gJ44sXkXAyZFKCOxx5JHKI0z73zUh3EydWpSJ5Iae
	RYetR4Mey17R6B0JK1eWJ3GBp6rjWdv16uapHRHpUk6+a70j16zTir4fuxdUiTxcvzAlGe+OtV3
	7ZljXSYSgWiP5m5KMa1iYIF+YDezK/NlApPpn
X-Gm-Gg: AfdE7cnp7jaSfUYddV2O0cJU7dnp3R8bshhzEnnru+mXH2r51cX2aMKsLycg5kiCLyT
	vqAMZkjWJm9/TWfqwez9dIGvbwTVZBSxwdnCKZN7km0fDrJkU3hVykJ/MWUVx6WfdZffe9Y4Pbd
	HHfQY5ZMJPIRBr2DQccBVf9oCrJwIw9gmdSCwu5JOjnS0hqWFxTs22uaR6o7aL3okCST7oPKxTZ
	X19zD48Guiq8ysuBei7SNLv2JRqG/usxeZYpdQsMBkMLr1CYFne2JZjQbIKGlv6xXNUNiYLC7Cn
	1dibmNKSeQ==
X-Received: by 2002:a17:907:3f08:b0:c05:a987:6818 with SMTP id
 a640c23a62f3a-c0b74791ec7mr160512166b.45.1781882965830; Fri, 19 Jun 2026
 08:29:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515124218.151966-2-elaidya225@gmail.com> <2026061632-papaya-handwoven-d010@gregkh>
In-Reply-To: <2026061632-papaya-handwoven-d010@gregkh>
From: Ahmed Elaidy <elaidya225@gmail.com>
Date: Fri, 19 Jun 2026 18:29:14 +0300
X-Gm-Features: AVVi8CclmblgOHLTebR1IvQr0GdtabbyWwRGzxpmUmyAO7FztZWfvJDgibSTRt4
Message-ID: <CAP48DwbYt3-3c+awg_s-=uHjKq3aE1J0Yx_XvR+v=hhsVMOSqA@mail.gmail.com>
Subject: Re: [PATCH 6.18.y v4 0/9] mm: backport sticky VMA flags and
 soft-dirty fix
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	ljs@kernel.org, avagin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

> Ok, but what does that actually mean?  A crash?  Normal user
> triggerable or something else?

The issue causes CRIU incremental dump/restore to fail when
VM_SOFTDIRTY is lost during VMA merge,
CRIU incorrectly treats pages as unmodified, leading to data loss in
incremental checkpoints.

> We need acks from the maintainers here before we can take these...

Lorenzo has reviewed the series and given his ack:
https://lore.kernel.org/stable/agcK1mzmGbB5KSpP@lucifer/

Thanks,
Ahmed


On Tue, Jun 16, 2026 at 6:39=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, May 15, 2026 at 03:42:10PM +0300, Ahmed Elaidy wrote:
> > This series backports the sticky VMA flags infrastructure and the
> > VM_SOFTDIRTY-on-merge fix to linux-6.18.y.
> >
> > Motivation: CRIU incremental dump/restore can hit a missing-parent-page=
map
> > failure when VM_SOFTDIRTY is lost during VMA merge operations.
>
> Ok, but what does that actually mean?  A crash?  Normal user
> triggerable or something else?
>
> > Patch 8 is the target fix:
> >   mm: propagate VM_SOFTDIRTY on merge
> >
> > The preceding patches provide required dependencies on 6.18.y and are i=
ncluded
> > to preserve upstream behavior, as requested by maintainers for stable b=
ackports.
> >
> > Changes since v3:
> >   - Reverted to sending the full 9-patch series as requested by Greg KH=
 and Lorenzo.
> >   - Updated Lorenzo's email to ljs@kernel.org across all patches.
> >   - Added Cc: stable@vger.kernel.org # 6.18.x to all patches.
> >   - Added Fixes tag for soft-dirty merging in Patch 8.
>
> We need acks from the maintainers here before we can take these...
>
> thanks,
>
> greg k-h
