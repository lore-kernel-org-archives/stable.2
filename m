Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C153BB134
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 07:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791531042; cv=none; b=bH86pKN5tqsblHwev6/JudIavxB+wV0O5MqTdtbTo2Ji+41WyhUJ3gpB3OekSHcTr0C03m3qrIwjmzHbPpm7So0jpFFhioP4sK3JyzZ6DAQZd/gR2dyz1sQamUutBmIQ7fB5qhPmQ0I83V3ZqmVGcgy/+g7zCviwBTaovDa+xp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791531042; c=relaxed/simple;
	bh=m2sbDzTVz80zNixXWIi0WDat1SU37qeKuIL9ZzrWE0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8p32DxRoHY2hh6sZNi4lxkWx/4ZopRc94uddYZLVyrK9dJ1m+OcbHvHn6pnGWh+XTfFX4yPuf6JJg0eL9Gt215C07lJOGC6fhExq+UMWmICxSay9J2NHSZuaIDx8nUjmX8AEw86383+uo7OGTO6i7El33PFixlLTg9bIZFg6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TisiumbA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TisiumbA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a1880e1bf1so9981335e9.1
        for <stable@vger.kernel.org>; Fri, 09 Oct 2026 00:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791531039; x=1792135839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QhfdgCnusoug/g1d4W12Bzr39jd94gg5/ulsL7PdlMY=;
        b=TisiumbAcAGgBzjagMugUD4vnd5QOPbyuCPbgGXc2bY11YasM0iNwBx90vl1OnQhBW
         0lIUXSaGBcnnkD3lTHRIZN1F6t7n9FchBO+t5uHEJdUAM+H6nI1jMlnD0eZpm/ymMSUT
         oPdnbxWZmMT/YSC+wiRo2R7q5jVgeUwQcJj/L/54jTi/pvv2YdaQvODC8QbNgHuE6PWQ
         cYBAvtdXW8KG591U4nJWV3r8usAFp3pXPL95DgUB2lSTxTUPDsC8QU/wwr2YTQhJpIT3
         EW153KTI7R8y1OV7WeMZ4MD0uw+IUvjXzxZ2+AtyrweGBGERMBx0lx/mYx+gJaFTjL8w
         dlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791531039; x=1792135839;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QhfdgCnusoug/g1d4W12Bzr39jd94gg5/ulsL7PdlMY=;
        b=AgzpIfkxVxceC+jlwvyCRVuVKbYmoHFgXKuetNOC59lVR4FjQVTh7HG2s7/XgbyQNL
         phvW3Bf1DmI2tzuADKmI81MYw0egzGo8ZWbzfovDMN7r/kkTTAUvAtd50KMcoCUun9gr
         +9HvOStoaEi5FAyrFgsl6VT/YQzWTr7LHOpBdytVn1fZooXXXQVrKWAgMWHjeSC/y20v
         MDBoMlU6FcbaPqYS0tcbQPkZWW+tz3nLYBR1CI/s212DoHywvjNDdyBG+9eT5ENlY+ba
         2QWswmk+DWqulMymwlM4rX6VIj4DPh+lWoo4VkQo7MzlPH2HuW+jecdIiYkXQlD1Y6vi
         Rj1w==
X-Forwarded-Encrypted: i=1; AKwUvBx528EjsYxaVpmYCL9PlpXlpqcwAkQ5FDgbZWQmBYJhlFYznlQZEeiTyIoPTwhIc/S3zoo1mgc=@vger.kernel.org
X-Gm-Message-State: AFuF++ndWdEcLI0iKCvuCVxWd6pehsz3AyYMKhNbAxQ8S1QqVCmhnPeE
	hOyX1YK8J5yl2DS8tu3W/aTM98bkbZfED3nFBLnunApmKVGAQ5Et6nF+
X-Gm-Gg: AYBFou3p2ujoN6zEP/IIMui12Xz9G18n9PlwHO/x3QJeebTCXaVaRnVQeiExjF16Vzb
	9spo/S5MlO2IV1L2XYtnuSHj5pdOIH+7+XP66x2/zxUYIeLrRdMN5jkbNWf6CJ4wtW28hlEKRgT
	xINu3tMvNUwoV/+R1l+PcvBl2DL8233vJzIgZEfMAg51eCUcrLoeWsfIqF2tNdqK/txujw78hpj
	kox6xfFjD0cT7bBOWxHmE5i1lGIXAjNscgJFllqJpIlj8gJC5noKabw0KWUZP8fN8f3AQYujQua
	0oQjSsVT87nqe749D1kRDkydcADBi8PCkWIMm9t2VvRXwpt9T03rtWHMbbARRqsMePZk5cOMWUd
	D5yD3ixLhQKZaON6rXNWw1H2062dTySlUn5t7Qq56hLIKWH/I1QE1TWkegKpthFQIT3trMNdxAN
	/pVSx56A2hgZ7hE3vcks4dN/2zWf9aXVGRbPsIpwkWH6ikoqzbMtxg9mYePIOq0tCx1BsOrlnDF
	bgmVKV8tRlfWW5+wMiOGwYiqCloyU5DaWlRtV4+QJ/YvAcFPxAOK4afI/6MhGYkngidzFELN9MS
	81mhKtLDRm6oVff4rXeB40r+g6BAXV70VrkYRUXHjAXxeFrMZKdlPViVaRM/h13f/oeET9WylS6
	C
X-Received: by 2002:a05:600d:82c6:b0:4a0:1fe2:d4c8 with SMTP id 5b1f17b1804b1-4a18e4a4c3emr19524635e9.5.1791531038809;
        Fri, 09 Oct 2026 00:30:38 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-a128-aa01-297a-7094-853e-a20c.310.pool.telefonica.de. [2a02:3100:a128:aa01:297a:7094:853e:a20c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf31b83sm38426495e9.12.2026.10.09.00.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 00:30:38 -0700 (PDT)
Date: Fri, 9 Oct 2026 09:30:37 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: avoid sleeping tx locks in netpoll
 context
Message-ID: <asiX75kRueyFqWuO@gmail.com>
References: <20260930185417.61865-1-kmehltretter@gmail.com>
 <20261004122910.1392318-1-arend.vanspriel@broadcom.com>
 <asR1TaKQJlPFqEvR@gmail.com>
 <802a092a-314a-4f77-aa1d-134b3d020069@broadcom.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <802a092a-314a-4f77-aa1d-134b3d020069@broadcom.com>

On Tue, Oct 06, 2026 at 10:27:27AM +0100, Arend van Spriel wrote:
> > 
> > Lockdep instrumentation in fcmode=1 and 2 confirmed that cleanup enters
> > without txq_lock.
> 
> This is an observation unrelated to the patch, right? You mentioned in the
> patch it only covers fcmode=0, right?
> 

Yes, the cleanup observation is unrelated to the fcmode=0 fix. I
mentioned it to explain why I kept brcmu_pktq_penq() for normal calls.

I'm looking at a separate brcmfmac FWS-path RT/netpoll fix for modes
1 and 2. The prototype defers IRQ-disabled transmit to the FWS worker.

Are modes 1 and 2 used or recommended on SDIO devices? That would
help me prioritise the follow-up.

Thanks,
Karl
