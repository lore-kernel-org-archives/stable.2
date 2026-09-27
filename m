Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481E03C1090
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790549447; cv=pass; b=ZPpUfQiFeo+IDK8a9GlSUrMSefLFnl5p7SUAGxfz+1u/2UBDpbWe3sdbBUc2WB628eUc9Bzcnx5tXG7yBF1qy1pLXdjKX7duyCKyJrq1lARYH66dlFn7+xhRxFnR45uCSDSoW8wsPZcga5eUi0YzWZtC5mgA9XRPkNEei+yscDY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790549447; c=relaxed/simple;
	bh=Ifx1yTX0L1801X3uiipDGm66k2wMyQhOYEC1lY1zW3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oUCiQdpdURoUg9Yi1RsQqYeg/+CM8azl3gmXBymN9JpUQ3+3t2sAlLna6zzzhXRtj9VSIB1BUhKdmBQ0SAcyneEIuJomOkXLw3XPr/imbt3IZLtcTrOB9AVeOJTz4ZIH45W13YACJfNcSjI6l3MJeJtmuhU+QE9RMOpxZyzYkoQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bUrQXHXj; arc=pass smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bUrQXHXj"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a8b9acbc6so338046266b.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 15:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790549444; cv=none;
        d=google.com; s=arc-20260327;
        b=pHf2HjQp6jCcbKYNSFIBY3bNplTaxLdJwAuk8Q2FmVXkAG0XF9i1AG92PdCe9koyEv
         opNhzhGXKCfhxsqzX5U+XPJFPwVkIlfNg4dCyFZOkkbOGh6T1jCqojlNuA0UfM4HVt+r
         AKGDM0689Iai19TvpU5rmFgMyW16fSOnMb4JjbJ7pmnMQXQhL5UKomwQJpO1cxQXBr/A
         Ppk7F8Fi31URDojsZ2lSUXXQbkEdWpHUmsJrD+3BhJ+IqDc/xcFSc4VzLfpmg4/ZH2Lc
         eE4MUqglkrHEF8NfCU0ZVZGQlyzqdzbhl3pJ+VMhY5QANWepWFPKv6WlD6SIhQgVPzJe
         9l5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Ifx1yTX0L1801X3uiipDGm66k2wMyQhOYEC1lY1zW3Q=;
        fh=Cg4sx/5K3YLVSbH6AsF+GbgcONQaQmCME7aNJtzsfLQ=;
        b=VjA4Kl5Ks2pWSTYbd9WhKw/QnsLfCBAg4kGQc1V5UrkGvGJcsi5Oade29AolCKvZIw
         ztxnZqt0qBKMBiXBSaYdoXG2gJ0sn6+jKZfv2aRskP85uWvmVmgGznaZ4SN8wQa/m0T+
         yJiQvPKtEl1RpbkZh+zUwj2xpdfOMM5kySrlnO+uiaqEBGVfriIEmvLn71xCoKmec2uQ
         vHAnqMnzaYOQR1yGmAhA4rAkKyEwOVI/Fenw/rBnFiVqPveHcWyFWPK6qtnne8yw40g4
         OTg+/KFkn0uiBQOc+2l5IjQxcaG19pjLecYscy5R+O8YUWR/jpnJWvyFUbN54INhSAKG
         XOvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20251104; t=1790549444; x=1791154244; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ifx1yTX0L1801X3uiipDGm66k2wMyQhOYEC1lY1zW3Q=;
        b=bUrQXHXjWd73HigefHpiexC1jDhP03WLbFjMridXHvWTWmWUq4jg+STaz5W/J6jRgD
         iJzTv+bKlgZg9sQeGD5ldyz3uLp0GRi+OCSQICKDX0Q2tDQc1kYXjt1ZGa4LWJDj46yu
         d1JdJrB8anLjre0KNJSLMH9PEC06zg7moNK0eSoiFDTZm0wR3MLmB3Zw3NDnBrOR9NXo
         arwgo8yPQa4ocep0nZBp+5c7T1V9LIMJKQpl/rFBly8CosDzVt5UdojkUHbM8A/VUxXr
         5TmR1obwcP0327NwkEEFumNUpZ7VIwT8xjv7qgrRIF1zbCUQ81u2pwcJJYiGWMBrSGWx
         kPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790549444; x=1791154244;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ifx1yTX0L1801X3uiipDGm66k2wMyQhOYEC1lY1zW3Q=;
        b=vMXBvIxznm7mfAhX84OQluh7dCMzPgic7m885QL3i9+dMhXKeWwYlnw9jnE75yBMRp
         3A4UtzyBX0yLa6hojdGLnGC4Huk3OOTfVtTshHPdyQwHAfCURqPkfrF4p0d7R+zL/eAx
         dVgibpR844gTt/3gLh7lMnIad33HjMTBQ+NNri2bV4XteNE+ir4rsV+vnZDuOqP+duPN
         gZ7bAlI4/D/0TJ+AHC07FwMdWAX/P3IWY8yY7Cxlf05XbLJkq/K9RXzyiy1ix/rx5gzp
         GqzGNSgOSxDL2oJqv6vjlqsRIXaaMBZhAE7qTCaPqj/3O08NGz4RlVKhv2kVINi0F9h3
         PgAg==
