Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793865507;
	b=02mtYIXmwi/R5Fi4ZPYeaMeMJ5UlJgcd4V86iE2UftXOB6KSjaKpLGNNqlas1lXK+9Bs
	 4D+hz3pzXkZWStj+4E/brhbGm0MR2EWFV2Y5gnpQ3D5R5I2CcPDF8f/yo0vw/vsOdzwKX
	 L8GKcNOTHLLpclCvQ6TvzBD/w9jtcKdg0JqdTp69GA9T5fbdRqonC6HZsjLCyWwI3E23V
	 AckRp2bDDd5BaE2v5ZCl+PMYoVxvOfJSlxpSBzRZj7rMrLIDQogyAzjRON/fKDLtIstdE
	 jcdi6Fb0ig1u4fKMLn/ycQL208Kxrg3yrPdKaqf9zcZwMhdSBNpLBX9QteF6jq4bqGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793865507;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9LcdG9WFpB5LuqvKh3Ca4mkyAaHpvvuN6mGaEVhMOmI=;
	b=U0QPp/zXTH20og0ujY/y9xBuq9xsE/MvwvTl7sWprpbFEz0s7x9qvvWlNQZbvF39Xmb1
	 2PWG0vg+dizSXuXT2PEv5Y6psAiAfebwtHhv51zOVeGKTmMbTuv3IUmk4jESe+iIuXb82
	 l09IZZOtmdrL7lXlHHfz7DJXcQqzDFjQs7ZNQvcxh0KEg8lzogUOpITkMv2OT7i9KkkkS
	 o1ibSFLk0f+s3J6QPCp7e6Vck5gzC2ohU0ApuLlSYIj+grQ3hwHayfdBDLY3+TIj1JLbS
	 CDIwm2RfGGlX6sgrf6rGW2X/Z3FvN3kXXHljuAYXrfeQkTMMNJZ3Yxs44iw7b9vhaGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="o/pAbmC4";
	arc=none smtp.remote-ip=209.85.167.54
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F4B606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 07:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63F4B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o/pAbmC4
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bfc3292d90so1193734e87.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 23:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793865506; x=1794470306; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9LcdG9WFpB5LuqvKh3Ca4mkyAaHpvvuN6mGaEVhMOmI=;
        b=o/pAbmC4focyiVC5jgdCvgOihIWOBGH/2ysTvIsTIJU15IsBrSezafjVdTY12EtNNS
         v0nb1JUSqdTGjHS/JYHqvfj2F5AIhqAOQnGNoeK6uu2I/XtZz2lqBVmLOLDHxyGr/f7M
         9fRSz3uK5e87b1fV5AaQqijHUPkrH4fxoCsBE044ktN97WVewpQ2GA6ra+gAVqai4b5A
         gAKodZw6VD+bLJTFkQYmcOpCsnHqwtSJpEr6rsErrvLol2eIcvz3wyhllxS237NzMtkb
         N8eH3ThuS/qsyqWEVegi+HlC1i/nV1Cd/Qh0MgDmsEv6r9KPpzSiyfIX4pS0+H6cCBJy
         P8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793865506; x=1794470306;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9LcdG9WFpB5LuqvKh3Ca4mkyAaHpvvuN6mGaEVhMOmI=;
        b=UlENn+tJ/Bna8/NyoOu0IioI7I/hVcd55cYYkp02rBnpmIYFpYx62tnUkhDGdDca1h
         DDqmp/fdhNLHXZ2hBGu1qAAIxzgjFPUiVB7VB+Xd5oPYq/tFIYsSiCXmXwR6uHXgowBl
         DU9LckzAMm8kmon70lv9z0LEWsUZ3gbnyLqqMH/1CXgDJfNMRgdfI4EOxMNYKisvHkV/
         BEjyFOLLNJeQPG1tFHbjWDlldMI6dNv+BxjhmJcxBl3K53yqNieO7HwpNxAwODCrPKIW
         nOlmxlK8liA1kuM1ZoeVCCXyXpKlT9l7rg2f1uqJ93R9WTlm90AOPaZumS0hI/IUkR7O
         AFJQ==
