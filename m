Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.87
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793945587;
	b=Q+w6OX5elHj2IJPL3Nh9umo5C/3I0NnkIan0xxlbR/IMPCSJpvUKRi4Owv2Y+eO0lkbj
	 RO6K5VgUjue1ZY8Ejm+7rZ0VkR2cpvqTw8b0UkhoSPE/NcKI1pYB0DVDxNR9p1/ToR0ou
	 kImRc41jdfS2fbY2gGvU/hFXv0bAlfGxOupmyDhcMlmgFhyJQDPFqwhXW1YNkT/AmOZrG
	 qhVKfhY30iizSA5nzTQ45PgicwJcKkF9ATL4w8BEPPIN0/0ghhLSyXucziWxaVmBf7G6c
	 7dHcIKXZFQj7pHSfLC8Ir5N1uSnY5AnUhc4pEQz9GwVKH7RxXvj4V+1rFm282bwmepQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793945587;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=UeFRryLaJVqpKuXcRGUVHxdnIHbny7uLg2c6R3dh+AA=;
	b=BdE+J1THHQa5Vu7uxFrYvTX5JP36g2cSnmQ1yOQR/I9GT1MKTALPEwGbCUdJnZ5HK/8j
	 9O8dvlKxUg2u9ur2bkZLq4mzVrmQ4pBwJMzBSlfTOkCNq5pQ+M4PjHHVS4Bize8Pvg3GT
	 05M1LSyrYEb2qZ0B4iIlq9ALHR2bCx0+HEUcVLGJlE3sLo7R4g3SjKr9+pMYn3Hh1L9S4
	 2E4fVKSTPXXNnUzdlnseYj7v/o45Hky1vakoCRYiI3qMDEk+y29Z87tW5d8ssUkX+kz+h
	 tH3wRGQQ5IO7ZI6Ldm7Fwm1y54jsDn5sjZdJImA0yIk1+eVl3bv6SYCWO3lC6HrQR8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bvPJUts0;
	arc=none smtp.remote-ip=91.218.175.87
Received: from mta0.migadu.com (out-87.mta0.migadu.com [91.218.175.87])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65F8606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 06:13:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B65F8606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bvPJUts0
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=UtMR0huybFZzo68zuG5r3t/yLCzKnw9Q4ZZ92vgROyE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793945583; v=1; x=1794550383;
 b=bvPJUts0NfHUKQVK2bHna3jm1DTJS6OWUm5OJ5OLiijya+d6Vfg8vLaYBXApL2GOXiidk85N
 dP/RwNh/+nLcYXh2IEvX2bbeESfUaQVPaZ79T7zXLqfJ1a6I9Wp+4Y/yIp8ubSq0waJlyLf55yu
 jrfU62V+HSgFBkLFlkNckuxA=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ff19274c30c44807;
	Fri, 06 Nov 2026 06:13:03 +0000
X-Mizu-Trace-ID: ff19274c30c44807
X-Migadu-Flow: FLOW_OUT
Message-ID: <d035a565-aa50-4aba-8213-f39869baad05@linux.dev>
Date: Fri, 6 Nov 2026 14:12:56 +0800
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
Subject: Re: [PATCH v2 3/4] mm: hugetlb: fix GFP mask propagation to CMA
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
Cc: muchun.song@linux.dev, osalvador@suse.de, david@kernel.org,
 akpm@linux-foundation.org, azpijr@gmail.com, lance.yang@linux.dev,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1793850539.git.zhengqi.arch@bytedance.com>
 <ac2de9b321f68c1025333e92e3ce94beadcb0b6c.1793850539.git.zhengqi.arch@bytedance.com>
 <auxTwrKCeg7a3hfY@localhost.localdomain>
 <1535887c-6be2-4415-b54e-2008e6e7a35c@linux.dev>
 <au1qtSMDpimURGuq@localhost.localdomain>
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <au1qtSMDpimURGuq@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/6/26 1:50 PM, Oscar Salvador (SUSE) wrote:
> On Fri, Nov 06, 2026 at 10:43:53AM +0800, Qi Zheng wrote:
>> I'd still prefer to keep __GFP_COMP so that
>> cma_alloc_frozen_compound() itself guarantees compound allocation,
>> without requiring callers to supply the flag.
> 
> Well, but aren't all callers hugetlb? And we already do supply __GFP_COMP there
> for evident reasons.
> And should that not be the case, and you want to catch someone who went rogue,
> I would just place a WARN_ON_ONCE to catch it here, so we know who is not following
> the rules.
> 
> Makes sense?

Ah, make sense.

How about this:

diff --git a/mm/cma.c b/mm/cma.c
index 876635a56180e..45017ed876f76 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -935,7 +935,8 @@ struct page *cma_alloc_frozen(struct cma *cma, 
unsigned long count,

  struct page *cma_alloc_frozen_compound(struct cma *cma, unsigned int 
order, gfp_t gfp)
  {
-       gfp |= __GFP_COMP | __GFP_NOWARN;
+       if (WARN_ON_ONCE(!(gfp & __GFP_COMP)))
+               return NULL;

         return __cma_alloc_frozen(cma, 1 << order, order, gfp);
  }

>   
> 

