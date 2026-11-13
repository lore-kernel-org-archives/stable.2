Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.208.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794601327;
	b=D6QZK88vsuZUodLUQAis67ybIYBxWEWNcWY7AN3cCb5kVMXpZucoXb6VDquaOIC9SMLV
	 2VpG9E8DLzWCPD1VSaCA1dwrfbWm0U+PSQu7xIKD+EwuUYQoOpgdl0U23rayAQQ8fGnDj
	 xrt2QeW+nXIvdaHgjmkQ7pcWGkMHVJ9A0O76Pi9GqaBw457IQAEdUZPPB6E6N/oc38RBm
	 wOBj5IuPOa0xmsmsVddHhIHfCDx/ebNi4lAVhoDgDqR1dFM+DzL9nnHb3vEB901++rIGX
	 01V13pWz9uwPNE+jMYNGVxOtTKawn3lDqq+rDdzlK1GGHUjMscT54MBqUp6+UBpp09w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601327;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=xtumAuvNbWuwUXK0cxJRs7l5/r2sAahJH/6uzW92HAc=;
	b=PN/++RPh3dFs0hu60+dFovz6tRBShWhtyO1oh/DCRZYfpN4ColVxuuWVirA1+gwOGjvf
	 BT8+WhmXhKgdLwINWowLT+dLPeMW4G92oQ3fX8YEv4yEsXxa/yn1m/CTtUOMYTbwOk85B
	 fSp/IL5dnmVzFBn8xnEyL/1rtz2ffa6eEYHSdPwHbATKBBEEBUaEDnufHBiw1xWUirmlm
	 aOcAU+IzEDJoSbEG1LuUhoE5SrpMKmdr+Rrt8G8Nhz1C3coBQPD2UZRGzSSkD7WKmaKzU
	 joi5LDBBHL8wnbq76aOhfjAyqTgNtZFQ9rpZn/VJVk9HUOAXwL+ARP9Lxn6cyxB1IJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="eliaN/OP";
	arc=fail smtp.remote-ip=209.85.208.177
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20BA606A336
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:22:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B20BA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eliaN/OP
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3ae3b5b1027so243011fa.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:22:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794601325; cv=none;
        d=google.com; s=arc-20260327;
        b=ksxOUuXux6+fKfw8307A/zxei80qTsMs0gMAUUqtkNXleadNSbkH+v5vKLg403KQ3r
         l1eUyporQnvodFLNynw1O7t+ronXe2hJpD04iskyLA4Dup9S9R23rdk+93NkfWiFNVvC
         EQXOtOjJhiWzp/M90SVN9XJJca8H1vVQuQ4YR8SVPCla6PVPXmkc+5ZgVEtmtzlDnCqK
         g0TYB6GsoJzd1e3Upgt5Ay0eBMW8VVj1X+Pygcf5eY9CLnjeAZoJdTdGZH2gPn8ONFvb
         DJuQ7zXE+X1ZTJhA3nwO6EP2LI8YK9L4eFS4ijG8nUBJyBfBfom7SeNjKpwpb/OJS5oj
         AFSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=xtumAuvNbWuwUXK0cxJRs7l5/r2sAahJH/6uzW92HAc=;
        fh=WGttablTLi9APGv+p6hSL2LJAIk6fraDwLUl8Y6AEVU=;
        b=kCMpaNaFWFfWUQJgBlczIc4EUFxXyafDwIF3URPBxv4dGMdiXjWM+dzTShO2NYRqK+
         jGedZcsyBYks59jV/LDhUuy/xNak0tcVTCHFxNhhoeJNIRDKHkwEXFRZ4nVANQIfn6Bk
         VGpr59+PS8Jl5K0P8D5pUzhJ9srFD9zvgeKNiIiu77lEGkXckK2+04MpeWzfYEAqqjGI
         s3DHNUlPFPhOtT3C9ZyRirBmGTAxQRY48Hxqlndpgihm1FYes1wfpIxNp5hN8zPRjUYA
         Cdv+W1cwLCLDbBsMpnnsEpUqbCVgS5oBThR+6wf4tdADjDeiGmglO+oM55eSuDTJ6nA2
         pfvg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601325; x=1795206125; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xtumAuvNbWuwUXK0cxJRs7l5/r2sAahJH/6uzW92HAc=;
        b=eliaN/OPLV5MQHHag51KNNYs9r1vwyaqcfJdkPEf/RxGAIxD8jHs7xlRZ8nZvj2xWc
         X+oTBEK8j+nPB2xjkjIpsQ7e0ql3O3uCheaVkZPsuT4Qzr72cKyMRk4ekxeEakNcVIvP
         56DIHjQtA9jeGJWIsKAS3TnLjuqKom/OdQMD7XwpY9FyxmdSx2XmODmyJuy3cb7/Ya6L
         dbVdWc+5/H8udaY3R3ewLTMY8GnySiNfHfJbMNidIhZc02OSafSuUgEkBEX6Cq+i3uzP
         3wacvfEu4+WIm11XYq/xPB2//IpU5VJJCpJTwyik5YREF01ZKwV9uFMwMbtJgb7HtEXK
         padg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601325; x=1795206125;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xtumAuvNbWuwUXK0cxJRs7l5/r2sAahJH/6uzW92HAc=;
        b=WN23YwEkMctFEE1hz1Rm2+vfJI637stxYC1tvOmU7h4MF5hMZsvDAmN5WWyzIqZn8/
         76xVvgFWgvkp+y64naFKTdUWjELHdLvoURRBGoFln3OdLslh3y3e1VhYICg3FRQZuXRT
         7ecTqYSti1Y38adhhXjZNUejA2+we5JElkfchkKdApMrQ4ZZMsf+J0R+4bx0zCq4JF6c
         Pf+c7wkaJ7TdDT5iOwuHsWoBQcwp8oZPHHlCfISR8631MyWp+SGwh9sO/3MnaIiQcJ1p
         3BAQ1wtsqnkHzq+q1tl68tSjpDW+8RT5noHh7av6kiTs7CVpUb7y7Hx87QU7YtJbNSuY
         gpgA==
