Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051603B6C15
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731361; cv=pass; b=gpVxjKcv/CLrGx3lthYTpImNmOq6rkTnPxRv4Zg7AviCfCb1T9KN1FHadXMQ2ghqu14+twyIbK36cOsBnFRcQ62h3O3kt806Yk4daodDs/k2hxHQltryLPmP+SXNRJUYH0fk/i+TQZRHCyPQMcdZ+i5gYgCj73P3FeYdsIEGE0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731361; c=relaxed/simple;
	bh=HNb54WhmzGWfVXwTVFcpIHzscspSYwASA3WPZN7wCaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IsGz0bl0pkWLowpUz7+bkcOl3EEx+8NtUDV22/01C5LYSvXP0RizJYBL8is6ovo3oFXd4DuhBEZIjyN42rlg2jswpxVJk+9fbKPstSs4CfSh+q+5zevLOH4cYDOwQIcnHP9Pxxf5RnN0iGBOfRHWxUfVi4d6lbTSGJS78cyuiGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeAsBtAy; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeAsBtAy"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66c7e3a2332so572116d50.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:02:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731359; cv=none;
        d=google.com; s=arc-20260327;
        b=smITdGmpufbY2OiEl+po0MyDe/taWie6ABjfxz6jTxNDl2cSKoBUlSJ/Hgzt/eC37I
         Cz99dFy8gMfdE55rDZCmMINq8nc5PU0Q5ZRJLV9tQTRKj249akrb2RQnIJdjPSkbCRFC
         BKb7xAIvybf/184JRI20wt+rLUy+eAdPurr/uj4lURYRqeYPkTgTytzS1I2znlshXwR0
         Pcy/JwtC9rvzjhYK+7oyRpPpVkVOSKISYXi4xN2sgmb/lWAFl6ucrFOXWTo8fngv+GE1
         TBjLbQtjWYMI9cEoMduC2Jutxci1P5jK3KdT28sSPRlMHSsxlmuwapo/QHg3x8M5GWiF
         Px5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=HNb54WhmzGWfVXwTVFcpIHzscspSYwASA3WPZN7wCaE=;
        fh=7yXYPZuARNOmI8cQ1LjbpGYLsgee6OqvtLsa72VeFeg=;
        b=mGbmq3cKse1rodMmjonJZddXs5K7Zd4LAWEuPM+qsJ9T4njOX+SoPDMe9e+7tb4i3p
         /TSicEbT/8137jqG/Z6ClCJIq9m3QSHvlevVkdDxyc3qBWnmgRCNduPetI8lWRYkeKEw
         jRECCj418mVsltL8XeG2lfEiyIO/UgcdLO1tO42jAF0ciJb9o90tqxlhaNh+lwFVtT2A
         0sashuH0vtF5uY29O1LN58g/xztEXO8VJbGCC30tlBAdeMXanka4ENhpivaAxtN2dCM9
         JNIcWeacuk9XogH1BlE8pi4Z5wshHpm4d30FQj+Kh6SGa6GtAQKCItejKi0lepNcnTWw
         MzkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731359; x=1788336159; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNb54WhmzGWfVXwTVFcpIHzscspSYwASA3WPZN7wCaE=;
        b=BeAsBtAyyyOYMKhxdAaPX78/e+c9eat2Wt2963pTLWIYhAeAtk9Z34RKZacIYvMP7S
         k0cFbzvMchtY7WlvDrRxl8PiOaNIsxnIX2w940kO9G1A2zCNj3EmXZI5sHlZ8nOeunsr
         uyyLlTJM9Ur/+f8mrI/eyjIHgYhvdWX4MU+Dmeb1q0yUIrueO5RUmiMyoZbZtEQ9FOZY
         9t9RNZPFhtZacur2pL/ZBrhge019Romind+3033oM5Fk3Ed+mB6mniSM743IKSLkxtWO
         1iuSjAp2TNtmi0tGxgHVh+weIMC+SoX5KuOjF9aZCyTUYraFkLIf0XZOdTCvAgMMipmu
         Kk/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731359; x=1788336159;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HNb54WhmzGWfVXwTVFcpIHzscspSYwASA3WPZN7wCaE=;
        b=nAv5eh2cqcQQwSu3ALNy+0mp2xKkwhHbZBpYLMrfeX+MYSxqwo3yOh5Xd4MWrkbDfD
         sR2dXH+QRbmrl/Qt/TGvZtv1Y7NfteE2Avq88IS45VMrwHfCJp0uT1FmFurV7dK1Zqzm
         HbLnEFfckqtwvb8U8KD7gttJksYt0rcv7AJOeTlEohGGmKeenfL4pGXeldsvX1f47oQF
         50sNV9ETysT9fKVG7Y0viP+Ep2upHhSj0opq54GcoxKoYOkmlOiYLYK9+BXAE81z9XTp
         6Jc5w2xENxtzpy9HHBLoA4a4K6+asFrNT6Aj5IvNIAAuEfoqIBJzyw6GVEBXhBNzgVDj
         cgEQ==
