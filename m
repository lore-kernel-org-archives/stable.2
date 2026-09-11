Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C39329B76C
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 03:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789096194; cv=none; b=P1G2yaNIGfOYrXmeCiUgn8kwurQbBF0tTDFX2ZW2ReTjw2v4AsonWHCbuv64znx8yltOqgRB0ywvhVxUrBlY0cfccqJjlecHtZWyuJydUNQCftFnjbzraDzekIJkPXD5EWmOv7BwNcXe20MUYvfMJAlNtFfZxjPFr4tvUDuXvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789096194; c=relaxed/simple;
	bh=1/2Ot7mwanEpQT2Oh2lZDb8noJPzDO6uAeVEWs4B1CM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LP9o0/bEN0kpNptD8zNSSd1NCmtWXn9EBruhlC+OqHNv9XTYH1a8i0St9eRznAzX5HAlFRSxMNeG2sil+hTUDFF/kd4Jd0mD3AtUTh+kIIX09wJO4Jy3V30d9eeCSIel4HMl+eLY6eAPM5PznAv4ipX9RRi09Dr2Xqsx1oSWozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pmJlJ7f0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pmJlJ7f0"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8692be1cda4so361947b3a.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 20:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789096192; x=1789700992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8g18QhUuMIvjnmySCKMX62xLle7fMML3c5ElWTUHIaA=;
        b=pmJlJ7f0zPcXxR9D/vdmvrOurGwdNpE9wxSE7D2V59MHL8ApzSyFmAScRl36Z5isiC
         nYAodw3ap9xuvKfmlnYchoT4oQpv+vRSIDDKY5+9oArQdBN4REUDRJbQTG2/rOJJ8tvg
         PRictX7KyilYqqxavQo1nhb5AK0puykKkwyuN64cE0eehfrRsSwIb5HhdAoRRuH03zF4
         GX7HvM8Eof17GTzW8Fx5HV8JzDJM2M6Ir6dPTSh1e20mI8ZiVt47PaALO5EfUryxU/WB
         3BaBlSn23FERXizboBlAIkIg05Ia6UGRtiiS0MpXxruo+RrDvt9Z6vlnOYhiRWyaJNZF
         SH2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789096192; x=1789700992;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8g18QhUuMIvjnmySCKMX62xLle7fMML3c5ElWTUHIaA=;
        b=FPulr5i5GVLmrSwloA15uY4pFJufKZj4ZBTrBl+LinSUyfzpYCotJL+TOMZjqnOnrr
         bbV04nDgwa1wVql2Ugtu2dHfsDNQ1aWA6cm96dsghgkgGoCocaPyBqh1bDrYIPP/P1gX
         bt4vCU+u2HvZn3Z7cwVH0MxR0qxNAv4swaCCm5tjRgDzlajWO237ljbvOWLWLgiixmtZ
         A+GRXMBts7EmwdBEZdW1W8xqprGYFBantW0SZD1peIibDgH4sx3bfkqmcaTljm/4sexa
         oyG6OTifoJSzihGRUjlfuLfZ+xa/K02ZYo/m7deA6mb5uOSMBS5lGDeOJq125friXiQx
         9iwA==
X-Forwarded-Encrypted: i=1; AKwUvBwZ7gfRsIrNqJzj4uXzl9ZicH4SKzMUwvSmZ1YDORFWa801Bu59/nqFGaiYJ6ICAHVhSqYkYww=@vger.kernel.org
X-Gm-Message-State: AFuF++npA3ZqLR6nN3BiCUnJpCi/XawljeDi0igA2Q7VKzpsxhb7b4Hb
	swpJIvFP9Pl76PqWJiU35JleNX1ap3w5UohGMpSX+636s67dh9Dckmzc
X-Gm-Gg: AYBFou0lsoxbcJnZRMVPUHGf0DQ/kAxCtd9UwSWWsYesvr5v3Hd+9dztpwT9nVPEEc+
	56Wydsgmwml+vcf05/mfSDI23ht8/OiF+JDs9zMTjEnnRU14WQ2cQBIbOYgwJeyXmCC4vDKe8I0
	ri6+pYc2bJENzgv/uvaLqoxRAHdCIvVhVEHMNr063bZqEtAueFdZvsGizqFlaNGdl0uWaabjU9R
	6M/AksNiKCt/qeFLj40SIg/Wkpd66gvfGWbU9f9//hz+40MqRVNN0UQTUpomWBFjSQQ/FGqgARy
	5IDVkxqXrNInGRqbrcIRfThkjAVxxThwP8Rqjoq2d7j07AOLVtqXbS+3aoMJhSbS3x0DL+WDWwr
	Vl9TL/yEBlTOKR/eQYcZpx4Fe03SyV4EhlVsIfRxSB0rBWXvmCFiIIPEi8M5af8iEcxDUHAAsT4
	YhTTu210RL1lmkcihnnzeYLPv/1CkB+PHTYY32wPHLwpc2+nJRpeyC81VFrJzLjZVcx3RzGy2ls
	9L5UuNpzjOmtHL/n0eDjFDgMZog2+zqciU4A8KQUtOI3UY54ryg5cR0uRXGpg2EsI9v5eFS/w==
X-Received: by 2002:a05:6300:670d:b0:3da:5b4d:a89f with SMTP id adf61e73a8af0-3daed64d8e7mr4655158637.27.1789096192485;
        Thu, 10 Sep 2026 20:09:52 -0700 (PDT)
Received: from nxpwireless-Inspiron-14-Plus-7440 (114-25-99-88.dynamic-ip.hinet.net. [114.25.99.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc4c655c2f0sm441504a12.18.2026.09.10.20.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 20:09:51 -0700 (PDT)
From: Jeff Chen <chunfan.chen@gmail.com>
X-Google-Original-From: Jeff Chen <jeff.chen_1@nxp.com>
Date: Fri, 11 Sep 2026 11:09:45 +0800
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: nxpwifi: validate variable IE lengths in beacon
 parser
Message-ID: <aqNw+bRxpHR0h8nb@nxpwireless-Inspiron-14-Plus-7440>
References: <AS8P251MB00017FB955BDEFEEA1EA579BC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB00017FB955BDEFEEA1EA579BC8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Sun, Sep 06, 2026 at 12:53:05 PM +0100, Aamir Ahmed wrote:
> nxpwifi_update_bss_desc_with_ie() stores pointers to the HT, VHT and HE
> capability and operation elements, to the operating mode notification
> and to the 20/40 BSS coexistence element, taken from a beacon or probe
> response, without checking that each element is long enough for the
> fixed size structure or field the driver later dereferences it as.
> 

> Fixes: 73b01e57ed3e ("wifi: nxp: add nxpwifi driver for IW61x") Cc: stable@vger.kernel.org 
> Assisted-by: LLM (Claude Code) Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk> ---

Thanks for the patch.

Since nxpwifi has not appeared in any released kernel yet,
Cc: stable@vger.kernel.org does not seem necessary.

The changelog looks much longer than needed.

Jeff
