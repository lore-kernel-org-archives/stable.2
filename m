Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794563572;
	b=Hjdvi+teVqu31YDDAeH3AMpRAPq9NQJuTMJ7eL/fmHu9DO6toU+MkSWVYpqoSZtaIzIO
	 3Vz84icP4hOVDN3yXn6KZhwW/d8LyNkYhC9oz6o9nQYFQBamd+NzkTajMZFIHdcx1VKb0
	 CtoBRD/ctHMwLA6RN6ZSQxDBPpl4K1b6sNMZPMTkOIntqK99w5EcVaDBj7UATdMXN/fa9
	 i7UPIBlQdQZ3ki8wwcnBAWkZSgX9kbntJwEQNiLBHdNhk1KxnofBZvpWaBAv86ApZAFKP
	 qz8v8R/yzaBxNP4CIdFUo4ohb7zhYyQHsmtDE8TLohxftLIe6rtlCXKdkmxNsuSmChg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794563572;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=AnA7uJSI+FmP/SSTgnturLYsnYlMVsJF1Sce6mnuOt8=;
	b=GX0bJGVauo0aQQiu2PP54ExCtI+V5DGi8S9NDBs5EbKXTbo9R8DBH6hMGTQTLjpTY4+l
	 Q3vU8b5FrQfu1ndS5fbcz0CdGa7K7nh5IEsPsqgbti8lDsEunrr/SQWSk17Uc0V03QnQ8
	 2b+VQ9XiRWQ+DbH8J/k+RPxnbKb/gXys1xgEbrA2MZ7yQY43CUBMfEo8B/uO3m75H0CKb
	 A5Abj2Zxgh4X83Os2U/4lNpQzPVNQA+/22Q241qgV2HY0thyO7v4C6TqVvWWAs+9T5f44
	 8POj8ZfMO2IRKwvFPKx869rIYkG9ACpG4l8aZ04XwFliuZmjXQ1xFwaN2D4dIkXehpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLsknzkb;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EA8606A32A
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1EA8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tLsknzkb
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ae1b34e0d2so1008552a91.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794563571; x=1795168371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AnA7uJSI+FmP/SSTgnturLYsnYlMVsJF1Sce6mnuOt8=;
        b=tLsknzkboX6RUWtslnAEiq5fjDbk9Ajab50yczQsFiX2aq46Vq4RrbvlrzoOm5q9Ls
         IZHdI9Ia2NJmFEZ0zhaSp8+YMWvqUd86TjgDw/QwA6NX12Una9hfb7HJ8T6q8kuh6p38
         izxnDvrK1jgNSRd5cq84BBhoKIBWlF9ro+YAKXynL2B8P7cXrRIJ+gfL3qqUj5VCguEn
         wZAVshwUqAZzCeKJtNb9JHqrY8q4fUf5V/iftMm/xhpENOouA8P8P4itkG26sge0ykiq
         zrkSR5siyd2gubX+w8DjYCm1noEm43VKG9LEGQ6M6Lj94qOx8rvyeLvo/0goNXr5auFu
         wjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794563571; x=1795168371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AnA7uJSI+FmP/SSTgnturLYsnYlMVsJF1Sce6mnuOt8=;
        b=IsK48rrs/hGRCYq/yLZpVHEg7gIvteVKtAsdZQmwFpjiH/W7l/87r88cmBoX1LQFpO
         q0l4RjLmLtPNjBzLBKNC/k3QN0VbWwEwgQ9JRMb4Ud3rXYS3dEkR7yyow2CocsDMGymp
         edZmY1JIAqiRJrNriTD6EE4ZxYlB1tRs7Y8NtK4+S7s+Er++iZpLnFcf3uirBUYGGf3v
         pHmN9kKsygFLplCU/4YPkhs++ekamkssyQ3fazYUpwV1TnRfGtVbFYiyahm3zDH8T6aN
         FJzqauug7kxcz/HYcuVw3cpvINvPkjNNtb9Dat7xgp5Xu7FD7aiWjT09V52L0hddnuTp
         hGRg==
X-Forwarded-Encrypted: i=1; AL+hErFM/prqLy5pdL2hQiPg9ODCC+E1IvYu3Xs8jiOYLGBnlM+3nkeg9B//UCV8ni1auiHLQtnzjIM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZK3Z5uRu07LgfVRruJ7kwsc93K33Q2178OwceGPmiOpoUnt9Q
	G5+y79XtDSrusdXxjvHU/Lytl9dFczG7lebEnDm8AknQHFJqg3riB3K5ZZb0mA==
