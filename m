Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42779342CBA
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784772819; cv=none; b=dJWRB+K5eQ0mczAlMCwt2yB4C/1bEKU1/7pdeycUrpkOvJi0TBtOve6QsvD+qkpENYlM7n2tloMe0X+Bx2gGdxKFopvq14kcEyfw6MCoPsjJPYjdJIg5hx56LVzM6q4/l0UGKfMLEVeBD3h3GE6lCY0AWQVlWvq3xq0AAE9XMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784772819; c=relaxed/simple;
	bh=Pb3YkLqv5VAJEZhN7Iy5XU//vgxrVXvJTwFLEhbQAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unHtS1n3a/L4Wg/UCHA9X7o19bgBlg5gmHGQbeyD5OZX2W4BG5FrBLI77UqGl4ySDm0V4PsygHV/Nzyn5JSCabbfDrMV8HAKQ+l6f3Q9xedpPgDa9Q3avkngq1XlDTXdQAWQHsz4A2s/jIogbcEcsoCkm60v5qPsQvQcR+Hl0lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=LmPFJl85; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="LmPFJl85"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-92f0b5ed131so12371785a.3
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 19:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784772814; x=1785377614; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63wl+OLSuyt8DrGkM/Vj7SgGoUiR2AzArICs+kt8mlg=;
        b=LmPFJl85NOZyZkDAtdb5wzRXiTTLyaCxPHIbFmu/TeET00oYZ38w11hDRcOyCzsD2e
         tCF2Dra3xZfV81mdckJa1l7zt5QlYk7/IggxXpeS9CVwiw4SFOkKpm2BxZy8Ngpwpnnw
         MtB74ja5MZwXIwMdBuBaVBYqHrSmy59qoRUoZE7/TnleNM9qlQry9ulVApCDN+peU5MD
         TPGoOPiSHnuvkxoLEWN2BwOhLaT0h40EE1T8QH7OE6btach5aMDAPmi2JkyV1E8OxZ4U
         +4m4gZ2HPsolj4OrAr3VFSUs9SuAZqFotEKdpj4bpTYNTxOdkzu0VmQ2gt7O7mofNyl2
         qHcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784772814; x=1785377614;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63wl+OLSuyt8DrGkM/Vj7SgGoUiR2AzArICs+kt8mlg=;
        b=BxPPNYd57f2loH5Q2IY+CR+nxRcGKwolGE2Qf/wnp0NoXEaSVI9UeO7GJoYuumkCuM
         IE7+T5tj/Bj9IMmIFWkCtx2BHdKuTTlqb2t40F9OKlBQiPiDIfGXhKpBHvD6VQY9gBci
         GKeEeo0RQsgI6CkAINmVtT2rmrgXuoXpobA+YlSid2WdPaoZSkXkeNQfCkWhirMc2kPt
         43ahc4uFfC6FwI5D0q6lK9gtbi/1ir96PrCYHFRDWhc+jsVjyYLmAwk3JJRLXYutRjXa
         EC7ZbW+S0QhsUtOUjnhhzlPUYbX2Bt+l2FIcqX0qWQ5rKLeRVnukiorSdSltsYHuvxg6
         UMFQ==
X-Forwarded-Encrypted: i=1; AHgh+RoWXfvXUH2+N43YaFv4f9oicaQF+xBkMVx01VFX8zGThA4F+/M9/F82shjrr1fkijDdO9Uth8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmG0ML0nk120mKWHAmi61CVcazDT/NHKhJew6AVRDTR3knJRx
	i+s/YlS3Sv0mx/MP+OB3+XIvWclLu5AuVy86ixYAmSJakC8NkTHysHuiOuWfpJltGiM=
X-Gm-Gg: AR+sD10nktksyPy297g4EOYEDlZr2l1gBc/6efM0s4ShPAFBTayWil2IxFmv+hsOxIf
	j98DypqGPZysavrxLDHn0jTCaNJchd4mwayNNgpeJt9vfTk+e04/cnnFALPTNZieXE+Y34YlpSl
	HEPPKMoCdiNTJONPbs+EuN4BHaBpbljqqvflOWNTDZb1fPLdXx0s7Dq4EOwKGrBrh7nHo72JB2i
	HBEPrW5mfXbZXzZ5XWI2xfDUPDY3p9F7z0mQnRuI5bTueRwXQVWtKs2oW5WCuJYZY5dIJ97VX4i
	GWY/CwCPp9a6wOWyP3WrdkWsdQdZOKznqKLBKEUSaZ0icAkT5x+PCf02Ty7Rjmxs28yOLL8K1Ky
	fYCv76AlBBA21UYuneYNmJGam2xVlP7Ul/7w0hlx0FSIT6i/PmsPIXdo5di/viyNap6OFJRNE81
	Ut
X-Received: by 2002:a05:620a:1726:b0:930:9a5e:bbc3 with SMTP id af79cd13be357-93103aee31bmr115743585a.49.1784772813954;
        Wed, 22 Jul 2026 19:13:33 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-931062c4ea8sm22128285a.28.2026.07.22.19.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 19:13:33 -0700 (PDT)
Date: Wed, 22 Jul 2026 22:13:29 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Hao Jia <jiahao.kernel@gmail.com>
Cc: akpm@linux-foundation.org, tj@kernel.org, shakeel.butt@linux.dev,
	mhocko@kernel.org, yosry@kernel.org, mkoutny@suse.com,
	nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
	roman.gushchin@linux.dev, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	Hao Jia <jiahao1@lixiang.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
Message-ID: <amF4yRobGT9x67y3@cmpxchg.org>
References: <20260717085151.22822-1-jiahao.kernel@gmail.com>
 <20260717085151.22822-2-jiahao.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717085151.22822-2-jiahao.kernel@gmail.com>

On Fri, Jul 17, 2026 at 04:51:50PM +0800, Hao Jia wrote:
> From: Hao Jia <jiahao1@lixiang.com>
> 
> Zswap writeback on hitting the pool limit is broken when memory cgroup
> is disabled, because mem_cgroup_iter() always returns NULL. Therefore,
> the global shrinker shrink_worker() always takes the !memcg branch.
> After MAX_RECLAIM_RETRIES empty walks, the worker simply gives up, so it
> fails to write back anything.
> 
> Therefore, when memory cgroup is disabled, fall through with the !memcg
> branch and shrink the root memcg directly.
> 
> With memcg disabled, shrink_memcg() only returns -ENOENT when the root
> LRU is empty, which means the total pages are already below thr. In the
> absence of heavy concurrent zswap stores, the loop then safely bails out
> via the zswap_total_pages() <= thr check; otherwise, it will resume
> shrinking the memcg after processing the reschedule check. For any other
> return value from shrink_memcg(), the loop is guaranteed to terminate,
> either after MAX_RECLAIM_RETRIES failures or once the threshold is met.
> 
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Cc: stable@vger.kernel.org
> Suggested-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Nhat Pham <nphamcs@gmail.com>
> Acked-by: Yosry Ahmed <yosry@kernel.org>
> Reported-by: Yosry Ahmed <yosry@kernel.org>
> Closes: https://lore.kernel.org/all/CAO9r8zPVzMKFbCixxD-qgtRrkFxWVrHiZZeLc=eyTPKPVQgX4g@mail.gmail.com
> Signed-off-by: Hao Jia <jiahao1@lixiang.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