X-Gm-Message-State: AFuF++nb5M81UTzyApq3EiKLDKS8hy7N0ur1zdL5Qbpz4jDH5iod8Bek
	AZwoHZQEHp+GyrEYM+imAzdvkCr46Pyv4EeOLr4wKyCyOzcpjtw/nokGidz49/bXVkqgcXL3gXl
	rdQMDMk+SmyZIVIzBS4Pt/dv0++SnhIc=
X-Gm-Gg: AYBFou3Q3fsZWKDcfx/YzQpvv/WhaJhtRhOPHZMjDcdddmwJPOsYjWMUFPs/EYdTTep
	Nf32KBoNIjvG8kT7PpsWYUUJlgpeqjq83BYPlShUb3ypHVL5nL32btCSB2zpfWIwmWttINYw9AZ
	LwjNhlQVjCysihp4vjWoMI3w0iN1lrNp6UX1Ss0RIBjLtAis6qhyH8hFkYoG8bgXEw1NH84/ASw
	7fiKOYPHpHzLTC8/k6pH+3ZLSYUWjGX9KvSxafPbgTc+U/nyDxJDSy4J4MVwt20u4X2p+GjxMyB
	TT3CTOOgvdbWZmFqsf/tiObDDwpPr9zqeSQ8lG+bquQCs4nXYU/SqRfbJQWBiYbg7gidGgPI2Oj
	iUA0ZnEeEH+q9NHHixGObRXXlOPXYe+WGZVMMZbfZ1aSXr7Xhb3dNTAebwovjITMMybIXnaz9gq
	lXoerYxFnn2RoBWZM=
X-Received: by 2002:a17:907:7b8c:b0:c2d:c33d:a9d4 with SMTP id
 a640c23a62f3a-c2dc33dada2mr233426266b.10.1790549444303; Sun, 27 Sep 2026
 15:50:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
 <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
In-Reply-To: <2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
From: Faaris Ansari <faarisansari@googlemail.com>
Date: Sun, 27 Sep 2026 23:50:33 +0100
X-Gm-Features: AclHuK-yRwoG3EWnoCvNFcLc3JE7YWNDmy2zbYPYkBL_ZtPL-UpCyDcrqmqvJWY
Message-ID: <CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, regressions@lists.linux.dev, 
	linux-sound@vger.kernel.org, 
	=?UTF-8?Q?C=C3=A1ssio_Gabriel?= <cassiogabrielcontato@gmail.com>, 
	Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

It seems you're right. Reverting that change has fixed the volume
control with my interface - I made sure to remove the quirk flags
whilst testing.

What are the next steps here? Is there a problem with that patch, or
do we need to add a quirk for the EVO4 in the kernel?

Faaris

On Sun, 27 Sept 2026 at 15:27, Sasha Levin <sashal@kernel.org> wrote:
>
> > I was able to work around the issue by adding extra modprobe config to
> > my system, specifically the below:
> >
> > options snd_usb_audio quirk_flags=2708:0006:ignore_ctl_error
> >
> > Does this quirk need to be added to the snd_usb_audio module or is
> > there an underlying fix somewhere else?
>
> The likely cause is 87a6f2fa6e6c ("ALSA: usb-audio: Propagate write errors
> in generic mixer put callbacks"). It is in 7.2 and was backported to 6.18.53
> and 6.12.111. Before it, a failed SET_CUR in the mixer put callbacks was
> ignored and userspace saw success. Now the error is returned unless
> ignore_ctl_error is set, which is exactly what your workaround does. It is
> the only functional change to sound/usb/mixer.c between 7.1.13 and 7.2.5.
>
> Could you confirm by reverting just that commit on 7.2.y or 6.18.y and
> testing without the quirk_flags option?
>
> --
> Thanks,
> Sasha
