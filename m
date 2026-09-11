Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2442E3D667F
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 17:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149298; cv=none; b=srw7ZC4f2vWwBr+wdowhLwvG5i2KrZJtZwld4NTSHhl3TKwxcrvqbnd/RPDc0yypHCJoE+VGaDp6OdHTxFZu2WLPJXmoz5PMeshubXkjv+DM0H3+2Uy805NlPIdwkSlcGAc0GVXlCAyyDhrU+SKd3Q5TsFek2D0pZcjMPdgG7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149298; c=relaxed/simple;
	bh=qdg7tdO8nxKyBKo3v6D8xa0WORkKygaX4JxI2N9lrLE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SIeuNq/irYvL1lwXiNMuRBy9PGPnoiDZ0UsTIpLQ9QebIXlL7HY3qFcja1h5q2edScRyZxbPIUWXX5w7z8wt52SKVyOliBSgxCstCp2fLDSAQMeSG7fGR65wTXKfnSzqanXdNWqcU0Rgb7ZM88I6wLZ/iyDyCk8P/C+3JuHYNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k+yDUymr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k+yDUymr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7D841F000FF;
	Fri, 11 Sep 2026 17:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149297;
	bh=8cxjmKiY1sOm4ulmfevoosxn16poSMCFfGh2sHVKhUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k+yDUymr3tSJlZLIn9Z/GA2guz5UToealWDOSdnAPZ0OHg1NSZrtNcBS/kBhfBze1
	 peiftt8Ucv3tH03HkY2YeC4icyGtUaU1yJz68k0aMNcZeDybewkMw6tcbvOrAy3uAb
	 bm51ys9ncDWVy2jGE85HJ0m+v1B8hgaT/xDn31Ff4pTBe7BXK4TdEWfwBuQpSVf4Np
	 a0v9j7Lbr7cdPEUJefFUve/s+Jzo9cLCy54kMDk+edBm0LhmxAPQ8IBiChbUnsalLD
	 +2ryb/xnB5yt/ldWKAwqGVZ0ML1iB+NV/HjpgJsFhlqfM7kXifR4AiEEc7NVsLvzRX
	 t8zZWx4Rq8pcg==
Date: Fri, 11 Sep 2026 13:54:55 -0400
From: Sasha Levin <sashal@kernel.org>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: stable@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	linux-amlogic@lists.infradead.org
Subject: Re: [PATCH 6.12.y] clk: meson: align gxbb_32k_clk_sel number of
 parents with actual count
Message-ID: <aqRAbyxpEnKlOXOu@laps>
References: <20260910072139.313775-1-jbrunet@baylibre.com>
 <daily-reply-0030-re-clk-meson-gxbb-6-12@kernel.org>
 <1jik4c6imt.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1jik4c6imt.fsf@starbuckisacylon.baylibre.com>

On Fri, Sep 11, 2026 at 03:07:54PM +0200, Jerome Brunet wrote:
>On ven. 11 sept. 2026 at 07:20, Sasha Levin <sashal@kernel.org> wrote:
>
>>> The following out-of-bounds read has been observed by Christian on a
>>> GXBB WeTek Hub:
>>
>> Queued for 6.12, thanks.
>
>Hello Sasha,
>
>In those instance where exact same backport applies to multiple versions
>how do you prefer to handle things ?
>
>* Just replying 5 times as I did ?
>* Just reply once with a note explaining that it applies to other version ?

Hey!

Either works - so whatever is easier for you.

Something along the lines of "[PATCH 6.18-6.1]" is what most folks use.

-- 
Thanks,
Sasha
