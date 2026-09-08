Received: from mail-vs2-f1.google.com (mail-vs2-f1.google.com [74.125.227.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D66157268A
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788882884; cv=pass; b=oxuFr3/1LUzrjbyPXzTLBBpPB8UEdGZSDnfI4xKeBPmltJyNQ2OZUmz57sLIoLQXc3+I/Ak4w7nx/TZTgoMTINtjVFzkT08p8UuJGx7oonZV/6t5RmvBnOrFZr4B8KQ2u5Klnn+Xu3YOZDTG18wF6tX95GEme4yP3m+3CEieD/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788882884; c=relaxed/simple;
	bh=m8naGFUUK15OK7RhREJs9bWygJEJ6IkQJ0hS9/AKPmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgbLvOR7mTtfTYSbaK05fcvEcqblwffPKu5Vt60iqWx7CpdtiwuCX3PC/d6lP+15Wv1LyQkcbK7tph95Ayj3Rxrwp1zscvdgjbDBmu2g6vjXKDDMXTb8zkIqdx1/pQjSGof+u0hluYem96KNaXWkf1xbHRv4fVfwwad83CCulW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=peXBH2a2; arc=pass smtp.client-ip=74.125.227.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="peXBH2a2"
Received: by mail-vs2-f1.google.com with SMTP id ada2fe7eead31-744b7f44933so949525137.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:54:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882881; cv=none;
        d=google.com; s=arc-20260327;
        b=MhWBlYm0wryEb1xUP5wfQvofkontdjbm4VaOqUA3uehiz8MRM7uhexVKSF7XE3c8qz
         NsIgsxFfNVj+zwodKioPKE/kltfSKvJpgxlL/R7X1zMHoKGkGEIbfgUu0zs7Ksqa++Wq
         D1VMgtbFg+1XTIZoy9wE2WeWDvrfN+zoXCZ4c7wk5aq/310xcnVVeLAdChe3O6QkAXCE
         lhaLmnasl+6bbQMYnUwLHRafcgH60YfZTvZiKQPgS8kLnHO00Hm+JC5K6L9fZdD+erdi
         5DuDkdoCtg7Lqx+aYZ9I3GU+5FhHCNm9clw3tgg0OcEd9rq+RW9b/FqoLSTKvoKVx6Be
         z61g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m8naGFUUK15OK7RhREJs9bWygJEJ6IkQJ0hS9/AKPmg=;
        fh=sA0iHC5pmlVwp1MibcNOfoDM76mkhU7t2G3DuYIShN0=;
        b=amrfGbesrsS+yyYTZyj7+EVdgBt6a1X+MEWv6ayM3OJL/2/LFlyVgMYZRTCmLmT2aY
         oUPS0z3xaxyBpnW3KL8LulORVVhMM23dXv4EwMqPI1cICXtbKjUQg8XCDllCBZd6PccS
         GNJ1c4ZpimKuAUO1wbfeHq6EDvp6eASWW70M+g5HuMQbGQNpEks7YmRiib29UjbjV8qy
         TNcxZ7H8ATYx1toIbf1uXJxZ0KfjCLVgNpsOa3Ad4qQlEzOe8k1TA3+s4vrGKRg1Zz7N
         DlVoAOBoLoSNPaMq54oHC1QgiHhiKBEG5M/FocSt/9n6VEcT6tS94my4bEPqKig/Zp+g
         XyfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788882881; x=1789487681; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m8naGFUUK15OK7RhREJs9bWygJEJ6IkQJ0hS9/AKPmg=;
        b=peXBH2a23fSed/p+ckB1kajRvnn60mDjJi7RJiS7nFs97gWq/6m66ODfJnFPFrXkvi
         Rsx1Wp0OQFM+zaQ1Z5s8/eNBEhHkQFqEON4+ODNyREVmVvSIHsjdLPjz2CJ41GrsqVBH
         J8qiQj2wDk3flVW36QwyuVSUG7ywKXFAAlY0rDSiJrSZNctOL/Zrjd3HPx6S7QeO7AuF
         MCRfuI0EAlgxbX16R/JnwgTv6g6MY5pfhr8IzpNLjOE/Tpy21viLrqoDeVTPEasD+nbS
         zTGMF6Km3EvbttKwc63XqjnfLv/8+SZhPODhHHc3c9NXeUmuUOQx8NdqxeSZpVv2GhlX
         VcAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788882881; x=1789487681;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m8naGFUUK15OK7RhREJs9bWygJEJ6IkQJ0hS9/AKPmg=;
        b=X/jzBQB1gzJE/tsYHTwoATdNbOWvSIX+GT/lC9l6hpvEZ9fbjhAWKTUyeK1j4PTJHu
         /1o6uXU862DO31PCyRCZfmLQ2GxcgqC1hFsnukvObTomvSe4K+s7baBsJC9hNn7sXGVx
         BH3+Lsy7AArCL8edsKHfhdj+CF4I1RLsMf1E1CLNo+cUcik8KHMIYybhUliyQ4kkte22
         DZtNrKKf9G7BAzpUnvE5cjEv8468g1y1kB7YbL3fhCo2xBy6+33QjbQ7/WsVxsMTGViH
         dz2/tx2OYm+YYIRf3xJtfDF990CfDh2TbRIHKLTnMdjOkuKTog+g/1gq+2FA6SmTuzSB
         i/9g==
X-Forwarded-Encrypted: i=1; AKwUvBwru7rRe48c8M9lu3L41tvWK8fLsVFxZ5COdgonybWloDbqMcQgZjxgiiI0yQntvKLkGEjGxKQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kcQ6JjG6boOgwkxpSeVTBmbu+qstwX1EO6Ei7dQ1Pb+IdTMFg0
	13IiVOshMtH0j5eGDH9B5JkgYYy9nal9MpqueSsooM++iP6P4zDB9sYrnU3pwOASGQtmmCQ9I6H
	bzXJtgvRSBBWW6Qx+2liDEVItnW+4AqU=
X-Gm-Gg: AYBFou0hmfmmSPi/gZTkIY1rBYH0EsyDiJrRWHq/WWmf8qUq5GKrgn5zNVeSl3RdSDL
	Q3j7T4tE+dvN08Zxv+Um9Xszzb82kc2+13G3LYnRCsnukiJL0agybllp0bY6uMLPOF8dpkYue0k
	HYjrGLFJLyCnJqawBzz0YqJTn/u09epDiPCXJFN8bXyhYXq9N3cDsie1+T2VBVDnxlxd7dqQd/x
	DuNU91gHd5nbOqHoDpy24t3VTGhX+GviRYwySYXC0yQogmv/zRD7fNabrmF8348FodcPVpC9q7s
	skqlkLSApuVMq8wg6ojceE6DkAKjDi0tmIg2WtvVXLgZah4=
X-Received: by 2002:a05:6122:338b:b0:5c6:5fff:f2c9 with SMTP id
 71dfb90a1353d-5c7ed41c953mr14439622e0c.4.1788882880956; Tue, 08 Sep 2026
 08:54:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260823142620.126424-1-shlomojune6@gmail.com>
 <CANn89i+5o16tSTk9MpLE24nCAn+SkMeZvHv0W=MqxnXGZDBBiQ@mail.gmail.com> <CANn89iKck9W0KB8Sp7OFDQ+OTFJnBpy=jsmQbZ+VYhrm8yOUgw@mail.gmail.com>
In-Reply-To: <CANn89iKck9W0KB8Sp7OFDQ+OTFJnBpy=jsmQbZ+VYhrm8yOUgw@mail.gmail.com>
From: J4f J4f <shlomojune6@gmail.com>
Date: Tue, 8 Sep 2026 23:54:28 +0800
X-Gm-Features: AcwNN1XPIJ_-7f0UpmEHZhNDAtBZArjkgFp-nC_du6g8-qb2zRaLlPZ5d23i7Vs
Message-ID: <CAE_LbwkoQMYLXzOi_RwMcxuNy=tMo256+Xj2Ac+0W7MbAv2yLg@mail.gmail.com>
Subject: Re: [PATCH net] net: skbuff: reject invalid pull bounds
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Following up on this, are you planning to send a V2?

Yes, hopefully next week. I have a few other things to take care of
first. Sorry for the delay.

Thanks,
Shihuang
