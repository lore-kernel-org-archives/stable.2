Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55F837D11A
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 09:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601053; cv=none; b=OTBmryjPpPqJ5UTTW8DgasgKsPBMlwngjYtXvdYF3QiQGtHLRuCTpPqOmzW2N4o+P6OYtQ9lEL+7uWSMEHos4qw8ZUnChcIYe1KSxqW3vUUEOf7DA6X5/env5A5q8D29giT5OKNso9y+DyDZR7n8lQ1de2pue8gQJZAKZpno2N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601053; c=relaxed/simple;
	bh=ezr4BNZLWb6MT7EgMXHLkLvSrE/gd0KLEILyGK6/znQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aV3UAFd5QjlBqYj2hITCAvYDe2ovLNQDXPjY/bi8trXFyfjJn5CnzLWvfSoyD1IpSF0HO9WlOa8o48OHMP+y7V54FnrFvycvbRyPkcTFHN3EE39m16HnKOSRfwOymKixauraLrxuGRZBqbEZbGfILLNFCHD47y6BN/w+aKZL5kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjxdkRk1; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjxdkRk1"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc2276e6daeso1437282a12.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 02:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601051; x=1789205851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qIk+EbZ1mbotjHlbU5KOJAFSs4jlrNY2j9DG/30vshg=;
        b=hjxdkRk1rYsDF2Z2Xz7i+HMiA6qcpVdLGu4qy3MAVYnrTuTsaqy47IvcF1HJIo2pKx
         Qc9WRhZMRVRf7P6emHQ1FIqnb5iGq8gUCgk8pZfJWCoxkPoaqYEDzEGacs3+906zyTir
         tglM3DUVSgrqdYRKPMEYwztinxZPcepwRwxnEOxuKPQ+SLTWxB2GC0RzKWGdxV/gln5z
         oO1Ou6Lzem+3x0vK7i/nGiOwj07V1becodaPaomEaHd6KN74kwf7M/znWr9WkLHj+xT6
         jvve+Of2eSu8eoWy5gd1bhbEOXMtv5QxxGGHbRqnPTHk19n9IH6pQ7D7zw1DZ2UFrHGY
         43Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601051; x=1789205851;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIk+EbZ1mbotjHlbU5KOJAFSs4jlrNY2j9DG/30vshg=;
        b=paepRN8U+iSMdg9Stds+OtPVkzgWgNU2VXVRo0FCy81cY/Yiuqn5O+gAnkUbfgxN5j
         48TRFU60ZIIByyANuiuMXSUHvIjOyEV5zexsQg7N9l/j2Th4tGv5BWxFAFC7MBadfW4v
         jyxGiMTltfE+IJSJTx6/MB+zIHXAOTCF2sFV6u9cb5PbIVg1W9ZZJaLP494upBHOm4og
         XmjX8Gwq2O/VvYxJ7buoHhDBhR1QeVQYEEitqJ/0iCXDITbbOop+nzYbO/2Lzthd0zVI
         KbEdr9PF2cbWnmuVk/yDdWwAX8KEsNkuMvVP83Tz6xrAovlAx5SS1AyS1oakrU7ZQ89O
         6Imw==
X-Forwarded-Encrypted: i=1; AKwUvBx49Q8M02m3l2Py3onF0F/WBaParu9sHjcIwmKKCRrxhQumjmpanpuME8aoFcU6v3JyElTL+Wg=@vger.kernel.org
X-Gm-Message-State: AFuF++lFy1imCs7Ot+hWhp+WdW5sPd5X3Xw5B4ljM1GepvBlO6d05zh+
	wcvZC1OXIXO8EikjLJkIIpRsWQ1jRPDMDTzX93uWxYQU9Ajm+zUEdvKN
X-Gm-Gg: AYBFou3R4FMmyagJz2KNP1Kocr/yuItGBP0JXYxX4paKCTta47kJRAy4dNvbRQD4baO
	vB80wxzpIC63KesThkdDIMokv+Q0JLrsOuJgNn+ED/QQ32yYgwOHKyDjlnE1tWo72YdPJn/R9+/
	VfyoP9a03xT5j7VxAmCaIrMDuFfOQQC4wWht18aqUVl+lRhpLxeSBdVI9ZmUTr8TKDUFqVgjQEG
	dxvi/mbrP5NrXUtssw8Ol450ypM8xDD+4Lh4mdGQPWEXoQ4vGTe2tdvgjECaF2tPCZbKwlDYqvN
	rAxF/YXcW1MBRc4vrpRaauYxDPmFqW5ce6+jNq4gfmVtHAQl2Gao/ncww9JRq86zg8G72YH/7Wt
	jghQTGq5dyVM/CYd7eFhU9AGVkAc/htBpJHYKIrqPCsLLnRkY7t4ou/1BTCGE5QCOUqCKm4Mrmy
	jpqxK4drT4Za5vzYFk/eg3mpVB9ZHSs/enwBBDML9yc8/cK4ovQH6MeAzn3/Ulxqj/UUSWQ4319
	sV/Nw4YbBgVxwmy4VSrekPI2Xr9Rg==
X-Received: by 2002:a05:6a21:3397:b0:3bf:63af:855 with SMTP id adf61e73a8af0-3da39d18db4mr19264229637.1.1788601050951;
        Sat, 05 Sep 2026 02:37:30 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:ff40:39da:76d2:2e7d])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324356931sm18718525c88.4.2026.09.05.02.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:37:29 -0700 (PDT)
Date: Sat, 5 Sep 2026 02:37:27 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Zhian Liang <liangzhan5dev@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] Input: tca8418_keypad -  Add devm cleanup to disable
 interrupts on unload
Message-ID: <apvip-xz2GFH96uU@google.com>
References: <20260903192942.21906-1-liangzhan5dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903192942.21906-1-liangzhan5dev@gmail.com>

Hi Zhian,

On Fri, Sep 04, 2026 at 03:29:41AM +0800, Zhian Liang wrote:
> tca8418_configure() enables TCA8418 interrupts by writing the CFG
> register.  If input_register_device() fails afterwards, probe returns
> an error and devres releases the IRQ handler, but the hardware is
> left with interrupts still enabled.

What kind of issues does it cause?

Thanks.

-- 
Dmitry
