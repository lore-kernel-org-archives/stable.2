Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 260933A257C
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 07:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788851564; cv=pass; b=u7y2bBmEG2H+nblYT09XU2VsM3phJNSwVVKgfiNuixNc9i4iWJHXPaDtnjWH2MlGCIsS3VKv0z4DM83hCQEnp9MHpl1ebAR6disOGg0K+n6TBukdyZQOelctJIPyXtF0wqC4gFHk3HoNsvkMOnsQnCNbuPFmEMG5T2Lnc8b6ROU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788851564; c=relaxed/simple;
	bh=kYtRBGff3Cf3tt3/PvyqbO1QmTw52cRguqV6Q0iAHR0=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mkPZ/HqkDvJKag+grpoG4tv8TfAdo7zfHrZDyG+WxCAgekQR9OYXCFTx1ohXxUh91Rmy2jzbbmiwC57AL4XIQ8sRs9QTOD+fjljEXSyu16yjYJHqofa7qN1dDIT/CuZJymVUpl3ouXSTELwS2mKHwl++U4l5PQgCD6Z95hqPlbY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dxcys2xJ; arc=pass smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dxcys2xJ"
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-5c5ac25089bso1980719e0c.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 00:12:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788851562; cv=none;
        d=google.com; s=arc-20260327;
        b=h7uHDGzTlAUW0RCjIpQimpiewx/wD8DiHuT8uGn+6Lx68C/FlOEqFY9FKDd4x91boW
         p7FweuS509jW8IMr/q7DDJMg9UBQKuuKaTM2IrRKD3J1X8ZwaIyhllVsYUxIqlFyqabX
         ZMRLdb6QCfD79aSaMok1EFORtLEwJctEhe5Wu2aeC247rE3JJFR6O2Unsvr9T3peHsOG
         9dv4DmNzaOf3kaGZIGN+OqUE4bjptGFjNr0wJbRidglqiBsKtWLXqYUGSb/2ZmC/+YNv
         wRi2nlx4G7tE2nBXygMi7JHZxjj4ARNwf38LGHdiu9Vj+KBUfrXLYbKIr2p5JjpTXspu
         W6Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=qsLaUxYbGMpI4z4uQbUiwjTKmX/vPTtkRhbslycMFDU=;
        fh=rRaFIw+V4K8W/f5ofw8wVomHTArVS4NbKi+0fHUMkEs=;
        b=G+TR3lP6Vx3j5PuGpHjMTUrWn9Mv6+1g2geUFRmRVHRf2urZSHyzWvmg7VXr5mPYbU
         keZm2dyPwMs+JbK+8MS4YhLwR1L0eZg7KyN8RDvdeFtD1pqz0+InnPKpZZ+8EvUaCueL
         Fnd3TlLk+xctPk/hJ/GsWI3gJJJWkxhD7y5fI0U+RrAu5sOuk39Wl0q06KIMpw4Weig9
         FmU4vEGwAEwXZmt+Ay2OxjjOymY6I+YmmWhTwvvNOKK2B6a+6FQdYxfUWDPKXwBcAAHf
         y8H0sT2gjjEJKHe3YibTJPi3kJN04MIt2tuz7UV1dtIMev7AVmzCjcL4DR9o/6s189EE
         xiTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788851562; x=1789456362; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qsLaUxYbGMpI4z4uQbUiwjTKmX/vPTtkRhbslycMFDU=;
        b=Dxcys2xJlv1bJU1/poc23s8dTEXI9jvI6QGpv3P84aiOaXWBx12Cu2conP0kYTdpH3
         R3hMPT5HYO2nUS4bzoxzDYB9EXCPEG0doJA+fVusoE9Rz2I4yiGnjGhttu/cDOYFlRFH
         zsA5Y9BN4ChZptL2cu4YMeepSoQ5zia3MS8hathZKO6OCbLg62YH37FiBUXf3P7N7tEW
         I1RoGHXJAOnxafuMmMhW0bNeHSc0JjToOse9gusEq58HAmC7np12zcuoack5Ko9erQEz
         nsokIkFXqPtHHSrJWLrcC5t5yq6ZAnp+WrpS4MkK4dxPM9K8uiciawUDREv9JHn3Zl9u
         shqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788851562; x=1789456362;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qsLaUxYbGMpI4z4uQbUiwjTKmX/vPTtkRhbslycMFDU=;
        b=mISLqOOU2oiKJiHim7hOmOlGS8w8Y+y02zefXaPtGrDo+RImsp4J7adkknCSaQrskY
         QSj7GASGBZJcxLZJ9emmuwZsWCLYwsN7bA7BU7RTyYdCCw62XNe8mq2Q1ilFSL0iRlhl
         kGxaPNIdd2qkBbvlSFg3DYPB59oH4wdUITgfFt/bfs/zUXBu7+8h5Qu95mcX5yOKM/cq
         OvhzqXlkI7hcrQxKoOuCH5dQsKCq06uG9jtApD8e+rE5zoUNGV1msE5vHH9rxZ8Bn+0N
         wAHwj/8S4Bw7RnYT7LDuwu06tlmO1n2eUsnQlK33XCtmiTJkf7fp08LXEYBzSL5an3rL
         K3ZA==
