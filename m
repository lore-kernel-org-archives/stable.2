Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537230;
	b=2F20m2Id0okHL3Ze/iSUFZZRAtv0+Rr/oECFTC6ciYhhwNGUJDMP4vIcyfEvFMTLdOy4
	 iu6GtyNoaz0bQyc+wHizSzbZ7ti0AnAJxenqZtR02aMdZgjkJeyt4Qwx3Li3hofhk2wor
	 rH1bpDEJzIpb8rCC1DWtJVHRNNQP+syji/4Yl+voAWGq2Vu26RLxDg44RfHGjBmMT5nmT
	 VWz0CKr4klDmjOKyGz1r8erpLiwLoPDeG7iaPB3LKziedcqt8DDgYzZ30zA7Pg+8PmPfN
	 ViZZZg6lWrSpzIxNPUaCHC2MsTOhH9FGQJG8RLp1BsGS+oUL8UXCBNDc5/zfyQYU3FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vo3EuFGzZ8sMiniz968ZKrMVFQcbEM5I9uSXgOOhJ8w=;
	b=OpRb6SUJSlSvjbCELrtU4sgWOtW4Xo87rfmNRz1/LxwCgU8LkOtUqHC9HLfUMKBbvdaC
	 1KgVrrVyq/5vL5jDvnPqE4YZDrY5mWO+OxMUoLz8P6iKorjN/sbqbdXQdEkMO+IMGYuUW
	 aMC9kh93DUewYcbBluxqHmZya1DdpMdf77kI5SywUrbLqfQWkfwaROi1CUCUDOTcVrvC2
	 aBj6+fo/BKO0RJRZQQ6EtNSwFRs2tyNA9u3t6RJi4AaX5Dk1vsv+mGcl/me7fFJ49+Ykx
	 bdDS4e7b1EHPu01xAAjoCktSkhFNiXsslUY122RvkP1Xi8O3Kramx8vpqgZcZZmNJKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R2O5BE9R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9EF606A335
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R2O5BE9R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68ECF1F000C4;
	Fri, 13 Nov 2026 02:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537230;
	bh=vo3EuFGzZ8sMiniz968ZKrMVFQcbEM5I9uSXgOOhJ8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R2O5BE9RfQz3R4GwH6pbaOg77FwMYCfskeCy28RtNXXRKID45E5znoskpMUyVkN1r
	 IOVkVJ2Bw0NqyvNixVYmsqRUNDOZLRjH/7i6c+Oj4JoXO3kFXX2uFeadT3lgojfsBc
	 0dngUo6lzDCUjknWmHmkeVzAquODA2lz9/z9AhUCwcmAm8J1e7QhR4XEnoVagxxRFD
	 3sdHOUb3CUiXreG+qY5h0jE5I9WNYCUlfMK3DBDNkvy4wcKXooraF8L5AmEOqvkS1f
	 3HuYQhJymnw9o9k+1dtZVYfxrxfu7qnhQOlvtOjIdBWgyTttu3SKHBRJlAg/NCQiSQ
	 8/ZrS6jvxNTtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	dipietro.salvatore@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-mm@kvack.org,
	Salvatore Dipietro <dipiets@amazon.it>
Subject: Re: [STABLE 7.3.y] 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations")
Date: Thu, 12 Nov 2026 21:33:29 -0500
Message-ID: <daily-reply-2026-11-12-1484516151@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112094205.994560-1-dipiets@amazon.it>
References: <20261112094205.994560-1-dipiets@amazon.it>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2026-11-12, Salvatore Dipietro wrote:
> [STABLE 7.3.y] 0e05a469c294 ("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations")
> Hi,
> Please apply to 7.3.y:
>   0e05a469c294 ("mm/page_alloc: avoid direct reclaim and compaction for costly __GFP_NORETRY allocations")

Queued for 7.3, thanks.


-- 
Thanks,
Sasha
