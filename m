Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289BC36DA0C
	for <stable@vger.kernel.org>; Sun,  7 Jun 2026 08:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780822795; cv=none; b=LBhIxxQZ8kgN8/8D+9C3XvKt2671Us97SAXlCWyQCcc2Q763A8z2XhZ7Ol6ruAEp2o3MOvk+GKRc0OclZ/Kti3BP/kBRdWrEDAXapt0WL+IUDYVRwX4BzzsDcmGdqDrycg9QCJNJTBHGPwe+ox9wvMe5MBzUk3N9Jd5eG/SAGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780822795; c=relaxed/simple;
	bh=51hCHviJV9dx2kHJUEdIxPea9gknSXJj2/BlEWlzHPA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EI3neFziqtz3ouGS9EGEs06Lj0S/WM4NWE87cF2kMW1hn9r9Okml8LVOCUUBXCkwAh2iAMu9tA6wv1ZuzlqtJAaBrTpmQTbWwHOSZ9iGORyzFIgbbkvmpKq3mI87HpQIaqjuCOWS+0Xuyn2Vj3ygApG8kLkJRI9jYWV3xgX7eIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrE0gVMt; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrE0gVMt"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-490ac10e337so29284465e9.3
        for <stable@vger.kernel.org>; Sun, 07 Jun 2026 01:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780822792; x=1781427592; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hd8eJQE2e7HGUVx3+ey2vy9S5cDeuFg6IlJZJVllcIw=;
        b=IrE0gVMtulCp3oN+57lGho/0OvEyOcm17i4vJeiNhE9ynyhO2q26zdmuxh/tu2IPeY
         SCHz/B3zBNOHZIkgY0hf4t9GCZgIHZnh+czAQ3UymI0m/m5SrMI+IaXYo3C+FFotApdD
         ZoBU7FONBHEYzKjsZzOCu+HhfZCWHqlxs0YMuWu5n2ZHJSYjhfi3P2INkkNPICzgV9mm
         1JvcWhCl3jN+yQg/CRAt2HQ5nbZIG7RGU6X8I3KnOdKg0w+7noDqvtjfwW0rNH1G8w9I
         P6q34vJZnO9m/lWgHwm/Lj2qNI8+0FvT9DF5FrOTafbujNCMuDZIyjSOkFU2lOHgj6FA
         NiwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780822792; x=1781427592;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hd8eJQE2e7HGUVx3+ey2vy9S5cDeuFg6IlJZJVllcIw=;
        b=qpGtNFV5ZkBsyRr1onGTcU04LSApPe0/hErUsnqYHTKahvH/7ggHRg0AWU5WZxvECV
         Aa9vLhpwgjuseZd4Rt8PnEE0pC77wZXG/KbqQPtAapzsPRen8kaZ5YpRdhwt7AGosaOx
         gNI4vBrqLVJUwMvWDnW4/W0f9UaPVj/bDT9oGKJJtked9YphHo4bLvt4jmV8cQxO178l
         S8ezlp0TNXhqNVQUyqcqaWSmxIVEZcjASgWST6pzvRTs/2J/mBWasEFOt5pIEC/KPhuR
         E+hnMVXkNclJarzt6cfyagRbacHBkgq971RTIMbjPV0VtE/5MP7BtL3T3HdimjHNGdcs
         sknA==
X-Forwarded-Encrypted: i=1; AFNElJ+XZl2Af2FRmI1938YU8pJOE4AqUUnyfB6nD6CvD3kllYCWVwrWucoLx/QUZIMOTTEoONzf81s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhbAo79CUOHoPKteEulRXTDHtw1EfFnHLcqNBff/Q9Evid0qql
	/WKpcBFxZWc5oj0g+JYqdsrmMQfkge77tX6kbpNQkXQ4h8w4NR1nCOgH
