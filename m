Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793946078;
	b=coan5aD6DpcZgVeOqgYuhpSUEy4mTPXuGXDNGwIzvgiJogxyMZc+FNPeV/HOOHdam3wX
	 zDbdQSCcoykTebCt6qufVCtg8krGZsXoSmOlnYasLp3roK/A1aldgpUjmvbA7lPN2Dt0z
	 h/OmWkto/vNcRBzcOSdb/Al5xfKDmc/RK8KZsOmi1OHIqFcJ82b1d6eM5MJXAYAvuDsqh
	 URl8ZzoAvfPKWvPMNjgsFoEfOrywjajgX2KPkW0NItkq+DoG4LF8WWGNJ7BLWXorWomu1
	 Izso3Q816vTbD9t2NWxSyxEzYSMBNrPHLqdxQYZOPq3Zx9BhirQnbGxUiatwEWMnIRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793946078;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=YvrHetLWEaprA/YnNV90q7vlMXrIcclPCKoaaWze1Ho=;
	b=2TRk9tpHyoOw2m9e0z74ZWu24WkgpDFOUlWpmRkiwHptIqSyaPs22ipIgRGmSzeaZueZ
	 KKxwntXEumkSjXKK2BCHhwdkc/8NkpeZhl3HCrrB6p++2bcW2Y0fXVSJtaOOnEKhjd/L3
	 f5y11ullUVTah4FSXQrDwrPj7yA/xmoY17o38Hrq+X6x18x/I56F1VEbHPz8Mobeo8GGu
	 zmqK45cZAbzaUeDAh/UMj1JcSz7/Lq5Ghez1h3087qiviDfKDDzjdKCUdSdx7vnu52Dkv
	 oyV5kIKyY071T+cJJNUpYriHXPoI4+DUCaGEqt1apZjO3JvoI3jWfkNL6fXhsLCPFKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztXfG5sF;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E05606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 06:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39E05606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ztXfG5sF
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a2761c69fbso822075c88.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 22:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793946077; x=1794550877; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YvrHetLWEaprA/YnNV90q7vlMXrIcclPCKoaaWze1Ho=;
        b=ztXfG5sFYa1gDCb5MK7O5ODxZx8Ot7aqD6aVXhfrBu1YthxQeyeDTOngXQIekaFBk2
         ud2CFY8feYyphEMjTtSfr5ChFcnFoKwKgJOJ9IoHUMUu5y+fD4XMihHQPZARom98ADxw
         zof0ZO5DASe8RYakHHC0FZ99P7i8m23AzoMze8ud9Vc0QIt+kn3ovw/5/C0fovLF0BzX
         PWvrTGTy3oX+hw5ty9SNeDqCsElSTc80bTsnvR5gmjbCfYHPOKkrLBzQe4wh/3ThKtNr
         qd6oDnC6A1XwFDS5/i/eo5CZLm/rM8ORB3ZPnpnl7UbIEEgHhAqUb1rRy66BlXXkxbSZ
         BhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793946077; x=1794550877;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvrHetLWEaprA/YnNV90q7vlMXrIcclPCKoaaWze1Ho=;
        b=hH8ia165lZ5zblzbKqYcd8g5pTwRJxJRHAddhiiY5VavLxvrctS88lCSd1TYP22e9V
         GFhSZ3GE+RUn84BARG24cdHhlLD1b8eBLJwjuDSzn/Y41kgfMGDQhDMsowVx0eLFLkD9
         Ti2++e4/fcz1oQJb6NclcLEf+MVY68u0wnyoAUss6WDfS+JVtZ1ZL1TDxwCuvv7Ll8dU
         e0zNmj6S6OpTgDk0J9kx9Ebp7wOv7iIiUb258Q4DA0/YcGf7niYZulnkLlAsyrW1YauC
         iA9svpLrTSawhU1mN91h4xgkCBhjb+wS02xjQ2K8LHFASZ2hs3oko01deEuLBKt1Rz5B
         mJqw==