X-Forwarded-Encrypted: i=1; AL+hErG0HZDIOygJE+R1ab7cVmx8ZIluiWEn3XYDvotQxRTZLwBtMrBwanustD5LeA8OrBlRbCe6fBI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+c4/bLUd+EWB5cNZXkK2SppJWCPe4Q2XtKDM0+8Gm2Iho9yXNp
	oAyJYhYYdc3wM/SnOrrrueLRBXsk/s1ohoawFnALxQBqRmBnYf9K5/wJD07Duhv2oQIWH1qPBKC
	8JamsXfxplxkU3CV3ZVFxaPQ4kRAWWHo=
X-Gm-Gg: AYBFou1pISyNrXZsflt3GiWzja/D97x/6tBN6z0bjK0DX8XHiJdwJrvB4BlNFpBjfiZ
	bU+oFEBw2xtBc9aYvnjk3POheu7qYe8gnhZ3xt+XXmCn+ZdX+w8nuGnG8Uzg1jDnMbHywpJYpMB
	q/r60rVZc+0vTTDydA7rz9NJ6QVGqJv2aaCTU7Rd447pCbC5vbxHJ1PBMwgRb+FVa2+n1pVgtI0
	/N+rbz11HAPMBHK9uw48Q010efGQbNar+6eM196MWAdr8oxWbXngPdFBbrDrhkmykoscOp6dS39
	K2wLvQWx7DbLkqnwY+B1oHOOUPprNB5EePgZA36hz8apEx6B0sqqHon6vX51UvOKssiyrMt6Iaq
	HxzLcWL5lwr1ZFPNmU6ZSS+2UM4ihTpD9so90Il+mtGf6h83+D/0+6bnK026xpVd8Bkv/jqJ5fU
	QbTSqwhoA+KcKwh8th
X-Received: by 2002:a05:6512:1322:b0:5c1:57b9:90b2 with SMTP id
 2adb3069b0e04-5c170746a13mr1720283e87.1.1794601324638; Fri, 13 Nov 2026
 12:22:04 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-hantro-robust-v2-0-18561fd48838@gmail.com>
 <20261112-hantro-robust-v2-2-18561fd48838@gmail.com> <c97eef1ba88daf83d231d2ecc78b47fcf524385c.camel@pengutronix.de>
 <f212840b-92fd-4d97-a6a7-2768a55483f7@collabora.com> <CAEy9hNU2ox76TFKtdisqUHDxZ=3gPVBDBcjz_W8RtCpCpK5d7g@mail.gmail.com>
 <b3fa092ec9390cf5bfe2f4338af68327be70e6e1.camel@pengutronix.de>
In-Reply-To: <b3fa092ec9390cf5bfe2f4338af68327be70e6e1.camel@pengutronix.de>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Fri, 13 Nov 2026 12:21:52 -0800
X-Gm-Features: AclHuK_r_rPrVJRj0pkug0EuQb97pNCsN4qnHk9bddNHOrBile8NMgFa-B299mE
Message-ID: <CAEy9hNXNaAdcL4NMmNf7sETknV+jQBp-inqFd-qAPut041GjJw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] media: verisilicon: Don't hold the VPU in reset
 after remove
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	Nicolas Dufresne <nicolas.dufresne@collabora.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Nicolas Frattaroli <frattaroli.nicolas@gmail.com>, 
	Andrzej Pietrasiewicz <andrzej.p@collabora.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, 
	Hans Verkuil <hverkuil@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Sergei Khomenkov <shomenkow@gmail.com>, 
	Tharit Tangkijwanichakul <tharitt97@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Would that more correctly describe the hardware though?

Yes. The IOMMU is inside the AV1 block and the TRM has no reset for it,
only these four. v3 adds them to the vsi-iommu binding and node.

> So this likely would require exclusive reset controls with
> acquire/release.

v3 does that: both drivers get them as released exclusive controls.
vsi-iommu acquires them to deassert on probe, hantro for its probe
deassert and for the timeout pulse of the encoder cores. Remove still
leaves them deasserted.

v3: https://lore.kernel.org/r/20261113-hantro-robust-v3-0-82383c722ad2@gmail.com

Arun
