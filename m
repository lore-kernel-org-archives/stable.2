Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464783;
	b=Lj7oBpBVOlDdw0QwxL0VH0dt9fZ1yH8yGJZQsXBv5G7qxwxI7/5hjahC/oZyxuo7osPB
	 AlWDTTGC3/FBQti4o3M0uxyOX9D73uLWmEsmMWu1z6rx3nESOByUPEv8ehFueNm9Hl93c
	 dhQFSirQI8ly4uDzy//KKm8jN3mTLe+8IXF36pn1O5rJauoaPPHlRAXoLy7bKvKRpKQ4S
	 EJTjtcyG9VpAthS2UZ0zXnI09rvDvfHfi+fcOIkZV4PWO62GFmyiwLOEXfW2kPn6cK1Yo
	 HPldqtJA4qWGu+TuwzBX8nXKk1o4xRZ7Do5qZdXJs6B57fqdoRhj9aphnNTe8R1Q+fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464783;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=Vl+Jr3N/YEqz9NFVbM7G/TwPrthGUN0HgQHZE/6GVYs=;
	b=gGDfHKPeY2OUhlY2I7bR6z2RagzLzVuX+W5OWWaCsthFD2d0wGimf1EtPTT3n/KdSsCg
	 gQWpH+uuGtG4v+7unmgcYayPoAXfjWC6cJ5qNty/AvZp4li2oD9Tg69mS6Ei87KkXKM0h
	 2EcPrMK5MTamIiD24hFTXF/7PDMGB/EXVGH1iSTqb5tRIFaXq8TMbfAfjD0q649ChN0ZH
	 C3oR8RXxOyu9jTZHjnSTwpQJhty1CwngjIAFrfWIfi6WhgZ+Qt5vzsy/SLx6lGcO0S52E
	 3C9SKGTwwkkHZjpVbuYTenr4vVVOXZWB8VZIaI3DwmqlbK2vgfwDVeCcts7yP8EuFRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBwGTjYq;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420B0606A326
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:13:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 420B0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XBwGTjYq
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1a2761c69fbso2875747c88.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795464782; x=1796069582; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Vl+Jr3N/YEqz9NFVbM7G/TwPrthGUN0HgQHZE/6GVYs=;
        b=XBwGTjYqQTUhH8gOOPo7XYWKULuUQj/EpvbNDliWDwCiUoZljy6hipnGBLvu6Cnf5I
         QB4eBs8VRrzDPEFIyfvnEECbj62cghj/ipTuo/74QHstzb5WBVfWu4m02MzsNJkRGKvI
         SL8fcrbPP0dhsR+7166QGff/5/sQV76QwiPZ7j97puU4qusj2tHix5UXAB3PKH0FfvdF
         VB7kwwzfXflu7ZjkINak8Hp7mvsdVxjbRWKOPxeP6S6R2nC5D+bm4l+C8kc5KUkVw6fN
         cK8+myDOVOK7fbti9aE2nqTQHnvbOopkfcQ73z56fwYLjpAI07pa3Vv+0MfVvQC4YUsN
         YlFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795464782; x=1796069582;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Vl+Jr3N/YEqz9NFVbM7G/TwPrthGUN0HgQHZE/6GVYs=;
        b=FBqbQAdM91AEx5ijUbBguaC5N91ypU85ZclfSSDikRMm6ugQord4vpKH59iHHHtt45
         gTiMQJyWHT32Y+ajuDk5G0OXzXlRc+K0L9JZPhxIO+VkKHXa99JUvQTuIOygECwkVevi
         lM8y9VHZRnQXb4UZdnJ3CYDa0bC909ih9eje3Znj8OENvn7AXURcOGmbCZ3vaczdm/4z
         GyGILIZ9BUYw0CmyStC0JG8n0MJpWHh+5UkRAISBWF7zrcqINdUG2cZGKhPgDq0FG6ii
         g9+dyY5AYbeWGgnoOVVRRX8pbVwgAJzAjN72EsXBFPdYhRDBmdHNOs4R0fkhPcY6z2Ml
         uT/g==
X-Forwarded-Encrypted: i=1; AL+hErHmJJ1uuhurxNN4AuXUewuzomNRuuL/L2X1yW0wuFEZnbA4aQG1i0s9pV3LgHui75c4+2rjSZM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Pck4O11iNRjl1xnmurHsD7PeHZHJEGbq4BmHUQi28IxH+hcD3
	Xtzp/hyLWLYP6jnoN3GbBMIsq5vCqFWhHhzx0hIvzvwsDAu0SLnaWcLL
