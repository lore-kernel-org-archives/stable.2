Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37A381E92
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785428108; cv=none; b=ZjI0rIS0mzACLabOBgKB9QwSakILBDViXrMyoSSrrnHZp5ZkVcGzy4Mf22LwJ2X4SkKVp9M2QnbQKl2n7IT2VFP+dsMWMmQhSkcKpcg3DeoBxV8oDF8Lem9of2K+YeZztO2THFZfq6TmT2R9ji5hYws7y4IfG8i8pA2NsKpGZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785428108; c=relaxed/simple;
	bh=Prrq3lRrNtjBMcFNoLT6vy0bmYe4ExXeIRC0llIkt7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbn4mpjV8M7rEndSrczv6N6kF34km2dxSblr2mpsB7W1volq0WqDkwZVxT6FZD5jPdCFw2vDrwyJelEmE5s//DExvrwU7VfBsj03RQ8Euty5edEZQ2SiYNVHB7DUN6tMcDR0jBZNPZVEQ8pobso+XgGPvgIq1bF4g6KrfASmfzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=aD1x7KZO; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="aD1x7KZO"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so72830a91.0
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 09:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1785428104; x=1786032904; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sc7/PIL5nmBZuTJI/qyxnyFN7S+kHFcyfHQ2vtF45hE=;
        b=aD1x7KZOof0CcjkO3K2mWdjMAAFm27fqdl7lL9hKPfT7nYI/samOcztz60bwQqvTPE
         wFyQsC7b70zbV5K6ObSxMVMDfwqRXrBLb+8MozDJ/MVkPH7qUbhzdEAUYxKLYSGqxLMA
         5coRJy5pRS4vLsXDunzwN4PDIYvKWsQaMEE4QtGTOtlUDa9ijQJETS4xUHaQJh42o1+1
         q31yDnWZcszUH53+AQZNb9dPr94O6Qmme1jJDcEh4rAaH8Sn3X/Peq6mLw+6bFRTYFCN
         aE5yGr82pAMRs/cmeZkd42a4dpwg2XgrW0bhcBbOM8re1S7ktPRrEAFLhrYcnD/FtP/f
         WbkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785428104; x=1786032904;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=sc7/PIL5nmBZuTJI/qyxnyFN7S+kHFcyfHQ2vtF45hE=;
        b=M/y5JMU6kVfouXZVjNvAsHz5Huv4c9pQi8RftZyPbb56O6/WnoxsEWhqWNLzpw4IAC
         4VZIcnG1wfqlSpSgVn51BXd0GYeG/6mxcSkDjZvXrJb45G8hmb7baYilN0KwMnA3Kl28
         gHq42saAfTtszINfTWLtdOAuDeK5tzLx8gRavcFOdcKBMtn7uMlBnkfkLgvufVWhR6H6
         eou92Kuh1rEUIxgTDCseN8IA/1KaMkL0TAovOJTUlQrt2RTR28UDbgyxC+QCWXFKj9IO
         AeCH0uv7vdQV39bSpen5dJfX3+uEiQ8OsGQtmqZN6n6JSh0aPAfDk9mzLqjO46oa2GFi
         8CJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrhkS8/pWPxW9AYNHuD8Q08/VgwDq2l5US2OofxANXjsybHPhcKPNGuW4COt01lggJ88Dt0vC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyskzNr3lvLl900X3FA9ZpJLuKSN8CZPuP+HfA0aOtBeWhue4EE
	ZELpbLBaWeHHpg6dPIBaj3ZX7xpZXulhniOxlqvSm0s5vz1O88Pd188O/Ic/iIvKCpQ=
X-Gm-Gg: AR+sD12X14KsH3gvZ2ywksH1DjT/VwlVxwGXOj2PhGSYML+sakCqAhSAwjneEQ+uvDG
	TgUL5ITGXbFc2xuzyoJskI2i48+8nj8fbwXZAPnqbS+i2yBHx96o1T1inXEjOZlxAA5I4BcNVws
	6cQKTQLyLcvYV1LKtx12uF1pNCX8uFrJXKWUn7eZ1iKNSkeFijlRyBfj7i8wifCpu3jcAZ5dl+G
	08E3/3OxHTKNh95PEfjpA6nXqdLI0asMfkFVcPdGWxjNQu4QdSgTE8gYeg/Ub8e8HIg4eUgVssE
	bv3JWOJFm+rowaB1k7WCDnEVnt7YFFZ0rXbzpT70PPbIU097CFpKFDduJ6+EBbPL+zWPv9pbEdm
	kZmbEtHAa+JSZyDPu/tX/Sw7wzqFtoGl6+4sBcN+7XLtTJO3MaHQcA2CgcTprGRBm9Zf2igbwYP
	CRJL1+ZDEos6V8eV8D4MqkJXxNI+SZYgp4ajLL7idkY4+eQBiuRndM
X-Received: by 2002:a17:90b:582c:b0:38e:57a3:f218 with SMTP id 98e67ed59e1d1-38f9bdd2f2dmr2888847a91.13.1785428103654;
        Thu, 30 Jul 2026 09:15:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38faba8491esm4092a91.2.2026.07.30.09.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 09:15:02 -0700 (PDT)
Date: Thu, 30 Jul 2026 09:15:02 -0700
From: Joe Damato <joe@dama.to>
To: Hidayath Khan <hidayath@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, wintera@linux.ibm.com,
	aswin@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] s390/qeth: validate user buffer length in SNMP and
 ARP query ioctls
Message-ID: <amt4hhb/IZwi+0PE@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Hidayath Khan <hidayath@linux.ibm.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	andrew+netdev@lunn.ch, wintera@linux.ibm.com, aswin@linux.ibm.com,
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, horms@kernel.org,
	netdev@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260730142216.218309-1-hidayath@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730142216.218309-1-hidayath@linux.ibm.com>

On Thu, Jul 30, 2026 at 04:22:16PM +0200, Hidayath Khan wrote:
> qeth_snmp_command() and qeth_l3_arp_query() allocate a buffer sized by
> a user-supplied length (udata_len) without checking a lower bound, then
> set udata_offset to a fixed non-zero value and pass both to a reply
> callback. The callback bounds-checks the copy with
> 
>         if ((udata_len - udata_offset) < len)
> 
> Both fields are u32, so a udata_len smaller than udata_offset makes the
> subtraction wrap and the check pass, and the following memcpy() writes
> past the allocation. A udata_len of 0 also yields ZERO_SIZE_PTR from
> kzalloc(), which the existing NULL check does not catch.
> 
> Reject buffers smaller than udata_offset before allocating, so the
> callback subtraction can no longer underflow.
> 
> Fixes: 4a71df50047f ("qeth: new qeth device driver")
> Cc: stable@vger.kernel.org
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
> Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
> ---
>  drivers/s390/net/qeth_core_main.c | 3 +++
>  drivers/s390/net/qeth_l3_main.c   | 5 +++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Joe Damato <joe@dama.to>
