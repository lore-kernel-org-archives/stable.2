Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9219D3FB05A
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789153557; cv=none; b=Vxg+S7BFSixktPOgTG6nSbIMbXY+mqowOjReq8mfWD9VBhir3RziNI/pMlFsCMeOZHmJWBkufqQ/jbS/q08MtUMQAJEf1/yek/RAF7LXR4RbthA6cHBMrTduAwDsSUxS0MdPE3freSqTzCrGOuEhM+YB3mXv7QeZjls4QOHcScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789153557; c=relaxed/simple;
	bh=l/CirUCwr/L+iTdoKApinwOtHjdHet/I16U4QpNhjhY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=attERk2qTNo9U3cKmylbjRkkc4Pxl4R3NZ0uhpI89eUO3j2hRsRERmH/ATaTu9lkMjG8A3AOfoKrfnxRQrZdzsBCRsgjcvudkNxXUG6XiwdCKIprWBGIOzPJzbEvQaNgMzLksZfqowggEq/dDOnUBmNpfL7Yz+nuEE7j4zpwpvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Un8IMAfB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Un8IMAfB"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49e6ba045ceso862815e9.1
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1789153539; x=1789758339; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cvEgCS4lnVZGuqvTEqApyi1EqjdLQ0vEhWKATFltbNs=;
        b=Un8IMAfBvC0at2gWXjouapc13yY7ToIb4VLUqTouiRfYPEIvoeeFiFEa3MtUFmgKcr
         DYN1G3HQYvaER/lLrhQ1k4Rc++lrHei9doH2hVEQZJjaBwB9S4gMTDByjsdMYZzsB4ks
         xqBewYNbQxI3M+pzm4j+k69gaL8jZ0mjZqOC/DCCBXUqES4/UMma66J/TXqlkkbMf0C+
         1biKXHk/XquS29BJYsYA1ZhagYPZndLLE2wz4LiliLIskJzps0l4AObKN1vD6b9RO5SL
         x6cm8LB9VxyJt1ZIa5dAIkwKSX7QrfK/5Jl3tLGrvDvVeqkLes23X/Mx8lgyMlzdlw2J
         jVIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789153539; x=1789758339;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cvEgCS4lnVZGuqvTEqApyi1EqjdLQ0vEhWKATFltbNs=;
        b=NU1qTWhyhnIUEMCCM6tyt57FkMdHzmxHxjgizCYRCB0TSfEo2srXhE3XShr3CPExim
         EgwnbsUDXQOQqEIkSsfarJ2pk9C8T3FgkSPt2cE8NFi5hjcxW9R5HKrO6CKlGqvY9KLv
         rKTytPcGcEHfoiuQQvLLFj/k2fren/QoVS/0XHqktC2A8MUUXqEHfPX/bQInffHaiWiL
         gH/MX5bG0MffBeBaF2Vw6vbna9PpDXyO6C8A/ny0DUeyC+bi5vT7dnv2whsPW459XD4I
         7thEAwN3o/0H/ZG9g/fds9lWuaTSbPtMaZqYLL7Ifs0nUvwOAt32rHvK8fuWa3HGCjaz
         nuYg==
X-Gm-Message-State: AFuF++kSYLRpCyv8anHBnIsZYat8CL2cXiYjZxNldeJBcmO6Attu5Swa
	9QhyiQdlV3haTJEg8aNLHrWhsKR04/+iI5FvPPsX+zQOXw5FBDvwO5Wu4kk2EILI/crgWc6Cm7Y
	3t4IK0cs=
X-Gm-Gg: AYBFou22lyqJdU0hS401X2X/x04D6mmAhX+OSrFaE+LcgQhi+hZ4AVliLakoKFcdGCO
	XyYDj7EOacEeZXTI5eq8EwK/SlmamYg7/pBTD4XhOmvzGjAPNUiH0l2wUCvgQikhl5581d7n5Ld
	XkMTDZLV+k0d375AzAWajr2mZQfTAM5zOJMBXd6CYmV6pVOMORKuT5iASD01PQreihkSEg+d+7m
	oWgeATtJDKcZInqpzOa/uyizT3rp9I9NYE1V2KtFwxTP0Ekbg9shVopOA9WbO5IbI65FscX0YZn
	77xwNuxehRS9Gbn22ztG6Hl6J+AtMONTXULPN9jLptwxkwwBzekOm9QdSi9bHswVE+OiWOXmPSX
	QDNQ6CABFDgWT7/Mb3i0Isj21ofah4Pj9ndtHVPEAfuK/U8r2LquZcNoF3suL8kkQTi4E+JrKKc
	ElLcCbfWasNQ77T3rUOjXQRgLk0req9cLU2VRFAcf2yYl3bheLkhDDNfNFoUY4G86uRJbn/edc1
	nd9BdAn/BqCs2/d9g==
X-Received: by 2002:a05:600c:1c10:b0:49c:fc6c:be05 with SMTP id 5b1f17b1804b1-49e619f7187mr77391455e9.28.1789153539618;
        Fri, 11 Sep 2026 12:05:39 -0700 (PDT)
Received: from localhost (82-67-6-57.subs.proxad.net. [82.67.6.57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e35sm170999285e9.2.2026.09.11.12.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:05:37 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 6.12.y] clk: meson: align gxbb_32k_clk_sel number of
 parents with actual count
In-Reply-To: <aqRAbyxpEnKlOXOu@laps>
References: <20260910072139.313775-1-jbrunet@baylibre.com>
 <daily-reply-0030-re-clk-meson-gxbb-6-12@kernel.org>
 <1jik4c6imt.fsf@starbuckisacylon.baylibre.com> <aqRAbyxpEnKlOXOu@laps>
Date: Fri, 11 Sep 2026 21:05:34 +0200
Message-ID: <1jfqzf7gn5.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On ven. 11 sept. 2026 at 13:54, Sasha Levin <sashal@kernel.org> wrote:

> On Fri, Sep 11, 2026 at 03:07:54PM +0200, Jerome Brunet wrote:
>>On ven. 11 sept. 2026 at 07:20, Sasha Levin <sashal@kernel.org> wrote:
>>
>>>> The following out-of-bounds read has been observed by Christian on a
>>>> GXBB WeTek Hub:
>>>
>>> Queued for 6.12, thanks.
>>
>>Hello Sasha,
>>
>>In those instance where exact same backport applies to multiple versions
>>how do you prefer to handle things ?
>>
>>* Just replying 5 times as I did ?
>>* Just reply once with a note explaining that it applies to other version ?
>
> Hey!
>
> Either works - so whatever is easier for you.
>
> Something along the lines of "[PATCH 6.18-6.1]" is what most folks use.

Noted. Thanks a lot

>
> -- 
> Thanks,
> Sasha
>
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Jerome
