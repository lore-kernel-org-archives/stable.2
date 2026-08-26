Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F6A313547
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731976; cv=pass; b=ghZVX4KQ1g1e0q/YETADFL8Jy4aLmeRfdXPxJorJG/vjeuWGqhxhXeayk+yYEfMLwtV1OBH/LueqLXKtbCF9jWMWsj7OTXAPB2fWBib3TN4wCDgYZIow1hjWmCgIjT0+ewqI9tY6Zy3OC7WaIEAB1RzRu7esidyASOHVV2onRw0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731976; c=relaxed/simple;
	bh=kAHZOCv7XkuLEBc02Z7R1yP0Zw1Cy7+DYa/ywssttks=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlCPmI0mLQc7wu3WnK9Wl2WUIQYu9n9RHMvhY8Wa7xA38pLBn7qAzijaVXQPJ3Wk++2ltxPqhphme7Py+8I8jcGt3kXP9q/cTCTfnQx5QlJVxiDxjXRYyWsUc2Fy8jw7szvbv6CGI0KnIvGBI5923cPWj3ZsAV8GP0SuleJcaRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IH41UP65; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IH41UP65"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66c9995ca60so2910231d50.1
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:12:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731974; cv=none;
        d=google.com; s=arc-20260327;
        b=WmJSQJXifoARg4DmfgLEaD/TTgi3y+rz9EVXUphXg13IAzpnoI9Wkzu+8Ti8EZcbyZ
         aXaW/5e9PikqMAG0cziWM9VklfDWh+nMyIoCIDBpdFA3CzmkPZ5TYQNBRxOgfdn1jy3C
         UTncjJPVd2Msb3THjSadDQIGbC2Fclb5eieldoWAayYYK6v4uP0QESxhv52Eqh1vyo5d
         fWTkKcL1T4ul4T1Grbd/h1fr8GkUaVL7hgWZoLY9IVnBBz94Ac00VaJ6eybOX6etEcNP
         BsLI+rqaUEShc2YNJVWQgo5p/49z3uJpVRDrRR8d1+AJaUc/xgJ9RuNxoGN9q1oC76mF
         En/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kAHZOCv7XkuLEBc02Z7R1yP0Zw1Cy7+DYa/ywssttks=;
        fh=/xLyS4cf4mSwf3HMdY3ijJ8TrEH1oYqOSNO+p8TTk3I=;
        b=OD82KatqXFkzce0uBUUNdFl7MMBAK8MICH1uy+nJZQ0PJu6hq3o92xD6P55H92LRHx
         e5d3NyCqK9KDK2a6n7V1DEy5VP8z1S4jovNHwhvpBASrkq6EWWqLYJlmKrXxoxDv488u
         WbCQAX69FwOIWVw8XKtoCvM5K26IZel7QxCheeIIGttK1LAtZh1ZPZoBpMEISRTSbdtt
         /rfJRIL7MCB/UBqsZ4FwxnBGy9fO7no+Cz0Ersa01v0OkBl/rVFzhoTI9oIGtYtaGgwV
         npw3jcw0PFMhqw7tZZ8t0/WtKQcJIIc7KEl4ohqvA5uuP4ohb29HQAxoly3hLWEa8/O/
         w4ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731974; x=1788336774; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kAHZOCv7XkuLEBc02Z7R1yP0Zw1Cy7+DYa/ywssttks=;
        b=IH41UP656+esuAlMfRC334PIae4kSk1F/SjEylJRZjLgfosVUIIeVgAayldx6xOEuT
         l3QZnQ3jN1iCZ7PA1aFvYqAMXWBWDouodHB/Xrg4/SxVPWiXiAGh5Msl38ZGc8KEu8+x
         rQAyug9MFePQA15JR3/6nHKJ3xzAPxIPyGnVMbHETc+xrM3/NYYWppcc7shZWcdd+s4Z
         UKYbIS6wPxq4WKHE3EuscEwpaY9bc4oONMq2B7IcBe9SbSgWl86g07ZIR+TK4ao0lfvq
         +iInecQsA3datfwJ+8YQQerSSjXNR127CUTYyj5NLbZriQs5nbO+tcFdvftW7sldovK0
         4CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731974; x=1788336774;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kAHZOCv7XkuLEBc02Z7R1yP0Zw1Cy7+DYa/ywssttks=;
        b=iWhC8PtX7y7OG9sQ+O38+auf60LbViJaZAQwRsWJfTPl60UIEzUOJZChVCkFLJrPeq
         GslAtJUpJUEIgRmShmsBk2iElwvuMMtm/1KFHwn1antwwddJDAoIXEy4tukNsoiw/pH4
         AyLaaCc0yWR2qUmnNMmnAvVkj4N7WKdUcciqsNFBJdYuwqDe+sRq78AtSUEDqwlq2VEY
         P7mSskGHCRA6a808sROtgeUPrHrk38kLYq20oDByG0qVB3FCAfuywXjPsVnem8VGxnyg
         Yay0UgzF0P64h7rf4ZcZvh495sLYIyR810W30ZWVGdHFs8VdVySG+uLn/5MoldJjCUvv
         Favw==
