Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0137F4508E9
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 16:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787760207; cv=pass; b=UcKYrcwWaAVMZ6LywIUixoTlwLVwow4qtLRmC+NiOaEFJe+qon+85luf2AjzuqRx2JuAXQ8GXv2RI75tkZN2KPjqMJzHCNiK/4gj5/hplGbEfPf+iKEK5JkMWpsvNXQvygRB4Fpamt7ClbNTRqGYA89WYBUSICw/gIvspyUp3ns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787760207; c=relaxed/simple;
	bh=uYFdFW6deGwNCuRXWE33qO5lp6MMBOGHlKlJNVvT82g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ee1mSPliaG/v3pOY98RsxSu4C8M7MnSDEfPWmLBW6bNJW1qkDb2KHpK/LsinCqKkROWa2gSez2vMvvj2klWoBAgv0ascy+qTsfqJPyhTVR7lSFuppoEBQHvykVC2Uz6AMhSee6BXtHVS4LlrSQao41ddELSR5OnNzYNNTGU+yiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBO6Xvx7; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBO6Xvx7"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a1f75277f3so9049791fa.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 09:03:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787760199; cv=none;
        d=google.com; s=arc-20260327;
        b=S2ADpmJQGfrpeM1DC6dxFLDW6FQkw6LfxHG6j+lSrYco/j9+SpGeaIVpIOs8WoZUSA
         zD3jUwnkFLuSosGECMCOguTMWs/QUCv+SY33vBJg9NoVrM85RIBDWJWuMrbdFhMbSjl+
         QAKms49Ukyu1MdH6UIBeY/9UMnlQXq79o5KquYC6fgadLngvsfgyaLuOcZxRTsWXVtjv
         qTwTTUtYhnAkKWf9yVEbI/w/4IO2djv45jJ6xZ6KuopLoujUSPL7MFvjzCRFgVWKremS
         Vg0wR1wtrszlRTlbLttqQquIriw5beG1q2/SgEirpX5M1BBgXEsKPjJ2rX2gM2Wu4zok
         Hqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uYFdFW6deGwNCuRXWE33qO5lp6MMBOGHlKlJNVvT82g=;
        fh=itJjE37JYBH3xhGWKajCzKUSJSm4e0jJHFodNXvwJtk=;
        b=nSMT7oaRXWUC/ICLG2STgcjnHY+iuYdJyd9OX2R9FMW24yqSxmYqDOAX3VKzfvxoMc
         zQwukKO607qouFkOTvPva+XVaZUG8BM+Xa0b5ivvER0YKFhFo99eD9ViL3GK2jf+6IDQ
         6TyK4jc8VdMR41Ig8WuqeQgoRNYRUSl0yKAYmNLTW41cT54OuznM5GGnsc+seHa3ZNqb
         Aa1xfaNgbcmO2BJULplADC7ECVxOYA/AaFZQPM0LXKJvjeQNSL1J6uS6W4jxiUutZFLI
         vrhpuZgGqGiYL1UMMXMrNeNQjfnYNL3+zNb+UAmyDTghboNI6+hBldRCTha+p2B0De8b
         bDOg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787760199; x=1788364999; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uYFdFW6deGwNCuRXWE33qO5lp6MMBOGHlKlJNVvT82g=;
        b=jBO6Xvx7RsJ6daoO9ux7RccUIWoR274y4P/QKLXA7yiKYnKY6a5vMzT7T7Z4GlCdUB
         Y+2x+OxPA2nkkG37yq6L9IBtIPhMjnZ0AJk2eAQ+27gquitNYDmEX5wE2/YdFFC9jIkZ
         uP2Wf/xQNax2ey+J08fZQMBWw0xxIRUTn+GO5K2yTjsLl7jQVJYeY3DyFZWlEugxVWvs
         2RJBLr2IgHL9kJNLxgZDWBWl6HCfFKqztNwxN/hzQhXNaphXExhSaNt0m27e3h9bimPs
         YyA8UaaGF02pbD0Kn30QD7wfbeaN2xHoQe5LBJ7RvEPv2kNjUtR+55lVB6BAcgJtg9ZA
         oJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787760199; x=1788364999;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uYFdFW6deGwNCuRXWE33qO5lp6MMBOGHlKlJNVvT82g=;
        b=d1vaw4sLN7xaITi5UCNfGsVnovERXI49iTjCvv2lKT6azJBE5SIqHQE8UXwc+9oWFI
         1t9m7V/2ADfzZbxmphqWWDmWG0AUmvmyW52RDw5q9h649Tgy4ZtAc06tSYjl785s1RId
         bchCkuv+Z5IJwejgHYozfae9adyIRHvnFqXoqLpWA6bZIupOi9TsVUJfUHM0QxCgpFCR
         g8RSKdiLTjjH0ompIt3k01GrfOhdpRaLQCbFiRebw9M+I3D4rdDenTp9kU4p1jn8da+j
         2kZ9JqFcpcHYwIJ5XlYafxkL1LwyN/HsX3k3IwM1+zefw78H1ZjN563LvMEm1aNPKr4S
         ajQQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrfEALDAyJHxymCfUuKASXt8uXyTa6oy2PuYjHuCqy4V1uB3DOu/+xOsA1BG7n8L0NiduNl9s=@vger.kernel.org
