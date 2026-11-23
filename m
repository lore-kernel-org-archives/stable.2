Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795463144;
	b=4J49a6MuD+neft/mjlr4nhovmfEakWwdAdwfhiKOdzAt6Y0i6e1jtLl8K56v9Ka/+Dqc
	 biiiTKF39Nwf0W9Oz2PQajGwD5s3YMZbrwfEqq+HwtQcjiTynjSdnvaPoM2M0rQGOK+/T
	 DlUrxDk0uvZCEgw67RJwX2mZEggosG+dmrpLetMQVXoxgRc8MuLJHSuMnsFKhqAfW7gZn
	 CXpIYLU+FBzbWOsWqJDCn/d8wcfsoBZLGALCFWa+/KURi5mTBSfC/Sx5VLuCMPbv/pHkD
	 Hu/lLbWhfBboFgscEgpbvL+PNfXVUO56t3/Bwvf7kcUktHUo64ypY4ysMPxDPb6OIhA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795463144;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=pD6s92k761c1Ji+Edgu0dOlrKizCHM30TIfkHtFjL/4=;
	b=5RuocyrLGfx+5zc882H3/gu0TsQlmppcdKV79pOu8PIrd3CNUzXtZFYR/9WmmxH4LG8r
	 msuWvohbCPXFhWzt21AUlSAfmj/Rz86ChLJpjAzQNS83+vd3sWu/H7iPGEE23JCCdwF2S
	 YDVnTvACuZqJouaEqkgNoXFjATudAc9kPyXPjqYL3bUqilFBLocFmfpi0AzA0ewmd51vi
	 6ta3+IQlSMiitZ+mxdYhPwceXUIPItGm/ZUs1N+2a3uHU2UEQY2+I45TDESz2eKhFSozS
	 mXOBMAXr6D/OsACKkqvovAysN1yvntds1dwpuLw/Zx2OmOjKzLPqDkdM+gUXT6YSd1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJvImX4Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC09606A31A;
	Mon, 23 Nov 2026 19:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kJvImX4Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 820D21F000C6;
	Mon, 23 Nov 2026 19:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795463143;
	bh=pD6s92k761c1Ji+Edgu0dOlrKizCHM30TIfkHtFjL/4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kJvImX4Zp2Shrp12IX87KJgXNh6vruJzS2+IdBsJBQxCX+u4DeeB/9tWE+h7aB9fh
	 nfefktlwJ8uFLFmSBSfZZwW9AQjnjw3xWsf2+d+zwx2MNP/smC0cpGbFf/6+nExeFP
	 ADiRMC0uXVKynZrTDFhWDThDOuUoTGi4Bn5JNVFkotaTk32iAJkmit98MQCVrcDebL
	 hvUBydB5yLLvy+cVOtIJKQJLLMwDTxRrKD0OLm8+LMdWtpJKc8fAOgCYrI9grDDxAc
	 ZGbmn8pqhwoGtBpIMth/Bj5gBOnme1T2NjLuJTQlC38jMpOTUZG/Sffhvq492vFYoD
	 T7vGRinp3VvGg==
Message-ID: <89037847-8875-4d8b-a8f3-d77a59aaddea@kernel.org>
Date: Mon, 23 Nov 2026 20:45:37 +0100
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
Subject: Re: [PATCH v2] mm/memory_hotplug: don't offline a hwpoisoned page
 still in the page cache
To: Mani Tofigh <mt4022@columbia.edu>, Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Vlastimil Babka <vbabka@kernel.org>, Gregory Price <gourry@gourry.net>,
 linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 tz2294@columbia.edu, stable@vger.kernel.org
References: <20261105-memhp-hwpoison-pagecache-v2-1-029d35634d42@columbia.edu>
 <d4812513-6cfb-4865-8636-b83dd92c23a0@kernel.org>
 <2e11ba52-b5c6-463e-a5ea-c165ba935704@columbia.edu>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <2e11ba52-b5c6-463e-a5ea-c165ba935704@columbia.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/23/26 06:46, Mani Tofigh wrote:
> 
> 
> On 11/6/26 3:58 PM, David Hildenbrand (Arm) wrote:
>> I didn't understand why just checking for the refcount is not sufficient. Can
>> you elaborate once more (and please not send a new revision before the
>> discussion is over).
>>
>> Memory poisoning must grab a reference when setting the folio hwpoison. Any
>> other reference (pin, pagecache, swapcache, mapping) keeps it alive.
>>
>> Why can't we build on and?
> 
> 
> Right, but memory_failure() doesn't always hold that reference. It i)
> sets the flag before get_hwpoison_page() grabs it, which waits on
> pcp_batch_high_lock that offline_pages() holds, and ii) gives up with 
> the flag set and no reference when get_hwpoison_page() fails (e.g.,
> a pagecache folio briefly off the LRU). In both cases the pagecache
> holds the only reference, so offline can't tell it apart from a
> page memory_failure() already handled.
> 
> So I think if we move zone_pcp_disable() in memory_failure() before
> setting the flag and keep the reference when it gives up, offline could
> simply treat any poisoned page with refcount > 1 as busy. That'd cover
> pins too. What do you think?

We'll have to find a way to make that reliable. Everything else is just hacking
around it.

Why can we block concurrent offlining through get_online_mems/put_online_mems?
But I hate these functions.

Or alternatively (better?), have a memory notifier that block concurrent
memory_failure() by grabbing the mf_mutex when MEM_GOING_OFFLINE and releasing
it when MEM_CANCEL_OFFLINE/MEM_OFFLINE.

Needs some thought, but if the problem is that these two mechanisms don't
interact well concurrently, then we should make them mutually exclusive.

-- 
Cheers,

David