X-Forwarded-Encrypted: i=1; AHgh+RoGQ0jCKJwsJveqJdliyY+8KmDZEAnsdiJ9H97mqE9uHnf28EdkQ6ANFJXEiCpQ95fuPl6o/iI=@vger.kernel.org
X-Gm-Message-State: AFuF++lWRKq55w0rGFHJtgbChSm+6ni2iB8Su31CmPJ2oyVgaGr2CDcQ
	Au5RyaI64S9IF2bmAMEksv1rolxbwU2e9Vw+ot13+gQ+jaPG6qBug/srXB2qwSrTiVUG2pJKvcE
	+tLZTQx4qc89M1ytYXxGsZcc8wCLuNQE=
X-Gm-Gg: AR+sD11aqNFf2W+KVVDngozax6JoJ21ZQuD15IOjQNzWf/JldTwMbJcwx18yye1BYMk
	FsIQYGtCyhtbanes8E+EAYxhgIJfclTW27S+bbqVwrqme46qWhcYEQibSkdJP/zFk96Vjvn16RD
	yJXUIQjbFwUFAWmWNSkwkhp13M4a492KbdTj/VuK59ndCt4d4K2hOdUpb6ICKpJjuVWVPWmF6Yn
	pfaHi7vllSVORBYsV3LkTuPJvJt5H8sat09Y6ANv9D7lw02+5AWONR4UZtH2MwR3qcO/aJa4lWR
	JqAwHdJM79Dp53iNmLN0S27vLcaFPeG01hQ4dXFv9CTGgLo=
X-Received: by 2002:a05:690e:1383:b0:66d:1a0c:d76d with SMTP id
 956f58d0204a3-66d1a0cea32mr3414212d50.5.1787731974283; Wed, 26 Aug 2026
 01:12:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808064145.2615010-1-lgs201920130244@gmail.com> <4c21c057-a928-4723-86dd-2caffc7b0800@kernel.org>
In-Reply-To: <4c21c057-a928-4723-86dd-2caffc7b0800@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:12:42 +0800
X-Gm-Features: AcwNN1UVRBXcZNCO39BCfYIp8FDpd17lRa5gn2KW9t2S0yPH-CXmwS9IVC-apKI
Message-ID: <CANUHTR-cUxCjjiyUsTt4=mG=S845oZVG+2OkMvOU2Ed5-DDV2A@mail.gmail.com>
Subject: Re: [PATCH] hwrng: cctrng: fix usage_count leak when
 autosuspend_delay is negative
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Hadar Gat <hadar.gat@arm.com>, Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:48, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 08:41, Guangshuo Li wrote:
> > cc_trng_pm_init() calls pm_runtime_use_autosuspend(), but
> > cc_trng_pm_fini() does not call the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() call before disabling
> > runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: a583ed310bb6 ("hwrng: cctrng - introduce Arm CryptoCell driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>
> You sent vast amount of patches, all separate, making it very difficult
> to track and respond in efficient way. Do not do that.
>
> Group your work per subsystem.
>
> You were asked to clarify and respond to incorrect fixes statement. I do
> not see how you clarified and responded at all.
>
> Best regards,
> Krzysztof

Sorry about that. I should have replied to the earlier review comments
explicitly, and I also should not have sent so many separate patches.

I will group future patches by subsystem and make sure to respond
clearly to review feedback before resending.

Thanks for pointing this out.

Best regards,
Guangshuo
