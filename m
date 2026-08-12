Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBD5433BAC
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 11:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786533704; cv=pass; b=YWaF6aOE00DHzv4HY7kZLoYi/0wpQA2vEKHrkzTAyPJvQzOiJ+MCK82wuP2Cyg+skvAdq8Qfd4TbxQg86JMrQQ1wLDNJbyeLvARS9H6PyLBoI1rDoJZCKAz6CjNnn6NOiOG8eaFdQ05HhS4/JoRG0e6xWEXhBh2X6SDPeAIFhl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786533704; c=relaxed/simple;
	bh=d8OMuVdk0r9dpwaPWKglZ1cvqqrJm8kAL+SQS477dZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4qFF+n2E7A6p8BhaDTp/9VpfO7tzVFyea0o7A6Mwd0/VfCqPk8rgx9qUO5pmV5NiO0e8jcOCbFy8sMbOcYPCT2SfQY2Kdd223ihwfiU2WN3mTDV4CS1mMjndQRbeoEy+Agr3k85pHouH5DWg9b/Ga2qDwg4gN6KgPbpPWLPMH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ln0fOlFs; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ln0fOlFs"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c169ae1cb26so387206066b.1
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 04:21:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786533700; cv=none;
        d=google.com; s=arc-20260327;
        b=J9CpyIWJGUjWL4a5OD0UdfiDVy5IlH6jvFV7ekHzn3ORS5nQ8K/KgBBI0GXU+/QrFq
         7ASUcjjbZTQSwWUVO7p380sCQYLJ3FpshsbsGSnAMysSbuCFKeTvUrk9/JqCK7OdVt7X
         vkjC61vccLsrvDIMU3QDDqrEYz05A+zNoB/JZBd0/U8AlKb6n1ILjAEP+2P1codPa/cy
         FfHfTHG7lHPLNGG+hrBZZaHOdOXbbKWJfn5WBsG1WxZXeB0IAMSJhkwPr/fbuiQnRojt
         Ns/CDalnNs8pmr8zsaWijtX2HZ2RVb+FfMQBBDZF5+Q38u+O9/NlGMJMwruNtyI2y7d/
         T54w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Q95iQWLg8lpz2kL/XhUdkfxRGWb1NSXaxj6O/CdBLtE=;
        fh=Y/xCgknSjcJWs3fxgHYlnLQSYHrDRlkPf5AAgF+wSf4=;
        b=WVYdEAojDZIZnvGqN832dMajNcacUHmc+Y3newddwCU2TSCjYgymLhKXD5wqBq2hXH
         Ghat6W61wYsnQP+av6DYH7FnakMIjxpJHQGZOo1dC760NX6Gwq/QZxpovre8hk+lswqe
         dU9VlxoViOXNkfqJzirUfvcOYlv3fKpOvYS2JpKotFnTOfjdTnnN3GIQv+EkMDM+T+iQ
         FJcfmHAMwwGXnzvQFpA+BCfAq9yrjirSwJQgtWf8khdS2yFNVyILTRqXijmhQN9pldn6
         NBVz2TYMtrhUw5s6Q0BVfMwqjjV4sRsd3Ba9L9KJJws1qVUtqMAfp7+XOcijd5qpTOkQ
         yKsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786533700; x=1787138500; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Q95iQWLg8lpz2kL/XhUdkfxRGWb1NSXaxj6O/CdBLtE=;
        b=ln0fOlFs6gh9GsJmcVGTyLWFgt8kbHdlsxz7oqAnVLdX0zm5E6edBoRPTENU58aZ8p
         26l1uvj6zw4724DIAnurJhKTskESQhwd3rpqvoZDSjbVy21SYkTzWlnUVE4QJn5R91i+
         E9cL0Ml4r8MMymok4mNabbSz4L1+lkDILE9H6X+EauYQxZ0EKH0eu6HUnzwPaDOTHTBJ
         NppVwBg+Qq9ujW5fsQT8y1Fa3GuiCRnD7tkeaF1+7Qp9bmfsIvXZHNDvNYUs52gUb9xl
         bZBWIwkPxl37e3yeYMGcxWPAludqr7P1m0uVJe2hvirJH4mgmOAcM549+kB6zjNR8AYC
         GDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786533700; x=1787138500;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q95iQWLg8lpz2kL/XhUdkfxRGWb1NSXaxj6O/CdBLtE=;
        b=gVbKzUcXqG8mgokA+yY3+daHLyBopvKFxdVAagKcWopMaznnwWGrBMYmzpzZRcwuTA
         wCxfn182U0VJ4d2XA7Z2+Msp6vaYENu/7u/8v78NF0BnDhBOqPP+VnQeVS7hS1YBAF47
         Myk1qxGGRFqNpReStMg+rx6Ny94b18/A13LMiwYxZbcy6Rv9mHkJCLIZ+N0dU/N32Sel
         yh3/L2+xMQqXwZrPLRU/B9+ZKrMmjDueIgxXYqv6Ic0hXQk2erG8CqExciv5n6Spb8dO
         6tl9voQGDzhrVGuS2T+2hm+On1a5pl/L6D4weY4fPdffvEhNmKiXIEERwllQ0p9YXdPq
         kfIg==
X-Forwarded-Encrypted: i=1; AHgh+RrVPJrvTyrEGyRYMZJqBFRSvxttxvJyOIVGeYuSoLCP173ZDO4ES+kpRxJ2q7otuEWv4VIRnzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UhSy4CdUTW1ZTBpu+NmxXvdXcXVosMFqamHDfD6sCwVUwBke
	Twk/V2fn8Bs/GcW0dgNqR+nYqwCsdthcuKtw/dMOD6kfIPWojf90H1BqO8CGFo7merBj/fkfiPT
	SujRh4PunIQ7G5ebPoWYrFzA7EVwILsFYpXQfI0Y=
