Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596135;
	b=tQMFZH0SzIMO6JLkp5HMReKZPnGOo1lkp6HkHPcVjBJpTMdNCotxdEE1DLbhpT7gTqqZ
	 YhaznDu08i7h7IUVaWW0zLrE2fVgYWnYEOO7H5+rDS175QoNzZiXKX5a2AjhLiKBH5AYS
	 ew0QWcd6sOc1lso6Ia5NV8ZxyN5ttUqB4a3V/VJMTepYEbd/Ez4A1SZTTBp6odbbNguDV
	 GkEzd3yGiO/0BISRmuhY7GEBaq0vIU0BV67cFCC6ORzsd2+cLtDfPhkIM7+diOuw7sVh0
	 sZ3tDia9PooI/d1P3jg5dJ53iwHzESqbqgJzY7MgAC/4Q2aQdHd1+89YUb168RgJnWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596135;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:In-Reply-To:References:Date:
	 Message-ID:MIME-Version:Content-Type;
	bh=bfedwSxwQLGGz+Z2vyd2vC4NVHhMFBOOXh9XyPwMEUc=;
	b=YYCFGSjqheE8YBYZK10Up9E4nBUBWc57W6iU97uUAjMGCzwXjsnuNWZNCurk1mHGXck8
	 cVV4yR4jdlQKicq47+rAoRAdYJmXwQbpNeLnJS+dGF25gkmNl3mIPp4kabkAfm+wixIeg
	 aNQ5v3MNTHYdTCIdTvDsS1noqhVlLxZsnuPaNAo/0QFwOLLZkCiXDr+pIK3MwV505c2Fl
	 BBgdyzlWso61U4RQ2KH+jSRePR3MJIpmAR69MCn7T4RLlxK8P62lMmYqccI/c3T50Xwef
	 Z3kSzx0sjVS9ycWGQ0PMfP4W/Sxa1+ny2SpaQa4RFZ+/1GtqLM8G0YiTa2OGjtE/JVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Px26KOns;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CTaHRziO;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B9C606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62B9C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Px26KOns;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=CTaHRziO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795596133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bfedwSxwQLGGz+Z2vyd2vC4NVHhMFBOOXh9XyPwMEUc=;
	b=Px26KOnsf8VzWaT5M4+AXcSNp0xsxvL1F6fNbr7DrhkBSuZfc89DxLbq56hteEnSnsCC1P
	XC0DDlgCO9PWNvFGT8J1/10w32LNQmUSnDexmrqotpmPjGLs2yIpE9PleFJrHiOlcSpJF6
	hVsBNoRC49PsF4OsiUpxpOfl7krYqVU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-173-qPw6pguENMyx_oDZ99-m6Q-1; Wed, 25 Nov 2026 08:42:11 +0000
X-MC-Unique: qPw6pguENMyx_oDZ99-m6Q-1
X-Mimecast-MFC-AGG-ID: qPw6pguENMyx_oDZ99-m6Q_1795596130
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a359c7f47bso45708175e9.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 00:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795596130; x=1796200930; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bfedwSxwQLGGz+Z2vyd2vC4NVHhMFBOOXh9XyPwMEUc=;
        b=CTaHRziOWhRLfDiA8sCcG27lxyX/1F5a4BlJiDD4p+Dl3MZv4mIP2LFQIu9P+CC/Q0
         7GeWfauPuuGzzBVopwUkXMjSdY0IeQb6VqWY1ZKXhwZQTxtvcneY3ow1rnl2sLbQSe6+
         q2sC4CvyAyDXmFRUdQA44PynRRUPZ+VnLXSPdGCabB+g/AbHVMcNXZAtypRJ9OEPz3jc
         fRIxNfxVZ7Lqsd+SUDSsbqsYM5tbCg6me929qizqtdiA/G0xcdNj1/6+oh0VdN1GqYSn
         3IdJ780DHdDGICVzxUquB8k+nL3wERpQMTCD2mK6DmirW9i5ILUZDA40nIT3g1djYNZN
         oxlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795596130; x=1796200930;
        h=content-type:mime-version:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bfedwSxwQLGGz+Z2vyd2vC4NVHhMFBOOXh9XyPwMEUc=;
        b=SNNcVLDlpqliSEsnY6WRW7YtUlnKiLCsaUlNIXyY4Svh4R3O+2VVdJVx6WWFDXSx7a
         YPVEy/5XneUCtSO6k5GCqB/7XUimCW7IBXe9PRysDBnIB+LhkxoMG3NEQE9AtmIloDLs
         8qWvUczCEnYagRpaZfPRodXWmi2LwR+MXcd7KQxZ/OZguQMrCfiyKlHwq6e5zJnDdk5R
         TT3mUXfCkFB3so6fhZYx+WV1O7QiCfCwKjsOKz+QC37HZC9L0rDaSB80rQzLYkIjzCr0
         bua63chdo91z7CUGWTZ4BkKf2wJmPK5jExHxvgwFSVwDgBHsrDciNrsqHvOdO0Ja/Cr2
         uHYA==
