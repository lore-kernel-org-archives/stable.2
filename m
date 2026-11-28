Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795834039;
	b=o5jP6u+e5vjg/v1A4wkdG8D6HeHTlfndZedYnIEY/lluI2fcCzXm02Jg9cYOzdHGgbXS
	 yof2jTKGzDexejdoHMPSKesz8JshnXCns3AuVmxecUjW0ZzRCrRzWe3/NG7CPqwjIs5yq
	 XQQlLq8C8Y6HD8db5+HX2u/ab0Jh93XQeJn9fUhBMilWEwmL8pe5QehdeX4AkceCVC1uW
	 JiRUXG1fPN+c5Rvx1IsACI+zXtXfIjtNj71SpemNbS5eOPKbjqa8BqpOZZVMasBzIFhqv
	 0OE0QdiurlAjNINAp1Gqq6CTaEAXhh30bnfb3sRsgu8rC0ShVOHfqk9V7XrPRZQnnwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795834039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=6WKT27fdX/tFqhewESdRPtk5HTiyQzUxICUqNBuVX0M=;
	b=h30uLGnzXiQgrjoFKnWjxOkpSSydFsVl/PAxVjZj84ZzP46AFDXWwJ3K+tEvUtJ1rFav
	 nUL9mSNA4fJsnyZfN+03FUWAK5GiDK/9lCg4BFmiTNFzSje24Pl05Wyy9nBRwfCyDxQSx
	 M2YpzRnI1rdhsBfyqP9TNqLJnjUAYZkNXx4k1eSnJ5lMLKRB0FwbMcjAc+qkMUAg/JaGL
	 2xrAqyllbMEzD4f5qFbYAuy79yMReoi4MKNIeU2IZbbxhAsIihOmptbH8rUMYB/mg3Z6U
	 7ckkmyjiXKChhy6HYSqBD5lOFCyfZZgGn5S7IY+W7o4wctl/tmya5GpFzf+xrioO1vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=FiuhkhtQ;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB8606A321
	for <stable@vger.kernel.org>; Sat, 28 Nov 2026 02:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BFB8606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=FiuhkhtQ
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-3869f03af6aso7742003eec.1
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 18:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795834037; x=1796438837; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6WKT27fdX/tFqhewESdRPtk5HTiyQzUxICUqNBuVX0M=;
        b=FiuhkhtQpTj02YUL2JydJxu7pP80ao7UIcx71q2j7NDWqv8zjwSqfHsgdYc/vNm9uZ
         OwV4iQpfm60T48BM7zkX30KHYk8NM75Q6QpM3dWv8XQvpRIyXqzZ9SFzsEIx9wgE9mp9
         gbnHoXfhWqG9nzd1ItBNVhu3rrmCjBYaAc0Jk+TW1ufAbAe//L/36bk2jNkDRQQXdJec
         Inf/Fj2kKa3TtaMFUbRAbCfsa+qypmduCT+3CZpkFVDNn6KnVRSBoTqqqYQh7oFQ9q1p
         nHgQJ3LwwMoHLHOJ3j4nVjJkhWMaov75Zvp1GyPiFADc942jmTe3Z3EwST7PFtLDNbDr
         S4Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795834037; x=1796438837;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6WKT27fdX/tFqhewESdRPtk5HTiyQzUxICUqNBuVX0M=;
        b=ryQ4VNOAr65kspbS3Mc91+uvfdUi5yv/ANq7trFAqm/6/a0TP2h4Zx4wU3aqKQI4DH
         78jN3B0i2sOM/bXBmproLKhghprFrbaLe0cBc83EgLs7uZ+33xwlvEKr0VyPnZvxI4z3
         21RCXLzNqvrKoNOulKg6/XW05sKARQrA1b5oVlVO5jLVx1C+Jv6SY1Hoxg8XUeiwtDA8
         iYoOyHJ74LZ0hrbf7g8d5Pw49LtjzRWJbw+oAQMw1XYUNNyDebNm4xdweYs4akvwDieB
         ZAT49xFoIA0D4R6KZ0Ncf8cUQagkkDEHPpqi6WMmgQekCPwjOWF2w5jwxz2Vybkozs9Q
         WBrg==
