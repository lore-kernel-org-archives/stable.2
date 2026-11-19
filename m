Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104467;
	b=Q7R9T0KayoVaNv2Nn3AO/AUrmKJxXysiO7Qjdoh6SdozDtJGEvDqG9K0FXQ9bfogzwoh
	 F+hkn/Fxd/o2XaEyatHBPiwr8LbnyxmbyP0oReVfkZPoZC2+yVLONpDy1MSUTBsahvXzg
	 73vThpNLcxYWK1ZvbGoZAatQBjvqUoK0Otii2lY8EbxFl2MEa32hZxuTb7qeOEJbJPVVl
	 wUOpp8BFOlMQr3n4465rifD40H6Vod1SRGKrQNyhCe0ANehA59DTr7smyQQVM3kjeH+ri
	 kzUa8QsJwUYjNsfw++5acyJcls3SIinaPi0WQyoZgUN/uAkNwuVNt7sd1pp5HEFrKVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104467;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:CC:Subject:In-Reply-To:
	 Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=gQ+mCMdhYRYeDcO02x4fd2TOgmX36Kcmpge/k55qYjc=;
	b=LKiKxiOawZpiu8lisaAWZ0S5+q+FVsmxEN5/gOnS75e/ZkXiNB9P8joGRlUyLaHR5Sna
	 vuBOsAN0ewiU+xPOpo1/JBXOIMww/M7sA72Z7i+GGde6yTmmbhE0k0zyEekM9hWnAfufn
	 6qTs5aLkTmX1SkEe15r0p5f7DdXXYzdlHqMQhXhgggEBYyRxYpevijw6RithOQwUMPUVo
	 P+EnfCNqo/UTfdnuDNAr9mx0LOWAUNtvpEf2IFRuLpuI/VKB8PDSBffrLJgwxPkuPA6Xr
	 /p0j9aDioazHDItHK2/JueulPD89B+y30llmXaTNhdlR6XaUgfWJZI7SjNRPebyEPKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=amAS0UaD;
	arc=none smtp.remote-ip=91.218.175.47
Received: from mta0.migadu.com (out-47.mta0.migadu.com [91.218.175.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAB6606A336
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:07:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFAB6606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=amAS0UaD
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RzSpnRl3L+3BYvT2DeQY1NjutcLyvlWogEngFMMuX0k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795104464; v=1; x=1795709264;
 b=amAS0UaDWguLQaCZLF6MFiRpHfwwVyefLk9UQQjcWrN2/3q/MHLLQ2+AauJeSfMQqMuwdsmO
 AvoI15AxGj/7NCtFmkkNKcoyE1SFYPGG/WV5YrpGsosUOTbYYm3XXf2hhfriqjDYUzHAV5Wk+aX
 jHQFJSC9B2/lOokGLE/AMaC8=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8aebfe3fc16492fa;
	Thu, 19 Nov 2026 16:07:44 +0000
X-Mizu-Trace-ID: 8aebfe3fc16492fa
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 16:07:41 +0000
From: Bradley Morgan <bradley.morgan@linux.dev>
To: fparola@amazon.de
CC: akpm@linux-foundation.org, alex@ghiti.fr, aou@eecs.berkeley.edu,
 baoquan.he@linux.dev, kexec@lists.infradead.org,
 linux-riscv@lists.infradead.org, nh-open-source@amazon.com,
 palmer@dabbelt.com, pasha.tatashin@soleen.com, pjw@kernel.org,
 pratyush@kernel.org, rppt@kernel.org, stable@vger.kernel.org,
 thunder.leizhen@huawei.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_crash=3A_Fix_crash_memory_reserv?=
 =?US-ASCII?Q?e_dead_loop_when_low_and_high_limits_match?=
In-Reply-To: <20261119093730.49471-1-fparola@amazon.de>
Message-ID: <CAEBC780-5EA0-425E-84DA-F16817BE884C@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8bit

On 19 November 2026 09:37:27 GMT, Federico Parola <fparola@amazon.de>
wrote:
>On arm64 with neither CONFIG_ZONE_DMA nor CONFIG_ZONE_DMA32,
>arm64_dma_phys_limit is PHYS_MASK + 1, so CRASH_ADDR_LOW_MAX equals
>CRASH_ADDR_HIGH_MAX. If the first crashkernel=size[KMG] attempt fails,
>reserve_crashkernel_generic() falls back to [CRASH_ADDR_LOW_MAX,
>CRASH_ADDR_HIGH_MAX), which is empty. That attempt fails too, and since
>search_end still equals CRASH_ADDR_LOW_MAX the fallback is taken again,
>forever. Boot stalls after the "Initmem setup" messages.
>
>The first attempt can fail on a kexec handover (KHO) boot, where early
>allocations are confined to the KHO scratch areas.
>
>Commit edb907a61333 ("crash: fix riscv64 crash memory reserve dead
>loop") fixed the same loop for crashkernel=size[KMG],high. Skip the
>fallback to high memory when there is none, so the reservation fails
>with "cannot allocate crashkernel" and boot continues.
>
>Fixes: 0ab97169aa05 ("crash_core: add generic function to do reservation")
>CC: stable@vger.kernel.org

Oki.

>Signed-off-by: Federico Parola <fparola@amazon.de>
>---
> kernel/crash_reserve.c | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/kernel/crash_reserve.c b/kernel/crash_reserve.c
>index eee37a11380ce..1417b429b45c6 100644
>--- a/kernel/crash_reserve.c
>+++ b/kernel/crash_reserve.c
>@@ -421,9 +421,11 @@ void __init reserve_crashkernel_generic(unsigned long long crash_size,
> 		/*
> 		 * For crashkernel=size[KMG], if the first attempt was for
> 		 * low memory, fall back to high memory, the minimum required
>-		 * low memory will be reserved later.
>+		 * low memory will be reserved later. There is no high memory to
>+		 * fall back to if CRASH_ADDR_LOW_MAX equals CRASH_ADDR_HIGH_MAX.
> 		 */
>-		if (!high && search_end == CRASH_ADDR_LOW_MAX) {
>+		if (!high && search_end == CRASH_ADDR_LOW_MAX &&
>+		    CRASH_ADDR_LOW_MAX < CRASH_ADDR_HIGH_MAX) {

Reviewed-by: Bradley Morgan <bradley.morgan@linux.dev>


> 			search_end = CRASH_ADDR_HIGH_MAX;
> 			search_base = CRASH_ADDR_LOW_MAX;
> 			crash_low_size = DEFAULT_CRASH_KERNEL_LOW_SIZE;
>

--- Thanks!
