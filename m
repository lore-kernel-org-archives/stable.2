Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793119760;
	b=PMPBc0HcrviaXNcTBIevQ2jqH4A92ID6Y5HC7hZTSODhAI+ijPpiN/8WKT6VgL/6VOBe
	 wzJAUbLsI4x+MOW0mmcLGDDYM/W7iAt/rQUyWC0pm/YQlXYmh7n+tFZq6YtC1MJHuXbbE
	 Wr0UVDRhiPzRmfXKgLErqWDfOstjaevHuOsthYhF6p8NiDCw76Xyz6dMOKF7X7dYOiLjJ
	 H8XaP8ra9lAqMKdVYhRZiVVRGkeDEhaJ7qdylQgWBqFghWy4IaoMqhK2wyx7IIUYtz3wO
	 fRpgHGPJwGE+MLSSpz8IfjCYB4yXyim9D4YZZrU5N6S/Tsa97++8DALsEBMZxtZ+3Eg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793119760;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5h6BBHIqEoVlVYK9N7Wra3yA9g0iuse1t0EMDjWEH9Y=;
	b=myRY3c+vf68xM2UzvY2q2KpsRPhte8kMVRj9+HTj1lAcCsTSVZ5eEUQ3T52Pon+fWOuY
	 GWlkL8byGnvJRgjr9+phMLdGkuo9LBl7Q+fX3YHNdlfCi4uLgH7P9Xc7ZNButKFwx/yPB
	 LIE+rBjR54BerSfnvG0rd2I7p0m5NC4Hc1Shiq2ul6rdm8JACgtPYNb8moq+H0kdmM19F
	 jZs6NbR2DSpWcsYRIdqnpG4Woha4VFTWe/6DvLLe/8Zob1kcb6OgIbXHfGiWjnHf2VGJh
	 jwDMf/G3ceSkBu5E6aPrVW+XxPocCfOQP7Ijvd3/LWlng9jguhcjt3Dwb4giyKeJSVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UB/oMyps";
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D3606A31E
	for <stable@vger.kernel.org>; Tue, 27 Oct 2026 16:49:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 225D3606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UB/oMyps
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a210470b49so386815e9.2
        for <stable@vger.kernel.org>; Tue, 27 Oct 2026 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793119757; x=1793724557; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5h6BBHIqEoVlVYK9N7Wra3yA9g0iuse1t0EMDjWEH9Y=;
        b=UB/oMypslgUErxwg+EMLW4/2jYT75wR8k/sQ4y9j1+chvoi+4sXibjHZc+ZP4FCwhe
         EejVkr5Nn4OLNRcDUXAzlOSyqyz7ZB6b5iv7fHyXL0ukmPozJ+GXBP2KYx4mAivO3OC6
         32azoh58l973/j9LYPpQdWo5fp1zMXjQxiIZnEQ6wFSd7uWecaZUrfYFLMDKLG6n8Zkt
         fzMjo6UxS/QOpKEn74pb1rGJkwe4UQmz96kG13Sg8JNrTawgIUJDhssCDdWI5pV+GK6l
         om7SbkfCCjv9NUI2POcmovIopR9MmKLLdAqeu4UwUaKNUqcOrmnSNRXWHeT4zDk5Etje
         9qqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793119757; x=1793724557;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5h6BBHIqEoVlVYK9N7Wra3yA9g0iuse1t0EMDjWEH9Y=;
        b=NSVNQiTEOZK7CEAYHO3+ZUbsNZJ9YXCrhDwzQVrRbbZZynDArxLePvxDE7Y6eWhcTw
         jIDxUsHgCSh3DgO0+mJdr5HUafsOMC/jLN9yVXlNMroYHKh0S8asxtNogTUa+KL89ukY
         URgzQhEGYKGzfnqDcmEuhEWsZMIJaGXsKLuPUGRap5ZXMEtNH1lN5VkVxXuxM1wuH9Hg
         UevSD7gJS2w0Axtcu4sd0MzZPYnV+vC/EDWUcmBLtd7h0QR6k6EWb72+XIxRFYNu79pB
         nq9lPyuG7sXjGZuhExH77mxmCMXdwRx2gV67acyyu+VOuaJIsGwA4M6lPTrEuA67X5iz
         bl4g==
X-Forwarded-Encrypted: i=1; AKwUvBwDKL7zMkmRe9bpjcR708bwYOyq4aUoRRdUk+xyuEVI96ezPXYKN2Bud/8o2COL3n9IuttU6Sk=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7036v8JiNnS7HtNuoevX+658Ysi0z30mXzAW3gKCx+xIWdl5z
	ESHp/ZxlWzHgZmgMCCfvKp5WZnEEnEf1fZHuyGmOxzWV+RFATl+VjmlamX0LRJdJ
