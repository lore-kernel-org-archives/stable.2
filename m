Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.128.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793118196;
	b=ds/ojA2EiTlS2++jA9rNvia9ivV7vpqKabQ+B1MGmMNKn02tEJJ/nV/diCabRlutdzpO
	 1ovV/UiTqIKAmv7r1W0laZ5Fv7m3LFLZ+LlkTNVN1CN3Ca6kCDpyUp3dTLzPxHxxlUhXQ
	 uYPMjXPTHmrpYVi4hDZQIKJG52sUJmJ32N7K5dMR9jUOGD9+LdF+UDyv/3jOSq3Yo0Syw
	 w+IFuyCYTI2ooNZ1Nabiva7QoabBJFIAA/N8x/RE743mzsUxYSD5n9uH5HOqw3XyG9Wtk
	 mYwO3NgbNpPjaww+vQXnEy01k1Uu7bA54Uo7fvvAuwqPUn2SPvxFU027sr+y7c2Xzbw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=QqIpGBAK2KuXj5Mm6dgtYCSC1cgHN+QuSvgapi/y7rc=;
	b=jWXafCGd4s0FSXcjjtaKNJ2tFYdEi7jMSR3mF+ASLxAZmyI3flij49pvJAgK3T04exMi
	 oJ8O9UD1j1vmnmt5h/X3kZksEQwiezWVLdqz701lL7jXpyg5oQdLVyp4p4kPqxdQtZ5AK
	 UIZr8MmSGyq4h2XnBdkTQkPMtHUVY5QE5WvgcRMrXPItLRD4blYMmK9p/x+UuWVaWyoIh
	 QDCaIWRajQPMSC8SKcOpySOGUlbd90YxcWRsNgiUj6gGAA9PRkuuAYk3G+kiVqGWci+/x
	 M6P5c+Tlmgq/2DLtuXs4kbWyplsZYf99tiblpXCF62+Dfhk9/7ZuFC22UVoTbjRxrAQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMLfp17Q;
	arc=fail smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BE7606A31A
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:23:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51BE7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XMLfp17Q
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8b0a921ee46so36552147b3.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:23:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793118195; cv=none;
        d=google.com; s=arc-20260327;
        b=r20MIQ9S3q87R5YqfhoUaELEAwbXiVxBdTSnGB44qkggFRrP/qCzjrtXqz75d4kP4s
         wAkYEKGNrxRYcEzDySdrYGCG589IG7aOp6B70SDMByQJ+GyeOcjyh6058a0dHfdzc8p2
         xBojFs6pqxAPxbBfrNh35vaWLW2nvqJdHYglWp6xVLHtiInRAVSbc8eZk70OtP+H3AVr
         kvBJsIjX+xBtj6zBQ4MkYnmO9457ib9legLVcaJAZ47I/hUQOjlyYg8fUcg4Yqc0C5CJ
         ppTMON5Kosl+0IX3y5g+ZZDU9Sq3/xzUa75tyb04qfEdFvs3V+e1AmYHUGp6gS4Akl5I
         gH+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QqIpGBAK2KuXj5Mm6dgtYCSC1cgHN+QuSvgapi/y7rc=;
        fh=vL/LzEseeUebOzMncPsa0xjXRzonzeIRs9CBZ9/kztI=;
        b=Dfbgbl6UPYw89t1vySC4ZRBIlX+5jholLfx5zLvWE4RI1vF+qMHynkUhoBIyhGz8jX
         g0EncOqQEuOABRPs0C92YIqtpO6Zpo/GE11/5DJY3hFL2tGm3f7g7HP8ow4mzR4EyjnU
         /hAlugOs1hDU/CCv0zZyt53pDvmwNO2zhd2h2FEguiE/u51g+uvggNx0BNV7Fb87vUm0
         yxeq1pDu6FYNgQ5Xo8vkrOEFRtQY4WWmmyYW1bc7QlPDYLTqdL8fPnaSk5EwZZz2jpGI
         9j/ucz3FZ/5ssrYaX64Dx2GHQfYTFI/tc1JWSfx+1c27TQa5hDm3XMZNRqs/r8SVurRA
         rLcA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793118195; x=1793722995; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QqIpGBAK2KuXj5Mm6dgtYCSC1cgHN+QuSvgapi/y7rc=;
        b=XMLfp17QWzpGE0tU5jJjiCFTB4/tY1R1uZXh/9tzKH+JZ1EpWJ2QbLXtbTP5cwypu+
         tjIq070JZMhQ919gl5zS3WzV7nfdO1KPWvuJshIa/S+dz2u21UtLNvpH1XhMuz+LdWb2
         ciFjQL4BVuyLd4nuJUjwOOSi0oDx+zOAqBAQaG1KQEYjkJVEtK6Hfc8abC/KkMp948cS
         i9hjseDoOIgABmGaDlV6goSmNfAAg8F+ZnolgHqGCyV3+Lzk8LVH2X3H+YCe2m+MwOD+
         JTgWPwbRaO3AtEm0hz0NtgmNtn6WOJvCLcztaHXonJiERv1QwlhudS2pPCeDvSQY3rIO
         vJzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793118195; x=1793722995;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=QqIpGBAK2KuXj5Mm6dgtYCSC1cgHN+QuSvgapi/y7rc=;
        b=sZPUcCbK/VW973PbY1dO6wB7Tt4Or0aUxwhjrWx2SH35RPTrkfczPWdVN99vqtVd4F
         MMeJFDIHZRr77gLgP7wDEhlJ2ycZxfIqrQIDloY4FQZWV9sp9RpkcHrBXMgMOXnHvn5l
         EeYXXHlnvdkdDztjncYJ3lPb6+cWJS7QDGYCBsYna7NbteO8inhAY09scQfUCxlP66zA
         PZu/q6547qudC1Kzi/WXOikF51TTt5HpVfd8j4NWTLKXAP+FvjlHfoTFRQ9jqhhtjUuz
         kiUS/4N8Q4gFCKZ05l2/MVIjZU4SFyEGaoUFwpcHowx4y2gei1NwtfOY/S1Xhmkje5X0
         C36w==
