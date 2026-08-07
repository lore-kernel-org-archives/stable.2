Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280843115AF
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786123005; cv=pass; b=RZheHPTSYBKxr4j1n9+DB9KLVKmiN8vOnnU3jFqHvuydaQwdFMoRbRfD+39suHSUI5cEHayfhQ/6FKHf1wEg6q6NCqWBDrFxiTTSgQgonOPJNsv6jzjdn+se8MbIVtN2XApfZzbbWDEWFIQK7S857tHkJXeSJLk16HILYU/007Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786123005; c=relaxed/simple;
	bh=Rtx8ZmZNm5nMH0poOJXM5HHavD/fWSB/wPvaR1ec6bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bYL7NkVwqObDtev7BxtnSANbGckb2oKwkTIWaxkh58FUAPVIR9DkuWweowzDzFQQV4ydNZDgg+pmyVp9BMvEJAYdjftaCas6f3+fXefsk1kC3C+XZlEXtLCJU4FjYtKjUf+LD49go0wLYkoYIgC1hbH4KzWLNPhwoykla4eApXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oR3mxwnA; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oR3mxwnA"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c15e62c695cso35780466b.1
        for <stable@vger.kernel.org>; Fri, 07 Aug 2026 10:16:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786123002; cv=none;
        d=google.com; s=arc-20260327;
        b=OmoZPARkGajOaI0G2DtSLPhOvo3ItOTEntDByxV2XRDOmFbhqZh2qo3plhfASohx4d
         /Ddru2Ru+IbJW0Npiq29tJ7E9sP72EFqV8l8GDQpsoRgq5jxL5jrxE9V3EGcevrAiTTw
         wQHnQSQTml/ujqf242MDGSnHf35k4C3OWptOlsZP4LB4ndlF5dSex0/+uSs9o7VIKi5W
         lnnB6jyIwCmHx77T+dd3bQrsknl8tyhSGTTSjJie7yKLt0HVlMo3mMFCx6O/yGauWW+r
         uu9+GiFaNht3Zv5ILCd4PDyVwTQIrIcpmu9KjZ4+yQVm4rEDOPVtQUCRkVXF2f+VSs/h
         jfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rtx8ZmZNm5nMH0poOJXM5HHavD/fWSB/wPvaR1ec6bI=;
        fh=8XdCdSsYum/EI4uP0LPQZ7Uhacp8D7eTy3xFPYLpRmU=;
        b=f5DCy1DebAQxAN7NI7o6AwV1CNkdtIirB0O3raISRqWbMoQjoFzL1XPw8/2/dbgAlR
         LGj3NS2QdWM8EE8INAQ/sZD5fFLZE8ux1EADjEoa6f5gx5B7kIMOUpZYarFrS/1vA2WF
         /pfXms+AKWUAai5ElRdNER/2Eo59tgQLNb6SLqD/CTUXz8g4434RVyv88kKcRqsLz1Ws
         b5k/6YHXRTI9EymQXwekMT0xFrG6DUWiQo26hyZsBqJdZyQi3YEM1Fu3wh8NCb98NmCx
         smZw0LJzTn5O7FQGCKfRy17cmLd9sgzzqViK+Wox0ymkZYVqfB/Hflc+jEFxEUrSziYk
         r+Rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786123002; x=1786727802; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Rtx8ZmZNm5nMH0poOJXM5HHavD/fWSB/wPvaR1ec6bI=;
        b=oR3mxwnA+tkTMgtqEhW1tsb85qlAwqf+87YN/egDgBM1uOGGAtbYi2ecWJPtp6HGnS
         tHPAn+aCvBhZHli6ewZ8HVWkOiEFsiC0oMWRkjaYIZ+JSIV1W8m07C7VEunEpFJ53yQT
         bV6doIG7teD7Hu7heSMQzU3KznmrPTbTwKc6XSA7J67UFkDL6j9tuRsIphHAuNk/vt4k
         D6Gl8QNooAzaa+DERYyp0muSa8nPuVyhSXz8vth/HOfM9Bvippi46V5/Aoj3y8UESDik
         BZBGCd/bJpuxGkxz545ieDiPMEPrv9u6lba+zMNqxe/WUfXWQ4FkKg5bxIzmdsQr9Y9w
         aoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786123002; x=1786727802;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Rtx8ZmZNm5nMH0poOJXM5HHavD/fWSB/wPvaR1ec6bI=;
        b=RBtJgpnl+zNvZAOvPraMJ5Ytluz6YKi79vxwg+6y/cVZywfVGGM3dVPzFV/eA3qoEG
         4r0iir0zFcB4L6ZKpd7R8xCTqJUiTlZ7AoFETGd35hMsE9SJQ7i1SHrVPVpNGC8U7IWm
         8lijFdRFKto9U/ODygSG9NQzmfBNmNQYvuBocQaS05qMLhNXV6XqZlBqaGnetKkCq5eo
         eECUcfl4+Qq0ljcOti6+0qk4ExYKNiOYQEfk6seqVgqoYpU0NmzfFgpzPGo0sMBI+972
         Sk/yNbzXvwOEFbkQ7UxmtuQ5xrvLTYwIvKR7s8xes0T0l9vEPKzNFMqzFWz4x3ZnyzbJ
         TQ8w==
