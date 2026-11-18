Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794971358;
	b=vws87E+jzhhzRoSL5ALAj97k5im7x1lLWoc3Gor6p8ZpovpLauBLH5BXn9ZehXj0MxVQ
	 91/5q71AN6uReuDClyRSZ6vkt7TqtT6zb/EICy8vPlGWzJmfVZRca4nmca4fKmwF55Okr
	 E1MfQOvNoMlkJncSglv5GHjXj4eZCe5FAkucVB9tad7nCF8CmTGafktRwU30v4VFgy0FS
	 WCJbpdHur0weqLWqZDcsUMr/P9/QKpoM9jebi2JJVGcanGf9s0TKw+3VVt1+S7pOl+xBe
	 rHNVTnTP91kuweXZXB68WQ37Iabt37iMikG0npbluJCTT+aAgvqOAzphVq98CG5bvWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794971358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Subject:From:To:
	 Cc:In-Reply-To:References:Date:Message-Id:X-Mailer;
	bh=pitsyVb1clMqV2L4ssVlVlqFN6fptjFrrSXbJnVEGtU=;
	b=MxyztdBUYP6C+OEDSY7zkoysVB/wL0E8y6DdjHiorvP4MM2AlKEhv3MqRW26l7TSaJtt
	 ghI1UUjFIuCPXOfG5gbzcwuv+MpMUeBdHQW9bpPBUAAYQHBoI5vrYoyGFE5vd1TZAKCki
	 ZQZKjs7AFigQJKlNesS2GDvawO3l26Iex9TJtCt+a/lYrH2BN8potOjjTVuSz73IoPtk/
	 ED6lNbzEzMAwJz8icqmFLtncGl7hLS8HsKCs0NoUiWrIIK5K8MrAJY9YIlQjyx/+AMHLw
	 c2yCb8xIz8JHEv52lkC0o9b+gaKfYNVCWbUtzAaIs/Xx8n8blCGwrg5FR06d047JvXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=gourry.net;
	spf=pass smtp.mailfrom=gourry.net;
	dkim=pass header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DnriVk9D;
	arc=none smtp.remote-ip=209.85.222.175
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C0606A31C
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 03:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 135C0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gourry.net header.i=@gourry.net header.a=rsa-sha256 header.s=google header.b=DnriVk9D
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-945e6d9ceeaso49830685a.0
        for <stable@vger.kernel.org>; Tue, 17 Nov 2026 19:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1794971356; x=1795576156; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pitsyVb1clMqV2L4ssVlVlqFN6fptjFrrSXbJnVEGtU=;
        b=DnriVk9DfTUS181w66seZNegYFfAnO7mb4fFvUcc4ZFQ2uHxB+1rrqUCiJ9R8//FSa
         kgFGoS/ehLk7tqP6keyGdj0ZSpONl5G/0OUwEz+bNDsbWIKeO09MbveRsU/80hUtXEum
         ftI3mO+tx56UezX+C9JV6cYE4Gdqeoks+dpVlbGgrA1SRMyTJ+MZOqKJ3W/mFvvH87LG
         uBZGqyALFWIsDQeNscH3zD09p7t4ozf7MqZ6YV9rhrdwxujPoRnUZ8MNm+rbiDqqx2QF
         shQEdWhzinsG4Nz0s3XH2k89ZX19Ari7PYeSWxHQHK0N1TtnkYERBQIO3ujjLYg8nN9M
         n3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794971356; x=1795576156;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pitsyVb1clMqV2L4ssVlVlqFN6fptjFrrSXbJnVEGtU=;
        b=UOkol2E4URWKjtR3qxeInt2RNu1EUIDZd63RRVGZdC6dzyH+VaLdwerRvMJhxwKYxb
         Yii6xP3DNip8YWoP94zexlgLCsTJ6HZyMtbRtwIuh3XqYH5d6+r2sAYqLDj5wOOEtCOU
         jeBNsdjknqownvMeSWtOBS3lu4ZL9SEGHAjhx3EU1Ko/IX7lKxAxDnRrWDYLBQxTvbPp
         9gj4/4wDztn1Fna+L1Qkryyb8NT75mQjOGRONBLEdoD3vpOdCmWRqeOpq7c/fWX0KMRR
         5p9Z6yIDyaARmQXdclf1Rlp3NhvNlPHZrBjdDnStR1VY2vjSWTXziEOHaWZOgdXP5scu
         Fcsg==
X-Forwarded-Encrypted: i=1; AL+hErELbi90P0b+vT6BnFd64cJs4UXVTl95Bq7spiDjZq+sH6FhcEA3/5s+Ke67Yd++XIr3v5LsefU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8VHhn2T4Dw1NmJjVr12n7hsYR/TPz45XhK1EvN0PHqULOTty32
	lo/rPtHEnIS0ZPTAk32GqfLGhFcm5mpxe33EaxYJqBpgd+1HQRVU/bp95EtdPXuJYd8=
