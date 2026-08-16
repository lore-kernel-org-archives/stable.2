Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442FB2BCF7F
	for <stable@vger.kernel.org>; Sun, 16 Aug 2026 10:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786876728; cv=none; b=faZGRrtjgalvqs8a85TE7lesUBfi5CR6/2qznOB3t3GoWeVB5ePTLsSHw0eokvmBCrIbZYi9E/Pz6xxGwdlIqL0bScdsbJWExhquTSMC30leGWWShZzW2COq8Y76XXqQlh4CV0qEFM9uTjk2UhWnNLhVaKZszgfB+FPQ7Wlkosc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786876728; c=relaxed/simple;
	bh=E1DtirF/DQyijYx6juRJxgXtDCMrWh5fDkYaKtFffkE=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=X9WjV89PzuxQKNp49B4hirCs4NacTFjxm3It+AxwAWCyBQ08zxPXSFJb897pZtQHdfYUpoZudkJYVsLkNzowCBK3Mqu7zY1aogbJztxOy5kkD+HQn4s1vb4U3INxmXONNozsrXt91iwb3FDg+0Y8davNHWatcY7aCW221W9l1LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXybHgyx; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=pJFpEucP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXybHgyx";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="pJFpEucP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786876726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J6KOR7ml/I3DeYY8E5GuQK4htPpObD433wHZPRRbJLQ=;
	b=UXybHgyxWAv20enrHygljfIwU+Ii9LKHxXYZ3O93VVvqHoynqRo3XVq/JPI+jdRPmnihD6
	4ek2h4SilRXIa/qNMblz+I48H9UEejwY4L6hQt8BCv751XLoxDJNm4g5t3T+E16GVHRNcz
	4e5je2ESlUIPDvfJQDB/v7IvmdjSYEs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-WdGf0SHmM7yZoEr7HnuASg-1; Sun, 16 Aug 2026 06:38:44 -0400
X-MC-Unique: WdGf0SHmM7yZoEr7HnuASg-1
X-Mimecast-MFC-AGG-ID: WdGf0SHmM7yZoEr7HnuASg_1786876723
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4954b1c6310so22662555e9.0
        for <stable@vger.kernel.org>; Sun, 16 Aug 2026 03:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1786876723; x=1787481523; darn=vger.kernel.org;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=J6KOR7ml/I3DeYY8E5GuQK4htPpObD433wHZPRRbJLQ=;
        b=pJFpEucPf5DMeLJKJbdO7d89hkwY8IsKiYvq6ZSvcHOuPuDUK6F2hFGkbiaIClq37j
         oN6Yn42ONARMQUK5Uezx7sV6DsGZNXEmLZ0oDAVCV875FumDIEOlkK9VbvOcqmC9LzMc
         YUlO2RsrLy3swiVkHVKWCGbA0m3wHLZmoj5+kWIEjlnQwHyMWATXz2fIXe3xXM63lm3s
         F0tlssNvjL20XoAqo5YZc3vz5zg8nlVF3BFzbqpNBGZH4vhG7NkX45zE62kvbm/+2FyC
         8kNrLwzHJfN9avw4s3Y40llt0PNgtRHY11ID5mrUqep3YYusXHHvqywKYmfMz7GyqPdg
         XOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786876723; x=1787481523;
        h=date:content-transfer-encoding:content-type:mime-version
         :organization:references:in-reply-to:message-id:subject:cc:to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=J6KOR7ml/I3DeYY8E5GuQK4htPpObD433wHZPRRbJLQ=;
        b=D1ycHgSiU80Ca9LytY1L2LuBy60Za83WPuFZcpsLsauco6nGIsIJbumB0vhWxpMNEF
         UViUS9H8KzA2MNbEBDR/fyh4Bw8mfU2o1f31emJDtr5HaSBjuvDh9G8w3gk5DPuxvesd
         R25JupH4j+maZ2JURTz2RBbu003k+nImJWBKqCJ1C1IIQSP21//JlWXG+1+8y16CJTph
         X9sAooZGTDNDPzvasHY6mpzsZ8wbcv/ePsCQgt/BqwvXM6fB/xKFVTlOGR2OqRY5rQE4
         IbFZ8S8Y3eve2k33nMq6wEZBm62Spg1UOAIDL3hvDVlMlwizYV/s+6MgPSe2JF+pf3HK
         h72A==