X-Forwarded-Encrypted: i=1; AHgh+RrEK/81QvZmNWfSF8pu8Onf9FjdnozvlaFhGSBQRJWjYT163j/vz7vz7nDuGsyHvAH/6pQdsig=@vger.kernel.org
X-Gm-Message-State: AFuF++mPV9MPNireYUFAhT/IRxs3Z5tPv+UCdufLXSNqkRzjR6pIOSzo
	VZ971sJMPlI2T0p0lh9YSEXUtkrbbp8flC7Z5QNxK8gllYuUVaEcD/o+HLY+6fUCPQ6LxhpybxV
	qmGvTSar3eOELnqBrhad03MMOAlldxel2IvZ74TII1w==
X-Gm-Gg: AR+sD11DfZ2b47Lz3lgVSHWTJOXgRCxWHH8v5uwf0B+N7gfmyEKk/ChyQS1JcXiqXcI
	Hd5UjAH4BjDUgDnQalXxs3bUD+uVdpqHtR0MA79gHDwIa438bZjGVktlQ/+LBb/wbmVTRBXq4Pb
	Syf6O6WBvYNkycuOJLQya+NbdibKEoCg3bH6zNySthp/0d+VVLL/LEvfrDjmS/eWv2TP5L+hWWI
	379S17mjyzYVksHYZj/EYYB9LIoHBk+Rdv2XeBTpte6DZBevkkUsYVNHsOjkHqrLu7I6oLiWgYC
	DhVjMwZCO2hHhKC14tSKxE87Ng8yi0TaQiqLy8qx3Xh956cC
X-Received: by 2002:a53:ec85:0:b0:66c:484c:867f with SMTP id
 956f58d0204a3-66d257d6fb4mr912561d50.45.1787731358946; Wed, 26 Aug 2026
 01:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808091734.2727295-1-lgs201920130244@gmail.com> <2d997800-b7b5-4700-919c-c4b6e5e926aa@kernel.org>
In-Reply-To: <2d997800-b7b5-4700-919c-c4b6e5e926aa@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:02:25 +0800
X-Gm-Features: AcwNN1WB7uMO3ABJ0oP8Rynn4S9aYtnBveYSbDNyJacRweQS6TxxzJZhtRXy8y4
Message-ID: <CANUHTR89nZ=GQGte0iE2Fa=VeiiEAXZhLu5S+osfXg0OORcNZw@mail.gmail.com>
Subject: Re: [PATCH] crypto: ccree: fix autosuspend cleanup during teardown
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Gilad Ben-Yossef <gilad@benyossef.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Thu, 20 Aug 2026 at 22:03, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 08/08/2026 11:17, Guangshuo Li wrote:
> > init_cc_resources() calls pm_runtime_use_autosuspend(), but neither
> > the probe failure path nor cleanup_cc_resources() calls the matching
> > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> >
> > If the autosuspend delay is set to a negative value while autosuspend
> > is enabled, the runtime PM core increments usage_count to prevent
> > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > during teardown, this reference is not dropped and usage_count remains
> > unbalanced.
> >
> > Add the missing pm_runtime_dont_use_autosuspend() calls to both the
> > probe failure and device cleanup paths before disabling runtime PM.
> >
> > This issue was found by manual code inspection.
> >
> > Fixes: 4c3f97276e15 ("crypto: ccree - introduce CryptoCell driver")
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
