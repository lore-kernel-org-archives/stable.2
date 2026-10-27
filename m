Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793120195;
	b=XhzQTW3mCOJUwspTLiChP1nLJo2knkMM5qP7D90SS4+zGHuCimP2hwG4/BXJFRSsCqIJ
	 BtQ49zrV/Rgbt7Yc7qC9UI1lcSViZRbo7YSKoaTQ9vrb1gmuM/T21ih9eYEcOYHHwjZUM
	 W3NCcTh50pD9x17DV/aWGruW+gX34sZGR02a+UZmvCtECdPGlYDDapfMx6X17gRJ1VFKk
	 YE+qxEsCCOo4VQHnvjVphXr7DwFjDqwmgPnKkq49nLnCMs8m0N89UzN3dYC2rASBCCdSB
	 Uhv2Uky6T5AvTq57Q3yXf9UtKvqGPBc4Il0Edsfj5TdpmEnLt2uGQ+a3FgwYAKj3gFA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793120195;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=uB/WSwKdSMSQP83dSeSWNnrK5HqaR1ZK69IbSUsYxlo=;
	b=aAM8Ey/en20WfVpw0k8+yT/D9xvWGAUf2qKvXN6Tg7dFa7MGLXHiTYljA6Vt8ds/vaPp
	 N4Ed6pCo3JkUPQ7FfMO7j9Su3rI2uz8JUKQ3TYFuXV0Ms7TOmnzdhzuJ6fUO+iu3LHuRX
	 /vWMNZ4We9BVP0qAAl8p89EhLePWTft2Fw9dR8qhYimv0W4/1zqeLcZj0i365Wjo/LuyE
	 9KMv7g9ySshTeRK/hHBoPrDdxKDJE8EC3RCm9uHzxqJWVO3MokNxTZbyYIyrfoGauQxqW
	 iM+368hkz0ZfieGLPYh6X7wkOBmqnSkNF2imNn0wRnCR19ak+5RoBW/eBB3bRgiMclA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDYw6Die;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94839606A31F
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:56:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94839606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDYw6Die
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-67a6b2a2259so62292d50.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:56:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793120194; cv=none;
        d=google.com; s=arc-20260327;
        b=bdllACPyxqCQsMrnJY/+DYiFfX2PhDTtXtSlsskHhPUf+QDB3MAgrCryH+UofhcECB
         uZbp57riYH8bwpDjqwcDWeAdD9ROsSAmTXPz6ZHfbL50PadDvT/KlptmCpSuwOtnVhnG
         pIfoGaAVPbbjZLr4++dRadPlEu9w7sliubNRCWzXlMGU5e7mOnLrrqwajOcmkHJJ9QIw
         CibBf61eVi1F+mE7KrQxrX1Bef7U98/AJ5WAJpYgvUxnCkNp+rgXGg98w9S6ciHejmeg
         Y9AuzNOaXuJog6wyYh8/e78E3q1IW/9VuShfKZOm3tHP96vtuVDFkWhD6i7wK+XmeLy9
         jwVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=uB/WSwKdSMSQP83dSeSWNnrK5HqaR1ZK69IbSUsYxlo=;
        fh=t2TmJHy1kV1cmNoYA7I7CkT0cr3sg+39yG5G0QAdjM4=;
        b=XPCkdG7dyI+2s2SFfkcSjdRXibXyByl85qID6/YUOLaq8FK+idiHjas2Fk3J97hjy4
         L3gvVkLfhhIEFMAjU8Nx1QitQBdoW/urihp0/Z186rw1lYVmZvjLqciOCZnMMbpbHRQb
         oBHll/C5LA+ZsyaS49irvyMOgfJ2Neh/IZZvTwtbomyjPd3m06bc82WKmcf47rLdApg8
         ZDXv50bvsH1YuwnaBDroyd5Xb3mI28Q7FDYvgEcF745FfdbJaoW0qaT4c/cmaYktStv7
         bpfPNeqMi6muOTPjl+C9rYnhVBhCGzg9pjemRi1TwP3WTK5YelZGkqKU3z7/6B0+RbWe
         pltA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793120194; x=1793724994; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uB/WSwKdSMSQP83dSeSWNnrK5HqaR1ZK69IbSUsYxlo=;
        b=lDYw6Die2KdQMWd22enGnH9RlSiNSaboywe6ax/oHn4JWnEhFXiXrIqditAtmJIz4I
         ANqYdr5TYj/tBJQHNYsA3aOq5YM15k96itt/c90Myyon7yfyT0bzGguqHz1VlUG2n6oR
         XT33uTMw7r7IxXA98eA3MP69MFkoW/otenWvUEPHAH26nzbYQXFNOtWSOmWo7owoRg9G
         vdaf2sNz2nAnCUaFRYL6r5zLtAIJ+0gEauj9gVt6wzQpXb0Q35Y2BE7A30wkQuXzNG7K
         mlsHLYwqaxo/loPbgNy5h3B9vZPW24h+8UWJfrwr4yeqf7/u2Ts+6s0WKX98fipmIy89
         ldLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793120194; x=1793724994;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uB/WSwKdSMSQP83dSeSWNnrK5HqaR1ZK69IbSUsYxlo=;
        b=xk0w/JPgsKg7dq9EVKjbaItqgoh9P04q5Xq7aFpjelYb7AHZvO33UYMgBE5sttzXOH
         jA/duWwmjAaUMQ49PHEvZzUlE1RDKm+9Q9NmeDRFpnjP0fH2dKD/e8l9FylNh53X1t2o
         OA2LuoY3OFEhogmTPp5Ta09sMxJQijYQJU6Qd15y7/cqa3cH9DtzQzngzy/addQFZ3sS
         BoivBL8it4adQVRXJano03L57snzLeLIDepzgGCwF+L7d36Wl4rIF/d4ZG7ki25c7BAf
         kihAPVMxnbeP8Hp0jKM8qj+ElVE2fpEXZPsw6oTGJgGHnD1biwnVqXYjWpqh2Vtje7nr
         4Eyg==
