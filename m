Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=71.18.227.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793630462;
	b=w5cDQmcEs+Tyna2Cp6vA2P/pKDRK/7C2mlijFpxhKII3ssWhHl6VC6SYl/AYr0rebuMM
	 hmCVJXhUmm2nd4wgMZhwsaW9RJlTNLjEYtxyUqYDviIWpqyDMor69HdR8rCbN+mlSho8u
	 QCqjU/PqIJEvpTsoEuuuI9w1bzHpAgKDi5AQ2k8N80J8ovZ/POaFJmsGMksIVhPaN/v85
	 bz7E0cZxNM+Op43XuyQbaDVyQ3FY7Ry2+P3ITLn8mvd0WZiXyYBIU0UC3e3S+VPCPOc6L
	 SViyXJztpOoRIngH7p+HdML4RGcQM03Ej0Vq6jttEllzKzZ6IoHjcoblbO9z/VTNikQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793630462;
	h=DMARC-Filter:DKIM-Signature:X-Original-From:To:References:Received:
	 X-Lms-Return-Path:From:Subject:Mime-Version:Content-Type:Cc:Date:
	 Message-Id:In-Reply-To:Content-Disposition:Content-Transfer-Encoding;
	bh=hBYpVLk0Gj2yhc6ZR1gYRn6W0WDnpenBHlPBQXVZPZo=;
	b=VkRWv+9Q/5HGtrBpuqgOXKFApHFlwb0zkXxcU4XZ9e3vlqxjYa8tsEEvebfLtwD7nu+F
	 T4ZM9ljq20ddm7idm0fpeOwfy31Q5FA6X+jgm5sS/y+EIaIOCtMxNqpTT5LWMCU3GZBPY
	 gu6oUR5sSOuS9C6eHVERk3ckRGtFPITBdoGtOLjThls1wsfJNsGFJxqih6iYDdyrqGUCC
	 yXcNQO4M0+4Y9tbui2rHDsT5atCuvxDiJkR8Z/51UsO6BYXbP4BQtffn9y61HH6qKnKdk
	 QmUYBml50kuUtEjN8euodYR0eB3PekiGUVmhHYriUJHIHQ06WuyV1cstHDckqPYrJxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cherr.cc;
	spf=pass smtp.mailfrom=cherr.cc;
	dkim=pass header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=GJzEnvy8;
	arc=none smtp.remote-ip=71.18.227.1
Received: from sg-2-1.ptr.blmpb.com (sg-2-1.ptr.blmpb.com [71.18.227.1])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD56606A59A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 14:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD56606A59A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cherr.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cherr.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cherr.cc header.i=@cherr.cc header.a=rsa-sha256 header.s=feishu2604220257 header.b=GJzEnvy8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604220257; d=cherr.cc; t=1793630453; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=hBYpVLk0Gj2yhc6ZR1gYRn6W0WDnpenBHlPBQXVZPZo=;
 b=GJzEnvy84RRKaN5aDA1cjZq/FP2gALazbs9k16zIXACzHliF7DQkbBZiBa4iNFO9K/Q0//
 pFhZKLcJnxX7vRJeJWD3VLrSJATnmwuIZ1uW+v1Mzh4AeJpjPRmHJ1ojPJsT7EDpcfiJ3X
 werdSyZZ/ETplnqcAT1v/yCTYSF5CzL6FKTl0C87VTifXgf6efEhqPq4jfLnBOHshVYnfX
 JHeB7odxBBJhK9dbKnKUlFKLy2AUicjTwToAhB65LZTRQhcmVA5Icyyea4ZoL0Y0Xvb09c
 EXFKyWEMbzzB1d9mpfpcsXKUoB5jsRl+ve7RP3FSzSUuvBal0P7Zzt1s+yxFXg==
X-Original-From: Shengzhuo Wei <me@cherr.cc>
To: =?utf-8?q?Tomasz_Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>
References: <20261029-b4-pidff-rescale-exponent-v1-1-3ba54accf767@cherr.cc> <bbd1ec87a9fff50b189f74cbd21e1d5bddf41136.camel@gmail.com>
Received: from kernel ([111.40.58.226]) by smtp.feishu.cn with ESMTPS; Mon, 02 Nov 2026 22:40:51 +0800
X-Lms-Return-Path: <lba+26ae8a0f3+bb3eb8+vger.kernel.org+me@cherr.cc>
From: "Shengzhuo Wei" <me@cherr.cc>
Subject: Re: [PATCH] HID: pidff: bound the unit exponent rescaling loop
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "Shengzhuo Wei" <me@cherr.cc>, "Oleg Makarenko" <oleg@makarenk.ooo>, 
	"Jiri Kosina" <jikos@kernel.org>, 
	"Benjamin Tissoires" <bentiss@kernel.org>, 
	=?utf-8?q?Micha=C5=82_Kope=C4=87?= <michal@nozomi.space>, 
	"Paul Dino Jones" <paul@spacefreak18.xyz>, <linux-input@vger.kernel.org>, 
	<linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<stable@vger.kernel.org>
Date: Mon, 2 Nov 2026 22:40:48 +0800
Message-Id: <auig8ARnvkEoAagA@kernel>
In-Reply-To: <bbd1ec87a9fff50b189f74cbd21e1d5bddf41136.camel@gmail.com>
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Tomasz,

Thanks for testing and reviewing the patch.

> Should we maybe add a warning to the driver that the time exponent might
> be out of a sane range? Sane range being, say, 10 to 0? This of course
> would have to happen during init stage not to spam dmesg.

For the initialization-time warning, would -8 to 0 be a reasonable
exponent range?

- -8 is the lowest exponent in the commonly used signed 4-bit HID
  encoding.
- 0 allows a time unit of one second.
- Positive exponents 1 through 7 would give time units of ten seconds
  or more, which seem unusually coarse for force-feedback effects.

This would only be a warning threshold: the driver would still accept
the device and leave the rescaling behavior unchanged.

Does that match what you had in mind, or would you prefer a different
range?

Thanks,
Shengzhuo
