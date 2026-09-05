Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C422472AF;
	Sat,  5 Sep 2026 23:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788649768; cv=none; b=jdDRLR5lLBeuboT5pEBHRx/PtsMPULUiRtSkfKKTIoN8Vm6v2LgiVKlPj4QiXUQhi1B9HBylOjW2X37aun7uGKVR0xlo3xiwgyi7V1eQqvZzkWIQMR3SC+fFb6txVV53y/PGLHRK+J2UtRdaGqPsm/a+C01dKbnX4Ipadb5Hq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788649768; c=relaxed/simple;
	bh=Y6XIaVAd8AIvpqRPODe43mHt0xLAedfYdq7+Pdhbi70=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iP6k0c20d7nlRoQjwUA5UQ4O4ofN0vSYdIPtL3VnkU3XglOxXlSJwJmwmA0U3de4hlY2ln3U+7WJvRgjZ5qb+dOZdoA6kKnRrfTFALbVJr4q2PWEtOOjkxjduhmLqlsGBNrSq4a3RLrwCU8n3N8lzu47sU29KGFjWWwlld13tno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C7dIJfzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C7dIJfzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533DC1F00A3A;
	Sat,  5 Sep 2026 23:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1788649767;
	bh=7MvH/fL/MoL/0Xg/K8Z12nlCW6Dkm7qOIbbrTCfZHRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C7dIJfzpfJ+sDTZ1NygWVigYa2VcwgEfAjj9LTpyc1yQQ8opPo6leshC7FwEejVbZ
	 7qqz3rLYlh/DRo55oG9x9cF3zOwXJ/+q7GTzBYovAJcEEHlPdUFC3vTKJeo2gw4gM4
	 dOp4GufsgbaFSrNdmD7dnvrK9H6DLOXBS6ZyDufw=
Date: Sat, 5 Sep 2026 16:09:26 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Longlong Xia <xialonglong2025@163.com>
Cc: hannes@cmpxchg.org, yosry@kernel.org, nphamcs@gmail.com,
 chengming.zhou@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Longlong Xia <xialonglong@kylinos.cn>
Subject: Re: [PATCH 1/1] mm/zswap: enable static key after runtime pool
 recovery
Message-Id: <20260905160926.9836f2ca0dc977b89f2f146e@linux-foundation.org>
In-Reply-To: <20260905125101.2970456-1-xialonglong2025@163.com>
References: <20260905125101.2970456-1-xialonglong2025@163.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  5 Sep 2026 20:50:28 +0800 Longlong Xia <xialonglong2025@163.com> wrote:

> From: Longlong Xia <xialonglong@kylinos.cn>
> 
> When CONFIG_ZSWAP_DEFAULT_ON is disabled, zswap_setup() can complete
> without a pool after a failed initial pool creation. A later compressor
> parameter update can create and publish a pool, but does not enable
> zswap_ever_enabled.
> 
> If users then enable zswap, zswap_store() intercepts swapout while
> zswap_load() still returns -ENOENT without consulting the xarray. The
> swapin path therefore reads a stale backing swap slot because the store
> skipped writing it.

That sounds bad.  I'll leave it to reviewers to suggest whether this is
a sufficient description of the runtime effects, and to decide whether
a backport is appropriate.  Please.

> Enable the static key after a successful compressor and pool update. Do
> this outside zswap_pools_lock because static key updates may sleep.
> 
> Verified with fault injection on a stock kernel (compressor builtin,
> CONFIG_ZSWAP_DEFAULT_ON=n):
> 
>   1. Boot with zswap.enabled=1; pool creation fails, init completes
>      pool-less (static key off).
>   2. Echo an available compressor name to zswap.compressor; a pool is
>      recovered but the key stays off.
>   3. Enable zswap.
>   4. madvise(MADV_PAGEOUT) a pattern-verified 512 MiB region, then
>      fault it back in and verify.
> 
> Step 4 reads back 131072/131072 zeroed pages (zswpin=0, zswpout=131072)
> without this patch; all pages intact (zswpin=131072) with it.

And thanks.  Sashiko might have found another issue in this zswap code:
	https://sashiko.dev/#/patchset/20260905125101.2970456-1-xialonglong2025@163.com