X-Forwarded-Encrypted: i=1; AL+hErElVVpN0NiK0RPG2K1YbH5RN0lmvQJzCfP59FisJDRV8Mtqmgk8PeY20VXeF5gORRNmX8zbU/s=@vger.kernel.org
X-Gm-Message-State: APuU4Z83ogd5P/HGjSKVNTXnYnfzYCbFPrhdAMxkTYW4UJhKHoFqdQh6
	fLEVo7QiEvyucujisKaGvVoJnENuhk8/ZtikmhjXkILReAh6xpYby8hZKcuQEqvS/oBDLGXCF4v
	DIHMOe+U+yea4dfwp4663nYxCtu6h1RWwI+5qyAccllqWM7coj1rcystwq8W50A4QdA==
X-Gm-Gg: AZFdTZco/trGw2KBSOc3SC7v2I7OnLYJfkv6sEzCigSTvW6fZGJgN5NRYfMSEYq6dT/
	7tjOAh/xmG++gCdVMkSG0YyKe7b+3n3gzhyGeaM1hqge7zboFae/fyPtaSPNMzwN0yJWeoOtYx1
	aAfNXhRd35DffraSV+3dOez5Pkxay4kLeT7oRAGlEXEiGagKxVJYdEIJqylCAm+D8gpGphGvzLr
	pbrqSE4+DgECJZkwPf3wTAyTLMwmQg2y9Ek5ZwuPvmI2AoPQzz2R/zAH0aSVfaT0aYLkiRMqLQd
	Rc8Cqyd6UzSP1QlXgYD9JMt+xCuLh93XS7Y9enK+ISNrtOI0D5AtiG3EUXIP02//gA9n+We80D9
	ObiNR26uHPZbHGpFEzptIou62By7N4dHaBptLtbyisBRhc9jzeX9/ccYhNJhZRvDuvdwamYHZqv
	AeQxtmjsocmNSoTGt6+ujz/bvCmelNZvEV0rjs6U0=
X-Received: by 2002:a05:600c:4584:b0:4b8:4af2:88b3 with SMTP id 5b1f17b1804b1-4bb88817aa2mr346073005e9.22.1795596130196;
        Wed, 25 Nov 2026 00:42:10 -0800 (PST)
X-Received: by 2002:a05:600c:4584:b0:4b8:4af2:88b3 with SMTP id 5b1f17b1804b1-4bb88817aa2mr346072345e9.22.1795596129635;
        Wed, 25 Nov 2026 00:42:09 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d55sm32983935f8f.5.2026.11.25.00.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 00:42:09 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Yige Jiang <yigejiang86@gmail.com>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: Yige Jiang <yigejiang86@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware: sysfb: Clear the device pointer on
 registration failure
In-Reply-To: <confirmed-20261105-25-a16124b5ff57@gmail.com>
References: <confirmed-20261105-25-a16124b5ff57@gmail.com>
Date: Wed, 25 Nov 2026 09:42:07 +0100
Message-ID: <xlv1mrqxl2u8.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Yige Jiang <yigejiang86@gmail.com> writes:

Hello,

> sysfb_init() stores the legacy framebuffer device in the file-scope pd
> pointer before adding its data and registering it. If either operation
> fails, the error path drops the allocation reference but leaves pd set.
> A later sysfb_disable() then passes this stale pointer to
> platform_device_unregister().
>
> Clear pd after releasing the failed device, while disable_lock is still
> held. This makes sysfb_unregister() skip it just as it skips an absent
> or already unregistered framebuffer.
>
> Fixes: bde376e9de3c ("firmware: sysfb: Add sysfb_disable() helper function")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yige Jiang <yigejiang86@gmail.com>
> ---

Thanks for the fix.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

