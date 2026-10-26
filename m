Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057095;
	b=SVUkE7nL2MrMwHfMb7Mq5UhhIWng2EEUuYjTWDi8ViYn+unAp8j0WeoR+Me/MTqnerLf
	 NtRocYqMQhWcwY/LZr7jIWhViCfcX8smoseKCTkBxXinmwRyOUgezJWxBhrayItlhza1Q
	 wvxvHHsFQjJulXxc4k1bFC3DNrEVgLIpdAqgrs5hYDb7ySEZlF5IsR9AQqkEekNAwbQI4
	 SErFu4UnASNRcRNYkOwjrvCRqgYgPvtCtcniExEiRe/4teTHq052r5XFJJSYb7/ORFLKX
	 Q5g9SqwxLjZbszJtqI7fx+x9lwnuItTLvfWEfFfwBg5EfLH3bmrJNzFhE2VRuIZQGqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057095;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=kd3Dml8l3wq2mpKC3ZlVeUqbWcVHK5sKBx/wLEoqeB0=;
	b=vbWke3HnA1ySfcmUBQlRKdTevOkFHrn4byq+aaY7L/5al7dytnwK96I8dBYLNLy3ePwQ
	 gj6MqQ0LPECk3TR8hf4tk2VmWOcT5NIAbhXjKN8PjcWEFfnxyJbET9vCk7y1TyhB4yY2I
	 PxH4L/V+zUuLr99+7aZDkgYZ4jUuKpamDXvCk9U3fxR0JaUt0+11fMTTZlzEZa71hU6SA
	 +zN/6wHEK5feZzqOTMYZX+vJODCnc09BoL1Kit3wejNHr05LuPlIv45DVjZ5897QVwXyE
	 E4ZeLvAAru/el4jcz4k2XaJcvlHufP7PJHUHUgGApUybOf02l+vE8POdt2IpJsJQ4Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+vLYLtK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB31606A327;
	Mon, 26 Oct 2026 23:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n+vLYLtK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BBCE1F01829;
	Mon, 26 Oct 2026 23:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057095;
	bh=kd3Dml8l3wq2mpKC3ZlVeUqbWcVHK5sKBx/wLEoqeB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=n+vLYLtKcNv22bWBkMUGXCCk9gajovYZy6u8dQ6jFeLyq4kpoCxdJi0VGVXm/RKKr
	 TnmJczfopJdIqOKC/bvueb8a1IUKSpHq0MkO3GERMNwu7TWiZRyatNv9gw/jgFmi6l
	 Q8BLjog93OMzQB4vESNPiBsCz8e3mhea/ge8JeHM6/8pAJbY4IcRf+ZDno2W3EI7mS
	 NssvA4u/wjqlObgc4uiZDqRGTMQHigLSUgLw+3wYkpC/VA/Qry13ipXJOJ6YlRA1tL
	 am+DNTfRuyttb6yiNo69/enwFUs3hEtDaPhRTtD01NkLO7sg3EUPIsRen7n35FtD9F
	 +R6TlPI70Fwew==
Message-ID: <c267c29a-5678-4c0f-a15d-e5c12ae8c427@kernel.org>
Date: Mon, 26 Oct 2026 23:33:31 +0100
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
Subject: Re: [PATCH] arm64/mm: restrict transparent contpte mappings to valid
 PTEs
To: Catalin Marinas <catalin.marinas@arm.com>,
 Zhao Gongyi <zhaogongyi@bytedance.com>
Cc: will@kernel.org, Ryan Roberts <Ryan.Roberts@arm.com>, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, lance.yang@linux.dev, mark.rutland@arm.com,
 akpm@linux-foundation.org, ljs@kernel.org, liam@infradead.org,
 vbabka@kernel.org, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261013093600.54995-1-zhaogongyi@bytedance.com>
 <daab2f45-56c2-48ad-a24f-aa4f889e4da2@kernel.org>
 <e0f60526-bb95-4d39-9a7a-72cdf32ca5b6@bytedance.com>
 <cc2e3af6-bb56-41b1-9cde-151797c3068d@kernel.org>
 <3b57c214-6a43-4fc7-a531-fb5eac196465@bytedance.com>
 <at9H9Vkx57pIcPos@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <at9H9Vkx57pIcPos@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/26 13:30, Catalin Marinas wrote:
> On Sun, Oct 25, 2026 at 12:00:33AM +0800, Zhao Gongyi wrote:
>> On 10/24/26 4:55 AM, David Hildenbrand (Arm) wrote:
>>> If we have the spare PTE bit, why shouldn't we just use it?
>>>
>>> It will make batching over PTEs faster. And we care about that for present PTEs.
>>>
>>> So I don't quite see why the stable fix couldn't just do it right away? Do you
>>> have a prototype that shows that it would require significant code changes?
>>
>> I tried a small prototype that keeps PTE_CONT on present-invalid PTEs.
>> It leaves contpte_set_ptes() unchanged and makes contpte_try_unfold()
>> recognize pte_present(pte) && pte_cont(pte), instead of checking only
>> pte_valid_cont(pte).
> 
> I think it's worth doing but currently not sure it buys us much unless
> we also change pte_batch_hint() to cover such entries. However, if we do
> this, we need to audit the other pte_valid_cont() callers (e.g.
> ptep_get() needs updating as well).
> 
> So, if we aren't going to change pte_batch_hint() as a backport fix (I
> don't think we should, it's an optimisation), I'd rather take v2 now and
> continue with a proper pte_present_cont() etc. patchset on top.

Your call, the version actually looks quite clean:

https://lore.kernel.org/r/52e7e1f6-3535-474d-9b46-6bb62f96eefc@bytedance.com

But yeah, audit needed (e.g., no need to flush when shattering such entries that
are not valid)

-- 
Cheers,

David