X-Gm-Gg: AR+sD13kFCwZD652NEt4EW+8mBsA/Nh/kQfLk1OsPJiRRA/9JkNx0pJ+a66BcboRVyf
	Q0WDrExdBHITeFeP6JnHvAHy3bk2drubtZI2PjsSHMKgYZJjI/B8TQWpEKYdyX26aZKUPRggZpr
	gfyLrdPLyDq3PKAJZlnNzjvOD5EAN6VYiqWWihfHg2xlAYT2eeqWtGm0c87lpfVVOzaW8lykb0N
	FOkzAIRoRxSYEy5rkOV0zwOZwag+u/PEBKm3LLGb9lE3ZQcqgiHpK2qyRTr7M/gj+33irVikOGv
	3AWAkgtsMMg1+GNULFhQpoLYuztohugV7y1jCjOJaDaam86UHOcNStfi5CNUndcHDhsgG3gX/LI
	uR4Z1GjpI2UZhBakiiZt16Vibn9Nv
X-Received: by 2002:a17:907:6b0e:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c20f508161fmr181291166b.6.1786533700381; Wed, 12 Aug 2026
 04:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260803143037.93105-1-meatuni001@gmail.com> <20260803143037.93105-12-meatuni001@gmail.com>
 <f337b075-fbb4-db20-8a94-b58b254fd864@linux.intel.com>
In-Reply-To: <f337b075-fbb4-db20-8a94-b58b254fd864@linux.intel.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Wed, 12 Aug 2026 16:21:27 +0500
X-Gm-Features: AUfX_mwD4GyioYavq-PD84tKtPvn5kK5hplSdml2BkhUvgSRy-L-eL2romBwA7M
Message-ID: <CADqcGBns4F5cwyowKAxhutxowM8i64936+2rq4uvNw6AZKCFOw@mail.gmail.com>
Subject: Re: [PATCH 11/13] platform/x86: hp-bioscfg: advance elem past
 consumed array elements in string-attributes
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, jorge.lopez2@hp.com, 
	Hans de Goede <hansg@kernel.org>, linux@weissschuh.net, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ilpo,

Thanks a lot for reviewing the series!

I have posted v2 [1], where patches 9-13 from v1 are squashed into a
single patch (now patch 9/9) covering all five attribute parsers, as
you suggested.

Regarding the cleanup and consolidation of the attribute parsing functions
(e.g., hp_populate_integer_elements_from_package() and
hp_populate_string_elements_from_package()): I completely agree that
there is significant code duplication across these attribute-type files.
Once this bugfix series lands, I will take a look at consolidating those
common parsing parts into a shared helper/macro as you suggested.

[1] https://lore.kernel.org/all/20260812111829.172273-1-meatuni001@gmail.co=
m/

Thanks,
Muhammad


On Wed, Aug 12, 2026 at 3:41=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> On Mon, 3 Aug 2026, Muhammad Bilal wrote:
>
> > Same defect as the companion fix to enum-attributes.c in this series:
> > the PREREQUISITES case consumes "size" consecutive ACPI package
> > elements via elem + reqs, but the outer loop only advances "elem" by
> > one per iteration, causing the next iteration to misread a leftover
> > prerequisite entry as the next property and abort the parse with
> > -EIO on the resulting type mismatch.
> >
> > Fix by advancing "elem" by (size - 1) after the loop.
> >
> > Fixes: e6c7b3e15559 ("platform/x86: hp-bioscfg: string-attributes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
> > ---
> >  drivers/platform/x86/hp/hp-bioscfg/string-attributes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c b/d=
rivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> > index fe5a9a3a4ef1..5abec8995911 100644
> > --- a/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> > +++ b/drivers/platform/x86/hp/hp-bioscfg/string-attributes.c
> > @@ -233,6 +233,8 @@ static int hp_populate_string_elements_from_package=
(union acpi_object *string_ob
> >                               kfree(str_value);
> >                               str_value =3D NULL;
> >                       }
> > +                     if (size)
> > +                             elem +=3D size - 1;
> >                       break;
> >
> >               case SECURITY_LEVEL:
> >
>
> Hi,
>
> First of all, thanks for working with this driver.
>
> There's no need to do the same fix in n patches. If the problem is the
> same in multiple files, they can be in the same patch. You just need to
> generalize your shortlog prefix a bit when combining.
>
> I'll probably take this series once that is fixed (and after I do a
> deeper review on them changes) ...
>
> ... BUT,
>
> This entire driver was merged half-baked, with outstanding comments from
> me unaddressed. One of the most important unaddressed comment related to
> the massive use of copy-pasted code which leads to having the same bug in
> multiple places.
>
> Once this series is done, could you try to look into consolidating simila=
r
> parts in these attribute type files so that there would be a common
> function that is called by each of these attribute type files (and if a
> common function is not possible due to types, perhaps macro could be trie=
d
> instead)? I'd be very welcoming for such a cleanup to finally start
> cleaning up the mess this driver is.
>
> If you extract e.g. hp_populate_integer_elements_from_package() and
> hp_populate_string_elements_from_package() and diff those two functions,
> you'll see what I mean. A struct is even called "common" in the struct
> string/integer_data so I expect it could be parsed by a common function.
>
> --
>  i.
>
