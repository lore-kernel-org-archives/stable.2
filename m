Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588610;
	b=buGadqxnBCy3DcOdftfqV548QIisxlimxbq8+0Pj94YBPh2/geK5BGu/7U5o6CW51EUo
	 Y/4vKbZIl8vArXPIrZOSkcswCp2OeyNxYjp6x2oalV0TvjeAL6gINH1nlfDesglVmyIiL
	 5ON4/CdDC6dWfFCdoMTmaKQwsgE9PMdKtYLjBfqNGMSEfLzTGnUuTIQyhDNf8hHz6I8Hq
	 G/7NJ5tamIh9DqveeMj6cQJpNHEpDg5X6tp/J1R5fEO2hVjH+ddNLbwJ54jsR54qWv9vZ
	 klGhaU02w5B21ZtOMDnmHiSk9RQQSG8UmZ2ud5sY9eta1mqxQcKg0WE+tH//spQACWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588610;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:In-Reply-To:References:Date:Message-ID:User-Agent:
	 MIME-Version:Content-Type;
	bh=cdqxXzF0nK7QzWfPYBzfNXGgW3hBDjtbpSIe6sOp4qA=;
	b=aesiFz0uXh5BPxxlHSkJHWuUqJxbJzHlVsE1pexh1wGHvwJiajai1gT3ngmSPFKTTDhI
	 4hIFK6XcRuCBuBeYyirp2PnNTIKixCapSQ5K4KB167HWejm9EdsfluSPpZBomkHfvgn6G
	 hmyQEtX+QrmVLdOmbvSPvZYQNVX+GLZSa2IUv5LNnH6O2fMpk4fhZ+/BRCZqMXvOukbT+
	 zzjiiTxDwl5ljm2WHK3OKGRXkNpUn1nG9vMTs8+8qjmaeSTfrA+GT/H+dgl8428Soapg8
	 DxIDNXtAokOcGarOmAhEAxdmVTvXoHZ2isODfZnavF5k6dx8uW+vOsFR5yNsYZ5tT9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MvP4Qd0D;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48575606A321;
	Wed, 25 Nov 2026 06:36:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48575606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MvP4Qd0D
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795588598; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=cdqxXzF0nK7QzWfPYBzfNXGgW3hBDjtbpSIe6sOp4qA=;
	b=MvP4Qd0DU1yNYOpMAw5xmIkoEddP12YV8pFdD7zSYk1WaCIL/C5upix8UMOZL2Y5CfY98sTX13eN8wlXUj228F+Fn31Pd0Ze3HQh2f5BWrCyeddp37hlibAuW4j8AjRIObUQ6xxI0o7i3iPjNIUmIKmKYBbYRfRYdZIEF5ICKH0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R491e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=ying.huang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0XFQbIt-_1795588597;
Received: from DESKTOP-5N7EMDA(mailfrom:ying.huang@linux.alibaba.com fp:SMTPD_---0XFQbIt-_1795588597 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 14:36:38 +0800
From: "Huang, Ying" <ying.huang@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>, Yadong Qi
 <yadong.qi@linux.alibaba.com>
Cc: will@kernel.org,  mark.rutland@arm.com,
  linux-arm-kernel@lists.infradead.org,  linux-kernel@vger.kernel.org,
  ryan.roberts@arm.com,  robh@kernel.org,  gregkh@linuxfoundation.org,
  ptg-linux-kernel@linux.alibaba.com,  stable@vger.kernel.org
Subject: Re: [PATCH] arm64: fixmap: fix missing break-before-make in
 __set_fixmap()
In-Reply-To: <awW3Dw743-rw_-cf@arm.com> (Catalin Marinas's message of "Tue, 24
	Nov 2026 16:10:55 +0000")
References: <20261123093505.974-1-yadong.qi@linux.alibaba.com>
	<awW3Dw743-rw_-cf@arm.com>
Date: Wed, 25 Nov 2026 14:36:36 +0800
Message-ID: <87mrqxto23.fsf@DESKTOP-5N7EMDA>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Nov 23, 2026 at 05:35:05PM +0800, Yadong Qi wrote:
>> diff --git a/arch/arm64/mm/fixmap.c b/arch/arm64/mm/fixmap.c
>> index f66a0016dd02..5593d7e0d523 100644
>> --- a/arch/arm64/mm/fixmap.c
>> +++ b/arch/arm64/mm/fixmap.c
>> @@ -126,12 +126,19 @@ void __set_fixmap(enum fixed_addresses idx,
>>  
>>  	ptep = fixmap_pte(addr);
>>  
>> -	if (pgprot_val(flags)) {
>> -		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>> -	} else {
>> +	/*
>> +	 * Break-before-make: when the slot still holds a valid mapping
>> +	 * (e.g. earlycon re-mapping FIX_EARLYCON_MEM_BASE), invalidate the
>> +	 * old entry and flush the TLB entries caching it before a new
>> +	 * mapping is installed, so old and new translations never coexist.
>> +	 */
>> +	if (pte_valid(__ptep_get(ptep))) {
>>  		__pte_clear(&init_mm, addr, ptep);
>> -		flush_tlb_kernel_range(addr, addr+PAGE_SIZE);
>> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
>>  	}
>> +
>> +	if (pgprot_val(flags))
>> +		__set_pte(ptep, pfn_pte(phys >> PAGE_SHIFT, flags));
>>  }
>
> I guess that's easier than getting the driver or earlycon code to do
> clear_fixmap().

Yes.  And because set_fixmap() flushes the tlb on x86, IMHO, it's a
little hard to justify the driver modification.

However, set_fixmap() only flushes the tlb on the local CPU instead of
broadcasting the flush, because fixmap is either per-CPU or used during
early boot.  In theory, we could follow that approach and perform a
local flush instead though the benefit may be marginal.

---
Best Regards,
Huang, Ying