X-Gm-Gg: Acq92OFmnwygDGtrJGV2nsVBXtNBvcL/mdTwUO+odXA/YJ7ibjJW46QjagEwSz60QsB
	GSH4GWH4Q4ywF/uFf8jCx2W7LIF3r9VCt1IDokgUouRWrFtf+qVSw35nZJN4ilZbvXrL7Wswb7S
	1sysJrc2Nu0nTz/rkCPY/bTg8xL7uwazwTVg43cVs8f3lLhCPOUiFCy2T1J0ZTDjRvddEnF8hsi
	kHRBaEBTc08N7YuGJNodWFXLmM2jd2poygMtexuRJh2AaQFT5xXRTXHJ6op+yNbKUwy8ttGp/t2
	L458CgJFzZC7Jw6OkkI7SThBFS+ZJaLGL9o0gMBnBtASXGyTsfH+5S2Wati0HXEl/fnGc1szrmD
	oAzUtSNBbgXYIDmaNDQzkrZ6mLOS76hWLU1/GZ8y5IntM5WvcZDNkYU9VWcyVnLPq4kf8rBJJNm
	AarN19jKKcptgq/KR2Wy0OYqKLM2uDR5s3NBi78zAM9J6tN9WcnNnQNdo7ZmX3BFWPlLgcwZras
	zwCREN+ImOt0p8QNDXXX0IwyjnDoKSZStMDJhVVa3nZ9nu9qk/Qwqk81qNwhZlL4xu2+DCew5F/
X-Received: by 2002:a05:600c:628c:b0:48f:e26a:1744 with SMTP id 5b1f17b1804b1-490c25a87f5mr166153635e9.9.1780822792343;
        Sun, 07 Jun 2026 01:59:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f35fd33sm45756094f8f.35.2026.06.07.01.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 01:59:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 07 Jun 2026 10:59:51 +0200
Message-Id: <DJ2OZSCSEVEI.3APUCE7ML9X4Q@gmail.com>
Cc: <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <houtao1@huawei.com>, <linux-kernel@vger.kernel.org>,
 <stable@vger.kernel.org>
Subject: Re: [PATCH bpf] bpf: Validate BTF repeated field counts before
 expansion
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Paul Moses" <p@1g4.org>, <martin.lau@linux.dev>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260605234301.1109063-1-p@1g4.org>
In-Reply-To: <20260605234301.1109063-1-p@1g4.org>

On Sat Jun 6, 2026 at 1:43 AM CEST, Paul Moses wrote:
> btf_parse_struct_metas() walks user-supplied BTF during BPF_BTF_LOAD,
> and btf_repeat_fields() expands repeatable fields from array elements
> into the fixed BTF_FIELDS_MAX scratch array used by btf_parse_fields().
>
> The remaining-capacity check performs the expanded field count calculatio=
n
> in u32. A malformed BTF can wrap that calculation, causing the check to
> pass even when the expanded field count exceeds the scratch array
> capacity. The following memcpy() can then write past the end of the
> array.
>
> Use checked addition and multiplication before copying repeated fields
> and reject impossible counts.
>
> Fixes: 797d73ee232d ("bpf: Check the remaining info_cnt before repeating =
btf fields")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paul Moses <p@1g4.org>
> ---

Do you have an example where this actually occurred in practice?

>  kernel/bpf/btf.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index a62d78581207..510aa32847da 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -3668,7 +3668,7 @@ static int btf_get_field_type(const struct btf *btf=
, const struct btf_type *var_
>  static int btf_repeat_fields(struct btf_field_info *info, int info_cnt,
>  			     u32 field_cnt, u32 repeat_cnt, u32 elem_size)
>  {
> -	u32 i, j;
> +	u32 i, j, total_cnt, total_repeats;
>  	u32 cur;
>
>  	/* Ensure not repeating fields that should not be repeated. */
> @@ -3686,10 +3686,9 @@ static int btf_repeat_fields(struct btf_field_info=
 *info, int info_cnt,
>  		}
>  	}
>
> -	/* The type of struct size or variable size is u32,
> -	 * so the multiplication will not overflow.
> -	 */
> -	if (field_cnt * (repeat_cnt + 1) > info_cnt)
> +	if (check_add_overflow(repeat_cnt, 1, &total_repeats) ||
> +	    check_mul_overflow(field_cnt, total_repeats, &total_cnt) ||
> +	    total_cnt > (u32)info_cnt)
>  		return -E2BIG;
>
>  	cur =3D field_cnt;

