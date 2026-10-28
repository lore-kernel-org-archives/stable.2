Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793196156;
	b=ohevboXjbn5RyhIdaWjTKvob2Zqk/azuquFM+G2uWp3nEsVDTc5mHRP+WCJ2YV/yHKis
	 YONH+fDvIYff2aySq2UJV/ec5QXeZGX4QlgTaVQQaDchy1EDQ2C6dytHNiC1GPoHe/9yO
	 3LG2Nj4JOsRtcsV/c94vKczkYaDBL/5HAjI2LtHnNYx/7A+bNG99i0UTp9MxMDF9ULeL+
	 WFhcwAmh1u0WD4yLfcAC2jNNIWx9CHzPPr9/c5F6LhE5t6FEv6HrT6EP+A+Cn/QeMVrck
	 lqgAY5cu45jl6lIQin15liP5ceLO8LaoL+NLQNEt1ONYLeC5eQYt82fyKgVXxa4y+sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793196156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=MhbJRMX4KyE0vdl/l3KEbEyUthhHhbsHZwQfxPaiOrM=;
	b=ZTJSG7Tmgv2SgnkdRzohIWGpSTBzvyL8Ai9kBhcjA60M1qPmLZirlZHtT6q2OZk+WbSK
	 QNbhqMJbHPmlotEqPQCys7ysaspZTTuZ47GM4pCntgNMCRFi19ryq+NOBUlcfG4asJKLy
	 IIqnw49Yct30t+5rywlfcTEN8ZhssiZQdFyUIh0oFmAAzgv3Me/uZNy3+am2vTfDq70EW
	 PXLlqUF0r91dXrWFlwdL1cn3w3tPDtJ1agnqTDUp8MAE37q5Qgi8kgR3GFrUFrUHs6isX
	 hGvJkzAupkGhp4OSK2jMqu+PoLCuE2bsz3TxWI4WrpGRXbqmeBWeIObKpKfCEizl4uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="a/zsbTjz";
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FEA606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 14:02:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9FEA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=a/zsbTjz
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-1846bc43c28so1145351c88.0
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 07:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1793196154; x=1793800954; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MhbJRMX4KyE0vdl/l3KEbEyUthhHhbsHZwQfxPaiOrM=;
        b=a/zsbTjzoQEFKXLraCTJ4jsxoZ+TXTYLqDB+MQaOeLkzHWqMoTJC+u+UuEt5nUWBIr
         IyxhlQxoi39mMAn+GARyXLq8f+mIWD2bcEMwvYwYWFd9c8Js8Y+2wwc8sgFO2mcRriKw
         48KaQbhEPXAV/W6pNUKxbO4IbpIzCybPXfLhGMouIObosONpPY3ajl3Ivrq2f6LYSUUe
         k+a0YnyvarS/Sev3zKaimATJOHpeUuE5psqsLG9PXvqBiLKy7MPR+jlkzf8B59UIblDO
         FYm0dq3OfVtzqMi7En5puNDyWEMKI1pRD5Kd+SbWg3h9XamJSOjgIi5To/kaPxEphqu9
         6wtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793196154; x=1793800954;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MhbJRMX4KyE0vdl/l3KEbEyUthhHhbsHZwQfxPaiOrM=;
        b=chYq7i2WGVOC3I6FiKYVOBMqtlI/iUk/mWPiOs6YT1vnslVwL/KrS2UQVyGdlUNHYE
         5L4L+l1Fwvi+ntJ2yTbZAscyJyJLq4iBtC9LZiEDi0yO5euDvYLG7dMEOLZ16CtJ+uLS
         uzpBTC/0M4q2lB0fwksHAcBj++/+U8/zgGaeNMfCnXgfozIjm22B9jDe4L4XxQdzY8aK
         WC4UuK67cuHKHulMKVO1A4O/dpytlNbH7x+Uv0mukv6A4UdkYHvsOPWNEhzQU9tQ/v7b
         iNxoxbID4rNmdq894p8NWrkx6z3qMadiSCjp9/ZE0K1mpgg6bYf7icTdkGDrPWwAX8WH
         gbOw==
X-Gm-Message-State: AFq9FYJ8pcVOK0DZe6I3V7AAKtTeQ15+3jWKUeBaLZ06jXYOrHq8sTVX
	r/W5E5c42EM4hy9mZXoPOevlgN3c9wz/pHY/m2DGeSlEVY0UuMyOOuI4eKvhm8qNOWQCHuU818W
	MX5q+hBc=
X-Gm-Gg: AYBFou2rKuM3SHForeExv8gLS3KBUA2NQx93nEUDIyV5kjLyNGQ+COpULcDITg7+v0M
	nZd3HcRo/TmVEo9j7Yg6sI9FjjJQesX6gCMR8bqExI8JYcvPu+AtZru+482LIoUwEMpUi8DzUMf
	P3jv5YKPqQlQg2x7k4+LbQeQwfirxC310RB71JRKWKijiRxxTajFF2IyIHahZ9NPReCAAcLBxos
	a5w76PBPUl25o6yDzc7n1KYjj6yXqlofKRB1Zyl2kLqLhrBK2wuUNHsPSumAewDXVwzwC8dKcQw
	AnYZQHXm0nwfFmkJ8So3LFNvEldaWHeg/eha1Zpf8UsE70y1cw+IfMPQiGJvNV+eIv1yShkEMAk
	2jQGwrmr7yCk5QhUHlw08UuUAMR1HGCtdi2+gZTI5V6mYl3NRL/PVQ0/x8TmvP3BSRTlFaNdJA6
	08nL0SIKNjbZdsBbRuQNk75X5/WVAltExOo5ZrWCAOadenjKfym2VmlL2TME5cJxVxp/2yBDOZl
	cu0cS25KZkTQsrEnF+goC40bGsZF3kEPGT7vyjPWub4e0Sx11jDvKT2QfvIjyGqROiMJVge6EME
	FY1Z7Lv+DF9snD998ApbYuBgzQuSE7LrPAg3/B6866TWltahu3hYESkPyh5t2MG/MZ+RK4F3UmX
	D2FYA2NlsE4oP
X-Received: by 2002:a05:701b:4552:20b0:176:2095:1ac4 with SMTP id a92af1059eb24-1a6ce01d7a7mr3181185c88.18.1793196153572;
        Wed, 28 Oct 2026 07:02:33 -0700 (PDT)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75c814917sm5857015c88.5.2026.10.28.07.02.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 07:02:31 -0700 (PDT)
Message-ID: <9dad5974-9c5d-42e6-9e5b-daa83f2b8b6e@kernel.dk>
Date: Wed, 28 Oct 2026 08:02:30 -0600
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
Subject: Re: Queued patches for 7.2-stable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable <stable@vger.kernel.org>
References: <42b54e88-8fd3-46d4-9cf4-cf28830cf089@kernel.dk>
 <2026102818-bazooka-smolder-122f@gregkh>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2026102818-bazooka-smolder-122f@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/28/26 7:57 AM, Greg Kroah-Hartman wrote:
> On Wed, Oct 28, 2026 at 07:53:02AM -0600, Jens Axboe wrote:
>> Hi,
>>
>> Like the 6.1 series, but for 7.2-stable.
>>
>> Please apply!
> 
> Where's my "YES!" button to pound in response to these?
> 
> thanks so much, I'll go queue them up now.

Hah thanks Greg, honestly these days this is just the easier
way to handle it, and then you can deliver a tested bundle and
get it out of your hair...

-- 
Jens Axboe

