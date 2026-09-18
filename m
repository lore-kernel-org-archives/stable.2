Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4DC35CB91
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742717; cv=pass; b=kSGaBrAxIxiMln642Z+pQhQJFiF/DiZruUStFqp0ISJZxMDEOWFHRbkyzwHkPBv7+TCKaRDgiJYTdTZdMEFltKMWr4YQomo6bKjPp7Vx6e3R/J56PDevifvPhVWKAgaTM5wjrbNZb2z/O4RVpJkSb5XHmaZ37EkWSEyuripSOjI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742717; c=relaxed/simple;
	bh=ZANROxcIqhrcevsvLae4ZVF5Yym2xmUzeCsrPwIoUNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VHHMZAxKAPWJ5ygzn9VI6JG2dH8NQYv7vBeRdm4hGZmtyuhZv1bnpVQ9K5jtkEKZjTJh5+OQdsnRGBUgdYejESdNR6npieXZWRqhQLkZmX/7AkAulHBEWrYGMNZFBcQfk2iYkpZjSZWrIJ+oBLfnP5Ddbw1B2nGPvfEziyOOBtQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oedKKICs; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oedKKICs"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccd5cf02so651255a91.3
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 07:45:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789742715; cv=none;
        d=google.com; s=arc-20260327;
        b=ketR1BewSIqdViPtf2uyamdr6Z0aLiNHuP1R9Op4X+pUAHO0FBafL2/KDs7gxlILxB
         /QD+C3n0wEobU2/UWZ7DvAxLsmtgXEmfb+XsPW2kL9kPwimlliaVE7v+OtgOzLE//+ii
         zYGktkQDciFHuWkMu+3qw7SODgdiG4DgAR09QChlPqhOfVO/81U3xRCcKoHG5po35ji5
         xRDt798Ev4aTvZJcXyDGTyicKmAYVwK0FlU0cYxuw9K/CDvfT6nQNm1Ip9c1LKERkPDI
         SVSY53iTdUazhflqenxRiM9FPd45aTxOttSFNf9F4VKGzhu1KYDaOExkjwCMskxQdrJ3
         fL/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i4H1dyn7FKo4Dmb7iVZeE4tq+RQeNUXgtmzy1F1tVUA=;
        fh=tNhPSAy/IQzyhuJMAPRawCaiHq/GnyI08VD1yTbxnpE=;
        b=jqcA8YxGIiuS5QN81Q8W+oTeBPL4wXVwEfb/2MM7f7u0nrXbB1f7bf2y8Wds/jCWhv
         kvcRPsmsxlEZwar8amrGI23Th4Mo4bZmCfla/76Dx/8rTSYTMfOWn4Y515iGZXzXk2YD
         IxjGGwfVeKLW7n2HRK1GiUPtu0A0Smf+JkefpBoVF8Y6Iy/Ov3cnF9LbXnCg59fJkYvI
         GBUuuG+IOw36BG3BJodDJwxpX0Bmb8OJmIsqdbpepH+6xXtKDVrKji/UWfqFanG4ZaDH
         AJ/scRrEl+EA59FxmbTXerlIS+VHYD9oROm7Ck2eCxcWKYNJBBso1cvXqPf6HyUUb7SJ
         b6ZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789742715; x=1790347515; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i4H1dyn7FKo4Dmb7iVZeE4tq+RQeNUXgtmzy1F1tVUA=;
        b=oedKKICsWK7PutLKBn5+39eDODSNDKhpz6MEzZooyF9+H67yIMZ3urfGPt4+Q385HT
         J1KMcWgcuamk6frDPCHJdX5vJMZ9onmqLtvJRWTBVGQJ6/8YeIPKEbBToeQPxlsvJjgZ
         9CdZrudFQzgeq0DZWQY7sARvEessfw0RgEKBo4cPZ8S1MPcgEG8ntr/LsFrPz7awzZDh
         c6/7d+RH1NDft6RcTAPgxy6/VjRrk+AzSJw/V7pMLsoGlGeK9rZkUxeQopPo+4db6rTp
         l3vgibYC5O7ByHiNn047zD0YXb4g/vNQ6wb4Qkj1IFAK+y4QmpOe2gkBtJgcX2MQRGa9
         ygcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742715; x=1790347515;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i4H1dyn7FKo4Dmb7iVZeE4tq+RQeNUXgtmzy1F1tVUA=;
        b=ihu9pYvpDe3KM2gWbX5vVUXofVOcWSNCiZg3tZpzoVBaESH786vYiyCYMj3aTsz61y
         BqI7JY8vMmxSo0B9KL2umuUoAW1Bi5BJBIdYEauWPvMZrTHmsO1Cw+4tuS89awMcSdUf
         m6s891Yd3dlxAG1Sl9UeQpnHEjHbi8wR3YIdxYF/2YMqqOKQhQKrfrj6YsqtRtWYqgfn
         LM99oqhvW5ntCMJpd26sT6wJ4kyMjbkW8tPu6k8j4MaiGZqsU9++UnwaDYOdi7y3/ccu
         ZNltoEO8YRPXF4DNvdimownjxQRFgFWA7KKlxAtO0bQ4dsvFYeN01rQsips3jGoAF7UJ
         7g+Q==
