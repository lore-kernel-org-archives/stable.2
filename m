Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794709319;
	b=1PDY6aC08edt9P7almUbJRyvVYS76F7TPUoMOMJQ2js9TSBFHsziFsw1aKboYwtoWL5n
	 3pxqTTLzMdcqQcjQt8uJjku6xY3C29U/F+/cCkNGV2ugrMGB7Ik42Fhljchzq7iRZm3Jd
	 FpKf6oHXYjxKQ4SrmL8ua+I0GAXSs76LTj0ZlYym3ajFvP0rpZbEgqEZqO1vX5T9JTL/+
	 1NEIsD+R/fpZo2TCFe9HGDigyteT0FXBZM19KbTIrIrR2cTNyQ9y5A5B1X3sbs7sWlpbA
	 YvRyVu4TCRE6+USDvo8qmflRSh7nys8vzuPkOgYV4i4ONvT+IupI3oSyYMJ7upOMTWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794709319;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=qXHHHc41FWF6q3BZigrkQJCdqW/gMYOPhflhdnzvf/M=;
	b=n9MpBDMc5I4jCd8QwtCxMhLk0GCvy8ZFGte/dtcgxeYjR1iur2GQwbbzpgxv5Q51Ij8R
	 XrIJunuHrHeesBDQnqcnmlMG11GnKKpqn7DDlPEnYJh+UlT2BupyQVw9RdR7MtGDrDvGo
	 E9mGp11g5cQRXGTUt8t0SHEzhrO/ULaIicMHIal7p/DNeZO1R9TFTxizzskjhS+nsw/e0
	 Vi4mC6cCdsngHaq+LNL/73ch6YFZZVj4/EA4XpCp6fcvI91xkGG6i7gfZS/BC8NvaQaPR
	 FgLLqQVVLphspWHV0gjSyeY+sw4lEJogmVbX8VAHHAbrHyrmfDsiwYtXa1SDIt9AFBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=seanlyon.dev;
	spf=pass smtp.mailfrom=seanlyon.dev;
	dkim=pass header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=nzWwNdHq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QLZIT08I;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01A5606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 02:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B01A5606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seanlyon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=seanlyon.dev header.i=@seanlyon.dev header.a=rsa-sha256 header.s=fm1 header.b=nzWwNdHq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=QLZIT08I
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 1AF811D000B2
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 21:21:58 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 14 Nov 2026 21:21:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seanlyon.dev; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1794709317; x=1794795717; bh=qXHHHc41FW
	F6q3BZigrkQJCdqW/gMYOPhflhdnzvf/M=; b=nzWwNdHqrVjyHJBgIP0HliZnmK
	48aeWu3Ti8o5sjWv1BsiwhDzZ1CSC4E1MFkhds8yJn3Sl7bwiHeoPq3/dFRUJHLc
	7vj/ctfSwR2PB5ETfIdXVL/n1xg0+tpb4lETThtTcJAN6cz2AmL5KxPPj5Xc2uNd
	78BRtjtUAyXj0QNtljK/PDx+mGu6o5qe3QOPTcn0/yRnLpwWVW2Hi6Exo0v7CQlv
	2okaVJpCHp6tSIf8olTOaowaN/V/Fzz3IJB90VHSqvZISSn3hTUWg0Jk6n5Y4f11
	mCYODqbljLCngcBTdDrJMLEb9CDZNueaPx8TESjxQGAN0PYAjXG7I4vc8ULA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1794709317; x=1794795717; bh=qXHHHc41FWF6q3BZigrkQJCdqW/gMYOPhfl
	hdnzvf/M=; b=QLZIT08I9Lu+pGyRMyF2bHI86+e5DrFX50nB8ZJoA5KX3WLqlf1
	VTFEmjDNCOBqQx7mkqekcxvlBKnvGxqqbAaT1Vg8FIN+Tsl+1TFrknZKdKMAq35G
	ywS31d82AInBdZ4IMGxAbWt+oUyWikdy8k+Wh4/2RXxsCQWq6dPeqMXmwUDJKXoM
	3iw6ZuIwcAW0tSB1EOdyUiUz7sQcGKHBVCorIrYP2+pcJjeG2GGr++iTfy4C3fKD
	gA8e3atQB1PrU6fhbw2XtImg/pQBufZ7LyG06iaH/G7/nVLq94RIA7oiSNPst8pV
	gghB/5gm5tBn09Ntkd3+WHM7Nw3cjEx30+g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=seanlyon.dev a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794709317; d=seanlyon.dev;
	mf=PHNlYW5Ac2Vhbmx5b24uZGV2Pg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:UGv1IHlHhSr2oH8vGi+XGApCeoRbbRLa3J50U6tBGPcSlSY
	exiYoQ3Iu3f68z5YutJGH/eF8qq85kfH2JdaGv8P9QB26/j6jVVVvgi9/Zf4ylVP
	yF1X7WobPRymTg8jIjIxpUrOvCgf5ozo60FTy65IkETqxlydWsKDZGDZDBxshUBP
	SGEjdzdgNLTKJNQ2BxeYBk2h0CY8I4g5kJbl7lCYWxSt81g8xMGtySLGUuFlbhm1
	Y/5VWI7n4Vfgsb6hgc3XljrDKnbH/BIuW7MfT3Z3KoH4Z+9OssZHkWu2yl4jwYQD
	UboRxnfQMHo50iHNqdTNlCvwhrdjcO4VKvUd5vQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:NEzhz4Fw4n9vjuOdz/kG5LzYlIst2edlg/5JQ4+VnHo=:8Oz77JzRfdquwOGo2NWoEYod6kQGN1m3tBuI9IpBC44=;