X-Gm-Gg: AYBFou3KG2XFah8dMAqohiPlxxo8ss2sSEASE71kPZy01AqROPzc++uo+r+cPsiGGLd
	C5pFVgbcWoIyJcvY+vj8cm/AxNEn77Q5AT8miAjfhtElaiiQB1DnCg5jT7MrpLARkvmStH4hw+f
	UobUfoGe8LQp41833xdUgeQSgrjQLmUGMw3/yRKy8Wy1frYY4UNinsl2TleO7LeWjwJr88WGGfG
	xOKT5KLcTxYwrunxOEuO/JM1pgkJTfjfhV8ccl8k8QhSS9GeRWePPoFdkd0Q+pOAFy9S1jloudN
	Dvi+htHSDv6d0O/oasOypkKXTuMQB3Xuy3CJmpCbxyRhrhpd/UAlCqK6pOcMvftrQPnrqyKJj2c
	AoCm3r34G7Y3Jlwl4RGGbTmuEwh9/ieg53Z2AZd+yVwffQLuhxEnP8Dyjb3tyRzimLCExS/zsU0
	/KyWbc/8Q1TSuRnTWGr1tSfzrvkaHYQYxFm51NanO3m3pmX7wcMEkUVZN5s48eO7yjxDteEU/P2
	pWep3IPQD8s8L0nM2WuXmrScTxys5OYNyiLoee3y5fWktpl98WTEi9jyNnYavOQv17dVLSZl/cd
	gfW4qOxiyv/ZqY2AiQ==
X-Received: by 2002:a05:600c:19d4:b0:4a2:18d4:f9e0 with SMTP id 5b1f17b1804b1-4a35acbbcaamr198161485e9.25.1793119757306;
        Tue, 27 Oct 2026 09:49:17 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48e0sm24388392f8f.38.2026.10.27.09.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 09:49:16 -0700 (PDT)
Date: Tue, 27 Oct 2026 16:49:11 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Reid Downing <skibletz@gmail.com>
Cc: Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, Eric
 Sandeen <sandeen@redhat.com>, Christoph Hellwig <hch@lst.de>,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] xfs: fix wrong compat fields in
 xfs_ioctl32_bstat_copyin()
Message-ID: <20261027164911.578ef6e7@pumpkin>
In-Reply-To: <20261027161748.2760321-1-skibletz@gmail.com>
References: <20261027161748.2760321-1-skibletz@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 12:17:48 -0400
Reid Downing <skibletz@gmail.com> wrote:

> bs_blocks and bs_xflags were both read from bstat32->bs_size.
> Read each one from its own field instead.

It would be much better to do a single copy_from_user() of the entire
compat structure and copy the fields to the standard one.

The function would need to be 'noinline_for_stack'.

David
 
> 
> Fixes: e94fc4a43e5c39 ("[XFS] Add compat handlers for swapext ioctl")
> Cc: <stable@vger.kernel.org> # v2.6.29
> Signed-off-by: Reid Downing <skibletz@gmail.com>
> ---
> v2:
>  - Also fix bs_blocks (spotted by Eric Sandeen)
> 
>  fs/xfs/xfs_ioctl32.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
> index f6875a2cc70..77bc936bf0d 100644
> --- a/fs/xfs/xfs_ioctl32.c
> +++ b/fs/xfs/xfs_ioctl32.c
> @@ -143,8 +143,8 @@ xfs_ioctl32_bstat_copyin(
>  	    xfs_ioctl32_bstime_copyin(&bstat->bs_atime, &bstat32->bs_atime) ||
>  	    xfs_ioctl32_bstime_copyin(&bstat->bs_mtime, &bstat32->bs_mtime) ||
>  	    xfs_ioctl32_bstime_copyin(&bstat->bs_ctime, &bstat32->bs_ctime) ||
> -	    get_user(bstat->bs_blocks,	&bstat32->bs_size)	||
> -	    get_user(bstat->bs_xflags,	&bstat32->bs_size)	||
> +	    get_user(bstat->bs_blocks,	&bstat32->bs_blocks)	||
> +	    get_user(bstat->bs_xflags,	&bstat32->bs_xflags)	||
>  	    get_user(bstat->bs_extsize,	&bstat32->bs_extsize)	||
>  	    get_user(bstat->bs_extents,	&bstat32->bs_extents)	||
>  	    get_user(bstat->bs_gen,	&bstat32->bs_gen)	||