X-Forwarded-Encrypted: i=1; AKwUvBxRl4hevP1f5OVLaA++Uz3k26VkYlG6Na/kLzA7y3aCsyTyUHbsR0HnIKG+Z79U1uV+WRdi1vo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+XwK+ss+79vDJpwNkS886FFO4BjovU//KV4X01a8u7bWjUn8r/
	rBqYz778uC/CwnzRFKkGy48vOeFwnbrE//i3Jz7VtRhdZKa5GOc3ZdO+
X-Gm-Gg: AYBFou2WAHhD9mP4QBk0hpzHO7nirQLcAniDvdplu7enyyYJSc0iLI/4meNldebLAr9
	EIbaRGA5ios5kZncFUiDuoCPRmuHeG4Se2RM7/9nbwvXD7jTR4fTE2qGbbRgbaAdMc1HIhWaTHB
	NTch4i8XZBI0+iu8ctR3vruCudLpaK0plshWRO2FtgIz6jbOBOQW61W/FtQWDRfQWmjk5H5UiPS
	ODjvuUcOZfIv3XxDiqkGAywlFqnnF0f4IKxwVRJLtuTG0uxIZ/hm4fUSQJLwgMYhbf5R0f6SqzO
	mSJRWoLibs6eSzNpyUcgJmY6KiIe5Xz9kkJK73iJa79G4SEayk0CzvGWKzdd2REKQYnYX8FNUZh
	Eb/EyrzncDb6/vZoNxJ9OU20B1RtvyQzQxlze2zxmBqPM0h0Xl51Zamz+DELb4ChLksbP1Pb9NA
	sxKtI2L9m5+5ifroDVG/hrchpDwUdJNfPN/Xztv0oJnxRfYJj0OS35h1nSKwIO/sP9nh522b9mL
	M24sG7dTL1R1hra5C7eD2yJbj/97zcpc6V9vnSs+ivcUf2t7I/cXwoA8Bt1O/guBWe+H4MZQIlF
	NksGQNe5KtTR3aHcGr2RCXFA5J5bmSVVMTi61WhoPm9lgwa+CRjNUBJ4lt2ABLlftEWA
X-Received: by 2002:a05:7022:1582:b0:19b:1202:77f8 with SMTP id a92af1059eb24-1b25d3497e3mr2346370c88.32.1793946077182;
        Thu, 05 Nov 2026 22:21:17 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:64e:8358:c9cb:c17b])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4df114sm2890595c88.18.2026.11.05.22.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 22:21:16 -0800 (PST)
Date: Thu, 5 Nov 2026 22:21:13 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Markus Armbruster <armbru@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] Input: xen-kbdfront - bound the backend-supplied
 keycode
Message-ID: <au1xwKh4LVxHyUMW@google.com>
References: <20261106014957.4130059-1-guozh23@xiaopeng.com>
 <20261106020217.48481-1-guozh23@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106020217.48481-1-guozh23@xiaopeng.com>

On Fri, Nov 06, 2026 at 10:02:17AM +0800, Guo Zihao wrote:
> Keycodes arrive from the shared ring the backend writes:
> 
> 	if (test_bit(key->keycode, info->ptr->keybit)) {
> 		dev = info->ptr;
> 	} else if (test_bit(key->keycode, info->kbd->keybit)) {
> 		...
> 	} else {
> 		pr_warn("unhandled keycode 0x%x\n", key->keycode);
> 		return;
> 	}
> 
> The keycode is a plain u32 from the ring page, while the keybit
> bitmaps it is tested against are sized for the KEY_CNT keycode bits
> declared to the input core. A backend that sends a keycode at or
> above KEY_CNT makes test_bit() read past the bitmap to decide which
> device gets the event, and no keycode at or above KEY_MAX is a valid
> EV_KEY code in the first place.
> 
> Since the event sits in memory the backend keeps writing access to,
> the keycode must also be fetched exactly once: re-reading key->keycode
> after the bounds check would let a concurrent backend write feed an
> unchecked value to test_bit() and input_event(). Snapshot the keycode
> into a local variable with READ_ONCE() before validating it, and use
> the snapshot (as well as the already snapshotted pressed value)
> throughout.
> 
> Ignore keycodes the bitmaps cannot hold.
> 
> Fixes: 4ee36dc08e5c ("xen pvfb: Para-virtual framebuffer, keyboard and pointer driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>

Please explain your threat model.

Thanks.

-- 
Dmitry
