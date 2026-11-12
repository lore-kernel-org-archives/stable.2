Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502510;
	b=0FAECOuV24VG8t4JYcAiwavzNKC+ISyeEutnu0nyeiFNKRpc77DJj5iQhaMImgvYVp0G
	 ovjPVcQFa/CsUu3s/MrRNcZ/lM//nPiotioIe037LT1+Kj0rHbbFH/27BQEOJa+x59NTc
	 LrTndLgUzQmC8Mgg0hxHgOnwe0V2uvAzua4QqOopfXXwIUk7cl8jctv8lQHP7Cr1K58iO
	 UVv4ACH1Ctzt1lONljEpMgeUBKzufflOYhytGJqbW7ODkEIbpx3vsX9k1CzA3F5zSiagd
	 9BQvVU/hgdcO2L8e/Jx8XcAk8KqMcRv0EMhVuPTbKCioI6SPb86LAxLE+o3gFTLM6sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502510;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=h37avnMlwklZkt4BDaNjmX2gxVeL40jNvKjrx/JQRbI=;
	b=dzoIwAP6bR9zZSo+0gChL96EYF52Bsv2Yc04fI9zlupM0n7ZuSUhrIMVnZztAR93ymq6
	 3vxwJpCz/7TbNd7+GgOUtUcrYVDEGuAFzoZmxSRbJC71lvkfZGcja8bNRnawBxcbAAtYy
	 ppuKyfB8l/5vntKlHXWqHMganQa5Op8vXCXkC7FjUqgf4gXHJ803EdTedaAV/1D0EVVlo
	 bxWYf9RkXjmL25772MoPNRW+PFnvJV9g1BRNDb1ja8wrbQqtL7h7F4jcTRFwBfnjNe3ta
	 SJ78vgiUfuPHviJSEBtR0BdPjzJ2CotsQSwnstsXprcid3Zgn4RG1yXrcIXnZVzpTAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLLvPhbI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE3A606A321;
	Thu, 12 Nov 2026 16:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KLLvPhbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E4741F000C4;
	Thu, 12 Nov 2026 16:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502509;
	bh=h37avnMlwklZkt4BDaNjmX2gxVeL40jNvKjrx/JQRbI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=KLLvPhbIPcuUzR/wg99twy7RPxnMrqjfDHsyCZ7L+UiOjMmyziglZx7GsCF+8Xp8z
	 CUl2zpxFciPXbozifCZ4zFdrYgEzENJx+7Z73+E502cB/A+2vOBv+N+EYAGlA1GYzt
	 kbwu4XivrddUer5Ca4e0wLYYtsiXbuOWzLOt+iMfm9hGICFt9ThFbEIEnDAltmuUZI
	 fvK9nL1vGQBviLCrMj1rLGWlvUlxGHZlt5x0LUZuZ7nl/x80BQhxyOtL/kSVKxhnMR
	 tl6dLG1+1UHiAWeSVl3gKfePi4p6FRWaQPUspAV+7NSdhRmcKGwyEl8/VgYr1r98TA
	 TOUSNTtgnGEcQ==
Date: Thu, 12 Nov 2026 08:55:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev-bot+sinfo@kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>, netdev@vger.kernel.org,
 jiawenwu@trustnetic.com, duanqiangwen@net-swift.com,
 linglingzhang@net-swift.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, hramamurthy@google.com,
 jacob.e.keller@intel.com, przemyslaw.kitszel@intel.com,
 stable@vger.kernel.org
Subject: Re: [PATCH net v8] net: libwx: fix VF PM suspend/resume flow
Message-ID: <20261112085508.58f6514b@kernel.org>
In-Reply-To: <179421969986.488859.13582406441576044740@kernel.org>
References: <20261109101442.84605-1-mengyuanlou@net-swift.com>
	<179421969986.488859.13582406441576044740@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 09 Nov 2026 10:21:39 +0000 netdev-bot+sinfo@kernel.org wrote:
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
> 
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
> 
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.

v8 and you still can't include the answers to this questions in the
commit msg? SMH
