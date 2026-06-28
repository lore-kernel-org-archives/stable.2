Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B32AD03
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 16:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782664742; cv=pass; b=en15nzeEAk6mBaG21ScUXsNTw1QH113sCj1x8hx0PiC4EdiZDqJ1wCrSIQOVadAyNV/ziP+19b8qYwNl4kF0pGs6ea27AnLOta715VY95FXNg8SJalGOMSdccwnjtMsjFCxF2OVLSzUT3vATtzQby8K+rAFU9utypid0HxQzt14=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782664742; c=relaxed/simple;
	bh=oF8AWW5pjpmqFrKuyPZxBk5waRwfJr5BbduDrbPfG8o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OwKC2uqXmrhXV14J2ohCSXBjHMhUjd8BnQUngPfrwXAbSoWPWaasTGQoCAi0Mahi2m+OygMuemLEaXLWGe5MFNtDDHBFyjYa0rUOaT60rbJqFSttZ2MCbYs1cE+p7dmjy6x23uFSeX4C9WJOb4P6hpUwJtHFaMsRiMg9theXPbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKur+EGk; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKur+EGk"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-693c51a8a19so4304291a12.3
        for <stable@vger.kernel.org>; Sun, 28 Jun 2026 09:39:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782664740; cv=none;
        d=google.com; s=arc-20260327;
        b=NalgbR4zBAIDFZAb7xKFM0eWDta7P7qXFtA+jOq4R+bt85eW0iVtGQpFuCrLINYw4t
         vDYhIua6UjX1evQdmh7cS6dnOonnuao+ierWFHFJeR9GmzQmBGvJbOHKBAE6gYBVUt2p
         I9eM1yAH3Kjem6XIJpSm/eMpibmPrX+S3yjbTi50hkx8MSalu64AtuTCK+I6HNa+9xND
         r3WFtMti/YHQjVcupnXjKNJlnKGYlEGIEfVjijiGaUsd8E67WczhfmZznyxTReJYlAne
         Vqfcz24+kpRY15UbGhML1nCwQA/TFs3vgpFooVLl4Q46TlAd2iyn1Ltsx/FcwUWY1nsE
         mwnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oF8AWW5pjpmqFrKuyPZxBk5waRwfJr5BbduDrbPfG8o=;
        fh=eP1cPncrgdqtjM11N5L72ByIXLDEHITuvD9uPK9sYBI=;
        b=dAuqHpZOzjJ0V1lieJpuYGhFsiu5oBIOvv1WapVpL23rtN/26t9pAK6i8ZxwkPzU14
         jWgtpf0UHTm53iaLdYd6EPmWYSPvtnV7L0ZfZu0XDi66CnZJqb2O9Gghr5s9iKM5lwq0
         K5BfwjStNC23fa94zRC7k5QfKdEUj2BwTVHGSrRJFJVawpchMPNLbU0G6zgBpeEfWhEa
         4lobn99U8wC399qBE0U2Q7eYNijbRf1B5InMs4oBLC4Z+S4+vlDp6QQ6hT/v8Hl9ie+Y
         wxHlGqXIqsUeOJ4bNpqS19+lRLSd6uULrJN9FKk0KeAh6C0H3XRaNKWHFQxbyrxt33pI
         hnig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782664740; x=1783269540; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oF8AWW5pjpmqFrKuyPZxBk5waRwfJr5BbduDrbPfG8o=;
        b=bKur+EGkofcnljX3bv3FP201GzxrkWvwtLw184et3muuSdKWEJYOwb/GW7ZoOw2q7q
         tCLYYPzZzruIbaz5+492nXo+JiBLwlMGs9jMVsJ7pN0v9K+iiai18TrN9XOeCiMgrFE2
         vq/bWtGLPf6gnD8Hi0Zd8TzMaAV71DDxOS5Rdom88wyd9E5VHyi19+aBhoIADgZMpCQ8
         /WhnOyOo3cnlIifBpaY6igj+jl/kuv956ZQUGEVmHhI71r7HGihzzmlHbZYo5TrBBZE4
         AKvC6I7ju1l+r1f5p6Mm+qzbBP1x1Sd4LxYcAE0dHZEIBBe/u++QwYYQ5rfjPMMSSEnr
         N2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782664740; x=1783269540;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oF8AWW5pjpmqFrKuyPZxBk5waRwfJr5BbduDrbPfG8o=;
        b=VEe4S4qvwgLtemS5GMHpRrEmjkjkoIS53zavpBdZJDh/yUMcqQRw4PjEbX3sexWELw
         5BJFx+c4HRu1noDYy/XnoVn6Tw+/R6ODn8YtRt+M0mwKFSF4W9hg1FwEZegYOaiKNmZ2
         ozrusG4IKscwSEnp5ibUNvGxLnXFNssI1N3ynA3Ui+UsuIXB5iqf1Cf2M30uUzBCe/vs
         +tNGP3BZaNYufWK6sAr7TWBO46zirnPxpxaget/E5Fh5p8aX7v5mQBOqrC6m2qBBl/jP
         yorJHRifN5qs7wEb7oAyu5Jvw7Lhv7uXDnca7BkZLQlnC4Yea+OkFl7qHXSNGtZMrZAl
         ZIRA==
