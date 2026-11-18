Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022200;
	b=1EReR1UHMTyGj9eYQFNNpBQsL7iGr0vKnxgGiuvo4QQGfO6S+BcDJIRNBe0NfS6eWLnh
	 UBpY60FRMdTnahCLUyr/YGKbGZKnAesWdqUG5z+0wrHgp+fCTBzOOyR/ZtmpGEiRYu+pM
	 5ZH/DX1LH3sSNyVSg6goq94uh/Dd1HfTlxn0erJZmnVwa0Vd5CUPyQglnCSyo89yEkA8u
	 eqZz+mjHbP9jKaiT0+dgG/CMiYETZePSUFJExnj4q4w2HgmzT6rHO/dtbBfbuDTYs/4Dw
	 58Sb4XlX7GcL9kn7rpsDg/6cV7g8H3G5Bz0QA8esqimwkoBas5U6RUJX7fXf5AGO20g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022200;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=SAzJmY4FCeji/qIKXkz3wy9NVv0twgE5M8r/Ajd4Jqk=;
	b=vSokR6NYMvDo8LVDEJbgSWyVvBUDoVrcxwLxhhzyDtOD/YYwnU7ghRwRS1fQFIlXux0/
	 KPmYlMNzwDOIAUa3JzFYH1AKwrGeFR50/vSfDhqDlKo8M8afO5DWY8hhpWfmOMbGzIBSr
	 hii7RvgzsRYuFJjc+qY6JaOzUA7oxBWG9wkUkO9huV6vTIoQp6yB7GeExLqNGtnH7TD+h
	 /tuKnybRtS9rhYPkYbVSCiuuvDOI22G06s3SI91U4sI5eLmbJ3xuerVhXn9WUCjTpQXuK
	 D5xitLw0YdtEaCDLPwIpTVGApJ6OkA43/jQW65s3FBwB8ikiS398iH62E3elnhzvy0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSY98f4K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DD9606A325;
	Wed, 18 Nov 2026 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GSY98f4K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA67C1F000C9;
	Wed, 18 Nov 2026 17:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022200;
	bh=SAzJmY4FCeji/qIKXkz3wy9NVv0twgE5M8r/Ajd4Jqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GSY98f4Ki8nRSlVBffIV0exkJgfRM+bfH+yHeRlifszVzSumzm3erhIwdDMLB/7fj
	 WYuGsz1NZdAkTUpBQDVls9xrw/8a/b2zIh2E9iwDTSk/UdaOZ6G4RAu4okEn0/Iu3N
	 PJK36e3rQ6ZMubzstA7P42bQv4InxsVDiwfyLcrkXDLMTLJsa1f2OdGsiuFs/eK8cc
	 0xDRMW5MlS7weCJc+GkV9gA0+XTylYdYwIWF+9JpPxZ8uChYBQFDHWx430nhbIh/aM
	 nvv3ELf1bpOhmGuYgnz+6ZywpXW9x8G7RX8orGBpDFxfyco7VwG5X2VR5hlL8SaClI
	 VJ9UXFPiPAtFw==
Date: Wed, 18 Nov 2026 17:16:36 +0000
From: Lee Jones <lee@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Thierry Reding <thierry.reding@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sandipan Patra <spatra@nvidia.com>, linux-pwm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/8] pwm: tegra: Prevent 32-bit period truncation and
 division by zero
Message-ID: <20261118171636.GD98456@joneslee-macbookpro.roam.internal>
References: <20261105143847.2559586-1-lee@kernel.org>
 <20261105143847.2559586-2-lee@kernel.org>
 <auykeNit2S4e7axg@monoceros>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auykeNit2S4e7axg@monoceros>

On Thu, 05 Nov 2026, Uwe Kleine-König wrote:

> Hello Lee,
> 
> On Thu, Nov 05, 2026 at 02:38:03PM +0000, Lee Jones wrote:
> > tegra_pwm_apply() passes the 64-bit state->duty_cycle and state->period
> > values into tegra_pwm_config(), which accepts signed 32-bit int
> > parameters and performs DIV_ROUND_CLOSEST_ULL(c, period_ns) before
> > validating period_ns against pc->min_period_ns.  If a consumer requests
> > a period that is a non-zero multiple of 2^32 nanoseconds, period_ns
> > truncates to zero and triggers a divide-by-zero panic.
> > 
> > Widen duty_ns and period_ns to u64 and validate that period_ns lies
> > within [pc->min_period_ns, U32_MAX] prior to dividing by period_ns.
> > 
> > Fixes: 1d7796bdb63a ("pwm: tegra: Support dynamic clock frequency configuration")
> > Fixes: fd3ddd4355c0 ("pwm: tegra: Implement .apply() callback")
> > Closes: https://sashiko.dev/#/bug/linux-5c5b97d6-4da6-4d06-9dc7-957419dcd832
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Lee Jones <lee@kernel.org>
> 
> This is already addressed in
> 9ad5602d4943 ("pwm: tegra: Fix value discarding for duty and period")
> which is next-20261102 and later.

Would you like me to resubmit the set without this or can you omit it?

-- 
Lee Jones
