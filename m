Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795108721;
	b=Jry7cze4u2o3/8fjLxr6vq2cgSQ398NM06TMj0TyieQ6EkpYie1URY+7BuGBNif2mjLO
	 ipZu4XeUJg1LO491GGB/MAy2LwY44zEVpxs+9EQrha+YEKakk6DlpbP7ydewzQfDeHp0P
	 Fs2gTJWHbr7VEstsdDfFT2QzuJllv9sR2qg9chuZycnQvRi68vvrUDzLYBd+7GGJ5gV/5
	 2zY8Xd0oeNImhPh8lbwVcuZ10h+irgL+3wMZen68KW7yndvlXxXgSIyEW+bpNVxxtI4Mq
	 J6f/OZoghQ/oQJfn6r06XDQNChYQGRFT5on551s4ywwusVaZL7yFi6Y+djDlgIrOlwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108721;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=4L0w+DFxg/0odSH0y21BfLvOwBrjEBLFbY6kPt4vqpY=;
	b=oDgjnynyKjb4DP1+QDuqOroollxG6ODXxxb854w1+rzbbTVCKoCn/0M8oCxAmQhat0sX
	 CjfPSBCiXWTjl8xHtlt17zln7PEDEktsl4vdSH/qtqxTl6rxxAMhKG/WbocbaUe/tN8Vw
	 XuNeQl2v/HmajESa6ji5/vyQHGb4oIyBkxUoWZmfPwys6FqclqXeIbAHI6XvVPY8jGMw0
	 btYRjHXfdYdbKhp0f6KaUOlMhnAZIhEcDfrPy5Ta4EGDq7/xOABIZm2AK6fUQoAmj2NPX
	 qPumc5ZR3/6WFywOgsbdAJvYE1bzrgUsZEhLdfastXRQ99hGdLSl232k7B2lkBtAx5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hkq4EUV0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27434606A320;
	Thu, 19 Nov 2026 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hkq4EUV0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51FA1F000C5;
	Thu, 19 Nov 2026 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795108720;
	bh=4L0w+DFxg/0odSH0y21BfLvOwBrjEBLFbY6kPt4vqpY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Hkq4EUV05WUov7YKaYc0/J/ur8O24lq7e79/JUlnftw6ebY6emqsbYTqlU9NtvD+L
	 7ad3Tfs9O1YZv7zwz7T9Ad26OptCK7iiLRF0oM4NFwtkIf2ny+ymNvcPIcDzIpkw9q
	 ZHo8V5J4FsSpfmpY82ejFQ9jStTmfQsR+kppDfb4wylfIMjwCW4f+4lVzaQ1bXnTiS
	 7Or5HAd80uDEEey7GHie2yyosK4lpGLcRgtUwIqQveLI0SdgZd33mJQnleqaWlTy8f
	 x8l9AifeFzO9OLpUDLrfGziobyImTVlAxcY790teu3Qf16STCo4WRA6RlFxk27z/0W
	 2JJUqe9+ly0xA==
Message-ID: <41242382-1cfc-4dd1-8f8f-f9486f80b424@kernel.org>
Date: Thu, 19 Nov 2026 18:18:36 +0100
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
Subject: Re: [PATCH] mm/ksm: do not inherit ksm_zero_pages counter or PTE
 markers on fork
To: "Xu Xin (vivo)" <xu.xin@linux.dev>
Cc: akpm@linux-foundation.org, chengming.zhou@linux.dev,
 donettom@linux.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 stable@vger.kernel.org
References: <e971c3f2-e8cf-4eb0-ae25-e7e4d9ea02ee@kernel.org>
 <20261118031038.75525-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261118031038.75525-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>>
>> But ... they were placed by KSM?
>>
>> Just like any other KSM folios deduplicated before fork and then shared with the
>> child?
> 
> I see your point, but in practice, people evaluating use_zero_pages=1 often
> look at ksm_zero_pages to gauge how much memory KSM actually saved. Since
> forked pages already share the same physical frame via COW even without KSM,
> counting them across many forked children can give a somewhat misleading
> impression of KSM's actual savings.
> 
> Also, ksm_merging_pages right next to it is already reset to 0 on fork (even
> when regular KSM folios are shared with the child), so resetting ksm_zero_pages
> keeps the two counters consistent. 
> 
>>
>> So won't there be an inconsistency when MADV_UNMERGEABLE?
>>
> 
> As for MADV_UNMERGEABLE, leaving the child's mapping as a normal read-only shared
> zero page is safe and avoids extra allocations. Plus it naturally avoids the
> skipped-VMA (MADV_DONTFORK) accounting bug you spotted, and does so
> without extra per-PTE overhead.
> 
> What do you think?

We should then definitely document the behavioral change, and how ksm_zero_pages
interacts with fork.

For clearing the dirty bit we should have a dedicated helper, such the handling
is hidden like in is_ksm_zero_pte().


So clean up that code (reducing the code comment drastically) and properly
document all that for ksm_zero_pages.

-- 
Cheers,

David