X-Forwarded-Encrypted: i=1; AKwUvBxjWjaOPFolRuA1FH7wKVMVAMBkr+lSxjyNOKvqVXg3Fnd0X/qSzW+VzH98iP7TWlDgDZxqM2A=@vger.kernel.org
X-Gm-Message-State: AFuF++lADxIqz4hNp1RRLy8IxjDyOe02c1zdZMwu70JwbwL+/jMEnbKR
	uxBB50MQ1DK9jWwALMrCDDYOBV0aApA50zWiXjCYUdbtM0iHBf6gh7V07EwvltnkbA0LDIdrNBN
	BZjQmivVz7Ph6juYPadyUwhJEeoAx7Ig=
X-Gm-Gg: AYBFou3M2Bbw0kI1Fg4qom34SuPWLrQ3yLKozXOD80WPmj/rmag3qDu6ffhJYCw7OJN
	kNG+XWWQuLWvgdXZWSvXEvHqJd02x7Hxupn3M+hWh4L/X42tVhYWE5I15w3yeMl6Gk8bIr0Lyvb
	qpd5y95Ahx0/ML+ybgrkWFt3vVHlAdv59iv2dT5/xvnVv9A7w3JhMgZISWvRkMNLK5tpcCti3WU
	24WiV8GJlpNm0eALlOtIj9Le1Ns1bjANd2w+GrNAhZJQAbxhfZgNatkOaspaGC5dGslzv/J8E+L
	ffc/2O0PLJy9vUJkLuMYNcSgaXAWfTZ/cCZ4uK/Y/2M6mthvpDbeeQ==
X-Received: by 2002:a05:6102:61db:20b0:78a:700c:ad84 with SMTP id
 ada2fe7eead31-78a700cc36fmr3564272137.9.1788851561548; Tue, 08 Sep 2026
 00:12:41 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 8 Sep 2026 02:12:39 -0500
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Tue, 8 Sep 2026 07:12:14 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Tue, 8 Sep 2026 08:49:32 +0200
From: Zhao Li <enderaoelyther@gmail.com>
In-Reply-To: <20260905193122.76f5d3245cd2e0603e7743b7@linux-foundation.org>
References: <20260427145247.84157-2-enderaoelyther@gmail.com>
 <20260428030712.66256-2-enderaoelyther@gmail.com> <20260428113037.88766-2-enderaoelyther@gmail.com>
 <20260905193122.76f5d3245cd2e0603e7743b7@linux-foundation.org>
Date: Tue, 8 Sep 2026 02:12:39 -0500
X-Gm-Features: AcwNN1XwTG0-VWWtLuCWHyxR5vlmphPm1tauraRmPLL5-TyLDFGlaKBhLxDmXoU
Message-ID: <CACHPgzxQ5ajoo3yrkXZgkmeDgOmOQTZxHpJcDc8P0GBRLvP8FQ@mail.gmail.com>
Subject: Re: [PATCH v3] mm/hugetlb: fix max-only subpool accounting on
 alloc_hugetlb_folio failure
To: Andrew Morton <akpm@linux-foundation.org>
Cc: mawupeng1@huawei.com, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Sep 2026 19:31:22 -0700, Andrew Morton wrote:
> I do like to see a clear statement of the user-visible effects of bugs
> when we fix them.  "subpool quota leak" sounds bad, but how does this
> visibly manifest?

Thanks for picking this up. The added description accurately captures
the max-only case.

The leftover used_hpages charge reduces the free space reported by
statfs(), so the mount can appear full despite having fewer allocated
huge pages than its configured size= limit. Later allocations can fail
with ENOSPC, or page faults can result in SIGBUS, even when huge pages
are available.

The patch leaves the min_size= reservation-accounting case unchanged.
I'll make the user-visible impact clearer in future patch descriptions.

Thanks,
Zhao