X-Forwarded-Encrypted: i=1; AKwUvBxU1vYIwjB0HxEBIpxicRJU+P5S4bBL/A2SFxcb0GVtTpn2y96EfgCE8C6LgbkLtR4BzcfdqSg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIgFIJqX8T1OyomU0ycpF2XM55lPq8+JQdnD1Kr9lxgmAkCxJQh
	ONraFHlZXuwojSAqeJH50nlOdLvVHq8hepGct2XRsPQTdXpUr/lbi8zUKyrrkjkaJVmXa06D0w4
	+Klz9imyTHT56QfQdb0XpmGPrpTEa2eM=
X-Gm-Gg: AYBFou2WpP0ZoRy5bkv9+vKZj5p1dTsEjqd+QJsiFgQh3slsl0IB5+pO2Nr54+R29DX
	65wlvM2xDHRXEJjFDsEiSJNWilELXJdHWlG08yBGY3VOMSxjEudHRzsb5c9hu+vTNSn87TJ3+0z
	Kca0cuVRMUkEZEycVNSvpqOaj9CUqaidruLHYeUDFA/8r4g7/a5eutWr5mdHkhWL9iHigCnBG9n
	BeFNrZ548KyQgvm6i0RN9xJ0YDuL3AevzG9Tj8qAt4ndVjHJoAFEVZGQQS1nuswO1i+k5YqMweC
	OOydzSNQoU/Q1G5EBL/IEbFPkEsysCDzf3SV1x0JazjH1WHuPNQYlpDjmdRsIRcYGNAEl3SmoDL
	8w2GFUt+NlclX54xE9WxpeT7zeuTGUlazvDraMg==
