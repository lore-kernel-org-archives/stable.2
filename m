Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792487629;
	b=oTLRY0eWUxsdHvW0Kc9V35f+FdJMyK3P7sTcRQoR38u6PzDYrgJbolAxEtQVD5Dz1Web
	 2c2BBjjBeV+nT078ZeowZjzpypBPCWHGhjwPM5tJcEhYzPy63TUCmdY1PnppJIMSYAwVt
	 EHBJFdh4lpT8d3lCImOHhbLBehnaEpRZ1vU1BZoDm1ZEC9aRlY8mRjYOjjmd9fenjHJBJ
	 /GZD65kOXn/+mFooUJbhZgH20oNdcO5jJdcu/LE13cjVTFka5mUdebnE+35hJ9E3SMk/o
	 avRBduRmmSoJFVbzyu2aAO1JgWzi2ycGOgUpfLlVpryGACDzPdO5stLUucTT1FmXhTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792487629;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:Cc:
	 Subject:To:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=cBT5Tv/OCYXZ5REQMB2nW+cv403IPsf1vrinm69NgC0=;
	b=A59emmVB7emtMmFog9duSi5iPG82bJLzuv1ySZ3PuVhKVGz/rXBwKuLQiYOt3LcgLTER
	 h6tJc/ygDyNLACu0wQaW6chcT7WnF+it6mniPnBv9VyMpcSG376R4kfmB2IpvxTm6Y6uT
	 vyryEDY7amNYG1+mEf6H761jn8hgVSu+rEifveXpef8ekj22qXga7FiKiIDKuGHHsyQ6U
	 JwNU/7EpPudXvsyvuFdHGPLlF/pmlGL5JSf7gLgCf0oGK/UD9NkEEHZ/lem1ZmpvmAj0E
	 MdnJ9bQ1JnSRvDe9O4orENNkh/w+PDA0l+G9ops5ks+ZHtCOnfailgCLkVe3Og0QWbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLnBLVxy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47261606A319;
	Tue, 20 Oct 2026 09:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QLnBLVxy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD2A1F000C4;
	Tue, 20 Oct 2026 09:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792487628;
	bh=cBT5Tv/OCYXZ5REQMB2nW+cv403IPsf1vrinm69NgC0=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=QLnBLVxy/rzkLd0FngifJtK1Tqe/bFoag34nXhw4wCLaJc44NxrGppj//PRtUy1/H
	 y8AGW4q+q21yxVYvn8qpW0WcF8/Tc/ZRXps1P0278s/P0joZD4DcN+//jHC6ns0njD
	 qq8O2Lz9kyaGWPvJY2gMEp7kJ29YG6fJxgpv4pf4WR23NCemQ/TQszc7f6Vl1ETxoe
	 HS1YVWYsfA/G4Imd7LCKVwyzSum8U29rrhG4ePfRfhd6YUNAi9GXM8qhSFzdlUmkR5
	 hVlp90x8/jJvzbiuya5Zko1k7XJZB48thL3G9EOk2CIH6tVHvNHjRnBMQNk9wPWqwC
	 Dj5QDRHQfWhdg==
Message-ID: <5c97f2ab-0fdb-4f87-898a-0f43ef42f470@kernel.org>
Date: Tue, 20 Oct 2026 17:13:45 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Daeho Jeong <daehojeong@google.com>,
 stable@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: expose resizable_tail feature via sysfs
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261014152138.138281-1-daeho43@gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261014152138.138281-1-daeho43@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/14/26 23:21, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Userspace has no way to know whether the kernel supports the
> resizable_tail_secno mount option before mounting. Passing it to a
> kernel without the support fails the mount with -EINVAL, and checking
> /sys/fs/f2fs/<disk>/pinned_area_max_secno requires an f2fs instance
> to be mounted already.
> 
> Export /sys/fs/f2fs/features/resizable_tail so that userspace can check
> the support before formatting or mounting a filesystem that relies on
> resizable_tail_secno, e.g. a filesystem whose tail is going to be shrunk
> online later.
> 
> Fixes: c966d29e01bb ("f2fs: support resizable tail section and unify pinned allocation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
