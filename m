Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0A3803F8
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785904433; cv=none; b=tEuQ54iCPqEEmvoUhTmklaYujvSPn2zAqU/WVUOHr8xSgOiTas7vIc8d9HLyfDKe7PimW80lMVFLP+3t1q7k3phXYk7sdHyJ1hFTExOHB3G53/jCXPJiX62wsQBkZB/AcKUEd+lQ5Wjw6OLWZRVZ0trG+fxRoFlcU+u4+oxWUd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785904433; c=relaxed/simple;
	bh=hmPVkxHG0GAgX7S5j0UfseU867TpcLXvRK+Y2JAHh50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZFmLGiL+OfQSuX2BqSp9UjQgFSc0W+i+igy7nPZXYmHDHgY7O1XJIGm4/XJC+6FE47DkETYFNj1ARLv6XJjMTxN/PDzTIzJ6qd+wx6wDxnswf0ZnCGOBW17BM5gHzQmPjmdfospfwC1shw+ccEVo+L1DEUq3NtgPWI5UHHV00tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qw5pxP2y; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qw5pxP2y"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c96c92c0980so314202a12.3
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 21:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785904432; x=1786509232; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L+VSIt/dK4uaFU6UoLSPrTrRpY150XN2pn30jvRWAek=;
        b=Qw5pxP2ySPYDEsCusknMzs54qVav0CARSAubYbI5ME8i3VJtd3FPc454FMzRmBA/is
         jETSr5LVCOmEMARJUl0Okiur7nvVDevjGk9zGnvNa0ONUMXipuGIX4qBHwZQXHqipC56
         V2ktohl5ol7gTBNnCoYu/UlrvpLeB0Pi+fwM8NlSiL7/ACCMxrzZ3aUbd95FthVbHOmL
         eASa/Je1/4UmBalRpoyup+hcggV9Grk02DvA/X7d/nVrF/vDlA7LPxHVQaT2z3A328ha
         mBvHmgigr6yF0Yc0bOA2RbX2ZhIlkGGxFQ9sGnDkA4YZupMVov+KnjVSFcV7HJIngbZ6
         EU8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785904432; x=1786509232;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L+VSIt/dK4uaFU6UoLSPrTrRpY150XN2pn30jvRWAek=;
        b=dHVsOYzEFzaJVBsx1kvLEj2rjammf1cCthTuhfay/8iN5C3RL67dtEN3P+VTunMsnm
         s7qlvRxIym5Izxr11obNYNz4YtoHrRT9W05KjdoWFxscfKcCBaQRPjJgyCZNmMUclAY7
         vzUTC0j/a4DLPChtTB93ZHZUrB38hUfyR12e+VJunGDU45CjOyvU5WF1/JowIAAAvJEH
         bos71TPghUYxNcHAH9siRYAAkrOzBIuLgIoIah93tE8Ii8nFntnUEeDD6WgbH53U5RT4
         KSJi+Km0IwF4sND2hQ5Oaxm8qrCSapxqJV+Mo/E/CLj8lJu1tWT3/Rc/wgfIB514x2is
         nRBw==
X-Forwarded-Encrypted: i=1; AHgh+Rou1uU4F5x/20cvrYRgCLLu3PNkkAJKOvp+VKOlfV5aAj+K7ExrpMlN9zv/jeNE3lHdN5Q80P8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSyDM6f5j9KAruhYWqKjGfiRPCKunejgJPnB+2a2SLZSmhAzFf
	fZAHgAm1JH9OYrb12WmAXvtkSemFPrAkb23FloAFnyOyfIDaWstJigz1tAnFew==
X-Gm-Gg: AR+sD10db0CfvczO63fTzKA9wr7b9R2glM/f1yZab4EcJk80HZfXGISj4vIHwtjHAWg
	6EcC96eNe9UMHidxQHlHDvpkqem4tZgpEQTG6KcpHlwhq96dox4gSLLNwlMj8Yh1c1rqJRIY27K
	1ngsvQiFzHSYZBsvOyqUy1rsp26UVY1tkEdPRsOgv4Ogj1Afcb05yA/ARPIB+DRI+JH9eOOIhpO
	tI4rGIUZ9AxMtQtYbSy+dGY83gtfzqa3r6+aE2RAcyM6i/gpxkFjIv1Mpun6RsYSwIIlkeKFOps
	yOWFzR4Lkjq/em7IeYMeki0z3SOUqN/9EU9LXc4OAPT3nlNJ7a49k5VUzo6vfHVvCBrRmEHsT7n
	7j6xwpbzSii0asit6OnmAFV0h+RbJOjTdQpk4vbJ4qRy/O+fr1ov5zpphVPE0gswMQnbmIMR5i+
	OpBk0J1qGdVte+LAh4lJBJ3pX9XpUuc7VmnPRLl8ZypLVq8/xHwQeQhOOLK6DoP80gf3qOQolgo
	Lcj33y0BP2DENM+nwK0jcjN1kodpg==
X-Received: by 2002:a05:6a20:d52a:b0:3b4:5ff3:45cb with SMTP id adf61e73a8af0-3cb85df276cmr4903580637.8.1785904431560;
        Tue, 04 Aug 2026 21:33:51 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:bf3a:ac93:79c4:84fd])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3158673be99sm19559233eec.15.2026.08.04.21.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 21:33:50 -0700 (PDT)
Date: Tue, 4 Aug 2026 21:33:48 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Samuel Ortiz <sameo@linux.intel.com>, Rabin Vincent <rabin.vincent@stericsson.com>, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Input: stmpe-keypad - disable keypad on probe failure
Message-ID: <anK82Y-C2GCd2cBP@google.com>
References: <20260804141525.39388-1-mhun512@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804141525.39388-1-mhun512@gmail.com>

Hi Myeonghun,

On Tue, Aug 04, 2026 at 11:15:25PM +0900, Myeonghun Pak wrote:
> stmpe_keypad_chip_init() enables the keypad block before programming
> its registers. If any subsequent register access fails, the function
> returns without disabling the block. The later IRQ request and input
> device registration failures have the same problem.

What exactly is the problem with leaving keyboard block enabled? 

Thanks.

-- 
Dmitry