X-Received: by 2002:a53:c092:0:b0:676:9578:672f with SMTP id
 956f58d0204a3-67a7bd3d839mr38638d50.135.1793120193486; Tue, 27 Oct 2026
 09:56:33 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027032609.119226-1-lgs201920130244@gmail.com>
 <f342a5e4-82b3-4044-85a3-10cad08595e4@kernel.org> <CANUHTR-SJTiQvo__wbqosSQV958fkHGY33YTRFor2=EwDTdXPg@mail.gmail.com>
 <585b45bb-a9b8-424b-abd4-66d53076b501@kernel.org>
In-Reply-To: <585b45bb-a9b8-424b-abd4-66d53076b501@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:56:23 +0800
X-Gm-Features: AclHuK-GfmT7NjkDsFJqpYDLgkQ0C0xdaJPsVN0W4Sw0aag8wcbtxfBX0j2KDkk
Message-ID: <CANUHTR9u0CMsRWj12EN-b47BazJ8Gjk0yvRHfe_G-BEbrJgGNA@mail.gmail.com>
Subject: Re: [PATCH] mfd: twl6040: fix IRQ action memory leaks during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, 
	Mark Brown <broonie@opensource.wolfsonmicro.com>, Samuel Ortiz <sameo@linux.intel.com>, 
	Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

Thank you for your feedback.

On Wed, 28 Oct 2026 at 00:44, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/10/2026 17:22, Guangshuo Li wrote:
> > Hi Krzysztof,
> >
> > On Tue, 27 Oct 2026 at 23:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> >>
> >> On 27/10/2026 04:26, Guangshuo Li wrote:
> >>> twl6040_remove() currently removes the regmap IRQ chip before
> >>> removing the MFD child devices. This destroys the IRQ mappings
> >>> before the child drivers can release their interrupt handlers.
> >>>
> >>> The parent driver also registers READY and thermal interrupt
> >>> handlers using devm_request_threaded_irq(). These handlers are
> >>> normally released by device-managed cleanup after remove returns,
> >>> when the corresponding IRQ descriptors have already been removed.
> >>>
> >>> Consequently, free_irq() cannot find the IRQ descriptors and the
> >>> allocated struct irqaction objects are not freed. The associated
> >>> IRQ threads also cannot be stopped through the normal cleanup path.
> >>>
> >>> The probe error paths have a similar issue, as they destroy the IRQ
> >>> chip before the device-managed IRQ handlers are released.
> >>>
> >>> Remove the MFD child devices first, then explicitly free the
> >>> parent's READY and thermal IRQ handlers using devm_free_irq()
> >>> before removing the regmap IRQ chip.
> >>>
> >>> Also update the probe error paths to release successfully requested
> >>> IRQs before destroying their mappings.
> >>>
> >>
> >> More of postings by bot ignoring any feedback.
> >>
> >> Best regards,
> >> Krzysztof
> >
> > Thank you for your feedback, and I apologize if our recent submissions
> > gave the impression that we were ignoring your previous comments.
> >
> > We did take your earlier suggestions into account and subsequently
> > submitted a patch series accordingly.
> >
> > For the more recent patches, however, since they address issues in
> > different drivers, we thought it would be more appropriate to submit
> > them separately rather than group them into a single series.
>
> How this that differ from last time, explain me please.
>
> Last time you sent x separate patches for subsystem foo. I asked to send
> them as patchset.
>
> Now you sent y separate patches for subsystem bar. You keep repeating
> the same.
>
> Best regards,
> Krzysztof

We did follow your earlier advice and submitted a patch series, which
also received feedback from the maintainer:

Series:
https://lkml.iu.edu/2607.2/05103.html

Maintainer replies:
https://lists.openwall.net/linux-kernel/2026/09/28/2917
https://lists.openwall.net/linux-kernel/2026/09/28/2932

However, you're right about this batch. When manually sorting the
patches, we failed to group the related fixes into a series. This was
our oversight, and I sincerely apologize.

We'll be more careful and submit the related MFD fixes as a series in v2.

Best regards,
Guangshuo Li
