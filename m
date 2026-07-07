Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF08733B6F6
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783453782; cv=none; b=s9KIV0ykkUlNdUgSU3Kz7IUo2r4G873q35SC6K49luWoUcjRA0TaMu1NvV6Ev9ThMcAn8Z38NsGNa9IKwdX0zHChXjCLK9BM2iK+dh60iQEw8tOc8gHJVTfCWBn8hzPXuVAfI3a5CjRHt13WAfNyIrROrG9OKHn8XuBLvrn7I+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783453782; c=relaxed/simple;
	bh=cWUDemI2fy2468Rcc9hA4tMRSKDMQfvaEw9RCKkrqaE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h5geZ/A7oy2sOSrjiCYV9PWQg2ewUnTjinmDh1Nf8C8F0PdGYcQgQzoDp14ni5tmKJ3zTL8Eehcd1hkIkGo9iI/LOq4JkHiKZIUm8pl7LYcLyqNyXYkRfdB7iYRLL1owcXTS2JNErKL/T+c+z+u5pDcRujUeqFxLoiiazgopWLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p7CHO8t+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7CHO8t+"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47d70879764so2018556f8f.2
        for <stable@vger.kernel.org>; Tue, 07 Jul 2026 12:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783453779; x=1784058579; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F7TEXP25/oGnwFyrCpdS4x0e3KbTeuTKFgjnVzacGG8=;
        b=p7CHO8t+ngkbTlk6SqV5aC3s1O1EXgcx9lqvtL59ws2LCl8KvQ+uSrtfD3rDNwyL//
         9mNqeENsDqNAbl6jaWlJNlflIijcYNgmHb/CBtZ59ngpvVI85Vm551MygoLf8P/ms/8m
         vUiA28SA139tU42HoeTbXF9KbWoAmYkvYNj7mdqnYuudhb70xHLO08ScaO8FKzVfYn7o
         4AExCPFLqQiZPPBUBcgTsAmejVSXtdsplbxFVTp3bvHqqcqJT3OFkZwx+C7puxAMuzLI
         LpgKzDj+B7DSjEb4JSj2CFax0SWYOhQPeuU7QyyVnOJSsrcxMKwjS9UjhbT3uSwG0bsL
         6g6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783453779; x=1784058579;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F7TEXP25/oGnwFyrCpdS4x0e3KbTeuTKFgjnVzacGG8=;
        b=UC/70GfcEulGOyR5UO+gxZL2lCa1OAjpm8L8uHx0zOpax9HeOSQa3hOgPpmBJ2FGlE
         BGBX/pVwXnnTLLpvLNlWxviGiu4mzDkHGEppdG6zK8xJ4fzaQKQHsbCubW2sJL7pP510
         bn8bNOuih93Ht/f4krLZwbA5N/zPcrkzfKtVby8CIAvWSwHmQNXu7fTSNxLXMayLRWDs
         Xq1YKSOqZLxYw0TFtWtccm2WHHaUipdlk20rKRIouod6cfS4RtaPzZ+dBR9nei001D9b
         OgWcZ9Yt1AWiKrlcOpsMnw8600cN3OWSNY4r7/uUpoJEb3R1QtyAmk3g6QurqiUhRfdb
         7UiQ==
X-Forwarded-Encrypted: i=1; AHgh+RopeWojHFwP6iWi2E411fdBLfLnX3uLvdb+wJIHbKGzva1J17yV1JWwrGhz4CqqIUEUDMv9D/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMREYLr/EK90X7DsElDDcGGESMel5RSWlez1WGP5+3YIV31iWc
	vFIZSmOx8XVb+hZmlEcsvbQM9kQl5HyT/H/V7oB0LxXJ2sXQ/SEqR2Ec