X-Gm-Message-State: AFuF++ktowCbU9Y93SrgC4FSUPiPswK6w/3qsRJ2LQCHRq0ZkyieHVfV
	eQ9gltd2t1vUFHfx53hQfj1a83SBiMPEhp7MCHBT/zVhv9m1e8QhRbVeGgvhlpbajmMyPXpz/mt
	GBsKcmPpfYdQn7OT+BXL2dNh6WdApftjgIfZ09/on1A==
X-Gm-Gg: AR+sD10IByba2XEhFyOvxeAK9IOqozCzRJxIYCMkReJT8dNOu4X97zwPlrFS1QpyGJr
	pmi3FPpadeVHU2QsntDgiSlMdoBBahXHInXRf8rSfbgLShjAzFn3MROn3dqZ8NmeZ4kkU+0phb3
	UXfzvuwFEXg1z7Mh4EstLvhaE9rxPEnaRtsji8JfBOP1oCu0kIIMTXJSZ/de7WsnmfVSt5TI0g5
	vl8LrKtewuF1GxY33AENZ6LpJ18wOSFNyJ6ytgP1HordlsKES+MVu4RSsPeJdz/YnYLr78nS8aq
	WJ8NOSZ8oDnLN7CM0q9ZOlzE1rcOjU06nT3F1oiu6Tyg3CW24WoAXm/ixsyAxTbHIyjPm8ARo6B
	J
X-Received: by 2002:a05:651c:a10d:20b0:3a1:476:74b3 with SMTP id
 38308e7fff4ca-3a1fd6605afmr15291371fa.9.1787760198919; Wed, 26 Aug 2026
 09:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
 <CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
 <CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
 <07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info> <aosGtkE_diwVJJtB@eggarch>
 <20260823174059.46fec036.michal.pecio@gmail.com> <aoser8dLytrwqBC2@eggarch>
 <CAPyJwA8m_Xd2oyV1i9k+-6f7A-j0FiC97yXL=Ci8ZAErs5W4vA@mail.gmail.com>
 <ao1ovvdPAy6n_F7I@eggarch> <CAPyJwA-QALkCQn8J1+=U-nuE_7WSEPhVcUEKb+MMYMaA_1AVjQ@mail.gmail.com>
 <ao7aLXk9q_v_jEyX@eggarch> <d5a395f7-06ad-401a-b026-e975f620f017@linux.intel.com>
In-Reply-To: <d5a395f7-06ad-401a-b026-e975f620f017@linux.intel.com>
From: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Date: Wed, 26 Aug 2026 18:03:06 +0200
X-Gm-Features: AcwNN1VMj1i9qHLHYCgFf_wI4NJMgmrhr4t1IuAyWuVvRr1oKaUch4AAYMJyJrg
Message-ID: <CAPyJwA8CNeUnh2kzYktF8OR2T2QnVNN9EUnrUci7_419bF4QDw@mail.gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Lovekesh Solanki <lovekeshsolanki00@gmail.com>, Michal Pecio <michal.pecio@gmail.com>, 
	Thorsten Leemhuis <regressions@leemhuis.info>, linux-usb@vger.kernel.org, 
	regressions@lists.linux.dev, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>, 
	Forest <forestix@gaga.casa>, Slavik Dev <developer.slavik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Mathieu, would it be possible to test different values for
> USB_SS_PORT_U0_WAKE_TIME in hub.c? Especially 120ms is interesting.

I reverted to the stock version of hub.c, and changed the
USB_SS_PORT_U0_WAKE_TIME to 120.
-> No crash for 1 hour, but I will test this deeper this evening.

Where I am a bit puzzled is that Mario Limoncello from AMD just confirmed
that this was a platform issue, only affecting StormPeak, for which AMD alr=
eady
has a fix.... Or maybe there are more than one issue here?

On Wed, Aug 26, 2026 at 3:40=E2=80=AFPM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
>
> On 8/26/26 15:35, Lovekesh Solanki wrote:
> > On Tue, Aug 25, 2026 at 11:43:22PM +0200, Mathieu Fluhr wrote:
> >> The patch you sent makes the issue go away. I am now running the exact=
 same
> >> scenario for 2 hours, without any crash.
> > That's good, thanks for confirming.
> >
> >> However, I am not sure if this can qualify for a proper fix, since I
> >> do not have any
> >> external hub connected to my motherboard: All my USB devices are direc=
tly
> >> plugged into root hubs (and at the moment, there is only a keyboard an=
d a
> >> mouse).
> > Yeah that's the point it only skips the 200ms hold for root hubs. The
> > external hubs still get their fair hold since a parent exists for them.
> > So external hubs are completely unaffected by this patch.
> >
> > On 'proper fix', I think it is, even if we keep this bug seperate for a
> > moment, it makes sense to not give root hubs hold they don't need.
> >
> > I'd love to hear more thoughts on the patch.
> >
>
> Roothub needs some time to settle as well, but 200ms might be excessive.
>
> xHC can triggers wake (PME) when a connected USB3 device starts signallin=
g wake,
> but port registers changes are not always visible to driver before link t=
raining
> between roothub and device is successful.
>
> My educated guess is that 120ms should always be enough for the roothub.
> This is also the lecagy msleep() still apparently left in xhci resume
> to detect port changes in xhci runtime resume if there are USB3 devices.
> That msleep was supposed to be removed now that we got the hub changes.
>
> This 120ms can probably be further tuned for roothub in some cases,
> especially if resume is due to userspace action instead of xHC wake signa=
l (PME).
>
> Mathieu, would it be possible to test different values for
> USB_SS_PORT_U0_WAKE_TIME in hub.c? Especially 120ms is interesting.
>
> See when system no longer crashes
>
> Thanks
> Mathias
>
