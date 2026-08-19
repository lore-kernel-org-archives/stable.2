Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE891E515
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 16:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155312; cv=pass; b=BTt6OjIEZJem92Cb7yaECZ8sXBRTW+a5WtPtbPTwixr+BtZM0e5lU3o4FEg2VemjC/AJb7wwNpHT6tjElOQH5cyEsEF3+3dm0Xe/4+PXp/9gUBuXGzsqgy4PdHcm2YGruLcy6nLRdb7IeeXuMj7ahaWAPDrt8XYu4SVw5AXFrXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155312; c=relaxed/simple;
	bh=43WgxPth44CuqYCSLaQiPb0iqpI35dSY+V5djWAef50=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U6MUacQ2DCs3WizyHHaSaNmFBdSq3QA3m1AJ1dc91QTyA9sjEqXoLZYQfD4VHZ9MShv0yhSxJPY7O6bG9YI2vEQV+qwEaKkpfktxAcQaG3GbKI1SSmMNz3TZk0XKEttZ6bMv3cm7901403yx12dJJJKFjTMBtaq9yr1ANcmb98o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wXRSAFWU; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wXRSAFWU"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-52d7ef16f91so6182691cf.3
        for <stable@vger.kernel.org>; Wed, 19 Aug 2026 09:01:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787155309; cv=none;
        d=google.com; s=arc-20260327;
        b=sgqR7rQSTskoM8U0eoL5I5CoVKswpetUgJyrWrixqy7clotKQ7FLsbXycpnPMwXx9y
         nIzweUe43lxlOf3vse2mS0Lm73EmxSzHKMyU2NSI62Gnw5VGOSWNkOt1n2dMavqCalhb
         y93DGd/o32sVnap47OrE/zitHhcJiOYk2AMlwS0MrIojDM7xIN7xYFIr4mVO0tzaxnlE
         wRuuczDx1VRmGw4otdI9o0cuS+kY4UHBcsEv9oL/gFj13fyDYwPuc+56nAeq/ae8HGe8
         HtEeh46SfB7ro9dqPm5lhQdEp4A8pOluRuxMV1khJ5+TkxCaBsmqiVRJM2L4LSd8YoIa
         dKRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=43WgxPth44CuqYCSLaQiPb0iqpI35dSY+V5djWAef50=;
        fh=hCUn4LPjBWntOYJOvXghgj/E7eoQ/xCgVpCRD5fulRI=;
        b=Ett8NY7m4kPIp6baewSmL56haAxzil9SeLtouzvlEl585WEO7wbUADuzJdybLzoIta
         xO3mjw+wSUf2uRIeUn07trQK8XqREH2mrBwwfrcr8EWS0+eIiA7LkqM7sSHN3JFxVflA
         +IyBBu85Qj809GxO3pnOI9TUmuNgs2AUDFYYZRJK/X9+njtv+g23lfrHAc5fxSreH/05
         DEXiot75mOlEgBgUxmmu4QYnx2zGsjsn5dbS0SIsY96SwrHzw6QR7Q8KoFr7dd/reC01
         L0LcQm4dTIrEtQaEI4Q2igKsK386H+K2LuQoHT/Mh35LPcmTwjPV93SmPXJj4UQxSmz0
         CNFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787155309; x=1787760109; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=43WgxPth44CuqYCSLaQiPb0iqpI35dSY+V5djWAef50=;
        b=wXRSAFWUQQ3TQOvrajf8zo7AJwTr4d6Mc+0HJr5FnBuVXoyZzeqGce4jQ7F2VNh536
         aLi5qEb8YIBAN7lmwSx8AsWnD0epiqSQQfSqm56w+rHdV5ed3VE8f+c/+NT4YZ7XpuZN
         ZHuYMbiKNDTLenDwJtYWgR4QmkhP5JWCc6pK7nr8hsUYTCO12QrcNZVboC9NXkZ2pVAc
         xZ9leFfMfdHDO75eDTJyLc4XMY8ERs5U0AYJnC4f/hSB9ci60sRvVXdZ9wP35vrvTyFx
         BOm+IfwEXX78KV+lEYzbRz8kzn5tSjudTJrsWMF2NTC20LWpQ6so0MP6laq/wU1niqai
         qOSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787155309; x=1787760109;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=43WgxPth44CuqYCSLaQiPb0iqpI35dSY+V5djWAef50=;
        b=dP8UpRa1mNPO9gM6jlLFXnGRnD2XME4gcNXJTC79amv1mbhthr1c2R63Xj1kkEPI6J
         CzAkDg10bakk3fRSEpPoFNTi6VOqbYscwvpHzxcYqxskUjjR2SExcPnd1wB3fpXyErAG
         tp52e6lktUXVWkmpQG8eCTibaWFZmPDGusZxUC09nenSjFDiR2gmsF9jVdywn6H6fQPs
         OQobNF7OED3gHLRhqpGYrJRqQv8Fp9ika+YZVvDfTCWHzPrSGtUNO5yHiCSixqsaAi6X
         Lhuxn3lRWRaJrRG8uhKbQ8zYuDP8+z9xmCThSEV24Ee5da7wCDHC6n4xYPyc0JcQCt6w
         0sPg==
