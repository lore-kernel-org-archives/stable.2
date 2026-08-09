Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA23CA487
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786271710; cv=pass; b=gLwzdWElWZ7nthH65L5zMVrPl+m5H7Er3BNoK0GYjuc8L/as4Y7yDASPawGkPDDJhpA/F8MaJwTlFgNfQotJGiIFxtvEQk6x6uFHqHN/KYy4cxhJrWg97+qk5LuLoNaydf4XeuYlAa/AZ8C1j2JBbsvcd9owuqbl408vvw7b+HI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786271710; c=relaxed/simple;
	bh=NxCAv5xAP2w1ZSf1mlnQlnFF2SO0st2zhPVTddT7mWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smlaIiodvgNiz1aF6mt3XU/rRl+VJFTToVxSAk7zPjatK+kTujf7eczv+A9vsK4RZmYqwbBp+WjmwVNxDpFo0Ua4k1OOdq2SBwaQgNXSUL4CVtnVlBrehvBtOLBqkstVGaPCM4GEKvyoOjh4PgQ3JiPCIdaiHCIwaZdFsIhR8PE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in; spf=none smtp.mailfrom=rajagiritech.edu.in; dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b=rbmK/o7a; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=rajagiritech.edu.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rajagiritech-edu-in.20251104.gappssmtp.com header.i=@rajagiritech-edu-in.20251104.gappssmtp.com header.b="rbmK/o7a"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15c42a45adso515532666b.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 03:35:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786271706; cv=none;
        d=google.com; s=arc-20260327;
        b=lDROPzvOGvpLu/CLBhmBacnyf0rNs0uZQzTFh9KTyQOoW1UOgJnIW0k3N5ifZSypkk
         DRNMbfD4DIS6ePVPSAvkZZ6zds+SbzginUB3P5f3hNyHRqgt+uZCR3Ghjar+xO9NR9WU
         JQU8dn/RMtbL5VJZyQOGHGOTtXbMnr91JkgyShtVT3Odkoh99RDmxyCQaQMrCKIjD3mE
         Kl6CBrc935BKdobMdrFPMY7cD0Xv/ozdrTXn1M6g3IXONtwUU/B9x9T8ibga+9jwZM0n
         uMcghw/+JkFlrKcrhQZTpuKZwggN+Jd+jNb0SDmXMvr08EFq31mPW/JsMqL0Objl9CyS
         Jf9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=KdX4rUCEuSYyW8WmNsNZv2tT/KklH6OSuhGI8oVyREc=;
        fh=Wz8J5UEBOCqQDV8EGy7SaS7auVxYFAJQ5oaobiGaD9E=;
        b=ppHIQ3LQpO9RqTJ/lZolbnffsaQNH4qSdpXlDFObsMp/G2/qBNhEBK1Mz8bYQr0b2v
         1BlnXGgtqT3EDlyQLxLGF6ZS+thTaFA/W1/ESEbapees8tLibhIo7T0XTj+QLkJYy9Ze
         OOwWfuEZugIjP6kQb/4DSLItHIXsg5Jaax3wPwHLeFmEwDdGGnejW+yNzNxaQbjJoW4m
         XBVnC0LbEFqoMmI4HfUoHH/KZWoQ17OQiDFE6V8CTWHU46uYFcXfU1WRUbXK7uhWcJCp
         19u2qX34FZEtHxdr8VmeuQPJ8R/paY4wX9umvtrH5xGwPDjWSIHbouhJBQd2JI2w7aQh
         EJ6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rajagiritech-edu-in.20251104.gappssmtp.com; s=20251104; t=1786271706; x=1786876506; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KdX4rUCEuSYyW8WmNsNZv2tT/KklH6OSuhGI8oVyREc=;
        b=rbmK/o7aMH3FpD0x6ep1A1LAR2sykdQONn1V3SFUlbNU5TPlr/pNSV+DJJbH8qkMSB
         ca4VY5iRt+UlB4oNrYAxX09xdV6eZziaL4ds7WLcoC6SC/Dyox5EzEwTF1pfu28bFw6z
         G6y080hc5WbnHpBXehFBrrnJkU8fjgqIZNIJH/DT7taENaq/hTOOidMiJD225mjfsLIP
         7vep7jV9p4Ak2xPerHThybY1Oa/kvGyNiywfQTbJi0liKF+4UTjan6VZcQ7D17UskUk5
         RUrDfc7GFbTMapq/9q02ltx7h8mceA3Tr5qrOaQthMysDyNzPgWmpcb6p4QhKzcOV0SQ
         cxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786271706; x=1786876506;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KdX4rUCEuSYyW8WmNsNZv2tT/KklH6OSuhGI8oVyREc=;
        b=emdhRIgWjHRnINa51MmJRo3GrS3845xzOUNL4aYwoNWtez7QCZG14FkJZlv8wj4Ddl
         ihK1eS95J4Wx8T/9etCRy12kV4Z0hIhaYl/lfx6pQ9+Ja2FVJMDiCndAe5pHP7myXRbj
         OWzzUSYYNfWFOp9mCx1wIzGK76m2Q+FYeWFumUZoNKFM1WAHw6x6xxa1RQ61lvLEivBw
         EnQdxCfKpulYq4ECaHvBXNc8DBM8pxqDFUh9qMZVQRSmoCWiSfTxEwf/8Eln3PfmdeIO
         byCskG/1+xejqNN0J6KhuzOLqKsl3QX2jqBbXtPL6C30wpKQ57AXJwS7WnqniQz6QN66
         3kGw==
