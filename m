Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.201
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638091;
	b=k2OPxZ0+3Saerq/mWJTJCsIxXMJtpWthe2LUaOTZ5907KCyeyWVMgjhLVmTqlowxVzo4
	 3HZey8ireHGaKFzqJjinUpP+1Vf9o5xV8Wdykmbe1wHEgSh6H+z18B0B4YbMZoEUR3sgM
	 yzODsL/SBbeEUcy+2KuGKJpANZpm0rLPBE1a5zyp06a8lCcAzR4Ef21hKHvmvogN7Lsnx
	 BSji5sL5UzZL8ZCOzUPF76nbWEzSsyGGzNsAp92Fve37iP1qDANAV9lT2w5Fj7RmiewrH
	 h1rzj1j7056AFYYb4frREOhRIcDFB2qBjWjT3Fdez+bYzhPFb/k6BWRSzaqN6ZLRqRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638091;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Z7VS6al0JzZMFGXrqJsbyoWOE59PZK4uhHY6gGIKbAw=;
	b=id8Fi3htrfwXnaIWWoCmJR7kRLtQaFB9EB3un/1IkE0uzjmeftQc1iInp1Kw+U+Wgmpm
	 XIndieedBZgbbvFYwW+fgfI08ajaibznW1q6hQOdBLxRnQ+sF2zj1guXZJeKpDCHIZ2Ip
	 kbaDTeGWr5ovY4OoCnrQ6MF2lJQYRHJ0TuECCHh7YxUAD104cCK9xiL+1Pzvnbn/UsXxo
	 eVnTRqHIQwYxVolcw0oEft1JQMJkhsnwNOuYwfKRJ+i++RYb4mrnkTZJXNnNQxrB/ONJ/
	 3/DcH3f/XdCg/SAzldCH8WjCZGGWx65AEKdISTBCQYdJExRXPbaCkQWvGJMHWBHy1BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIrKkQdH;
	arc=none smtp.remote-ip=74.125.231.201
Received: from mail-oi2-f9.google.com (mail-oi2-f9.google.com [74.125.231.201])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6FD606B0EF
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 16:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A6FD606B0EF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OIrKkQdH
Received: by mail-oi2-f9.google.com with SMTP id 5614622812f47-4f47feb5a15so589516b6e.1
        for <stable@vger.kernel.org>; Mon, 02 Nov 2026 08:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793638090; x=1794242890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z7VS6al0JzZMFGXrqJsbyoWOE59PZK4uhHY6gGIKbAw=;
        b=OIrKkQdHg8imsBqMl/+qEQYyMtw/THLGUi75tT52k+NWmj7srcUIaq9Y24tajRC/KZ
         fnM20P+QtC4Y06hDbFvcLxAxVIYB+WTUfuHPVdYumkwqlGk572TrzlYpRmmkypyaq+tt
         cxPzHUpY6Kn6yb788Qz2H+fh1vjYxgDdXsk6sTktX60X0m26/kMdA0Xmd6vGopDdMRis
         jGsl+/cHPuZovGvek1+SdnEH8HVLDgqq57x1Igk7fdgnYSZ8mTV/dOEcKk9rISGOEkBV
         awtYuMMd9x4dx6FqvBOVMNynTcgnyYOwldGDPFv5Dofz3EqzKFuDq26EgAxHCeScaUEg
         oCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793638090; x=1794242890;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z7VS6al0JzZMFGXrqJsbyoWOE59PZK4uhHY6gGIKbAw=;
        b=nEL1SVHc+n153vkqaZn6iauanrzWtR+kzCeI+9+XF1nragbbR9xG1WlUHrhDB4NdXk
         akn0+0aKIiD+0/XemO8Jp7k5x87yjXuD8K+f13ufoUB1+5t8+G3qhqH1XMYGpFsTv269
         CtnAfNEezCLShECPkkoqzwevYyR5jKKVC+APrR6tP3U51ZcrkC5qJY07RuPDeinV4YbE
         HXWwFlRj+xfMOVJXAQ8GbBklIodvDwyRIICCPKkziKk107YeydQdp5y2fMKzLa4IHzcq
         zNby7thhXAEYose1R1NhQrtfmKBBVCNhP93ln9gBVNHKvKzuhNP14tpyyIX+vUwzaT8V
         PDSA==
