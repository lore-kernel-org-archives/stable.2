Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.167.242.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793619174;
	b=JEYoEOv3soSpFLY8zMfjdzH12bAOqlNe0xwKaQpSYjuEYeB1Mi9sfoR5zOwvHebQNVBW
	 A7f6JiKB1g2OGE3Wcoa+f19KJ86ayTFFsf4YN57mPT+gm61i5aJwHXQiOEKJmguotIwZP
	 IWxVA1CKjoENUMYQhGwbvh+zf76LzjowJxbSDkb8rY68ArQYK8jaI/ZEZvFZ+ZjuyZ+R8
	 UGm3p7aRiGGP73ih3qv7Mpx8BoJntJikuRlzZnRnjPv/c6yAbqMSHkvyPbs8EHwrwTVHH
	 9/KNzN6GJKs6p3sq1NJU1u4tjz8loJ0wbphHunlWJvLn6Mk5VY4YzQsH0bS2FJT5Upw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793619174;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=73xKAjxZ/iUfedvukKH4tAcujSRHdTqC2mzu9O7dGao=;
	b=zDCanDzENEW9oJp/68E/j3MiH/rz5JnMaSAfnrLId6POjTJfvbHpuR1N/BpR+kmBWM+X
	 b7l3BAcPRzkmvn8c4NOZpSl+OqH5WL598BioWyQSyhkqi6oFxmRjy1Qu67c1iY/VaOi3G
	 5Bc2Ye+6kJRoLSmZyCLAWmFJE7LOBsBDfIFn9tE9+Cu25UKD15HwXVgph0/4WsZw6Cgs8
	 MfBaYvCVMVCnIyXV98jlJL3FrRcnbQcjASMiMIJ6PYOliFq+A1tuNsnQJXdgYlnxM7N/8
	 uu3RdxWcYwUXTm/WDbOKuIc0QJT4csNfmdDLZAv7/ha8L36BjjfvapEzUSTmuwMWriA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ideasonboard.com;
	spf=pass smtp.mailfrom=ideasonboard.com;
	dkim=pass header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=QL4hSh4u;
	arc=none smtp.remote-ip=213.167.242.64
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC26D606A32D;
	Mon,  2 Nov 2026 11:32:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC26D606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=QL4hSh4u
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id D2C12BE;
	Mon,  2 Nov 2026 12:30:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1793619034;
	bh=6IEb5JlEa93A/QwCVBaWw1bfumGLwlpduvEDjIOXKDw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QL4hSh4u5MjmKA6IPEaetV2TRD1Bfz/fu29kHrH3Ei57lI8ZR9BTEyvi3QBOI5cro
	 zyGHnOrJEI36SLW576iOUArg8EemlycCY9cZY9vD4XDBUEj3taOoBM0Uh0okeAX6Fn
	 gQ3R2ZpdYDvnNb2RvJAlqUspZII2kFZDrwwHX8aE=
Message-ID: <b3a85767-9cf5-4e28-a6a0-b6695e63601b@ideasonboard.com>
Date: Mon, 2 Nov 2026 13:32:46 +0200
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: rp1-cfe: Use IS_ERR() check for
 media_entity_remote_source_pad_unique()
To: Ingyu Jang <ingyujang25@korea.ac.kr>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Jai Luthra <jai.luthra@ideasonboard.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Naushir Patuck <naush@raspberrypi.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-media@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260514193148.2357371-1-ingyujang25@korea.ac.kr>
 <20261101132422.1396104-1-ingyujang25@korea.ac.kr>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20261101132422.1396104-1-ingyujang25@korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 01/11/2026 15:24, Ingyu Jang wrote:
> media_entity_remote_source_pad_unique() returns either a valid struct
> media_pad pointer or an error pointer (ERR_PTR(-ENOTUNIQ) or
> ERR_PTR(-ENOLINK)); it never returns NULL. The current NULL check
> therefore never triggers, and the "pad not connected" error path is
> unreachable.
> 
> Replace the NULL check with an IS_ERR() check so the validation
> actually detects malformed media graphs.
> 
> Fixes: 6edb685abb2a ("media: raspberrypi: Add support for RP1-CFE")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ingyu Jang <ingyujang25@korea.ac.kr>
> Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Reviewed-by: Jai Luthra <jai.luthra@ideasonboard.com>

Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

  Tomi