X-Gm-Gg: AYBFou0/afjSyEDHBcJabtuF0KUuiaeg/LF+Q+6XdN3F8NjgTIvru9JH6Jbph/DMKYx
	zwgbpSkD9HbIpCroZHlhXoC8zQjxsGNLCzFnTATnru9O74dCX3rKfPzfcsI0b3d51dWRTaVdRHo
	pxm3+8pLE9wlWPKISup2E1vo0xXi0448H81zA10+8SzMVHp8LeY+DtH4LSg9CoB2DgLXW4NH3sn
	UiQOr6hy3fKzagnsYUsiWx8x2Z846L+9lEa/qtpD02heJ/PYroETv2n1ow43KGUD+PWl6FYjZJM
	FUuSw7ME+9207sPPNLRh28UgvpeEFKnOmSyBC2dnzX18oOVS7Hwuab92FfH9dlZk3XWZsC3NtrA
	wLxvkY0Uuie7X2u59o+Is0/YRoY32X0JGYoC2bKWwaQ2katTOKATs5dbntVAoxNx4xi3uLniDeW
	NPpYPY0t8/RDoRwtWmqjObOdmkT+NsKAd+Unq+n5DrNiSEpR6oTSJ33A3OUOxkeIQvxnzlwjJvS
	oYtgstf9Vza7fl4qb8/ZPTsOfV6i5MPnKmCnXrhPoPCz/YfSzXBU4xT5r7ukh9bz0e5JYVSfLFz
	aI+mYJSH4goj9RkgkXMlf57+BH9/hgNUrQijCasLA6x7Tbu9Bg==
X-Received: by 2002:a17:90b:5687:b0:3a8:337d:228a with SMTP id 98e67ed59e1d1-3b1b087c04bmr1164575a91.6.1794563571127;
        Fri, 13 Nov 2026 01:52:51 -0800 (PST)
Received: from rigel (106-68-220-184.tpgi.com.au. [106.68.220.184])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1ae981c55sm3893709a91.1.2026.11.13.01.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 01:52:50 -0800 (PST)
Date: Fri, 13 Nov 2026 17:52:43 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Adrian Ambrozewicz <aambrozewicz@nvidia.com>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v3 0/5] gpiolib: improve concurrent access to the flags
 field of struct gpio_desc
Message-ID: <20261113095243.GA103672@rigel>
References: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>
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
In-Reply-To: <20261110-gpio-desc-flags-atomic-v3-0-2f463bce8086@oss.qualcomm.com>

On Tue, Nov 10, 2026 at 02:47:00PM +0100, Bartosz Golaszewski wrote:
> This is a follow-up to our discussion[1] about desc->flags and possible
> races with users who don't/can't synchronize with other means.
> 
> It's an attempt to use try_cmpxchg() to update only the required flags
> atomically where needed + minor fixes using atomic variants of bitops
> where it makes sense.
> 
> [1] https://lore.kernel.org/all/20261015153714.GA105746@rigel/
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
> Changes in v3:
> - Don't pull in bitops.h when including bitmap.h
> - Improve coding style: fix indentation, set mask later in the function,
>   make lines longer and more readable
> - Use the right Fixes tags
> - Link to v2: https://patch.msgid.link/20261109-gpio-desc-flags-atomic-v2-0-c4c54b476628@oss.qualcomm.com
> 
> Changes in v2:
> - Drop the custom gpiod_update_flags() function and use the existing
>   set_mask_bits() macro instead
> - Add a patch clearing debounce_period_us before GPIOD_FLAG_REQUESTED as
>   suggested by Kent
> - Rename the functions updating flags in gpiolib-cdev.c
> - Don't rename the flags variable
> - Link to v1: https://patch.msgid.link/20261104-gpio-desc-flags-atomic-v1-0-e23cedf619ba@oss.qualcomm.com
> 
> ---
> Bartosz Golaszewski (5):
>       gpiolib: don't overwrite the entire flags field in gpiod_get_direction()
>       gpio: shared: use atomic set_bit() for descriptor flags
>       gpiolib: clear debounce period before the "requested" flag
>       gpiolib: don't overwrite the entire flags field in gpiod_free_commit()
>       gpio: cdev: don't overwrite the whole flags field when configuring lines
> 
>  drivers/gpio/gpiolib-cdev.c   | 93 +++++++++++++++++++++----------------------
>  drivers/gpio/gpiolib-shared.c |  5 +--
>  drivers/gpio/gpiolib.c        | 35 ++++++++--------
>  3 files changed, 65 insertions(+), 68 deletions(-)
> ---
> base-commit: 630059a5a632377b9b7b487baccde92b7ae1dd47
> change-id: 20261104-gpio-desc-flags-atomic-cc963a1ccfd0
> 
> Best regards,
> -- 
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 

Reviewed-by: Kent Gibson <warthog618@gmail.com>

Cheers,
Kent.