X-Gm-Gg: AfdE7cmctmk+sZlZzQBHqD7CeoACUk1hcxNJkKnT8LrY+J7ttclTribLVzokJ5PUHuu
	F9+E0KMRXGwww00qPqbX6UItZF0YDk8x1TfKWOxxUn2VlZ3aWW45uoAm3/SnORYV9fM4fqniJPm
	MC7APryZ/a5hEOpaw0L8kFnbbmGwq5VsAdxwsRHGfbhngMCPey/zsfrno75jtH/u13fS32ml6HR
	IgEQloAB2THikmViIFnR+CXJjklUf8UHrY8zbNT10eH2eDlhUL0d6SSWkpESAT6ACKXQbQSkm7D
	nT93TbYQUM8jFgH3ct17n0edrHGEn1WTRltVTIH1PAS68pJ/MSQicwoOuv6ddx5e6B+1xtIkMoi
	Z3i2931Hza/lTpu+a89lVh2IIRuy6Zttkpb9Daz5X2CnIoG0ZVfU+rINB0eHc+D95N8Y5tAgbNJ
	IOUKvYcocDWnh9B8c4Nz/ZWA32noC4xfLD9yjJSJnqCLVLfA==
X-Received: by 2002:a05:600c:8b6e:b0:493:a5d4:3798 with SMTP id 5b1f17b1804b1-493df0663fdmr71499135e9.1.1783453778982;
        Tue, 07 Jul 2026 12:49:38 -0700 (PDT)
Received: from pumpkin (host-92-21-50-228.as13285.net. [92.21.50.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f294a6sm153839565e9.1.2026.07.07.12.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:49:38 -0700 (PDT)
Date: Tue, 7 Jul 2026 20:49:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: <Alexander.Chesnokov@kaspersky.com>
Cc: <xuhaoyue1@hisilicon.com>, <lvc-project@linuxtesting.org>,
 <Oleg.Kazakov@kaspersky.com>, <Pavel.Zhigulin@kaspersky.com>,
 <stable@vger.kernel.org>, Wenpeng Liang <liangwenpeng@huawei.com>, Jason
 Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Xi Wang
 <wangxi11@huawei.com>, Weihang Li <liweihang@huawei.com>,
 <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] RDMA/hns: Fix arithmetic overflow in
 hns_roce_v2_set_hem()
Message-ID: <20260707204936.6a8e5c35@pumpkin>
In-Reply-To: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
References: <20260707140938.3106919-1-Alexander.Chesnokov@kaspersky.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 7 Jul 2026 17:09:38 +0300
<Alexander.Chesnokov@kaspersky.com> wrote:

> From: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> 
> If hop_num is 2 or 1, then the expressions like
> i * chunk_ba_num + j are computed in 32-bit
> arithmetic before being assigned to a u64 index field,
> which can lead to overflow.
> 
> Cast the first operand to u64 to ensure the arithmetic
> is performed in 64-bit.

If the values can be 64bit it would be better to just make i/j/k u64.

	David

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: a81fba28136d ("RDMA/hns: Configure BT BA and BT attribute for the contexts in hip08")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alexander Chesnokov <Alexander.Chesnokov@kaspersky.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index 1c180a6b1c07..b62513b4db09 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -4257,11 +4257,11 @@ static int hns_roce_v2_set_hem(struct hns_roce_dev *hr_dev,
>  	chunk_ba_num = mhop.bt_chunk_size / 8;
>  
>  	if (hop_num == 2) {
> -		hem_idx = i * chunk_ba_num * chunk_ba_num + j * chunk_ba_num +
> +		hem_idx = (u64)i * chunk_ba_num * chunk_ba_num + (u64)j * chunk_ba_num +
>  			  k;
> -		l1_idx = i * chunk_ba_num + j;
> +		l1_idx = (u64)i * chunk_ba_num + j;
>  	} else if (hop_num == 1) {
> -		hem_idx = i * chunk_ba_num + j;
> +		hem_idx = (u64)i * chunk_ba_num + j;
>  	} else if (hop_num == HNS_ROCE_HOP_NUM_0) {
>  		hem_idx = i;
>  	}

