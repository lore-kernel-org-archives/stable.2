Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795119378;
	b=al+gENU2mm4Ae+NbKFrDE7s5BGMUqaslcEFIGq1T/LBUucFfsn+ac2lPWUYNkENeYZ78
	 Ag5EaL/zph1IPOkQ/YvkusDF+qO9oGWA5TTxWuB5k4CVFYTiX0Pow2jTQUbKsYfDmKRU8
	 5Oj+z5mSBI7NFrnq8kgHJYhYK6Cu4cv/0jfnbUUQ3t6ATfp5YaacMelaD02sFBr2Z8EmM
	 0SJLn8zAi9nLLyi5jx16AXYufvq7PpgAgmGvEB+/+n7scuXfAK4SWfZI4K+HkT7OBI/S3
	 eB7KynUQhn3aES7kiK1L9GgzV6bJbnpcqUSvPCiz6yS8trrzJb30lihG0xBCKS0laGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795119378;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=b8guypKOYpjdcOq3rY5Ln184uhI7aFGCjLwkde4AGfM=;
	b=VHGjdtGLFVLo0gBMeek5WBIW3KVZxPuMMSVEFMNHCkrGMLGuNFivexT7yN6C2+XqL/S6
	 ZGcKRoX2y37yjX4MqSXcrfLItrnLZW0FXjFVTttjgvNbiExnj9zPgxYXowM9z5RtnnXlu
	 pdBuw9L2gUq1QRjCKnzOyaQVpKKA9S6k5SE6OWg2ml0k+nH0fYzhr7qfiTNOOJwi0593r
	 0tG90RuhXoCdRzoQS8M+qE9t4Gvqy9RvvPJ6h8aK6YUR+YUdCioc7SZQHyeBxVL1wUL5c
	 xgbZyVsE0awUGWdcqZTgDYmlCdBnq9q9AHGbZG9kez3/OxfnQNkbxwHY4JQhxh0cQgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXI8LCOj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3C606A320;
	Thu, 19 Nov 2026 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXI8LCOj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D611F000C0;
	Thu, 19 Nov 2026 20:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795119377;
	bh=b8guypKOYpjdcOq3rY5Ln184uhI7aFGCjLwkde4AGfM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=aXI8LCOjjbrnYnc0RwqwcQVYjFYuZP7jshxcWA5lgDpS/oXj5bFyoisOI63BRuvSM
	 kMKtLeJLOkrTpn9ArQQOkh1eB1Zkf2LdQcRgjfAKp4N/++y5NRocK9cwepgmT6CYK9
	 c5tTCWykVPcHp1owpvG6vCkTL2wH0FYgVexpoqSj3AHN55XgHM+6x4NtYba3sFofME
	 rjTVVMbukye3C8vRRdAYbBGJQMe82ExTK95/BO4U48uQPFHQwZDxRXAKMI9NErTmmQ
	 yJoRO17NV/LNKzjOWYBxndEBLWU4mi9MqmECbUtFUInzr4XuLuY349L8yVCGJSHkwl
	 JnFuNI7P9jJLg==
Message-ID: <699ed617-8325-4c13-9579-81cd4f0540df@kernel.org>
Date: Thu, 19 Nov 2026 21:16:11 +0100
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
Subject: Re: [PATCH] mm/hmm: reject shadow-stack mappings
To: Dave Hansen <dave.hansen@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, leon@kernel.org,
 kas@kernel.org, dave.hansen@linux.intel.com, bp@alien8.de, rppt@kernel.org,
 stable@vger.kernel.org, "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
References: <20261113195536.2660763-1-gourry@gourry.net>
 <20261113200303.GA395967@nvidia.com>
 <179460249376.482102.14669935557901467762.b4-reply@b4>
 <20261114002027.GE3706007@nvidia.com>
 <20261113181025.6e8b9475b29c13d29f59e02e@linux-foundation.org>
 <20261115000005.GG3706007@nvidia.com>
 <20261114170127.3d29199864eb352d9045eaba@linux-foundation.org>
 <55034934-8aab-4e8a-a74a-b30c977670ed@intel.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <55034934-8aab-4e8a-a74a-b30c977670ed@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 21:05, Dave Hansen wrote:
> On 11/14/26 17:01, Andrew Morton wrote:
>> On x86, a shadow-stack PTE has its ordinary write bit clear.  The CPU
>> rejects ordinary stores, but pte_write() reports it writable because
>> shadow-stack instructions can write it.  HMM consequently sets
>> HMM_PFN_WRITE.  Nouveau uses that flag for GPU write permission, and
>> RDMA on-demand paging can use it to grant device write permission to a
>> registered memory region.  A device, or an RDMA peer with write access
>> to that region, can then overwrite the process's shadow stack,
>> potentially corrupting return addresses or bypassing that protection.
>>
>> Reject shadow-stack VMAs in hmm_vma_walk_test(), including read access.
>> A requested fault returns -EFAULT; a snapshot records HMM_PFN_ERROR.
> 
> This is a fun one.
> 
> I almost wonder if we want to go one step further and disallow GUPs with
> FOLL_WRITE on these PTEs. There should be precious few reasons for
> devices to be writing to shadow stack pages.
> 
> Isn't this a bigger issue than HMM? Should the fix be in HMM?

I think we discussed this excessively after I raised it and it's even partially
documented in the relevant commit messages.

-- 
Cheers,

David