X-Forwarded-Encrypted: i=1; AL+hErHOZq+I36eBwZGT9z/FYu+L+w0bfwfWG1so49nYc3k3V0BWU+iMts7uujd5sqvx5lB4w9ZsfQ8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ae6wi/Ow/krGocuEv98PH8XVF7KzM46JCGlee/tkxtlAK72Dw
	uOiPL+gD0MWzSgghYw+f6E0Dvk/elrIiiqD+dc3lbRhjuZ8fWuycJbtbOU2M6y8ZcMbLi0CK3fD
	gQYql0aM=
X-Gm-Gg: AZFdTZchn7Ii+ETzJJV9GM2O/WJNIVsBETIcdol4LQTO8A7h/rt4+M1fs7V3hcvqwTI
	QIjgbDUbxzRNh5lC/TcoM//86/L5Rui8Ox9ddBEDxWQ77P4L6HK60l1pFSus8Pou56tMcgNSGLq
	Mxdzfg3lDvQ31EHw7xF6lQDnQX20+x+3FM0YoA6mn2zA4fq4ge90y4pIt0L5DM4rlkzSSrE2A+O
	vdeBRF7ow1sJoFm9ML9FlzgdTI2TOxnWODr2Qx4ikLkSjSvjm0o2gNwp0UoL8n5D2L5nkrcZflT
	hYk6XqeIaSc6lUhHP0qmTFSzRn7CQWxRxzhd7rTAz6vtHA8F9oFyUrnQOL1J0uTKBVIg9Oo0zqf
	9dqV1lb4nXRNnNd56GnacS69bRY8d1JnIpJJwQVLbrSgdehBP7NiS64G7/Tjtb0T6zC62Kumdmj
	ngOep/XwlxpzPIxiR+R9Lga7crQE1aGx3tEzxhlS7yG/7CntZafNCdK6s27FPSIiEgWl7bNK+Xp
	HDXyqg1dtdxRSgFsbXDMa4/i5J92DtcCmi7nL6U4P8T96PE3zk37G4mc0Uto6DgAey19SO4y1oe
	ecoWx5nkD52Te6+5WO5cnNO43n/ADCFWk3zKpGcmFp1VxynhqKlUuRfCz3I7AxcMmEd0q7vr8/r
	91eQ+Tod0Sfnyw5YiZlGUDL4ielrF5lRD287QYiuWYja1V4eV
X-Received: by 2002:a05:693c:88d5:10b0:386:9e9c:867 with SMTP id 5a478bee46e88-3869e9c2df2mr21137020eec.10.1795834037229;
        Fri, 27 Nov 2026 18:47:17 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385646633d0sm134059672eec.3.2026.11.27.18.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 18:47:16 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: hch@infradead.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, mtsai@redhat.com, 
 stable@vger.kernel.org, hch@lst.de
In-Reply-To: <20261120101758.45513-1-dennylin0707@gmail.com>
References: <20261120101758.45513-1-dennylin0707@gmail.com>
Subject: Re: [PATCH v4] block: fix discard alignment for non-power-of-two
 granularities
Message-Id: <179583403624.86956.1820367114895807728.b4-ty@b4>
Date: Fri, 27 Nov 2026 19:47:16 -0700
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Fri, 20 Nov 2026 10:17:58 +0000, Hungyu Lin wrote:
> bio_discard_limit() uses round_up() and round_down(), which require a
> power-of-two alignment. However, discard_granularity need not be a power
> of two. For example, dm-thin supports data block sizes that are arbitrary
> multiples of 64 KiB and advertises the block size as its granularity.
> 
> With a 192 KiB granularity, discarding one complete block at offset
> 384 KiB is split into 128 KiB and 64 KiB bios. Neither covers a complete
> thin block, so dm-thin ignores both and the mapping remains allocated.
> 
> [...]

Applied, thanks!

[1/1] block: fix discard alignment for non-power-of-two granularities
      commit: f6ce3d09d6480b56e357336ac080952f9525eab0

Best regards,
-- 
Jens Axboe