X-Forwarded-Encrypted: i=1; AHgh+RrOqRrEkmLfE1ghxrOprrBIiY+/Gm+A3dKaIKCzt/ig3oUVkZATJlaQgDh+Ii2gfLF1Sf+4L74=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNuK3tpY7yqBR+qgUb5YfhG5hD6/NGWRpRPK6lWYsikhCmH2Qb
	hF+10EBvEVLsU1Zs6kKIrXC2NoE2rlZwtLSmogBKQBr7Na1EIwDIe74oxwuMVFyvTmfdF+LHqsa
	Q68lAtHz9pCx/fDHAKijOpDAnbXY4H6lgw5Q1hg9eDe1yySjb/buBS7s7kw==
X-Gm-Gg: AR+sD11tJQrSQEea9qIwoFFiY4zSRXqJ/qcksoW4X09YirEmJC7aNls9Nf9aE7XXEe/
	FjfRoT3RGj2j/KoY0oCb7exf6D3xT6HnTtaIly4GK9vjnfq7GPI8QcTPn3GZLXppR6sG0ifaGv3
	yPY9lz3aj6XbvRg4X6tEbzG26FHTa8M+mLTCYkwU6z8m90F5lgE/qFwEnEAQlo8wFmHjhghaiIg
	vpPbs2WTM+0eIlfzXUfdtOFMRwxiMLBzsA+bUYjpKZR7go/q4am8csaKui8VikxQhOp6HOxCC1e
	2n4ISEumaEcM6/B39OF1xG72xwAuTuKNoWnaAZhwPC3w5iU1qCUMP9po7OP+n9FC3127Szh3GuY
	3/UgHbuidS5M=
X-Received: by 2002:a05:600c:1f91:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4998797d111mr236172405e9.15.1786876723020;
        Sun, 16 Aug 2026 03:38:43 -0700 (PDT)
X-Received: by 2002:a05:600c:1f91:b0:492:4e09:9fc1 with SMTP id 5b1f17b1804b1-4998797d111mr236172095e9.15.1786876722609;
        Sun, 16 Aug 2026 03:38:42 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [2a10:fc81:a806:d6a9::1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49987b1a31esm211201745e9.2.2026.08.16.03.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 03:38:41 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
 linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 Taehee Yoo <ap420073@gmail.com>, netfilter-devel@vger.kernel.org, Pablo
 Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil
 Sutter <phil@nwl.cc>, stable@vger.kernel.org
Subject: Re: [PATCH 6/6] netfilter: nft_set_pipapo_avx2: add missing
 vzeroupper
Message-ID: <20260816123839.3670e5c3@elisabeth>
In-Reply-To: <20260815205750.169336-7-ebiggers@kernel.org>
References: <20260815205750.169336-1-ebiggers@kernel.org>
	<20260815205750.169336-7-ebiggers@kernel.org>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Sun, 16 Aug 2026 12:38:41 +0200 (CEST)

Eric, thanks for taking care of this.

The patch looks good to me, I just have two questions:

On Sat, 15 Aug 2026 13:57:50 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> Since pipapo_get_avx2() uses YMM registers, execute vzeroupper before
> returning from it.  This is needed to avoid degrading the performance of
> any later SSE code that may happen to be executed.

Out of curiosity: was this prompted by some observed latency spike in
execution of SSE code, or it's just meant to satisfy the recommendation
from AMD and Intel to use it while transitioning from AVX to SSE modes?

> Fixes: 7400b063969b ("nft_set_pipapo: Introduce AVX2-based lookup implementation")
> Cc: stable@vger.kernel.org

Is this really stable material? Skipping vzeroupper might have a
performance impact, but it's not an issue for correctness.

The main reason why I'm asking is that, while vzeroupper might look
harmless and obviously safe, it actually caused CVE-2023-20593
("ZenBleed") on AMD Zen 2.

I expect systems receiving stable kernel updates to also run the
patched microcode by now, so I'm not overly concerned in any case.

-- 
Stefano