X-Gm-Gg: AZFdTZf91ReP9WFhy768BrLQ6AK6BDK2EB4s7z49WFRIHcTl9idyJme+E/vBV3jfPMP
	k9cR2F4IKjfVcdYG0DCkAFpiRnqNuzkbssIX47Z1evuzqfwcruY2LbvRnnUO7VFaFeVW3B+GpGW
	Zs+WSTlgefODtU7SbVGhSpadwD4N1jrSTYKpavYVeg4MV3GDTwNZUGvyS0tGZggLGJbhKxKfIhv
	C3aa9w1xHv22rg4BuCt9oCDnBiuB97667m3BtoCZ+028jLLzvf9Gr4NdNMFJzoB8jK94l9J0sFV
	ZvYltQgtiR3P+aDiGBXRC+J9pgoeH+ldtBvxWzGFPGev2/LPnZNLfvHbZWhiWCBvjteCLGiaSk9
	r0m5NirMPfUJTH//3rBjuHnPgLJ58G/P9/rkxKIcwjHd32GYyY0QEZw7hm8YjyfqV3hKB4/66sS
	y/wa8O6JZ42TuWq0FZRMrdxn40iumm88jR+4JYeiqORblGdSChbzFoh8/msb7S/hM35P3vVbuSL
	NjGpkHFDDaeT4Qu3Fo8F9nucKbewNt5kCnhHg26Hr/OnSPQbvh88xQxl5AadUYbvlOrJkJCpODP
	eLmEv5qwiq268OsNHH3BIOBM7+xo3yzrFrbtUfGsqh3ssA25J8FVlVUZ1SZZL3MpVTdIdHs=
X-Received: by 2002:a05:7022:e80e:b0:1ab:de8b:5f0f with SMTP id a92af1059eb24-1b556924b07mr13875087c88.40.1795464782093;
        Mon, 23 Nov 2026 12:13:02 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:4121:d698:201c:9274])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556847fdasm34059654c88.13.2026.11.23.12.13.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 12:13:01 -0800 (PST)
Date: Mon, 23 Nov 2026 12:12:58 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Lee Jones <lee@kernel.org>
Cc: Marek Vasut <marek.vasut@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	Linus Walleij <linusw@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 01/10] Input: matrix_keypad - validate GPIO counts
 against matrix limits
Message-ID: <awSdwBnT5bk_BS-G@google.com>
References: <20261123183200.3900004-1-lee@kernel.org>
 <20261123183200.3900004-2-lee@kernel.org>
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
In-Reply-To: <20261123183200.3900004-2-lee@kernel.org>

On Mon, Nov 23, 2026 at 06:31:07PM +0000, Lee Jones wrote:
> matrix_keypad_init_gpio() obtains the row and column GPIO counts via
> gpiod_count() and only checks for negative error codes before storing
> them in keypad->num_row_gpios and keypad->num_col_gpios.
> 
> If firmware supplies more than MATRIX_MAX_ROWS (32) row GPIOs or
> MATRIX_MAX_COLS (32) column GPIOs, the setup loops write past the fixed
> row_gpios, col_gpios, and row_irqs arrays inside struct matrix_keypad,
> and matrix_keypad_scan() overflows the stack-allocated new_state array.
> Conversely, a zero count causes get_count_order() to return -1, leading
> to an undefined shift when computing row_shift.
> 
> Reject non-positive GPIO counts as well as counts exceeding
> MATRIX_MAX_ROWS or MATRIX_MAX_COLS, and size col_gpios with
> MATRIX_MAX_COLS for consistency.
> 
> Fixes: 584bf366f8fa ("Input: matrix_keypad - switch to gpiod API and generic device properties")
> Closes: https://sashiko.dev/#/bug/linux-ed4b89af-6c76-4e5f-b140-fb2b107b12d0
> Cc: stable@vger.kernel.org

We trust DT somewhat so I do not think this needs to be in stable.

> Signed-off-by: Lee Jones <lee@kernel.org>
> ---
>  drivers/input/keyboard/matrix_keypad.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
> index 11018382e84e..c2f839a3de90 100644
> --- a/drivers/input/keyboard/matrix_keypad.c
> +++ b/drivers/input/keyboard/matrix_keypad.c
> @@ -33,7 +33,7 @@ struct matrix_keypad {
>  	struct gpio_desc *row_gpios[MATRIX_MAX_ROWS];
>  	unsigned int num_row_gpios;
>  
> -	struct gpio_desc *col_gpios[MATRIX_MAX_ROWS];
> +	struct gpio_desc *col_gpios[MATRIX_MAX_COLS];

Luckily they are the same...

>  	unsigned int num_col_gpios;
>  
>  	unsigned int row_irqs[MATRIX_MAX_ROWS];
> @@ -302,11 +302,16 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
>  
>  	nrow = gpiod_count(&pdev->dev, "row");
>  	ncol = gpiod_count(&pdev->dev, "col");
> -	if (nrow < 0 || ncol < 0) {
> +	if (nrow <= 0 || ncol <= 0) {

gpiod_count() never returns 0. It's either positive, or -ENOENT.

>  		dev_err(&pdev->dev, "missing row or column GPIOs\n");
>  		return -EINVAL;
>  	}
>  
> +	if (nrow > MATRIX_MAX_ROWS || ncol > MATRIX_MAX_COLS) {
> +		dev_err(&pdev->dev, "too many row or column GPIOs\n");
> +		return -EINVAL;
> +	}
> +
>  	keypad->num_row_gpios = nrow;
>  	keypad->num_col_gpios = ncol;
>  

Thanks.

-- 
Dmitry
