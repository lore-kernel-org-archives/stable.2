Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BB430F95C
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790451802; cv=none; b=ccAJwR+dj7ftieBdirQ50/zEfUUE5XZPPvicHybj4Bf33IwiP3sDDux58+iCmR5alo+N/t0tx+zvRYop5QYDcTj5qaJiEaoMgI3iQfDSL5lxDXtNj+ScZ1Ok+hl/7MHF+Or4KpUlf2BdI+Oc5a9zu9fY207IJCuZlhqaLFkTdwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790451802; c=relaxed/simple;
	bh=yFzj5SLBlau0HvAKLRZZb9fm5oHRvILo885f0yEf6+I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EIZFo/DTN4j6mFVJTaPjflCWyqGCl5llJfJF+IMu0fjJ+xdWnRecgh+sgE26JvmSxWjwle5INWhXfpcDb75XZrpVUEBmGpKp/CsBJodzkJ0eF3ugBgvv59e7hfdSoOKe+u7VWz0/JXdjYX0IskmHJ/gqXBveIEVDfubhoyYOWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SmIezdHK; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SmIezdHK"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so2183425e9.0
        for <stable@vger.kernel.org>; Sat, 26 Sep 2026 12:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1790451799; x=1791056599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KGm9iURTFOlFsZwXuvtV7Ou17cgzdnPa0yxJVyNfdSA=;
        b=SmIezdHKprJN3ZjANvSWLfMXmZLxaKO2zcpWybN25horFWCOlgRmSQPS+j0URZrbmY
         tz+HTZ3ScIZUId5NJgaN7UFxraHNY9HN/VacwqgH3pE0EuProk/6QqX9mDR9+IkjrYTF
         cWwAB+0RxbKZFIusc38rbzVpnLaaU85OynABE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790451799; x=1791056599;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KGm9iURTFOlFsZwXuvtV7Ou17cgzdnPa0yxJVyNfdSA=;
        b=xLkyrEwOKHNbQQ9xycFHPTjGolVftT6lBu2cMph3zugVr1PFz3FvzIo30mT/l1aFW7
         AXvbZ1FAqGE9smPAKGTeqaNglNVKlzotpwS1y9u+tunzcFFKXRYSyU8MDD5QWUez4x7f
         YQRKu6NZwiOfg7NG4u0YLu0VOX4u7GoZcQLSn5OCTKQIIOjGPWsswCwSkDIRn9AIYAEm
         kWaZSI7v2Qi0mk9KKS6mhwTMTa3E9IgbfJygSXf2/BbLiSd14bF51/M9PQmklwIAsekv
         HSdqD+CCb4V41KvFMY8XsuU49drU7Su1q+03ue/i5L+vJCc5WQ1yCq4s2fpc5vYfKfSI
         HDuw==
X-Forwarded-Encrypted: i=1; AKwUvBxkf0Xv3LhaHVIATdkSOBr1+XMmObnT/3y1Gku61jyPW913ie/OJBZ0f55CVHu0p+XEn0i9rnU=@vger.kernel.org
X-Gm-Message-State: AFuF++ntBmLnMl/FcwMqU5SR4guaCmeoiCRe1mwewhjkUUu29l5KZlPi
	NwMGxGnVZtEFqWPK73t5EGvrSJ9mSL5iNyWeXfm1Ot8hsrhqy1OoD0PGa5Agc9Y1glY=
X-Gm-Gg: AYBFou2UfE1vlMjRHgRxhA5GF5JvFb/ftZH2bSwGKiSJI7cV9mRVUydzxPF0ulpDTX4
	P3LWt8VZCQ7w72uTnH0sx1ap5YYQJwoDFshIOj9LAfzHM3s3uvdxYbJkrV/A0SJk8rlAB+AkhgY
	xKDV+vAUJq8BUOQIB8aUR3Kx0FlimdgAw0/V1s/ZZTj01wlEKqs8rsM8JM2aRPQu9QB2wYGnaO5
	2ntglVGiFZRBjiuV7Cofa0cSynaDH56XIFbbYGP8jxgD/9FYJxyUfVpzmeyn1uXolH28jmbv6cr
	D9QV+F29+5IWdD6PEadP8cr1Ot7VlePNe2mJ4ev4bwltuamXkxhlXbhA4hEIIIhcTbn3wPph6xx
	59UoTGuBpoiA7vRHZYQ5fbhEGrojqaZwlXNdBPMDQFKdelFx6uPU4KuVgl3o/eh05i+DMvqxzn4
	r5HLYfl8borio0BIOLShfclIngZl8nECJD2uerdFZltol6lzQs1h0nsTjoVJEKZKqp7UWS/X3rI
	VVJAMQFuWZGoxtdj84Q1dh4Dt0+xDAIg/q+K10KPOxSuQbcqLmH7V5yFw==
X-Received: by 2002:a05:600c:4705:b0:49e:65f2:db64 with SMTP id 5b1f17b1804b1-49fe66d03b6mr165541205e9.5.1790451798838;
        Sat, 26 Sep 2026 12:43:18 -0700 (PDT)
Received: from [10.188.205.27] (cust-west-par-46-193-1-237.cust.wifirst.net. [46.193.1.237])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fffc12af2sm35786975e9.10.2026.09.26.12.43.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2026 12:43:17 -0700 (PDT)
Message-ID: <b0b2ed50-efc3-4b73-bf03-33adbe37cd2d@linuxfoundation.org>
Date: Sat, 26 Sep 2026 13:43:14 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] usbip: vudc: Prevent transfer timer rearm during
 teardown
To: mhun512@gmail.com, valentina.manea.m@gmail.com, shuah@kernel.org,
 i@zenithal.me, gregkh@linuxfoundation.org
Cc: ae878000@gmail.com, michael.bommarito@gmail.com,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
References: <CAGEsz8Gwh=Y31EuTJLUp_jq3HhiizHxt7_ivOuytyZZH06mycA@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CAGEsz8Gwh=Y31EuTJLUp_jq3HhiizHxt7_ivOuytyZZH06mycA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/24/26 15:51, mhun512@gmail.com wrote:
> Commit d96209626a29 ("usbip: vudc: Fix use after free bug in
> vudc_remove due to race condition") deletes the timer before
> usb_del_gadget_udc() stops the receive thread.  v_kick_timer() can rearm
> it even in VUDC_TR_STOPPED, leaving v_timer() to use freed vudc.
> 
> Use timer_shutdown_sync() to reject later rearms.  Replace the
> inaccurate blanket lock comment with __must_hold(&udc->lock) on
> v_start_timer() and v_kick_timer(); v_init_timer() and v_stop_timer() run
> unlocked.
> 
> A KASAN/DEBUG_OBJECTS_TIMERS x86_64 QEMU harness binds g_zero to
> usbip-vudc.0, sends CMD_SUBMIT to usbip_sockfd via a socketpair, and
> repeatedly unbinds/rebinds vudc.  The unpatched kernel reported a
> free-active timer and a use-after-free in v_timer(); the patched kernel
> ran 4000 iterations without either report.  No physical device or
> remote client was tested.
> > Fixes: d96209626a29 ("usbip: vudc: Fix use after free bug in
> vudc_remove due to race condition")

If you haven't tested this physical devices and a remote client, how
do you know this change fixes the problem. Sorry I can't accept this
patch.

thanks,
-- Shuah
