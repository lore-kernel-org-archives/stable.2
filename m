Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD0A402420
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786570265; cv=none; b=p3YVcyDGQwGDAmeF0NMFha3G8YroimqoEG9QPB5EXko7rFt4QKJP4htHzdS1MWvnHbQm250RG9kPKOu8EMwl6Ryt5ZNs/qaXJEMBcqet/vwufwXQERtaiJwGTO2pM4dxyhaiym7k1D7w+zE+MrO2u/xmHWsHSrSKPtrF78qTks4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786570265; c=relaxed/simple;
	bh=zx6prgcMBq+aEKupMGxkOYncXvrks7n9WE+aPL5/vmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g9Z4eo5EnTJCtbpvPZOYWMrUmdHns3vkkC2BE4QJI0nN+z3h/3qf9Ncy4TTALNJQ/qYNx6V/6AaNzvpdOpxnHV8ioXJ/X7orY3NjmHPN+2Cn6W4dOmD9GaWjzq6h+WDBxgXN4dYDye7Bsq0vkBMcGqfv+RwdrNQ1pZ3T7Ay+YrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m6W9AZaF; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m6W9AZaF"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ccdf36f63dso17495ad.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 14:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786570263; x=1787175063; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Br/qW24JarGLH405s/rLwe/R9vyAJXaj4x4ugCqjcmg=;
        b=m6W9AZaF5nrK24gKaJrVJYbNwBv5cN3tAhBMcvNTJb8LC8wKAhWTIOmAmmZ8aKF3Gq
         EdgxZl0TysK5rrIc2iQ5fxICx5M587q7v10IzCktKfIczXH3LKMydTm8JWrIaRPz9hLo
         3vNznrG3w3G6CNAZkAQRPxjIzIEicngdDn2TLi8b8Fa3lAGZDMNg+mm52tiaZse8zv2F
         79GIp2NJtM945XHZuJXW/ur+VUhlIqqcpTSN1Mfd7cEEr9br78T/2O3KsaBrziOhJxFe
         l/wDGUlRPcUncfMXAo59wF9PYYuXwxdOCuBKGchHrgabJamizBxzEoHiv1QxN1Vy92uq
         +RWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786570263; x=1787175063;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Br/qW24JarGLH405s/rLwe/R9vyAJXaj4x4ugCqjcmg=;
        b=FqItBFpLl7DHQhhqInk7lcgYQ6QMam4oKu7HCeeM5NSabJWQROdJ2KE07lkG5u5S7Y
         O6aU7DYGOBEFalx46cSE0ezGquAg27zHk5kmFb4YP9ozhMd+6EUMJONNmvyyuDYwthJG
         Z1U6v/nZk+hFkPi3oBEb8O/kQZv15h2/u2xmMw0oYteomPKcBOW9YBxUm82CLGJxrAOC
         TwvpINyJvyD6TrMWWDZps0wDf2DaoL45l09M3UIyVHH/PtsHiOujINkNgTp80vZfPbyt
         mQXVeSV1TRN9AtSM7FpYv5YxJ2mi/nA4OHP4GVnTgTXEmMaEeG9LF1y5uSqSt9Cyw/lR
         RK0g==
X-Forwarded-Encrypted: i=1; AHgh+RpYl/lWudBBogFxndGjYjBNDUmz3JnMrLWU9JVIlipaCM38DHgnD4Ouk8qwaiXqSSgxdmkDGPI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcFqBfPLzO9U+sar35W+WkpHgraHVsNTZp67bSb5YdM3o/yU8
	9b6/hk6hVqJikTBIyULnAwEJxaRAADu7iYMWExUUYeV6RT3HzFCDNLeQCAg0/g5I8w==