X-Forwarded-Encrypted: i=1; AKwUvBzHZLxQTblGKadzRVNMVq15dDW/G67uuQ32qn+lNyMilosqe4WTiNhUh6f5huy21Ok7P6VFZLI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYWt373xfPf5WdMaomTLBMR0g+TMmgM49wLsle0wWq4vLGxwE+
	6aWkQhORuSmxM5/d1Sk8t4+NC2+xqsNQMf7avN9cmsmzFT1LU+6j1xSb
X-Gm-Gg: AYBFou35bhPtvtZE1M5YSyGekTgl/C4EAqX07VisKHmaSeNFoKLM3V84C44Zp37sGyo
	FPn9KZbEauc36Ut/BX5q/8+EX7laEIj7Vn8vDpnzsG66poHaS9o66NqzcaTXuZYW7BpNcjhh/TN
	DXOZB0UrLOixL2fgX5Bopkm5Tl2zdCZOErtvG/eM0xpHtm9ijTmGHdY5bj3g8ckTi6yDn8HuQg6
	riFeamhGjLrnHIEB/D1fnTb2Kz0A2htzNOxauNGeMg5QGYVloVP16iFnuZHZuOtrauFNni8wcc/
	WD4KGsrrNYVhtt9h7/FDBncjtQgXMIkXrgukIvDErl8p6vrUpQrAdkKIOzt2aesDTzQ6++gaLmy
	HFFODv3tVLSaNuOtfQkhcWO7SazLfAOwDWsSkBVOG9Scxy8RZPvIxviz+RuxcpYnUDGzeUTTvi8
	bBD0+dUNsgFYYnpJ7vuimO2lI2mmK/uBYJn4DZoMf6uC7q1DYxcdk4VQh95ylaGG99FLo6ywoqs
	wl1Oae1NkhzD5HGm5REgEuQSwZOHyn1ZllpqV0BzWIpgJprxZw5bHik3bRQtMj0cdSFOHPF7VSD
	TNaMrPeOwN6ZADDWM++MDyy2eCWM4vxqlqge4UfBsQuXdBMhhMFmpIq+SnB2/vff9LlXJIsXisW
	Vmuo68G0hrq/wvR+Mh0Hc
X-Received: by 2002:a05:6808:c232:b0:4cb:ae51:5971 with SMTP id 5614622812f47-5640ddade81mr7293574b6e.32.1793638090243;
        Mon, 02 Nov 2026 08:48:10 -0800 (PST)
Received: from [10.10.121.179] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a92167b03csm6972479fac.2.2026.11.02.08.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Nov 2026 08:48:09 -0800 (PST)
Message-ID: <74880003-29c9-4f8e-a7b8-b5ecce9d4230@gmail.com>
Date: Mon, 2 Nov 2026 10:48:08 -0600
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
Subject: Re: [PATCH v3 1/4] drm/imagination: don't gate the runtime PM
 callbacks on drm_dev_enter()
To: Gyeyoung Baek <gye976@gmail.com>
Cc: Alessio Belle <alessio.belle@imgtec.com>,
 Luigi Santivetti <luigi.santivetti@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-0-674b907d0652@gmail.com>
 <20260913-rbrue-suez-upstreaming-pvr-suspend-gpu-system-sleep-v3-1-674b907d0652@gmail.com>
 <CAKbEznugM-HxPxHwZ7RxC2iLC0TDH0qi9649hWATiPYXF+urfw@mail.gmail.com>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <CAKbEznugM-HxPxHwZ7RxC2iLC0TDH0qi9649hWATiPYXF+urfw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Gyeyoung,

On 10/12/26 10:43 PM, Gyeyoung Baek wrote:
> 'lost' looks protected by reset_sem, but it's read here without the
> lock. Shouldn't this at least be READ_ONCE()?
Thanks for looking, you're right. Lost isn't fully covered by reset_sem 
anyway, as pvr_mmu_flush_exec() marks the device lost without it, and 
the watchdog worker already reads it unlocked. I'll make it a 
READ_ONCE(), with a matching WRITE_ONCE() in pvr_device_lost() in the 
next revision.

Thanks again,
Ryan Brue
