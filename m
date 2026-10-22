Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792696839;
	b=pCE0q23ZOWiIBSB/7jpI6GOY66azOrKkCBm4/4N07989bMJM+q3bnw4xtGo+2/kB/abQ
	 uJ+UzWMikGK0rsRuQAgXYS78k7x0MrLCCkrf9GdoWGEZqmHnbYpwOfiT3XDvjeajlKuHr
	 P9woutrWo9LC9FICVfCUdORKhNm5OZgs19t/fRLiPCl59YsFxUAk9Urt5IocxE8ZxGK77
	 INxKPfZChPdD5gwUIpFCjVgNq+96fm6BEs80wE36CUsOR/LQv13jCRbCOhSZXhsaxERjX
	 U8j3xKQAco6W0gt/ITKo4IEBY2p+pZq3o/vwoUGE+6EK6ZWnKOQGTucBinYVRjPucww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792696839;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=9sXkOvf7AxrvAAH1/YNkURKgzHX7Y0lOYp7pZGB9twE=;
	b=UsQnyzhz/YyBy33J3P93nOh/qhjFuWjpO/hp1uDM9IzTzrqX3d9dUKt5thyW81neNYFP
	 DixJRYSMmwedTNqHNqVnS2DkiXwWUQNiPUG6khw1cJtMl3zrDn90Aa9GhVkIlLs+QvKX6
	 ns45JGXbV80+RZPTC02kwUmVHmFXW+AECCmWaceQLJ5KaKqETFg3Ad8RHqmwfpwchWwuG
	 iDFMqrVBchVJiwUMf/i0FjWjUfPkJpvuqed5H8aVUFLSVGr/Pn8wJ/a6HtooDGqMyL21h
	 kddR+7VERmfhYc7MfkmfG1bCAKGJHPl67lnbCF+MQwU+lEP1ZbNIxO2tr8WrbVgc3QA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RhEpnE+1;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292C606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 19:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5292C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RhEpnE+1
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b21cf1a580so91132a12.1
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 12:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792696837; x=1793301637; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9sXkOvf7AxrvAAH1/YNkURKgzHX7Y0lOYp7pZGB9twE=;
        b=RhEpnE+1jUnYlqv7JiGI+cVLv0LAbRqOGEjDHl+SzzNNqELp3BCGQMTTtkgrVV3sGl
         EFu4BCg+awMIqSrV39O77g2wInCTCrcBhkIjy0jDRVtvvIGkUBfHrA9RQ60mPXoMgadW
         ++gt39oScXT2O6apkAxfTnmB9uKAJWi5IC2NaVHRKSqz2CXsM2nyCcjU0TwiFPHwe6MH
         y0T2ETNBajdsd7ISMCyCFyNHHC18XZ+r+d1l9jE2k2ZkiJXu2/Jr2MsniWUCdPbIRci1
         QZ6s/cvamcXw/xg/Dc28xFpzsZr0b3ZAVkTclEmnqNGmro07X6tHoGCdMbjrYQ9HIXQl
         JTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792696837; x=1793301637;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9sXkOvf7AxrvAAH1/YNkURKgzHX7Y0lOYp7pZGB9twE=;
        b=iyyj4mIGYnI6D91kKiDY6aSsaZF68PCL+v9V1anK8ToF9xb0g0wU1yZCp9+wsfcC+8
         420+x8puh0fCw5V1oJeUC6rI1kAnJo8mCaD6Bwkwf0yn90T7k8Bm4Nqs/YJ/gwyZuS86
         +r7IC8BcocCpctiYVOTRSzBXoHpWltG5tSSbTbxx5l1x93tChZEH/Ia8i/THXSNMfYsu
         JFYwdt+KVKQgSCsDx0EemgNnY8Hk1rs9ys9bazCK/HI3fYbxz5E3KaftFYm6LPVzBDJQ
         YkMr9pE/Xlj/jmdWjRmjiWtclh4dgTrkxDOwMJsBmJFD/Ndc5TzS/w54NKs4w8MkeMj8
         bsRA==
X-Gm-Message-State: AFq9FYLTzR2hrjDu3TPs/fu5R4JJvFNJqt5PUGE5a22s24L16HhMdb5a
	E1AgP/xpkz7/GBGfVKKpWMfBqYHySgbn7yp4SWAjUsdXWMR3EI3jngI5