X-Gm-Message-State: AOJu0Ywcc5bcqfsD3JLwLzF9hZHt4Ila+zBYY2kzFsJ7X400+iHoLCxN
	59wJB36i5/gOI88AEqyDQieLa1exR5e9rBxk2L6Ez7OYPJ81XCFY99DIk9DDrOgiqPA52pGSjxZ
	bTyeK5R1c2Tjap97v+j/+VPwFilp0jTKQHqRsodPLDw==
X-Gm-Gg: AR+sD10EX2Afs9HZ0N7ABGMFc30mXPUnhfEY0s5iihIt9xDaFvvJSE7Nqp8fBlLM3i9
	vVS0gZlOhkLwcEgLRiED9IsyMUs18n6aTqWBLAD2lbPsFYycj9P+/ysg768LEzslIzvwJnvSDAF
	mmCtWLQGqNrK/4s5YSvbjb9LgvoJ3KO0st3yRo7v8OLtDS9IYGiFZA7bUJMDefdTNcO/NQT0bSd
	djr2AFfrWZp+HF0/i9VpJkorIqFTlyfwgKcpQddNt7y4GD/gNBasrOXEgZ290NfK6RgEWyd09VD
	5ufJrLLZ/FDrDrsD8vkGzNW1riQFAwH2vz9r2QvaUQAZTI3PHQoVJwnMq8kMNAXrDBa+FqjwcdE
	jFG8smgDWCFpWvVIVlo+021ri3HqrahjhFXuX3QnPChlaEtRQN/DHPb7/Il/O3EAX+CKKYbLGCh
	GMqZMa8TUeDkA=
X-Received: by 2002:a17:907:3cc7:b0:c20:2164:2dd8 with SMTP id
 a640c23a62f3a-c208d50fe96mr561663966b.14.1786271706535; Sun, 09 Aug 2026
 03:35:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260807143428.008222056@linuxfoundation.org>
In-Reply-To: <20260807143428.008222056@linuxfoundation.org>
From: Jeffrin Thalakkottoor <jeffrin@rajagiritech.edu.in>
Date: Sun, 9 Aug 2026 16:04:27 +0530
X-Gm-Features: AUfX_mxYytND5X3lPSRMIqhDfeuuBUak7S9E9u56sUUNOrk5fSq5lU4tciuwc28
Message-ID: <CAG=yYw=wt2S1hCfJL_0Ka7bt0EqZD2wSW6E4uCWVAtes2bb0Mw@mail.gmail.com>
Subject: Re: [PATCH 7.1 000/438] 7.1.8-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@nabladev.com, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org, 
	achill@achill.org, sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"

 hello,

 Compiled and booted  7.1.8-rc1 (using qemu-system-amd64)

No new typical dmesg regressions .

Tested-by: Jeffrin Jose T <jeffrin@rajagiritech.edu.in>


--
software engineer
rajagiri school of engineering and technology
