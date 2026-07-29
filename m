Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F23B058D;
	Wed, 29 Jul 2026 16:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342084; cv=none; b=XUMlBF1rl8+aZrvjK79D705bdqs0HORlbBkNON4PNPHOT1Ny6OtFLe6RPC2f9nGFK8/njP3wSKmdUGvNZKoaAkeMmJXtSEg6Iycmp0+zpiI2YhRbfJLUMZO7T3rJQZszRbmQjC+q41BB5Np8AUWk3rcvz4ODzPHr4BT6m1EC2x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342084; c=relaxed/simple;
	bh=xGEQOdJ0fqTIEZ3CdD2nxnvptkZLl+xDibIfRdDqs0c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuHUBhQliVkxX2tq3BJ8w/t4jf9qaetK37jxQ6GwRpelG1PUKBT4wk9zuAe5jeMRv/B8Srf3JOfCh4ungZQU3fKMJ8evcKhEVGtBhonBeSAxqfMSu3c+O1oGCa7Max84tjCJSJObVHEScAPP5iPqwsUQy2liv1HlPg5iCUYY2Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MOh/4662; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MOh/4662"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D131F000E9;
	Wed, 29 Jul 2026 16:21:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785342083;
	bh=JM4FiXN/GSZDdrwaTNMY9uV5gz3Vu4GPflJilJ5fnjA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=MOh/46620tT8hSHj6p/BSKgS94jECE/HC4cUhJ+8nmae+Iz9xMIvr1U+hrnfKv8ek
	 hO4IbTNLytAwdbfb6QS7Gqf4KepMbYFy/+ZW7ORJMm3eJPd2tPTfwSHuPSlpBc8CVu
	 k5c32H2Sq2AHvh4Hiyn4erLAtAPrYvj3ScgDWY+etN6t34d1Cgr9WviBAFIRpkc7+Z
	 Vm8LMGuZbLY8p+ymN8vNqn0LQhz5BHcbBBJBacAvmqfVPUYf/6gevXxuxhfE7sKKYj
	 4Onfq6euYjNuPG/n9PLMUIWddt3boORc71rGTZNVj2kyB9fNhAXu32PdY0Y/4K3fHP
	 RxYYHotVl2i6w==
Message-ID: <e5d6417f-5313-4fbb-a245-4f4c3a9d91e9@kernel.org>
Date: Wed, 29 Jul 2026 18:21:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm/slub: fix missing debugfs entries for caches
 created before sysfs init
Content-Language: en-US
To: Li Xiasong <lixiasong1@huawei.com>, Harry Yoo <harry@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: stable@vger.kernel.org, Hao Li <hao.li@linux.dev>,
 Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, weiyongjun1@huawei.com
References: <20260729101849.3734287-1-lixiasong1@huawei.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <20260729101849.3734287-1-lixiasong1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/29/26 12:18, Li Xiasong wrote:
> slab_debugfs_init() creates the slab debugfs root at device initcall
> time, while slab_sysfs_init() moves slab_state to FULL at late initcall
> time. SLAB_STORE_USER caches created in this window miss their debugfs
> entries because do_kmem_cache_create() skips debugfs_slab_add() when
> slab_state <= UP. This was observed with MPTCP's request_sock_subflow_v6
> cache, whose slab debugfs directory was missing.
> 
> The affected window is:
> 
>   slab_debugfs_init()
>     slab_debugfs_root = debugfs_create_dir(...)
>     list_for_each_entry(s, &slab_caches, list)
>       debugfs_slab_add(s)
> 
>   kmem_cache_create(..., SLAB_STORE_USER, ...)
>     do_kmem_cache_create()
>       if (slab_state <= UP)
>         return without debugfs entries
> 
>   slab_sysfs_init()
>     slab_state = FULL
> 
> Initialize the debugfs root and add debugfs entries while holding
> slab_mutex, walking slab_caches exactly once and handling both sysfs
> and debugfs entries in the same pass. This gives the sysfs and debugfs
> initialization an explicit order and prevents caches from being
> created between the debugfs scan and slab_state reaching FULL.
> 
> Gate the new slab_late_init() on either sysfs or debugfs being enabled,
> with the slab_kset creation and alias_list processing factored into
> helpers that have empty no-sysfs variants, as suggested by Vlastimil
> Babka. On slab_kset_init() failure, slab_state stays below FULL so
> kmem_cache_create() keeps taking the early-boot path, matching prior
> behavior.
> 
> Guard debugfs_slab_release() against an uninitialized debugfs root,
> since the root is now created later and a cache may be released before
> it exists.
> 
> Fixes: 1a5ad30b89b4 ("mm: slub: make slab_sysfs_init() a late_initcall")
> Cc: stable@vger.kernel.org
> Suggested-by: Vlastimil Babka <vbabka@kernel.org>
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>

Added to slab/for-next, thanks!

