Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793118117;
	b=WJ08HBL/DdG+JeQFrwxBsd/cBgOrp593HmRypq8LtXeeo4LnFEw2E7A+jtxg2y5lHhTY
	 GfQ8rYyYPtJwEImVHr2bJw+wNSK489w9gv8D40pDaDXd8zQ9f3Dq4F4hi/6HP+2xO+Waa
	 RiOS6PilmDuYjUUbweNVX9JjCdoV/fgjsXAMGANCtmrKF2fdEIJcMULVgKekA4zjtl7Wy
	 wcbotEgbhVt9OjN0akmc7/88G3XpOE03QMe5/d2+ItbLjnFRRFz18GRCqeQAn5gppgNiK
	 0l4NLQyQF0ItB5QRDhToIkZIcurfqafM2ASNAiJenDwwVqKhy9mH/tKy1I3fW6G6PtA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118117;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=WGMFH53fvXz3fTXe4+RA6dwEuGNwjFllOJfSunpTT8w=;
	b=p5IIv+s/U41ynr1rb01qfJLfAASDolD5BK74UK656q2puM6dt5wt3jFUtgD7MVxjSYe9
	 Rs+JDB7T4LwVTl+dCu1LIEOT0USX/DVPwqTiMob0Me806+FvSrezTCWsYK8aiNLpxR1C9
	 22Vi0dDWgSoDXO75qrf3hN9qKxSZ2DhnsqUIj2ZRym/LljEJFzV/22Jw4VEkqWJJE40Fx
	 nPP7+Z/d/gJEA8Dc6r0HI31UxikFnpu3IY3SvJUq/j0jH6Hk3nEDoDCHTorvTierYPQwF
	 ox2JADUtA4Iy2G5r7PeVshRs8NLBS6/ClV+CXeo2jA69PXUQQCWoBjQ2RXSi4z/n/Vg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=caXsg8eD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9E2606A31B
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD9E2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=caXsg8eD
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8ab3d3c5761so39097297b3.1
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793118116; cv=none;
        d=google.com; s=arc-20260327;
        b=AXus1aprVWtvj8qSpy3zzqmBtygyKrxmASbY3o3rRn0qlKXWkB8lTb0oI5q/miVMAD
         VAyWqobPfuUDan0oZWFKeSHu3ypUlZTPz/1Q7/sLUGuB+eWUWq0OqBfIa8BVNM5bwuMt
         5H/JbL96vDZLUN9DkaxGAm7rW2yaUaGWnrpB2ealCbeLOFbp2C2W8bOtYmxOLbtPDxyC
         mydNIFCWNrVr6QUm/MM3M/Fdg78iVBdSXZgXexoP2uqaV2xWlD8WCkOWvF+Ev2ilycB5
         TPo2kCt+GwRfYrO+1NF7J9p8Jwba4fqclHfCrxHYYeNU9sACmxYKb4AX/BqAL06cd1n/
         WVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=WGMFH53fvXz3fTXe4+RA6dwEuGNwjFllOJfSunpTT8w=;
        fh=EK6KrR1aaeL5HcJWTOQV+Opp//6c4YDfzXiM+Ej5rVw=;
        b=mDJBt3f+PBWMXd8DgS9l140v4M+DfeyI+DnIBngN2MPW5NqApGAGkUevPv/jXcDQWO
         O1qB4pfhax3vJaRtd+PUrD4uBxspgeozo2EdXlJfAPYOL5xe4XvJqdihADdpvOSk5oJi
         Q1iqbun2yP862gezakjIm1OBk8DNAKwmRGD2z6pvYViy3CPicdOKPZGi3Bu6vSsWyaqo
         bYhtqgQ5YlnoyphY8sVSllA7FBUkIBiy6ELNpnoEB1Y5Y9SFWxVmjJuPLmMOecMQSuwS
         aCr4JV3du3+85lyfjXMCDIe6unku035UaeNXSBACdCjqBBAyc79uyzICVSDRQRVnrzCk
         52kQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118116; x=1793722916; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WGMFH53fvXz3fTXe4+RA6dwEuGNwjFllOJfSunpTT8w=;
        b=caXsg8eDJZuM0Xqfamw/nWCD1s6Ne3MM+74gMbQZ2kjyh//9kfSetHNy8QI3T9JI/S
         mk2/YyHh7riPlaMdJmR3GELfrC26Hce/RM6Ixoxc3oEbwaOt6eLK1sEl5Pbn0VKqv+QG
         qjVs5SyBJRBt0MDYMKDtL30EInYvru05tyCNysbo5oJUsatNAGLclJJtRHmjllAFpDU2
         ZaN2BZrRMo0aszN5FW9hEy19f37novWoHiNwwRB9izJQ/hv8UANi2HXTlxHddQsCIsqn
         SB1wB3Ipp92XpXAaMumhy61xkWfSor/tWoCe3T8UJaUMiJ+9YQRSlrGMHgK3/m+7JQVY
         wdww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118116; x=1793722916;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WGMFH53fvXz3fTXe4+RA6dwEuGNwjFllOJfSunpTT8w=;
        b=ezyJdiC0C6C8ffaxtk6gOzxa7k7NwRU4JGm+aCSfuvf9tn1FrwI6xb/qwHD+D2POO8
         9W/4QKHi+5+T4RER+KIdhWnZT2yCGHPdvuI/qSeJsl2oqUhnqhD4/TakAHTtsLxMmQfO
         38Cx5AXIGa5DcpN2DD2Tl2VfNGKZ30PA9CRrd8jnowpd91vKJHcOJ5ig6VOmpN9riPHu
         4ZfQGkVXSkmALMUD4dVma6y+8N9cN9aBRGTfwRT1mzNuZuBUrv0EuisYPBZLZJfF5aay
         0wvaF0Lsg00TFiArtPoaOQ98XItTYOSiJAI390M2KypoqlzizdupwKnQjBzN3EqFEo3b
         vK1g==
