Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793694416;
	b=3o9Il48bBe9hZqtqs93awld57QbVhuIq2aWVE+6529WrWGQpUrdzJftM8xU3UEutJ4Ol
	 nN4kOrmBAE4znISxxXBEgZH8IzMgdAq75vVMTn91GHer3kPknb6q8rqEQVZthqTpyEbzV
	 brA8SH8ozxjyZtU+WdjmUzGyhNid6K8Wau3nWV+0+f8+Smlvxzi1LUx8KcEyzb3YBVd9r
	 7U+FreyGUwpPn10QTKuLewlWEWhApBvrvWuqLifCAbn8gejWItpyZ98/up9h7/veGkARD
	 93/BAFzUrhcBL1c3mXLE9xnRce9STqqTVv3RuQWituxUbYLgfyIkBZgntdnI1052C8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793694416;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=W7kXggEh5yfe6fFE4jTh1v6G6P3GKOrRyW+l+lOyS6o=;
	b=EmgtROJWuUJBSPobmhn8JfdcGsBuFgnpLmivCYo9TUwv/1IWYcBCJTuGzQVoA4LPdVjI
	 WMfxejRObDRL1I3ZVD2GuwluAVcHKTk9rY6p7AQrFeqHKX1KM3+YxTzuXvkAW4xgq10pe
	 Mi8Otn00kGcqJiRJmoF+kg7M9mKjme2BPSZgPruW31DtwqTcT9VdNbnWIwpWttL1Dv4ye
	 bNe/nHlQG5utOGNLoAkvWDmkp8S+6Xv7B9+jXVVmtkELS/zKO5p4A5aJxP2NnJWOOWWLp
	 J4sFTb47L7rzosDyw9Y2+brYIfXTjOsL8hrhUFk+rsuhujni2buQtQN9HDR3kAaVsAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv3ZoNV6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEE8606A324;
	Tue,  3 Nov 2026 08:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zv3ZoNV6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC521F00919;
	Tue,  3 Nov 2026 08:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793694415;
	bh=W7kXggEh5yfe6fFE4jTh1v6G6P3GKOrRyW+l+lOyS6o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Zv3ZoNV6A09/e9kgq/U85LcDr1trIfitCwIcOsR3rnB2t5G1R+2TRWnqw+pR3/d9G
	 ZmieS1S8Eob9FcHxlWOVUXdsItDJbIMZ4GSZ3srI7u1hMYB0m/Sx3cNkPTjsfPr2/X
	 mVB5V0QdTR6BryF8n1lYbs7Kg1Au+suC47xkkyxiKQO8FmWMp4ETFUnwCKFUSe8b55
	 Xvym3MP2LWqa9eqh4wCz0dg6wH1ZWXzh/dXsnqPxL0oXTuVkMgPeZVq4BprfQIcjeK
	 mqSce21Td5+ApzlLra/UdQEd8wvPtFkinREmlUI9iKPEmQTBb5Zgm7RCelWzz9p5gw
	 yM33zUDxL8zNA==
Message-ID: <46cb1b29-3e4a-4b2e-88bf-5d7962158823@kernel.org>
Date: Tue, 3 Nov 2026 09:26:47 +0100
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
Subject: Re: [PATCH v2] mm/migrate: fix softlockup in do_pages_stat() with
 huge page arrays
To: Qi Xi <xiqi5703@163.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Byungchul Park <byungchul@sk.com>,
 Gregory Price <gourry@gourry.net>, Ying Huang
 <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Qiliang Yuan <odys.yuan@gmail.com>, linux-kernel@vger.kernel.org,
 wangkefeng.wang@huawei.com, sunnanyong@huawei.com, xiqi2@huawei.com,
 stable@vger.kernel.org
References: <20261103080557.1632382-1-xiqi5703@163.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261103080557.1632382-1-xiqi5703@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/26 09:05, Qi Xi wrote:
> From: Qi Xi <xiqi2@huawei.com>
> 
> do_pages_stat() walks the user page array in 16-page chunks but never
> reschedules, so a huge nr_pages can hold a CPU past the watchdog
> threshold on non-preemptible kernels.  Add cond_resched() to the loop so
> long move_pages() node-query calls yield periodically.
> 
> With KASAN and function tracing enabled, a move_pages() node query
> (nodes == NULL) over 10 million page entries (~40GB of mapped memory)
> reproduces the softlockup on a 6.6-based arm64 kernel with
> CONFIG_PREEMPT_NONE=y.
> 
> In current mainline, only alpha, hexagon and classic m68k can still
> select PREEMPT_NONE; stable kernels older than v7.0 still allow it, so
> the fix mainly targets pre-v7.0 stable users.
> 
> Fixes: 80bba1290ab5 ("mm: no get_user/put_user while holding mmap_sem in do_pages_stat?")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Qi Xi <xiqi2@huawei.com>
> ---
> v1 -> v2: describe the repro environment; add Cc stable; no code change.
> 
>  mm/migrate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index 7bdcdb57652f..6c2371020cc5 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2545,6 +2545,7 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
>  
>  		chunk_offset += chunk_nr;
>  		nr_pages -= chunk_nr;
> +		cond_resched();
>  	}
>  	return nr_pages ? -EFAULT : 0;
>  }

I'll wait a couple more days and will then queue it for the next merge window,
not as a hotfix.

-- 
Cheers,

David