X-Gm-Gg: AR+sD12BGdAwu6rCbZQbyEMVV6jgkRqh4p4Uqps46k5ZFYixbJhVkGu2XPhHwymDRiY
	Gb0uhP8sp+Dj0dzI0A/QOd4AH18LrYqladFe7egpoNWZfylM9JDspjykH8pqu0GjdEv2ModKYps
	v2fIS+DoL1qeSZHcNlSzKxrcOnaKjQYBe8LFT4DkgC65n9vdk8m2C6GMOU7jYC5iHC4IUFtUSUJ
	nH9yNnJIzOCBDCsygW9WHTpcU5SVQHT1tw5biazyBk+08lbZEgDOZ4kyzp8cHyWqUze+Ic0p9LH
	9Q0zotzKTr8l5nXGT5BHwGgAzKmFieWxPIIE70di1gADexzbQbt6S6TJwa1ueybg7fp8tx12e0h
	gq9Q6S6Md5xJocU1s7DhByoHsvbg8Gv+xV3rlnSUHu6teEY4OMOC3ltHm9RwrWULnDZU7A3E4en
	gvSzxGpBJL4BFT9Jet8+ukcqSEDEQhzmgPT2slnlgrjLJF2xKTgHtrb5/yk5lHSoMTguHhz2iCl
	e8taXohJ6e8V/zm1j9w1rdJPU/fHNnM1hKi6Thz9oYHnFYXtxPhYSlCX1B0Fn5taNO4oTE2FcWT
	eTofAghRCdPMSxA26HwN
X-Received: by 2002:a17:903:2304:b0:2ca:e0ff:eaa0 with SMTP id d9443c01a7336-2d384f689cemr155235ad.2.1786570262470;
        Wed, 12 Aug 2026 14:31:02 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931f26cd9esm393637a91.3.2026.08.12.14.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 14:31:01 -0700 (PDT)
Date: Wed, 12 Aug 2026 21:30:57 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Tomer Pomeranc <tomerpo@gmail.com>
Cc: linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	arve@android.com, tkjos@android.com, brauner@kernel.org,
	aliceryhl@google.com, stable@vger.kernel.org
Subject: Re: [PATCH 0/2] binder: fix TF_UPDATE_TXN supersede cleanup bugs
Message-ID: <anzmEX3hPwiem5ok@google.com>
References: <20260812195316.259136-1-tomerpo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812195316.259136-1-tomerpo@gmail.com>

On Wed, Aug 12, 2026 at 10:53:14PM +0300, Tomer Pomeranc wrote:
> Two bugs in the t_outdated cleanup path of binder_proc_transaction(),
> both introduced by commit 9864bb480133 ("binder: add TF_UPDATE_TXN to
> replace outdated txn"):

I was never a fan of this TF_UPDATE_TXN flag. This is a kernel band-aid
patch for a flow-control problem in userspace.

> 
> 1. kfree(t_outdated) is called without binder_free_txn_fixups(),
>    permanently leaking binder_txn_fd_fixup entries and their fget()'d
>    struct file references. The refcount never reaches zero; the leak
>    survives process exit and accumulates until file-max exhaustion.

Yes.

> 
> 2. binder_release_entire_buffer() is called with is_failure=false for
>    a transaction that was never delivered. Since binder_apply_fd_fixups()
>    was never called, the BINDER_TYPE_FDA handler reads stale buffer data
>    as fd numbers and closes unrelated fds via binder_deferred_fd_close().

Ha! good catch.

> 
> Confirmed on mainline Linux (6.8.0-124-generic, binder_linux module)
> and Android (Pixel 8, kernel 6.1.124, /dev/hwbinder).
> 
> Tomer Pomeranc (2):
>   binder: fix leaked fd fixups on TF_UPDATE_TXN supersede
>   binder: fix is_failure flag for superseded transaction cleanup
> 
>  drivers/android/binder.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> -- 
> 2.34.1
> 

So both fixes LGTM, and we should take them.

However, I'm thinking we should drop this code. We now have frozen
process notifications and that should prevent duplicate transactions to
frozen processes from happening in the first place. So we remove the
code and mark TF_UPDATE_TXN as obsolete.

... or maybe we just drop the entire C binder code base. I'm tired of
all these memory issues.

--
Carlos Llamas