X-Forwarded-Encrypted: i=1; AKwUvBxLGDPioLvOXe47a6g+nUXKrGXAAsfEYlnxPRl53LSvERxvn0MMzeFhN28F4nj/VafytypDYNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKn0W48Vzwpe6Si/myPsv5jm1E54IOYynLWh5tFaKD64N+lBg1M
	NNrz1gS6ocGW71DteDRiTnmTrBOvAoiPdjM0zWyE6rzeB8fr1OXnY+RUyzc3GCzYH6N9+gzjzPc
	t7eG1jCzTnRC9GUgB5KsZIyjDpBRbMoo=
X-Gm-Gg: AYBFou1qBlqfyar1eHCqQAz5CksLr+fFMkDCeao/0570Ynf/YsIYe7yply+iQ4JpKft
	9fDnIUchzq/lNKed+TvxMq2r51EnyIil/A4+HrlFfnp0vrzoTsGmppEpHlv/HVFyBPPVdQpTl+/
	5NCIc3OZbXvJP6nQR8fS/NGaLNIA6QJLmh2nmr739uCmC6BH7EwpHj6IF21jj9ffxXgXukQ4AZK
	wj0/S72fCMmL3VJdw+HES5asdbwmNOcuyK3y35IhwlnNcGZEppmx8plyjxMU7jbDxDOhtNChOsQ
	mMPocIgQhJ0SC5HP0F7s2Ar6ypTQodnM4WK4A1UHoAyWNCyJVS+fSTZgeK5et3f39rRWI8Hf40o
	NW506RLxmnwL71w8ZWd3GaO44oFCJ1ptkfZENeA==
X-Received: by 2002:a05:690c:c117:b0:8b1:2b32:de70 with SMTP id
 00721157ae682-8b166c533d8mr81246197b3.35.1793118114590; Tue, 27 Oct 2026
 09:21:54 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027030803.118131-1-lgs201920130244@gmail.com> <9ef05c62-1067-459f-8dab-2b0fbe70178d@kernel.org>
In-Reply-To: <9ef05c62-1067-459f-8dab-2b0fbe70178d@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:21:43 +0800
X-Gm-Features: AclHuK-kZHn8BsJVCqzCiIghWeJdjN-Oh5rQ_CDaqaySgmTmND5PB2X4wIrP1mU
Message-ID: <CANUHTR82mj-Pj0QzKbrn+nkFWRGQVxBxoinmN6fZETRAPOHPqQ@mail.gmail.com>
Subject: Re: [PATCH] mfd: da9150: fix IRQ action memory leak on removal
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Support Opensource <support.opensource@diasemi.com>, Lee Jones <lee@kernel.org>, 
	Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, mfd@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 27 Oct 2026 at 23:26, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 27/10/2026 04:08, Guangshuo Li wrote:
> > da9150_remove() currently removes the regmap IRQ chip before removing
> > the MFD child devices. regmap_del_irq_chip() disposes the child IRQ
> > mappings and removes their IRQ descriptors.
> >
> > The GPADC child registers an interrupt handler using
> > devm_request_threaded_irq(). When the child device is subsequently
> > removed, its device-managed cleanup calls free_irq(), which can no
> > longer find the corresponding IRQ descriptor. As a result, the
> > allocated struct irqaction is not freed, causing a memory leak.
> > The associated IRQ thread also cannot be stopped normally.
> >
> > Remove the MFD child devices first so their interrupt handlers are
> > released while the IRQ mappings are still valid. Then remove the
> > regmap IRQ chip and its IRQ domain.
> >
> > This issue was found by our static analysis tool under development.
>
> So you just keep ignoring and ignoring our feedback. It's just bot, so
> little point to discuss with bot.
>
> Best regards,
> Krzysztof

Thank you for your feedback, and I apologize if our recent submissions
gave the impression that we were ignoring your previous comments.

We did take your earlier suggestions into account and subsequently
submitted a patch series accordingly.

For the more recent patches, however, since they address issues in
different drivers, we thought it would be more appropriate to submit
them separately rather than group them into a single series.

We certainly did not intend to disregard your feedback. We appreciate
your time and guidance, and we will be more careful with our future
submissions.

Thank you for your understanding.

Best regards,
Guangshuo Li
