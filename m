Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795030239;
	b=LeXJkkMaEkx/aDFDbgKQzF67xDdKsWa1F0ev4x1X/aVQjIDrbK/dj386QauoZbO1YF5W
	 6rZJ0Mtz/cwhUJ/mJRKW2BozrIEh7zfy10D+TCBrXFqEH66zGaDtszZ+WQ2be/xGyC7cx
	 0s0Ax2kmPLJFaj/IO2974hfpOn+6PXbvf0dnjOYZFgc5hhgvp1sJoFiG0WMcwEn5zvXEY
	 mrfqkVnEn6VSWjOVatAn8pzGs+2ATgSxAYk5OveRWYcRX7827ebKQeqAmX80L9OIE4wP6
	 ty2d105fAOCvdeJ5UgNJJn++9V7TVROnunjRIojUdvj+PUvlBIo1t47i8Z8Q9TSSI6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795030239;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=uCIJQ2+ZuweUCQ7Z+ro6l7SCMuE3DcN2BblJLgjbiP8=;
	b=EH/uS2pYLx8uUaHo/pT1cysbSErFdYnogf7JXuxRVdgDdyKXXTLQzzQ/sQaZf9UKE6Me
	 w6gMUnWrcDL3fzJ/kj1SvMMnpDpqCjh/C+3gvRuK2qxEsKkQ2Ly3u5gPRHA4dIvhO2OCy
	 fvz2eS/BXM6lVmftiNwXdbX+tQGFd37OVTNZGsmMmqVF4I7hrzxRSHDb6JbH8QkKu8gM6
	 sQlmhWsIkJanqN9XZDrJqJ9oYkRqJi5JiXbtfGGIbhNaNyHsFdQf440A0nnr0CJoRE/Nw
	 W9A1b3Y44D7a6jCOunAMwUhXua7lEzqQpo/nnW12pnfCAfsw3MIgDn7cdds3dfWdzWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5Vx+xOJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5AC606F60F;
	Wed, 18 Nov 2026 19:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z5Vx+xOJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895641F000C7;
	Wed, 18 Nov 2026 19:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795030238;
	bh=uCIJQ2+ZuweUCQ7Z+ro6l7SCMuE3DcN2BblJLgjbiP8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z5Vx+xOJ8C59D+/+AoajSybSdJGt5bgTzIMhnKmUl+MHulKgpwPUT1HLGNwHbwD0r
	 9kkcrrN8XC8GP5EEKeh7m3fq5Biqu4WHFNlfqwMuCFFiqMLN/laMzHLBa8rOysyK+F
	 jfa/cj/ehUf6egAm4aneC2nTj0YlAOf6eMWc9xSRJejrt9J/2e8ZXcMsIaeWCOTf/W
	 oPj2VKs+c8iKfAZ+yaL364PQumCIVhxjs2AGHxVzZ74+hdXQs7jBJ17ZmbJl6br4Uh
	 Ga5qU+Qo2CE0o0TfxIO4xtGDzvsmDdXm6eURr/Bwarm6mKYiwOEbJBgHhDetR4s7fy
	 PxCTjQeCu86lQ==
Message-ID: <b6b123a8-d465-4269-8670-02cdb03f97a7@kernel.org>
Date: Wed, 18 Nov 2026 11:30:36 -0800
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
Subject: Re: [PATCH 2/2] zonefs: ignore RLIMIT_FSIZE above LLONG_MAX in
 zonefs_write_check_limits()
To: Ding Feng <dingf3ng@gmail.com>, viro@zeniv.linux.org.uk,
 brauner@kernel.org
Cc: jack@suse.cz, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, naohiro.aota@wdc.com, jth@kernel.org,
 stable@vger.kernel.org
References: <20261117173129.61028-1-dingf3ng@gmail.com>
 <20261117173129.61028-3-dingf3ng@gmail.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261117173129.61028-3-dingf3ng@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/17/26 09:31, Ding Feng wrote:
> zonefs_write_check_limits() follows generic_write_check_limits() and
> has the same problem: it stores rlimit(RLIMIT_FSIZE), an unsigned long,
> in a loff_t, so a soft limit between 2^63 and RLIM_INFINITY is negative
> and every write fails with -EFBIG and raises SIGXFSZ.
> 
> Keep the limit unsigned and apply it only when it is at most LLONG_MAX,
> as the generic helper now does.
> 
> Fixes: ebfd68cd0c1e ("zonefs: Fix O_APPEND async write handling")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5 Frama-C
> Signed-off-by: Ding Feng <dingf3ng@gmail.com>

Applied to zonefs for-7.4-fixes. Thanks!

-- 
Damien Le Moal
Western Digital Research