X-Gm-Message-State: APuU4Z8xKlc/aIsHtXLKZc3Oih1woM61ANbMVb8JGCAEwi+oCspyvO9p
	/OJ2LHQIoR4tjH/7zBu+KR7TSrphsgKDzc2/3WBX8A4ZUQ+Lkr1VMmX0NUlBEq/IeDk=
X-Gm-Gg: AYBFou3NRNx0D0nHv81Wtlh7NoCbQV6krOPPOi68osEFEaMHVvVCHZ3v9KC8Tvv4H64
	W9lPEuXaq1J7A+nDgSc7E9u0zcizfTpZnvGfNburFVgo/pZhhjlnAOp4oGiZZ3SeQY6WX7HlqUd
	qSqcWf++oRPDwSfuNmzdoUxfIBlPAH+QguzMf2xJT3hFnwo+u1q8EoMZvqb0eoIsW7SFayd2jvM
	F7LxteZU7BXVspcGc7H7FqxkR8JLCLtUymw9fcnrUMb8Wxy81OLmAq9eCmWExgADR4eo2KjVK7b
	LqSdHLwyCykQF8A1m+GQ3syzIixqk86jBIZPDDmfJM9iYkq6mYCcv2p4T4UkZMsfaf576gS7rtZ
	s3AvB81WC/HRhbh7Q4zryImIVnGGwbgtCvfMJ14t09zRl/luB0o0tpgwwjuULGeUmau3OYEMU2n
	tIwPc0EkaNvC7xPYfJyw7R9mv3tnxLr4kOBJlmQBLl/nXcw3iEBH7ieTZsmTBTWB5oFWOtILFLr
	Ttyv3ark2TL9Vc+6sLjqzxYIrTLno7FoULl3sZ4+uODijBhP+G8WxgKLSsyiENw8ZkpFjl92XeM
	CXMe5YJGcO2sG+3yg5v70G+7a4hKD1ihUWz56DwW9WKTSTEUb2x+Rz4W/eP9yd+e/dhq6zr1kdk
	sKxzB+pB+
X-Received: by 2002:a05:6512:a83:b0:5bf:fa79:9863 with SMTP id 2adb3069b0e04-5bffa799a9fmr455927e87.8.1793865505307;
        Wed, 04 Nov 2026 23:58:25 -0800 (PST)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bff384c97csm710105e87.5.2026.11.04.23.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2026 23:58:24 -0800 (PST)
Message-ID: <a99baee6-e494-4f8d-b82c-9dec66a25ffa@gmail.com>
Date: Thu, 5 Nov 2026 09:58:23 +0200
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
Subject: Re: [PATCH 01/10] regulator: irq_helpers: Clear caller handle in
 regulator_irq_helper_cancel()
To: Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Jiale Yao <yaojiale02@163.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261104182148.1176116-1-lee@kernel.org>
 <20261104182148.1176116-2-lee@kernel.org>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20261104182148.1176116-2-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/11/2026 20:20, Lee Jones wrote:
> regulator_irq_helper_cancel() is documented as clearing the caller's
> handle pointer upon return, and takes a void **handle parameter for
> that purpose.  Instead, it assigns NULL to the local pointer h before
> returning, leaving the caller with a dangling pointer to freed memory.
> 
> Dereference handle to clear the caller's pointer as intended.
> 
> Fixes: 7111c6d1b31b ("regulator: IRQ based event/error notification helpers")
> Closes: https://sashiko.dev/#/bug/linux-5c3d3b21-3823-4654-bf5d-85407c5fd05f
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>

Good catch! Thanks a lot :)

Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>

> ---
>   drivers/regulator/irq_helpers.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/irq_helpers.c b/drivers/regulator/irq_helpers.c
> index cdbd170d2b15..7b25eae667e3 100644
> --- a/drivers/regulator/irq_helpers.c
> +++ b/drivers/regulator/irq_helpers.c
> @@ -403,7 +403,7 @@ void regulator_irq_helper_cancel(void **handle)
>   				destroy_workqueue(h->wq);
>   		}
>   
> -		h = NULL;
> +		*handle = NULL;
>   	}
>   }
>   EXPORT_SYMBOL_GPL(regulator_irq_helper_cancel);


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~
