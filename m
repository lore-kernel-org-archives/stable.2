Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FD4E3227
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 14:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790607430; cv=none; b=e/HIyv9uCchX80BeGJuEnwMSl5GkXtz9cuc4LUdLi0TpD+3AsXXqoV+x+fiILZkdG6oFquTAVvYvj1fLCtXkaOA3nhNWAvAgRi3i+cIqARo7Dckz7JNty9n/WrPx+aYAsaOHJBXSIv/vwsBoJ5aK4xJMBqiz2mHsgYubCIdZEOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790607430; c=relaxed/simple;
	bh=hnhQkpKoMw2Zhfw9DM4few3dVnMySo2yIHKJrwxV20g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZp92/UHky+6MDoX1CNnZyHUNMWXY/U1RX1POxWVifodKrAATmE5jMahsdkB7Sjoq9ohXqX7prfoukDlw1p3he62++FnhC34aPtqDiZUuOF6G6MQ/kvipq03ZMeTL2yb1Z73qBQMRIuwiesHRDLdXl5ajKV8IP+DfOat1nwbeuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y/jZ3mG9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y/jZ3mG9"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b445a84fso82045ad.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 07:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790607425; x=1791212225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Go9hn601ofYGhTbmTXvodFkeQSZutx3QY5olFYU9dfU=;
        b=Y/jZ3mG90k+9/OiYbELY+hpBvAWC2O7pfXFE+zOZk7RNy5sDEYHoKttkUiBS67Spm5
         yO8lPO3VAQTJD3ieeZULPxFdhiuqTyCfHmZ0qJc+Chr/M7N1CAW8tsZZ+l8QxoETpZfY
         APjq8dY+T/BSTBXpfsqEYW5cWgETdh/bTH869vAmtD6rN05PkpVluURnkn7r+uTYY/6G
         kTrom5m27/2dqFQmS4PsjJ/EgiHaGIP29Hzksi4k3ToHFJkuwUFv9vxa5MGO80YyGHj1
         BqC5YJrgIH4jrFGbbiVbKRT6wgw+m4xfcmzndZRgpSY7V5pYWXG0bs054yOdAYuYoSma
         rXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790607425; x=1791212225;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Go9hn601ofYGhTbmTXvodFkeQSZutx3QY5olFYU9dfU=;
        b=bn4YlCFaFM/tkSiIgfYAho1UQ1Ee5SxYg8veOzWc5/M7DM4dNhqDzN1rbjQZztBS3Q
         XkISereF1slsDjB9TkVxhREumL+miufuiht8i9I8vj+xH7M0S/Hg+DqAVk1PE7i399xe
         qyfiCnijGlGAmxXqflHoIIFyuMng3JshmAUBSrKmK3pJgBHRNtRE2GPckKZHlCAsNfhN
         jlwy+Nx5OY32YMMg/x+/weQc0qAi6vJRJyUXRvss+6hoMG9l7GAxVsUJfFmMhAunZffV
         KsMOxT03yojahyk7zHJjDP894s8RP4hUEVzMhIaHU7lSDXU5L2fA8WYG+kisYF6yiAR9
         y+SA==
X-Forwarded-Encrypted: i=1; AKwUvBwTXMtig8l/71HqzgJ8TlP8u3K8KKck4P/saPl9JJTHf3F7YJ34OvUD0SFSnulAybOZtgow+kk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLtdWphhlodq10ob1hdwqAvmAhcBHjVZmlfKdUfduZ1Cxmv4BC0
	GStU+mlRTA+X/KUrIYpngPjrY/5KKWYKIpCu4wdx5WX4m/1T1TXPGmvz+UHpeuO5Kw==
X-Gm-Gg: AYBFou00kdMhgVTtnyUR/h8roFHUfDgXA5R0Dur93uovLB9kKMyeXCyY1lvvns89XSL
	AGqF59Roav/vr0olXthaqdjRExs5JfBdYu6fQqJgf0iWX/t7KxQ1XlUmxl8Nd1uQx8bB2uY9i4a
	QKjGsiNublDRJC5lB5D0/fahC3V3sYrih9fNajyPNwzlbnBXMMmvNBpPCEEL6IYRuiO2WUr+WTK
	6aP6lfmC2S4Abgc6NfiPv/BYvAOhiDJdUtmSzr0NQnTIFDCY/zC84oS3w9NINwU5Xa6YqB3EBLc
	/Z8nW8UZUEt8cHAnjT3C4PilRIITc0jyusqxjZowlAS/40QhyWJHzubnbEQueSd7XDWutYcIuQU
	oI5QmWimBxef3/UcrhCpH1KUimv4ecx0Ih6sDZ9ozMH0KqGsg7GNtagMJ7DeX19d+fQZIc4k2x2
	sazWXVwWr7upHCo6dKZV+WHc62qi9BcIZx7XBirBD1DvnYkqQLW5M6tmMorgTQyg7Jbaas+GuTm
	GCeTRzXPfPA8xIYyh/nDemc0zWyz48nbrs7
X-Received: by 2002:a17:902:d4d2:b0:2df:42af:2f9f with SMTP id d9443c01a7336-2dfa968ef1cmr5442355ad.1.1790607424172;
        Mon, 28 Sep 2026 07:57:04 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9feddd0sm7198628a91.2.2026.09.28.07.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 07:57:03 -0700 (PDT)
Date: Mon, 28 Sep 2026 14:56:54 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Corbet <corbet@lwn.net>, iommu@lists.linux.dev,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Will Deacon <will@kernel.org>, David Matlack <dmatlack@google.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>, patches@lists.linux.dev,
	Samiullah Khawaja <skhawaja@google.com>,
	Mostafa Saleh <smostafa@google.com>, stable@vger.kernel.org,
	Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>
Subject: Re: [PATCH v7 5/9] iommu/arm-smmu-v3: Keep track in arm_smmu_invs if
 range invalidation is used
Message-ID: <arqANvAwIz6GSXJp@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <5-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:13PM -0300, Jason Gunthorpe wrote:
> Summarize if any of the inv entries will use range invalidation and if any
> need ARM_SMMU_OPT_FULL_CONT_RANGE_INV. The next patch will use this to
> avoid range invalidation pre-calculations unless the range commands will
> be used.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