X-Forwarded-Encrypted: i=1; AKwUvBx2RxYcf7Dj/jXOS7xOMC4XuigIN2Qhgs0win6BgVqCTbYOvSEIa1YPWRK38wn6Vjo6YAKFnbo=@vger.kernel.org
X-Gm-Message-State: AFuF++kQk2SM93Y5rUIDlG22qkETbuRggQ+dtYutzcN748t0N9uGgtVo
	OG4GRuvjZByu6yWZd2ujy3JI7bqeqj2F8Jh53mZLihkst4vp+WEMdHg02DIVwQqUT/qq97XaKmC
	IXq5iVIoh15Q6IXbutVAervGkZjh0C9v/6LA13DXr
X-Gm-Gg: AYBFou3OGhPCShv9x1HLfyHLtJiHpl5VSwCDvhNZYfLeGT27be3T2k2BzmrpFnuZGPB
	Kv/KNg6ngHiUUjIohfcxYEc5LYagqan/WSTjq6lN0CWzaTdc+KFCDCQwwMgBiavqCBk+NzPe3vx
	YEojleDVAdQo7TLKTh0EqboiKMyAHv/wFB1EWKQ6BpRT+algY/U83ivUjiHfZvztuZ/udsXVB1i
	l1z9tkGAhS8Ot9ThpeX4Zt9m2qwOOyjJDl5nIAKcmv/OcI0ZM/mj9i83pAz096K2Jfij9eggf9i
	RFf7cxlbjFKvW90P3Isq0rueuyNp3zwnq1T7a8DV46ULErIWyfoVvpb3a3gX6Sqq8yhjXSfEisy
	DYEpYTo/kBg==
X-Received: by 2002:a17:90b:50c5:b0:39e:6a81:f34e with SMTP id
 98e67ed59e1d1-39e6a81fce2mr276638a91.40.1789742713887; Fri, 18 Sep 2026
 07:45:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260917104306.22145-1-fangxy@xiaopeng.com>
In-Reply-To: <20260917104306.22145-1-fangxy@xiaopeng.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 18 Sep 2026 16:44:37 +0200
X-Gm-Features: AcwNN1VsdOoF1CR4dvwem1MY-kEX1GrJkBZUCbo6tbBHym_QJ70vNsvmm2kEea4
Message-ID: <CAG_fn=VhA-O1BDJ7=THD9bViomcOR7UDve5M569sHEzZqDv7Kw@mail.gmail.com>
Subject: Re: [PATCH] kcov: ignore an out-of-range comparison count in write_comp_data()
To: Fang Xieyan <fangxy@xiaopeng.com>
Cc: akpm@linux-foundation.org, andreyknvl@gmail.com, dvyukov@google.com, 
	tchibo@google.com, elver@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, eadavis@sina.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 12:43=E2=80=AFPM Fang Xieyan <fangxy@xiaopeng.com> =
wrote:
>
> write_comp_data() reads the comparison record count from area[0] and uses
> it to index the coverage buffer:
>
>         area =3D (u64 *)t->kcov_area;
>         max_pos =3D t->kcov_size * sizeof(unsigned long);
>
>         count =3D READ_ONCE(area[0]);
>
>         /* Every record is KCOV_WORDS_PER_CMP 64-bit words. */
>         start_index =3D 1 + count * KCOV_WORDS_PER_CMP;
>         end_pos =3D (start_index + KCOV_WORDS_PER_CMP) * sizeof(u64);
>         if (likely(end_pos <=3D max_pos)) {
>
> The buffer is mmap'd writable into the collecting process, so count is
> under its control and end_pos <=3D max_pos is its only bound. A count tha=
t
> wraps the u64 multiply leaves end_pos below max_pos, so the check passes
> while the record store lands 24 bytes before the buffer, in the unmapped
> vmalloc guard page, and faults:
>
>   BUG: unable to handle page fault for address: ffa0000000b60fe8
>   #PF: supervisor write access in kernel mode
>   #PF: error_code(0x0002) - not-present page
>   Oops: 0002 [#1] SMP KASAN NOPTI
>   RIP: 0010:write_comp_data+0x7e/0xa0
>   ...
>   Kernel panic - not syncing: Fatal exception
>
> Bound count first: only max_pos / (sizeof(u64) * KCOV_WORDS_PER_CMP)
> records fit, so a larger count is not a valid index and is dropped.
> kcov_move_area() bounds the same untrusted count this way, and no count
> the end_pos <=3D max_pos check accepts reaches that limit, so no valid
> record is lost.
>
> Fixes: ded97d2c2b2c ("kcov: support comparison operands collection")
> Cc: stable@vger.kernel.org
> Assisted-by: Hawkeye:GLM-5.3-flash
> Assisted-by: Qoder:Qwen3.8-Max
> Signed-off-by: Fang Xieyan <fangxy@xiaopeng.com>

Reviewed-by: Alexander Potapenko <glider@google.com>

I was reviewing
https://lore.kernel.org/all/20260915033345.904567-1-eadavis@sina.com/
yesterday, but this patch supersedes Edward's.
