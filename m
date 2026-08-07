Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73302D249B;
	Fri,  7 Aug 2026 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099689; cv=none; b=Ph2vyhYQkWr2Nhkityu6gwVpfIPefq+Ffkm6wPpsFvs6WJVD49AppfD/32qa9UUgL09UHKzgXemisNX3T4raaXa6IsUnHQuDwXWP5ddWur9Dw53b6aCv65v0q0YHkdOgSJLSIiSEglnQ3kmAkVIIXuGDCgjz50Lzz40zzXYbe3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099689; c=relaxed/simple;
	bh=vOiGYi6GzdftdnfesMoyL/X6PeInfEX5s1xNaSbVeCs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/TWblGlQ5fNr7OW+LHQoFncZRTIJBDTy7VtcGQuTy/8tn/vqnTVtVfeAJ2wT6CTUevsI8E318oeJeH3jqdJh6NUkfTarIkjJzDEmxRbumB+A/3SWIEsaY+CJxEngrQjh/LYeQJ2Gx1dFHDhx6y4wR92BKS0jyCqlI2RgvnUKNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTelDiwa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTelDiwa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041301F000E9;
	Fri,  7 Aug 2026 10:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786099688;
	bh=IuTOLPWRFxip1SuBm7XLyoi88bugKLsW4EamheL0MnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=YTelDiwaGoABahHhFRpg39hLFeVqNG0gRvpvMSOlFa6Ro+YTDPMUBL+PXbJnEs/fw
	 sm/xbq9pZtxtD7w083cNniZpsn9JoCG222q1Odw2l/cJYs6qDOZj2nxpArKHgtUv8S
	 oaT7yg8MYmwqxdWVW5x8p8MRCHbUJM9Rr/PGBjYNzF8lxDROQBwcO8pkpsOOXxYH6y
	 P1qS9Mu6pRFIFdf3ZwznEE/XkKesrW+NZo67bt3Mx5TGP4wVkHHDT2cxQK5NEiZk2r
	 s2VJu3lUAqtprH5jd1YvMYMB9txR3GomuvgVQDlpe+suH9Ko3R8tDIMyvjCiCa4SP8
	 QZTGcE0k56c0Q==
Message-ID: <682b2569-0a20-4595-b83b-8c833c387baf@kernel.org>
Date: Fri, 7 Aug 2026 12:47:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fork: reset pointer tag of vmapped thread stack before
 vfree
To: sparkhuang <huangshaobo3@xiaomi.com>
Cc: akpm@linux-foundation.org, bsegall@google.com, dietmar.eggemann@arm.com,
 juri.lelli@redhat.com, kees@kernel.org, kprateek.nayak@amd.com,
 liam@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 ljs@kernel.org, mgorman@suse.de, mhocko@suse.com, mingo@redhat.com,
 peterz@infradead.org, rostedt@goodmis.org, rppt@kernel.org,
 ryabinin.a.a@gmail.com, stable@vger.kernel.org, surenb@google.com,
 vbabka@kernel.org, vincent.guittot@linaro.org, vschneid@redhat.com
References: <f5af86ba-e724-4b9f-acdb-2445e2ec4b1e@kernel.org>
 <20260807104153.94261-1-huangshaobo3@xiaomi.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260807104153.94261-1-huangshaobo3@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/7/26 12:41, sparkhuang wrote:
> On 2026-08-07  9:27 UTC, David wrote:
>> Were you able to reproduce this more than once?
> 
> Still trying to reproduce it. So far it has only occurred this once.
> 
>> Does this relate to CONFIG_KASAN_STACK?
> 
> I'm not entirely sure if it's related.
> The configs relevant to this path are:
> 	CONFIG_KASAN_SHADOW_OFFSET=0xefffffc000000000
> 	CONFIG_HAVE_ARCH_KASAN=y
> 	CONFIG_HAVE_ARCH_KASAN_SW_TAGS=y
> 	CONFIG_HAVE_ARCH_KASAN_HW_TAGS=y
> 	CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> 	CONFIG_CC_HAS_KASAN_GENERIC=y
> 	CONFIG_CC_HAS_KASAN_SW_TAGS=y
> 	CONFIG_KASAN=y
> 	CONFIG_CC_HAS_KASAN_MEMINTRINSIC_PREFIX=y
> 	# CONFIG_KASAN_GENERIC is not set
> 	CONFIG_KASAN_SW_TAGS=y
> 	# CONFIG_KASAN_HW_TAGS is not set
> 	CONFIG_KASAN_OUTLINE=y
> 	# CONFIG_KASAN_INLINE is not set
> 	CONFIG_KASAN_STACK=y

The KASAN_STACK might be the relevant bit. We will get the stack retagged, so
when we free the memory, the stored tag and the memory tag will differ.

At least that's my understanding from a quick peek :)

-- 
Cheers,

David
