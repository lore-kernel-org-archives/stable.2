Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794504886;
	b=AIyWc5g8X6BHsp+XnL5uIN78sDHoGAZ5t462lhR/uX3UFZCJDV+GlFGxlMMCKwQYP68A
	 5MBEFzmfONFxBaJtYNN9YA17wqnn65FDyu76LeMthw9x1XtbZLSIKRZntfCuFVEzEy7Ak
	 DPNKnW8K+aS34lca45Z4+LZggbUHCifspVSgFDpX5aXErbQpqPb+bmuxwhe6FkgjOuV/E
	 tqJixPLhCTCxGYgjLXLW2jEbf1dPRomcJJw0TZuLiKciFhaIcnCmModXSuyhdaOd/m0Rr
	 QFwz4oRBs361adhyfqjuK8qn8yR8R3Q44ZOclBK8wMM0oVYy5PJ7d6IgS3LA7RWIrvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504886;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ycrCu3DcnDLB0U88T/9grZGWKZUG1dcYBjk8fgOCOfI=;
	b=F8dSUgLzLZn7xMHGDDGShVsNqhNgh/INTxLu+BJFx+MSWCIfbwHtMu+Rd6xmGlT9bcL8
	 BARX5lb7WnRYkvkZwMESDgDGbKok5f2kAoF/WFTkODcwI2HKgis5ks5g/2JhzcmYaakQx
	 hsHuG01enjPWYjR04WvsnLofhT1p93NC3ygU3TFFx2ZxczPARRQ83I3wQodHL2hV9pxBp
	 /2yI/3rchWDsLFG/IGPpycpkjzExiF0UAgf9c3th2h6JIAp32GeZHQINeW5Yzt/uCj042
	 heVVkGDP0anawafrc+hn3PITkFPnmSZnxFwbfY3+P7gZu8UZfPuFslpUqZeskmWj4Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iK0VbpxC;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364FA60A5BD7;
	Thu, 12 Nov 2026 17:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 364FA60A5BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=iK0VbpxC
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5FB401516;
	Thu, 12 Nov 2026 09:34:42 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECD4D3F632;
	Thu, 12 Nov 2026 09:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794504885; bh=MuWT2VnKrf99VLJVMZG7nQfDKcJKJImkQExrQPVoaGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iK0VbpxC17TUndKMMRwxW2JCmFfLy2r+U+X1AHMewdCIlUdsaX39Z++1PPW32ebO/
	 au1F9IvHK63fT0EV6zljQHdOCa28tu6liLv1oXfdSKRJk/tJAAdkomiD1KNLAFhLrE
	 bvP/0i3hikYeqaUShKyIgnOjeU3GaQAhl1AELh4I=
Date: Thu, 12 Nov 2026 17:34:32 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Shubhang Kaushik (Ampere)" <sh@gentwo.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Shuah Khan <shuah@kernel.org>, Kees Cook <kees@kernel.org>,
	Shubhang Kaushik <shubhang@os.amperecomputing.com>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] futex: Canonicalize arm64 tagged user addresses
Message-ID: <avX4qJ9SG3SJynen@arm.com>
References: <20261109-futex-tagged-uaddr-v2-prep-v3-0-3f5f2ef83138@gentwo.org>
 <20261109-futex-tagged-uaddr-v2-prep-v3-1-3f5f2ef83138@gentwo.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109-futex-tagged-uaddr-v2-prep-v3-1-3f5f2ef83138@gentwo.org>

On Mon, Nov 09, 2026 at 10:26:47AM -0800, Shubhang Kaushik (Ampere) wrote:
> On arm64, a thread that enables the tagged address ABI can pass valid
> top-byte-tagged user pointers to futex syscalls. Such a pointer must
> have the same syscall behaviour as its untagged form.
> 
> get_futex_key() validates the user address with access_ok(), but uses
> the raw address when constructing private and shared-anonymous futex
> keys. A waiter using a tagged address and a waker using the untagged
> form can therefore access the same futex word while hashing to distinct
> keys, causing FUTEX_WAKE to miss the waiter.
> 
> Keep access_ok() on the original pointer so that arm64 retains its
> per-thread tagged-address ABI enforcement. Canonicalize the address
> afterwards, before it is used for futex key construction and shared
> mapping lookup.
> 
> Fixes: 63f0c6037965 ("arm64: Introduce prctl() options to control the tagged user addresses ABI")
> Cc: stable@vger.kernel.org
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> Acked-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Shubhang Kaushik (Ampere) <sh@gentwo.org>
> ---
>  kernel/futex/core.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/futex/core.c b/kernel/futex/core.c
> index a240638f69e5c65bd036434a15f3df680efb4638..dcc8ffca38595a5ea69f3672375ffb9f9c6766f9 100644
> --- a/kernel/futex/core.c
> +++ b/kernel/futex/core.c
> @@ -539,6 +539,8 @@ int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
>  	if (unlikely(!access_ok(uaddr, size)))
>  		return -EFAULT;
>  
> +	address = untagged_addr(address);
> +
>  	if (unlikely(should_fail_futex(fshared)))
>  		return -EFAULT;

Thomas, Peter, do you plan to take this fix via tip or you'd rather we
take it via arm64? TBH, I don't think it's urgent, the bug has been
around since 2019.

Thanks.

-- 
Catalin