X-Forwarded-Encrypted: i=1; AHgh+RomqwcsPx6hxoBxu/EZE8shGSWiO9vy5q30V5sRkzH3fC4IBqZfieLN3uBG0OnMneD0QWi8iLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCjbzZC+8MVJayjzX1/Isx2qi2RSgPPPUXhuWubKKgICFr/X5z
	ne26l6yn4Jz5TH3KDsSk5UukaVAnZXaiNlxdL6Dd6QiqumRe2xH+vbJvqzUM5joG8wP0RImAyjV
	qnFUazXGRdcAA5KZhuXqnOeWaNHIMjcK385gZkCrt
X-Gm-Gg: AR+sD12yZ2quyIfAwz1f52AEhOltxn6y/iUuocITxaZigyV2FRCvrpUXcprYTtFqbAH
	t8PMV+8CEAUmcmkI1Dvct4x2mhKF2NzwEHcIYYEVF08x6rii/ufl6mnhxSh8b0oR33yv8nNYn8y
	BT49+Pc4MOfv8Xs8eXXBLzbuqnV+MHTpt8790z7Q6ZMLN8n5unfbumBAaYg3kzeg2oHOzTQL4pO
	Dsg5XwV+TF6aiDNg1FapHRrLRi3anz4ejRgAJTZ26bOJGPjWai2zYhWOz+H7RwqgY/ce3eZWE3z
	JReIISvt1I1QzPpHzfCl1J++FYDFXih0b+ATMvsFPCGrneivYx+e5VEbmiaGZm30yMAd0DKXpF6
	5RzlRLBG2wwT2mPPHz9FcU9ZHgV05PT62g3cRdAl56fvGDJKeCAVhU/5EZHd/PymtRrVmZisk3D
	QoIcYldWdQX2fz8U8=
X-Received: by 2002:a05:622a:1f87:b0:528:22:8c61 with SMTP id
 d75a77b69052e-52dd5caceadmr58314551cf.38.1787155308636; Wed, 19 Aug 2026
 09:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819143136.57350-1-jhs@mojatatu.com> <CANn89iLRPjpKF6xrWz=pv5cWXT6FxCDmOprXKrkDRgQH4Jin-w@mail.gmail.com>
 <CAM0EoMmc=CNVO0h1miKSO63uYH9f6YkX6=z+itqALT9tAYtcog@mail.gmail.com>
 <CANn89iK+xzagk9faUSjHQj+9kTnWn0wg6tRez5XtkE14G+SCvQ@mail.gmail.com> <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com>
In-Reply-To: <CAM0EoM=6C=yarfbjtegiobdK9jvLzLwJSSMxFBYDiG6XtZQ35w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Aug 2026 18:01:37 +0200
X-Gm-Features: AcwNN1UxvWHBCT8HDHQEZVo6y7JWszgVh6-23ZZ3QgUYycuQqHowaQerrtfBw9s
Message-ID: <CANn89iLD-c930HoW0tf+A3c+5ANHv7iRzy0wFt-HqNFswtee9g@mail.gmail.com>
Subject: Re: [PATCH net v2] net: sched: fix quantum/backlog overflow in fq,
 fq_codel, fq_pie, hhf, sfq
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, stable@vger.kernel.org, vega@nebusec.ai, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 5:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> Ok. So one patch per file?

I would have done that, but you are the net/sched maintainer, I will
certainly respect your choice :)