X-Gm-Gg: AYBFou23qO3izlxZIMmtke08kZ/oUBEDf6nYigoBtXYUs0t7ieNsNtujMrGVxehaYqi
	O5d11xVXo0f9dwA1tVdwInMo5sWhOnR87Eb9U09cTWlJu9d/AbXZqgd1ig4wscuSF+/UKbvC0Ty
	j4W/jlgiRztgNCsBbNs9tKK8uTznPr5JbMh1m1md3CJSha7F0OftGvQsYEYnofrHrPW6jwTNJyF
	e4y4JqNC8ERLql88kjBYZxdnfjyR2Al0a6mHUvZAmLlrxIXeNvlgedQIk5PTuQBlgFN8mdUGGFz
	nXWyy1lYsZ8QqsyXQutK5FjBmNnQxmFW8eoiDG9bEx7+Up5vycSxMnrgDAx+mEWW3hoEDv/MBg0
	PaX9JOooCoRMt+I5AbEMoGpLRkqlo0SEW7fEEcI36CW0V16FrW0LGjqb6zo1Eu3MCLHk1X22ce4
	L6CDrXSji8xa7M+1xJZ0y17GVdB5oL99toGuqQuxq7jDlTz/mHiFwuUYcBBdXB2GEYL9rl0p+Na
	8X0eOkB//ywU8bGCns6abe0Raq/YULelrS12XRTIMYtP2/EDpzNCoExL3TMXkORPXo=
X-Received: by 2002:a17:907:db15:b0:c3f:4d1:8cd7 with SMTP id a640c23a62f3a-c46a92afc93mr21950366b.25.1792696836432;
        Thu, 22 Oct 2026 12:20:36 -0700 (PDT)
Received: from [192.168.0.193] ([194.183.54.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46a5cadf1esm20266066b.53.2026.10.22.12.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 12:20:35 -0700 (PDT)
Message-ID: <e44c1fc2-802e-4cd6-8359-a315bda970e6@gmail.com>
Date: Thu, 22 Oct 2026 21:20:34 +0200
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
Subject: Re: [PATCH 14/21] leds: flash: Avoid divide-by-zero in
 led_clamp_align()
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Dmitry Antipov <dmantipov@yandex.ru>,
 Jacek Anaszewski <j.anaszewski@samsung.com>, Bryan Wu <cooloney@gmail.com>,
 Kyungmin Park <kyungmin.park@samsung.com>, linux-leds@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261021123406.3163547-1-lee@kernel.org>
 <20261021123406.3163547-15-lee@kernel.org>
Content-Language: en-US
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
In-Reply-To: <20261021123406.3163547-15-lee@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lee,

On 10/21/26 2:32 PM, Lee Jones wrote:
> If a flash LED driver leaves a setting's step size as zero, writing to
> the corresponding sysfs attribute invokes led_clamp_align() and triggers
> an integer division by zero when aligning the offset to s->step.
> 
> Clamp s->val to [s->min, s->max] and return early when s->step is zero.
> 
> Fixes: 7aea8389a77a ("leds: Add LED Flash class extension to the LED subsystem")
> Closes: https://sashiko.dev/#/bug/linux-9d06d7fe-310b-4aee-8b16-0fb49550c287
> Cc: stable@vger.kernel.org
> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>   drivers/leds/led-class-flash.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/leds/led-class-flash.c b/drivers/leds/led-class-flash.c
> index 181dfd49c6ad..16b3b6b9365b 100644
> --- a/drivers/leds/led-class-flash.c
> +++ b/drivers/leds/led-class-flash.c
> @@ -375,6 +375,11 @@ static void led_clamp_align(struct led_flash_setting *s)
>   {
>   	u32 v, offset;
>   
> +	if (!s->step) {
> +		s->val = clamp(s->val, s->min, s->max);
> +		return;
> +	}
> +
>   	v = s->val + s->step / 2;
>   	v = clamp(v, s->min, s->max);
>   	offset = v - s->min;


Reviewed-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>

-- 
Best regards,
Jacek Anaszewski

