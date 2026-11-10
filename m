Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794314283;
	b=dSPm7LiAeklrzPWCn1FUKSKJJXYIH4RZXpPFS8POV1AC/aZbRGNUVCaIlcDhP5/O3KEy
	 lLS3B93AszsYOFR0LlUXTmnjmZFKgwJvEiZML4CBT6zRzmKptqOeBRNOBsLazmMqwFEta
	 9GFYIGGVwmTtwoPqeI3JmDOCVieXWVTby8m6RLLm4UWYvlQJE557Hg4JFdO5nw+Bfwlg3
	 TrveaFjKRRy6v5wSEDu27AyboLHFgyh+ASwhWQcMq4emgKJICMas2YPQmMUgA9hqSWKcb
	 KzBGtasQyg1+aQqhgdACnq6ZWn+q023tGNXkP+Zt7+2StrpROzBld963xQ/IcUw7HNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794314283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=LIqybWUTQzegIEfoVn3a6+qxGy8XVtvbVV2ymuSqRgc=;
	b=F4D9zyOgk8jv9be2MQFNusDFrWZ5hv8XdEkzGkf82fa1RsX/5Dk86POWchKcnh/SLWAi
	 UouqujPeReyECBu2AhHJlZg8+UnUfAMPxB4Xhrw/Xkb8D87sf89rQk+IPmCxW9TNHg+T0
	 agok3WET9wAANbt3F9Kgwt5gzFHdYQA61XOuJZFsMElmcRM/RdNDeFq0w3BdHLjCe6Z6c
	 4hCjsMiQ5uhcSUYML6YrkUD32pHjKUEGQqQqaObB/V5QYJtZY+7SHbeqwUNYMnC2wgXSI
	 VGgjRf2XXE7WO9Ive3qwg7ny8mqRZ2axIWZivuMMnHTfgSHb2z3x0m08GNGs9/nQ1ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=metarealtyinc.ca;
	spf=pass smtp.mailfrom=metarealtyinc.ca;
	dkim=pass header.d=metarealtyinc.ca header.i=@metarealtyinc.ca header.a=rsa-sha256 header.s=google header.b=RhEL56TW;
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC04606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC04606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metarealtyinc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metarealtyinc.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metarealtyinc.ca header.i=@metarealtyinc.ca header.a=rsa-sha256 header.s=google header.b=RhEL56TW
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-77bf892b496so742367137.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metarealtyinc.ca; s=google; t=1794314281; x=1794919081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIqybWUTQzegIEfoVn3a6+qxGy8XVtvbVV2ymuSqRgc=;
        b=RhEL56TWvZBXkEIEDYfBQgetrfcsntdz9+ZDPeqE/R5D/l7VBDa8SbFKKD2SNgQ5x2
         394OOvhKe/y5ClVwdIb1P4XsznMFbB/0VIcXtvPWj3i/xjUH7A5QtEYipC/c620fZvgk
         4JFfpKE9lEufOGNsrIlYIhFHM69Y7biG82vOKYUkDXXUjChSkhEOiMsOERFtWzMKL0hS
         0RQCfKzdyQEnlpDUHx3JgZ0MYIbzEEAt2LOE6yYkTIx8rY16niz2/wKaxfIpnlKS28Ph
         xsjRZpmFpfaEY9B1gLvG3yAEWKjNJT64BKCf6xZuj8lsdPg+4htkegzdxmLfg5px8Q//
         xCQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794314281; x=1794919081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIqybWUTQzegIEfoVn3a6+qxGy8XVtvbVV2ymuSqRgc=;
        b=zvAT4NMzNI/T289glWwwu3bA6H+TsuVYMOU7bT0RrxMpMwZBV3qATt5AYXsAMBWPcP
         r8l/NRkuvlDDv5fGCoR6x9Ukjkl+K8rH0npRD74w/p0OBu1m36NQp+CyZ/Y5BEHMTDTU
         eLIOkaf0takZSoV/eF61kbFwDXLxsyxWw70GUrwVtdkKCiet9Lwaw4h98if++EC6nX1X
         r6bwqfp4L9Zoz+Q/hM+nI5lB478W1sqIngB1o7PWWtvXb54iLgUij+YtAA6AHbfjBuLS
         uRNe0Yl785Myn0m6fsqenszwQaD8IQcczIqJ75VaBQODo9AwBf72+1kn2dtdICYKiIJf
         4Z0w==
