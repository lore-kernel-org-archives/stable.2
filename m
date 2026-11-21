Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257736;
	b=GNCnYZCFu0BYgxz7iW9BdvfQsuDn5YXRr5HMJkfdonsDiLWrwG9d/5wQjlSxnV1R5e3X
	 0gpFW1N5++jiZUeKVs0byM72lp/IQvU1uTdSQNI4hhWGuHc78bqw9CU3//7vX4Zq+7BQD
	 emDnh0/aSrJ0JosNdicKBKCH3QJorGk0V9MC8YJGKpqD+hwHbhQefDfiLJ23CKJJw8y6U
	 aKHChg6/jE+eenqxfH7i0tJBW35RqfGIKUX/yphINTP95g1GubBHaNNOITSKcuZX5W/m/
	 am9yEwVzCGQgGYEs4Yms2GLaakb5vgoAANRU3L3k7UhppSgZvlNVwVanZKTDJppVr1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257736;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Yj6YhJZae49Tw0DKv2iw0HLLaEXFAkG+q7uMo0BJK1M=;
	b=ZvVLLnnE2uH8b8ztqzXRKBE5LdhL0R00RMqoFVwu8Xkk+DTW+3Y931xCKs8sD5IbPjbQ
	 aIzwVW2CK8sTbOrnOYg7QmZ9iaoG1ZPZVX2u1Kxe93VLI0Vppgsce5qIuO9l3s0RDtEre
	 m1E51Ec9KmjxmzZvZKTxzCmSI95XZ/hUvIJsI/ze6edD2WJKyTwkUP2dO861cgOnv4yjD
	 +/vn9L3DgCzTe0llpWuTueNoybgJIp9p7vKlHdObj3zRr5Dc8cBPXCyxuE9hoQAN6RZhw
	 3lRWV00wbL+ZM4TSFEuVvZBZbq6c/+B1INiTU0F257x9Usmy+GZ5Hzdu8eX/y/TXHrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oy7tTvfm;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3071606A320;
	Sat, 21 Nov 2026 10:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3071606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=oy7tTvfm
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E7C8F1575;
	Sat, 21 Nov 2026 02:42:11 -0800 (PST)
Received: from [10.57.93.173] (unknown [10.57.93.173])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E33D03F673;
	Sat, 21 Nov 2026 02:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1795257734; bh=iL8eR8LtS02jD0fPEipVhs7PZCrNJt53A3HgRmlu1nE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oy7tTvfmqCGu0HNi4kMZuliqPxj9S4Sg/F1R9gMt1ti70b/jdNnoI2j+XJJraGBRs
	 6zWwas8zsHWk+kpMPDns3rt2CAp0k3ryRfHT4apcesHp/t4pHYKqG0O1U155bD3god
	 n7+8Vxqr/TFa/r6QaMYXTbopuoDxgIv7+mptE56w=
Message-ID: <5f9eae39-b82c-4fb3-9bea-c49a6b7baf25@arm.com>
Date: Sat, 21 Nov 2026 10:42:11 +0000
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
Subject: Re: [PATCH 1/3] arm64: pi: Add an ISB after mapping the FDT in the
 initial ID map
To: Fuad Tabba <fuad.tabba@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Yang Shi <yang@os.amperecomputing.com>, Kevin Brodsky
 <kevin.brodsky@arm.com>, Anshuman Khandual <anshuman.khandual@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Fuad Tabba <tabba@google.com>, stable@vger.kernel.org
References: <20261120121638.194154-1-fuad.tabba@linux.dev>
 <20261120121638.194154-2-fuad.tabba@linux.dev>
From: Ryan Roberts <ryan.roberts@arm.com>
Content-Language: en-GB
In-Reply-To: <20261120121638.194154-2-fuad.tabba@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/11/2026 12:16, Fuad Tabba wrote:
> map_fdt() maps the FDT into the live initial ID map with only a DSB
> before the caller reads it, so the read can fault on a translation made
> speculatively before the mapping was written. This early in boot,
> VBAR_EL1 doesn't yet point at the kernel's vectors, and the kernel fails
> to boot.
> 
> Add an ISB after the DSB.
> 
> Fixes: 84b04d3e6bdbc ("arm64: kernel: Create initial ID map from C code")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fuad Tabba <fuad.tabba@linux.dev>

I did a quick audit of all the other DSBs without ISBs in the pi code and I
think the rest are all correct because they are not synchronising stores to
_live_ tables so there can't have been any speculation with the old invalid value.

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>



> ---
>  arch/arm64/kernel/pi/map_kernel.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/kernel/pi/map_kernel.c b/arch/arm64/kernel/pi/map_kernel.c
> index fb44cbdd2f292..f9338257adb7d 100644
> --- a/arch/arm64/kernel/pi/map_kernel.c
> +++ b/arch/arm64/kernel/pi/map_kernel.c
> @@ -211,6 +211,7 @@ static void *__init map_fdt(phys_addr_t fdt)
>  		  fdt, PAGE_KERNEL, IDMAP_ROOT_LEVEL,
>  		  (pte_t *)init_idmap_pg_dir, false, 0);
>  	dsb(ishst);
> +	isb();
>  
>  	return (void *)fdt;
>  }