X-Forwarded-Encrypted: i=1; AHgh+RrLNN1qq3XSMEb3eYwFn71hHP92+vtBlae0pFjhpFP6nRXl0TIFVViylNR6P/js0eTXfegHVKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMStQiU713Sdqwm5Pz08w+ayQDPcbVCGc727BlkSEnKHnIfjEt
	tMw+JOcXWjb85/LbQod8yrO7VYtuQxr0Hv455Ui4JrIKcJFAZHRusDRmZb0NmtkfY+Hc528dSkt
	zuwl6jYFPw2gFN5uQN/eNcY8hMQUpwO4=
X-Gm-Gg: AR+sD12IobNbCkDGC095QaRRSk+queni8Icyk7UGbnPQsJcsNkhXFTdCAI9sWNGfBBy
	Kho213mwpaRMnAdzfoodjHyWCyCkWyG+z0XOikip9U2OfVGTJoXREflPa2ZVBLqZZTgpeSoY6ya
	d8ETEbBoDVO/pkl8vd0GrFbl7zrk3OtJuK5KeAkYbBg0XBvqEcbx6lkhFNJzFpfGzYNrYRS/snj
	UMaCwXzuxDcDYfe1r2bH3Ib54EQGMIeRXZxR4KjFAoXttdYhBlAeh5zqMYRmnbXcHr8ytl9R1Is
	qQW0kN6pB0GiRDQ39Hx9Ib21iGiJ8X603mpGCuL+uuKm8/s3MTun1pAiMeMUQZyYwlRD9bG8ER6
	f0aSy5wjS6/btoV/BAtrpsPrCMi0/Demjd9bLSeoHhfs=
X-Received: by 2002:a05:6402:1e8e:b0:6a0:a4f4:bca4 with SMTP id
 4fb4d7f45d1cf-6a14f07c8e2mr6612492a12.1.1786123002218; Fri, 07 Aug 2026
 10:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807163418.487508-1-bogdan.nicolae@gmail.com> <19fdd238f38.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <19fdd238f38.2873.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Bogdan Nicolae <bogdan.nicolae@gmail.com>
Date: Fri, 7 Aug 2026 12:12:48 -0500
X-Gm-Features: AUfX_myiUNyTJjYFkszlm8txJvLhnyde7l5fcWYkuiyDB5Q-vCiwqt1JvwI0dCg
Message-ID: <CA+ORkNRRZ_qES77+12=Cx2rs_ntVqmOB0vzUtTOJddabpMvAyg@mail.gmail.com>
Subject: Re: [PATCH v6] wifi: brcmfmac: cyw: pass PMKID to firmware if present
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev, 
	brcm80211-dev-list.pdl@broadcom.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure!

Best,
Bogdan

On Fri, Aug 7, 2026 at 11:52=E2=80=AFAM Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> Op 7 augustus 2026 18:37:48 schreef Bogdan Nicolae <bogdan.nicolae@gmail.=
com>:
>
> > Zero out auth_status on initialization. Otherwise, garbage will
> > leak from the stack to the firmware (when ssid is less than 32 bytes
> > and/or when params->pmkid is set). Then, pass the params->pmkid to the
> > firmware (without it, the firmware caches a garbage PMKID on successful
> > authentication and denies a subsequent association request that include=
s
> > the PMKID).
> >
> > Fixes: 66f909308a7c ("wifi: brcmfmac: cyw: support external SAE
> > authentication in station mode")
> > Signed-off-by: Bogdan Nicolae <bogdan.nicolae@gmail.com>
> > Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>
>
> Hi Bogdan,
>
> Looks good so my Acked-by: still stands. Thanks for going with the flow.
>
> Regards,
> Arend
>
> > ---
> > v6: Fixed diff line number
> > v5: Fixed line length > 80 chars
> > v4: Fixed indentation
> > v3: Added Fixes, Cc: stable, and Acked-by tags
> > v2: Split into a separate patch
> >
> > drivers/net/wireless/broadcom/brcm80211/brcmfmac/cyw/core.c | 4 +++-
> > 1 file changed, 3 insertions(+), 1 deletion(-)
>
>
>