X-Gm-Gg: AYBFou05VzJoLEPhDp/aYZ+NWpJlHqZLaoxjrUl7oO2Pz2KtosyoNvUIojIkyyrH50G
	okzqjrN0kc2cjSeefrjmOWSlC9EjSRzdG4quA9//MpndmpX7KfFOcvqZhUAZARLsISo04bfN88f
	TVxB7fUhRHj+gFNJX6qF1wUsIpKON0WohypTXSQZ/HoVx9rLKZUrP1sE+SUrglT8XA4/V+5y9kQ
	TUvioj6apO2DSh8Y2gWw14EwoYnKbU1lcqIGbxAeQhQiuPeTSh5guXcQOSORZ82q0JHBQZGGKCM
	tK/LlaqB4uJq/LivmekIoNYm5lM4NPLp+Tn7I/QZ2+zGPfAx7TWbiuvyW9+2NnH7av4Y1+JU8Vo
	3VfAta0iuUGP95flv6vTdsiv+R+aFJTj3wsBLO4adG47XWIXi/JvJhqbpmGa1MFgKpC3mBAc5tg
	po03yrRFYJtmLw2wiWGQ7tDKj4uza6Wrs5DeW8JAlmXbgcemudspaWRuFJ1cSDGtJKlA3/gQQd4
	DRQ6ZZCbxIQeA4ctizTOpJKg+GLUPezxx4uAMEC4waf856EgeHALpf7KyDMdSvMV51RqaR73o6P
	YSXT/kvjkdg8XbFY/1rE2KUhkHGTRqin8VcXb8j3lz4mpKWEUANQKZBdmJouF87X2Qo36RJun5Z
	h9OfaXYl+
X-Received: by 2002:a05:620a:1714:b0:949:73f3:83c with SMTP id af79cd13be357-94999572b95mr323060585a.21.1794971356503;
        Tue, 17 Nov 2026 19:09:16 -0800 (PST)
Received: from [192.168.50.231] (pool-71-191-145-202.washdc.fios.verizon.net. [71.191.145.202])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9499b74dd0asm76329585a.19.2026.11.17.19.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 19:09:15 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] [v2] mm/mempolicy: fix copy_nodes_to_user() for
 odd inputs
From: "Gregory Price (Meta)" <gourry@gourry.net>
To: Arnd Bergmann <arnd@kernel.org>
Cc: David Hildenbrand <david@kernel.org>, Gregory Price <gourry@gourry.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, 
 larips <larips950@gmail.com>, stable@vger.kernel.org, 
 Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
 Brendan Jackman <brendan.jackman@linux.dev>, 
 Johannes Weiner <hannes@cmpxchg.org>, Jackie Liu <liuyun01@kylinos.cn>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20261117211635.2472067-1-arnd@kernel.org>
References: <20261117211635.2472067-1-arnd@kernel.org>
Date: Tue, 17 Nov 2026 22:09:15 -0500
Message-Id: <179497135500.1538916.14761148206849685975.b4-reply@b4>
X-Mailer: b4 0.17-dev

On 2026-11-17 22:14 +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The compat_put_bitmap() argument has an off-by-one error that leads to
> copying an extra 32-bit word from the kernel stack to userspace when
> called with an argument that is one larger than a 64-bit number.
> 
> In addition, the size calculation rounds up to multiples of 64 bits
> instead of multiples of word size as documented in the man page and
> expected by numactl.
> 
> Fix the calculation where needed to use the correct -1 offset
> and pad as needed.
> 
> Reported-by: larips <larips950@gmail.com>
> Reported-by: Gregory Price (Meta) <gourry@gourry.net>
> Fixes: e130242dc351 ("mm: simplify compat numa syscalls")
> Link: https://lore.kernel.org/all/20261117101910.1820066-1-gourry@gourry.net/
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: as Lorenzo pointed out, the off-by-one mistake is part of the ABI
>     and cannot change, we just have to use it consistently.
> ---
>  mm/mempolicy.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 6d662a9a8c74..e471ce615691 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1749,12 +1749,12 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
>  static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
>  			      nodemask_t *nodes)
>  {
> -	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
> +	unsigned long copy = ALIGN(maxnode-1, BITS_PER_LONG) / 8;
>  	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
>  	bool compat = in_compat_syscall();
>  
>  	if (compat)
> -		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
> +		copy = ALIGN(maxnode-1, BITS_PER_COMPAT_LONG) / 8;

bleh this is such a mess to reason about.

Pretty sure you need to keep both of these lines: 

      if (compat) {
         copy = ALIGN(maxnode, BITS_PER_COMPAT_LONG) / 8;
         nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
      }

Otherwise now we can get the opposite problem.  If the buffer is longer
than nbytes, we'll write too few.

Test:
```
   /* 32-bit get_mempolicy() leaves nodemask word 1 stale (needs <= 32 nodes). */
   #include <stdio.h>
   #include <string.h>
   #include <sys/mman.h>

   int main(void)
   {
      /* int $0x80 is a compat syscall: pointers must be below 4G */
      unsigned int *m = mmap(0, 4096, PROT_READ | PROT_WRITE,
                   MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
      long ret;

      memset(m, 0xa5, 4096);
      /* i386 get_mempolicy(275)(&policy, mask, maxnode=1025, 0, MPOL_F_MEMS_ALLOWED) */
      asm volatile("int $0x80" : "=a"(ret)
              : "a"(275), "b"(m + 512), "c"(m), "d"(1025), "S"(0), "D"(4)
              : "memory");
      printf("ret=%ld word0=%08x word1=%08x -> %s\n", ret, m[0], m[1],
             m[1] == 0xa5a5a5a5 ? "FAIL: word 1 stale" : "ok");
      return m[1] == 0xa5a5a5a5;
   }
```

base       -  word0=00000003 word1=00000000 -> ok
this patch -  word0=00000003 word1=a5a5a5a5 -> FAIL
fix above  -  word0=00000003 word1=00000000 -> ok

-- 
~Gregory

