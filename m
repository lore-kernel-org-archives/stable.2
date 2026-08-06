Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1475319601
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 02:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785984110; cv=none; b=JTXb0lI8JFVfhWglADFR4kNTYBXn9NKPIc4IStLRKCQpz/b6Q/8RUh+F8GqisEhKlBfgHbMFxkcEZo8jfYCyglkqTkJpHrT0CQbCgXulTFRqfXOpSXAqnsNAFOYENMS1b56nnkAdA5OEjffiTJ4IyTXuKYMAUEkmxueAI+RI+V8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785984110; c=relaxed/simple;
	bh=S15LZOm+KfHL9mBtd6aWQBqL0BNGnQ8cfSi1s5Qwqzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NK72ujAHz+rayseY7+T+GSROBzEACZce5e4uXo75uJ0SvzsYiOiQWVhmFosgiT90H3FbR0zUmWX60EkOfGpFDpyAEIH/R0eD7JMRCom/hq8llZfNxKrLE0nWmCXl1r349MQO1BAVx+3lR6dR49XYiFgz12wHSMtFm65snUyn6qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H7zPE9zw; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H7zPE9zw"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso18173295ad.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 19:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1785984108; x=1786588908; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdkmU1B5dTzWBQ42Bde/rqNgo2V5GhgoLHg+J+XmMtI=;
        b=H7zPE9zwIFuqtLRkftfVodwJwA2mLCMumQofO8NoM3yPsxsgGYY7YEIIF5mh8rSv0w
         nU31ZEPIR0kWaVpx1p3Hjc7IpQ0ixt0SH0W2iIDFq5/OZy9bVw63hHaAPmYnu3ADTX/R
         YxKXGpLZbO92MOR0D0wXIY3Z0y3YRRQBEZE5E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785984108; x=1786588908;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdkmU1B5dTzWBQ42Bde/rqNgo2V5GhgoLHg+J+XmMtI=;
        b=rJLtOKNx10iV9NKx+ABqWYodp+MxkqQmpXpSF5PZ1629kb2Kgsll4gaBA5uN41ekvS
         HocbaRNzBMjVsbmEfet4KUPglI3AxmaBi4UHyv2aMvvrMHSznA5tDVVmzcRpOyP23zFC
         HQteXDacRkVSXRVtQ6/Y89KXkHQsOJmI8PcKNEQ4mONxiNJSyVtVkuiiv/1oN0OuCGbW
         imUDTmn/AgHUTaFnyg8u/3PNk60qS/Ww26G3GdQOvyL/Hu3xitMP3QQ2dJZbXeaMaI5J
         /kJaHx5jQwphleW1vrQK7dnNlkrCLpJt6mjSWQMztV+Mtzj0iDYvtjuvMcGSNiUilzNt
         kKGw==
X-Forwarded-Encrypted: i=1; AHgh+RpFNyJLSVli//jIlT/Q2YKlD91ZdBaTCspZz+he3ABBX+Q/L7IaeAZaWd1Xu51NZ20TyjaVx/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzho/u+mQVHyhlNnNEckJm8jR+aBNSX7bvmZeac0dlJXTQu1iIk
	ROyAQOSTPik7clFq+n8h2vHZi2c3YqtwThCW/2+zbxjNEKYSWpKJ/BM0b/z3OjWb5A==
X-Gm-Gg: AR+sD12JLFUqpZKwQP3AAEAWqN6UXMeKuVHXKC5hbTJuN+w/z2+e2mt5dpBRpCx6PKc
	iSRF69if9PrMz7TiaxFZ+uWpaBrpkfzNQ5HdB5Kw9TDXYlgvQE5EcHDndvKoQKEG3tKKQgai3rn
	gjg73Ar0ttEALU2gv5Uj+e18QNrfpu1Pl8BpHIsi0Qo5RBSk7Q/Ng/I1ff9as4SKnVvfh/8k29g
	yvNQqj/9LZ8m+nRY2b3JjMWxYfab84OR18k2HSk/3jaxwlikRtEpKX01bwEJ2WqlIAk6BayKmkk
	1Ty0UHVlM7p6ad1RlvWHBG5+crxxeedEErfvZHZ8GJp0M6Q06jekXmt5xgBKbPD0L2EbdxQdTnL
	f/DZ0WFmGV+LkftDui/xuqSl9Ibi8X4Ft4TWsU2NW9h4/vgIUV+uq9QPPbtBohsPKr5o/2eHtKU
	9CaGtQUP2pAL1j3UiSHPeDu5im8Fn+5GTjBygezU4PfeGTyo3L++zIrwv1g2+4l1gJcbzttBzWO
	RpKXIxkPAHvXfg7GWiRNo4Xm0zw
X-Received: by 2002:a17:903:3c0c:b0:2ca:b4b9:4586 with SMTP id d9443c01a7336-2d0ca981aadmr143618055ad.19.1785984107913;
        Wed, 05 Aug 2026 19:41:47 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:8002:2a47:a704:5a58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4cf714sm23091755ad.67.2026.08.05.19.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 19:41:47 -0700 (PDT)
Date: Thu, 6 Aug 2026 11:41:43 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Longlong Xia <xialonglong2025@163.com>, minchan@kernel.org, 
	senozhatsky@chromium.org, axboe@kernel.dk, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] zram: reject disksizes that exceed slot index range
Message-ID: <anPz9jWFvXlc8BXs@google.com>
References: <20260804143832.146129-1-xialonglong2025@163.com>
 <20260805115424.a0c8abdb9bbd2f7caa6fb66a@linux-foundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805115424.a0c8abdb9bbd2f7caa6fb66a@linux-foundation.org>

On (26/08/05 11:54), Andrew Morton wrote:
> > From: Longlong Xia <xialonglong@kylinos.cn>
> > 
> > zram uses u32 slot indexes, while disksize_store() accepts a u64
> > size. On 32-bit systems, a disksize larger than U32_MAX pages is
> > truncated when zram_meta_alloc() assigns the page count to size_t.
> > array_size() then sees only the truncated count, so a small table can
> > be allocated while the original capacity is published. Valid I/O
> > within that capacity can subsequently access beyond zram->table.
> > 
> > The same oversized capacity also lets full-device scanners compare a
> > u32 index with an upper bound larger than U32_MAX, so the index can
> > wrap instead of terminating.
> > 
> > Reject disksizes larger than U32_MAX pages before aligning and
> > allocating the table. This keeps the table size, published capacity and
> > slot index range consistent.
> 
> Oh.  Rejecting large devices sounds severe.  Can't we just fix the
> 32-bit trucation issues?

zram historically used u32, I never thought that anyone would want
a 16TB+ device.  But we don't really have reasons to limit it.

I can look into converting to unsigned long, Longlong is already
looking into it.