X-Forwarded-Encrypted: i=1; AL+hErG6WGYYEchoURkvXjrPR/eLrm80dTnGq20/4vTldiS7LNyDISs88WgfefINtOVnGMZS32Pi86I=@vger.kernel.org
X-Gm-Message-State: APuU4Z8yr2/Jx8k46x6YCWHhSmQkrM386ZH/0sGEmMDYkSUdfUPqek34
	iHdVhfQnIYwUB5n7cq19jfuq2dzM8q5MExouywq8LbJ+BdzYs4LdP35wpzmD+Wgj7aI=
X-Gm-Gg: AYBFou3ccP8unHjod0cOBIbhHknyZgRHaXPNTZL40eAo0nfVceV1wmQRhbxLKtj9JuW
	HPQTyf+b3p6bUnLWtQPCjH7bnrBebhZfSfHCCOy1Pp97o0ksV/dYkE+7VQ7D1JP5IgIavEgVzks
	OTnwlOy16doqKEtxlUsWaayn6YwGTiVApd0mVAExpfRmq6s+dotJLEheydVf9RRmWsnA81AKwi3
	Mtu4Z2RMUcE7qzt/z3VHpYJaq4vwMvyajGCzAgDqIA/iDhcWOSQNwwd1aUVWUe/zUvtrW/nt83u
	wXkHIbbo3Dhoqy67SPtqFVKxdhnTbwXcQB0n+bvkkjlzNccNOpvCxIKA5adFGEelGXVoQg20Ewq
	kyjHAra84vfW1mpRDpXvg5IL0iHYZzSWxtsw31P3/xgMINaGB7rpFhxU997QlojfVz/3vDQ0qc2
	HCoxdTV1o16SUnbwVI/RirHb429ZOJ9CD6o0RA/ULvn0RkQNlItpSOMwkGDsGfGWggxRt+pXo62
	pjXB/GJeSpIGjA7tpM/HWXIDuUU8ZARCc5AFMMUXWNx6u0tVLi/cKZrU/FjdssHhrurUpHaFdxI
	Ibc5t/7G3njc/SawXHgx8Yff/Ok0C9nefawkV2E17mRDZkVkdE1aSLvXXqbBGUtNyhWyjtlzPT/
	yVY4Xx3Pb/2LmJRYKQPmsA3Mh/qesTbQOpAL+Rv9VU8jPqj5eOEuVmGNFXdPjiHWah5yJCpoWx+
	CPwEIPXD1DfMjcECxCFXrmbeiiO4zoKGPQekeyRl4LCrBmO2r3r33UtbSBri9FkkFC
X-Received: by 2002:a05:6102:94c:b0:7c3:9b8d:5124 with SMTP id ada2fe7eead31-7d301ba5407mr716189137.18.1794314280680;
        Tue, 10 Nov 2026 04:38:00 -0800 (PST)
Received: from jake-laptop ([2607:fea8:c6:a700::879a])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d30209ff97sm1658194137.0.2026.11.10.04.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 04:37:59 -0800 (PST)
From: Jake Steinman <j@metarealtyinc.ca>
To: arpith99@gmail.com
Cc: sakari.ailus@linux.intel.com,
	gvozdoder@gmail.com,
	lixu.zhang@intel.com,
	mchehab@kernel.org,
	antti.laakso@linux.intel.com,
	mehdi.djait@linux.intel.com,
	dan.scally@ideasonboard.com,
	hansg@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	regressions@lists.linux.dev
Subject: Re: [PATCH] media: ivsc: csi: Add sensor node in bound callback
Date: Tue, 10 Nov 2026 07:37:57 -0500
Message-ID: <20261110123757.730188-1-j@metarealtyinc.ca>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103200226.100989-1-arpith99@gmail.com>
References: <20261103200226.100989-1-arpith99@gmail.com>
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

(Resending, my first copy had a broken Cc list.)

Sorry about this, the HM1092 ipu-bridge entry went in ahead of the
driver. The change matches the CVS fix and looks right to me.

Reviewed-by: Jake Steinman <j@metarealtyinc.ca>

Sergey's VCM point probably still holds: a VCM instantiated by
ipu-bridge only gets its node from .complete(). Sakari, if you'd rather
not rely on per-bridge fixes until the hm1092 driver lands, I'm fine
with reverting 4fdb0342f05e.

Jake
