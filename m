Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEC640801E
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 20:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792009782; cv=none; b=J8vRo+hz4r9Qk4SFTMr4YsNORXM5VIfdlqRKT+JN6O3rAPavqWsd2m5k8KcwzGM2MxL+QWyQV36q64nx2KcBJyp0WxG0XjndWYzdf8FYgiRlNbnbwBFKZY+QYxyROnZRk6S5JHcRO8amfxIhNU0OjNk0+G67reWU3WQR8IXtKUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792009782; c=relaxed/simple;
	bh=yW2JRdI+sHVXqRRLn3ro5rxRmw1YQMKkbezj+YasMm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENtgd/GfMOa/PT18/KdK6Tbk5PBDCSyvhZ6mFYV5qTM9aCje6h0pECMxgDoRMPdBWQiEKUkLGSC+NNi2j+0PWpXxPzvvcSzzf5bfB/v9H6IWGyVqKPmwejhdHTx3Z9p5tmKTdfEKhHNYeLEUhVUJ7/nEqS68titRWTcxHSnV62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=rdAxAsMm; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="rdAxAsMm"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5352a876d5aso58442581cf.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 13:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1792009781; x=1792614581; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8KpIQc9Vyaph3vkgeCaoJ68oVGAH4Ek85s5zfjWhrac=;
        b=rdAxAsMmZjVc+aFoV7+zMJ2GvAxRjMz/tFtzAatt9ZbyWsHrVKsMcAa+d81t4EGrJy
         kdJql+zC5+eQ+90faaXFS4Sb4K8hOpZhcCSGW8kvnLn9oCiBV2wDxDjnmMVl2VCmQ7XN
         Uwg6uggwkp4CA/yv4jlqeKfvCcxqo81sK4jH69lYZ+5N4JHExW62PKKbqis6oA2XRVEt
         Eunxjf+o0xNL95IWFknf+wI+8v6qCuOnhmKG8gzEzmFU8lQuzHi6xLLK58k7qPSRrX9B
         o3XJRpEKzSy/9aa2JFaLclIr+ZhFKrjLoy654fdxJNu2b7w/B3M5hhpnJuYZx18si2QI
         sQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792009781; x=1792614581;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8KpIQc9Vyaph3vkgeCaoJ68oVGAH4Ek85s5zfjWhrac=;
        b=bp5+UnS1GDARU+O94tKjMF49xuvcX6YtJ/4bkOReffvsUDMjRD4hjPsiCpclz/b/Tf
         vcUkmT/sh5WnRIXmEuUdN4Tg93IYybzOmL+0LNel7AC0Zotl9mpL0Tsf+x5OuPQfJQjY
         PT9cgubui0jYfpPQnr/lCivcM/oe9kmh5Q2ZUuto27P6XqSRBsPZdvmpPeAIydXBV9cg
         R0u/fyw6n8/iTBrcfjNh+Cjy6uBJEh8K/hauKy5wQeBHCh4B2bBuB0TrocSXr5/KAJn+
         Eyn/TLr7uTzG5YHe3PP2Z1wgZT077aKSv/BtQnkAx3pbaTFHOvZOOUsdXHCqHmEdJFhe
         OXoA==
X-Forwarded-Encrypted: i=1; AKwUvBxV7BbWgdeqsg1lWfEKg5QQSSRvpe3aekm0FxOYYYL6kZYa/PEPtykvpqkWNH/5OH28q178uaQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1lU/5BvV2MFxfe3rKQ1IJ2P0DfBVDRVZcT3RsCZgrH2TDqmaV
	o+Cyf5o7EIl606+ybns+VD5Myeikg+XBdw5k/MsGKDHrhjYxsrqW9CPzIT53peBCq5Q=
X-Gm-Gg: AYBFou0qyaeCW8dK8mKkRUJ8JDbI6SMZiEBLnvsKrG1XkhxzXY3dySdOaQ/jI7UOTTd
	h7znWdyCl8pVRKI9kIxa/rBe35vVNXym9Q9IUGYWxWqfP/bBeEgEzQgbrmgRAudAvYaFsvs2w5x
	XQPM6i6dceqqMsGoh+tto8pEE0BnuS+aw0qikRjyxH//zmp0X+iRGGORArmCiH6D6iQc+8QamEj
	N52SBt2zijlmsree/Q2sr8btCTG1ubg2+sqR1Fm5vgQkoHxCyHSuq929n7Z8PHp7tW7pgttRcXx
	rtDg2Ig/l4GpZWztJQg4NpB8Au0/VrxkEmc8WF+l+3QuS3yZhV6sjzsH363AIskZldZqUf4ouof
	dhombj1EtxPtzblqiRTxVirrkwbnWlvND1yfH8VojlgdMIy4vEzEZ/we4GAQEU5gZg/BExFzr6r
	VVZpJaemFiCZdmc9WcuqDycWQeID/hXxZSK0hN2Zd48NgLxtj6kNVLb4cht2qyrP1Tgl5W
X-Received: by 2002:a05:622a:22c5:10b0:535:fc2d:b7c2 with SMTP id d75a77b69052e-535fc2dba9emr47727251cf.33.1792009779058;
        Wed, 14 Oct 2026 13:29:39 -0700 (PDT)
Received: from localhost ([2603:7001:f100:5081:9526:3c0:45cc:5ac6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5361281f0f2sm5986961cf.25.2026.10.14.13.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 13:29:37 -0700 (PDT)
Date: Wed, 14 Oct 2026 22:29:36 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>,
	Usama Arif <usama.arif@linux.dev>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <brendan.jackman@linux.dev>,
	Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
Message-ID: <20261014202936.GC371161@cmpxchg.org>
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <as5q14OsbK2CmOrh@thinkstation>

On Tue, Oct 13, 2026 at 06:37:20PM +0100, Kiryl Shutsemau wrote:
> @@ -4127,6 +4127,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	return page;
>  }
>  
> +static inline bool order_nofrag_promoted(unsigned int order,
> +					 const struct alloc_context *ac)
> +{
> +	return ac->reclaim_compact_order != order;
> +}

order_defrag_promoted?

Otherwise looks good to me!
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>

And agree 7.4-rc1 with CC stable is fine. Sadly, not sure if anyone
but Meta is using the feature right now.
