Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E640B0E2;
	Thu, 24 Sep 2026 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287674; cv=none; b=GFTCRL5lw5+b457dgPyUKoOQHpk1UG/B4pH2etzJglekkc3yU7FCtuvAgVj2FSk+GMhgtmYZw7o9PkH4DN+JXNDGhj188I3X6uG0SZPeH29Op4+J5Za/vQVShF+LEIkrJdJ59rHxAu/i3ao1sVXb0/K06gGV7X6Ns7/HwFBAUrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287674; c=relaxed/simple;
	bh=qiD2hUGpfqUuu9Cp/g24kjqyG+rTdlXeArfG7l6xECA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HivTMVpPv9I4LICSPYKYwEA7MbG3jwzf1LkOQJmfyEC+LyKPM2RJcW0Yb3ZxncGuQjrPW4insgQyKVXnJ/xsxmSZoF7n4fD+aIw8PndVBQ0jhc05N7/x3OlkKIYZLznqTK9Ym/5UL5Yh5w3xbpJuvc9SjfdnOSEmmePIlWCX8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOKfFYh2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOKfFYh2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7F31F000FF;
	Thu, 24 Sep 2026 22:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790287671;
	bh=WsKp+zJdWGrhfBDrkAc141AkuulupGxxYDeIqqqI7gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JOKfFYh2yC4DENg4E3ZXijA2t90eDK4mwc1tms8KyXWdrWQbV3XFuq+DrKnwwmWBP
	 0JcgJgQbzwBtJbmYoldP1SFtmdVO/QBNft0TrQCGrojzk30+E7OsmNAZwvKINBB9sQ
	 bKNtOUVS+nLn+Gow9HLS4ObcVKPQZDWUjOepoWgezU/ygKVT+6LANkjAbmIslp6eW2
	 O1sCHnmOWc5uaq0WfBN6KFR79BwGfEl1ulgt6XJzkDc9jSaU+eZVJVDht0PvMgHCqS
	 QWx9GOI1BHAm8GnDqgDu8biU2T7Li/CYVOxRd84652zAhIq1Yp8GqzNf9c8mUZEN4h
	 +5Z74VkuYSnIA==
Date: Fri, 25 Sep 2026 00:07:48 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Cc: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>, 
	Sagar Dharia <sdharia@codeaurora.org>, Karthikeyan Ramasubramanian <kramasub@codeaurora.org>, 
	Stephen Boyd <swboyd@chromium.org>, Wolfram Sang <wsa@kernel.org>, 
	Douglas Anderson <dianders@chromium.org>, Girish Mahadevan <girishm@codeaurora.org>, 
	linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH v2] i2c: qcom-geni: Fix hardcoded clock index in
 SE_GENI_CLK_SEL
Message-ID: <arWfAPy5zdG_swNo@zenone.zhora.eu>
References: <20260921-i2c-fix-se-clk-conf-v2-1-8b5537ceff2d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921-i2c-fix-se-clk-conf-v2-1-8b5537ceff2d@oss.qualcomm.com>

Hi Viken,

On Mon, Sep 21, 2026 at 05:17:01PM +0530, Viken Dadhaniya wrote:
> qcom_geni_i2c_conf() writes a hardcoded 0 to SE_GENI_CLK_SEL, which
> selects an index from the hardware clock performance table. This always
> picks the first table entry regardless of the actual source clock
> configuration. On platforms where the matching entry is not at index 0,
> the wrong source clock divider is active and the I2C bus runs at an
> incorrect frequency.
> 
> Use geni_se_clk_freq_match() in geni_i2c_clk_map_idx() to find the
> performance table index for the source clock (32 MHz or 19.2 MHz). Store
> the resolved index in a new clk_idx field in geni_i2c_dev and write it
> to SE_GENI_CLK_SEL instead of the hardcoded 0.
> 
> Fixes: 37692de5d523 ("i2c: i2c-qcom-geni: Add bus driver for the Qualcomm GENI I2C controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

pushed to i2c/i2c-fixes.

Thanks,
Andi
