Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CFF25A2A4
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 07:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785999680; cv=none; b=aUnvy5L5AZW6da4m7FWG9fSqd/FJ+wUEVDyWAqwxyh1i0nT9VnH0qxc3OI1FEDdUA8+vuNxhBbJdJVN/QZIfz0WLQsmUxWYmiEk9igYu808qT9Wp4pL3AGlJsp9QfLB2TnaNzpJ1/cF6I1gtbQwF+2/OvdDXBJAWoDqdF8VGck8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785999680; c=relaxed/simple;
	bh=FUr7+8XCM9C5LQXFrSAbnj32rYDp2mpjf3Wil/NUWOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nzjtXkHUV3jJT9AYIv9Ww+EanhCAeBP/ghwzS/6jUakk7F61quu01dl4nOvGJF+C4u/4AE8lSggSGBCp5T5YUMwEXz5zoBDUlFlpy7BBqGtjgeNCM72eIkoBs8xfwVoGXi9lS6Otfb4sRQz7SmIQqeJcHffSK1/vsIdY5LAfdHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fPfppkF8; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fPfppkF8"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-495437bb891so5245725e9.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 00:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785999676; x=1786604476; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHCjuqA116INNULVQeMYQUxLnjzVId5qnDvtMozvW48=;
        b=fPfppkF817BmEWc6e+IgcHn3Op7T50+Eu9QJSzeOaQbcD+Zbbrv6WtX85PHi+/DYrn
         ePMie01YBtdF+WuGWde9xdlD82toRfXPGC0glG/lpgoNmA4126DzcrT0uhMvtim+Pix5
         lagHY14/hjdXPHNPxiStGGXehYnwR2tyq5js8Iq0Tq7bRXqxbszIWbx8MqKLY5r+P6W0
         qgeKAMvf6nHEDsHko7J6aMUc1ZTayBDKz9VaM/0Nfq9zNuF58aQfIZJPLX9scDD010vJ
         3cijRQ1F7JahJNJRpUs0SU0i2talE+5O2OVWvnjav5AgvwfzYYisuUMjdppviIXz522S
         g3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785999676; x=1786604476;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHCjuqA116INNULVQeMYQUxLnjzVId5qnDvtMozvW48=;
        b=AovJ5sbShahIhzmlDoxk2LzwtxSmZvQOZjwzNKuLCyECfVRhW8jseMug5TK/RJQh86
         qR8BUcTdoKDGwrG9hhF4TZkmXUz5Q1NYFmR9iLvi2yYwN3nXLVtohBgqPpXgWL32Eo6q
         JgoQ5Slm5lv9G/CLZvj2GHRFktjd/X1yg72pUrs/MM3x7rPzhdkmG+52eIWlR18b8u0x
         z4sF020mzPNSu9CxxphQAbWMD/DKkVQWQ53QhGTYsMqqz9Bo+sRKIgx4gqJ6lC228Rbt
         ehsd9QrdWuxVORFeSHhiSq/2b6/hE5hdmOWXw9dOajZ44kzExUsLvXXyW7LTrYA7VxlD
         8WDg==
X-Forwarded-Encrypted: i=1; AHgh+RrwzSXK/qhM+WEgXTN2v8n0OOV8NTiQ0j2Za+hTfWoZfKQKpzqjrblShu31T78mG6z9Y2o/PqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs70jJ1OX6WUR0yhFDFTYztwoIYzEiL9t9QiqXmnOfuYEUDg6e
	Bz4DrZTciM/12BExymlsrsTMQEpNi0DVn7Hzd/sNKe4rasaH1F5W5HQS
X-Gm-Gg: AR+sD10xOXYIoBh16/EbV721MCmxd52I3ikFZNnG9U/Dnj2M61hGXw1mcVsfK773wF2
	KZhFJXnvKauqoo3MT+l9QYIvNbU6E6KkngSyxTDfKvCiXtUzfng67QN5SS4h1JlHK7svEYWBSOn
	DBzeiMFGz0i7mBP+TNkfqtI5xFOwOa//fSf5QTYesg/Q+7r45Td2vCr6wJpfe2ljBXgg07cj+J8
	b3rUkVqbdWGRhFmi8SgRj8IuoYYdAWNX4qzuSn2FuzNzMRqb06QF7EUi3bAqdDDx4OQop5dqBU3
	+stO0QkSQbd448y/NLZUeQsXmSj3db6IibgeQotETDZVJSQQbSJT4jCZM+GKuoKqeM+QMEaNFBV
	sjxDZRxdd7s4PmaWFZkXvvgqGFKJGSLjQR9B4h/47Bc5WnU8Ur/n86av/zP4wDUo4YvCLlQ+4SS
	ROCGDK864WjEZ5lzYOpqQbqRWd05Spz6kw1BnYiSJRjtNU42JvC7BnNskIfA0DtAmf1OMXBH6B9
	SF0/nLSw2HTfILpcXtKRa1IxY4i99vmLGbRVLNB/TtVM84TLr5xVnRfyqwX1dahmhZoIX8YqIdS
	NTvLGTe4EAYBFr50d7jaWUOv4RC3O3CQLN+gT+sGErkULWmJxZoIyxolTYCfSWPLv5qgGWYCtQ7
	VJ55GxMqEmfdShshQfQ+PVZpHer47ICeS5fphzm5hEf49JHkHZqutEyOc
X-Received: by 2002:a05:600c:3542:b0:494:1f7:8057 with SMTP id 5b1f17b1804b1-499553bccc0mr21135755e9.1.1785999675699;
        Thu, 06 Aug 2026 00:01:15 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995427a244sm36121895e9.10.2026.08.06.00.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 00:01:14 -0700 (PDT)
Date: Thu, 6 Aug 2026 09:01:11 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Hui Su <sh_def@163.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bmp280: fix out-of-bounds access in
 sampling frequency lookup
Message-ID: <20260806090105.000059c9@gmail.com>
In-Reply-To: <20260805074127.473731-1-sh_def@163.com>
References: <20260805074127.473731-1-sh_def@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  5 Aug 2026 15:41:27 +0800
Hui Su <sh_def@163.com> wrote:

> The sampling frequency tables store each frequency as an integer part
> and a fractional part in micro units. num_sampling_freq_avail is
> initialized to the number of flattened integer elements because
> read_avail() returns the table as a flat array.
> 
> bmp280_write_sampling_frequency(), however, indexes the same table as a
> two-dimensional array and uses num_sampling_freq_avail as the number of
> rows. This makes the lookup walk past the end of the table when an
> unsupported sampling frequency is written.
> 
> Convert the flattened element count back to the number of rows before
> iterating over the table.
> 
> Fixes: 10b40ffba2f9 ("iio: pressure: bmp280: Add more tunable config parameters for BMP380")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hui Su <sh_def@163.com>
> ---

LGTM

Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>

-- 
Kind regards,
Joshua Crofts
