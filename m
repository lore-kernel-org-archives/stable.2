Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63633CF201
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 15:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788277633; cv=none; b=Cl/ddkf91QVszbcrqH2ZGWCq6GQmhfouS/Dfy/Y011GKC5SVUPe6C8si2aDglycEtSAY84AC9ErborO6Y/PAnBcr2UHwybykCmxmZLpLF1k6PqiXohY0uwVaR9TcvlkRl7iGQWC9qM46Lx59XTsQB8SswAmnJ1Z7j/Y4mSRxA9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788277633; c=relaxed/simple;
	bh=Fo+cyOSZ390VpvGi96sorBSWtjIbA/jriibM1HSiSKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u71N2EM65knz2dunaauyMXjagy3ssv3tKJGk9IHp3tLI6yz2VJ3cnFBD0rd+CZ5HzeRbjftpqGGmIzglWNwp7wWOsVs+t4hhkjpQn0ihSyW0QSvY2YPTp0W/7CIDe6asD8VWAepMxzbrliZtgc437uMkB1AiZkGiSDSCzo/V6S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T0AGABNU; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T0AGABNU"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d8facae850so153945ad.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 08:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788277631; x=1788882431; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bbKL83syu/qRRZNv+72ALzl67/XZ/emAL3qXRHrx7cY=;
        b=T0AGABNUubLN0L6f6rijN8GiywRdx5+PXxTSEr4zQc01USLIEQOSHtprIexRD9A4Fx
         jvM/TrjYVmtM9/uH4eUn7ryuvlN6DHdolW9HEqmAUwe8hMIC7Zy9YZETlYLY1VVOcBdN
         aRIZWgwKKUEeBstpmYDaq1EObOLvyAw9BscGOoHIY5KeG6h24mFIAZ8bGSDZjh2v4FfQ
         T7WcpQ51iz0CnFYLY2XX1Mgdb0GhWrqwmeTdKgWlNip9K+UOCcVInmTElfhDybeVT7Dg
         cxsV2SrWJTU10WNWJ9mkOdLrLoaM2Pc6iwSC8Dse5LZ6wumGTSzGLTZZyGezD5Fj/tjW
         ksUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788277631; x=1788882431;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bbKL83syu/qRRZNv+72ALzl67/XZ/emAL3qXRHrx7cY=;
        b=muzxHpZ5i0qZrUt8P7nM3eQRSbDFB6XAaW18ujEKWMBMIWM4Com8y5wjOgJCtjHvb6
         DmNszhjXaDuPwrskD3qIrQ57JunHrAUS1Xg8hw4yCCgSFVq/JTPE/qXtGO0meLZc60Nh
         2iJSG054IqzVWbZSigurY97+YlUAQ7UznhRHAnmHE8LHncs1PVlu1ty9ABqFVmVDWPj2
         ajf6YyrRFiKpu5NPz0wV87coTzv1W75GKDSjDqA/+1nVR/AmV4yOhFSfrUoiKNQAoK7V
         8C+a8WyPy/9zf0XmBbnYyHW3gicxhG20lPiccsrC+vIWzucRupEVhKvo+R/30XynblFu
         WzOQ==
X-Forwarded-Encrypted: i=1; AKwUvByaxIN86rRpvWfAt/jUIEpyzimBqmOON+bPKPlLdHldlkTf2JzieWTSLUTISfDKygk1c7Kv3Us=@vger.kernel.org
X-Gm-Message-State: AFuF++nxpP67Ngup3xy70fdZ7Lf2cvtmE0o5ZcDLx3cub2xrGAD9xMRk
	QCuODNhjaf0QO0GOqt7M130oBjO6Ub1eJSxFeVXSUo3yxpGBw5PsPL08t1VhHt5usQ==
X-Gm-Gg: AYBFou3atLI1dxh4KI+8trFVV38aiY7pVxMvfSuKAcp9Cy+H2r9eGMXTeaxiTEblBdp
	zhtXCWRp8tPyIcAaQr6WBrZ6EvKPkh+ksaVVm/jBXzI77jC+NDKis6mzw/O6NWTiplj776WPoMs
	iosrv/C1AfvDPEETJRe53UqadWy1O4KkTxrLTJlW3T1h7lZUfKWJrSuB43IgDrunfZa+vepWQpB
	2iqiZ7Vj5psiptINDjJdAfNBgRkLAksqcLbbTW6xNvrru1FQ+n8Jid5gfA7WeecjGevkS3yKRX0
	aPgyotkdVgQhomFJRxvu9U+byWxCWY/xoLn5GrW8WdD5o5hc7tjuWK2535YHZoi0NDfLvoXOiun
	UCFtc8KtiXdgrBfNaua7cqf5VK6JMJD57iu54H+dvslXsf/9oyieI1xQrnGwY4CUC3rOFxSge+j
	v+WoNNM1QTwAnkoZpZgnjmv6ia19xc/ToDTZWY+GJXmx4rjYJ9bMUjYJQP6PCF9i+DwnARNUNdB
	eUSGU8hMveoblp6yfrRNKkFN7izlzuT0hEYrJnzhjl1Z6vF13mUXYJ6jv1t4ESPLbvhsNyDt112
	uPmG7mc=
X-Received: by 2002:a17:903:1a10:b0:2d8:d88f:cbe7 with SMTP id d9443c01a7336-2d9521694a1mr8105305ad.16.1788277630425;
        Tue, 01 Sep 2026 08:47:10 -0700 (PDT)
Received: from google.com (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae3c1f03esm242850a91.14.2026.09.01.08.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 08:47:09 -0700 (PDT)
Date: Tue, 1 Sep 2026 15:47:05 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	Suren Baghdasaryan <surenb@google.com>, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 3/5] binder: check vma->vm_start in binder_vma_close()
Message-ID: <apbzeSGFM2XtZbuK@google.com>
References: <20260901030419.470246-1-cmllamas@google.com>
 <20260901030419.470246-4-cmllamas@google.com>
 <apabb4vGhNfcXMnY@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apabb4vGhNfcXMnY@google.com>

On Tue, Sep 01, 2026 at 09:31:27AM +0000, Alice Ryhl wrote:
> On Tue, Sep 01, 2026 at 03:04:14AM +0000, Carlos Llamas wrote:
> > Certain operations like a failed mremap() might trigger vm_ops->close()
> > on temporary mappings. To avoid tearing-down the main binder mapping on
> > these, let's verify that the VMA matches the expected starting address.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Closes: https://sashiko.dev/#/patchset/20260831224145.169403-1-cmllamas%40google.com?part=1
> > Signed-off-by: Carlos Llamas <cmllamas@google.com>
> 
> I don't quite understand this. You explicitly made sure mremap() can't
> happen to begin with, so when is this called?

The issue is mremap() first clones the old vma and then calls ->mremap()
but we return -EINVAL. So it now starts to tear-down the cloned vma and
it calls ->close() as part of it.

The idea was to avoid shutting down our IPC when this happens.

However, sashiko pointed out a second issue with a tail split. I need to
expand this check to allow the ->close() on anything within the range of
the original VMA.

I'll have to send a v3.