X-ME-Sender: <xms:RRf5alqI9wp-ZOHnH3OqB-U-Oll2ogPu9c7vK-R-ukXqDXTm9gTwcw>
    <xme:RRf5alXR8dfJikQNNZMwg2hVuE7-RdVgbGBy90OSglDM9bdsaHv8Spb7cXymZ_LpA
    eb4qvFel8kPPTdQzfSwyIFY9VcCaNY5KeLABpz4qTGhC0UUAFlScDk>
X-ME-Received: <xmr:RRf5aj9p1zeFXQ2yikg0JbTBlbeYwNX440EXznatlxSSJYAwpFfFdPSdTIOIvupoY4s8ctkU79doY_RZr0C0Td7rDRg>
X-ME-Proxy-Cause: dmFkZTFZjYd7mGpZLTuxKaaFHRoYdX4i2NEzO9HuaJQJQXexzsQxFWJpruajcEOtNfm125
    IN8fVsjuYx++xYPC9l2GGtQqH5GoAtFP8SpUPBA3WT/KVbvUGNozjI1opdcjs62uqwRl8V
    hCNLu2O9B+yCI5nm0ys6Yewfc+IH3pkdkGdlcHTMhxk+0WQcD1N9INX1NenQvaQo5ZL0Je
    oE85VCJTP6I6oPToVijoI4I0XvOLZyGHAGMTrsGjuTZC4kSHrz5HPAk7m7yCxVDnYepdyW
    H4MOhW6eCoeuSmkxNXVx9BRgf/XRgwk9G6iNN6eEPvd0pDjYhPcfvdcuyctibHTm1x42Q7
    fo7YOv4sigSmtsqE9oYZKTv2jUhzvh7vy9LRQ0My9dGzAOAm5tCaiN1aLSGvTGpaA81GFy
    a5lgcmTVnwnAlafDP+OCNd45YJIhOFYmPXpWhL03AD9B4ytpF7Ahy1ZqOdyYpLSkvUqUxb
    bu9WGzLjSPedx6JZ9E4VELe+iy+H1rh7h+D4B24yox1Qs322aWKhVHKbTFa/n8GRBacZEN
    l2lD84qWjqNO7/QYKP2TGdxrQYKdXnMuF8cda/UepNAT2ctTtqOd9CjPlXOsXrsOqqIfiz
    KSxIpgvlpBnLof1lH9ctG5jg8AwzB3dt2AY3WK/27zDpO3lH6cTt1y0SbX8w
X-ME-Proxy: <xmx:RRf5atYixnIFXx8x9cVn2JQIUFoZ9XTn2J5NQol88r7KIRm-clEzzA>
    <xmx:RRf5arevTFPYXIWtWzmjd0kNnWpvwnhLGCXDckkJuBQf61pq3BgNXA>
    <xmx:RRf5anpcAxbS2QEVLTz3VvBBWjhFaATHC-BlIfMfGcBRRkoaxMkIPQ>
    <xmx:RRf5aiCwCjuZ-RWxyb1R1mnIBntR21docKjOeqtm5yfxIle_B7nODA>
    <xmx:RRf5anFv7HokLOkdzIQGTU1sl0LSbm9HAgnU1ooaPehO96PfVXGWL6P4>
Feedback-ID: i07c64b5b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Nov 2026 21:21:56 -0500 (EST)
Date: Sat, 14 Nov 2026 21:21:56 -0500
From: Sean Lyon <sean@seanlyon.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org,
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.12 000/670] 6.12.118-rc1 review
Message-ID: <avkXRItw_Qahug4P@ncase>
References: <20261113153811.177190860@linuxfoundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261113153811.177190860@linuxfoundation.org>

On Fri, Nov 13, 2026 at 10:42:44AM -0500, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.118 release.
> There are 670 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.

Built, booted, and tested on hardware for x86_64:

- Intel N100

No regressions found.

Tested-by: Sean Lyon <sean@seanlyon.dev>

Thanks!
Sean
