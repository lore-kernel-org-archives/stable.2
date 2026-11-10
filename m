Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299269;
	b=wirrCZFq5lqITWE4A0fpW5fsvh5Mx9FjLtJ2caQKJEm9pIuL2WtSZXohFBJZ164O21EJ
	 Nur6iRzXMF2bL3Ao9zWvlhci+HHfR9AYqOD/wLYsXGpdri1JdcepS8PJj41F4kNHwmVF6
	 NbDv4faKzoVZUMx9aZa0dawdUQFCza8GAECj2A6z1mC7IiPUutxiHKpQMEx/9MtAXBLa6
	 aIiFnEcPWjuZgIrmvqZulgNE07km75lNAbM9AB2EKOtktpnYu+bVljmwndqEwUK55x0MG
	 2ss6SuOgnDkoL1OV0SZe4wVsqaM4oDZmv/AkMq9S7+CKBRzq5EFwBDcZCfzmB2RoB5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XJd1FBKDVsSxZhIE6xre9cpQW3ehpWs32eSf98wT1Go=;
	b=eYy9YgO3GdAeSA6D+bT/bsph3LcZ3VhCoZW/9et6bTT87Tew2ncGHmX7K9vidU5A/nmE
	 SW955vq9Pehq5ISD0GPBZAgFswryFuuxWmK6auIWfpjU2RZf0A8fwrfnEBdmwt6MFCmUb
	 Ruv2Umg6wnaMpvLHdmai8oodkfE1yyuG1xnlyzG+UCsn6dNygAfAhyNmW04KzypjQJaB2
	 Q/GxWx/+qLi7Y2vMyBFkpKr+JQiOS3CrdePpMpAWgwXDrZDAUpJTkQfXz0SrWuKm1S9xu
	 aXD15Wm6DagnpphyJ7w4xlrQl+na2gnZkRoJfQAjyCdooYpSenbkDjXTe6pSj6HlItA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HtwkkRY2;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF5B606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 08:27:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DF5B606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HtwkkRY2
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a599e9110eso4701205e9.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 00:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794299267; x=1794904067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XJd1FBKDVsSxZhIE6xre9cpQW3ehpWs32eSf98wT1Go=;
        b=HtwkkRY2V+MO/y9G/rQZ0bDToA0n2FHZOXpaSG2p5JIUfMofrCjGSaafZNrL7Fm6CF
         XTTcmHzdpna2PPqAWOErN0L6gAUhG+Yu1Hk41XfVRyKGE55BVflX4kw1Esq8GYeeoixE
         lUFxY85TIRpWnNXVwzTsP8dznH4yJcDqYhhJGRWF4Ju5Kzel+goJE5z8nnJ7MVQtHIGo
         V3Y4gF75aPCyo94XA3i92ZR/EnmpQO3B7p1WXqJSgZ3DOx34vQQ15Pe/Y2mAGhrrkUCb
         vg050K3YyZGoDtL+3exSBXMZZAtNe+HrnRDXmB268Jcs2ktcGupbcBVDZ99h0YJpuLMQ
         pHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794299267; x=1794904067;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XJd1FBKDVsSxZhIE6xre9cpQW3ehpWs32eSf98wT1Go=;
        b=mThVBWXFWgeJD+1rJBX1GBDXZhL9MOb/0O2UQvi4n/ZxCAdJxwyvaweYLDnlV8GjoK
         xFwm6demV+X5VXIt8UAqkLoAKn9JJ74m+fmJT+hld0D1fxuDHFA0PmuRq2Yl2GSoLXJG
         ThOb4Wf2Ckr27LIRVKShHYplQv0RPuGNeYIdJ7CrP+2y8BR8WLpqDjz337jPTqW0GYbU
         5PJZwH8QZ0+QwMc0offP4W/5vZGCUky7mtwBpbKsYAzyBBLhpONcZ5djpnQr9zZ+JYKG
         cpCvKYU5XC8KoF6ib7/g5yKhBYjUR/Ye69sYzD1tQnZ1leV+l/3PTL1MUNdVkqjekn28
         H1tQ==
X-Forwarded-Encrypted: i=1; AL+hErHS2VLvilB3W8mGRneDNUVzFhg4ovka/PYhLeHVYxl1aMclR6vItMm747lyoq8H2T8zwBtLXXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/aHwr0guWmJpJxq0BtLjAupcUNC9mTWnOgJJFvbuuQREUTZO3s
	eGJVFJ6NYjKAWt1SerrYFKG+hCZZQYHA1P50EVq+i7M5H70K1pJXT2Qi
X-Gm-Gg: AYBFou03i6q59qHeEPKp6wEIf9TzIdG7EyqMQAM8ARCjQyq/XOoZmJE07JTWxSh6/iW
	/k3cmkSo3G5cmWdp9PDrvrlm5d4JRBsaFw5TXfJCYMbycAwhIxFfu4Y0p3hoAMdBhCgIhWxCSzY
	GXTjFlYoZmvnJ2YqRPHhaU5wVxTBivQcM/+cSmR3L/NmwJIxM8bl5yULcS4CcveGXJoJSN+B+fA
	jgG1vZNEUTvaQvCHtgZIjqcI46w1K14V54XoyvVfyNJyZrJ0VXAd7LU2RsTQeEY6RCBPSVsYyVe
	D3uLE0RMVeneK9Sz1vqK6C+MyMIwnk9TBqFRnLb8KULgEJAw9WOwVSOI6MTF8rODDzAUk1zh9/F
	zDR3d+u7mjh5Ui/E+cg/iNA8OBj+jptC2HaKOyj5zNrn0o2InS+6CU0YaNJKQFXn1JVFrxVJENd
	HiisOcb+H9zOVuj2IdkLEdCzgNitW6GRy+ZyuASlBGyDcDZ/d5xCdCXyJFJJzI7cvnQiXxWDs/X
	+ygn66qm9ZlGoi703aMNJc9Nm74HJAQh5bKVO1YdEIlmenIO4cc9Hj3JUE4U2rWr1CzKHzuUMwj
	YsKVdzf7x3ReknMzg/u729XyJbfz6Ap2QkLRBdCwt6YEHYtIsg==
X-Received: by 2002:a05:600c:13ca:b0:4a1:e015:6441 with SMTP id 5b1f17b1804b1-4ba022c9d83mr18304505e9.0.1794299267228;
        Tue, 10 Nov 2026 00:27:47 -0800 (PST)
Received: from L-P-ITAIH2-L-RF.rf.local ([193.169.70.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4983585923bsm3885849f8f.11.2026.11.10.00.27.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 00:27:46 -0800 (PST)
From: Itai Handler <itai.handler@gmail.com>
To: mwalle@kernel.org,
	pratyush@kernel.org
Cc: miquel.raynal@bootlin.com,
	richard@nod.at,
	vigneshr@ti.com,
	takahiro.kuwano@infineon.com,
	tudor.ambarus@linaro.org,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v5] mtd: spi-nor: take the flash lock around spi_nor_restore()
Date: Tue, 10 Nov 2026 10:27:07 +0200
Message-Id: <20261110082707.556862-1-itai.handler@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261029210153.3986211-1-itai.handler@gmail.com>
References: <20261029210153.3986211-1-itai.handler@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Michael, Pratyush,

Gentle ping on this fix. It still applies cleanly on top of v7.4-rc2
and spi-nor/next.

Could you please take a look when you have a moment? I'm happy to
rework it if anything needs changing.

Thanks,
Itai
