Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C9233949
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 01:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786065204; cv=none; b=L1ESxYQ962qZYa+kC9ISwscaakkO+1SaqbBeKnGB42DmSqB2G2UMR3WHh5ni9UlBvhWThb4qoonX1/TPcHs+svTzDABvpT70YARp42AAzQOreMy4rv78YERtqfUuRtWdEjHwdQF3+DaKRSVTNmYQ+S2fIBh7oVcTTPYr3Wm/F34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786065204; c=relaxed/simple;
	bh=SIIgJPGFhz5hNnkc11W1Z33TkabJ2YrobQTf7snc4jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clA/lm0kQkYk8K59dv7cE7fAMGzDv6ZCimpQQKYegTzSjAS2+6H/DBbL1HXARoxtA772/TtM637gTFMuI0vGmN1pj2K/G8aeVQsD/F995s3Rr6J369lvob9lXWq2oDOPRtoeDdKjfsfPw73hJIp2Xi/6Hm8Rb0WfvRFtE5m9zVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JW+YmbUQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JW+YmbUQ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso27783665e9.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 18:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786065201; x=1786670001; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JhTAK8kd+tCRfVOm3LmowAQ3BoIBHWxZmJ5DLNOQvkM=;
        b=JW+YmbUQCMwBJxhsL3m/F307VuGJDQN/a6tRNTgNSJv/2O490v6PlRHBdsh8jVPgfN
         dFyqdsZOQ//9m9Tlyf2e4cqWPYpE3Vja3/eGXdv6Q0u6CK6KvjKJdvJTnaQSSKgKmCua
         TB1bIFecVICp4rWRlIHuXzxc9byV7+rUC0OIBWLZC09ujDOTbd+DBp/GKMh4Y9h7SMuL
         QTo8erTr9wHPAKEX58KNglYvapNs1rQKwFo50hiqWKAF0DIJNlCF0PzsCySmwi1pLQds
         WgvIrExJWkxbhMs4C8noLJaIC2UqZxjX+1CFHizbkQqy3roKHUa/xysHW8p8LdKwRkFi
         AZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786065201; x=1786670001;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JhTAK8kd+tCRfVOm3LmowAQ3BoIBHWxZmJ5DLNOQvkM=;
        b=fJp9D/8+y2TyRqkE5bmuJQRCoU3gBLZtdIsLHR0Gd7ZlUIOgYm0IXk1E2NTbqJdVd2
         zUVqPRNp80TlPuAKBuLaW1pAu9OGu1hg3rNks13z43YjpMj8hfWDbSm598GXIANDEAgz
         6ZMWvUoqT3fmwObr7J0Sktg1HIp6g9HlWfS8J7LU0yA3Skq73XZxawlqmj04OkK6UpXq
         tVC2jmQ1Iw0XEIOKahSfS34MZb2/PQ2tlcvU3zkzUl3azhUp3wbZBvXh1bvcP9Z4m2TS
         +l8tdI8oo7tSpBtLdJmdeF9zT3s6l8Qx2Kwg1yDCFFC2RNrnGCnCMYiv2m98OlB2ySv+
         b6lA==
X-Forwarded-Encrypted: i=1; AHgh+RoW6EDvTFnd1OML3v3OZyw+yWAPFsPV96/eZRSBPdBRivLBnopaJmH0NMr+2P+E0sSiQcOrCVY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvitB2RyFGTdxmvYXfRGYpPqKAIMDk71pJKDgmkrkmJa8sE/GM
	LKfteK6wXen3qsRnaQjFy3D63iFL5NjPK0A/91KrJhV2oXJW+DC0MnvX
X-Gm-Gg: AR+sD13S8myWa0YtkVeaoKiiwqqYtmpj5KCbJzQMgl+Z7i8BaYTiRW/WNpJ454nZuKA
	KFK1GFfu5bdXsohc5lO8EMS43bvuT4Wx0CSUFTALrI0luiCOyFUv/wmXbTmHlE3s8riJ4ZE5ZSH
	M0fQureN7Cc4W2DS+zOj0ogaHS+PXhCZHjMmf81BSAsqWJvSnfEWOjhULK9582MVfZ9kGBz1/Zf
	7OYtI72vL2GzJUMlp81l9f59LcxNAfhRdn7cn0fUCWY04d3VhW/9bQ4vTk07Okt3aavVX+JX1aT
	LFzXMYoCGggdeydKzZEiLS/wH5Q6wFqAzoz/2Zyvb/WVFtuOb4ManIV3J/EQhNI7AuuFGpmICs4
	ySqKAqUIQDMX7WLuLgYPPTCWt9UgzE0sghKRcWjlZDv99z/i7rQsP9iIw82bWHHy5fzFackYgmJ
	l+zes3LXWYKpx4L3M1rEZXg9KkUlKwVGEnctDSa8woIShm8q/VC5BjgckGfbnnrYBnZ8volX38+
	sIqqWaZANKJnIZtdxD+KNk6//nsXQak1ME3IKEtb5yaRQh9hbahr95HPZsQNAd2shX8L5gzUVHS
	5FvDPj9W0663yO3pi2OBqKDkXVv5e9QA9OXzJAKpfN4NpBBovIpUpTADUx0/zScYQKJHVqwYYUs
	YBj79L+Q=
X-Received: by 2002:a05:600c:1f96:b0:496:c249:dd9a with SMTP id 5b1f17b1804b1-4994e71364fmr228063365e9.3.1786065200908;
        Thu, 06 Aug 2026 18:13:20 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-2a02-3100-adf9-2301-8c14-6be6-a9e6-a2d4.310.pool.telefonica.de. [2a02:3100:adf9:2301:8c14:6be6:a9e6:a2d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c8bcca6sm13771385e9.4.2026.08.06.18.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 18:13:20 -0700 (PDT)
Date: Fri, 7 Aug 2026 03:13:17 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Wei-Lin Chang <weilin.chang@arm.com>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>, 
	Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Steffen Eiden <seiden@linux.ibm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, grayhat@foxmail.com
Subject: Re: [PATCH v3] KVM: arm64: nv: Keep the shadow S2 MMUs at fixed
 addresses
Message-ID: <anUt9gd8HIwaj9jf@gmail.com>
References: <20260806192451.10169-1-kmehltretter@gmail.com>
 <d5svhw3jkjnkucohx2ntwhphemgbtfcmjt2zoyyw6svz56zfrh@z2ziydov5ras>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5svhw3jkjnkucohx2ntwhphemgbtfcmjt2zoyyw6svz56zfrh@z2ziydov5ras>

On Thu, Aug 06, 2026 at 10:54:03PM +0100, Wei-Lin Chang wrote:
> 
> Hey sorry for nitpicking once more, I actually like v2 more, as this
> version splits the error handling to two places. Marc's implementation
> [1] is also good, but that requires a twist in kvm_arch_flush_shadow_all().
> So I'd personally go with v2 (+my suggestions for it :)), but also fine if
> others have other opinions.
> 
> I also think the comment in kvm_vcpu_init_nested() is worth adjusting
> slightly, too.
> 

No worries, thanks for taking another look.

I was following the guidance in include/linux/cleanup.h:

  the expectation is that usage of "goto" and cleanup helpers is never
  mixed in the same function.

But maybe keeping goto is better. I'll wait a bit for others
to comment.

For the comment, I propose replacing the current text with:

	/*
	 * If allocating an MMU object fails, keep the VNCR page alive so
	 * that userspace can retry vCPU initialisation without affecting
	 * the VM.
	 */

Is that the adjustment you had in mind?

Thanks,
Karl
