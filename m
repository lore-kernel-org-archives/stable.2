Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52F4272E6D
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070298; cv=none; b=PKyBDgRp3BXvmIrS4Qf4Z/2wxraBX0N+jsrkBImXnq+c3v19p3ReQI05fuLqsoptlzVe2k52dPlPCb+CvaMBfGQdAy2jegq3HBSmrHBJdVap9iTwfkQtpJgImbBLJdGMxsflvuxcto9npJpqfqpa64+bhkEzBLGDhQKZBfWja6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070298; c=relaxed/simple;
	bh=3sVAJtNcQlCRKPK5dGUWPlTmZVASBi8OYcqXL+6ufh0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=YXbeVXO2i37tvt3yXm+f/tIAZxLSu9S+MZzlKoadF9XiAxqya0gkX4PxCtO8+DX3bY6bAH220w3tizGrJYo1hyz6aLmG2jmCIsgRLpQXOmBLoMZtwrQzILC5y52EBysBhDy/FSyZllV3yP0y9FNJwOqvtgh58SnMM3TYmhDFhn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qKSdWpyB; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qKSdWpyB"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso2008130b3a.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 19:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786070296; x=1786675096; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=oJdLdIw3eLo0oaT0dX3TZQQLMEjdBPNutZDZxls1Ksc=;
        b=qKSdWpyBw9CLm0FCfhJPPsADJzPRYMfYAusKqFBfRTrmDp9qzB726X9uTLOVawsfSv
         rMl/Sl2AG9xJ3NM7vJOKeLnI7IWv1TsZr8YHqjcOiPDoZ5qM44hJwcL5Lmac/zFzE3Uy
         1QJuxjui0Q4bWUt6XyfVatj43xMI+iKq7SWp/6s9oWzt/BvQa6b1D+1QK3MBowITzPe4
         l9z6ktg+OyfExQhB9aUlkiwZpuk1NFyhg8aumOq3pfOHdrBgO81lhxNcM2/U2krdZ6Iy
         ZftRm+Nmvi6vaMyheHQMUVFyeC6hoK/qM96Dtv4eCbSdnVP4sNYcdsLKac48eiYqnv1W
         XjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786070296; x=1786675096;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oJdLdIw3eLo0oaT0dX3TZQQLMEjdBPNutZDZxls1Ksc=;
        b=out+rDTIthaNbs8DhPgRYMVEA1tt0p2glWZQak40xt5eTLG0Q7C7L63i7zArVk2zg9
         ODhT0WAnp9ksy/uhD16vPiBAndUiTHOAcH5pbZMXnop/cGvxHoyLVNSDOi93ZRYQ6PF5
         u3RRnYktSOHZ7a4tNkK62qyQteL8ClztG9kwsi7a4gPec8YACXyi8gj8rhdT7KFlh5O6
         wBSr20DSTO02mwsaxM+f2X/jpRnmhjs58jU6STJqvgnuUiWsfTY2TGvfpKo7K+ci7hbt
         jLRAp0TvPTAugnp/kwDfWWodA2frReFvz2jGR/5trlEUaEZ+yYjjd1oABaUfAOsm6uUz
         2Rtg==
X-Forwarded-Encrypted: i=1; AHgh+Rpn4sS6TMZRrVjUBr72cN99SvYOYK5tPHqqAjqststXS1a8k+AjEo0Neikmn83M83CLd8Vk/Q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR7RiPON93IcaUV4w1zAXlEt7MmjKuIRqsqiGv20MyIsTF4+E1
	0JWWUVaI+CEP4hK5LKUNfT0V3ULqas0gB5hTA46hw7kZsJE7uPTvfFoOGPM/gA==
