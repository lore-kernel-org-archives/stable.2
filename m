Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795647087;
	b=vJ05ez3yALICHBW0qjW2D5gtes46ejVeSe7FOQmfeJhDcVLy+78r63tisvpBMzNZwdhn
	 utpUV2BEd7MrA87Nofz3aMjKxheOGdKOWWfKe0GNNVNXvaeOzwnFkqg42AewyyLYjpr0l
	 aqprtuiXtvz5L5+vd4xHguTDItKTYQM/IYN06vw7zoGaSVHP00+LbqBKT73XxujK/ocxP
	 rgXz5wCCSED3oxDMh67/q6hRlpnmZph45mUuYdMCSVpRxMgOSqFN6j5sFU+W7CKTPhPk0
	 zO3/13xmBjiGECkuwNZ6YAOFNBuL8JvG2Xn8wxdwR18ZNas/au8tyPcSsNw4CM//hPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795647087;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XiEaXyK4wnqo/lld8izd+mPMlTH01p0W9lNsSXFPEr4=;
	b=5KzX0TEUU+fQ2oqLD3RKxS/RliK85g0cxM5HwmFp0laI/GCFHt7CxS36sjPgSWiefHx7
	 flCB0RFl7RRCnae7o7tfwMnJGqMB7Nsm3mHMK1jGr/HflApBII1DTlW41QzNBZ8B0Tna1
	 JTpDk/D3OyRNPHdNOVAPa6i5QMLZR6mqDxGFswWYfH0JvIjIXYaVSIAo+gcJpvARl2K79
	 /5yLm4DwD3cv0o4e0pVYe2imqw6Uf+EL5DQl0H8QTAZEtESXLPE6BGMfW3ncZFzA84BWc
	 OClMGwUaHUHeyoNztZ3f7YW0PTrjiMkTUmN3qyXZRC9nyKPdaH5xtIsWL3kXFrlfOtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAM8pxul;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1234E606A332;
	Wed, 25 Nov 2026 22:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AAM8pxul
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 264F81F000D2;
	Wed, 25 Nov 2026 22:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795647086;
	bh=XiEaXyK4wnqo/lld8izd+mPMlTH01p0W9lNsSXFPEr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=AAM8pxulDq4TCwh7/7+vcCxkTJGss+cIX1YrGhtlWy+rp14kajXzbRhLczZMNvbL/
	 t0oxHKGiDkUCQj77OdWqwGuGTvVWv6olXGXDnn1UlNrQAbKdxYgJ5udgJOWuj5g6Kp
	 aK/R3iiP+opUZaUbDVgsye66y5lEZXH7hZjKVTuseo3ZmQfCNmSEUYtEz+wVM3IQUU
	 hU51s7DAFhFDIx13KX+G6lqdntTP2kkyzttOBsa4lxni1cjMm6askFAG+IRh3Bq0ho
	 UcV6WaExu58QkVIdLMkEWnJyomaUICrL+ROOldMEi4/3Jj9xfDn5L91HUBgtZpD8wh
	 IMMtoK55AxuZQ==
Message-ID: <f5ff8f43-c75c-4b19-b683-fdff0c6dd7ae@kernel.org>
Date: Wed, 25 Nov 2026 23:51:21 +0100
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
Subject: Re: [PATCH] mm/gup: fault in ranges that start at address 0
To: Hengyu Liang <hengyul@cs.unc.edu>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Baoquan He <baoquan.he@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
 John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261125173202.3636133-1-hengyul@cs.unc.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261125173202.3636133-1-hengyul@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/25/26 18:32, Hengyu Liang wrote:
> Commit a7797e74bd39 ("mm/gup: clean up codes in fault_in_xxx()
> functions") made the loops of fault_in_readable(), fault_in_writeable()
> and fault_in_safe_writeable() stop when the current address is 0, to
> detect an overflow.
> 
> However, the loops then do not run at all for a range that starts at
> address 0, and the functions report that nothing was faulted in. As of
> now, a write() from a buffer at address 0 fails with EFAULT when the
> page is mapped but not present yet.
> 
> The issue can be reproduced with this program, run as root:
> 
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <sys/mman.h>
>     #include <unistd.h>
> 
>     int main(void)
>     {
>             int fd = open("file", O_WRONLY | O_CREAT, 0644);
> 
>             mmap(NULL, 4096, PROT_READ | PROT_WRITE,
>                  MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
>             printf("%zd\n", write(fd, NULL, 7));
>             return 0;
>     }

Thanks for the report.

Ah, so we require root, because usually we have vm.mmap_min_addr limits in place.

Where we disallow mapping to address 0 for good reasons ;)

> 
> Before commit a7797e74bd39 ("mm/gup: clean up codes in fault_in_xxx()
> functions"), the result is:
> 
>     7
> 
> After that commit, the result is:
> 
>     -1
> 
> With this patch, the result is the same as before that commit.
> 
> This patch will stop the loops when the current address is below the
> start address instead, which is only the case after an overflow.
> 
> Fixes: a7797e74bd39 ("mm/gup: clean up codes in fault_in_xxx() functions")
> Cc: stable@vger.kernel.org # v6.16
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
> ---
> I found this while comparing the behavior of different kernel versions.
> I used an LLM to analyze the problem and to draft the patch and this
> message, and I analyzed the result myself.

Okay, but you did not actually run into this yourself, right?

Doing some research, mapping to address 0 should not really have any users.

There are some legacy dosem and wine emulators, but looks like that's only a
problem for 32bit and all legacy.

Likely this is "nobody cares" and we don't need CC stable.

> 
> Tested on v7.4-rc3 with KASAN and lockdep: with the buffer at address 0
> and at 0x10000, on ext4, tmpfs and xfs, write(), pwritev() and O_DIRECT
> reads and writes give the same results as before commit a7797e74bd39.
> 
>  mm/gup.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 2b405cce2ca5..a174e93327e9 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2074,7 +2074,7 @@ size_t fault_in_writeable(char __user *uaddr, size_t size)
>  		return size;
>  
>  	/* Stop once we overflow to 0. */
These comments are not really correct anymore. We don't stop once we overflow to
0 anymore.

Likely we want to be more careful when calcualting+handling end instead.

-- 
Cheers,

David