X-Forwarded-Encrypted: i=1; AHgh+RoD5S1fwk8Vif+mxwT2AjfrRiHK0QNxcY40zJmuSofTcUepDBVVpd8DcvnDgBo81opSycA2Q6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQWlluSv4hcPjusoUG3e1XWNVzybypQK9TKeFjJJ2QT3g+ZipZ
	ubf9NH9dMYzDsXnIfRgNjgW1DRxAQ0O1CuBUQgZ8w7VyQoxRgwTTMIQFLt9LmHhSbgTCzlE+L5V
	XzgJ7NUHhhllA4VRelKZb2kKCZIK27lQ=
X-Gm-Gg: AfdE7ckCJ2ViUCI15zwbPSgTyOOQ5bIQttYYpfKP27tjh3jL/hB7IBRdynjSQZUZK90
	1Wqm8XdTLUMiNf63cMjGvjOj2h9WrKg71rDIlxi29VN5ukHH60YiQeXP6zLnsVurlz0diPJri3U
	jQCOP9Py0AWI3s8cXjzbEPwMmB+R3uNBHgyp7gmh32RDL7SofNbl08pseW6y3A0otxSloamC1Ok
	ucPOYMcfTUiiVOIEuLCHTJxm5U+ZXr/RwqGDjq+V4kbe9U+jOxguKXigvoiIFKsIYHoCePrybfm
	O7afpjk=
X-Received: by 2002:a17:906:c156:b0:c12:3c96:838 with SMTP id
 a640c23a62f3a-c123c961142mr249845666b.4.1782664739321; Sun, 28 Jun 2026
 09:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260623161035.5792-1-nikhilsolanke5@gmail.com>
 <567e8866-4308-4e5f-819c-fe778dbf74f8@rowland.harvard.edu>
 <CAFgddhJk0EYG71fnKdio=RHC-cH+JmL-EZ7-oVD-LdHoa2TBSA@mail.gmail.com>
 <5159fd69-dddf-4073-a8e7-95fa77de0b7f@rowland.harvard.edu>
 <CAFgddhJ2HeJ=oTBX_axMJcgJq7GXH9abe+LH+x9NGekGO4BMyw@mail.gmail.com>
 <eb0dfd45-91c5-49ba-a297-b183dbc52c8c@rowland.harvard.edu>
 <CAFgddhLZ9SuOzG_6mW09j9aDkCp6TedpNkzJ6TUD+DnR3TDLKA@mail.gmail.com>
 <02060df3-b8c5-4a86-b3ab-3a28eea8a562@rowland.harvard.edu> <20260628165040.76fd608d.michal.pecio@gmail.com>
In-Reply-To: <20260628165040.76fd608d.michal.pecio@gmail.com>
From: Nikhil Solanke <nikhilsolanke5@gmail.com>
Date: Sun, 28 Jun 2026 22:08:48 +0530
X-Gm-Features: AVVi8CdB5AnO0mtdmg2yxL9ayYJoS_AHThaWgN_hBet0KNFvHXEcgc-7Urzbs-k
Message-ID: <CAFgddhJehWf5P_=J5pJM9h7MYXxb_qkfNusHW1aJ98wKXh3ZWg@mail.gmail.com>
Subject: Re: [PATCH v2] usbcore: Add quirk for 255-bytes initial config read
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, corbet@lwn.net, skhan@linuxfoundation.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 28 Jun 2026 at 20:20, Michal Pecio <michal.pecio@gmail.com> wrote:
>
> On Sun, 28 Jun 2026 09:55:07 -0400, Alan Stern wrote:
> > On Sun, Jun 28, 2026 at 11:53:09AM +0530, Nikhil Solanke wrote:
> > > I need some help with the USB_QUIRK_DELAY_INIT part. I can't figure
> > > out how to make it properly work with my patch because of the
> > > following reasons:
> > >
> > > 1. I don't want to move it to the top because, from my pov, there
> > > must have been some reason for placing that quirk where it is now.
> > > so i don't want to mess with it.
>
> git blame is your friend:

I'll keep in mind to use git blame in future. I haven't worked
extensively in a large, collaborative codebase, so using git blame
didn't occur to me in this case. Sorry about that!

Thanks,
Nikhil Solanke
