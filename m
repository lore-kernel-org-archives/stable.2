Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D774A99CC
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790595253; cv=none; b=ZK9kvinMPNnK8mYHz9DoYrld/v4EmShUaSUo+zRV9CdZ9z6laKVzjb4obIrRlTnbr2FqhTCUjh0Vyms+uANk406VkWb8kUw0fWIU6oFYfgNdEQCwacQKhm8IhTxe+7lSSZ0+EwgAx3LvBq2ulUqJTqIWAjIIacZ2dowWe9gB+mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790595253; c=relaxed/simple;
	bh=Jt7kPh9XkqywM/6h7nDHDZz6YThHu04q3E5/FsPi8vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rp4i8kIYGMwtErQK66RRDIxJHB2DkdMTwBT8NMG86E6OFvy0Oep3m2E3cng6I4+IzpSGNxUeGcLZI945XeD9nObJlpUY67MizjKFL+UZDTcwlsZXv1YQh2sku4Wn6/AiDO3GhnFViXTrHyxXXd+yuKggjyFe6LlViVzN8KunZQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=v3zBVzMI; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3zBVzMI"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2d8fd7a3f38so67585ad.1
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 04:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790595251; x=1791200051; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bqZIT4CuwAtsItk7lmKS5Bq3DdAgNyIdg2q2F0jacX0=;
        b=v3zBVzMIe5XZKwkJU8JVgJoevTo47tYiMz1EAmEAO3KqUd+VrOKzhQm3zV2jVDqMpA
         hOCda7bFY+EVBmLYjrcE67EzIP8NataIxNcEu76r6Zl8Kd73ynYVOFVpqddk9Cv55cCz
         Uvl2u+wRCmfXRPJtT/HExhCiAhkacr3LzdgHKZFsSqYD/SDdy55t8yccoPq0nsNcXnSS
         birKot3rynElkX0zHjB9KBKTHOAwxcZmbZ6TUcFKMfLJeBW6TM3V3pa5KOV4Jli/kK0C
         cx8Xl1JJwRYro5zy8JDw/nLBKuP/H3BhQR0Kjt7vqtXUa/4OSWIZsuiKFGcIzUK8MV+u
         Z3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790595251; x=1791200051;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bqZIT4CuwAtsItk7lmKS5Bq3DdAgNyIdg2q2F0jacX0=;
        b=smT5Sy8dAoNkc79S0AWM7+5yS8cXf5AU0vD/xUH7vaNtg1dK03WBK5kd2iVbxlZwVf
         RHed9jIxZqQsJwXgz4GGZEeyc5xpaYmMXAmtCMAD2xW1vay/M3zByKnb969ykm+29aTZ
         /ZadvRQOyDM2xSjJXQBzBX8NcX688OsCVB4i1ELttmqTxRR+D1IH0o8q6HN6jGTsomNG
         Wk/PNksb5dLsUZ7wDKF5L2FlyUgKXwgYOj6NMlU/YGYT4bNqZezB5Dnw8Ik/KauP0vlI
         C7zyprXOjiWoWA3b2OCyX4EgMoDNN5UqkMdty7b41eKZAAh5MwfXPxuifKOCZwrPc8Ua
         kVoQ==
X-Forwarded-Encrypted: i=1; AKwUvBwrZ+pySf0pMNBrZPkTomplZPgJ8xDc1v5U4zEm77a2/Shz+KtxkfXgNg1t68a3ENvErybZxDg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCIHAKoccSL+b+8kHJwf2JcXzvHDZVQGTNaUp0MRcrsIx3E5oj
	eauCvrRm/6d+t8jvYyeOiSwt9hPzzlJTgMhP+2XdjYpGtxAPVs/uokmCy8AmAUGIwA==
X-Gm-Gg: AYBFou3Olqqi+cqgu9UXq1R1QmycRpeIvUDfG7A6FOCL6KVfeCfIIuwxgZ6PR7AzmFJ
	yucXk/GWdsX/FOle4thFhzI0W67DeES8shVYJCGhz//2PC2V40k5IwPV5KBGDklAHtGYIJVc23f
	G8hkxdCtNmQrzD8RcAwV0W681AHnjAla1HgnXfOAes35LfltB1EzVQQm0bBvLLwOa5v9xz0N1mR
	Wd4R7kmEjVbfdBT9KY7fHFYXx9YANZKIVdwzezdslDa5gTP0xHWBuGnSbP0Sr7emVO4gxBZTVdZ
	OC4qpbRAmyitifn+fyzQOhxetAGl5fTduEpKFnk1OyIr/b2KZRt98VirwYnb/oU9bymYm8hn/xy
	Ck56VQdvqDf/cHCImnzcpE7hZPQHQN6ov+xDcLQjxhxYukgQMnhP+UPn/dGUvDDPGfWq6nwCdE6
	8Ib27svmTmNeSHeB0A9vK7TjKdQEY0bEoQUynCAM4jzPcWPtFaWUMndET0hsroP+ESO9cqkVbHQ
	omsHLLxOu88rhoi5zC0ubCOgp2NKK3S+236
X-Received: by 2002:a17:902:d54f:b0:2d5:c090:3810 with SMTP id d9443c01a7336-2dfa615a5b9mr4545925ad.2.1790595250807;
        Mon, 28 Sep 2026 04:34:10 -0700 (PDT)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0972f111csm26688235a91.2.2026.09.28.04.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 04:34:10 -0700 (PDT)
Date: Mon, 28 Sep 2026 11:34:01 +0000
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
Subject: Re: [PATCH v7 2/9] iommu/arm-smmu-v3: Pass the parameters for the
 invalidation in a struct
Message-ID: <arpQqQXkdkNRBn-l@google.com>
References: <0-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
 <2-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2-v7-e84261bbe7cd+2ea80b-smmu_tlbi_jgg@nvidia.com>

On Mon, Sep 21, 2026 at 08:55:10PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> These parameters go to a lot of different functions and the next patches
> will add more. Put them into a struct to keep things tidy.
> 
> Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Nicolin Chen <nicolinc@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Pranjal Shrivastava <praan@google.com>