X-Forwarded-Encrypted: i=1; AKwUvBzhboq+JK0BHBzmm7/6bH+/w5VAJCFkVwR/dX+3J8uwGFm40sJ3pY5Br2LxwomKMg/x+DnwV2k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJoFLTgfky0Tx5fRarHLUMio5lez40RRgLpCVuyvuwcJOg06bmW
	JgVXdN6yipaTvHJkKQQs6vkFpAgEKKMTHctBgozFhp8NIDfTqmDXCK4hXopxI/7nxFuOHTArw2A
	OSozgolcKkFpvClejDT31G0rqvMe6dP8=
X-Gm-Gg: AYBFou1njzwVWGN27+kHpPjMrS9rwr4OPfMWXBJtJoIvWN3JU+xvj8o/YunPq7jxdDn
	FK+R234nLIAthJdc7+/Mxdag10EqboX+HGjl8CDI/Apn48ruWlA2pQxcDgc1sXEeq+dtJZ8wwth
	ousQXxHbAekj+ZoF+7JQVwlss0KKyIQHXalCc5W1puY/HPN0N/pfZLKucvvhmPYYTnx1/qi8crQ
	4haol7XEOhp/+GVmOrlv5BWS10cJ/Ic40OTHmDN9NXCi7JtFVb7clEypK/oetROnuV4J/fDNfR7
	Os0/pGq6yG57l7YykPReEAqMxkdGLqBjUpfEAYeMSpf64lNOouECyL9UMN2NkqF9Mp6gw31GVgH
	K25sN4p2ga7Xacq4Nu2ZydXZakoBKlA2tl2Oo
X-Received: by 2002:a05:690c:ec8:b0:8a9:977a:4149 with SMTP id
 00721157ae682-8b166c208dfmr65074317b3.72.1793118195377; Tue, 27 Oct 2026
 09:23:15 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026111103.4158855-1-lgs201920130244@gmail.com> <908cb70d-bfe8-4d01-b64e-44ffcfe259bd@kernel.org>
In-Reply-To: <908cb70d-bfe8-4d01-b64e-44ffcfe259bd@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 28 Oct 2026 00:23:05 +0800
X-Gm-Features: AclHuK-tuXfD3-wCV2DoM9fPtRqDwLKmCfP8tZLuO8Qr1rY1uRTJcYQ15eNQu_Q
Message-ID: <CANUHTR9XrH5gKF=bN0s7Z2xP=5OzPEU8D8_Xwv4F+3rp2cUS-A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: acer-wmi: fix UAF after accelerometer
 registration failure
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Lee, Chun-Yi" <jlee@suse.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Matthew Garrett <mjg@redhat.com>, Marek Vasut <marex@denx.de>, platform-driver-x86@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 27 Oct 2026 at 23:33, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 26/10/2026 12:11, Guangshuo Li wrote:
> > When input_register_device() fails in acer_wmi_accel_setup(), the error
> > path frees acer_wmi_accel_dev but leaves the global pointer non-NULL.
> >
> > Since acer_wmi_init() ignores the accelerometer setup failure and
> > continues initialization, a later driver removal or initialization
> > failure can call input_unregister_device() on the dangling pointer,
> > resulting in a use-after-free.
> >
> > Set acer_wmi_accel_dev to NULL after freeing it so that the cleanup
> > paths do not attempt to unregister the already-freed input device.
> >
> > This issue was found by our static analysis tool under development.
> >
> > Fixes: 1eb3fe1d3b6b ("ACER: Add support for accelerometer sensor")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
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
