Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695471;
	b=C6uZMUTgyLBytQ/WaXFskNOqCQ+Q6v84xQkJLdC1QgM3vy+PD5PNfw7JMNmriBV1Dt1M
	 EnqUTFOnq7o/GW3j0eQ9VHj7hsRiQJJFORv3VpViy66bwmrbmHtQUFN3bKLJk1yHDazcG
	 teZROd+1h9SYYkCU9TisgXy1IsHd7INIazI2LCYB2Zw7toS5UhYaN5992K/YTsJdHkt6y
	 pUjUGXXvGqfHMFZshW8oJ9XyPt9oP7ewLVCg6R/UQIxRkckeI5oW/kvToVek4apNxN+EH
	 Voi2eaZi0c8MRp1C02lYH5c/ZQDIXhO9wTxPRNaiTqcMfsYtC1Rfs2nCLPLlJ5fsIFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695471;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=ilisxbvbd8NSl3FqfuStr292wszm0PcMcOarGjNhaDU=;
	b=3bBINgc9xZOShOX/hCswL7yqES6KvZHGRf9VZOisAwhk0RrVzz12HiQ1V7gq5BbiFr88
	 ufIwyEbJGevd2j63Nq+q3tEOMg+632wUpKbqbUlKWqiP82TMhOvrtr7HuAF7duMndMYr3
	 QCqBblK5w6exZpVQwBtj+brNFc/yhFksfwFvDj4ylRngzhw/AJGLV8ZRACHYwVrR0Dfnh
	 xufxaTfLYO4looOTYXha/1IpbH0yBbxo0Z3tEyetu0dXxa4poXkRGpo+Uw7PZCd7b76Bp
	 xXEwdxtJ8L2vidCBMDUIEPQmFf1LYzcdGMr1u1jWtur7GwaNYCpB8tT6JG46+hzuXmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VgvQYUgS;
	arc=none smtp.remote-ip=95.215.58.145
Received: from mta1.migadu.com (out-145.mta1.migadu.com [95.215.58.145])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3F606A968
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 08:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90F3F606A968
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=VgvQYUgS
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=XmvDp6Uab0sh7g6VkNQVO5JWlnHOPAP3vSfwuAggiUg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793695468; v=1; x=1794300268;
 b=VgvQYUgSn9rJvn63grV0lQbWiRySyysEa4lJGYRUTt6r9Zr0ReglDaey6g/xwQgDVXtitFWJ
 KGKgRsrVEz28nKdTCWTFQnLaN6sKYUuoOkPgnanbmeqIrlrnvJAaD/VoVcI14T51pZ7tCeUn8xn
 seEDw49OCAJY7j2ukth3duxI=
X-Envelope-To: stable@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 90c7e1b874827c5c;
	Tue, 03 Nov 2026 08:44:28 +0000
X-Mizu-Trace-ID: 90c7e1b874827c5c
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 2/4] mm: hugetlb: skip CMA allocations under
 PF_MEMALLOC_PIN
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
Date: Tue, 3 Nov 2026 16:44:10 +0800
Cc: osalvador@suse.de,
 david@kernel.org,
 akpm@linux-foundation.org,
 azpijr@gmail.com,
 linux-kernel@vger.kernel.org,
 linux-mm@kvack.org,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <D1D941B5-C7F1-4273-875A-B75178E0E69E@linux.dev>
References: <cover.1793692578.git.zhengqi.arch@bytedance.com>
 <5bc00742fe249cf09a3095abccf8889d5fa71116.1793692578.git.zhengqi.arch@bytedance.com>
To: Qi Zheng <qi.zheng@linux.dev>
X-Mailer: Apple Mail (2.3901.200.71.1.16)



> On Nov 3, 2026, at 16:01, Qi Zheng <qi.zheng@linux.dev> wrote:
> 
> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> With gigantic overcommit enabled, a fault during long-term pinning
> can allocate a fresh HugeTLB folio from CMA despite PF_MEMALLOC_PIN.
> 
> The folio must then be migrated before it can be pinned. However,
> fresh gigantic migration targets are not supported, so pinning fails
> when the HugeTLB pool has no suitable target, even if the original
> fault could have allocated pinnable memory outside CMA.
> 
> Honor PF_MEMALLOC_PIN in the HugeTLB CMA allocator so the fault can
> try the non-CMA fallback, or fail when allocation is restricted to CMA.
> 
> Fixes: eb02f14c4a2b ("mm/hugetlb: allow overcommitting gigantic hugepages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

LGTM.

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