X-Gm-Gg: AR+sD13zCpML8gW90jLbs9UD35Y9azicvJ85yOmavSsmNIh3IEdZr2s/esjchLoEKx5
	vAC8Rahegun3W7JnpDH8r84RC/MT2txUJGXK6mCmweTSm1zKOxIDzG0zJNeQPTrUIccSKDKmnVT
	21SKa6UlmXa7RVsNEURGq/ksDD0K5ZrXQ+r1GRhe3WuQB6bzjVIrc6u159PGMZt48qcxIFxzIk1
	gn91X0uTQPsu9w5TN+qEAZ4TSan+LlN2FvW8h3wz4dn+VESA85H+Q525oyQ6aJarfdKHb6H8JbW
	5qUpi23X+LzCu6nxRItnuAOMDfsUrQgsUx9eA9AncV5XPv2ZVZnh0JH0rSHC0revhbAII0W+D7/
	efMCTss2BUIVSONGpNP9CStilYxCPqK5KStoxdCpDVs404Rzy21NI3ktreiCZHRo8qbiyxVnC2o
	o9zVDeuI2FmkXzSIKtqIpL8j6CEokAzOJMphn5b3BK3CDnTSkMUspp/+i5khU=
X-Received: by 2002:a05:6a21:6089:b0:3c4:2fe1:fa36 with SMTP id adf61e73a8af0-3cbadd74818mr8045427637.36.1786070295864;
        Thu, 06 Aug 2026 19:38:15 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315beb87d3bsm1585726eec.14.2026.08.06.19.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 19:38:14 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gaurav Batra <gbatra@linux.ibm.com>, maddy@linux.ibm.com
Cc: ltc-dev@lists.linux.ibm.com, sbhat@linux.ibm.com, vaibhav@linux.ibm.com, harshpb@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, donettom@linux.ibm.com, Gaurav Batra <gbatra@linux.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH v5] powerpc/pseries/iommu: Add TCEs for 16GB pages when RAM is pre-mapped
In-Reply-To: <20260806205027.86428-1-gbatra@linux.ibm.com>
Date: Fri, 07 Aug 2026 08:05:50 +0530
Message-ID: <ldailks9.ritesh.list@gmail.com>
References: <20260806205027.86428-1-gbatra@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Gaurav Batra <gbatra@linux.ibm.com> writes:

> In powerPC, if Dynamic DMA Window is big enough, RAM is pre-mapped. To
> determine the size of RAM, a PAPR+ property "ibm,lrdr-capacity" is used.
> This OF property dictates what is the max size of RAM an LPAR can have,
> including DR added memory.
>
> In PowerPC, 16GB pages can be allocated at machine level and then
> assigned to LPARs. These 16GB pages are added to LPAR memory at the time
> of boot. The address range for these 16GB pages is above MAX RAM an LPAR
> can have (ibm,lrdr-capacity). In the current implementation, these 16GB
> pages are being excluded from pre-mapped TCEs. A driver can have DMA
> buffers allocated from 16GB pages. This results in platform to raise an
> EEH when DMA is attempted on buffers in 16GB memory range.
>
> commit 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly
> adds TCEs for pmemory")
>
> Prior to the above patch, memblock_end_of_DRAM() was being used to
> determine the MAX memory of an LPAR. This included 16GB pages as well.
> The issue with using memblock_end_of_DRAM() is that when pmemory is
> converted to RAM via daxctl command, the DDW engine will incorrectly try
> to add TCEs for pmemory as well.
>
> Below is the address distribution of RAM, 16GB pages and pmemory for an
> LPAR with max memory of 256GB, memory allocated 64GB, 2 16GB pages and
> assigned pmemory of 8GB.
>
> RANGE                                 SIZE  STATE REMOVABLE     BLOCK
> 0x0000000000000000-0x0000000fffffffff  64G online       yes     0-255
> 0x0000004000000000-0x00000047ffffffff  32G online       yes 1024-1151
>
> cat /sys/bus/nd/devices/region0/resource
> 0x40100000000
> cat /sys/bus/nd/devices/region0/size
> 8589934592
>
> The approach to fix this problem is to revert back the code changes
> introduced by the above patch and to stash away the MAX memory of an
> LPAR, including 16GB pages, at the LPAR boot time. This value is then
> used whenever TCEs are needed to be pre-mapped - enable_DDW() or,
> iommu_mem_notifier()
>
> Fixes: 6aa989ab2bd0 ("powerpc/pseries/iommu: memory notifier incorrectly adds TCEs for pmemory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>

Thanks for addressing the review comments.
BTW - we should really cleanup enable_ddw() function. It has so many
corner cases and has started to become confusing. But as for this patch
it looks good to me. So, please feel free to add:

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>

