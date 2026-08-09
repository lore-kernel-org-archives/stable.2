Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AFA35CB7B
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 18:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786299120; cv=none; b=CM3KK7bzOYRNcuAu2a9sqQN4mL62PCiQtvBDihULKtOAXQu5TMrj/xHCDwEdcddHFz/UT//nhaSNkkysqliUliyY1l9S9bNkHNMGxbQrvvfyKwpR3sQRgfsFiq4I0NRwe3GaISNBhwog+0c0xtsDAtDksfkuAfC2TQz3oyUtMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786299120; c=relaxed/simple;
	bh=UzgFFcq25sDDfKoaHn+VXHNND3WRXeDcn+AQuJuIe+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=auf1gHI6Qed29St8Cppdu22TPMl2EYpxYORwNHVqfkM6YBp/yhm987nsdKOZYOQOC9YGfIb1/TVp/dfXTtgsPkXefD275psUGCB9iyLxL5/cOWbVF1SzGpsJBIsWQlo5QnWD89k40mK0XZQCSacV8jJGSU+yG+3XwIifLNjpik4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgawpL/k; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgawpL/k"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-476a130c138so1110756f8f.0
        for <stable@vger.kernel.org>; Sun, 09 Aug 2026 11:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786299116; x=1786903916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WoCA45LQ4z+3BUUhv5YOm84o93I32Yjtpc3HcvkQ194=;
        b=MgawpL/kCf5uzgQZ9wIdyINkMb4i8RmGxXeGUyAovIkCXqKoCEQhLjDqwPbP8RXIx8
         gPxZahjgfTVta1wfywes6/ypl5DVuWViZ1R3Sk90f0LfG7heGE8mgh4Q/KNB/+s/zarH
         LKSD+i5K0RbuCRY1wm/3m5toyl+ZUHaeCLGfLRTjDs8WXUIyEQ92F9F9Eyy+yfwxFkCe
         XH/RBewNJNtiLScBusWQrBy3OdJ2PFQUri2PL33UtiTsLfI2w3gQhb3td99AKekkkeZ4
         yL1qPLYqvR9EO0tfnKD7+Y0bGx6+zCtsZG9RBAb5f2bpZRNqG7ps+KrBd72moY0qXdxH
         bYbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786299116; x=1786903916;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WoCA45LQ4z+3BUUhv5YOm84o93I32Yjtpc3HcvkQ194=;
        b=AsZK9B1roNBykpSgwF3inNwue39YkmDWeceqGEF0liXDh8ig9CZT9/ybL4e4PhgLEY
         mClDHsPymP4jaRENwxePceG3KcLp57OeblZrw2TR1tK5sRbi1y0SNkRU5pkvS6I7Xl0u
         uh5HQGo0U4UOj9k2Y2koVGIgMdk6GRxqZsACfELjnIOywKNdXrUlmtqvtwUfX9HkeXyt
         cUL0zG0BvHmJTpXvZh6BuNVH7LVNH/STWRQKKw1s8mt31O959RaYUd/ivHVJc6WqXpyz
         Hqu34Py5MSlGjUU5jBi/71z72osi4zp2qs41GSr9ZCULnrUUVzsDNMzSQR/DFB6Lo9ef
         cQ6g==
X-Forwarded-Encrypted: i=1; AHgh+RrtbIz7wfaYqxF5yb+y3PPB3wsmwDkOefC4iHIxHiPFfKiRp7qFN1uVep09Hb/HZD8fgfNQrhs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmXuZvT5vgDmkYAEYa9bdz5v5434193BYqnBfrwub3Ggxbtm0g
	pFZxYfr0Zj9DE/jj6GHbMH60xto57AQJNSqM9RjHywc7pZi0btFcV9Ku
X-Gm-Gg: AR+sD10qNkxSleDn/7RxxJXdDRcI3hZSCMiTWBWuSCKcmVs0ufIDh3jU3NsW2I7yaTi
	taxFrohz9ZEDHYsDwVgKvrdv51Ti52nYq82tOdslGQGJUyUyidrjtcOZHUuJhXHOIErBBpatiRV
	wO71Sju7aHxRy6U8QMHjwXLj57a0VwnLPeq42l1riItEADTFbJOChyIhnoaY76LZNVtYkCcmXOP
	sXxviiUBQdTfbV3VFkD9heW134bqsiQdkYIxy7ur5ohrG3NbUjdhZtOsXY/1bU0cBa+vZ3kcxJo
	lr/L9v1A+24yfFb+pOpwQbrYac862sRYf9EuKgHC3EEuWYe6kw0m9I5khUA6HCZIPN3LKQz3r4T
	PlEoe8d5Y5v3KLproFVexCSB4TtquMIBdtF9ZghomRJuv1NpLpkuM9QnbG3OV/MkS/3yEHoxV66
	V6C5XN7WLsQ61W4L0MZoIh1yPMMUCLc+bZ5ZATd5UYIneQKFOpoE5v2KAiL+nnaLizHa1mefkAL
	df/lkGuZEqefc3r5Y0dPvRA/2nxulBLsXJPt7iKkCRkoDd9TZn805e+keePn+Tsv3HqotASUv77
	w6YVarJpej0fO0oYQiF8rWoJXSPqiedaZKkhSEDh4mIy2Ak7ZNDFvYDWUQwMIfCaAuEhDqI65Fd
	eJg==
X-Received: by 2002:a05:6000:22c9:b0:47f:e7c8:3fe9 with SMTP id ffacd0b85a97d-47ffd15cb0fmr36249046f8f.0.1786299116224;
        Sun, 09 Aug 2026 11:11:56 -0700 (PDT)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-ac88-a501-9c5c-9666-3a00-3cdb.310.pool.telefonica.de. [2a02:3100:ac88:a501:9c5c:9666:3a00:3cdb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480020be8f3sm24111242f8f.0.2026.08.09.11.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 11:11:55 -0700 (PDT)
Date: Sun, 9 Aug 2026 20:11:54 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: nv: Allocate the shadow S2 MMUs
 individually
Message-ID: <anizGXThM-haqQXU@gmail.com>
References: <20260803224405.41468-1-kmehltretter@gmail.com>
 <86mrv2arf2.wl-maz@kernel.org>
 <anYNTW2e3HalTqTk@gmail.com>
 <878q6fplpd.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q6fplpd.wl-maz@kernel.org>

On Sun, Aug 09, 2026 at 12:39:10PM +0100, Marc Zyngier wrote:
> My current patch is as follows, and so far, I haven't seen much that I
> like better.
> 

Hi Marc,

Thanks for your revised patch.
I think one correctness issue is in there. 

> +		for (i = 0; !ret && i < S2_MMU_PER_VCPU; i++)
> +			ret = init_nested_s2_mmu(kvm, &tmp[i]);

> +		if (ret) {
> +			while (--i >= 0)
> +				kvm_free_stage2_pgd(&tmp[i]);

The increment expression of the for loop still runs after an error.

I reproduced this with failslab. If init_nested_s2_mmu() fails while
allocating pgt, before mmu->arch is assigned, the for loop still
increments i. Thus while (--i >= 0) passes the failed entry to
kvm_free_stage2_pgd(). The resulting log is:

Unable to handle kernel paging request at virtual address fffffffffffff650
Internal error: Oops: 0000000096000046 [#1] SMP
Call trace:
  _raw_write_lock
  kvm_free_stage2_pgd
  kvm_vcpu_init_nested

Thanks,
Karl
